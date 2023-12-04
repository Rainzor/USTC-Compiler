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
    Type *Int32Type = module->get_int32_type();

    auto mainFun = Function::create(FunctionType::get(Int32Type, {}), "main", module);
    auto bb = BasicBlock::create(module, "entry", mainFun);
    builder->set_insert_point(bb);

    auto retAlloca = builder->create_alloca(Int32Type);
    builder->create_store(CONST_INT(0),retAlloca);

    //declear a[10]
    auto *arrayType = ArrayType::get(Int32Type, 10); 
    auto a = builder->create_alloca(arrayType);

    //a[0]=10
    auto a0Gep = builder->create_gep(a, {CONST_INT(0), CONST_INT(0)});
    builder->create_store(CONST_INT(10), a0Gep);
    //res = a[0]*2
    auto a0Load = builder->create_load(a0Gep);
    auto res = builder->create_imul(a0Load, CONST_INT(2));
    //a[1]=res
    auto a1Gep = builder->create_gep(a, {CONST_INT(0), CONST_INT(1)});
    builder->create_store(res, a1Gep);

    //return a[1]
    auto a1Load = builder->create_load(a1Gep);
    builder->create_ret(a1Load);

    std::cout << module->print();
    delete module;
    return 0;
}
