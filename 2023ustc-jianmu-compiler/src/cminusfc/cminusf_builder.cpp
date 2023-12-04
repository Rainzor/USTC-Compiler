#include "cminusf_builder.hpp"




#define CONST_FP(num) ConstantFP::get((float)num, module.get())
#define CONST_INT(num) ConstantInt::get(num, module.get())

// types
Type *VOID_T;
Type *INT1_T;
Type *INT32_T;
Type *INT32PTR_T;
Type *FLOAT_T;
Type *FLOATPTR_T;

#define is_POINTER_INTEGER(cur_val) ((cur_val)->get_type()->get_pointer_element_type()->is_integer_type())
#define is_POINTER_FLOAT(cur_val) ((cur_val)->get_type()->get_pointer_element_type()->is_float_type())
#define is_POINTER_POINTER(cur_val) ((cur_val)->get_type()->get_pointer_element_type()->is_pointer_type())

#define is_INTEGER(cur_val) ((cur_val)->get_type()->is_integer_type())
#define is_FLOAT(cur_val) ((cur_val)->get_type()->is_float_type())
#define is_POINTER(cur_val) ((cur_val)->get_type()->is_pointer_type())

/*
 * use CMinusfBuilder::Scope to construct scopes
 * scope.enter: enter a new scope
 * scope.exit: exit current scope
 * scope.push: add a new binding to current scope
 * scope.find: find and return the value bound to the name
 */

Value* CminusfBuilder::visit(ASTProgram &node) {
    VOID_T = module->get_void_type();
    INT1_T = module->get_int1_type();
    INT32_T = module->get_int32_type();
    INT32PTR_T = module->get_int32_ptr_type();
    FLOAT_T = module->get_float_type();
    FLOATPTR_T = module->get_float_ptr_type();

    Value *ret_val = nullptr;
    for (auto &decl : node.declarations) {
        ret_val = decl->accept(*this);
    }
    return ret_val;
}

Value* CminusfBuilder::visit(ASTNum &node) {
    // TODO: 
    if(node.type==TYPE_INT) {
        context.val = CONST_INT(node.i_val);
    }
    else if(node.type==TYPE_FLOAT) {
        context.val = CONST_FP(node.f_val);
    }
    else if (node.type==TYPE_VOID){}
    return nullptr;
}

Value* CminusfBuilder::visit(ASTVarDeclaration &node) {
    // TODO: 
    Type* var_type;
    if(node.type==TYPE_INT) {
        var_type = INT32_T;
    }
    else if(node.type==TYPE_FLOAT) {
        var_type = FLOAT_T;
    }

    if(scope.in_global()){
        if (node.num==nullptr){ //single var
            auto init_val=ConstantZero::get(var_type,module.get());
            auto gen_var=GlobalVariable::create(node.id,module.get(),var_type,false,init_val);
            scope.push(node.id,gen_var);
        }
        else{//array type
            auto* arr_ptr = ArrayType::get(var_type,node.num->i_val); //Type[num->i_val]
            auto init_val=ConstantZero::get(arr_ptr,module.get());
            auto gen_arr=GlobalVariable::create(node.id,module.get(),arr_ptr,false,init_val);
            scope.push(node.id,gen_arr);
        }
    }else{
        if(node.num==nullptr){
            auto gen_var = builder->create_alloca(var_type);
            scope.push(node.id,gen_var);
        }else{
            auto* arr_ptr = ArrayType::get(var_type,node.num->i_val);
            auto gen_arr = builder->create_alloca(arr_ptr);
            scope.push(node.id,gen_arr);
        }
    }

    return nullptr;
}

