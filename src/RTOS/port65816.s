
;----------------------------------------------------------------------------------
;	void outbyte(int c);
;----------------------------------------------------------------------------------
;	module	outbyte
;	include homebrewWDC.inc
;	code
;	xdef	~~outbyte
;	func
;	
;~~outbyte:
;
;
;s_character	set 4
;	sep	#M
;	longa	off
;	
;	IF PLATFORM=0
;chrout1:
;	lda	#64
;	and	>LSR0
;	beq	chrout1
;	lda	s_character,s	
;	sta	>THR0
;	ENDIF
;	
;	IF PLATFORM=1
;	lda	#4
;outbyte1:
;	bit	SB+STATA
;	beq	outbyte1
;	
;	lda	s_character,s
;	sta	SB+TRANSA
;	ENDIF
;
;	plx	;pop return addr
;	pla	;pop bank
;
;	ply	;pop argument
;	
;	pha	;push bank
;	phx	;push return addr
;	rep	#M
;	
;	rtl
;
;	ends
;	efunc
;	endmod


;----------------------------------------------------------------------------------
;       void vPortEndScheduler( void )
;----------------------------------------------------------------------------------
	module	vPortEndScheduler
	code
	xdef	~~vPortEndScheduler
	
	func

~~vPortEndScheduler:

	rtl
	
	ends
	efunc
	endmod
	
	
;----------------------------------------------------------------------------------
;       portBASE_TYPE xPortStartScheduler( void )
;----------------------------------------------------------------------------------
	module	xPortStartScheduler
	code
	xdef	~~xPortStartScheduler
	xref	~~pxCurrentTCB
	xref	~~prvSetupTimerInterrupt
	func

~~xPortStartScheduler:

	jsl	~~prvSetupTimerInterrupt

	lda	~~pxCurrentTCB+2
	pha
	lda	~~pxCurrentTCB
	pha
	tsc
	tcd
	lda	[$1]

	tcs
	
	plb
	pld
	ply
	plx
	pla
	rti
	
	ends
	efunc
	endmod

;----------------------------------------------------------------------------------
;       static void prvSetupTimerInterrupt( void )
;----------------------------------------------------------------------------------
	module	prvSetupTimerInterrupt
	code
	xdef	~~prvSetupTimerInterrupt
	xref	~~vPortYieldFromTick
	func

	include "homebrewWDC.inc"
	
~~prvSetupTimerInterrupt:

	lda	#JMLOP			; point IRQ-vec to JML instruction
	sta	>IRQVEC
	
	lda	#~~vPortYieldFromTick	
	sta	>JMLADR			; populate lo/hi of JML instruction
	

	IF PLATFORM=0
	lda	>CONST5MS		;8.333333Mhz / 200Hz
	sta	>TIMERLO
	
	sep	#M
	longa	off

	lda	#$5C			;JML opcode
	sta	>JMLOP
	lda	#^~~vPortYieldFromTick	; populate bank of JML instruction
	sta	>JMLADR+2
	
	lda	#3
	sta	>TIMERST
	
;	lda	#$ff
;	sta	>ColBorder
	
	rep	#M
	longa	on
	ENDIF
	
	IF PLATFORM=1
	sep	#M
	longa	off
	
	lda	#<9216	;3686400 / 2 = 1843200; 1843200Hz / 200Hz (5ms) = 9216; 36864
	sta	SB+CNTLSB
	lda	#>9216
	sta	SB+CNTMSB
		
	lda	#8
	sta	SB+IMR
		
	rep	#M
	longa	on
	ENDIF
	
	rtl
		
	ends
	efunc
	endmod


;----------------------------------------------------------------------------------
;       pxNewTCB->pxTopOfStack = pxPortInitialiseStack( pxTopOfStack, pxTaskCode, pvParameters );
;----------------------------------------------------------------------------------
	module	pxPortInitialiseStack
	code
	xdef	~~pxPortInitialiseStack
	xref	__printf
	func

	include	"homebrewWDC.inc"

~~pxPortInitialiseStack:
return_adr_lo	set 1
return_adr_hi	set 2
return_adr_bank	set 3	
s_pxTopOfStack	set 4		;+5+6+7
s_pxTaskCode	set 8		;+9+10+11
s_pvParameters	set 12		;+13+14+15

	tsc
	phd
	tcd
	
	sec
	lda	<s_pxTopOfStack
	sbc	#20
	sta	<s_pxTopOfStack

	ldy	#11
	lda	<s_pxTaskCode
	sta	[s_pxTopOfStack],y
	
	dey
	lda	#0
	tax
	
	sep	#M
	longa	off
	
