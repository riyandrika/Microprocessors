				AREA L3002B_Q3, CODE, READONLY
				
H_ADDR			EQU 0x40000200				
X_ADDR			EQU	0x40000300
output_ADDR		EQU	0x40000400

X_reg			RN		0
H_reg			RN		1
n_filter		RN		2
accumulator		RN		3
output_reg		RN		4

				ENTRY
				CODE32
				
main			LDR output_reg, =output_ADDR
				LDR r5, =X_DATA
				LDM r5, {r6-r12}  ; Load X_DATA
				LDR X_reg, =X_ADDR	
				STMFD X_reg!, {r6-r12}
				LDR r5, =H_DATA
				LDM r5, {r6-r12}	; Load H_DATA
				LDR H_reg, =H_ADDR
				STMFD H_reg!, {r6-r12}
				
				LDR sp, =0x40000100
				MOV	accumulator, #0	; initialise accumulator
				MOV n_filter, #7	; to be used as counter
				STMFD sp!, {n_filter, accumulator, H_reg, X_reg}
				
				BL	veneer
				LDMFD sp!, {n_filter, accumulator, H_reg, X_reg}
				STR accumulator, [output_reg]

stop			B	stop

veneer			LDR r6, =multiplyAdd + 1
				BX r6
				
				CODE16
multiplyAdd		PUSH {r0-r3, lr}
				LDR r0, [sp, #20] ; X_reg
				LDR r1, [sp, #24] ; H_reg
				LDR r2, [sp, #28] ; n_filter
				LDR r3, [sp, #32] ; accmulator
				MOV r4, #4
				
loop			LDR	r5, [r0]
				ADD r0, r4
				LDR r6, [r1]
				ADD r1, r4
				MUL r6, r5
				ADD r3, r6
				SUB r2, #1
				BNE loop
				
				LSR r3, #15
				STR r3, [sp, #32]
				POP {r0-r3, pc}
				
X_DATA			DCD 	0x0034, 0x0024, 0x0012, 0x0010, 0x0120, 0x0142, 0x0030
H_DATA			DCD		0xFFFFFBE7, 0x000004DD, 0x00000625, 0xFFFFF9DB, 0x00000625, 0x000004DD, 0xFFFFFBE7
				
				END
				