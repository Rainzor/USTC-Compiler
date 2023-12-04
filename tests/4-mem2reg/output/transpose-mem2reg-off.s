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
	addi.d $sp, $sp, -80
.readarray_label_entry:
# %op0 = alloca i32
	addi.d $t0, $fp, -28
	st.d $t0, $fp, -24
# store i32 0, i32* %op0
	ld.d $t0, $fp, -24
	addi.w $t1, $zero, 0
	st.w $t1, $t0, 0
# br label %label1
	b .readarray_label1
.readarray_label1:
# %op2 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -32
# %op3 = load i32, i32* @len
	la.local $t0, len
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -36
# %op4 = icmp slt i32 %op2, %op3
	ld.w $t0, $fp, -32
	ld.w $t1, $fp, -36
	slt $t2, $t0, $t1
	st.b $t2, $fp, -37
# %op5 = zext i1 %op4 to i32
	ld.b $t0, $fp, -37
	bstrpick.w $t1, $t0, 7, 0
	st.w $t1, $fp, -44
# %op6 = icmp ne i32 %op5, 0
	ld.w $t0, $fp, -44
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -45
# br i1 %op6, label %label7, label %label11
	ld.b $t0, $fp, -45
	beqz $t0, .readarray_label11
	b .readarray_label7
.readarray_label7:
# %op8 = call i32 @input()
	bl input
	st.w $a0, $fp, -52
# %op9 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -56
# %op10 = icmp slt i32 %op9, 0
	ld.w $t0, $fp, -56
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -57
# br i1 %op10, label %label16, label %label12
	ld.b $t0, $fp, -57
	beqz $t0, .readarray_label12
	b .readarray_label16
.readarray_label11:
# ret void
	addi.w $a0, $zero, 0
	b readarray_exit
.readarray_label12:
# %op13 = getelementptr [100000 x i32], [100000 x i32]* @ad, i32 0, i32 %op9
	la.local $t0, ad
	ld.w $t1, $fp, -56
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -72
# store i32 %op8, i32* %op13
	ld.d $t0, $fp, -72
	ld.w $t1, $fp, -52
	st.w $t1, $t0, 0
# %op14 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -76
# %op15 = add i32 %op14, 1
	ld.w $t0, $fp, -76
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -80
# store i32 %op15, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t1, $fp, -80
	st.w $t1, $t0, 0
# br label %label1
	b .readarray_label1
.readarray_label16:
# call void @neg_idx_except()
	bl neg_idx_except
# ret void
	addi.w $a0, $zero, 0
	b readarray_exit
readarray_exit:
	addi.d $sp, $sp, 80
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl transpose
	.type transpose, @function
transpose:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -432
	st.w $a0, $fp, -20
	st.d $a1, $fp, -32
	st.w $a2, $fp, -36
.transpose_label_entry:
# %op3 = alloca i32
	addi.d $t0, $fp, -52
	st.d $t0, $fp, -48
# store i32 %arg0, i32* %op3
	ld.d $t0, $fp, -48
	ld.w $t1, $fp, -20
	st.w $t1, $t0, 0
# %op4 = alloca i32*
	addi.d $t0, $fp, -72
	st.d $t0, $fp, -64
# store i32* %arg1, i32** %op4
	ld.d $t0, $fp, -64
	ld.d $t1, $fp, -32
	st.d $t1, $t0, 0
# %op5 = alloca i32
	addi.d $t0, $fp, -84
	st.d $t0, $fp, -80
# store i32 %arg2, i32* %op5
	ld.d $t0, $fp, -80
	ld.w $t1, $fp, -36
	st.w $t1, $t0, 0
# %op6 = alloca i32
	addi.d $t0, $fp, -100
	st.d $t0, $fp, -96
# %op7 = alloca i32
	addi.d $t0, $fp, -116
	st.d $t0, $fp, -112
# %op8 = alloca i32
	addi.d $t0, $fp, -132
	st.d $t0, $fp, -128
