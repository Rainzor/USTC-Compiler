#pragma once

#include "BasicBlock.hpp"
#include "PassManager.hpp"

#include <map>
#include <unordered_map>

#include <set>

class Dominators : public Pass {
  public:
    using BBSet = std::set<BasicBlock *>;

    explicit Dominators(Module *m) : Pass(m) {}
    ~Dominators() = default;
    void run() override;

    BasicBlock *get_idom(BasicBlock *bb) { return idom_.at(bb); }
    const BBSet &get_dominance_frontier(BasicBlock *bb) {
        return dom_frontier_.at(bb);
    }
    const BBSet &get_dom_tree_succ_blocks(BasicBlock *bb) {
        return dom_tree_succ_blocks_.at(bb);
    }

  private:
    // TODO
    void create_idom(Function *f);
    void create_dominance_frontier(Function *f);
    void create_dom_tree_succ(Function *f);

    // TODO 补充需要的函数

    // 获取支配树后序标记 postorder number
    void dfs(std::vector<BasicBlock *> &dfn,
             std::unordered_map<BasicBlock *, bool> &visited,
             BasicBlock *bb);
    // 获取两个支配树后序标记的最近公共祖先
    int intersect(int b1, int b2,const std::vector<int> &doms);
    std::map<BasicBlock *, BasicBlock *> idom_{};  // 直接支配
    std::map<BasicBlock *, BBSet> dom_frontier_{}; // 支配边界集合
    std::map<BasicBlock *, BBSet> dom_tree_succ_blocks_{}; // 支配树中的后继节点
};