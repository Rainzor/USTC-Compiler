# Note for Compiler

## Cminusf 语法

1. program→declaration-list
2. declaration-list→declaration-list declaration ∣ declaration
3. declaration→var-declaration ∣ fun-declaration
4. var-declaration →type-specifier **ID** **;** ∣ type-specifier **ID** **[** **INTEGER** **]** **;**
5. type-specifier→**int** ∣ **float** ∣ **void**
6. fun-declaration→type-specifier **ID** **(** params **)** compound-stmt
7. params→param-list ∣ **void**
8. param-list→param-list **,** param ∣ param
9. param→type-specifier **ID** ∣ type-specifier **ID** **[** **]**
10. compound-stmt→**{** local-declarations statement-list **}**
11. local-declarations→local-declarations var-declaration ∣ empty
12. statement-list→statement-list statement ∣ empty
13. statement→ expression-stmt∣ compound-stmt∣ selection-stmt∣ iteration-stmt∣ return-stmt
14. expression-stmt→expression **;** ∣ **;**
15. selection-stmt→ **if** **(** expression **)** statement∣ **if** **(** expression **)** statement **else** statement
16. iteration-stmt→**while** **(** expression **)** statement
17. return-stmt→**return** **;** ∣ **return** expression **;**
18. expression→var **=** expression ∣ simple-expression
19. var→**ID** ∣ **ID** **[** expression**]**
20. simple-expression→additive-expression relop additive-expression ∣ additive-expression
21. relop →**<=** ∣ **<** ∣ **>** ∣ **>=** ∣ **==** ∣ **!=**
22. additive-expression→additive-expression addop term ∣ term
23. addop→**+** ∣ **-**
24. term→term mulop factor ∣ factor
25. mulop→***** ∣ **/**
26. factor→**(** expression **)** ∣ var ∣ call ∣ integer ∣ float
27. integer→**INTEGER**
28. float→**FLOATPOINT**
29. call→**ID** **(** args**)**
30. args→arg-list ∣ empty
31. arg-list→arg-list **,** expression ∣ expression

## Regular Expression

| 符号    | 含义                                     |
| ------- | ---------------------------------------- |
| `.`     | 匹配除换行符以外的任何字符               |
| `*`     | 匹配前一个字符的零次或多次出现           |
| `+`     | 匹配前一个字符的一次或多次出现           |
| `?`     | 匹配前一个字符的零次或一次出现           |
| `[]`    | 定义一个字符类，匹配括号内的任何一个字符 |
| `[^]`   | 否定字符类，匹配不在括号内的任何一个字符 |
| `()`    | 创建一个子表达式，并捕获匹配的部分       |
| `|`     | 或操作，匹配两边任一表达式               |
| `{n}`   | 匹配前一个字符恰好 n 次                  |
| `{n,}`  | 匹配前一个字符至少 n 次                  |
| `{n,m}` | 匹配前一个字符至少 n 次，但不超过 m 次   |
| `\`     | 转义字符，用于匹配特殊字符               |
| `^`     | 锚点，匹配字符串的开头                   |
| `$`     | 锚点，匹配字符串的结尾                   |
| `\d`    | 匹配任何数字字符                         |
| `\D`    | 匹配任何非数字字符                       |
| `\w`    | 匹配任何字母、数字或下划线字符           |
| `\W`    | 匹配任何非字母、非数字、非下划线字符     |
| `\s`    | 匹配任何空白字符（空格、制表符、换行等） |
| `\S`    | 匹配任何非空白字符                       |



##### expression

```cpp
void CalcBuilder::visit(CalcASTInput &node) { node.expression->accept(*this); }
void CalcBuilder::visit(CalcASTExpression &node) {
    if (node.expression == nullptr) {
        node.term->accept(*this);
    } else {
        node.expression->accept(*this);
        auto l_val = val;
        node.term->accept(*this);
        auto r_val = val;
        switch (node.op) {
        case OP_PLUS:
            val = builder->create_iadd(l_val, r_val);
            break;
        case OP_MINUS:
            val = builder->create_isub(l_val, r_val);
            break;
        }
    }
}

void CalcBuilder::visit(CalcASTTerm &node) {
    if (node.term == nullptr) {
        node.factor->accept(*this);
    } else {
        
        node.term->accept(*this);
        auto l_val = val;
        node.factor->accept(*this);
        auto r_val = val;
        switch (node.op) {
        case OP_MUL:
            val = builder->create_imul(l_val, r_val);
            break;
        case OP_DIV:
            val = builder->create_isdiv(l_val, r_val);
            break;
        }
    }
}
void CalcBuilder::visit(CalcASTNum &node) {
    val = ConstantInt::get(node.val, module.get());
}
```

##### if

```cpp
/if else
Value* CminusfBuilder::visit(ASTSelectionStmt &node) {
    // TODO: if statement else statement

    node.expression->accept(*this);
    auto cur_val = context.val;
    auto trueBB=BasicBlock::create(module.get(),"",context.func);
    auto falseBB=BasicBlock::create(module.get(),"",context.func);
    auto endBB=BasicBlock::create(module.get(),"",context.func);

    Value * cond_val;
    if(is_FLOAT(cur_val))
        cond_val = builder->create_fcmp_ne(cur_val,CONST_FP(0.));
    else
        cond_val=builder->create_icmp_ne(cur_val,CONST_INT(0));
    
    if (node.else_statement!=nullptr)//has else block
        builder->create_cond_br(cond_val,trueBB,falseBB);
    else 
        builder->create_cond_br(cond_val,trueBB,endBB);

    //if expression
    builder->set_insert_point(trueBB);
    node.if_statement->accept(*this);
    if (!builder->get_insert_block()->is_terminated()) 
        builder->create_br(endBB);

    //else expression
    if (node.else_statement!=nullptr){
        builder->set_insert_point(falseBB);
        node.else_statement->accept(*this);
        if (!builder->get_insert_block()->is_terminated())
            builder->create_br(endBB);
    }else
        falseBB->erase_from_parent();

    builder->set_insert_point(endBB);
    return nullptr;
}
```

##### while

```cpp
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
```



```cpp
// while
Value* CminusfBuilder::visit(ASTIterationStmt &node) {
    // TODO: while statement
    auto cur_fun = context.func;
    auto judgeBB=BasicBlock::create(module.get(),"",cur_fun);
    auto stmtBB=BasicBlock::create(module.get(),"",cur_fun);
    auto endBB=BasicBlock::create(module.get(),"",cur_fun);
    if (!builder->get_insert_block()->is_terminated()) 
        builder->create_br(judgeBB);//goto judge while condition
    
    builder->set_insert_point(judgeBB);
    node.expression->accept(*this);
    
    auto cur_val=context.val;
    Value* cond_val;
    if (cur_val->get_type()->is_float_type()) 
        cond_val=builder->create_fcmp_ne(cur_val,CONST_FP(0.));
    else 
        cond_val=builder->create_icmp_ne(cur_val,CONST_INT(0));

    builder->create_cond_br(cond_val,stmtBB,endBB);//go to statement or end the while loop
    builder->set_insert_point(stmtBB);
    node.statement->accept(*this);
    if (!builder->get_insert_block()->is_terminated()) 
        builder->create_br(judgeBB);//goto while judgement

    builder->set_insert_point(endBB);
    return nullptr;
}
```

