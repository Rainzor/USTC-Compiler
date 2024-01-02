# Global variables
	.text
	.section .bss, "aw", @nobits
	.globl matrix
	.type matrix, @object
	.size matrix, 80000000
matrix:
	.space 80000000
	.globl ad
	.type ad, @object
	.size ad, 400000
ad:
	.space 400000
	.globl len
	.type len, @object
	.size len, 4
len:
	.space 4
	.text
	.globl readarray
	.type readarray, @function
readarray:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -64
.readarray_label_entry:
# br label %label1
	addi.w $t0, $zero, 0
	st.w $t0, $fp, -20
	b .readarray_label1
.readarray_label1:
# %op17 = phi i32 [ 0, %label_entry ], [ %op15, %label12 ]
# %op3 = load i32, i32* @len
	la.local $t0, len
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -24
# %op4 = icmp slt i32 %op17, %op3
	ld.w $t0, $fp, -20
	ld.w $t1, $fp, -24
	slt $t2, $t0, $t1
	st.b $t2, $fp, -25
# %op5 = zext i1 %op4 to i32
	ld.b $t0, $fp, -25
	bstrpick.w $t1, $t0, 7, 0
	st.w $t1, $fp, -32
# %op6 = icmp ne i32 %op5, 0
	ld.w $t0, $fp, -32
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -33
# br i1 %op6, label %label7, label %label11
	ld.b $t0, $fp, -33
	beqz $t0, .readarray_label11
	b .readarray_label7
.readarray_label7:
# %op8 = call i32 @input()
	bl input
	st.w $a0, $fp, -40
# %op10 = icmp slt i32 %op17, 0
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -41
# br i1 %op10, label %label16, label %label12
	ld.b $t0, $fp, -41
	beqz $t0, .readarray_label12
	b .readarray_label16
.readarray_label11:
# ret void
	addi.w $a0, $zero, 0
	b readarray_exit
.readarray_label12:
# %op13 = getelementptr [100000 x i32], [100000 x i32]* @ad, i32 0, i32 %op17
	la.local $t0, ad
	ld.w $t1, $fp, -20
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -56
# store i32 %op8, i32* %op13
	ld.d $t0, $fp, -56
	ld.w $t1, $fp, -40
	st.w $t1, $t0, 0
# %op15 = add i32 %op17, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -60
# br label %label1
	ld.w $t0, $fp, -60
	st.w $t0, $fp, -20
	b .readarray_label1
.readarray_label16:
# call void @neg_idx_except()
	bl neg_idx_except
# ret void
	addi.w $a0, $zero, 0
	b readarray_exit
readarray_exit:
	addi.d $sp, $sp, 64
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl transpose
	.type transpose, @function
transpose:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -208
	st.w $a0, $fp, -20
	st.d $a1, $fp, -32
	st.w $a2, $fp, -36
.transpose_label_entry:
# %op12 = sdiv i32 %arg0, %arg2
	ld.w $t0, $fp, -20
	ld.w $t1, $fp, -36
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -40
# br label %label13
	addi.w $t0, $zero, 0
	st.w $t0, $fp, -44
	b .transpose_label13
.transpose_label13:
# %op87 = phi i32 [ 0, %label_entry ], [ %op36, %label34 ]
# %op16 = icmp slt i32 %op87, %op12
	ld.w $t0, $fp, -44
	ld.w $t1, $fp, -40
	slt $t2, $t0, $t1
	st.b $t2, $fp, -45
# %op17 = zext i1 %op16 to i32
	ld.b $t0, $fp, -45
	bstrpick.w $t1, $t0, 7, 0
	st.w $t1, $fp, -52
# %op18 = icmp ne i32 %op17, 0
	ld.w $t0, $fp, -52
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -53
# br i1 %op18, label %label19, label %label20
	ld.b $t0, $fp, -53
	beqz $t0, .transpose_label20
	b .transpose_label19
.transpose_label19:
# br label %label22
	addi.w $t0, $zero, 0
	st.w $t0, $fp, -64
	b .transpose_label22
.transpose_label20:
# %op21 = sub i32 0, 1
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -60
# ret i32 %op21
	ld.w $a0, $fp, -60
	b transpose_exit
.transpose_label22:
# %op88 = phi i32 [ 0, %label19 ], [ %op89, %label47 ]
# %op25 = icmp slt i32 %op88, %arg2
	ld.w $t0, $fp, -64
	ld.w $t1, $fp, -36
	slt $t2, $t0, $t1
	st.b $t2, $fp, -65
