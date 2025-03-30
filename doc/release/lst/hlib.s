;:ts=8
	module	getFreeIocb
	code
	xdef	__getFreeIocb
	func
__getFreeIocb:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
p_1	set	0
i_1	set	2
	lda	#$280
	sta	<L3+p_1
	sep	#$20
	longa	off
	stz	<L3+i_1
	rep	#$20
	longa	on
	bra	L10004
L10003:
	sep	#$20
	longa	off
	lda	(<L3+p_1)
	cmp	#<$ff
	rep	#$20
	longa	on
	beq	L10002
	lda	#$10
	clc
	adc	<L3+p_1
	sta	<L3+p_1
	sep	#$20
	longa	off
	inc	<L3+i_1
	rep	#$20
	longa	on
L10004:
	sep	#$20
	longa	off
	lda	<L3+i_1
	cmp	#<$8
	rep	#$20
	longa	on
	bcc	L10003
L10002:
	lda	<L3+i_1
	and	#$ff
	tay
	pld
	tsc
	clc
	adc	#L2
	tcs
	tya
	rts
L2	equ	3
L3	equ	1
	ends
	efunc
	endmod
	module	isatty
	code
	xdef	__isatty
	func
__isatty:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L7
	tcs
	phd
	tcd
fd_0	set	3
	lda	<L7+fd_0
	asl	A
	sta	<1
	ldx	<1
	lda	|__c2iocb+1,X
	and	#$ff
	tay
	lda	<L7+1
	sta	<L7+1+2
	pld
	tsc
	clc
	adc	#L7+2
	tcs
	tya
	rts
L7	equ	4
L8	equ	5
	xref	__c2iocb
	ends
	efunc
	endmod
	module	creat
	code
	xdef	__creat
	func
__creat:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L10
	tcs
	phd
	tcd
_name_0	set	3
_mode_0	set	5
	lda	#$1
	tay
	lda	<L10+1
	sta	<L10+1+4
	pld
	tsc
	clc
	adc	#L10+4
	tcs
	tya
	rts
L10	equ	0
L11	equ	1
	ends
	efunc
	endmod
	module	read
	code
	xdef	__read
	func
__read:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L13
	tcs
	phd
	tcd
fd_0	set	3
p_0	set	5
len_0	set	7
len0_1	set	0
len1_1	set	2
iocb_1	set	4
	lda	<L13+fd_0
	asl	A
	sta	<1
	sep	#$20
	longa	off
	ldx	<1
	lda	|__c2iocb,X
	sta	<L14+iocb_1
	rep	#$20
	longa	on
	lda	<L13+fd_0
	asl	A
	sta	<1
	ldx	<1
	lda	|__c2iocb+1,X
	and	#$ff
	beq	L10005
	lda	#$1
	sta	<L13+len_0
L10005:
	pei	<L13+len_0
	pei	<L13+p_0
	pei	<L14+iocb_1
	jsr	__getchr
	lda	<L14+iocb_1
	and	#$ff
	sta	<5
	asl	A
	asl	A
	asl	A
	asl	A
	sta	<1
	lda	#$280
	sta	<5
	lda	#$7
	clc
	adc	<1
	sta	<9
	ldy	<9
	lda	(<5),Y
	tay
	lda	<L13+1
	sta	<L13+1+6
	pld
	tsc
	clc
	adc	#L13+6
	tcs
	tya
	rts
L13	equ	17
L14	equ	13
	xref	__getchr
	xref	__c2iocb
	ends
	efunc
	endmod
	module	unlink
	code
	xdef	__unlink
	func
__unlink:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L17
	tcs
	phd
	tcd
p_0	set	3
	lda	#$1
	tay
	lda	<L17+1
	sta	<L17+1+2
	pld
	tsc
	clc
	adc	#L17+2
	tcs
	tya
	rts
L17	equ	0
L18	equ	1
	ends
	efunc
	endmod
	module	write
	code
	xdef	__write
	func
__write:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L20
	tcs
	phd
	tcd
fd_0	set	3
p_0	set	5
len_0	set	7
	pei	<L20+len_0
	pei	<L20+p_0
	lda	<L20+fd_0
	asl	A
	sta	<1
	ldx	<1
	lda	|__c2iocb,X
	and	#$ff
	pha
	jsr	__putchr
	lda	<L20+len_0
	tay
	lda	<L20+1
	sta	<L20+1+6
	pld
	tsc
	clc
	adc	#L20+6
	tcs
	tya
	rts