# %op9 = alloca i32
	addi.d $t0, $fp, -148
	st.d $t0, $fp, -144
# %op10 = load i32, i32* %op3
	ld.d $t0, $fp, -48
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -152
# %op11 = load i32, i32* %op5
	ld.d $t0, $fp, -80
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -156
# %op12 = sdiv i32 %op10, %op11
	ld.w $t0, $fp, -152
	ld.w $t1, $fp, -156
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -160
# store i32 %op12, i32* %op6
	ld.d $t0, $fp, -96
	ld.w $t1, $fp, -160
	st.w $t1, $t0, 0
# store i32 0, i32* %op7
	ld.d $t0, $fp, -112
	addi.w $t1, $zero, 0
	st.w $t1, $t0, 0
# store i32 0, i32* %op8
	ld.d $t0, $fp, -128
	addi.w $t1, $zero, 0
	st.w $t1, $t0, 0
# br label %label13
	b .transpose_label13
.transpose_label13:
# %op14 = load i32, i32* %op7
	ld.d $t0, $fp, -112
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -164
# %op15 = load i32, i32* %op6
	ld.d $t0, $fp, -96
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -168
# %op16 = icmp slt i32 %op14, %op15
	ld.w $t0, $fp, -164
	ld.w $t1, $fp, -168
	slt $t2, $t0, $t1
	st.b $t2, $fp, -169
# %op17 = zext i1 %op16 to i32
	ld.b $t0, $fp, -169
	bstrpick.w $t1, $t0, 7, 0
	st.w $t1, $fp, -176
# %op18 = icmp ne i32 %op17, 0
	ld.w $t0, $fp, -176
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -177
# br i1 %op18, label %label19, label %label20
	ld.b $t0, $fp, -177
	beqz $t0, .transpose_label20
	b .transpose_label19
.transpose_label19:
# store i32 0, i32* %op8
	ld.d $t0, $fp, -128
	addi.w $t1, $zero, 0
	st.w $t1, $t0, 0
# br label %label22
	b .transpose_label22
.transpose_label20:
# %op21 = sub i32 0, 1
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -184
# ret i32 %op21
	ld.w $a0, $fp, -184
	b transpose_exit
.transpose_label22:
# %op23 = load i32, i32* %op8
	ld.d $t0, $fp, -128
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -188
# %op24 = load i32, i32* %op5
	ld.d $t0, $fp, -80
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -192
# %op25 = icmp slt i32 %op23, %op24
	ld.w $t0, $fp, -188
	ld.w $t1, $fp, -192
	slt $t2, $t0, $t1
	st.b $t2, $fp, -193
# %op26 = zext i1 %op25 to i32
	ld.b $t0, $fp, -193
	bstrpick.w $t1, $t0, 7, 0
	st.w $t1, $fp, -200
# %op27 = icmp ne i32 %op26, 0
	ld.w $t0, $fp, -200
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -201
# br i1 %op27, label %label28, label %label34
	ld.b $t0, $fp, -201
	beqz $t0, .transpose_label34
	b .transpose_label28
.transpose_label28:
# %op29 = load i32, i32* %op7
	ld.d $t0, $fp, -112
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -208
# %op30 = load i32, i32* %op8
	ld.d $t0, $fp, -128
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -212
# %op31 = icmp slt i32 %op29, %op30
	ld.w $t0, $fp, -208
	ld.w $t1, $fp, -212
	slt $t2, $t0, $t1
	st.b $t2, $fp, -213
# %op32 = zext i1 %op31 to i32
	ld.b $t0, $fp, -213
	bstrpick.w $t1, $t0, 7, 0
	st.w $t1, $fp, -220
# %op33 = icmp ne i32 %op32, 0
	ld.w $t0, $fp, -220
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -221
# br i1 %op33, label %label37, label %label40
	ld.b $t0, $fp, -221
	beqz $t0, .transpose_label40
	b .transpose_label37
