#include "Mem2Reg.hpp"
#include "IRBuilder.hpp"
#include "Value.hpp"

#include <memory>

void Mem2Reg::run() {
    // 创建支配树分析 Pass 的实例
    dominators_ = std::make_unique<Dominators>(m_);
    // 建立支配树
    dominators_->run();
    // 以函数为单元遍历实现 Mem2Reg 算法
    for (auto &f : m_->get_functions()) {
        if (f.is_declaration())
            continue;
        func_ = &f;
        if (func_->get_basic_blocks().size() >= 1) {
            // 对应伪代码中 phi 指令插入的阶段
            generate_phi();
            // 对应伪代码中重命名阶段
            rename(func_->get_entry_block());
        }
        // 后续 DeadCode 将移除冗余的局部变量的分配空间
    }
}

void Mem2Reg::generate_phi() {
    // 步骤一：找到活跃在多个 block 的全局名字集合，以及它们所属的 bb 块
    val_defset_map_.clear();
    global_active_val_set_.clear();
    phi_map_.clear();
    reg_stk_map_.clear();

    for(auto& bb:func_->get_basic_blocks()){
        for(auto& ins:bb.get_instructions()){
            if(ins.is_store()){
                auto l_val = ins.get_operand(1);//获取的是一个指针，指向alloca的位置
                //排除全局变量和gep指令(数组或者指针的偏移量)
                if(is_valid_ptr(l_val)){
                    if(global_active_val_set_.find(l_val)==global_active_val_set_.end()){
                        global_active_val_set_.insert(l_val);
                        val_defset_map_.insert({l_val,{}});
                        reg_stk_map_.insert({l_val,std::stack<Value*>{}});
                    }
                    val_defset_map_[l_val].insert(&bb);
                }
            }
        }
    }
    // 步骤二：从支配树获取支配边界信息，并在对应位置插入 phi 指令
    std::queue<BasicBlock*> Defs;
    std::set<BasicBlock *> Frontiers;
    for(auto&active_val:global_active_val_set_){
        if(val_defset_map_[active_val].size()==1)//只有一个定义块，不需要插入phi指令，进行剪枝
            continue;
        for(auto&bb:val_defset_map_[active_val]){
            Defs.push(bb);
        }
        while(!Defs.empty()){
            auto bb = Defs.front();
            Defs.pop();
            for(auto& frontier:dominators_->get_dominance_frontier(bb)){
                if(Frontiers.find(frontier)==Frontiers.end()){// 该边界点还未插入phi指令
                    // 插入边界点
                    Frontiers.insert(frontier);
                    // 插入phi指令
                    auto alloca_inst = dynamic_cast<AllocaInst*> (active_val);
                    auto phi_inst = PhiInst::create_phi(alloca_inst->get_alloca_type(),frontier);
                    frontier->add_instr_begin(phi_inst);
                    // std::cout<<active_val->get_name()<<"'s Phi in Block "<<frontier->get_name()<<std::endl;
                    phi_map_.insert({phi_inst,active_val});                    
                    if(val_defset_map_[active_val].find(frontier)==val_defset_map_[active_val].end()){
                        val_defset_map_[active_val].insert(frontier);
                        Defs.push(frontier);
                    }
                }
            }
        }
        Frontiers.clear();
    }
}

void Mem2Reg::rename(BasicBlock *bb) {
    // TODO
    // 步骤三：将 phi 指令作为 lval 的最新定值，lval 即是为局部变量 alloca 出的地址空间
    // 步骤四：用 lval 最新的定值替代对应的load指令
    // 步骤五：将 store 指令的 rval，也即被存入内存的值，作为 lval 的最新定值    

    Value* lval;
    Value* val;
    for(auto& ins:bb->get_instructions()){

        if(ins.is_phi()){
            lval = phi_map_[&ins];
            val = dynamic_cast<Value* > (&ins);
            reg_stk_map_[lval].push(val);
            
        }else if(ins.is_store()){
            lval = ins.get_operand(1);
            if(is_valid_ptr(lval)){
                val = ins.get_operand(0);
                reg_stk_map_[lval].push(val);
            }
        }else if(ins.is_load()){
            lval = ins.get_operand(0);
            if(is_valid_ptr(lval)){
                val = reg_stk_map_[lval].top();
                ins.replace_all_use_with(val);
            }
        }

    }
    // 步骤六：为bb后继基本块中 lval 对应的 phi 指令参数补充完整
    for(auto& succ_bb:bb->get_succ_basic_blocks()){
        for(auto& ins:succ_bb->get_instructions()){
            if(ins.is_phi()){
                auto phi_inst = dynamic_cast<PhiInst*>(&ins);
                lval = phi_map_[phi_inst];
                if(!reg_stk_map_[lval].empty()){
                    val = reg_stk_map_[lval].top();
                    phi_inst->add_phi_pair_operand(val, bb);
                }
            }
        }
    }



    // 步骤七：对 bb 在支配树上的所有后继节点，递归执行 re_name 操作
    for(auto& succ_bb:dominators_->get_dom_tree_succ_blocks(bb)){
        rename(succ_bb);
    }
    
    // 步骤八：pop出 lval 的最新定值
    for(auto& ins:bb->get_instructions()){
        if(ins.is_phi()){
            lval = phi_map_[&ins];
            reg_stk_map_[lval].pop();
        }else if(ins.is_store()){
            lval = ins.get_operand(1);
            if(is_valid_ptr(lval)){
                reg_stk_map_[lval].pop();
            }
        }
    }

    // 步骤九：清除冗余的指令:涉及内存变量的所有store指令
    // 不包含全局变量，指针，数组
    // alloca/load指令
    std::unordered_set<Instruction *> wait_del{};
    for (auto it = bb->get_instructions().begin();
         it != bb->get_instructions().end(); it++) {
        auto inst = &*it;
        if (inst->is_store() && is_valid_ptr(inst->get_operand(1))) {
            wait_del.insert(inst);
        }
    }

    for (auto inst : wait_del)
      inst->remove_all_operands();
    for (auto inst : wait_del)
      inst->get_parent()->get_instructions().erase(inst);
}