L20	equ	4
L21	equ	5
	xref	__putchr
	xref	__c2iocb
	ends
	efunc
	endmod
	module	lseek
	code
	xdef	__lseek
	func
__lseek:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L23
	tcs
	phd
	tcd
i_0	set	3
j_0	set	5
k_0	set	9
	lda	#$0
	tax
	ina
	tay
	lda	<L23+1
	sta	<L23+1+8
	pld
	tsc
	clc
	adc	#L23+8
	tcs
	tya
	rts
L23	equ	0
L24	equ	1
	ends
	efunc
	endmod
	module	close
	code
	xdef	__close
	func
__close:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L26
	tcs
	phd
	tcd
fd_0	set	3
	sec
	lda	#$2
	sbc	<L26+fd_0
	bvs	L28
	eor	#$8000
L28:
	bmi	L10006
	lda	<L26+fd_0
	asl	A
	sta	<1
	ldx	<1
	lda	|__c2iocb,X
	pha
	jsr	__aclose
L10006:
	lda	#$0
	tay
	lda	<L26+1
	sta	<L26+1+2
	pld
	tsc
	clc
	adc	#L26+2
	tcs
	tya
	rts
L26	equ	4
L27	equ	5
	xref	__aclose
	xref	__c2iocb
	ends
	efunc
	endmod
	module	open
	code
	xdef	__open
	func
__open:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L31
	tcs
	phd
	tcd
fname_0	set	3
mode_0	set	5
iorc_1	set	0
iocb_1	set	1
isatty_1	set	2
piob_1	set	3
fd_1	set	5
	jsr	___getiob
	sta	<L32+piob_1
	sec
	sbc	#<___iob
	sta	<1
	ldx	#<$e
	xref	__~div
	jsr	__~div
	sta	<L32+fd_1
	sep	#$20
	longa	off
	stz	<L32+isatty_1
	lda	(<L31+fname_0)
	cmp	#<$45
	rep	#$20
	longa	on
	beq	L33
	sep	#$20
	longa	off
	lda	(<L31+fname_0)
	cmp	#<$52
	rep	#$20
	longa	on
	beq	L33
	sep	#$20
	longa	off
	lda	(<L31+fname_0)
	cmp	#<$4b
	rep	#$20
	longa	on
	bne	L10007
L33:
	sep	#$20
	longa	off
	lda	#$1
	sta	<L32+isatty_1
	rep	#$20
	longa	on
L10007:
	lda	<L32+fd_1
	xref	__~swt
	jsr	__~swt
	dw	3
	dw	0
	dw	L10010-1
	dw	1
	dw	L10012-1
	dw	2
	dw	L10012-1
	dw	L10013-1
L10010:
	sep	#$20
	longa	off
	lda	#$7
	sta	<L32+iocb_1
	rep	#$20
	longa	on
L10009:
	lda	<L32+fd_1
	beq	L10015
	lda	<L32+fd_1
	cmp	#<$2
	beq	L10015
	pei	<L32+iocb_1
	jsr	__aclose
	pea	#<$0
	pea	#<$c
	pei	<L31+fname_0
	pei	<L32+iocb_1
	jsr	__aopen
	sep	#$20
	longa	off
	sta	<L32+iorc_1
	cmp	#<$80
	rep	#$20
	longa	on
	bcs	L20000
L10015:
	lda	<L32+fd_1
	asl	A
	sta	<1
	sep	#$20
	longa	off
	lda	<L32+iocb_1
	ldx	<1
	sta	|__c2iocb,X
	rep	#$20
	longa	on
	lda	<L32+fd_1
	asl	A
	sta	<1
	sep	#$20
	longa	off
	lda	<L32+isatty_1
	ldx	<1
	sta	|__c2iocb+1,X
	rep	#$20
	longa	on
	lda	<L32+fd_1
	bra	L38
L10012:
	sep	#$20
	longa	off
	stz	<L32+iocb_1
	rep	#$20
	longa	on
	bra	L10009
L10013:
	jsr	__getFreeIocb
	sep	#$20
	longa	off
	sta	<L32+iocb_1
	cmp	#<$8
	rep	#$20
	longa	on
	bcc	L10009
L20000:
	lda	#$ffff
L38:
	tay
	lda	<L31+1
	sta	<L31+1+4
	pld
	tsc
	clc
	adc	#L31+4
	tcs
	tya
	rts
L31	equ	11
L32	equ	5
	xref	__aopen
	xref	__aclose
	xref	__getFreeIocb
	xref	___getiob
	xref	__c2iocb
	xref	___iob
	ends
	efunc
	endmod
	module	getErrorString
	code
	xdef	__getErrorString
	func