Value* CminusfBuilder::visit(ASTFunDeclaration &node) {
    FunctionType *fun_type;
    Type *ret_type;
    std::vector<Type *> param_types;
    if (node.type == TYPE_INT)
        ret_type = INT32_T;
    else if (node.type == TYPE_FLOAT)
        ret_type = FLOAT_T;
    else
        ret_type = VOID_T;

    for (auto &param : node.params) {
        // TODO: Please accomplish param_types.
        if (param->type==TYPE_INT){
            if (param->isarray) 
                param_types.push_back(INT32PTR_T);
            else 
                param_types.push_back(INT32_T);
        }
        else{
            if (param->isarray) 
                param_types.push_back(FLOATPTR_T);
            else 
                param_types.push_back(FLOAT_T);
        }

    }

    fun_type = FunctionType::get(ret_type, param_types);
    auto func = Function::create(fun_type, node.id, module.get());
    scope.push(node.id, func);
    context.func = func;
    auto funBB = BasicBlock::create(module.get(), "entry", func);
    builder->set_insert_point(funBB);
    scope.enter();
    std::vector<Value *> args;
    for (auto &arg : func->get_args()) {
        args.push_back(&arg);
    }
    Value* var_alloca;
    for (int i = 0; i < node.params.size(); ++i) {
        // TODO: You need to deal with params and store them in the scope.
        auto param = node.params[i];
        if (param->type==TYPE_INT){
            if (param->isarray) 
            {
                var_alloca=builder->create_alloca(INT32PTR_T);
                builder->create_store(args[i],var_alloca);
                scope.push(param->id,var_alloca);
            }
            else 
            {
                var_alloca=builder->create_alloca(INT32_T);
                builder->create_store(args[i],var_alloca);
                scope.push(param->id,var_alloca);
            }
        }else{
            if (param->isarray){
                var_alloca=builder->create_alloca(FLOATPTR_T);
                builder->create_store(args[i],var_alloca);
                scope.push(param->id,var_alloca);
            }
            else{
                var_alloca=builder->create_alloca(FLOAT_T);
                builder->create_store(args[i],var_alloca);
                scope.push(param->id,var_alloca);
            }
        }

    }
    node.compound_stmt->accept(*this);
    if (not builder->get_insert_block()->is_terminated())
    {
        if (context.func->get_return_type()->is_void_type())
            builder->create_void_ret();
        else if (context.func->get_return_type()->is_float_type())
            builder->create_ret(CONST_FP(0.));
        else
            builder->create_ret(CONST_INT(0));
    }
    scope.exit();
    return nullptr;
}

Value* CminusfBuilder::visit(ASTParam &node) {
    // TODO: 
    {}
    return nullptr;
}

Value* CminusfBuilder::visit(ASTCompoundStmt &node) {
    // TODO: This function is not complete.
    // You may need to add some code here
    // to deal with complex statements.

    scope.enter();

    for (auto &decl : node.local_declarations) {
        decl->accept(*this);
    }

    for (auto &stmt : node.statement_list) {
        stmt->accept(*this);
        if (builder->get_insert_block()->is_terminated())
            break;
    }

    scope.exit();
    return nullptr;
}

Value* CminusfBuilder::visit(ASTExpressionStmt &node) {
    // TODO: This function is empty now.
    // Add some code here.

    if (node.expression!=nullptr) 
        node.expression->accept(*this);
    return nullptr;
}

//if else
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

Value* CminusfBuilder::visit(ASTReturnStmt &node) {
    if (node.expression == nullptr) {
        builder->create_void_ret();
        return nullptr;
    } else {
        // TODO: The given code is incomplete.
        // You need to solve other return cases (e.g. return an integer).
        auto cur_fun = context.func;
        auto ret_type=cur_fun->get_function_type()->get_return_type();
        node.expression->accept(*this);
        auto cur_val = context.val;
        if (ret_type->is_integer_type()){
            if (ret_type!=cur_val->get_type())
                cur_val=builder->create_fptosi(cur_val,INT32_T);
        }
        else{
            if (ret_type!=cur_val->get_type())
                cur_val=builder->create_sitofp(cur_val,FLOAT_T);
        }
        builder->create_ret(cur_val);

    }
    return nullptr;
}