.transpose_label34:
# %op35 = load i32, i32* %op7
	ld.d $t0, $fp, -112
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -228
# %op36 = add i32 %op35, 1
	ld.w $t0, $fp, -228
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -232
# store i32 %op36, i32* %op7
	ld.d $t0, $fp, -112
	ld.w $t1, $fp, -232
	st.w $t1, $t0, 0
# br label %label13
	b .transpose_label13
.transpose_label37:
# %op38 = load i32, i32* %op8
	ld.d $t0, $fp, -128
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -236
# %op39 = add i32 %op38, 1
	ld.w $t0, $fp, -236
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -240
# store i32 %op39, i32* %op8
	ld.d $t0, $fp, -128
	ld.w $t1, $fp, -240
	st.w $t1, $t0, 0
# br label %label47
	b .transpose_label47
.transpose_label40:
# %op41 = load i32, i32* %op7
	ld.d $t0, $fp, -112
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -244
# %op42 = load i32, i32* %op5
	ld.d $t0, $fp, -80
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -248
# %op43 = mul i32 %op41, %op42
	ld.w $t0, $fp, -244
	ld.w $t1, $fp, -248
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -252
# %op44 = load i32, i32* %op8
	ld.d $t0, $fp, -128
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -256
# %op45 = add i32 %op43, %op44
	ld.w $t0, $fp, -252
	ld.w $t1, $fp, -256
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -260
# %op46 = icmp slt i32 %op45, 0
	ld.w $t0, $fp, -260
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -261
# br i1 %op46, label %label58, label %label48
	ld.b $t0, $fp, -261
	beqz $t0, .transpose_label48
	b .transpose_label58
.transpose_label47:
# br label %label22
	b .transpose_label22
.transpose_label48:
# %op49 = load i32*, i32** %op4
	ld.d $t0, $fp, -64
	ld.d $t1, $t0, 0
	st.d $t1, $fp, -272
# %op50 = getelementptr i32, i32* %op49, i32 %op45
	ld.d $t0, $fp, -272
	ld.w $t1, $fp, -260
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -280
# %op51 = load i32, i32* %op50
	ld.d $t0, $fp, -280
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -284
# store i32 %op51, i32* %op9
	ld.d $t0, $fp, -144
	ld.w $t1, $fp, -284
	st.w $t1, $t0, 0
# %op52 = load i32, i32* %op7
	ld.d $t0, $fp, -112
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -288
# %op53 = load i32, i32* %op5
	ld.d $t0, $fp, -80
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -292
# %op54 = mul i32 %op52, %op53
	ld.w $t0, $fp, -288
	ld.w $t1, $fp, -292
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -296
# %op55 = load i32, i32* %op8
	ld.d $t0, $fp, -128
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -300
# %op56 = add i32 %op54, %op55
	ld.w $t0, $fp, -296
	ld.w $t1, $fp, -300
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -304
# %op57 = icmp slt i32 %op56, 0
	ld.w $t0, $fp, -304
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -305
# br i1 %op57, label %label69, label %label59
	ld.b $t0, $fp, -305
	beqz $t0, .transpose_label59
	b .transpose_label69
.transpose_label58:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b transpose_exit
.transpose_label59:
# %op60 = load i32*, i32** %op4
	ld.d $t0, $fp, -64
	ld.d $t1, $t0, 0
	st.d $t1, $fp, -320
# %op61 = getelementptr i32, i32* %op60, i32 %op56
	ld.d $t0, $fp, -320
	ld.w $t1, $fp, -304
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -328
# %op62 = load i32, i32* %op61
	ld.d $t0, $fp, -328
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -332
# %op63 = load i32, i32* %op8
	ld.d $t0, $fp, -128
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -336
# %op64 = load i32, i32* %op6
	ld.d $t0, $fp, -96
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -340
# %op65 = mul i32 %op63, %op64
	ld.w $t0, $fp, -336
	ld.w $t1, $fp, -340
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -344
# %op66 = load i32, i32* %op7
	ld.d $t0, $fp, -112
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -348
# %op67 = add i32 %op65, %op66
	ld.w $t0, $fp, -344
	ld.w $t1, $fp, -348
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -352
# %op68 = icmp slt i32 %op67, 0
	ld.w $t0, $fp, -352
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -353
# br i1 %op68, label %label80, label %label70
	ld.b $t0, $fp, -353
	beqz $t0, .transpose_label70
	b .transpose_label80
