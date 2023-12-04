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
    Type* Int32Type = module->get_int32_type();
    Type* FloatType = module->get_float_type();

    auto mainFun = Function::create(FunctionType::get(Int32Type, {}), "main", module);
    auto bb = BasicBlock::create(module, "entry", mainFun);
    builder->set_insert_point(bb);
    auto retAlloca = builder->create_alloca(Int32Type);
    builder->create_store(CONST_INT(0), retAlloca);

    auto a = builder->create_alloca(FloatType);
    builder->create_store(CONST_FP(5.555), a);
    auto aLoad = builder->create_load(a);

    auto cmp = builder->create_fcmp_lt(aLoad, CONST_FP(1));

    auto trueBB = BasicBlock::create(module, "trueBB", mainFun);
    auto falseBB = BasicBlock::create(module, "falseBB", mainFun);
    auto retBB = BasicBlock::create(module, "retBB", mainFun);
    builder->create_cond_br(cmp, trueBB, falseBB);

    // trueBB
    builder->set_insert_point(trueBB);
    builder->create_store(CONST_INT(0), retAlloca);
    builder->create_br(retBB);

    // falseBB
    builder->set_insert_point(falseBB);
    builder->create_store(CONST_INT(233), retAlloca);
    builder->create_br(retBB);

    // retBB
    builder->set_insert_point(retBB);
    auto retLoad = builder->create_load(retAlloca);
    builder->create_ret(retLoad);

    std::cout << module->print();
    delete module;
    return 0;
}