# %op26 = zext i1 %op25 to i32
	ld.b $t0, $fp, -65
	bstrpick.w $t1, $t0, 7, 0
	st.w $t1, $fp, -72
# %op27 = icmp ne i32 %op26, 0
	ld.w $t0, $fp, -72
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -73
# br i1 %op27, label %label28, label %label34
	ld.b $t0, $fp, -73
	beqz $t0, .transpose_label34
	b .transpose_label28
.transpose_label28:
# %op31 = icmp slt i32 %op87, %op88
	ld.w $t0, $fp, -44
	ld.w $t1, $fp, -64
	slt $t2, $t0, $t1
	st.b $t2, $fp, -74
# %op32 = zext i1 %op31 to i32
	ld.b $t0, $fp, -74
	bstrpick.w $t1, $t0, 7, 0
	st.w $t1, $fp, -80
# %op33 = icmp ne i32 %op32, 0
	ld.w $t0, $fp, -80
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -81
# br i1 %op33, label %label37, label %label40
	ld.b $t0, $fp, -81
	beqz $t0, .transpose_label40
	b .transpose_label37
.transpose_label34:
# %op36 = add i32 %op87, 1
	ld.w $t0, $fp, -44
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -88
# br label %label13
	ld.w $t0, $fp, -88
	st.w $t0, $fp, -44
	b .transpose_label13
.transpose_label37:
# %op39 = add i32 %op88, 1
	ld.w $t0, $fp, -64
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -92
# br label %label47
	ld.w $t0, $fp, -92
	st.w $t0, $fp, -108
	b .transpose_label47
.transpose_label40:
# %op43 = mul i32 %op87, %arg2
	ld.w $t0, $fp, -44
	ld.w $t1, $fp, -36
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -96
# %op45 = add i32 %op43, %op88
	ld.w $t0, $fp, -96
	ld.w $t1, $fp, -64
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -100
# %op46 = icmp slt i32 %op45, 0
	ld.w $t0, $fp, -100
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -101
# br i1 %op46, label %label58, label %label48
	ld.b $t0, $fp, -101
	beqz $t0, .transpose_label48
	b .transpose_label58
.transpose_label47:
# %op89 = phi i32 [ %op39, %label37 ], [ %op85, %label81 ]
# br label %label22
	ld.w $t0, $fp, -108
	st.w $t0, $fp, -64
	b .transpose_label22
.transpose_label48:
# %op50 = getelementptr i32, i32* %arg1, i32 %op45
	ld.d $t0, $fp, -32
	ld.w $t1, $fp, -100
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -120
# %op51 = load i32, i32* %op50
	ld.d $t0, $fp, -120
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -124
# %op54 = mul i32 %op87, %arg2
	ld.w $t0, $fp, -44
	ld.w $t1, $fp, -36
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -128
# %op56 = add i32 %op54, %op88
	ld.w $t0, $fp, -128
	ld.w $t1, $fp, -64
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -132
# %op57 = icmp slt i32 %op56, 0
	ld.w $t0, $fp, -132
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -133
# br i1 %op57, label %label69, label %label59
	ld.b $t0, $fp, -133
	beqz $t0, .transpose_label59
	b .transpose_label69
.transpose_label58:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b transpose_exit
.transpose_label59:
# %op61 = getelementptr i32, i32* %arg1, i32 %op56
	ld.d $t0, $fp, -32
	ld.w $t1, $fp, -132
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -144
# %op62 = load i32, i32* %op61
	ld.d $t0, $fp, -144
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -148
# %op65 = mul i32 %op88, %op12
	ld.w $t0, $fp, -64
	ld.w $t1, $fp, -40
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -152
# %op67 = add i32 %op65, %op87
	ld.w $t0, $fp, -152
	ld.w $t1, $fp, -44
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -156
# %op68 = icmp slt i32 %op67, 0
	ld.w $t0, $fp, -156
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -157
# br i1 %op68, label %label80, label %label70
	ld.b $t0, $fp, -157
	beqz $t0, .transpose_label70
	b .transpose_label80
.transpose_label69:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b transpose_exit
.transpose_label70:
# %op72 = getelementptr i32, i32* %arg1, i32 %op67
	ld.d $t0, $fp, -32
	ld.w $t1, $fp, -156
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -168
# store i32 %op62, i32* %op72
	ld.d $t0, $fp, -168
	ld.w $t1, $fp, -148
	st.w $t1, $t0, 0
