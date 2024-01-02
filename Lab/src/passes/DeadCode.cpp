#include "DeadCode.hpp"
#include "logging.hpp"

// 处理流程：两趟处理，mark 标记有用变量，sweep 删除无用指令
void DeadCode::run() {
    bool changed{};
    func_info->run();
    do {
        changed = false;
        for (auto &F : m_->get_functions()) {
            auto func = &F;
            mark(func);
            changed |= sweep(func);
        }
    } while (changed);
    LOG_INFO << "dead code pass erased " << ins_count << " instructions";
}

void DeadCode::mark(Function *func) {
    work_list.clear();
    marked.clear();

    for (auto &bb : func->get_basic_blocks()) {
        for (auto &ins : bb.get_instructions()) {
            if (is_critical(&ins)) {
                marked[&ins] = true;
                work_list.push_back(&ins);
            }
        }
    }

    while (work_list.empty() == false) {
        //根据critial的指令，标记真正需要删除的指令
        auto now = work_list.front();
        work_list.pop_front();

        mark(now);
    }
}

void DeadCode::mark(Instruction *ins) {
    //保护store中value 和 目标地址的指令，包含那些数组指针的声明
    //递归的保护了ret 或 call时传入参数的涉及到的变量
    for (auto op : ins->get_operands()) {
        //操作数本身继承于value，等价于一条指令
        auto def = dynamic_cast<Instruction *>(op);
        if (def == nullptr)
            continue;
        if (marked[def])
            continue;
        if (def->get_function() != ins->get_function())
            continue;
        marked[def] = true;
        work_list.push_back(def);
    }
}

bool DeadCode::sweep(Function *func) {
    std::unordered_set<Instruction *> wait_del{};
    for (auto &bb : func->get_basic_blocks()) {
        for (auto it = bb.get_instructions().begin();
             it != bb.get_instructions().end();) {
            if (marked[&*it]) {
                ++it;
                continue;
            } else {
                auto tmp = &*it;
                wait_del.insert(tmp);
                it++;
            }
        }
    }
    for (auto inst : wait_del)
        inst->remove_all_operands();
    for (auto inst : wait_del)
        inst->get_parent()->get_instructions().erase(inst);
    ins_count += wait_del.size();
    return not wait_del.empty(); // changed
}

bool DeadCode::is_critical(Instruction *ins) {
    // critical 包含了call,br,ret,store指令
    // 这些指令将被保护，其余的会被删除
    if (ins->is_call()) {
        auto call_inst = dynamic_cast<CallInst *>(ins);
        auto callee = dynamic_cast<Function *>(call_inst->get_operand(0));
        if (func_info->is_pure_function(callee))
            return false;
        return true;
    }
    if (ins->is_br() || ins->is_ret())
        return true;
    if (ins->is_store())
        return true;
    return false;
}
