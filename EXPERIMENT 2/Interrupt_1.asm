;
; AssemblerApplication6.asm
;
; Created: 23-09-2021 19:48:56
; Author : Shradha
;

   #include "m8def.inc"
	.org 0x0000
rjmp reset          ;Setting the address of reset to 0x0000

.org 0x0002
rjmp int1_ISR       ;Setting the interrupt vector table for int1

.org 0x0100         
;We begin the reset program

reset:
	  ;Loading stack pointer address
      LDI R16,0x70
	  OUT SPL,R16                  ;Initialising lower byte
	  LDI R16,0x00
	  OUT SPH,R16                  ;Initialising higher byte

	  ;Interface port B pin0 to be output
	  ;so to view LED blinking

	   LDI R16,0x01
	   OUT DDRB,R16                 ;Making Port B(PB0 pin) an output port

	  LDI R16,0x00
	  OUT DDRD,R16                  ;Making Port D an input port

	  ;Set MCUCR register to enable low level interrupt
	  IN R16, MCUCR                 ;Putting the current value of MCUCR into R16
	  ANDI R16,0b11110011           ;Anding with 0b1111011 to get int 1 port to be level triggered                 
	  OUT MCUCR,R16

	  ;Set GICR register to enable interrupt 1
	  IN R16,GICR
	  ORI R16,0x80                  ;Setting the last bit of GICR to enable interrupt 1
	  OUT GICR,R16

	  LDI R16,0x00             
	  OUT PORTB,R16                  ;Initialising port B(led not blinking)

	  SEI                            ;Setting the global interrupt
ind_loop:
      rjmp ind_loop

int1_ISR:IN R16,SREG                 ;Begin the interrupt routine
		 PUSH R16                    ;Putting the current value of status register into the stack

		 LDI R16,0x0A                ;Inputting 10 to view the leb blink for 10 times
		 MOV R0,R16                  ;Move it to R0
		 ;Modify below loops to make LED blink for 1 sec
	c1:	 LDI R16,0x01
		 OUT PORTB,R16                ;Setting the pin 0 of port B to make the leb blink
		 LDI R18,4
	a3:  LDI R16, 200                 ;Delay loop
	a1:	 LDI R17,250
	a2:	 NOP
	     NOP
	     DEC R17
		 BRNE a2                       ;250*5*200*4*1(1 microsecond) gives 1s
		 DEC R16
		 BRNE a1
		 DEC R18
		 BRNE a3
		 
		 LDI R16,0x00                 ;Send 0 to port B
		 OUT PORTB,R16
		 LDI R18,4
	b3: LDI R16,200
	b1: LDI R17,250
	b2: NOP
		NOP
		DEC R17
	    BRNE b2
		DEC R16
		BRNE b1
		DEC R18
		BRNE b3

		DEC R0
		BRNE c1
		POP R16
		OUT SREG, R16                  ;Bring back the value previously stored in stack back to status register
		RETI                           ;Return to main program

