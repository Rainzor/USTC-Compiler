define dso_local i32 @main() #0{
    %retval = alloca i32, align 4
    %1 = alloca float
    store i32 0, i32* %retval
    store float 0x40163851E0000000, float* %1
    %2 = load float, float* %1
    %3 = fcmp ugt float %2, 1.000000e+00
    br i1 %3, label %4, label %5
    ; <label>:4
4:
    store i32 233, i32* %retval
    br label %6
    ; <label>:5
5:
    store i32 0, i32* %retval
    br label %6
    ; <label>:6
6:
    %7 = load i32, i32* %retval
    ret i32 %7
}