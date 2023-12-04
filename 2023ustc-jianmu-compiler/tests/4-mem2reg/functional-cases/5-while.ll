; ModuleID = 'cminus'
source_filename = "/home/rainzor/Compiler/2023ustc-jianmu-compiler/tests/4-mem2reg/functional-cases/5-while.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @main() {
label_entry:
  br label %label2
label2:                                                ; preds = %label_entry, %label8
  %op13 = phi i32 [ 0, %label_entry ], [ %op11, %label8 ]
  %op5 = icmp slt i32 %op13, 10
  %op6 = zext i1 %op5 to i32
  %op7 = icmp ne i32 %op6, 0
  br i1 %op7, label %label8, label %label12
label8:                                                ; preds = %label2
  call void @output(i32 %op13)
  %op11 = add i32 %op13, 1
  br label %label2
label12:                                                ; preds = %label2
  ret i32 0
}
