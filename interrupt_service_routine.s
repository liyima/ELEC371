ISR:
	subi 	ea, ea, 4
	subi	sp, sp 12
	stw	ra, 8(sp)
	stw	r2, 4(sp)
	stw	r3, 0(sp)

	rdctl	r2, ipending

checkHandleX:
	andi	r3, r2, 0x80000000
	beq	r3, r0, checkHandleY
	call	HandleX
checkHandleY:
	andi	r3, r2, 0x400000
	beq,	r3, r0, checkHandleZ
	call	HandleY
checkHandleZ:
	andi	r3, r2, 0x2000
	beq	r3, r0, EndBreak
	call	HandleZ
EndBreak:
	ldw	ra, 8(sp)
	ldw	r2, 4(sp)
	ldw	r3, 0(sp)
	addi	sp, sp 12
	addi	sp, sp, 4

	eret
