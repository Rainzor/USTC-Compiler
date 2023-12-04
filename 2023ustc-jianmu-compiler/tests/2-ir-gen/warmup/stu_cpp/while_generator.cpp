#include "BasicBlock.hpp"
#include "Constant.hpp"
#include "Function.hpp"
#include "IRBuilder.hpp"
#include "Module.hpp"
#include "Type.hpp"

#include <iostream>
#include <memory>

#define CONST_INT(num)\
        ConstantInt::get(num, module)

#define CONST_FP(num)\ 
        ConstantFP::get(num, module) 
int main() {

    auto module = new Module();
    auto builder = new IRBuilder(nullptr, module);
    Type* Int32Type = module->get_int32_type();

    auto mainFun = Function::create(FunctionType::get(Int32Type, {}), "main", module);
    auto bb = BasicBlock::create(module, "entry", mainFun);
    builder->set_insert_point(bb);
    auto retAlloca = builder->create_alloca(Int32Type);
    builder->create_store(CONST_INT(0), retAlloca);

    auto a = builder->create_alloca(Int32Type);
    builder->create_store(CONST_INT(10), a);
    auto i = builder->create_alloca(Int32Type);
    builder->create_store(CONST_INT(0), i);

    auto while_begin = BasicBlock::create(module, "while_begin", mainFun);
    auto while_body = BasicBlock::create(module, "while_body", mainFun);
    auto while_end = BasicBlock::create(module, "while_end", mainFun);

    // while_begin
    builder->create_br(while_begin);
    builder->set_insert_point(while_begin);
    auto it = builder->create_load(i);
    auto icmp = builder->create_icmp_lt(it, CONST_INT(10));
    builder->create_cond_br(icmp, while_body, while_end);

    // while_body
    builder->set_insert_point(while_body);
    auto iLoad = builder->create_load(i);
    auto iAdd = builder->create_iadd(iLoad, CONST_INT(1));
    builder->create_store(iAdd, i);
    auto aLoad = builder->create_load(a);
    auto aAdd = builder->create_iadd(aLoad, iAdd);
    builder->create_store(aAdd, a);
    builder->create_br(while_begin);

    // while_end
    builder->set_insert_point(while_end);
    aLoad = builder->create_load(a);
    builder->create_store(aLoad, retAlloca);
    builder->create_ret(builder->create_load(retAlloca));

    std::cout << module->print();
    delete module;
    return 0;

}
