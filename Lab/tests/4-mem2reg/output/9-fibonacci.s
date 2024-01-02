	.text
	.globl fibonacci
	.type fibonacci, @function
fibonacci:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -64
	st.w $a0, $fp, -20
.fibonacci_label_entry:
# %op3 = icmp eq i32 %arg0, 0
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	xori $t2, $t2, 1
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
# br i1 %op5, label %label6, label %label7
	ld.b $t0, $fp, -29
	beqz $t0, .fibonacci_label7
	b .fibonacci_label6
.fibonacci_label6:
# ret i32 0
	addi.w $a0, $zero, 0
	b fibonacci_exit
.fibonacci_label7:
# %op9 = icmp eq i32 %arg0, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	xori $t2, $t2, 1
	st.b $t2, $fp, -30
# %op10 = zext i1 %op9 to i32
	ld.b $t0, $fp, -30
	bstrpick.w $t1, $t0, 7, 0
	st.w $t1, $fp, -36
# %op11 = icmp ne i32 %op10, 0
	ld.w $t0, $fp, -36
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -37
# br i1 %op11, label %label13, label %label14
	ld.b $t0, $fp, -37
	beqz $t0, .fibonacci_label14
	b .fibonacci_label13
.fibonacci_label12:
# ret i32 0
	addi.w $a0, $zero, 0
	b fibonacci_exit
.fibonacci_label13:
# ret i32 1
	addi.w $a0, $zero, 1
	b fibonacci_exit
.fibonacci_label14:
# %op16 = sub i32 %arg0, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -44
# %op17 = call i32 @fibonacci(i32 %op16)
	ld.w $a0, $fp, -44
	bl fibonacci
	st.w $a0, $fp, -48
# %op19 = sub i32 %arg0, 2
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 2
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -52
# %op20 = call i32 @fibonacci(i32 %op19)
	ld.w $a0, $fp, -52
	bl fibonacci
	st.w $a0, $fp, -56
# %op21 = add i32 %op17, %op20
	ld.w $t0, $fp, -48
	ld.w $t1, $fp, -56
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -60
# ret i32 %op21
	ld.w $a0, $fp, -60
	b fibonacci_exit
.fibonacci_label22:
# br label %label12
	b .fibonacci_label12
fibonacci_exit:
	addi.d $sp, $sp, 64
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
# br label %label2
	addi.w $t0, $zero, 0
	st.w $t0, $fp, -20
	b .main_label2
.main_label2:
# %op14 = phi i32 [ 0, %label_entry ], [ %op12, %label8 ]
# %op5 = icmp slt i32 %op14, 10
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 10
	slt $t2, $t0, $t1
	st.b $t2, $fp, -21
# %op6 = zext i1 %op5 to i32
	ld.b $t0, $fp, -21
	bstrpick.w $t1, $t0, 7, 0
	st.w $t1, $fp, -28
# %op7 = icmp ne i32 %op6, 0
	ld.w $t0, $fp, -28
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -29
# br i1 %op7, label %label8, label %label13
	ld.b $t0, $fp, -29
	beqz $t0, .main_label13
	b .main_label8
.main_label8:
# %op10 = call i32 @fibonacci(i32 %op14)
	ld.w $a0, $fp, -20
	bl fibonacci
	st.w $a0, $fp, -36
# call void @output(i32 %op10)
	ld.w $a0, $fp, -36
	bl output
# %op12 = add i32 %op14, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -40
# br label %label2
	ld.w $t0, $fp, -40
	st.w $t0, $fp, -20
	b .main_label2
.main_label13:
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 48
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
