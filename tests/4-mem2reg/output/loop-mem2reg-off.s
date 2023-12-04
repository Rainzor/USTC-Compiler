	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -64
.main_label_entry:
# %op0 = alloca i32
	addi.d $t0, $fp, -28
	st.d $t0, $fp, -24
# store i32 1, i32* %op0
	ld.d $t0, $fp, -24
	addi.w $t1, $zero, 1
	st.w $t1, $t0, 0
# br label %label1
	b .main_label1
.main_label1:
# %op2 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -32
# %op3 = icmp slt i32 %op2, 999999999
	ld.w $t0, $fp, -32
	lu12i.w $t1, 244140
	ori $t1, $t1, 2559
	slt $t2, $t0, $t1
	st.b $t2, $fp, -33
# %op4 = zext i1 %op3 to i32
	ld.b $t0, $fp, -33
	bstrpick.w $t1, $t0, 7, 0
	st.w $t1, $fp, -40
# %op5 = icmp ne i32 %op4, 0
	ld.w $t0, $fp, -40
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -41
# br i1 %op5, label %label6, label %label9
	ld.b $t0, $fp, -41
	beqz $t0, .main_label9
	b .main_label6
.main_label6:
# %op7 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -48
# %op8 = add i32 %op7, 1
	ld.w $t0, $fp, -48
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -52
# store i32 %op8, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t1, $fp, -52
	st.w $t1, $t0, 0
# br label %label1
	b .main_label1
.main_label9:
# %op10 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -56
# ret i32 %op10
	ld.w $a0, $fp, -56
	b main_exit
main_exit:
	addi.d $sp, $sp, 64
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
