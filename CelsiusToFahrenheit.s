					AREA Exercise2, CODE, READONLY
					ENTRY
					MOV r0, #10 				; counter
					ADR r1, CelsiusTable 		; load addr(table) into r1 in Q24.8
					LDR r3, =0x000001CC 		; #1.8 in Q24.8 format
FahrenheitTable 	EQU 0x40000100				; Declare address of fahrenheit table
					LDR r4, =FahrenheitTable
					LDR r5, =0x00002000 		; #32 in Q24.8
					
loop				SUBS r0,r0,#1 				; decrement counter
					LDR r6, [r1], #4 			; load Celsius value into r6 and increment addr pointer by 4 [post-indexed]
					MUL r2, r6, r3 				; r2 = celsius * 1.8
					MOV r2, r2, LSR #8			; r2 = r2/2^8
					ADD r2, r2, r5 				; r2 = celsius * 1.8 + 32
					STR r2, [r4], #4			; store F value into F table, increment addr pointer by 4
					BNE loop
					
stop	 			B stop

CelsiusTable 		DCD 0x00001080, 0x00001199, 0x000012E6, 0x00001419, 0x00001680, 0x00001AB3, 0x00001CE6, 0x00002399, 0x00002433, 0x00002599

					END