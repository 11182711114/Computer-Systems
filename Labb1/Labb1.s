# Example program for lab 1 in Computer Systems (DA).
# Created 20120612 by Zandra Norman.
# Modified 20141006 by Hasibur Rahman
# Copyright abandoned. This file is in the public domain.

	.text
	.global _start
		
_start:
	# These addresses needs to be set to the correct values
	movia	r17,0x804	# Address for the red LEDs
	movia	r18,0x800	# Address for the green LEDs

# This segment writes to the green LEDs, waits
# for the timer and then turns the green LEDs off.
	
# This segment writes to the red LEDs, waits
# for the timer and then turns the red LEDs off.
LED_CYCLE:
	movia	r8, 0x55555 #lamps to turn on: (0)1010101010101010101
	movia	r9, 0xfffff #all 1s to make logical NOT with r8 using XOR
	movia	r10, 0x4 #4 cycles green

RED: 		
	stwio	r8,0(r17)
	call	TIMER
	stwio	r0,0(r17)
	subi r10,r10,0x1 #subtract 1 from r10
	xor r8,r8,r9 #invert r8(the LEDs)
	bne r10,r0,RED #Have we not done 4 cycles green? goto RED
	
GREEN:
	movia	r8, 0x1ff
	stwio	r8,0(r18)
	call	TIMER
	stwio	r0,0(r18)
	br 		LED_CYCLE #Start cycle over
	
TIMER:
	movia	r11, 0xffffff	# Is this value reasonable? 0xffffff
START_TIMER:
	subi	r11,r11,0x1
	bne	r11,r0, START_TIMER
	ret
		
END:

.end
