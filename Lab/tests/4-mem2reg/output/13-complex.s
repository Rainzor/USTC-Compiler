# Global variables
	.text
	.section .bss, "aw", @nobits
	.globl n
	.type n, @object
	.size n, 4
n:
	.space 4
	.globl m
	.type m, @object
	.size m, 4
m:
	.space 4
	.globl w
	.type w, @object
	.size w, 20
w:
	.space 20
	.globl v
	.type v, @object
	.size v, 20
v:
	.space 20
	.globl dp
	.type dp, @object
	.size dp, 264
dp:
	.space 264
	.text
	.globl max
	.type max, @function
max:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -48
	st.w $a0, $fp, -20
	st.w $a1, $fp, -24
.max_label_entry:
# %op6 = icmp sgt i32 %arg0, %arg1
	ld.w $t0, $fp, -20
	ld.w $t1, $fp, -24
	slt $t2, $t1, $t0
	st.b $t2, $fp, -25
# %op7 = zext i1 %op6 to i32
	ld.b $t0, $fp, -25
	bstrpick.w $t1, $t0, 7, 0
	st.w $t1, $fp, -32
# %op8 = icmp ne i32 %op7, 0
	ld.w $t0, $fp, -32
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -33
# br i1 %op8, label %label9, label %label11
	ld.b $t0, $fp, -33
	beqz $t0, .max_label11
	b .max_label9
.max_label9:
# ret i32 %arg0
	ld.w $a0, $fp, -20
	b max_exit
.max_label11:
# ret i32 %arg1
	ld.w $a0, $fp, -24
	b max_exit
.max_label13:
# ret i32 0
	addi.w $a0, $zero, 0
	b max_exit
max_exit:
	addi.d $sp, $sp, 48
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl knapsack
	.type knapsack, @function
knapsack:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -256
	st.w $a0, $fp, -20
	st.w $a1, $fp, -24
.knapsack_label_entry:
# %op6 = icmp sle i32 %arg1, 0
	ld.w $t0, $fp, -24
	addi.w $t1, $zero, 0
	slt $t2, $t1, $t0
	xori $t2, $t2, 1
	st.b $t2, $fp, -25
# %op7 = zext i1 %op6 to i32
	ld.b $t0, $fp, -25
	bstrpick.w $t1, $t0, 7, 0
	st.w $t1, $fp, -32
# %op8 = icmp ne i32 %op7, 0
	ld.w $t0, $fp, -32
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -33
# br i1 %op8, label %label9, label %label10
	ld.b $t0, $fp, -33
	beqz $t0, .knapsack_label10
	b .knapsack_label9
.knapsack_label9:
# ret i32 0
	addi.w $a0, $zero, 0
	b knapsack_exit
.knapsack_label10:
# %op12 = icmp eq i32 %arg0, 0
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	xori $t2, $t2, 1
	st.b $t2, $fp, -34
# %op13 = zext i1 %op12 to i32
	ld.b $t0, $fp, -34
	bstrpick.w $t1, $t0, 7, 0
	st.w $t1, $fp, -40
# %op14 = icmp ne i32 %op13, 0
	ld.w $t0, $fp, -40
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -41
# br i1 %op14, label %label15, label %label16
	ld.b $t0, $fp, -41
	beqz $t0, .knapsack_label16
	b .knapsack_label15
.knapsack_label15:
# ret i32 0
	addi.w $a0, $zero, 0
	b knapsack_exit
.knapsack_label16:
# %op18 = mul i32 %arg0, 11
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 11
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -48
# %op20 = add i32 %op18, %arg1
	ld.w $t0, $fp, -48
	ld.w $t1, $fp, -24
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -52
# %op21 = icmp slt i32 %op20, 0
	ld.w $t0, $fp, -52
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -53
# br i1 %op21, label %label28, label %label22
	ld.b $t0, $fp, -53
	beqz $t0, .knapsack_label22
	b .knapsack_label28
.knapsack_label22:
# %op23 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op20
	la.local $t0, dp
	ld.w $t1, $fp, -52
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -64
# %op24 = load i32, i32* %op23
	ld.d $t0, $fp, -64
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -68
# %op25 = icmp sge i32 %op24, 0
	ld.w $t0, $fp, -68
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	xori $t2, $t2, 1
	st.b $t2, $fp, -69
# %op26 = zext i1 %op25 to i32
	ld.b $t0, $fp, -69
	bstrpick.w $t1, $t0, 7, 0
	st.w $t1, $fp, -76
