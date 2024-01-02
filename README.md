# Compiler

This is USTC *Principles and Techniques of Compiler* 2023 course

Course Homepage link: https://ustc-compiler-principles.github.io/2023

## How to use it

##### Environment

> Windows11 
>
> WSL2 Ubuntu 22.04.3 LTS
>
> flex 2.6.4, bison 3.8.2,GNU gdb12.1,clang LLVM 14.0.0, GCC 11.4.0

##### Compile the project

```sh
cd Lab
mkdir build
cd build
# 使用 cmake 生成 makefile 等文件
cmake ..
# 使用 make 进行编译，指定 install 以正确测试
sudo make install
```

##### Compile a cminus file: 

`test.cminus` for example

```sh
#Compile to IR
cminusfc -emit-llvm test.cminus
#Compile to assembly
cminusfc -S test.cminus
```

(The test examples you can find in [tests](./Lab/tests/testcases_general))

##### Take Mem2Reg Optimization

```sh
#Compile to IR with optimization
cminusfc -emit-llvm -mem2reg test.cminus
#Compile to assembly with optimization
cminusfc -S -mem2reg test.cminus
```

