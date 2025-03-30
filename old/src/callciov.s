	
;----------------------------------------------------------------------------------
;	char xio(char channel, char cmd, const char *s, int len, int aux1, int aux2)
;----------------------------------------------------------------------------------
	module	xio
	include homebrewWDC.inc
	code
	xdef	__xio
	func
	
__xio:

s_channel	set 3
s_cmd		set 5
s_s		set 7
s_len		set 9
s_aux1		set 11
s_aux2		set 13

	sep	#M+IX		;A+IX = 8
	longa	off
	longi	off
	
	lda	s_channel,s
	asl
	asl
	asl
	asl
	tax

	lda	s_cmd,s		;cmd
	sta	ICCOM,x
	lda	s_aux1,s	;aux1
	sta	ICCOM,x
	lda	s_aux2,s	;aux2
	sta	ICCOM,x
	
	rep	#M
	longa	on
	
	lda	s_len,s
	sta	ICBLL,x
	lda	s_s,s
	sta	ICBAL,x
	
	phd
	lda	#0
	tcd	
	
	sep 	#$30
	longa	off
	longi	off
	
	jsr	$C00F
	
	pld	
	rep 	#M+IX+CARRY
	longa on
	longi on

	plx	;return adr
	tsc
	adc 	#12
	tcs
	phx
	tya
	rts
	
	ends
	efunc
	endmod
	

;--------------------------------------------------------------------
;	char callCIOV(char channel, char cmd, const char *s, int len)
;--------------------------------------------------------------------
	module	callCIOV
	include homebrewWDC.inc
	code
	xdef	__callCIOV
	func
	
__callCIOV:

s_channel	set 3
s_cmd		set 5
s_s		set 7
s_len		set 9

	sep	#M+IX		;A+IX = 8
	longa	off
	longi	off
	
	lda	s_channel,s
	asl
	asl
	asl
	asl
	tax

	lda	s_cmd,s		;cmd
	sta	ICCOM,x
	
	rep	#M
	longa	on
	
	lda	s_len,s
	sta	ICBLL,x
	lda	s_s,s
	sta	ICBAL,x
	
	phd
	lda	#0
	tcd	
	
	sep 	#$30
	longa	off
	longi	off
	
	jsr	$C00F
	
	pld	
	rep 	#M+IX+CARRY
	longa on
	longi on

	plx	;return adr
	tsc
	adc 	#8
	tcs
	phx
	tya
	rts
	
	ends
	efunc
	endmod
	
;--------------------------------------------------------------------
;	char aopen(char channel, const char *s, char aux1, char aux2)
;--------------------------------------------------------------------
	module	aopen
	include homebrewWDC.inc
	code
	xdef	__aopen
	func
	
__aopen:

s_channel	set 3
s_s		set 5
s_aux1		set 7
s_aux2		set 9

	sep	#M+IX		;A+IX = 8
	longa	off
	longi	off
	
	lda	s_channel,s
	asl
	asl
	asl
	asl
	tax

	lda	#OPEN		;cmd
	sta	ICCOM,x
	lda	s_aux1,s
	sta	ICAX1,x
	lda	s_aux2,s
	sta	ICAX2,x
	
	rep	#M
	longa	on
	lda	s_s,s
	sta	ICBAL,x
	
	phd
	lda	#0
	tcd	
	
	sep 	#$30
	longa	off
	longi	off
	
	jsr	$C00F
	
	pld	
	rep 	#M+IX+CARRY
	longa on
	longi on

	plx	;return adr
	tsc
	adc 	#8
	tcs
	phx
	tya
	rts
	
	ends
	efunc
	endmod
	
	
;-----------------------------------------------------------------------------
;	char aclose(char channel)
;-----------------------------------------------------------------------------
	module	aclose
	include homebrewWDC.inc
	code
	xdef	__aclose
	xref	__callCIOV
	func
	
__aclose:

s_channel	set 3

	pea	#0
	pea	#0
	pea	#CLOSE
	lda	s_channel+6,s
	pha
	jsr	__callCIOV
	plx			;pop return address
	ply			;discard channel from stack
	phx			;push return address
	rts
	
	ends
	efunc
	endmod


;-----------------------------------------------------------------------------
;	char getchr(char channel, char *s, int len)
;-----------------------------------------------------------------------------
	module	getchr
	include homebrewWDC.inc
	code
	xdef	__getchr
	xref	__callCIOV
	func
	
__getchr:

s_channel	set 3
s_s		set 5
s_len		set 7

	lda	s_len,s
	pha
	lda	s_s+2,s
	pha
	pea	#GETCHR
	lda	s_channel+6,s
	pha
	
	jsr	__callCIOV
	
	plx			;pop return address
	clc
	tsc
	adc	#6
	tcs
	phx			;push return address
	tya
	rts
	
	ends
	efunc
	endmod
	