__getErrorString:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L42
	tcs
	phd
	tcd
iorc_0	set	3
	lda	<L42+iorc_0
	and	#$ff
	xref	__~swt
	jsr	__~swt
	dw	22
	dw	1
	dw	L10019-1
	dw	128
	dw	L10020-1
	dw	129
	dw	L10021-1
	dw	130
	dw	L10022-1
	dw	131
	dw	L10023-1
	dw	132
	dw	L10024-1
	dw	133
	dw	L10025-1
	dw	134
	dw	L10026-1
	dw	135
	dw	L10027-1
	dw	136
	dw	L10028-1
	dw	137
	dw	L10029-1
	dw	138
	dw	L10030-1
	dw	139
	dw	L10031-1
	dw	140
	dw	L10032-1
	dw	141
	dw	L10033-1
	dw	142
	dw	L10034-1
	dw	143
	dw	L10035-1
	dw	144
	dw	L10036-1
	dw	145
	dw	L10037-1
	dw	146
	dw	L10038-1
	dw	147
	dw	L10039-1
	dw	170
	dw	L10040-1
	dw	L10041-1
L10019:
	lda	#<L1
L44:
	tay
	lda	<L42+1
	sta	<L42+1+2
	pld
	tsc
	clc
	adc	#L42+2
	tcs
	tya
	rts
L10020:
	lda	#<L1+21
	bra	L44
L10021:
	lda	#<L1+37
	bra	L44
L10022:
	lda	#<L1+61
	bra	L44
L10023:
	lda	#<L1+86
	bra	L44
L10024:
	lda	#<L1+119
	bra	L44
L10025:
	lda	#<L1+141
	bra	L44
L10026:
	lda	#<L1+168
	bra	L44
L10027:
	lda	#<L1+193
	bra	L44
L10028:
	lda	#<L1+225
	bra	L44
L10029:
	lda	#<L1+243
	bra	L44
L10030:
	lda	#<L1+266
	bra	L44
L10031:
	lda	#<L1+298
	bra	L44
L10032:
	lda	#<L1+340
	bra	L44
L10033:
	lda	#<L1+365
	bra	L44
L10034:
	lda	#<L1+388
	bra	L44
L10035:
	lda	#<L1+418
	bra	L44
L10036:
	lda	#<L1+444
	bra	L44
L10037:
	lda	#<L1+485
	bra	L44
L10038:
	lda	#<L1+514
	bra	L44
L10039:
	lda	#<L1+556
	bra	L44
L10040:
	lda	#<L1+598
	bra	L44
L10041:
	lda	#<L1+626
	bra	L44
L42	equ	0
L43	equ	1
	ends
	efunc
	data