# %op76 = mul i32 %op87, %arg2
	ld.w $t0, $fp, -44
	ld.w $t1, $fp, -36
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -172
# %op78 = add i32 %op76, %op88
	ld.w $t0, $fp, -172
	ld.w $t1, $fp, -64
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -176
# %op79 = icmp slt i32 %op78, 0
	ld.w $t0, $fp, -176
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -177
# br i1 %op79, label %label86, label %label81
	ld.b $t0, $fp, -177
	beqz $t0, .transpose_label81
	b .transpose_label86
.transpose_label80:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b transpose_exit
.transpose_label81:
# %op83 = getelementptr i32, i32* %arg1, i32 %op78
	ld.d $t0, $fp, -32
	ld.w $t1, $fp, -176
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -192
# store i32 %op51, i32* %op83
	ld.d $t0, $fp, -192
	ld.w $t1, $fp, -124
	st.w $t1, $t0, 0
# %op85 = add i32 %op88, 1
	ld.w $t0, $fp, -64
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -196
# br label %label47
	ld.w $t0, $fp, -196
	st.w $t0, $fp, -108
	b .transpose_label47
.transpose_label86:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b transpose_exit
transpose_exit:
	addi.d $sp, $sp, 208
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -192
.main_label_entry:
# %op3 = call i32 @input()
	bl input
	st.w $a0, $fp, -20
# %op4 = call i32 @input()
	bl input
	st.w $a0, $fp, -24
# store i32 %op4, i32* @len
	la.local $t0, len
	ld.w $t1, $fp, -24
	st.w $t1, $t0, 0
# call void @readarray()
	bl readarray
# br label %label5
	addi.w $t0, $zero, 0
	st.w $t0, $fp, -28
	b .main_label5
.main_label5:
# %op71 = phi i32 [ 0, %label_entry ], [ %op19, %label16 ]
# %op8 = icmp slt i32 %op71, %op3
	ld.w $t0, $fp, -28
	ld.w $t1, $fp, -20
	slt $t2, $t0, $t1
	st.b $t2, $fp, -29
# %op9 = zext i1 %op8 to i32
	ld.b $t0, $fp, -29
	bstrpick.w $t1, $t0, 7, 0
	st.w $t1, $fp, -36
# %op10 = icmp ne i32 %op9, 0
	ld.w $t0, $fp, -36
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -37
# br i1 %op10, label %label11, label %label15
	ld.b $t0, $fp, -37
	beqz $t0, .main_label15
	b .main_label11
.main_label11:
# %op14 = icmp slt i32 %op71, 0
	ld.w $t0, $fp, -28
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -38
# br i1 %op14, label %label20, label %label16
	ld.b $t0, $fp, -38
	beqz $t0, .main_label16
	b .main_label20
.main_label15:
# br label %label21
	addi.w $t0, $zero, 0
	st.w $t0, $fp, -56
	b .main_label21
.main_label16:
# %op17 = getelementptr [20000000 x i32], [20000000 x i32]* @matrix, i32 0, i32 %op71
	la.local $t0, matrix
	ld.w $t1, $fp, -28
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -48
# store i32 %op71, i32* %op17
	ld.d $t0, $fp, -48
	ld.w $t1, $fp, -28
	st.w $t1, $t0, 0
# %op19 = add i32 %op71, 1
	ld.w $t0, $fp, -28
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -52
# br label %label5
	ld.w $t0, $fp, -52
	st.w $t0, $fp, -28
	b .main_label5
.main_label20:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label21:
# %op72 = phi i32 [ 0, %label15 ], [ %op38, %label33 ]
# %op23 = load i32, i32* @len
	la.local $t0, len
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -60
# %op24 = icmp slt i32 %op72, %op23
	ld.w $t0, $fp, -56
	ld.w $t1, $fp, -60
	slt $t2, $t0, $t1
	st.b $t2, $fp, -61
# %op25 = zext i1 %op24 to i32
	ld.b $t0, $fp, -61
	bstrpick.w $t1, $t0, 7, 0
	st.w $t1, $fp, -68
# %op26 = icmp ne i32 %op25, 0
	ld.w $t0, $fp, -68
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -69
# br i1 %op26, label %label27, label %label32
	ld.b $t0, $fp, -69
	beqz $t0, .main_label32
	b .main_label27
.main_label27:
# %op29 = getelementptr [20000000 x i32], [20000000 x i32]* @matrix, i32 0, i32 0
	la.local $t0, matrix
	addi.w $t1, $zero, 0
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -80
# %op31 = icmp slt i32 %op72, 0
	ld.w $t0, $fp, -56
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -81
# br i1 %op31, label %label39, label %label33
	ld.b $t0, $fp, -81
	beqz $t0, .main_label33
	b .main_label39
