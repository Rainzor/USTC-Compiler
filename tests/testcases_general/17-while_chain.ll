; ModuleID = 'cminus'
source_filename = "/home/rainzor/Compiler/2023ustc-jianmu-compiler/tests/testcases_general/17-while_chain.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @main() {
label_entry:
  br label %label2
label2:                                                ; preds = %label_entry, %label19
  %op20 = phi i32 [ 10, %label_entry ], [ %op7, %label19 ]
  %op21 = phi i32 [ %op22, %label19 ], [ undef, %label_entry ]
  %op4 = icmp ne i32 %op20, 0
  br i1 %op4, label %label5, label %label9
label5:                                                ; preds = %label2
  %op7 = sub i32 %op20, 1
  br label %label13
label9:                                                ; preds = %label2
  %op12 = add i32 %op20, %op21
  ret i32 %op12
label13:                                                ; preds = %label5, %label16
  %op22 = phi i32 [ %op7, %label5 ], [ %op18, %label16 ]
  %op15 = icmp ne i32 %op22, 0
  br i1 %op15, label %label16, label %label19
label16:                                                ; preds = %label13
  %op18 = sub i32 %op22, 1
  br label %label13
label19:                                                ; preds = %label13
  br label %label2
}