# %op27 = icmp ne i32 %op26, 0
	ld.w $t0, $fp, -76
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -77
# br i1 %op27, label %label29, label %label35
	ld.b $t0, $fp, -77
	beqz $t0, .knapsack_label35
	b .knapsack_label29
.knapsack_label28:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b knapsack_exit
.knapsack_label29:
# %op31 = mul i32 %arg0, 11
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 11
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -84
# %op33 = add i32 %op31, %arg1
	ld.w $t0, $fp, -84
	ld.w $t1, $fp, -24
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -88
# %op34 = icmp slt i32 %op33, 0
	ld.w $t0, $fp, -88
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -89
# br i1 %op34, label %label43, label %label40
	ld.b $t0, $fp, -89
	beqz $t0, .knapsack_label40
	b .knapsack_label43
.knapsack_label35:
# %op38 = sub i32 %arg0, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -96
# %op39 = icmp slt i32 %op38, 0
	ld.w $t0, $fp, -96
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -97
# br i1 %op39, label %label50, label %label44
	ld.b $t0, $fp, -97
	beqz $t0, .knapsack_label44
	b .knapsack_label50
.knapsack_label40:
# %op41 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op33
	la.local $t0, dp
	ld.w $t1, $fp, -88
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -112
# %op42 = load i32, i32* %op41
	ld.d $t0, $fp, -112
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -116
# ret i32 %op42
	ld.w $a0, $fp, -116
	b knapsack_exit
.knapsack_label43:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b knapsack_exit
.knapsack_label44:
# %op45 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 %op38
	la.local $t0, w
	ld.w $t1, $fp, -96
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -128
# %op46 = load i32, i32* %op45
	ld.d $t0, $fp, -128
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -132
# %op47 = icmp slt i32 %arg1, %op46
	ld.w $t0, $fp, -24
	ld.w $t1, $fp, -132
	slt $t2, $t0, $t1
	st.b $t2, $fp, -133
# %op48 = zext i1 %op47 to i32
	ld.b $t0, $fp, -133
	bstrpick.w $t1, $t0, 7, 0
	st.w $t1, $fp, -140
# %op49 = icmp ne i32 %op48, 0
	ld.w $t0, $fp, -140
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -141
# br i1 %op49, label %label51, label %label56
	ld.b $t0, $fp, -141
	beqz $t0, .knapsack_label56
	b .knapsack_label51
.knapsack_label50:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b knapsack_exit
.knapsack_label51:
# %op53 = sub i32 %arg0, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -148
# %op55 = call i32 @knapsack(i32 %op53, i32 %arg1)
	ld.w $a0, $fp, -148
	ld.w $a1, $fp, -24
	bl knapsack
	st.w $a0, $fp, -152
# br label %label67
	ld.w $t0, $fp, -152
	st.w $t0, $fp, -176
	b .knapsack_label67
.knapsack_label56:
# %op58 = sub i32 %arg0, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -156
# %op60 = call i32 @knapsack(i32 %op58, i32 %arg1)
	ld.w $a0, $fp, -156
	ld.w $a1, $fp, -24
	bl knapsack
	st.w $a0, $fp, -160
# %op62 = sub i32 %arg0, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -164
# %op65 = sub i32 %arg0, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -168
# %op66 = icmp slt i32 %op65, 0
	ld.w $t0, $fp, -168
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -169
# br i1 %op66, label %label82, label %label74
	ld.b $t0, $fp, -169
	beqz $t0, .knapsack_label74
	b .knapsack_label82
.knapsack_label67:
# %op93 = phi i32 [ %op55, %label51 ], [ %op87, %label83 ]
# %op70 = mul i32 %arg0, 11
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 11
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -180
# %op72 = add i32 %op70, %arg1
	ld.w $t0, $fp, -180
	ld.w $t1, $fp, -24
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -184
# %op73 = icmp slt i32 %op72, 0
	ld.w $t0, $fp, -184
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -185
# br i1 %op73, label %label92, label %label89
	ld.b $t0, $fp, -185
	beqz $t0, .knapsack_label89
	b .knapsack_label92
.knapsack_label74:
# %op75 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 %op65
	la.local $t0, w
	ld.w $t1, $fp, -168
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -200
# %op76 = load i32, i32* %op75
	ld.d $t0, $fp, -200
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -204
# %op77 = sub i32 %arg1, %op76
	ld.w $t0, $fp, -24
	ld.w $t1, $fp, -204
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -208
# %op78 = call i32 @knapsack(i32 %op62, i32 %op77)
	ld.w $a0, $fp, -164
	ld.w $a1, $fp, -208
	bl knapsack
	st.w $a0, $fp, -212
