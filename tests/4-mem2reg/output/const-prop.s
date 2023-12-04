	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -144
.main_label_entry:
# %op7 = call i32 @input()
	bl input
	st.w $a0, $fp, -20
# br label %label8
	addi.w $t0, $zero, 0
	st.w $t0, $fp, -24
	addi.w $t0, $zero, 0
	st.w $t0, $fp, -28
	b .main_label8
.main_label8:
# %op68 = phi i32 [ 0, %label_entry ], [ %op65, %label14 ]
# %op69 = phi i32 [ 0, %label_entry ], [ %op63, %label14 ]
# %op11 = icmp slt i32 %op68, %op7
	ld.w $t0, $fp, -24
	ld.w $t1, $fp, -20
	slt $t2, $t0, $t1
	st.b $t2, $fp, -29
# %op12 = zext i1 %op11 to i32
	ld.b $t0, $fp, -29
	bstrpick.w $t1, $t0, 7, 0
	st.w $t1, $fp, -36
# %op13 = icmp ne i32 %op12, 0
	ld.w $t0, $fp, -36
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -37
# br i1 %op13, label %label14, label %label66
	ld.b $t0, $fp, -37
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
	fst.s $ft2, $fp, -44
# %op16 = fmul float %op15, 0x4002aa9940000000
	fld.s $ft0, $fp, -44
	lu12i.w $t8, 262485
	ori $t8, $t8, 1226
	movgr2fr.w $ft1, $t8
	fmul.s $ft2, $ft0, $ft1
	fst.s $ft2, $fp, -48
# %op17 = fmul float %op16, 0x4011781d80000000
	fld.s $ft0, $fp, -48
	lu12i.w $t8, 264380
	ori $t8, $t8, 236
	movgr2fr.w $ft1, $t8
	fmul.s $ft2, $ft0, $ft1
	fst.s $ft2, $fp, -52
# %op18 = fmul float %op17, 0x401962ac40000000
	fld.s $ft0, $fp, -52
	lu12i.w $t8, 265393
	ori $t8, $t8, 1378
	movgr2fr.w $ft1, $t8
	fmul.s $ft2, $ft0, $ft1
	fst.s $ft2, $fp, -56
# %op19 = fptosi float %op18 to i32
	fld.s $ft0, $fp, -56
	ftintrz.w.s $ft1, $ft0
	movfr2gr.s $t0, $ft1
	st.w $t0, $fp, -60
# %op22 = mul i32 %op19, %op19
	ld.w $t0, $fp, -60
	ld.w $t1, $fp, -60
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -64
# %op24 = mul i32 %op22, %op19
	ld.w $t0, $fp, -64
	ld.w $t1, $fp, -60
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -68
# %op26 = mul i32 %op24, %op19
	ld.w $t0, $fp, -68
	ld.w $t1, $fp, -60
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -72
# %op28 = mul i32 %op26, %op19
	ld.w $t0, $fp, -72
	ld.w $t1, $fp, -60
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -76
# %op30 = mul i32 %op28, %op19
	ld.w $t0, $fp, -76
	ld.w $t1, $fp, -60
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -80
# %op33 = mul i32 %op30, %op30
	ld.w $t0, $fp, -80
	ld.w $t1, $fp, -80
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -84
# %op35 = mul i32 %op33, %op30
	ld.w $t0, $fp, -84
	ld.w $t1, $fp, -80
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -88
# %op37 = mul i32 %op35, %op30
	ld.w $t0, $fp, -88
	ld.w $t1, $fp, -80
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -92
# %op39 = mul i32 %op37, %op30
	ld.w $t0, $fp, -92
	ld.w $t1, $fp, -80
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -96
# %op41 = mul i32 %op39, %op30
	ld.w $t0, $fp, -96
	ld.w $t1, $fp, -80
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -100
# %op44 = mul i32 %op41, %op41
	ld.w $t0, $fp, -100
	ld.w $t1, $fp, -100
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -104
# %op46 = mul i32 %op44, %op41
	ld.w $t0, $fp, -104
	ld.w $t1, $fp, -100
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -108
# %op48 = mul i32 %op46, %op41
	ld.w $t0, $fp, -108
	ld.w $t1, $fp, -100
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -112
# %op50 = mul i32 %op48, %op41
	ld.w $t0, $fp, -112
	ld.w $t1, $fp, -100
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -116
# %op52 = mul i32 %op50, %op41
	ld.w $t0, $fp, -116
	ld.w $t1, $fp, -100
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -120
# %op55 = mul i32 %op52, %op52
	ld.w $t0, $fp, -120
	ld.w $t1, $fp, -120
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -124
# %op57 = mul i32 %op55, %op52
	ld.w $t0, $fp, -124
	ld.w $t1, $fp, -120
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -128
# %op59 = mul i32 %op57, %op52
	ld.w $t0, $fp, -128
	ld.w $t1, $fp, -120
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -132
# %op61 = mul i32 %op59, %op52
	ld.w $t0, $fp, -132
	ld.w $t1, $fp, -120
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -136
# %op63 = mul i32 %op61, %op52
	ld.w $t0, $fp, -136
	ld.w $t1, $fp, -120
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -140
# %op65 = add i32 %op68, 1
	ld.w $t0, $fp, -24
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -144
# br label %label8
	ld.w $t0, $fp, -144
	st.w $t0, $fp, -24
	ld.w $t0, $fp, -140
	st.w $t0, $fp, -28
	b .main_label8
.main_label66:
# call void @output(i32 %op69)
	ld.w $a0, $fp, -28
	bl output
# ret void
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 144
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
