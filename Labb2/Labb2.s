# Program structure for lab 2 in DA VT14
# Modified on 20140305 by Hasibur Rahman
# Copyright abandoned. This file is in the public domain.


.text
.global _start

_start:

.macro PUSH reg
subi sp, sp, 4
stw \reg, 0(sp)
.endm

.macro POP reg
ldw \reg, 0(sp)
addi sp, sp, 4
.endm

#Code to set up registers with relevant adresses to the I/O units
	movia sp, 0x007FFFFC #set stackpointer to highest adress in SDRAM
	movia r8, 0x10001000 #JTAG0 UART base adress 

MAIN_LOOP:
	call READ_JTAG
	#call READ_SERIAL
	br MAIN_LOOP

READ_JTAG:
#Read data from the JTAG port

	ret

WRITE_JTAG:
#Write data to the JTAG port
#------- your code here
	ret

READ_SERIAL:
#Read data from the serial port
#------ your code here
	ret

WRITE_SERIAL:
#Write data to the serial port
#------- your code here
	ret
	

.end