Value* CminusfBuilder::visit(ASTVar &node) {//vontext.val存储对应变量的地址
    // TODO: This function is empty now.
    // Add some code here.
    bool is_lval = context.is_lval;
    context.is_lval=false;
    if(node.expression==nullptr){//id
        auto cur_var=scope.find(node.id);
        if (is_lval) //值
            context.val=cur_var;
        else{
            if (is_POINTER_FLOAT(cur_var)||
                is_POINTER_INTEGER(cur_var)||
                is_POINTER_POINTER(cur_var)) //指针
                context.val=builder->create_load(cur_var);
            else //数组
                context.val=builder->create_gep(cur_var,{CONST_INT(0),CONST_INT(0)});
        }
    }else{//id[expression]
        auto cur_var = scope.find(node.id);
        node.expression->accept(*this);
        auto cur_val = context.val;
        if(cur_val->get_type()->is_float_type())
            cur_val=builder->create_fptosi(cur_val,INT32_T);
        auto cur_fun = context.func;
        auto condBB=BasicBlock::create(module.get(),"",cur_fun);
        auto exceptBB=BasicBlock::create(module.get(),"",cur_fun);
        Value* is_neg;
        is_neg = builder->create_icmp_lt(cur_val,CONST_INT(0));
        builder->create_cond_br(is_neg,exceptBB,condBB);

        builder->set_insert_point(exceptBB);
        auto deal_fail = scope.find("neg_idx_except");
        builder->create_call(static_cast<Function *>(deal_fail),{});

        if (cur_fun->get_return_type()->is_void_type()) 
            builder->create_void_ret();
        else if (cur_fun->get_return_type()->is_float_type()) 
            builder->create_ret(CONST_FP(0.));
        else 
            builder->create_ret(CONST_INT(0));

        builder->set_insert_point(condBB);
        Value* new_ptr;
        if(is_POINTER_POINTER(cur_var)){//指针
            auto array_ptr = builder->create_load(cur_var);
            new_ptr = builder->create_gep(array_ptr,{cur_val});
        }else if(is_POINTER_FLOAT(cur_var)||is_POINTER_INTEGER(cur_var)){
            new_ptr = builder->create_gep(cur_var,{cur_val});
        }else{//数组
            new_ptr = builder->create_gep(cur_var,{CONST_INT(0),cur_val});
        }
        
        if(is_lval){
            context.is_lval=false;
            context.val = new_ptr;
        }else{
            context.val = builder->create_load(new_ptr);
        }
    }
    return nullptr;
}

Value* CminusfBuilder::visit(ASTAssignExpression &node) {
    // TODO: 
    node.expression->accept(*this);
    context.is_lval=true;
    auto value=context.val;
    node.var->accept(*this);
    auto var_alloc=context.val;
    if (value->get_type()!=var_alloc->get_type()->get_pointer_element_type()){
        if (value->get_type()==INT32_T) 
            value=builder->create_sitofp(value,FLOAT_T);
        else 
            value=builder->create_fptosi(value,INT32_T);
    }
    builder->create_store(value,var_alloc);
    context.val=value;
    return nullptr;
}

Value* CminusfBuilder::visit(ASTSimpleExpression &node) {
    // TODO: 
    if(node.additive_expression_r==nullptr)
        node.additive_expression_l->accept(*this);
    else{
        node.additive_expression_l->accept(*this);
        auto lvalue=context.val;
        node.additive_expression_r->accept(*this);
        auto rvalue=context.val;
        bool is_int;
        Value* flag;
        if (lvalue->get_type()==rvalue->get_type()) 
            is_int=rvalue->get_type()->is_integer_type();
        else{
            if (is_INTEGER(lvalue)) 
                lvalue=builder->create_sitofp(lvalue,FLOAT_T);
            if (is_INTEGER(rvalue)) 
                rvalue=builder->create_sitofp(rvalue,FLOAT_T);
            is_int=false;
        }

        switch (node.op){
        case OP_LT:
            if (is_int) 
                flag=builder->create_icmp_lt(lvalue,rvalue);
            else 
                flag=builder->create_fcmp_lt(lvalue,rvalue);
            break;
        
        case OP_LE:
            if (is_int) 
                flag=builder->create_icmp_le(lvalue,rvalue);
            else 
                flag=builder->create_fcmp_le(lvalue,rvalue);
            break;

        case OP_GE:
            if (is_int) 
                flag=builder->create_icmp_ge(lvalue,rvalue);
            else 
                flag=builder->create_fcmp_ge(lvalue,rvalue);
            break;

        case OP_GT:
            if (is_int) 
                flag=builder->create_icmp_gt(lvalue,rvalue);
            else 
                flag=builder->create_fcmp_gt(lvalue,rvalue);
            break;

        case OP_EQ:
            if (is_int) 
                flag=builder->create_icmp_eq(lvalue,rvalue);
            else 
                flag=builder->create_fcmp_eq(lvalue,rvalue);
            break;

        case OP_NEQ:
            if (is_int) 
                flag=builder->create_icmp_ne(lvalue,rvalue);
            else 
                flag=builder->create_fcmp_ne(lvalue,rvalue);
            break;
        default:
            break;
        }
        context.val=builder->create_zext(flag,INT32_T);
    }


    return nullptr;
}

