;
; LAB1.asm
;
; Created: 01-09-2021 16:20:39
; Author : Shradha
;


.CSEG
        LDI R17, $12  ;Load R17 with 0x12
		LDI R18, $29  ;Load R18 with 0x29
		ADD R17, R18  ; Adds both the values and stores the result(0x3B) in R17
NOP

.CSEG
        LDI R17, $05  ;Load R17 with lower byte of 1st number
		LDI R18, $10  ;Load R18 with higher byte of 1st number
		LDI R19, $11  ;Load R19 with lower byte of 2nd number to be added
		LDI R20, $12  ;Load 20 with lower byte of 2nd number to be added
		LDI R16, $00  ;Intialising R16 with 0
		ADD R17,R19   ;Add lower bytes
		ADC R18, R20  ;Add the higher bytes with carry
		BRCC abc      ;if no carry then skip to end
		LDI R16, $01  ;if carry then value 1 is stored in R16
abc:    
NOP

.CSEG
        LDI R16, $15  ;Load R16 with 0x15
		LDI R17, $25  ;Load R17 with Ox25
		MUL R16, R17  ;Multipy the contents of R16 and R17( result gets stored in R0 and R1)
NOP

.CSEG
       LDI ZL, LOW(NUM<<1)
	   LDI ZH, HIGH(NUM<<1)
	   LDI XL, $60
	   LDI XH, $00
	   LPM R0, Z+
	   LPM R1, Z+
	   
	   
	   CP R0, R1
	   BRCC aaa
	       MOV R1, R0
		   
aaa:  ST X, R1 

NOP
NUM:  .db $20, $21






