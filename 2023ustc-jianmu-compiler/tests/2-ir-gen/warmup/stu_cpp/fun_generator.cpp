#include "BasicBlock.hpp"
#include "Constant.hpp"
#include "Function.hpp"
#include "IRBuilder.hpp"
#include "Module.hpp"
#include "Type.hpp"

#include <iostream>
#include <memory>

// 得到常数值的表示,方便后面多次用到
#define CONST_INT(num)\
        ConstantInt::get(num, module)

#define CONST_FP(num)\ 
        ConstantFP::get(num, module) 
int main() {
    auto module = new Module();
    auto builder = new IRBuilder(nullptr, module);
    auto Int32Type = module->get_int32_type();

    //callee func
    std::vector<Type *> Ints(1,Int32Type);
    //arg type
    auto calleeFunTy = FunctionType::get(Int32Type, Ints);
    //define func
    auto calleeFun = Function::create(calleeFunTy, "callee", module);
    auto bb = BasicBlock::create(module, "entry", calleeFun);
    builder->set_insert_point(bb);

    auto retAlloca = builder->create_alloca(Int32Type);
    builder->create_store(CONST_INT(0), retAlloca);

    auto aAlloca = builder->create_alloca(Int32Type);
    std::vector<Value *> args;
    for (auto &arg: calleeFun->get_args()) {
        args.push_back(&arg);
    }
    builder->create_store(args[0], aAlloca);
    auto aLoad = builder->create_load(aAlloca);
    auto res = builder->create_imul(aLoad, CONST_INT(2));
    builder->create_ret(res);

    //define main funcs
    auto mainFun = Function::create(FunctionType::get(Int32Type, {}), "main", module);
    bb = BasicBlock::create(module, "entry", mainFun);
    builder->set_insert_point(bb);

    retAlloca = builder->create_alloca(Int32Type);
    builder->create_store(CONST_INT(0), retAlloca);

    auto call = builder->create_call(calleeFun,{CONST_INT(110)});
    builder->create_ret(call);

    std::cout<<module->print();
    delete module;
    return 0;
}
