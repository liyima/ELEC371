.global _start
_start:
	
.org 0x0000

	movi	sp, 0x7FFC
	movia	r2, DEST_LIST
	movia	r3, LIST1
	movia	r4, LIST2
	ldw		r5, N(r0)
	
	Call SelectLarger
	
SelectLarger:
	subi		sp, sp, 24
	stw		r2, 20(sp)	# dest list
	stw		r3, 16(sp)	# list 1
	stw		r4, 12(sp)	# list 2
	stw		r5, 8(sp)	# N
	stw		r6, 4(sp)	# loading in the value from r3
	stw		r7, 0(sp)	# loading in the value from r4
	
SL_Loop:
	ldw		r6, 0(r3)
	ldw		r7, 0(r4)
	
	bgt		r6, r7, SL_Then
	stw		r7, 0(r2)
	br		SL_End

SL_Then:
	stw		r6, 0(r2)

SL_End:
	addi		r2, r2, 4
	addi		r3, r3, 4
	addi		r4, r4, 4
	subi		r5, r5, 1
	bgt		r5, r0, SL_Loop
	
	ldw		r2, 20(sp)	# dest list
	ldw		r3, 16(sp)	# list 1
	ldw		r4, 12(sp)	# list 2
	ldw		r5, 8(sp)	# N
	ldw		r6, 4(sp)	# load this register into dest list
	ldw		r7, 0(sp)
	addi		sp, sp, 24
	
	ret

.org 0x1000

DEST_LIST:		.skip 16
LIST1:			.word -9, 13, 0xFF, 167
LIST2:			.word 24, -5, 0, 192
N:			.word 4
