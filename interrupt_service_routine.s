ISR:
	subi 	ea, ea, 4	#always need this line, ea saves address of last instruction before the interrupt
	subi	sp, sp 12
	stw	ra, 8(sp)	# should always have ra in a nested subroutine, because the interrupt can happen at any time during a process' execution
	stw	r2, 4(sp)
	stw	r3, 0(sp)

	rdctl	r2, ipending	# get ipending's value

checkHandleX:
	andi	r3, r2, 0x80000000	# masking bit for X's ienable/ipending
	beq	r3, r0, checkHandleY
	call	HandleX
checkHandleY:
	andi	r3, r2, 0x400000	# masking bit for Y's ienable/ipending
	beq,	r3, r0, checkHandleZ
	call	HandleY
checkHandleZ:
	andi	r3, r2, 0x2000		# masking bit for Z's ienable/ipending
	beq	r3, r0, EndBreak
	call	HandleZ
EndBreak:
	ldw	ra, 8(sp)		# restore pointers
	ldw	r2, 4(sp)
	ldw	r3, 0(sp)
	addi	sp, sp 12
	addi	sp, sp, 4

	eret			# eret copies ea to program counter (return address bit for interrupts) 
				# copy enable status contents to status (IE is reenabled to recognize interrupts again)