.main_label32:
# br label %label40
	addi.w $t0, $zero, 0
	st.w $t0, $fp, -112
	addi.w $t0, $zero, 0
	st.w $t0, $fp, -116
	b .main_label40
.main_label33:
# %op34 = getelementptr [100000 x i32], [100000 x i32]* @ad, i32 0, i32 %op72
	la.local $t0, ad
	ld.w $t1, $fp, -56
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -96
# %op35 = load i32, i32* %op34
	ld.d $t0, $fp, -96
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -100
# %op36 = call i32 @transpose(i32 %op3, i32* %op29, i32 %op35)
	ld.w $a0, $fp, -20
	ld.d $a1, $fp, -80
	ld.w $a2, $fp, -100
	bl transpose
	st.w $a0, $fp, -104
# %op38 = add i32 %op72, 1
	ld.w $t0, $fp, -56
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -108
# br label %label21
	ld.w $t0, $fp, -108
	st.w $t0, $fp, -56
	b .main_label21
.main_label39:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label40:
# %op73 = phi i32 [ 0, %label32 ], [ %op64, %label58 ]
# %op74 = phi i32 [ 0, %label32 ], [ %op62, %label58 ]
# %op42 = load i32, i32* @len
	la.local $t0, len
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -120
# %op43 = icmp slt i32 %op73, %op42
	ld.w $t0, $fp, -112
	ld.w $t1, $fp, -120
	slt $t2, $t0, $t1
	st.b $t2, $fp, -121
# %op44 = zext i1 %op43 to i32
	ld.b $t0, $fp, -121
	bstrpick.w $t1, $t0, 7, 0
	st.w $t1, $fp, -128
# %op45 = icmp ne i32 %op44, 0
	ld.w $t0, $fp, -128
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -129
# br i1 %op45, label %label46, label %label53
	ld.b $t0, $fp, -129
	beqz $t0, .main_label53
	b .main_label46
.main_label46:
# %op50 = mul i32 %op73, %op73
	ld.w $t0, $fp, -112
	ld.w $t1, $fp, -112
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -136
# %op52 = icmp slt i32 %op73, 0
	ld.w $t0, $fp, -112
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -137
# br i1 %op52, label %label65, label %label58
	ld.b $t0, $fp, -137
	beqz $t0, .main_label58
	b .main_label65
.main_label53:
# %op55 = icmp slt i32 %op74, 0
	ld.w $t0, $fp, -116
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -138
# %op56 = zext i1 %op55 to i32
	ld.b $t0, $fp, -138
	bstrpick.w $t1, $t0, 7, 0
	st.w $t1, $fp, -144
# %op57 = icmp ne i32 %op56, 0
	ld.w $t0, $fp, -144
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -145
# br i1 %op57, label %label66, label %label69
	ld.b $t0, $fp, -145
	ld.w $t0, $fp, -116
	st.w $t0, $fp, -184
	beqz $t0, .main_label69
	b .main_label66
.main_label58:
# %op59 = getelementptr [20000000 x i32], [20000000 x i32]* @matrix, i32 0, i32 %op73
	la.local $t0, matrix
	ld.w $t1, $fp, -112
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -160
# %op60 = load i32, i32* %op59
	ld.d $t0, $fp, -160
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -164
# %op61 = mul i32 %op50, %op60
	ld.w $t0, $fp, -136
	ld.w $t1, $fp, -164
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -168
# %op62 = add i32 %op74, %op61
	ld.w $t0, $fp, -116
	ld.w $t1, $fp, -168
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -172
# %op64 = add i32 %op73, 1
	ld.w $t0, $fp, -112
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -176
# br label %label40
	ld.w $t0, $fp, -176
	st.w $t0, $fp, -112
	ld.w $t0, $fp, -172
	st.w $t0, $fp, -116
	b .main_label40
.main_label65:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label66:
# %op68 = sub i32 0, %op74
	addi.w $t0, $zero, 0
	ld.w $t1, $fp, -116
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -180
# br label %label69
	ld.w $t0, $fp, -180
	st.w $t0, $fp, -184
	b .main_label69
.main_label69:
# %op75 = phi i32 [ %op74, %label53 ], [ %op68, %label66 ]
# call void @output(i32 %op75)
	ld.w $a0, $fp, -184
	bl output
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 192
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
