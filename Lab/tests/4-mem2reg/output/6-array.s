	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -176
.main_label_entry:
# %op0 = alloca [10 x i32]
	addi.d $t0, $fp, -64
	st.d $t0, $fp, -24
# %op2 = icmp slt i32 0, 0
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -65
# br i1 %op2, label %label6, label %label3
	ld.b $t0, $fp, -65
	beqz $t0, .main_label3
	b .main_label6
.main_label3:
# %op4 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 0
	ld.d $t0, $fp, -24
	addi.w $t1, $zero, 0
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -80
# store i32 11, i32* %op4
	ld.d $t0, $fp, -80
	addi.w $t1, $zero, 11
	st.w $t1, $t0, 0
# %op5 = icmp slt i32 4, 0
	addi.w $t0, $zero, 4
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -81
# br i1 %op5, label %label10, label %label7
	ld.b $t0, $fp, -81
	beqz $t0, .main_label7
	b .main_label10
.main_label6:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label7:
# %op8 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 4
	ld.d $t0, $fp, -24
	addi.w $t1, $zero, 4
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -96
# store i32 22, i32* %op8
	ld.d $t0, $fp, -96
	addi.w $t1, $zero, 22
	st.w $t1, $t0, 0
# %op9 = icmp slt i32 9, 0
	addi.w $t0, $zero, 9
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -97
# br i1 %op9, label %label14, label %label11
	ld.b $t0, $fp, -97
	beqz $t0, .main_label11
	b .main_label14
.main_label10:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label11:
# %op12 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 9
	ld.d $t0, $fp, -24
	addi.w $t1, $zero, 9
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -112
# store i32 33, i32* %op12
	ld.d $t0, $fp, -112
	addi.w $t1, $zero, 33
	st.w $t1, $t0, 0
# %op13 = icmp slt i32 0, 0
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -113
# br i1 %op13, label %label19, label %label15
	ld.b $t0, $fp, -113
	beqz $t0, .main_label15
	b .main_label19
.main_label14:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label15:
# %op16 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 0
	ld.d $t0, $fp, -24
	addi.w $t1, $zero, 0
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -128
# %op17 = load i32, i32* %op16
	ld.d $t0, $fp, -128
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -132
# call void @output(i32 %op17)
	ld.w $a0, $fp, -132
	bl output
# %op18 = icmp slt i32 4, 0
	addi.w $t0, $zero, 4
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -133
# br i1 %op18, label %label24, label %label20
	ld.b $t0, $fp, -133
	beqz $t0, .main_label20
	b .main_label24
.main_label19:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label20:
# %op21 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 4
	ld.d $t0, $fp, -24
	addi.w $t1, $zero, 4
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -144
# %op22 = load i32, i32* %op21
	ld.d $t0, $fp, -144
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -148
# call void @output(i32 %op22)
	ld.w $a0, $fp, -148
	bl output
# %op23 = icmp slt i32 9, 0
	addi.w $t0, $zero, 9
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -149
# br i1 %op23, label %label28, label %label25
	ld.b $t0, $fp, -149
	beqz $t0, .main_label25
	b .main_label28
.main_label24:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label25:
# %op26 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 9
	ld.d $t0, $fp, -24
	addi.w $t1, $zero, 9
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -160
# %op27 = load i32, i32* %op26
	ld.d $t0, $fp, -160
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -164
# call void @output(i32 %op27)
	ld.w $a0, $fp, -164
	bl output
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label28:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 176
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