.transpose_label69:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b transpose_exit
.transpose_label70:
# %op71 = load i32*, i32** %op4
	ld.d $t0, $fp, -64
	ld.d $t1, $t0, 0
	st.d $t1, $fp, -368
# %op72 = getelementptr i32, i32* %op71, i32 %op67
	ld.d $t0, $fp, -368
	ld.w $t1, $fp, -352
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -376
# store i32 %op62, i32* %op72
	ld.d $t0, $fp, -376
	ld.w $t1, $fp, -332
	st.w $t1, $t0, 0
# %op73 = load i32, i32* %op9
	ld.d $t0, $fp, -144
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -380
# %op74 = load i32, i32* %op7
	ld.d $t0, $fp, -112
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -384
# %op75 = load i32, i32* %op5
	ld.d $t0, $fp, -80
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -388
# %op76 = mul i32 %op74, %op75
	ld.w $t0, $fp, -384
	ld.w $t1, $fp, -388
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -392
# %op77 = load i32, i32* %op8
	ld.d $t0, $fp, -128
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -396
# %op78 = add i32 %op76, %op77
	ld.w $t0, $fp, -392
	ld.w $t1, $fp, -396
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -400
# %op79 = icmp slt i32 %op78, 0
	ld.w $t0, $fp, -400
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -401
# br i1 %op79, label %label86, label %label81
	ld.b $t0, $fp, -401
	beqz $t0, .transpose_label81
	b .transpose_label86
.transpose_label80:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b transpose_exit
.transpose_label81:
# %op82 = load i32*, i32** %op4
	ld.d $t0, $fp, -64
	ld.d $t1, $t0, 0
	st.d $t1, $fp, -416
# %op83 = getelementptr i32, i32* %op82, i32 %op78
	ld.d $t0, $fp, -416
	ld.w $t1, $fp, -400
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -424
# store i32 %op73, i32* %op83
	ld.d $t0, $fp, -424
	ld.w $t1, $fp, -380
	st.w $t1, $t0, 0
# %op84 = load i32, i32* %op8
	ld.d $t0, $fp, -128
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -428
# %op85 = add i32 %op84, 1
	ld.w $t0, $fp, -428
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -432
# store i32 %op85, i32* %op8
	ld.d $t0, $fp, -128
	ld.w $t1, $fp, -432
	st.w $t1, $t0, 0
# br label %label47
	b .transpose_label47
.transpose_label86:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b transpose_exit
transpose_exit:
	addi.d $sp, $sp, 432
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -288
.main_label_entry:
# %op0 = alloca i32
	addi.d $t0, $fp, -28
	st.d $t0, $fp, -24
# %op1 = alloca i32
	addi.d $t0, $fp, -44
	st.d $t0, $fp, -40
# %op2 = alloca i32
	addi.d $t0, $fp, -60
	st.d $t0, $fp, -56
# %op3 = call i32 @input()
	bl input
	st.w $a0, $fp, -64
# store i32 %op3, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t1, $fp, -64
	st.w $t1, $t0, 0
# %op4 = call i32 @input()
	bl input
	st.w $a0, $fp, -68
# store i32 %op4, i32* @len
	la.local $t0, len
	ld.w $t1, $fp, -68
	st.w $t1, $t0, 0
# call void @readarray()
	bl readarray
# store i32 0, i32* %op1
	ld.d $t0, $fp, -40
	addi.w $t1, $zero, 0
	st.w $t1, $t0, 0
# br label %label5
	b .main_label5
