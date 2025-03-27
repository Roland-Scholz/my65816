STACK	EQU	$01FF			;CHANGE THIS FOR YOUR SYSTEM
FNAME	EQU 	$0380
EOL	EQU	$0A
ARGC	EQU	$033b			;2-byte number of args
ARGV	EQU	$033d			;8*2-bytes pointer to arg strings

	code
	xdef	__startup	
	func	
	__startup:	
	
START:	
	PHP				;save processor flags (M/X)
	REP 	#$30			;16 bit registers
	LONGI	ON
	LONGA	ON

;	LDA	#_END_DATA-_BEG_DATA 	;number of bytes to copy
;	BEQ	SKIP 			;if none, just skip
;	DEC	A				;less one for MVN instruction
;	LDX	#<_ROM_BEG_DATA		;get source into X
;	LDY	#<_BEG_DATA		;get dest into Y
;	MVN	#^_ROM_BEG_DATA,#^_BEG_DATA ;copy bytes
;SKIP:

	LDX	#_END_UDATA-_BEG_UDATA	;get number of bytes to clear
	BEQ	DONE			;nothing to do
	LDA	#0			;get a zero for storing
	SEP	#$20			;do byte at a time
	LONGA	OFF
	LDY	#_BEG_UDATA		;get beginning of zeros
LOOP:	STA	|0,Y			;clear memory
	INY				;bump pointer
	DEX				;decrement count
	BNE	LOOP			;continue till done
	
;	REP	#$20			;16 bit memory reg

	lda	FNAME
	bne	DONE
copyline:
	lda	line,x
	beq	DONE
	sta	FNAME,x
	inx
	bra	copyline

DONE:
	ldx	#1
	stx	ARGC
	ldx	#FNAME
	stx	ARGV
	ldy	#ARGV
	
CMDLINE:	
	lda	|0,x
	beq	CMDLINE5
	cmp	#' ' 
	bne	CMDLINE1
	stz	|0,x
	bra	CMDLINE5
CMDLINE1:
	cmp	#EOL
	beq	CMDLINE3		;end

	inx
	cpx	#FNAME+128
	bcc	CMDLINE
	bra	CMDLINE3a

CMDLINE5:
	inx
	cpx	#FNAME+128
	bcs	CMDLINE3a
	
	lda	|0,x
	beq	CMDLINE5
	cmp	#' '
	bne	CMDLINE5a
	bra	CMDLINE5

CMDLINE5a:	
	cmp	#EOL
	beq	CMDLINE3
	
	REP	#$20			;A=16
	LONGA	ON
	
	lda	ARGC
	cmp	#8
	bcs	CMDLINE3a
	
	iny
	iny

	txa
	sta	|0,y
	inc	ARGC
	sep	#$20
	LONGA	OFF
	
	bra	CMDLINE
	

CMDLINE3:	
	stz	|0,x
CMDLINE3a:
	REP	#$20			;A=16
	
	pea	#ARGV
	lda	ARGC
	pha
	XREF	__main			;change MYSTART to yours
	JSR	|__main			;long jump in case not bank 0
ENDE:
	PLP
	RTS

	ends
	efunc
	
	data
line:
	db "Test Parm1   Parm2", EOL, 0
	ends
	
	XREF	_ROM_BEG_DATA
	XREF	_BEG_DATA
	XREF	_END_DATA
	XREF	_BEG_UDATA
	XREF	_END_UDATA