# %op80 = sub i32 %arg0, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -216
# %op81 = icmp slt i32 %op80, 0
	ld.w $t0, $fp, -216
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -217
# br i1 %op81, label %label88, label %label83
	ld.b $t0, $fp, -217
	beqz $t0, .knapsack_label83
	b .knapsack_label88
.knapsack_label82:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b knapsack_exit
.knapsack_label83:
# %op84 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 %op80
	la.local $t0, v
	ld.w $t1, $fp, -216
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -232
# %op85 = load i32, i32* %op84
	ld.d $t0, $fp, -232
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -236
# %op86 = add i32 %op78, %op85
	ld.w $t0, $fp, -212
	ld.w $t1, $fp, -236
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -240
# %op87 = call i32 @max(i32 %op60, i32 %op86)
	ld.w $a0, $fp, -160
	ld.w $a1, $fp, -240
	bl max
	st.w $a0, $fp, -244
# br label %label67
	ld.w $t0, $fp, -244
	st.w $t0, $fp, -176
	b .knapsack_label67
.knapsack_label88:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b knapsack_exit
.knapsack_label89:
# %op90 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op72
	la.local $t0, dp
	ld.w $t1, $fp, -184
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -256
# store i32 %op93, i32* %op90
	ld.d $t0, $fp, -256
	ld.w $t1, $fp, -176
	st.w $t1, $t0, 0
# ret i32 %op93
	ld.w $a0, $fp, -176
	b knapsack_exit
.knapsack_label92:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b knapsack_exit
knapsack_exit:
	addi.d $sp, $sp, 256
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -240
.main_label_entry:
# store i32 5, i32* @n
	la.local $t0, n
	addi.w $t1, $zero, 5
	st.w $t1, $t0, 0
# store i32 10, i32* @m
	la.local $t0, m
	addi.w $t1, $zero, 10
	st.w $t1, $t0, 0
# %op1 = icmp slt i32 0, 0
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -17
# br i1 %op1, label %label5, label %label2
	ld.b $t0, $fp, -17
	beqz $t0, .main_label2
	b .main_label5
.main_label2:
# %op3 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 0
	la.local $t0, w
	addi.w $t1, $zero, 0
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -32
# store i32 2, i32* %op3
	ld.d $t0, $fp, -32
	addi.w $t1, $zero, 2
	st.w $t1, $t0, 0
# %op4 = icmp slt i32 1, 0
	addi.w $t0, $zero, 1
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -33
# br i1 %op4, label %label9, label %label6
	ld.b $t0, $fp, -33
	beqz $t0, .main_label6
	b .main_label9
.main_label5:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label6:
# %op7 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 1
	la.local $t0, w
	addi.w $t1, $zero, 1
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -48
# store i32 2, i32* %op7
	ld.d $t0, $fp, -48
	addi.w $t1, $zero, 2
	st.w $t1, $t0, 0
# %op8 = icmp slt i32 2, 0
	addi.w $t0, $zero, 2
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -49
# br i1 %op8, label %label13, label %label10
	ld.b $t0, $fp, -49
	beqz $t0, .main_label10
	b .main_label13
.main_label9:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label10:
# %op11 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 2
	la.local $t0, w
	addi.w $t1, $zero, 2
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -64
# store i32 6, i32* %op11
	ld.d $t0, $fp, -64
	addi.w $t1, $zero, 6
	st.w $t1, $t0, 0
# %op12 = icmp slt i32 3, 0
	addi.w $t0, $zero, 3
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -65
# br i1 %op12, label %label17, label %label14
	ld.b $t0, $fp, -65
	beqz $t0, .main_label14
	b .main_label17
.main_label13:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label14:
# %op15 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 3
	la.local $t0, w
	addi.w $t1, $zero, 3
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -80
# store i32 5, i32* %op15
	ld.d $t0, $fp, -80
	addi.w $t1, $zero, 5
	st.w $t1, $t0, 0
# %op16 = icmp slt i32 4, 0
	addi.w $t0, $zero, 4
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -81
# br i1 %op16, label %label21, label %label18
	ld.b $t0, $fp, -81
	beqz $t0, .main_label18
	b .main_label21
.main_label17:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label18:
# %op19 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 4
	la.local $t0, w
	addi.w $t1, $zero, 4
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -96
# store i32 4, i32* %op19
	ld.d $t0, $fp, -96
	addi.w $t1, $zero, 4
	st.w $t1, $t0, 0
# %op20 = icmp slt i32 0, 0
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -97
# br i1 %op20, label %label25, label %label22
	ld.b $t0, $fp, -97
	beqz $t0, .main_label22
	b .main_label25
