						AREA	L3002B_Q3ii, CODE, READONLY

H_ADDR					EQU 0x40000200				
X_ADDR					EQU	0x40000300
output_ADDR				EQU	0x40000400

X_reg					RN		0
H_reg					RN		1
n_filter				RN		2
accumulator				RN		3
output_reg				RN		4
data_counter			RN		5
y_counter				RN		6

						ENTRY

main					LDR output_reg, =output_ADDR
						LDR X_reg, =X_ADDR	
						LDR H_reg, =H_ADDR
						MOV data_counter, #1
						
						LDR r7, =H_DATA								; addr(elements of H)
						
STR_H					LDR r8, [r7], #4							; loading elements of H by post-indexing
						STR r8, [H_reg, -data_counter, LSL #2]		; store elements of H in FD stack
						ADD data_counter, #1
						CMP data_counter, #8
						BNE STR_H
						
						MOV data_counter, #1
						LDR r7, =X_DATA								; addr(elements of X)
						
STR_X					LDR r8, [r7], #4							; loading elements of X by post-indexing
						STR r8, [X_reg, -data_counter, LSL #2]		; store elements of X in FD stack
						ADD data_counter, #1
						CMP data_counter, #11
						BNE STR_X
						
						MOV y_counter, #1							; initialise outer loop counter
						
y_loop					LDR sp, =0x40000100									; re-initialise SP to base at every iteration
						MOV	accumulator, #0	; initialise accumulator		; re-initialise accumulator to zero at every iteration
						MOV n_filter, #7	; to be used as counter			; re-initialise n_filter to 7 at every iteration
						STMFD sp!, {n_filter, accumulator, H_reg, X_reg}	
						
						BL	multiplyAdd
						LDMFD sp!, {n_filter, accumulator, H_reg, X_reg}
						STR accumulator, [output_reg, -y_counter, LSL #2]
						ADD y_counter, #1
						CMP y_counter, #5
						BNE y_loop											; go to next iteration on outer loop
						
stop					B	stop
						
multiplyAdd				STMFD sp!, {r5-r8, lr}
						LDR r5, [sp, #20]	; X_reg
						SUB r11, y_counter, #1								; counter for addr(X_DATA) is one less than loop counter
						SUB r5, r11, LSL #2
						LDR r6, [sp, #24]	; H_reg
						LDR r7, [sp, #28]	; n_filter
						LDR r8, [sp, #32]	; accumulator
						
loop					LDR	r9, [r5, #-4]!	; current_X
						LDR r10, [r6, #-4]!	; current_H
						MLA r8, r9, r10, r8	; accumulate
						SUBS r7, #1			; decrement counter
						BNE loop			; continue total 7 times
						
						LSR r8, #15			;	convert back to Q32.0
						STR r8, [sp, #32]	
						LDMFD sp!, {r5-r8, pc}

H_DATA					DCD		0xFFFFFBE7, 0x000004DD, 0x00000625, 0xFFFFF9DB, 0x00000625, 0x000004DD, 0xFFFFFBE7
X_DATA					DCD		0x0034, 0xFF24, 0xFF12, 0x0034, 0x0024, 0x0012, 0x0010, 0x0120, 0x0142, 0x0030
	
						END