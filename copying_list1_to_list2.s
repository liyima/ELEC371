# this copies list1 into list2

.text
.global _start
.org 0x0000
_start:

	movi	sp,	0x7FFC
	movia	r2, LIST1 # need movia to get the entire list, not just the first value
	movia	r3, LIST2
	ldw		r4, N(r0)
	
	call ListCopy
	
_end: # be able to call end anywhere
	break
	
ListCopy:
	
	subi	sp, sp, 16
	stw		r2, 12(sp) # input list
	stw		r3, 8(sp) # output list
	stw		r4, 4(sp) # counter
	stw		r5, 0(sp) # place to load and store for output list
	
LC_loop:

	# store list1 value into list2
	ldw r5, 0(r2)
	stw r5, 0(r3)

	# iterate through the list
	addi r2, r2, 4
	addi r3, r3, 4
	subi r4, r4, 1
	# if counter is >0, loop through list
	bgt r4, r0, LC_loop
	
	ldw		r2, 12(sp) # input list
	ldw		r3, 8(sp) # output list
	ldw		r4, 4(sp) # counter
	ldw		r5, 0(sp) # place to load and store for output list
	addi	sp, sp, 16
	
	ret

.org 0x1000
LIST1:	.word 4, 6, 8, 9
LIST2:	.skip 16
N:		.word 4
