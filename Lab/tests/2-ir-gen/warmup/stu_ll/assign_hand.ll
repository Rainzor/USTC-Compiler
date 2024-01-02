define dso_local i32 @main() #0{
    %1 = alloca i32
    %2 = alloca [10 x i32]
    store i32 0, i32* %1
    %3 = getelementptr inbounds [10 x i32], [10 x i32]* %2, i32 0, i32 0
    store i32 10, i32* %3
    %4 = getelementptr inbounds [10 x i32], [10 x i32]* %2, i32 0, i32 0
    %5 = load i32, i32* %4
    %6 = mul i32 %5, 2
    %7 = getelementptr inbounds [10 x i32], [10 x i32]* %2, i32 0, i32 1
    store i32 %6, i32* %7
    %8 = getelementptr inbounds [10 x i32], [10 x i32]* %2, i32 0, i32 1
    %9 = load i32, i32* %8
    ret i32 %9
}