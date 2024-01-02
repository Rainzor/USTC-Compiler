	.text
	.globl store
	.type store, @function
store:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -48
	st.d $a0, $fp, -24
	st.w $a1, $fp, -28
	st.w $a2, $fp, -32
.store_label_entry:
# %op8 = icmp slt i32 %arg1, 0
	ld.w $t0, $fp, -28
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -33
# br i1 %op8, label %label13, label %label9
	ld.b $t0, $fp, -33
	beqz $t0, .store_label9
	b .store_label13
.store_label9:
# %op11 = getelementptr i32, i32* %arg0, i32 %arg1
	ld.d $t0, $fp, -24
	ld.w $t1, $fp, -28
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -48
# store i32 %arg2, i32* %op11
	ld.d $t0, $fp, -48
	ld.w $t1, $fp, -32
	st.w $t1, $t0, 0
# ret i32 %arg2
	ld.w $a0, $fp, -32
	b store_exit
.store_label13:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b store_exit
store_exit:
	addi.d $sp, $sp, 48
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -144
.main_label_entry:
# %op0 = alloca [10 x i32]
	addi.d $t0, $fp, -64
	st.d $t0, $fp, -24
# br label %label3
	addi.w $t0, $zero, 0
	st.w $t0, $fp, -68
	b .main_label3
.main_label3:
# %op35 = phi i32 [ 0, %label_entry ], [ %op15, %label8 ]
# %op5 = icmp slt i32 %op35, 10
	ld.w $t0, $fp, -68
	addi.w $t1, $zero, 10
	slt $t2, $t0, $t1
	st.b $t2, $fp, -69
# %op6 = zext i1 %op5 to i32
	ld.b $t0, $fp, -69
	bstrpick.w $t1, $t0, 7, 0
	st.w $t1, $fp, -76
# %op7 = icmp ne i32 %op6, 0
	ld.w $t0, $fp, -76
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -77
# br i1 %op7, label %label8, label %label16
	ld.b $t0, $fp, -77
	beqz $t0, .main_label16
	b .main_label8
.main_label8:
# %op9 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 0
	ld.d $t0, $fp, -24
	addi.w $t1, $zero, 0
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -88
# %op12 = mul i32 %op35, 2
	ld.w $t0, $fp, -68
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -92
# %op13 = call i32 @store(i32* %op9, i32 %op35, i32 %op12)
	ld.d $a0, $fp, -88
	ld.w $a1, $fp, -68
	ld.w $a2, $fp, -92
	bl store
	st.w $a0, $fp, -96
# %op15 = add i32 %op35, 1
	ld.w $t0, $fp, -68
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -100
# br label %label3
	ld.w $t0, $fp, -100
	st.w $t0, $fp, -68
	b .main_label3
.main_label16:
# br label %label17
	addi.w $t0, $zero, 0
	st.w $t0, $fp, -104
	addi.w $t0, $zero, 0
	st.w $t0, $fp, -108
	b .main_label17
.main_label17:
# %op36 = phi i32 [ 0, %label16 ], [ %op33, %label28 ]
# %op37 = phi i32 [ 0, %label16 ], [ %op31, %label28 ]
# %op19 = icmp slt i32 %op36, 10
	ld.w $t0, $fp, -104
	addi.w $t1, $zero, 10
	slt $t2, $t0, $t1
	st.b $t2, $fp, -109
# %op20 = zext i1 %op19 to i32
	ld.b $t0, $fp, -109
	bstrpick.w $t1, $t0, 7, 0
	st.w $t1, $fp, -116
# %op21 = icmp ne i32 %op20, 0
	ld.w $t0, $fp, -116
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -117
# br i1 %op21, label %label22, label %label26
	ld.b $t0, $fp, -117
	beqz $t0, .main_label26
	b .main_label22
.main_label22:
# %op25 = icmp slt i32 %op36, 0
	ld.w $t0, $fp, -104
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -118
# br i1 %op25, label %label34, label %label28
	ld.b $t0, $fp, -118
	beqz $t0, .main_label28
	b .main_label34
.main_label26:
# call void @output(i32 %op37)
	ld.w $a0, $fp, -108
	bl output
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label28:
# %op29 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 %op36
	ld.d $t0, $fp, -24
	ld.w $t1, $fp, -104
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -128
# %op30 = load i32, i32* %op29
	ld.d $t0, $fp, -128
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -132
# %op31 = add i32 %op37, %op30
	ld.w $t0, $fp, -108
	ld.w $t1, $fp, -132
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -136
# %op33 = add i32 %op36, 1
	ld.w $t0, $fp, -104
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -140
# br label %label17
	ld.w $t0, $fp, -140
	st.w $t0, $fp, -104
	ld.w $t0, $fp, -136
	st.w $t0, $fp, -108
	b .main_label17
.main_label34:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 144
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
