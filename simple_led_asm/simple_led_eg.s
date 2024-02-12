    AREA RESET, CODE, READONLY    ; Define the code area
    EXPORT __main                 ; Make the main entry point public

__main
    ; Enable clock for GPIOA
    LDR R0, =RCC_AHB2ENR 		  ; Address of AHB2 peripheral clock enable register (RCC_AHB2ENR)
    LDR R1, [R0]                  ; Load the current value of RCC_AHB2ENR
    ORR R1, R1, #0x1              ; Set bit 0 to enable GPIOA clock
    STR R1, [R0]                  ; Update the RCC_AHB2ENR register

    ; Configure GPIOA pin 0 as output
    LDR R0, =GPIOA_BOUNDARY		  ; GPIOA base address (GPIOA_MODER)
    LDR R1, [R0, #MODER]          ; Load the current value of GPIOA_MODER
    BIC R1, R1, #0x3              ; Clear the 2 bits corresponding to pin 0
    ORR R1, R1, #0x1              ; Set pin 0 as General purpose output mode
    STR R1, [R0, #MODER]          ; Update the GPIOA_MODER register

BlinkLoop
    ; Set GPIOA pin 0 high (turn on LED)
    LDR R0, =0x48000018	      ; GPIOA base address + offset to BSRR (GPIOA_BSRR)
    MOV R1, #0x1                  ; Create a bitmask to set pin 0
    STR R1, [R0]                  ; Write to GPIOA_BSRR to set pin 0 high

    ; Delay loop for LED on time
    LDR R2, =0xc95               ; Load a large value for delay
DelayOn
    SUBS R2, R2, #1               ; Decrement the delay counter
    BNE DelayOn                   ; If not zero, continue looping

    ; Set GPIOA pin 0 low (turn off LED)
    MOV R1, #0x10000              ; Create a bitmask to reset pin 0
    STR R1, [R0]                  ; Write to GPIOA_BSRR to reset pin 0

    ; Delay loop for LED off time
    LDR R2, =1000000              ; Load a large value for delay
DelayOff
    SUBS R2, R2, #1               ; Decrement the delay counter
    BNE DelayOff                  ; If not zero, continue looping

    B BlinkLoop                   ; Repeat the blink loop indefinitely


		AREA    		myData, DATA, READWRITE ; name of the area, data/code section, read/write access
				ALIGN ;ensure that proper byte boundary alignment is respected more here: https:;developer.arm.com/documentation/dui0068/b/Directives-Reference/Miscellaneous-directives/ALIGN

RCC_AHB2ENR 	EQU    	0x4002104C
GPIOA_BOUNDARY 	EQU 	0x48000000
; everything below this line are offset register addresses, use this in conjunction with the GPIOB boundary register
MODER 			EQU 	0x00
OTYPER 			EQU   	0x04
OSPEEDR 		EQU  	0x08
PUPDR 			EQU    	0x0C
ODR 			EQU     0x14
BSRR 			EQU     0x18

    END                           ; End of the file
