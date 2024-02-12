	AREA main, CODE, READONLY
	EXPORT __main
	ENTRY
__main 	PROC
		MOV r0, #0x03 ; the number whose factorial needs to be calculated
		BL factorial ; branch to the main subroutine
		MOV r7, r0 ; simple move data
		ENDP ; end procedure
factorial
		PUSH {r4, lr} ; push both r4 and link register to the stack, look up stack pointer current address
		MOV r4, r0 ; move r0 to r4
		CMP r4, #0x01 ; do this until r4=1
		BNE NZ ; if r4 is not equal to 1 then go to nonzero section
		MOVS r0, #0x01 ; 
loop 	POP {r4, pc} 
NZ 		SUBS r0, r4, #1 ; subtract 1 from r4 and store to r0 and call the factorial
		BL factorial ; branch to factorial
		MUL r0, r4, r0 ; multiplly r4 with r0.
		B loop ; call the loop function where thext gibbest value is popped for next set of factorial multiply calculation
END