Value* CminusfBuilder::visit(ASTAdditiveExpression &node) {
    // TODO: This function is empty now.
    // Add some code here.
    if(node.additive_expression==nullptr)
        node.term->accept(*this);
    else{
        node.additive_expression->accept(*this);
        auto lvalue=context.val;
        node.term->accept(*this);
        auto rvalue=context.val;
        bool is_int;
        if (lvalue->get_type()==rvalue->get_type()) 
            is_int=rvalue->get_type()->is_integer_type();
        else{
            if (is_INTEGER(lvalue)) 
                lvalue=builder->create_sitofp(lvalue,FLOAT_T);
            if (is_INTEGER(rvalue)) 
                rvalue=builder->create_sitofp(rvalue,FLOAT_T);
            is_int=false;
        }
        switch (node.op){
        case OP_PLUS:
            if (is_int) 
                context.val=builder->create_iadd(lvalue,rvalue);
            else 
                context.val=builder->create_fadd(lvalue,rvalue);
            break;
        case OP_MINUS:
            if (is_int) 
                context.val=builder->create_isub(lvalue,rvalue);
            else 
                context.val=builder->create_fsub(lvalue,rvalue);
            break;
        default:
            break;
        }
    }
    return nullptr;
}

Value* CminusfBuilder::visit(ASTTerm &node) {
    // TODO: 
    if (node.term==nullptr) 
        node.factor->accept(*this);
    else{
        node.term->accept(*this);
        auto lvalue=context.val;
        node.factor->accept(*this);
        auto rvalue=context.val;
        bool is_int;
        if (lvalue->get_type()==rvalue->get_type()) 
            is_int=rvalue->get_type()->is_integer_type();
        else{
            if (is_INTEGER(lvalue)) 
                lvalue=builder->create_sitofp(lvalue,FLOAT_T);
            if (is_INTEGER(rvalue)) 
                rvalue=builder->create_sitofp(rvalue,FLOAT_T);
            is_int=false;
        }
        switch (node.op){
            case OP_MUL:
                if (is_int) 
                    context.val=builder->create_imul(lvalue,rvalue);
                else 
                    context.val=builder->create_fmul(lvalue,rvalue);
                break;
            case OP_DIV:
                if (is_int) 
                    context.val=builder->create_isdiv(lvalue,rvalue);
                else 
                    context.val=builder->create_fdiv(lvalue,rvalue);
                break;
            default:
                break;
        }
    }
    return nullptr;
}

Value* CminusfBuilder::visit(ASTCall &node) {
    // TODO:
    auto cur_fun = static_cast<Function *>(scope.find(node.id));
    auto params = cur_fun->get_function_type()->param_begin();
    std::vector<Value *> args;
    for(auto&arg:node.args){
        arg->accept(*this);
        auto cur_val = context.val;
        if (!is_POINTER(cur_val) && *params!=cur_val->get_type()){
            if (is_INTEGER(cur_val)) 
                cur_val=builder->create_sitofp(cur_val,FLOAT_T);
            else 
                cur_val=builder->create_fptosi(cur_val,INT32_T);
        }
        args.push_back(cur_val);
        params++;
    }
    context.val=builder->create_call(static_cast<Function *>(cur_fun),args);

    return nullptr;
}
