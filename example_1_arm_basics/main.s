		AREA    main, CODE, READONLY ; name of the area, data/code section, read/write access
		EXPORT	__main				; make __main visible to linker
		
		ENTRY			; explicit declaration of the entry point for the program.
					
__main	PROC ; declaring __main as a PROCEDURE (also called SUBROUTINE, sometimes confusingly called PROCESS) this must always be terminated by an ENDP
		
		
		movs r0, #VAR ; copying the contents of variable VAR to r0, movs will updated N and Z flags based on the value at r0. Notice what happens in the PSR
		movs r1, #0	; copying the value #0 to r1, notice what happens to N and Z flag in the PSR when running this instruction. 
					; Now try the above instruction with "mov" operation and see how the PSR bits are updated.
		adds r2, r0, r1 ; adding with update of sign flags. What happens when this instruction is executed? try it out with just "add" and see results

Label 	B Label ; This is an unconditional branch instruction that transfers the control to the same location. The program effectively "hangs" here

		ENDP	; every PROC should end with an ENDP	

		AREA    myData, DATA, READWRITE ; name of the area, data/code section, read/write access
		ALIGN ;ensure that proper byte boundary alignment is respected more here: https://developer.arm.com/documentation/dui0068/b/Directives-Reference/Miscellaneous-directives/ALIGN
VAR  	EQU 0xAA ;In this case VAR is an alias for value 0xAA. think of it as a #define in c/c++, this will NOT create a physical memory location where 0xAA is allocated
VAR1	DCW VAR ;This is more like a static, where your resulting binary file will have a byte of memory allocated to VAR1 and is equal to 0xAA 
		END ; letting your arm compiler know that it has reached the end of the code