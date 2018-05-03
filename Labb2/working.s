# Example program for lab 1 in Computer Systems (DA).
# Created 20120612 by Zandra Norman.
# Modified 20141006 by Hasibur Rahman
# Copyright abandoned. This file is in the public domain.

.text
.global _start
		
_start:
# set up stack pointer */
	#movia	sp, 0x0003fffc	# stack starts from highest memory address in SDRAM */
	movia	r6, 0x860		#JTAG UART base address */
	movia 	r7, 0x868		#JTAG UART contro register
# print a text string */
	movia	r8, TEXT_STRING
LOOP:
	ldb	r5, 0(r8)
	beq	r5, zero, GET_JTAG	#string is null-terminated */
	call	PUT_JTAG
	addi	r8, r8, 1
	br	LOOP
GET_JTAG:
	# read and echo characters */
	ldwio	r4, 0(r7)
	andi	r8, r4, 0x80	#* check if there is new data */
	beq	r8, r0, GET_JTAG	#if no data, wait */
	ldwio	r4, 0(r6)		# read the JTAG UART Data register */
	andi	r5, r4, 0x00ff	# the data is in the least significant byte */
	call	PUT_JTAG		# echo character */
	br	GET_JTAG
	
.global PUT_JTAG

PUT_JTAG: 
	# save any modified registers */
	subi	sp, sp, 4			#reserve space on the stack */
	stw		r4, 0(sp)			# save register */
	ldwio	r4, 0(r7)			# read the JTAG UART Control register */
	andhi	r4, r4, 0xffff		# check for write space */
	bne		r4, r0, END_PUT		#if no space, ignore the character */
	stwio	r5, 4(r6)			# send the character */
END_PUT:
# restore registers */
	ldw		r4, 0(sp)
	addi	sp, sp, 4
	ret
.data
# data follows */
TEXT_STRING:
	.asciz "Data follows: "

.end