istack0:
	sta	[s_pxTopOfStack],y
	dey	
	bne	istack0

	
	ldy	#13
	lda	<s_pxTaskCode+2
	sta	[s_pxTopOfStack],y

		
	ldy	#1			; data bank = program bank
	sta	[s_pxTopOfStack],y
	
	
	rep	#M
	longa	on

	ldy	#17
	lda	<s_pvParameters
	sta	[s_pxTopOfStack],y
	ldy	#19
	lda	<s_pvParameters+2
	sta	[s_pxTopOfStack],y
	
	lda	<1
	sta	<13
	lda	<2
	sta	<14

	ldy	<s_pxTopOfStack
	
	pld
	
	clc
	tsc
	adc	#12
	tcs
	
	tya

	rtl

;	plb		offset 	1
;	pld			2
;	ply			4
;	plx			6
;	pla			8
;	status			10
;	return addr lo/hi	11
;	return addr bank	13
;	pvParameters_lo		14

;	return addr dummy	15+16+17

;	pvParameters_hi		18
;	pvParameters_bank	19
;	pvParameters_dummy	20
	
;txt:	.byte "IStack: %04X %04X %04X", 10, 0

	ends
	efunc
	endmod
	
	
;----------------------------------------------------------------------------------
;	void vPortYield( void )
;----------------------------------------------------------------------------------
	module	vPortYield
	code
	xdef	~~vPortYield
	xref	~~vTaskSwitchContext
	xref	~~pxCurrentTCB
	xref	__printf
	func
	
	include	"homebrewWDC.inc"
	
~~vPortYield:

	php
	sei

	rep	#M+IX
	longa	on
	longi	on
	
	sta	saveAccu
	stx	saveX

	sep	#M
	longa	off
	
	pla			;pop status
	plx			;pop RTS-Addr
	inx			;add 1
	phx			;push return addr for RTI
	pha			;push status
	
	rep	#M
	longa	on

	lda	saveAccu
	pha
	ldx	saveX
	phx
	phy
	phd
	phb	

	lda	~~pxCurrentTCB+2
	pha
	lda	~~pxCurrentTCB
	pha
	tsc
	tcd
	clc
	adc	#4	
	sta	[$1]
	
	jsl	~~vTaskSwitchContext

	lda	~~pxCurrentTCB+2
	pha
	lda	~~pxCurrentTCB
	pha	
	tsc
	tcd
	lda	[$1]
	tcs
	
	plb
	pld
	ply
	plx
	pla	
	rti
	
saveAccu:
	.word 0
saveX:
	.word 0
	
	ends
	efunc
	endmod
;----------------------------------------------------------------------------------
;	vPortYieldFromTick;
;----------------------------------------------------------------------------------
	module	vPortYieldFromTick
	code
	xdef	~~vPortYieldFromTick
	xref	~~xTaskIncrementTick
	xref	~~vTaskSwitchContext
	xref	~~pxCurrentTCB
	xref	__printf
	func

	include "homebrewWDC.inc"
	
~~vPortYieldFromTick:

	rep	#M+IX
	longa	on
	longi	on
	
	pha
	phx
	phy
	phd
	phb
	
	;cld
	
	lda	#0		;set direct to 0
	tcd

	sep	#M+IX
	longa	off
	longi	off
	
	pha			;set data bank to 0
	plb
	
	lda	>PS2STATUS	;key available?
	bne	irqtimer	;Bit 0 = 0?, no =>
	jsl	jkgbirq		;perform key activities
	
irqtimer:		
	IF PLATFORM=0
	
	lda >TIMERST		;timer underrun?
	bpl irqend		;no, leave

	lda #1			;reset status bit
	sta >TIMERST
	
;	lda >colorBorderLo	;colourize!
;	eor #$ff
;	sta >colorBorderLo	

	ENDIF
	
	IF PLATFORM=1
	lda	SB+ISR		;IRQ caused by timer?
	and	#8
	beq	irqend		;no, leave
	lda	SB+STOPCNT	;reset status flag
	ENDIF
	
	phk			;data bank = program bank ($01)
	plb
	
	rep	#M+IX
	longa	on
	longi	on

	lda	~~pxCurrentTCB+2
	pha
	lda	~~pxCurrentTCB
	pha
	tsc
	tcd
	clc
	adc	#4	
	sta	[$1]

	jsl	~~xTaskIncrementTick
	jsl	~~vTaskSwitchContext
	
	lda	~~pxCurrentTCB+2
	pha
	lda	~~pxCurrentTCB
	pha	
	tsc
	tcd
	lda	[$1]
	tcs
	
irqend:
	rep	#M+IX
	plb
	pld
	ply
	plx
	pla
	rti

	ends
	efunc
	endmod