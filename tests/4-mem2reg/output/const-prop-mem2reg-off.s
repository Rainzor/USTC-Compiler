	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -368
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
# %op3 = alloca i32
	addi.d $t0, $fp, -76
	st.d $t0, $fp, -72
# %op4 = alloca i32
	addi.d $t0, $fp, -92
	st.d $t0, $fp, -88
# %op5 = alloca i32
	addi.d $t0, $fp, -108
	st.d $t0, $fp, -104
# %op6 = alloca i32
	addi.d $t0, $fp, -124
	st.d $t0, $fp, -120
# %op7 = call i32 @input()
	bl input
	st.w $a0, $fp, -128
# store i32 %op7, i32* %op6
	ld.d $t0, $fp, -120
	ld.w $t1, $fp, -128
	st.w $t1, $t0, 0
# store i32 0, i32* %op0
	ld.d $t0, $fp, -24
	addi.w $t1, $zero, 0
	st.w $t1, $t0, 0
# store i32 0, i32* %op1
	ld.d $t0, $fp, -40
	addi.w $t1, $zero, 0
	st.w $t1, $t0, 0
# store i32 0, i32* %op5
	ld.d $t0, $fp, -104
	addi.w $t1, $zero, 0
	st.w $t1, $t0, 0
# br label %label8
	b .main_label8
.main_label8:
# %op9 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -132
# %op10 = load i32, i32* %op6
	ld.d $t0, $fp, -120
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -136
# %op11 = icmp slt i32 %op9, %op10
	ld.w $t0, $fp, -132
	ld.w $t1, $fp, -136
	slt $t2, $t0, $t1
	st.b $t2, $fp, -137
# %op12 = zext i1 %op11 to i32
	ld.b $t0, $fp, -137
	bstrpick.w $t1, $t0, 7, 0
	st.w $t1, $fp, -144
# %op13 = icmp ne i32 %op12, 0
	ld.w $t0, $fp, -144
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -145
# br i1 %op13, label %label14, label %label66
	ld.b $t0, $fp, -145
	beqz $t0, .main_label66
	b .main_label14
.main_label14:
# %op15 = fmul float 0x3ff3c0c200000000, 0x4016f06a20000000
	lu12i.w $t8, 260576
	ori $t8, $t8, 1552
	movgr2fr.w $ft0, $t8
	lu12i.w $t8, 265080
	ori $t8, $t8, 849
	movgr2fr.w $ft1, $t8
	fmul.s $ft2, $ft0, $ft1
	fst.s $ft2, $fp, -152
# %op16 = fmul float %op15, 0x4002aa9940000000
	fld.s $ft0, $fp, -152
	lu12i.w $t8, 262485
	ori $t8, $t8, 1226
	movgr2fr.w $ft1, $t8
	fmul.s $ft2, $ft0, $ft1
	fst.s $ft2, $fp, -156
# %op17 = fmul float %op16, 0x4011781d80000000
	fld.s $ft0, $fp, -156
	lu12i.w $t8, 264380
	ori $t8, $t8, 236
	movgr2fr.w $ft1, $t8
	fmul.s $ft2, $ft0, $ft1
	fst.s $ft2, $fp, -160
# %op18 = fmul float %op17, 0x401962ac40000000
	fld.s $ft0, $fp, -160
	lu12i.w $t8, 265393
	ori $t8, $t8, 1378
	movgr2fr.w $ft1, $t8
	fmul.s $ft2, $ft0, $ft1
	fst.s $ft2, $fp, -164
# %op19 = fptosi float %op18 to i32
	fld.s $ft0, $fp, -164
	ftintrz.w.s $ft1, $ft0
	movfr2gr.s $t0, $ft1
	st.w $t0, $fp, -168
# store i32 %op19, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t1, $fp, -168
	st.w $t1, $t0, 0
# %op20 = load i32, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -172
# %op21 = load i32, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -176
# %op22 = mul i32 %op20, %op21
	ld.w $t0, $fp, -172
	ld.w $t1, $fp, -176
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -180
# %op23 = load i32, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -184
# %op24 = mul i32 %op22, %op23
	ld.w $t0, $fp, -180
	ld.w $t1, $fp, -184
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -188
# %op25 = load i32, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -192
# %op26 = mul i32 %op24, %op25
	ld.w $t0, $fp, -188
	ld.w $t1, $fp, -192
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -196
# %op27 = load i32, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -200
# %op28 = mul i32 %op26, %op27
	ld.w $t0, $fp, -196
	ld.w $t1, $fp, -200
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -204
# %op29 = load i32, i32* %op1
	ld.d $t0, $fp, -40
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -208
# %op30 = mul i32 %op28, %op29
	ld.w $t0, $fp, -204
	ld.w $t1, $fp, -208
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -212
# store i32 %op30, i32* %op2
	ld.d $t0, $fp, -56
	ld.w $t1, $fp, -212
	st.w $t1, $t0, 0
