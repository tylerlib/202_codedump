	AREA    main, CODE, READONLY
	EXPORT	__main				; make __main visible to linker
	
	ENTRY			
				
__main	PROC
	
	
	; begin variable storage section 
	LDR r5, =SAMP ; load the value in SAMP to a register
	LDR r6, =Y  ; load the address where you want to store the SAMP 
	STR r5, [r6] ; store the SAMP value to the address in X
	
	; YOU CAN DO SAME TESTS FOR STR.
	;LDR r8, r5 ; will this work? uncomment this line and try to build, what would you replace this line with?
	; Load byte only
	LDRB r1, [r6] ; loads only 1 byte to r3 from address held in R6
	; load halfword
	LDRH r2, [r6] ; loads only "half-word" (2 bytes) to r2 from address held in R6
	; load word (32 bits)
	LDR r3, [r6] ; loads full word (4 bytes) to r3 from address held in R6
	
	LDRSB r4, [r6]	; load signed byte to r4  from address held in r6
	LDRSH r0, [r6] ; load signed halfword to r0 from address held in r6
	ADD r3,#1 ; add 1 to existing value in r3
	
	; all storage examples
	
	; simple store (also store word)
	; 		STR r3, r4	;will this work though???
	
	; simple store to location(also store word)
	; add a memory watch window and set the address to 0x200004f4
	STR r3, [r6]		; you should see new r3 value stored in address contained in r6
	SUB r3, #1
	STRH r3, [r6, #8]	; store halfword(Pre-Indexing) see new r3 value stored in address contained in r6 + 8(bytes), 0x20000508 (note that r6 value stays the same)
	STRB r3, [r6, #-4] 	; store byte  (Pre-Indexing) see new r3 value stored in address contained in r6 - 4(bytes), 0x2000049C (note that r6 value stays the same)
	
	ADDS r4,#2
	; LOAD byte (Post Increment)
	LDR r4, [r6], #4 ; this will copy the contents from memory location conatined in r6 to r4 and then increment the value in r6 by 4 (r6 after this will be 0x20000500) 
	; store byte (Pre-Increment with update)
	STR r3, [r6, #8]! ; this will copy the contents from memory location conatined in r6 + 8 to r4 and then increment the value in r6 by 8 (r6 after this will be 0x20000508)
	
	
	;SUB r6, #0x0f ;uncomment this line and see what happens
	; Load Multiple registers increment after
	LDR r6, =Y ; reset the address for the sake of this example
	LDMIA r6, {r5,r0,r1,r3,r2} ; copy the contents from location pointed to by r6 and save them to registers r0,r1,r2,r3,r5 respectively. Do copy and then increase the address
	LDM r6!, {r7-r9} ; store 
	; Load Multiple registers increment before
	; LDMIB r6, {r5,r0,r1,r3,r2} ; ARMV7 doesn't support this
	; Load Multiple registers decrement after
	;LDMDA r6, {r5,r0,r1,r3,r2} ; ARMV7 doesn't support this either
	; Load Multiple registers decrement before
	LDMDB r6, {r5,r0,r1,r3,r2} ; 

	; Load Multiple registers increment after
	LDR r6, =Y ; reset the address for the sake of this example
	STMIA r6, {r5,r0,r1,r3,r2}
	; Load Multiple registers increment before
	; STMIB r6, {r5,r0,r1,r3,r2} ; will this work though?/??
	; Load Multiple registers decrement after
	; STMDA r6, {r5,r0,r1,r3,r2}
	; Load Multiple registers decrement before
	STMDB r6, {r5,r0,r1,r3,r2}

L 	B L

	ENDP
					
	ALIGN			

	AREA    myData, DATA, READWRITE
	ALIGN
X	EQU	0x20000000 ; address where you want the data to be stored/retreived from memory
Y	EQU 0x20000500 ; different address
Z	EQU 0x20001000 ; 3rd address
	
SAMP EQU 0xa1b2c34d
VAR1 EQU 0xAA
VAR2 EQU 0xFFFFFFFE
VAR3 EQU 0x10000001

	END