;-----------------------------------------------------------------------------
;	char putchr(char channel, char *s, int len)
;-----------------------------------------------------------------------------
	module	putchr
	include homebrewWDC.inc
	code
	xdef	__putchr
	xref	__callCIOV
	func
	
__putchr:

s_channel	set 3
s_s		set 5
s_len		set 7

	lda	s_len,s
	pha
	lda	s_s+2,s
	pha
	pea	#PUTCHR
	lda	s_channel+6,s
	pha
	
	jsr	__callCIOV
	
	plx			;pop return address
	clc
	tsc
	adc	#6
	tcs
	phx			;push return address
	tya
	rts
	
	ends
	efunc
	endmod
	

;-----------------------------------------------------------------------------
;	char getrec(char channel, char *s)
;-----------------------------------------------------------------------------
	module	getrec
	include homebrewWDC.inc
	code
	xdef	__getrec
	xref	__callCIOV
	func
	
__getrec:

s_channel	set 3
s_s		set 5

	pea	#128
	lda	s_s+2,s
	pha
	pea	#GETREC
	lda	s_channel+6,s
	pha
	
	jsr	__callCIOV
	
	plx			;pop return address
	clc
	tsc
	adc	#4
	tcs
	phx			;push return address
	tya
	rts
	
	ends
	efunc
	endmod
	
;-----------------------------------------------------------------------------
;	char putrec(char channel, char *s)
;-----------------------------------------------------------------------------
	module	putrec
	include homebrewWDC.inc
	code
	xdef	__putrec
	xref	__callCIOV
	func
	
__putrec:

s_channel	set 3
s_s		set 5

	pea	#128
	lda	s_s+2,s
	pha
	pea	#PUTREC
	lda	s_channel+6,s
	pha

	jsr	__callCIOV

	plx			;pop return address
	clc
	tsc
	adc	#4
	tcs
	phx			;push return address
	tya
	rts
	
	ends
	efunc
	endmod
	
;-----------------------------------------------------------------------------
;	hex(char *buf, char b)
;-----------------------------------------------------------------------------
	module	hex
	include homebrewWDC.inc
	code
	xdef	__hex
	func
	
__hex:

s_p_buf	set 3
s_byte	set 5

	sep	#M+IX
	longa	off
	longi	off
	
	ldy	#0
	lda	s_byte,s	;load byte from stack
	lsr	
	lsr	
	lsr	
	lsr	
	jsr	nibble
	sta	(s_p_buf,s),y
	iny

	lda	s_byte,s	;load byte from stack
	and	#15
	jsr	nibble
	sta	(s_p_buf,s),y
		
	rep	#M+IX
	longa	on
	longi	on
	
	plx			;pop return address
	ply
	ply
	phx			;push return address
	rts
	
nibble:
	longa	off
	longi	off
	clc	
	adc	#'0'
	cmp	#'9'+1
	bcc	nibble99
	adc	#6
nibble99:
	rts

	ends
	efunc
	endmod


;-----------------------------------------------------------------------------
;	hex4(char *buf, int i)
;-----------------------------------------------------------------------------
	module	hex4
	include homebrewWDC.inc
	code
	xdef	__hex4
	xref	__hex
	func
	
__hex4:

s_p_buf	set 3
s_int	set 5
	
	lda	s_int,s	;load byte from stack
	xba
	pha
	lda	s_p_buf+2,s
	pha
	jsr	__hex
	
	lda	s_int,s	;load byte from stack
	pha
	lda	s_p_buf+2,s
	ina
	ina
	pha
	jsr	__hex
	
	plx			;pop return address
	ply
	ply
	phx			;push return address
	rts

	ends
	efunc
	endmod
	
	
;-----------------------------------------------------------------------------
;	hex8(char *buf, unsigned long l)
;-----------------------------------------------------------------------------
	module	hex8
	include homebrewWDC.inc
	code
	xdef	__hex8
	xref	__hex4
	func
	
__hex8:

s_p_buf	set 3
s_intlo	set 5
s_inthi	set 7
	
	lda	s_inthi,s	;load byte from stack
	pha
	lda	s_p_buf+2,s
	pha
	jsr	__hex4
	
	lda	s_intlo,s	;load byte from stack
	pha
	lda	s_p_buf+2,s
	clc
	adc	#4
	pha
	jsr	__hex4
	
	plx			;pop return address
	ply
	ply
	ply
	phx			;push return address
	rts
	
	ends
	efunc
	endmod