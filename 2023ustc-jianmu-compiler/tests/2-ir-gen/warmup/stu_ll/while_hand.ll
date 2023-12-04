define dso_local i32 @main() #0 {
    ;return val
    %1 = alloca i32
    store i32 0, i32* %1
    ; a
    %2 = alloca i32
    store i32 10, i32* %2
    ; i
    %3 = alloca i32
    store i32 0, i32* %3
    br label %4
4:
    %5 = load i32, i32* %3
    %6 = icmp slt i32 %5, 10
    br i1 %6, label %7, label %13
7:
    %8 = load i32, i32* %3
    %9 = add i32 %8, 1
    store i32 %9, i32* %3

    %10 = load i32, i32* %2
    %11 = load i32, i32* %3
    %12 = add i32 %10, %11
    store i32 %12, i32* %2

    br label %4
13:
    %14 = load i32, i32* %2
    ret i32 %14
}