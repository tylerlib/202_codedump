	AREA    main, CODE, READONLY
	EXPORT	__main				; make __main visible to linker
	
	ENTRY			
	

__main			MOV R10, #10 ; the max number is 10
				MOV R1, #0 ; first register has value 0
				MOV R2, #1 ; 2nd register has value 1 (next number in fibonacci sequence) 	
				; Calculate the Fibonacci number
FIB				SUBS R10, #1 ; subtract the counter value by 1 like a while loop
				BLE COMP ; if Less than or equal to then you're done (i.e. the Zero flag is set)
				ADD R3, R1, R2 ; sum the previous and current value
				MOV R1, R2 ; update the current to previous
				MOV R2, R3 ; update the sum to current
				BGT	FIB ; If the N flag is not set then go back to the lop
COMP			b COMP ; we're done

		AREA    myData, DATA, READWRITE
		ALIGN

memory SPACE 100

VAR  EQU 0xAA
VAR2 EQU 0xBB
mem_space EQU memory

N    EQU    6
ERR    EQU     -1
OVERFLOW    EQU     -2


	END