#include "Dominators.hpp"

void Dominators::run() {
    m_->set_print_name();
    for (auto &f1 : m_->get_functions()) {
        auto f = &f1;

        if (f->get_basic_blocks().size() == 0)
            continue;
        // std::cout << "Function: " << f->get_name() << std::endl;
        // std::cout << "Blocks: ";

        for (auto &bb1 : f->get_basic_blocks()) {
            auto bb = &bb1;
            // std::cout<<bb->get_name()<<" ";
            idom_.insert({bb, nullptr});
            dom_frontier_.insert({bb, {}});
            dom_tree_succ_blocks_.insert({bb, {}});
        }
        // std::cout<<std::endl;

        // Immediate Domiance
        create_idom(f);
        // std::cout<<"IDOM:\n";
        // for(auto&p:idom_){
        //   std::cout << p.second->get_name() << "->" << p.first->get_name() << std::endl;
        // }

        // Dominance Frontier
        create_dominance_frontier(f);
        // std::cout<<"Frontier:\n";
        // for(auto&p:dom_frontier_){
        //     std::cout<<p.first->get_name()<<"'s frontiers: ";
        //     for(auto&f:p.second){
        //         std::cout<<f->get_name()<<" ";
        //     }
        //     std::cout<<std::endl;
        // }
        create_dom_tree_succ(f);
    }
}

void Dominators::dfs(std::vector<BasicBlock *> &dfn,
                     std::unordered_map<BasicBlock *, bool> &visited,
                     BasicBlock *bb) {
  visited[bb] = true;
  for (auto &succ : bb->get_succ_basic_blocks()) {
    if (!visited[succ]) {
      dfs(dfn, visited, succ);
    }
  }
  dfn.push_back(bb);
}

int Dominators::intersect(int b1, int b2,const std::vector<int> &doms){
    while(b1!=b2){
        while(b1<b2){
            b1=doms[b1];
        }
        while(b2<b1){
            b2=doms[b2];
        }
    }
    return b1;
}

void Dominators::create_idom(Function *f) {
    // TODO 分析得到 f 中各个基本块的 idom
    auto bb_entry = f->get_entry_block();
    std::unordered_map<BasicBlock *, bool> visited{};
    for(auto&bb1: f->get_basic_blocks()){
        auto bb=&bb1;
        visited.insert({bb,false});
    }
    std::vector<BasicBlock*> dfn;
    dfs(dfn,visited,bb_entry);
    int bb_num = dfn.size();
    std::unordered_map<BasicBlock *, int> postorder{};
    for(int i=0;i<bb_num;i++){
        postorder.insert({dfn[i],i});
    }


    std::vector<int> doms(bb_num,-1);
    doms[bb_num-1]=bb_num-1;
    bool changed;
    do{
        changed = false;
        for (int i = bb_num - 2; i >= 0; i--){// in reverse postorder
            auto bb=dfn[i];
            int new_idom=-1;
            for(auto& pred:bb->get_pre_basic_blocks()){
                int pred_num=postorder[pred];
                if(new_idom==-1){
                    new_idom=pred_num;
                }
                else if(doms[pred_num]!=-1){// if doms[pred_num] is not undefined
                    new_idom=intersect(pred_num,new_idom,doms);
                }
            }
            if(doms[i]!=new_idom){
                doms[i]=new_idom;
                changed=true;
            }            
        }
    } while (changed);
    for(int i=0;i<bb_num;i++){
      idom_[dfn[i]]= dfn[doms[i]];
    }
}

void Dominators::create_dominance_frontier(Function *f) {
    // TODO 分析得到 f 中各个基本块的支配边界集合
    for(auto& bb1:f->get_basic_blocks()){
        auto bb=&bb1;
        if(bb->get_pre_basic_blocks().size()>=2){
            for(auto& pred:bb->get_pre_basic_blocks()){
                auto runner=pred;
                while(runner!=idom_[bb]){
                    dom_frontier_[runner].insert(bb);
                    runner=idom_[runner];
                }
            }
        }
    }
}

void Dominators::create_dom_tree_succ(Function *f) {
    // TODO 分析得到 f 中各个基本块的支配树后继
    for(auto& bb1:f->get_basic_blocks()){
        auto bb=&bb1;
        if(bb!=f->get_entry_block()&&idom_[bb]!=nullptr){
            dom_tree_succ_blocks_[idom_[bb]].insert(bb);
        }
    }

}