L1:
	db	$73,$75,$63,$63,$65,$73,$73,$66,$75,$6C,$20,$6F,$70,$65,$72
	db	$61,$74,$69,$6F,$6E,$00,$42,$52,$45,$41,$4B,$20,$6B,$65,$79
	db	$20,$61,$62,$6F,$72,$74,$00,$49,$4F,$43,$42,$20,$61,$6C,$72
	db	$65,$61,$64,$79,$20,$6F,$70,$65,$6E,$20,$65,$72,$72,$6F,$72
	db	$00,$6E,$6F,$6E,$65,$78,$69,$73,$74,$65,$6E,$74,$20,$64,$65
	db	$76,$69,$63,$65,$20,$65,$72,$72,$6F,$72,$00,$49,$4F,$43,$42
	db	$20,$6F,$70,$65,$6E,$65,$64,$20,$66,$6F,$72,$20,$77,$72,$69
	db	$74,$65,$20,$6F,$6E,$6C,$79,$20,$65,$72,$72,$6F,$72,$00,$69
	db	$6E,$76,$61,$6C,$69,$64,$20,$63,$6F,$6D,$6D,$61,$6E,$64,$20
	db	$65,$72,$72,$6F,$72,$00,$64,$65,$76,$69,$63,$65,$2F,$66,$69
	db	$6C,$65,$20,$6E,$6F,$74,$20,$6F,$70,$65,$6E,$20,$65,$72,$72
	db	$6F,$72,$00,$69,$6E,$76,$61,$6C,$69,$64,$20,$49,$4F,$43,$42
	db	$20,$69,$6E,$64,$65,$78,$20,$65,$72,$72,$6F,$72,$00,$49,$4F
	db	$43,$42,$20,$6F,$70,$65,$6E,$65,$64,$20,$66,$6F,$72,$20,$72
	db	$65,$61,$64,$20,$6F,$6E,$6C,$79,$20,$65,$72,$72,$6F,$72,$00
	db	$65,$6E,$64,$20,$6F,$66,$20,$66,$69,$6C,$65,$20,$65,$72,$72
	db	$6F,$72,$00,$74,$72,$75,$6E,$63,$61,$74,$65,$64,$20,$72,$65
	db	$63,$6F,$72,$64,$20,$65,$72,$72,$6F,$72,$00,$70,$65,$72,$69
	db	$70,$68,$65,$72,$61,$6C,$20,$64,$65,$76,$69,$63,$65,$20,$74
	db	$69,$6D,$65,$6F,$75,$74,$20,$65,$72,$72,$6F,$72,$00,$64,$65
	db	$76,$69,$63,$65,$20,$64,$6F,$65,$73,$20,$6E,$6F,$74,$20,$61
	db	$63,$6B,$6E,$6F,$77,$6C,$65,$64,$67,$65,$20,$63,$6F,$6D,$6D
	db	$61,$6E,$64,$20,$65,$72,$72,$6F,$72,$00,$73,$65,$72,$69,$61
	db	$6C,$20,$62,$75,$73,$20,$66,$72,$61,$6D,$69,$6E,$67,$20,$65
	db	$72,$72,$6F,$72,$00,$63,$75,$72,$73,$6F,$72,$20,$6F,$76,$65
	db	$72,$72,$61,$6E,$67,$65,$20,$65,$72,$72,$6F,$72,$00,$73,$65
	db	$72,$69,$61,$6C,$20,$62,$75,$73,$20,$64,$61,$74,$61,$20,$6F
	db	$76,$65,$72,$72,$75,$6E,$20,$65,$72,$72,$6F,$72,$00,$73,$65
	db	$72,$69,$61,$6C,$20,$62,$75,$73,$20,$63,$68,$65,$63,$6B,$73
	db	$75,$6D,$20,$65,$72,$72,$6F,$72,$00,$64,$65,$76,$69,$63,$65
	db	$20,$64,$6F,$6E,$65,$20,$28,$6F,$70,$65,$72,$61,$74,$69,$6F
	db	$6E,$20,$69,$6E,$63,$6F,$6D,$70,$6C,$65,$74,$65,$29,$20,$65
	db	$72,$72,$6F,$72,$00,$62,$61,$64,$20,$73,$63,$72,$65,$65,$6E
	db	$20,$6D,$6F,$64,$65,$20,$6E,$75,$6D,$62,$65,$72,$20,$65,$72
	db	$72,$6F,$72,$00,$66,$75,$6E,$63,$74,$69,$6F,$6E,$20,$6E,$6F
	db	$74,$20,$69,$6D,$70,$6C,$65,$6D,$65,$6E,$74,$65,$64,$20,$69
	db	$6E,$20,$68,$61,$6E,$64,$6C,$65,$72,$20,$65,$72,$72,$6F,$72
	db	$00,$69,$6E,$73,$75,$66,$66,$69,$63,$69,$65,$6E,$74,$20,$6D
	db	$65,$6D,$6F,$72,$79,$20,$66,$6F,$72,$20,$73,$63,$72,$65,$65
	db	$6E,$20,$6D,$6F,$64,$65,$20,$65,$72,$72,$6F,$72,$00,$66,$69
	db	$6C,$65,$20,$6F,$72,$20,$64,$69,$72,$65,$63,$74,$6F,$72,$79
	db	$20,$6E,$6F,$74,$20,$66,$6F,$75,$6E,$64,$00,$75,$6E,$6B,$6E
	db	$6F,$77,$6E,$20,$65,$72,$72,$6F,$72,$00
	ends
	endmod
	module	printErr
	code
	xdef	__printErr
	func
__printErr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L46
	tcs
	phd
	tcd
iorc_0	set	3
s_1	set	0
	pei	<L46+iorc_0
	jsr	__getErrorString
	sta	<L47+s_1
	pha
	jsr	__strlen
	pha
	pei	<L47+s_1
	pea	#<$0
	jsr	__putchr
	lda	<L46+1
	sta	<L46+1+2
	pld
	tsc
	clc
	adc	#L46+2
	tcs
	rts
L46	equ	2
L47	equ	1
	xref	__strlen
	xref	__putchr
	xref	__getErrorString
	ends
	efunc
	endmod
