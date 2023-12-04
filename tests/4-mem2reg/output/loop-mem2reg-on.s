	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -48
.main_label_entry:
# br label %label1
	addi.w $t0, $zero, 1
	st.w $t0, $fp, -20
	b .main_label1
.main_label1:
# %op11 = phi i32 [ 1, %label_entry ], [ %op8, %label6 ]
# %op3 = icmp slt i32 %op11, 999999999
	ld.w $t0, $fp, -20
	lu12i.w $t1, 244140
	ori $t1, $t1, 2559
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
# br i1 %op5, label %label6, label %label9
	ld.b $t0, $fp, -29
	beqz $t0, .main_label9
	b .main_label6
.main_label6:
# %op8 = add i32 %op11, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -36
# br label %label1
	ld.w $t0, $fp, -36
	st.w $t0, $fp, -20
	b .main_label1
.main_label9:
# ret i32 %op11
	ld.w $a0, $fp, -20
	b main_exit
main_exit:
	addi.d $sp, $sp, 48
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
