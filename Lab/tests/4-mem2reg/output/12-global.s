# Global variables
	.text
	.section .bss, "aw", @nobits
	.globl seed
	.type seed, @object
	.size seed, 4
seed:
	.space 4
	.text
	.globl randomLCG
	.type randomLCG, @function
randomLCG:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -32
.randomLCG_label_entry:
# %op0 = load i32, i32* @seed
	la.local $t0, seed
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -20
# %op1 = mul i32 %op0, 1103515245
	ld.w $t0, $fp, -20
	lu12i.w $t1, 269412
	ori $t1, $t1, 3693
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -24
# %op2 = add i32 %op1, 12345
	ld.w $t0, $fp, -24
	lu12i.w $t1, 3
	ori $t1, $t1, 57
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -28
# store i32 %op2, i32* @seed
	la.local $t0, seed
	ld.w $t1, $fp, -28
	st.w $t1, $t0, 0
# %op3 = load i32, i32* @seed
	la.local $t0, seed
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -32
# ret i32 %op3
	ld.w $a0, $fp, -32
	b randomLCG_exit
randomLCG_exit:
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl randBin
	.type randBin, @function
randBin:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -32
.randBin_label_entry:
# %op0 = call i32 @randomLCG()
	bl randomLCG
	st.w $a0, $fp, -20
# %op1 = icmp sgt i32 %op0, 0
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 0
	slt $t2, $t1, $t0
	st.b $t2, $fp, -21
# %op2 = zext i1 %op1 to i32
	ld.b $t0, $fp, -21
	bstrpick.w $t1, $t0, 7, 0
	st.w $t1, $fp, -28
# %op3 = icmp ne i32 %op2, 0
	ld.w $t0, $fp, -28
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -29
# br i1 %op3, label %label4, label %label5
	ld.b $t0, $fp, -29
	beqz $t0, .randBin_label5
	b .randBin_label4
.randBin_label4:
# ret i32 1
	addi.w $a0, $zero, 1
	b randBin_exit
.randBin_label5:
# ret i32 0
	addi.w $a0, $zero, 0
	b randBin_exit
.randBin_label6:
# ret i32 0
	addi.w $a0, $zero, 0
	b randBin_exit
randBin_exit:
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl returnToZeroSteps
	.type returnToZeroSteps, @function
returnToZeroSteps:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -80
.returnToZeroSteps_label_entry:
# br label %label2
	addi.w $t0, $zero, 0
	st.w $t0, $fp, -20
	addi.w $t0, $zero, 0
	st.w $t0, $fp, -24
	b .returnToZeroSteps_label2
.returnToZeroSteps_label2:
# %op27 = phi i32 [ 0, %label_entry ], [ %op29, %label26 ]
# %op28 = phi i32 [ 0, %label_entry ], [ %op19, %label26 ]
# %op4 = icmp slt i32 %op28, 20
	ld.w $t0, $fp, -24
	addi.w $t1, $zero, 20
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
# br i1 %op6, label %label7, label %label10
	ld.b $t0, $fp, -33
	beqz $t0, .returnToZeroSteps_label10
	b .returnToZeroSteps_label7
.returnToZeroSteps_label7:
# %op8 = call i32 @randBin()
	bl randBin
	st.w $a0, $fp, -40
# %op9 = icmp ne i32 %op8, 0
	ld.w $t0, $fp, -40
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -41
# br i1 %op9, label %label11, label %label14
	ld.b $t0, $fp, -41
	beqz $t0, .returnToZeroSteps_label14
	b .returnToZeroSteps_label11
.returnToZeroSteps_label10:
# ret i32 20
	addi.w $a0, $zero, 20
	b returnToZeroSteps_exit
.returnToZeroSteps_label11:
# %op13 = add i32 %op27, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -48
# br label %label17
	ld.w $t0, $fp, -48
	st.w $t0, $fp, -56
	b .returnToZeroSteps_label17
.returnToZeroSteps_label14:
# %op16 = sub i32 %op27, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -52
# br label %label17
	ld.w $t0, $fp, -52
	st.w $t0, $fp, -56
	b .returnToZeroSteps_label17
.returnToZeroSteps_label17:
# %op29 = phi i32 [ %op13, %label11 ], [ %op16, %label14 ]
# %op19 = add i32 %op28, 1
	ld.w $t0, $fp, -24
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -60
# %op21 = icmp eq i32 %op29, 0
	ld.w $t0, $fp, -56
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	xori $t2, $t2, 1
	st.b $t2, $fp, -61
# %op22 = zext i1 %op21 to i32
	ld.b $t0, $fp, -61
	bstrpick.w $t1, $t0, 7, 0
	st.w $t1, $fp, -68
# %op23 = icmp ne i32 %op22, 0
	ld.w $t0, $fp, -68
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -69
# br i1 %op23, label %label24, label %label26
	ld.b $t0, $fp, -69
	beqz $t0, .returnToZeroSteps_label26
	b .returnToZeroSteps_label24
.returnToZeroSteps_label24:
# ret i32 %op19
	ld.w $a0, $fp, -60
	b returnToZeroSteps_exit
.returnToZeroSteps_label26:
# br label %label2
	ld.w $t0, $fp, -56
	st.w $t0, $fp, -20
	ld.w $t0, $fp, -60
	st.w $t0, $fp, -24
	b .returnToZeroSteps_label2
returnToZeroSteps_exit:
	addi.d $sp, $sp, 80
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -48
.main_label_entry:
# store i32 3407, i32* @seed
	la.local $t0, seed
	lu12i.w $t1, 0
	ori $t1, $t1, 3407
	st.w $t1, $t0, 0
# br label %label1
	addi.w $t0, $zero, 0
	st.w $t0, $fp, -20
	b .main_label1
.main_label1:
# %op11 = phi i32 [ 0, %label_entry ], [ %op9, %label6 ]
# %op3 = icmp slt i32 %op11, 20
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 20
	slt $t2, $t0, $t1
	st.b $t2, $fp, -21
# %op4 = zext i1 %op3 to i32
	ld.b $t0, $fp, -21
	bstrpick.w $t1, $t0, 7, 0
	st.w $t1, $fp, -28
# %op5 = icmp ne i32 %op4, 0
	ld.w $t0, $fp, -28
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -29
# br i1 %op5, label %label6, label %label10
	ld.b $t0, $fp, -29
	beqz $t0, .main_label10
	b .main_label6
.main_label6:
# %op7 = call i32 @returnToZeroSteps()
	bl returnToZeroSteps
	st.w $a0, $fp, -36
# call void @output(i32 %op7)
	ld.w $a0, $fp, -36
	bl output
# %op9 = add i32 %op11, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -40
# br label %label1
	ld.w $t0, $fp, -40
	st.w $t0, $fp, -20
	b .main_label1
.main_label10:
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 48
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