# %op31 = load i32, i32* %op2
	ld.d $t0, $fp, -56
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -216
# %op32 = load i32, i32* %op2
	ld.d $t0, $fp, -56
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -220
# %op33 = mul i32 %op31, %op32
	ld.w $t0, $fp, -216
	ld.w $t1, $fp, -220
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -224
# %op34 = load i32, i32* %op2
	ld.d $t0, $fp, -56
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -228
# %op35 = mul i32 %op33, %op34
	ld.w $t0, $fp, -224
	ld.w $t1, $fp, -228
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -232
# %op36 = load i32, i32* %op2
	ld.d $t0, $fp, -56
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -236
# %op37 = mul i32 %op35, %op36
	ld.w $t0, $fp, -232
	ld.w $t1, $fp, -236
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -240
# %op38 = load i32, i32* %op2
	ld.d $t0, $fp, -56
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -244
# %op39 = mul i32 %op37, %op38
	ld.w $t0, $fp, -240
	ld.w $t1, $fp, -244
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -248
# %op40 = load i32, i32* %op2
	ld.d $t0, $fp, -56
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -252
# %op41 = mul i32 %op39, %op40
	ld.w $t0, $fp, -248
	ld.w $t1, $fp, -252
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -256
# store i32 %op41, i32* %op3
	ld.d $t0, $fp, -72
	ld.w $t1, $fp, -256
	st.w $t1, $t0, 0
# %op42 = load i32, i32* %op3
	ld.d $t0, $fp, -72
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -260
# %op43 = load i32, i32* %op3
	ld.d $t0, $fp, -72
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -264
# %op44 = mul i32 %op42, %op43
	ld.w $t0, $fp, -260
	ld.w $t1, $fp, -264
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -268
# %op45 = load i32, i32* %op3
	ld.d $t0, $fp, -72
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -272
# %op46 = mul i32 %op44, %op45
	ld.w $t0, $fp, -268
	ld.w $t1, $fp, -272
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -276
# %op47 = load i32, i32* %op3
	ld.d $t0, $fp, -72
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -280
# %op48 = mul i32 %op46, %op47
	ld.w $t0, $fp, -276
	ld.w $t1, $fp, -280
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -284
# %op49 = load i32, i32* %op3
	ld.d $t0, $fp, -72
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -288
# %op50 = mul i32 %op48, %op49
	ld.w $t0, $fp, -284
	ld.w $t1, $fp, -288
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -292
# %op51 = load i32, i32* %op3
	ld.d $t0, $fp, -72
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -296
# %op52 = mul i32 %op50, %op51
	ld.w $t0, $fp, -292
	ld.w $t1, $fp, -296
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -300
# store i32 %op52, i32* %op4
	ld.d $t0, $fp, -88
	ld.w $t1, $fp, -300
	st.w $t1, $t0, 0
# %op53 = load i32, i32* %op4
	ld.d $t0, $fp, -88
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -304
# %op54 = load i32, i32* %op4
	ld.d $t0, $fp, -88
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -308
# %op55 = mul i32 %op53, %op54
	ld.w $t0, $fp, -304
	ld.w $t1, $fp, -308
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -312
# %op56 = load i32, i32* %op4
	ld.d $t0, $fp, -88
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -316
# %op57 = mul i32 %op55, %op56
	ld.w $t0, $fp, -312
	ld.w $t1, $fp, -316
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -320
# %op58 = load i32, i32* %op4
	ld.d $t0, $fp, -88
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -324
# %op59 = mul i32 %op57, %op58
	ld.w $t0, $fp, -320
	ld.w $t1, $fp, -324
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -328
# %op60 = load i32, i32* %op4
	ld.d $t0, $fp, -88
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -332
# %op61 = mul i32 %op59, %op60
	ld.w $t0, $fp, -328
	ld.w $t1, $fp, -332
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -336
# %op62 = load i32, i32* %op4
	ld.d $t0, $fp, -88
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -340
# %op63 = mul i32 %op61, %op62
	ld.w $t0, $fp, -336
	ld.w $t1, $fp, -340
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -344
# store i32 %op63, i32* %op5
	ld.d $t0, $fp, -104
	ld.w $t1, $fp, -344
	st.w $t1, $t0, 0
# %op64 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -348
# %op65 = add i32 %op64, 1
	ld.w $t0, $fp, -348
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -352
# store i32 %op65, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t1, $fp, -352
	st.w $t1, $t0, 0
# br label %label8
	b .main_label8
.main_label66:
# %op67 = load i32, i32* %op5
	ld.d $t0, $fp, -104
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -356
# call void @output(i32 %op67)
	ld.w $a0, $fp, -356
	bl output
# ret void
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 368
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
