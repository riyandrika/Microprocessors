					AREA Exercise3, CODE, READONLY
					ENTRY
					MOV r0, #10 				; counter
					ADR r1, FahrenheitTable 	; r1 = addr(F table)
					LDR r3, =0x00000047 		; #1/1.8 in Q32.0 format
CelsiusTable 		EQU 	0x40000100			; Declare address of C table
					LDR r4, =CelsiusTable		; r4 = addr(C table)
					LDR r5, =0x00002000 		; #32 in Q24.8
					
loop				SUBS r0,r0,#1 				; decrement counter
					LDR r6, [r1], #4 			; load Celsius value into r6 and increment addr
					SUB r6, r6, r5				; r6 = F - 32
					MUL r2, r6, r3 				; r2 = (F - 32) * 1/1.8
					STR r2, [r4], #4			; store C value into C table, increment addr
					BNE loop
					
stop	 			B stop

FahrenheitTable 	DCD 70, 72, 74, 76, 78, 80, 82, 84, 86, 88 ; Values in Q(24.8) format
					END