.main_label21:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label22:
# %op23 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 0
	la.local $t0, v
	addi.w $t1, $zero, 0
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -112
# store i32 6, i32* %op23
	ld.d $t0, $fp, -112
	addi.w $t1, $zero, 6
	st.w $t1, $t0, 0
# %op24 = icmp slt i32 1, 0
	addi.w $t0, $zero, 1
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -113
# br i1 %op24, label %label29, label %label26
	ld.b $t0, $fp, -113
	beqz $t0, .main_label26
	b .main_label29
.main_label25:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label26:
# %op27 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 1
	la.local $t0, v
	addi.w $t1, $zero, 1
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -128
# store i32 3, i32* %op27
	ld.d $t0, $fp, -128
	addi.w $t1, $zero, 3
	st.w $t1, $t0, 0
# %op28 = icmp slt i32 2, 0
	addi.w $t0, $zero, 2
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -129
# br i1 %op28, label %label33, label %label30
	ld.b $t0, $fp, -129
	beqz $t0, .main_label30
	b .main_label33
.main_label29:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label30:
# %op31 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 2
	la.local $t0, v
	addi.w $t1, $zero, 2
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -144
# store i32 5, i32* %op31
	ld.d $t0, $fp, -144
	addi.w $t1, $zero, 5
	st.w $t1, $t0, 0
# %op32 = icmp slt i32 3, 0
	addi.w $t0, $zero, 3
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -145
# br i1 %op32, label %label37, label %label34
	ld.b $t0, $fp, -145
	beqz $t0, .main_label34
	b .main_label37
.main_label33:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label34:
# %op35 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 3
	la.local $t0, v
	addi.w $t1, $zero, 3
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -160
# store i32 4, i32* %op35
	ld.d $t0, $fp, -160
	addi.w $t1, $zero, 4
	st.w $t1, $t0, 0
# %op36 = icmp slt i32 4, 0
	addi.w $t0, $zero, 4
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -161
# br i1 %op36, label %label40, label %label38
	ld.b $t0, $fp, -161
	beqz $t0, .main_label38
	b .main_label40
.main_label37:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label38:
# %op39 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 4
	la.local $t0, v
	addi.w $t1, $zero, 4
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -176
# store i32 6, i32* %op39
	ld.d $t0, $fp, -176
	addi.w $t1, $zero, 6
	st.w $t1, $t0, 0
# br label %label41
	addi.w $t0, $zero, 0
	st.w $t0, $fp, -180
	b .main_label41
.main_label40:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label41:
# %op59 = phi i32 [ 0, %label38 ], [ %op57, %label54 ]
# %op43 = icmp slt i32 %op59, 66
	ld.w $t0, $fp, -180
	addi.w $t1, $zero, 66
	slt $t2, $t0, $t1
	st.b $t2, $fp, -181
# %op44 = zext i1 %op43 to i32
	ld.b $t0, $fp, -181
	bstrpick.w $t1, $t0, 7, 0
	st.w $t1, $fp, -188
# %op45 = icmp ne i32 %op44, 0
	ld.w $t0, $fp, -188
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -189
# br i1 %op45, label %label46, label %label50
	ld.b $t0, $fp, -189
	beqz $t0, .main_label50
	b .main_label46
.main_label46:
# %op47 = sub i32 0, 1
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -196
# %op49 = icmp slt i32 %op59, 0
	ld.w $t0, $fp, -180
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -197
# br i1 %op49, label %label58, label %label54
	ld.b $t0, $fp, -197
	beqz $t0, .main_label54
	b .main_label58
.main_label50:
# %op51 = load i32, i32* @n
	la.local $t0, n
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -204
# %op52 = load i32, i32* @m
	la.local $t0, m
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -208
# %op53 = call i32 @knapsack(i32 %op51, i32 %op52)
	ld.w $a0, $fp, -204
	ld.w $a1, $fp, -208
	bl knapsack
	st.w $a0, $fp, -212
# call void @output(i32 %op53)
	ld.w $a0, $fp, -212
	bl output
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label54:
# %op55 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op59
	la.local $t0, dp
	ld.w $t1, $fp, -180
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -224
# store i32 %op47, i32* %op55
	ld.d $t0, $fp, -224
	ld.w $t1, $fp, -196
	st.w $t1, $t0, 0
# %op57 = add i32 %op59, 1
	ld.w $t0, $fp, -180
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -228
# br label %label41
	ld.w $t0, $fp, -228
	st.w $t0, $fp, -180
	b .main_label41
.main_label58:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 240
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