.main_label5:
# %op6 = load i32, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -72
# %op7 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -76
# %op8 = icmp slt i32 %op6, %op7
	ld.w $t0, $fp, -72
	ld.w $t1, $fp, -76
	slt $t2, $t0, $t1
	st.b $t2, $fp, -77
# %op9 = zext i1 %op8 to i32
	ld.b $t0, $fp, -77
	bstrpick.w $t1, $t0, 7, 0
	st.w $t1, $fp, -84
# %op10 = icmp ne i32 %op9, 0
	ld.w $t0, $fp, -84
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -85
# br i1 %op10, label %label11, label %label15
	ld.b $t0, $fp, -85
	beqz $t0, .main_label15
	b .main_label11
.main_label11:
# %op12 = load i32, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -92
# %op13 = load i32, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -96
# %op14 = icmp slt i32 %op13, 0
	ld.w $t0, $fp, -96
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -97
# br i1 %op14, label %label20, label %label16
	ld.b $t0, $fp, -97
	beqz $t0, .main_label16
	b .main_label20
.main_label15:
# store i32 0, i32* %op1
	ld.d $t0, $fp, -40
	addi.w $t1, $zero, 0
	st.w $t1, $t0, 0
# br label %label21
	b .main_label21
.main_label16:
# %op17 = getelementptr [20000000 x i32], [20000000 x i32]* @matrix, i32 0, i32 %op13
	la.local $t0, matrix
	ld.w $t1, $fp, -96
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -112
# store i32 %op12, i32* %op17
	ld.d $t0, $fp, -112
	ld.w $t1, $fp, -92
	st.w $t1, $t0, 0
# %op18 = load i32, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -116
# %op19 = add i32 %op18, 1
	ld.w $t0, $fp, -116
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -120
# store i32 %op19, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t1, $fp, -120
	st.w $t1, $t0, 0
# br label %label5
	b .main_label5
.main_label20:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label21:
# %op22 = load i32, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -124
# %op23 = load i32, i32* @len
	la.local $t0, len
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -128
# %op24 = icmp slt i32 %op22, %op23
	ld.w $t0, $fp, -124
	ld.w $t1, $fp, -128
	slt $t2, $t0, $t1
	st.b $t2, $fp, -129
# %op25 = zext i1 %op24 to i32
	ld.b $t0, $fp, -129
	bstrpick.w $t1, $t0, 7, 0
	st.w $t1, $fp, -136
# %op26 = icmp ne i32 %op25, 0
	ld.w $t0, $fp, -136
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -137
# br i1 %op26, label %label27, label %label32
	ld.b $t0, $fp, -137
	beqz $t0, .main_label32
	b .main_label27
.main_label27:
# %op28 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -144
# %op29 = getelementptr [20000000 x i32], [20000000 x i32]* @matrix, i32 0, i32 0
	la.local $t0, matrix
	addi.w $t1, $zero, 0
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -152
# %op30 = load i32, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -156
# %op31 = icmp slt i32 %op30, 0
	ld.w $t0, $fp, -156
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -157
# br i1 %op31, label %label39, label %label33
	ld.b $t0, $fp, -157
	beqz $t0, .main_label33
	b .main_label39
.main_label32:
# store i32 0, i32* %op2
	ld.d $t0, $fp, -56
	addi.w $t1, $zero, 0
	st.w $t1, $t0, 0
# store i32 0, i32* %op1
	ld.d $t0, $fp, -40
	addi.w $t1, $zero, 0
	st.w $t1, $t0, 0
# br label %label40
	b .main_label40
.main_label33:
# %op34 = getelementptr [100000 x i32], [100000 x i32]* @ad, i32 0, i32 %op30
	la.local $t0, ad
	ld.w $t1, $fp, -156
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -168
# %op35 = load i32, i32* %op34
	ld.d $t0, $fp, -168
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -172
# %op36 = call i32 @transpose(i32 %op28, i32* %op29, i32 %op35)
	ld.w $a0, $fp, -144
	ld.d $a1, $fp, -152
	ld.w $a2, $fp, -172
	bl transpose
	st.w $a0, $fp, -176
