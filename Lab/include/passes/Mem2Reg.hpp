#pragma once

#include "Dominators.hpp"
#include "Instruction.hpp"
#include "Value.hpp"

#include <memory>
#include <stack>
#include <set>
#include <queue>
#include <unordered_map>
#include <unordered_set>
#include <fstream>
class Mem2Reg : public Pass {
private:
  Function *func_;
  std::unique_ptr<Dominators> dominators_;
  // TODO 添加需要的变量
  std::unordered_set<Value *> global_active_val_set_{};
  std::unordered_map<Value *, std::set<BasicBlock *>> val_defset_map_{};
  std::unordered_map<Instruction *, Value *> phi_map_{};
  std::unordered_map<Value *, std::stack<Value *>> reg_stk_map_{};

public:
  Mem2Reg(Module *m) : Pass(m) {}
  ~Mem2Reg() = default;

  void run() override;

  void generate_phi();
  void rename(BasicBlock *bb);

  static inline bool is_global_variable(Value *l_val) {
    return dynamic_cast<GlobalVariable *>(l_val) != nullptr;
    }
    static inline bool is_gep_instr(Value *l_val) {
        return dynamic_cast<GetElementPtrInst *>(l_val) != nullptr;
    }

    static inline bool is_valid_ptr(Value *l_val) {
        return not is_global_variable(l_val) and not is_gep_instr(l_val);
    }
};