# %op37 = load i32, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -180
# %op38 = add i32 %op37, 1
	ld.w $t0, $fp, -180
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -184
# store i32 %op38, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t1, $fp, -184
	st.w $t1, $t0, 0
# br label %label21
	b .main_label21
.main_label39:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label40:
# %op41 = load i32, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -188
# %op42 = load i32, i32* @len
	la.local $t0, len
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -192
# %op43 = icmp slt i32 %op41, %op42
	ld.w $t0, $fp, -188
	ld.w $t1, $fp, -192
	slt $t2, $t0, $t1
	st.b $t2, $fp, -193
# %op44 = zext i1 %op43 to i32
	ld.b $t0, $fp, -193
	bstrpick.w $t1, $t0, 7, 0
	st.w $t1, $fp, -200
# %op45 = icmp ne i32 %op44, 0
	ld.w $t0, $fp, -200
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -201
# br i1 %op45, label %label46, label %label53
	ld.b $t0, $fp, -201
	beqz $t0, .main_label53
	b .main_label46
.main_label46:
# %op47 = load i32, i32* %op2
	ld.d $t0, $fp, -56
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -208
# %op48 = load i32, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -212
# %op49 = load i32, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -216
# %op50 = mul i32 %op48, %op49
	ld.w $t0, $fp, -212
	ld.w $t1, $fp, -216
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -220
# %op51 = load i32, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -224
# %op52 = icmp slt i32 %op51, 0
	ld.w $t0, $fp, -224
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -225
# br i1 %op52, label %label65, label %label58
	ld.b $t0, $fp, -225
	beqz $t0, .main_label58
	b .main_label65
.main_label53:
# %op54 = load i32, i32* %op2
	ld.d $t0, $fp, -56
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -232
# %op55 = icmp slt i32 %op54, 0
	ld.w $t0, $fp, -232
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -233
# %op56 = zext i1 %op55 to i32
	ld.b $t0, $fp, -233
	bstrpick.w $t1, $t0, 7, 0
	st.w $t1, $fp, -240
# %op57 = icmp ne i32 %op56, 0
	ld.w $t0, $fp, -240
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -241
# br i1 %op57, label %label66, label %label69
	ld.b $t0, $fp, -241
	beqz $t0, .main_label69
	b .main_label66
.main_label58:
# %op59 = getelementptr [20000000 x i32], [20000000 x i32]* @matrix, i32 0, i32 %op51
	la.local $t0, matrix
	ld.w $t1, $fp, -224
	slli.d $t1, $t1, 2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -256
# %op60 = load i32, i32* %op59
	ld.d $t0, $fp, -256
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -260
# %op61 = mul i32 %op50, %op60
	ld.w $t0, $fp, -220
	ld.w $t1, $fp, -260
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -264
# %op62 = add i32 %op47, %op61
	ld.w $t0, $fp, -208
	ld.w $t1, $fp, -264
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -268
# store i32 %op62, i32* %op2
	ld.d $t0, $fp, -56
	ld.w $t1, $fp, -268
	st.w $t1, $t0, 0
# %op63 = load i32, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -272
# %op64 = add i32 %op63, 1
	ld.w $t0, $fp, -272
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -276
# store i32 %op64, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t1, $fp, -276
	st.w $t1, $t0, 0
# br label %label40
	b .main_label40
.main_label65:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label66:
# %op67 = load i32, i32* %op2
	ld.d $t0, $fp, -56
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -280
# %op68 = sub i32 0, %op67
	addi.w $t0, $zero, 0
	ld.w $t1, $fp, -280
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -284
# store i32 %op68, i32* %op2
	ld.d $t0, $fp, -56
	ld.w $t1, $fp, -284
	st.w $t1, $t0, 0
# br label %label69
	b .main_label69
.main_label69:
# %op70 = load i32, i32* %op2
	ld.d $t0, $fp, -56
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -288
# call void @output(i32 %op70)
	ld.w $a0, $fp, -288
	bl output
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 288
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
