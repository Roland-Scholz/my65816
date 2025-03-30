;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
	data
	xdef	~~ucHeap16
~~ucHeap16:
	dl	$1000
	ends
	data
	xdef	~~ucHeap
~~ucHeap:
	dl	$20000
	ends
	data
~~exepath:
	db	$2F,$0
	ds	78
	ends
	code
	xdef	~~debugTaskControl
	func
~~debugTaskControl:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
tc_0	set	4
	pea	#^L1
	pea	#<L1
	pea	#6
	jsl	~~debugf
	ldy	#$2
	lda	[<L2+tc_0],Y
	pha
	lda	[<L2+tc_0]
	pha
	pea	#^L1+19
	pea	#<L1+19
	pea	#10
	jsl	~~debugf
	ldy	#$4
	lda	[<L2+tc_0],Y
	sta	<R0
	stz	<R0+2
	pei	<R0+2
	pei	<R0
	pea	#^L1+43
	pea	#<L1+43
	pea	#10
	jsl	~~debugf
	ldy	#$8
	lda	[<L2+tc_0],Y
	pha
	dey
	dey
	lda	[<L2+tc_0],Y
	pha
	pea	#^L1+67
	pea	#<L1+67
	pea	#10
	jsl	~~debugf
	ldy	#$c
	lda	[<L2+tc_0],Y
	pha
	dey
	dey
	lda	[<L2+tc_0],Y
	pha
	pea	#^L1+91
	pea	#<L1+91
	pea	#10
	jsl	~~debugf
	ldy	#$10
	lda	[<L2+tc_0],Y
	pha
	dey
	dey
	lda	[<L2+tc_0],Y
	pha
	pea	#^L1+115
	pea	#<L1+115
	pea	#10
	jsl	~~debugf
	ldy	#$14
	lda	[<L2+tc_0],Y
	pha
	dey
	dey
	lda	[<L2+tc_0],Y
	pha
	pea	#^L1+139
	pea	#<L1+139
	pea	#10
	jsl	~~debugf
	ldy	#$18
	lda	[<L2+tc_0],Y
	pha
	dey
	dey
	lda	[<L2+tc_0],Y
	pha
	pea	#^L1+163
	pea	#<L1+163
	pea	#10
	jsl	~~debugf
	ldy	#$1c
	lda	[<L2+tc_0],Y
	pha
	dey
	dey
	lda	[<L2+tc_0],Y
	pha
	pea	#^L1+187
	pea	#<L1+187
	pea	#10
	jsl	~~debugf
	ldy	#$0
	phy
	ldy	#$1e
	lda	[<L2+tc_0],Y
	ply
	rol	A
	ror	A
	bpl	L4
	dey
L4:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pea	#^L1+211
	pea	#<L1+211
	pea	#10
	jsl	~~debugf
	ldy	#$22
	lda	[<L2+tc_0],Y
	pha
	dey
	dey
	lda	[<L2+tc_0],Y
	pha
	pea	#^L1+235
	pea	#<L1+235
	pea	#10
	jsl	~~debugf
	ldy	#$26
	lda	[<L2+tc_0],Y
	pha
	dey
	dey
	lda	[<L2+tc_0],Y
	pha
	pea	#^L1+259
	pea	#<L1+259
	pea	#10
	jsl	~~debugf
	ldy	#$28
	lda	[<L2+tc_0],Y
	sta	<R0
	stz	<R0+2
	pei	<R0+2
	pei	<R0
	pea	#^L1+283
	pea	#<L1+283
	pea	#10
	jsl	~~debugf
	ldy	#$2a
	lda	[<L2+tc_0],Y
	sta	<R0
	stz	<R0+2
	pei	<R0+2
	pei	<R0
	pea	#^L1+307
	pea	#<L1+307
	pea	#10
	jsl	~~debugf
	ldy	#$2c
	lda	[<L2+tc_0],Y
	sta	<R0
	stz	<R0+2
	pei	<R0+2
	pei	<R0
	pea	#^L1+331
	pea	#<L1+331
	pea	#10
	jsl	~~debugf
	lda	<L2+2
	sta	<L2+2+4
	lda	<L2+1
	sta	<L2+1+4
	pld
	tsc
	clc
	adc	#L2+4
	tcs
	rtl
L2	equ	4
L3	equ	5
	ends
	efunc
	data
L1:
	db	$74,$61,$73,$6B,$43,$6F,$6E,$74,$72,$6F,$6C,$20,$20,$20,$20
	db	$20,$3A,$0A,$00,$63,$6D,$64,$4C,$69,$6E,$65,$20,$20,$20,$20
	db	$20,$20,$20,$20,$20,$3A,$20,$25,$30,$38,$58,$0A,$00,$61,$72
	db	$67,$63,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$3A
	db	$20,$25,$30,$34,$58,$0A,$00,$61,$72,$67,$76,$20,$20,$20,$20
	db	$20,$20,$20,$20,$20,$20,$20,$20,$3A,$20,$25,$30,$38,$58,$0A
	db	$00,$63,$61,$6C,$6C,$65,$72,$54,$61,$73,$6B,$48,$61,$6E,$64
	db	$6C,$65,$3A,$20,$25,$30,$38,$58,$0A,$00,$74,$61,$73,$6B,$48
	db	$61,$6E,$64,$6C,$65,$20,$20,$20,$20,$20,$20,$3A,$20,$25,$30
	db	$38,$58,$0A,$00,$63,$6F,$64,$65,$50,$74,$72,$20,$20,$20,$20
	db	$20,$20,$20,$20,$20,$3A,$20,$25,$30,$38,$58,$0A,$00,$75,$64
	db	$61,$74,$61,$50,$74,$72,$20,$20,$20,$20,$20,$20,$20,$20,$3A
	db	$20,$25,$30,$38,$58,$0A,$00,$64,$61,$74,$61,$50,$74,$72,$20
	db	$20,$20,$20,$20,$20,$20,$20,$20,$3A,$20,$25,$30,$38,$58,$0A
	db	$00,$72,$63,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
	db	$20,$20,$3A,$20,$25,$30,$34,$58,$0A,$00,$68,$65,$61,$70,$20
	db	$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$3A,$20,$25,$30
	db	$38,$58,$0A,$00,$68,$65,$61,$70,$4E,$65,$78,$74,$20,$20,$20
	db	$20,$20,$20,$20,$20,$3A,$20,$25,$30,$38,$58,$0A,$00,$68,$65
	db	$61,$70,$41,$76,$61,$69,$6C,$61,$62,$6C,$65,$20,$20,$20,$3A
	db	$20,$25,$30,$34,$58,$0A,$00,$68,$65,$61,$70,$53,$69,$7A,$65
	db	$20,$20,$20,$20,$20,$20,$20,$20,$3A,$20,$25,$30,$34,$58,$0A
	db	$00,$62,$61,$63,$6B,$67,$72,$6F,$75,$6E,$64,$20,$20,$20,$20
	db	$20,$20,$3A,$20,$25,$30,$34,$58,$0A,$00
	ends
	code
	xdef	~~printHeap
	func
~~printHeap:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L7
	tcs
	phd
	tcd
e_0	set	4
end_0	set	8
	bra	L10004
L10003:
	ldy	#$6
	lda	[<L7+e_0],Y
	pha
	dey
	dey
	lda	[<L7+e_0],Y
	pha
	dey
	dey
	lda	[<L7+e_0],Y
	pha
	lda	[<L7+e_0]
	pha
	pei	<L7+e_0+2
	pei	<L7+e_0
	pea	#^L6
	pea	#<L6
	pea	#18
	jsl	~~debugf
	ldy	#$4
	lda	[<L7+e_0],Y
	sta	<R0
	iny
	iny
	lda	[<L7+e_0],Y
	and	#^$7fffffff
	sta	<R0+2
	lda	<L7+e_0
	clc
	adc	<R0
	sta	<L7+e_0
	lda	<L7+e_0+2
	adc	<R0+2
	sta	<L7+e_0+2
L10004:
	lda	<L7+e_0
	cmp	<L7+end_0
	bne	L9
	lda	<L7+e_0+2
	cmp	<L7+end_0+2
L9:
	bne	L10003
	lda	<L7+2
	sta	<L7+2+8
	lda	<L7+1
	sta	<L7+1+8
	pld
	tsc
	clc
	adc	#L7+8
	tcs
	rtl
L7	equ	4
L8	equ	5
	ends
	efunc
	data
L6:
	db	$65,$3A,$20,$25,$30,$38,$58,$2C,$20,$6E,$65,$78,$74,$46,$72
	db	$65,$65,$42,$6C,$6F,$63,$6B,$3A,$20,$25,$30,$38,$58,$2C,$20
	db	$6C,$65,$6E,$67,$74,$68,$3A,$20,$25,$30,$38,$58,$20,$0A,$00
	ends
	code
	xdef	~~checkHeap
	func
~~checkHeap:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L13
	tcs
	phd
	tcd
str_0	set	4
	pei	<L13+str_0+2
	pei	<L13+str_0
	pea	#^L12
	pea	#<L12
	pea	#10
	jsl	~~debugf
	lda	|~~pxEnd16+2
	pha
	lda	|~~pxEnd16
	pha
	lda	|~~ucHeap16+2
	pha
	lda	|~~ucHeap16
	pha
	jsl	~~printHeap
	pea	#^L12+4
	pea	#<L12+4
	pea	#6
	jsl	~~debugf
	lda	|~~pxEnd+2
	pha
	lda	|~~pxEnd
	pha
	lda	|~~ucHeap+2
	pha
	lda	|~~ucHeap
	pha
	jsl	~~printHeap
	lda	<L13+2
	sta	<L13+2+4
	lda	<L13+1
	sta	<L13+1+4
	pld
	tsc
	clc
	adc	#L13+4
	tcs
	rtl
L13	equ	0
L14	equ	1
	ends
	efunc
	data
L12:
	db	$25,$73,$0A,$00,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
	db	$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
	db	$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
	db	$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$0A,$00
	ends
	code
	xdef	~~freetaskControl
	func
~~freetaskControl:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L17
	tcs
	phd
	tcd
tc_0	set	4
heapEntry_1	set	0
i_1	set	4
	ldy	#$20
	lda	[<L17+tc_0],Y
	sta	<L18+heapEntry_1
	iny
	iny
	lda	[<L17+tc_0],Y
	sta	<L18+heapEntry_1+2
	lda	<L18+heapEntry_1
	ora	<L18+heapEntry_1+2
	beq	L10005
	ldy	#$2a
	lda	[<L17+tc_0],Y
	sta	<L18+i_1
	bra	L10009
L10008:
	lda	[<L18+heapEntry_1]
	ldy	#$2
	ora	[<L18+heapEntry_1],Y
	beq	L10006
	lda	[<L18+heapEntry_1],Y
	pha
	lda	[<L18+heapEntry_1]
	pha
	jsl	~~vPortFree
L10006:
	lda	#$4
	clc
	adc	<L18+heapEntry_1
	sta	<L18+heapEntry_1
	bcc	L21
	inc	<L18+heapEntry_1+2
L21:
	dec	<L18+i_1
L10009:
	lda	<L18+i_1
	bne	L10008
L10005:
	ldy	#$2
	lda	[<L17+tc_0],Y
	pha
	lda	[<L17+tc_0]
	pha
	jsl	~~vPortFree
	ldy	#$14
	lda	[<L17+tc_0],Y
	pha
	dey
	dey
	lda	[<L17+tc_0],Y
	pha
	jsl	~~vPortFree
	ldy	#$1c
	lda	[<L17+tc_0],Y
	pha
	dey
	dey
	lda	[<L17+tc_0],Y
	pha
	jsl	~~vPortFree
	ldy	#$8
	lda	[<L17+tc_0],Y
	pha
	dey
	dey
	lda	[<L17+tc_0],Y
	pha
	jsl	~~vPortFree
	ldy	#$22
	lda	[<L17+tc_0],Y
	pha
	dey
	dey
	lda	[<L17+tc_0],Y
	pha
	jsl	~~vPortFree
	pei	<L17+tc_0+2
	pei	<L17+tc_0
	jsl	~~vPortFree
	lda	<L17+2
	sta	<L17+2+4
	lda	<L17+1
	sta	<L17+1+4
	pld
	tsc
	clc
	adc	#L17+4
	tcs
	rtl
L17	equ	6
L18	equ	1
	ends
	efunc
	code
	func
~~removeTask:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L24
	tcs
	phd
	tcd
tc_0	set	4
	ldy	#$10
	lda	[<L24+tc_0],Y
	pha
	dey
	dey
	lda	[<L24+tc_0],Y
	pha
	jsl	~~vTaskDelete
	pei	<L24+tc_0+2
	pei	<L24+tc_0
	jsl	~~freetaskControl
	lda	<L24+2
	sta	<L24+2+4
	lda	<L24+1
	sta	<L24+1+4
	pld
	tsc
	clc
	adc	#L24+4
	tcs
	rtl
L24	equ	0
L25	equ	1
	ends
	efunc
	code
	func
~~removeTaskTask:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L27
	tcs
	phd
	tcd
tc_0	set	4
	pei	<L27+tc_0+2
	pei	<L27+tc_0
	jsl	~~removeTask
	pea	#^$0
	pea	#<$0
	jsl	~~vTaskDelete
	lda	<L27+2
	sta	<L27+2+4
	lda	<L27+1
	sta	<L27+1+4
	pld
	tsc
	clc
	adc	#L27+4
	tcs
	rtl
L27	equ	0
L28	equ	1
	ends
	efunc
	code
	xdef	~~vTaskRemove
	func
~~vTaskRemove:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L30
	tcs
	phd
	tcd
tc_0	set	4
	ldy	#$2c
	lda	[<L30+tc_0],Y
	beq	L10011
	pea	#^$0
	pea	#<$0
	pea	#<$0
	pei	<L30+tc_0+2
	pei	<L30+tc_0
	pea	#<$100
	pea	#^L16
	pea	#<L16
	pea	#^~~removeTaskTask
	pea	#<~~removeTaskTask
	jsl	~~xTaskCreate
	bra	L33
L10011:
	pei	<L30+tc_0+2
	pei	<L30+tc_0
	jsl	~~removeTask
	pea	#^L16+7
	pea	#<L16+7
	jsl	~~checkHeap
L33:
	lda	<L30+2
	sta	<L30+2+4
	lda	<L30+1
	sta	<L30+1+4
	pld
	tsc
	clc
	adc	#L30+4
	tcs
	rtl
L30	equ	0
L31	equ	1
	ends
	efunc
	data
L16:
	db	$72,$65,$6D,$6F,$76,$65,$00,$61,$66,$74,$65,$72,$00
	ends
	code
	xdef	~~getShellpath
	func
~~getShellpath:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L35
	tcs
	phd
	tcd
	lda	#<~~shellpath
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	ldx	<R0+2
	lda	<R0
	tay
	pld
	tsc
	clc
	adc	#L35
	tcs
	tya
	rtl
L35	equ	4
L36	equ	5
	ends
	efunc
	code
	xdef	~~hex2int
	func
~~hex2int:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L38
	tcs
	phd
	tcd
c_0	set	4
val_1	set	0
	lda	#$ffff
	sta	<L39+val_1
	lda	<L38+c_0
	and	#$ff
	pha
	jsl	~~toupper
	sep	#$20
	longa	off
	sta	<L38+c_0
	cmp	#<$30
	rep	#$20
	longa	on
	bcc	L10013
	sep	#$20
	longa	off
	lda	#$39
	cmp	<L38+c_0
	rep	#$20
	longa	on
	bcc	L10013
	lda	<L38+c_0
	and	#$ff
	clc
	adc	#$ffd0
	sta	<L39+val_1
L10013:
	sep	#$20
	longa	off
	lda	<L38+c_0
	cmp	#<$41
	rep	#$20
	longa	on
	bcc	L10014
	sep	#$20
	longa	off
	lda	#$46
	cmp	<L38+c_0
	rep	#$20
	longa	on
	bcc	L10014
	lda	<L38+c_0
	and	#$ff
	clc
	adc	#$ffc9
	sta	<L39+val_1
L10014:
	lda	<L39+val_1
	tay
	lda	<L38+2
	sta	<L38+2+2
	lda	<L38+1
	sta	<L38+1+2
	pld
	tsc
	clc
	adc	#L38+2
	tcs
	tya
	rtl
L38	equ	6
L39	equ	5
	ends
	efunc
	code
	xdef	~~str2hex
	func
~~str2hex:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L45
	tcs
	phd
	tcd
s_0	set	4
val_1	set	0
i_1	set	4
	stz	<L46+val_1
	stz	<L46+val_1+2
	bra	L10015
L20001:
	lda	[<L45+s_0]
	pha
	jsl	~~hex2int
	sta	<L46+i_1
	lda	<L46+i_1
	bmi	L10017
	asl	<L46+val_1
	rol	<L46+val_1+2
	asl	<L46+val_1
	rol	<L46+val_1+2
	asl	<L46+val_1
	rol	<L46+val_1+2
	asl	<L46+val_1
	rol	<L46+val_1+2
	ldy	#$0
	lda	<L46+i_1
	bpl	L49
	dey
L49:
	sta	<R0
	sty	<R0+2
	lda	<R0
	clc
	adc	<L46+val_1
	sta	<L46+val_1
	lda	<R0+2
	adc	<L46+val_1+2
	sta	<L46+val_1+2
L10017:
	inc	<L45+s_0
	bne	L10015
	inc	<L45+s_0+2
L10015:
	lda	[<L45+s_0]
	and	#$ff
	bne	L20001
	ldx	<L46+val_1+2
	lda	<L46+val_1
	tay
	lda	<L45+2
	sta	<L45+2+4
	lda	<L45+1
	sta	<L45+1+4
	pld
	tsc
	clc
	adc	#L45+4
	tcs
	tya
	rtl
L45	equ	10
L46	equ	5
	ends
	efunc
	code
	xdef	~~strupper
	func
~~strupper:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L52
	tcs
	phd
	tcd
str_0	set	4
	bra	L10018
L20003:
	lda	[<L52+str_0]
	and	#$ff
	pha
	jsl	~~toupper
	sep	#$20
	longa	off
	sta	[<L52+str_0]
	rep	#$20
	longa	on
	inc	<L52+str_0
	bne	L10018
	inc	<L52+str_0+2
L10018:
	lda	[<L52+str_0]
	and	#$ff
	bne	L20003
	lda	<L52+2
	sta	<L52+2+4
	lda	<L52+1
	sta	<L52+1+4
	pld
	tsc
	clc
	adc	#L52+4
	tcs
	rtl
L52	equ	0
L53	equ	1
	ends
	efunc
	code
	func
~~formatLine:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L57
	tcs
	phd
	tcd
text_0	set	4
data_0	set	8
	pei	<L57+data_0+2
	pei	<L57+data_0
	pei	<L57+data_0+2
	pei	<L57+data_0
	pei	<L57+text_0+2
	pei	<L57+text_0
	pea	#^L34
	pea	#<L34
	pea	#18
	jsl	~~printf
	lda	<L57+2
	sta	<L57+2+8
	lda	<L57+1
	sta	<L57+1+8
	pld
	tsc
	clc
	adc	#L57+8
	tcs
	rtl
L57	equ	0
L58	equ	1
	ends
	efunc
	data
L34:
	db	$25,$73,$3A,$20,$25,$6C,$38,$58,$20,$25,$6C,$38,$64,$0A,$00
	ends
	code
	func
~~evaluateExpression:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L61
	tcs
	phd
	tcd
p_1	set	0
p1_1	set	4
ex_1	set	8
sym_1	set	12
itemType_1	set	16
i_1	set	18
section_1	set	20
symNum_1	set	22
value0_1	set	24
value1_1	set	28
	lda	#<~~s
	sta	<L62+ex_1
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<L62+ex_1+2
	stz	<L62+value1_1
	stz	<L62+value1_1+2
	stz	<L62+value0_1
	stz	<L62+value0_1+2
	lda	#<~~s+7
	sta	<L62+p_1
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<L62+p_1+2
	lda	#$6
	sta	<L62+i_1
	brl	L10023
L20005:
	lda	[<L62+p_1]
	and	#$ff
	sta	<L62+itemType_1
	inc	<L62+p_1
	bne	L63
	inc	<L62+p_1+2
L63:
	inc	<L62+i_1
	sec
	lda	<L62+itemType_1
	sbc	#<$14
	bvs	L64
	eor	#$8000
L64:
	bmi	*+5
	brl	L10024
	lda	<L62+itemType_1
	xref	~~~fsw
	jsl	~~~fsw
	dw	21
	dw	10
	dw	L10023-1
	dw	L10027-1
	dw	L10028-1
	dw	L10029-1
	dw	L10030-1
	dw	L10031-1
	dw	L10032-1
	dw	L10033-1
	dw	L10034-1
	dw	L10035-1
	dw	L10036-1
L10027:
	pei	<L62+value0_1+2
	pei	<L62+value0_1
	pei	<L62+value1_1+2
	pei	<L62+value1_1
	xref	~~~lmul
	jsl	~~~lmul
L20007:
	sta	<L62+value0_1
	stx	<L62+value0_1+2
	brl	L10023
L10028:
	pei	<L62+value0_1+2
	pei	<L62+value0_1
	pei	<L62+value1_1+2
	pei	<L62+value1_1
	xref	~~~ludv
	jsl	~~~ludv
	bra	L20007
L10029:
	pei	<L62+value0_1+2
	pei	<L62+value0_1
	pei	<L62+value1_1+2
	pei	<L62+value1_1
	xref	~~~lumd
	jsl	~~~lumd
	bra	L20007
L10030:
	pei	<L62+value1_1+2
	pei	<L62+value1_1
	lda	<L62+value0_1
	xref	~~~llsr
	jsl	~~~llsr
	bra	L20007
L10031:
	pei	<L62+value1_1+2
	pei	<L62+value1_1
	lda	<L62+value0_1
	xref	~~~lasl
	jsl	~~~lasl
	bra	L20007
L10032:
	lda	<L62+value1_1
	clc
	adc	<L62+value0_1
	sta	<L62+value0_1
	lda	<L62+value1_1+2
	adc	<L62+value0_1+2
L20011:
	sta	<L62+value0_1+2
	brl	L10023
L10033:
	sec
	lda	<L62+value1_1
	sbc	<L62+value0_1
	sta	<L62+value0_1
	lda	<L62+value1_1+2
	sbc	<L62+value0_1+2
	bra	L20011
L10034:
	lda	<L62+value0_1
	and	<L62+value1_1
	sta	<L62+value0_1
	lda	<L62+value0_1+2
	and	<L62+value1_1+2
	bra	L20011
L10035:
	lda	<L62+value0_1
	ora	<L62+value1_1
	sta	<L62+value0_1
	lda	<L62+value0_1+2
	ora	<L62+value1_1+2
	bra	L20011
L10036:
	lda	<L62+value0_1
	eor	<L62+value1_1
	sta	<L62+value0_1
	lda	<L62+value0_1+2
	eor	<L62+value1_1+2
	bra	L20011
L10024:
	lda	<L62+value0_1
	sta	<L62+value1_1
	lda	<L62+value0_1+2
	sta	<L62+value1_1+2
	lda	<L62+itemType_1
	xref	~~~swt
	jsl	~~~swt
	dw	3
	dw	1
	dw	L10040-1
	dw	2
	dw	L10041-1
	dw	3
	dw	L10042-1
	dw	L10043-1
L10040:
	lda	[<L62+p_1]
	sta	<L62+symNum_1
	ldy	#$0
	lda	<L62+symNum_1
	bpl	L66
	dey
L66:
	sta	<R0
	sty	<R0+2
	pea	#^$6
	pea	#<$6
	pei	<R0+2
	pei	<R0
	xref	~~~lmul
	jsl	~~~lmul
	sta	<R0
	stx	<R0+2
	lda	|~~symbols
	clc
	adc	<R0
	sta	<L62+sym_1
	lda	|~~symbols+2
	adc	<R0+2
	sta	<L62+sym_1+2
	ldy	#$1
	lda	[<L62+sym_1],Y
	and	#$ff
	asl	A
	asl	A
	clc
	adc	#<~~base
	sta	<R1
	clc
	lda	(<R1)
	iny
	adc	[<L62+sym_1],Y
	sta	<L62+value0_1
	lda	(<R1),Y
	iny
	iny
	adc	[<L62+sym_1],Y
	sta	<L62+value0_1+2
	inc	<L62+i_1
	inc	<L62+i_1
	clc
	lda	#$2
L20015:
	adc	<L62+p_1
	sta	<L62+p_1
	bcc	L10023
	inc	<L62+p_1+2
	bra	L10023
L10041:
	lda	[<L62+p_1]
	sta	<L62+value0_1
	ldy	#$2
	lda	[<L62+p_1],Y
L20025:
	sta	<L62+value0_1+2
	lda	#$4
	clc
	adc	<L62+i_1
	sta	<L62+i_1
	clc
	lda	#$4
	bra	L20015
L10042:
	lda	[<L62+p_1]
	and	#$ff
	sta	<L62+section_1
	inc	<L62+p_1
	bne	L69
	inc	<L62+p_1+2
L69:
	inc	<L62+i_1
	lda	<L62+section_1
	asl	A
	asl	A
	clc
	adc	#<~~base
	sta	<R1
	lda	(<R1)
	clc
	adc	[<L62+p_1]
	sta	<L62+value0_1
	ldy	#$2
	lda	(<R1),Y
	adc	[<L62+p_1],Y
	bra	L20025
L10043:
	pei	<L62+itemType_1
	pea	#^L60
	pea	#<L60
	pea	#8
	jsl	~~printf
L10023:
	lda	[<L62+ex_1]
	and	#$ff
	sta	<R0
	sec
	lda	<L62+i_1
	sbc	<R0
	bvs	L71
	eor	#$8000
L71:
	bmi	*+5
	brl	L20005
	ldy	#$2
	lda	[<L62+ex_1],Y
	and	#$ff
	asl	A
	asl	A
	clc
	adc	#<~~base
	sta	<R1
	clc
	lda	(<R1)
	iny
	adc	[<L62+ex_1],Y
	sta	<L62+p_1
	dey
	lda	(<R1),Y
	ldy	#$5
	adc	[<L62+ex_1],Y
	sta	<L62+p_1+2
	clc
	tdc
	adc	#<L62+value0_1
	sta	<L62+p1_1
	lda	#$0
	sta	<L62+p1_1+2
	stz	<L62+i_1
	bra	L10047
L10046:
	sep	#$20
	longa	off
	lda	[<L62+p1_1]
	sta	[<L62+p_1]
	rep	#$20
	longa	on
	inc	<L62+p1_1
	bne	L73
	inc	<L62+p1_1+2
L73:
	inc	<L62+p_1
	bne	L10044
	inc	<L62+p_1+2
L10044:
	inc	<L62+i_1
L10047:
	ldy	#$1
	lda	[<L62+ex_1],Y
	and	#$ff
	sta	<R0
	sec
	lda	<L62+i_1
	sbc	<R0
	bvs	L75
	eor	#$8000
L75:
	bpl	L10046
	pld
	tsc
	clc
	adc	#L61
	tcs
	rtl
L61	equ	40
L62	equ	9
	ends
	efunc
	data
L60:
	db	$55,$6E,$6B,$6E,$6F,$77,$6E,$20,$69,$74,$65,$6D,$54,$79,$70
	db	$65,$3A,$20,$25,$64,$0A,$00
	ends
	code
	func
~~loadExec:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L79
	tcs
	phd
	tcd
filename_0	set	4
taskControl_0	set	8
bRead_1	set	0
cnt_1	set	4
bytesMalloc_1	set	8
bytes2Read_1	set	12
fin_1	set	16
fno_1	set	20
	lda	#$0
	ldy	#$12
	sta	[<L79+taskControl_0],Y
	iny
	iny
	sta	[<L79+taskControl_0],Y
	ldy	#$1a
	sta	[<L79+taskControl_0],Y
	iny
	iny
	sta	[<L79+taskControl_0],Y
	ldy	#$16
	sta	[<L79+taskControl_0],Y
	iny
	iny
	sta	[<L79+taskControl_0],Y
	pea	#^L78
	pea	#<L78
	pei	<L79+filename_0+2
	pei	<L79+filename_0
	jsl	~~fopen
	sta	<L80+fin_1
	stx	<L80+fin_1+2
	ora	<L80+fin_1+2
	bne	L10048
L82:
	lda	<L79+2
	sta	<L79+2+8
	lda	<L79+1
	sta	<L79+1+8
	pld
	tsc
	clc
	adc	#L79+8
	tcs
	rtl
L10048:
	pei	<L80+fin_1+2
	pei	<L80+fin_1
	jsl	~~fileno
	sta	<L80+fno_1
	pea	#^$1c
	pea	#<$1c
	lda	#<~~header
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	pei	<L80+fno_1
	jsl	~~read
	sta	<L80+bRead_1
	stx	<L80+bRead_1+2
	cmp	#<$1c
	bne	L83
	lda	<L80+bRead_1+2
	cmp	#^$1c
L83:
	bne	L82
	lda	|~~header
	cmp	#<$36313852
	bne	L85
	lda	|~~header+2
	cmp	#^$36313852
L85:
	bne	L82
	lda	|~~header+8
	clc
	adc	|~~header+16
	sta	<L80+bytesMalloc_1
	lda	|~~header+8+2
	adc	|~~header+16+2
	sta	<L80+bytesMalloc_1+2
	pha
	pei	<L80+bytesMalloc_1
	jsl	~~malloc
	stx	<R0+2
	ldy	#$12
	sta	[<L79+taskControl_0],Y
	lda	<R0+2
	iny
	iny
	sta	[<L79+taskControl_0],Y
	dey
	dey
	lda	[<L79+taskControl_0],Y
	iny
	iny
	ora	[<L79+taskControl_0],Y
	bne	*+5
	brl	L82
	lda	|~~header+8+2
	pha
	lda	|~~header+8
	pha
	lda	[<L79+taskControl_0],Y
	pha
	dey
	dey
	lda	[<L79+taskControl_0],Y
	pha
	pei	<L80+fno_1
	jsl	~~read
	sta	<L80+bRead_1
	stx	<L80+bRead_1+2
	cmp	|~~header+8
	bne	L88
	lda	<L80+bRead_1+2
	cmp	|~~header+8+2
L88:
	beq	*+5
	brl	L82
	clc
	ldy	#$12
	lda	[<L79+taskControl_0],Y
	adc	|~~header+8
	sta	<R0
	iny
	iny
	lda	[<L79+taskControl_0],Y
	adc	|~~header+8+2
	sta	<R0+2
	lda	<R0
	iny
	iny
	sta	[<L79+taskControl_0],Y
	lda	<R0+2
	iny
	iny
	sta	[<L79+taskControl_0],Y
	lda	|~~header+12
	ora	|~~header+12+2
	beq	L10053
	lda	|~~header+12+2
	pha
	lda	|~~header+12
	pha
	jsl	~~malloc
	stx	<R0+2
	ldy	#$1a
	sta	[<L79+taskControl_0],Y
	lda	<R0+2
	iny
	iny
	sta	[<L79+taskControl_0],Y
	dey
	dey
	lda	[<L79+taskControl_0],Y
	iny
	iny
	ora	[<L79+taskControl_0],Y
	bne	*+5
	brl	L82
	lda	|~~header+12+2
	pha
	lda	|~~header+12
	pha
	lda	[<L79+taskControl_0],Y
	pha
	dey
	dey
	lda	[<L79+taskControl_0],Y
	pha
	pei	<L80+fno_1
	jsl	~~read
	sta	<L80+bRead_1
	stx	<L80+bRead_1+2
	cmp	|~~header+12
	bne	L92
	lda	<L80+bRead_1+2
	cmp	|~~header+12+2
L92:
	beq	*+5
	brl	L82
L10053:
	stz	|~~base
	stz	|~~base+2
	ldy	#$12
	lda	[<L79+taskControl_0],Y
	sta	|~~base+4
	iny
	iny
	lda	[<L79+taskControl_0],Y
	sta	|~~base+4+2
	stz	|~~base+8
	stz	|~~base+8+2
	ldy	#$1a
	lda	[<L79+taskControl_0],Y
	sta	|~~base+12
	iny
	iny
	lda	[<L79+taskControl_0],Y
	sta	|~~base+12+2
	ldy	#$16
	lda	[<L79+taskControl_0],Y
	sta	|~~base+16
	iny
	iny
	lda	[<L79+taskControl_0],Y
	sta	|~~base+16+2
	ldy	#$14
	lda	[<L79+taskControl_0],Y
	pha
	dey
	dey
	lda	[<L79+taskControl_0],Y
	pha
	pea	#^L78+3
	pea	#<L78+3
	jsl	~~formatLine
	ldy	#$1c
	lda	[<L79+taskControl_0],Y
	pha
	dey
	dey
	lda	[<L79+taskControl_0],Y
	pha
	pea	#^L78+18
	pea	#<L78+18
	jsl	~~formatLine
	ldy	#$18
	lda	[<L79+taskControl_0],Y
	pha
	dey
	dey
	lda	[<L79+taskControl_0],Y
	pha
	pea	#^L78+33
	pea	#<L78+33
	jsl	~~formatLine
	lda	|~~header+4+2
	pha
	lda	|~~header+4
	pha
	pea	#^L78+48
	pea	#<L78+48
	jsl	~~formatLine
	lda	|~~header+8+2
	pha
	lda	|~~header+8
	pha
	pea	#^L78+63
	pea	#<L78+63
	jsl	~~formatLine
	lda	|~~header+12+2
	pha
	lda	|~~header+12
	pha
	pea	#^L78+78
	pea	#<L78+78
	jsl	~~formatLine
	lda	|~~header+16+2
	pha
	lda	|~~header+16
	pha
	pea	#^L78+93
	pea	#<L78+93
	jsl	~~formatLine
	pei	<L80+bytesMalloc_1+2
	pei	<L80+bytesMalloc_1
	pea	#^L78+108
	pea	#<L78+108
	jsl	~~formatLine
	lda	|~~header+20+2
	pha
	lda	|~~header+20
	pha
	pea	#^L78+123
	pea	#<L78+123
	jsl	~~formatLine
	lda	|~~header+24+2
	pha
	lda	|~~header+24
	pha
	pea	#^L78+138
	pea	#<L78+138
	jsl	~~formatLine
	pea	#^$6
	pea	#<$6
	lda	|~~header+20+2
	pha
	lda	|~~header+20
	pha
	xref	~~~lmul
	jsl	~~~lmul
	sta	<L80+bytesMalloc_1
	stx	<L80+bytesMalloc_1+2
	pei	<L80+bytesMalloc_1+2
	pei	<L80+bytesMalloc_1
	jsl	~~malloc
	sta	|~~symbols
	stx	|~~symbols+2
	pei	<L80+bytesMalloc_1+2
	pei	<L80+bytesMalloc_1
	lda	|~~symbols+2
	pha
	lda	|~~symbols
	pha
	pei	<L80+fno_1
	jsl	~~read
	stz	<L80+cnt_1
	stz	<L80+cnt_1+2
	bra	L10059
L10058:
	pei	<L80+fin_1+2
	pei	<L80+fin_1
	pea	#^$1
	pea	#<$1
	pea	#^$1
	pea	#<$1
	lda	#<~~s
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	jsl	~~fread
	sta	<L80+bRead_1
	stx	<L80+bRead_1+2
	lda	|~~s
	and	#$ff
	sta	<L80+bytes2Read_1
	stz	<L80+bytes2Read_1+2
	pei	<L80+fin_1+2
	pei	<L80+fin_1
	pei	<L80+bytes2Read_1+2
	pei	<L80+bytes2Read_1
	pea	#^$1
	pea	#<$1
	lda	#<~~s+1
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	jsl	~~fread
	sta	<L80+bRead_1
	stx	<L80+bRead_1+2
	jsl	~~evaluateExpression
	inc	<L80+cnt_1
	bne	L10059
	inc	<L80+cnt_1+2
L10059:
	lda	<L80+cnt_1
	cmp	|~~header+24
	lda	<L80+cnt_1+2
	sbc	|~~header+24+2
	bcc	L10058
	lda	|~~symbols+2
	pha
	lda	|~~symbols
	pha
	jsl	~~free
	pei	<L80+fin_1+2
	pei	<L80+fin_1
	jsl	~~fclose
	brl	L82
L79	equ	26
L80	equ	5
	ends
	efunc
	data
L78:
	db	$72,$62,$00,$4D,$6F,$64,$75,$6C,$65,$20,$62,$61,$73,$65,$20
	db	$20,$20,$00,$44,$61,$74,$61,$20,$62,$61,$73,$65,$20,$20,$20
	db	$20,$20,$00,$55,$44,$61,$74,$61,$20,$62,$61,$73,$65,$20,$20
	db	$20,$20,$00,$4F,$66,$66,$73,$65,$74,$20,$74,$6F,$20,$6D,$61
	db	$69,$6E,$00,$43,$6F,$64,$65,$20,$6C,$65,$6E,$67,$74,$68,$20
	db	$20,$20,$00,$44,$61,$74,$61,$20,$6C,$65,$6E,$67,$74,$68,$20
	db	$20,$20,$00,$55,$44,$61,$74,$61,$20,$6C,$65,$6E,$67,$74,$68
	db	$20,$20,$00,$54,$6F,$74,$61,$6C,$20,$6C,$65,$6E,$67,$74,$68
	db	$20,$20,$00,$23,$73,$79,$6D,$62,$6F,$6C,$73,$20,$20,$20,$20
	db	$20,$20,$00,$23,$65,$78,$70,$72,$65,$73,$73,$69,$6F,$6E,$73
	db	$20,$20,$00
	ends
	code
	func
~~prependDevname:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L97
	tcs
	phd
	tcd
s_0	set	4
	sep	#$20
	longa	off
	lda	[<L97+s_0]
	cmp	#<$44
	rep	#$20
	longa	on
	bne	L99
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L97+s_0],Y
	cmp	#<$3a
	rep	#$20
	longa	on
	beq	L102
L99:
	pei	<L97+s_0+2
	pei	<L97+s_0
	jsl	~~strlen
	sta	<R0
	stx	<R0+2
	lda	#$1
	clc
	adc	<R0
	sta	<R1
	lda	#$0
	adc	<R0+2
	pha
	pei	<R1
	pei	<L97+s_0+2
	pei	<L97+s_0
	lda	#$2
	clc
	adc	<L97+s_0
	sta	<R0
	lda	#$0
	adc	<L97+s_0+2
	pha
	pei	<R0
	jsl	~~memmove
	sep	#$20
	longa	off
	lda	#$44
	sta	[<L97+s_0]
	lda	#$3a
	ldy	#$1
	sta	[<L97+s_0],Y
	rep	#$20
	longa	on
L102:
	lda	<L97+2
	sta	<L97+2+4
	lda	<L97+1
	sta	<L97+1+4
	pld
	tsc
	clc
	adc	#L97+4
	tcs
	rtl
L97	equ	8
L98	equ	9
	ends
	efunc
	code
	xdef	~~adjustFilename
	func
~~adjustFilename:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L103
	tcs
	phd
	tcd
s_0	set	4
exe_0	set	8
p_1	set	0
out_1	set	4
len_1	set	8
	pei	<L103+s_0+2
	pei	<L103+s_0
	jsl	~~strlen
	sta	<L104+len_1
	clc
	adc	#$a
	sta	<R0
	stz	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~malloc
	sta	<L104+out_1
	stx	<L104+out_1+2
	pei	<L103+s_0+2
	pei	<L103+s_0
	pei	<L104+out_1+2
	pei	<L104+out_1
	jsl	~~strcpy
	pei	<L104+out_1+2
	pei	<L104+out_1
	jsl	~~strupper
	ldx	<L104+out_1+2
	lda	<L104+out_1
	tay
	lda	<L103+2
	sta	<L103+2+6
	lda	<L103+1
	sta	<L103+1+6
	pld
	tsc
	clc
	adc	#L103+6
	tcs
	tya
	rtl
L103	equ	14
L104	equ	5
	ends
	efunc
	code
	xdef	~~adjustExe
	func
~~adjustExe:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L106
	tcs
	phd
	tcd
s_0	set	4
p_1	set	0
out_1	set	4
len_1	set	8
	pei	<L106+s_0+2
	pei	<L106+s_0
	jsl	~~strlen
	sta	<L107+len_1
	clc
	adc	#$a
	sta	<R0
	stz	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~malloc
	sta	<L107+out_1
	stx	<L107+out_1+2
	pei	<L106+s_0+2
	pei	<L106+s_0
	pei	<L107+out_1+2
	pei	<L107+out_1
	jsl	~~strcpy
	pei	<L107+out_1+2
	pei	<L107+out_1
	jsl	~~strupper
	pei	<L107+out_1+2
	pei	<L107+out_1
	jsl	~~prependDevname
	pei	<L107+out_1+2
	pei	<L107+out_1
	jsl	~~strlen
	sta	<R0
	stx	<R0+2
	lda	<L107+out_1
	clc
	adc	<R0
	sta	<L107+p_1
	lda	<L107+out_1+2
	adc	<R0+2
	sta	<L107+p_1+2
	bra	L10061
L20027:
	sep	#$20
	longa	off
	lda	[<L107+p_1]
	cmp	#<$2e
	rep	#$20
	longa	on
	beq	L10062
	lda	<L107+p_1
	bne	L110
	dec	<L107+p_1+2
L110:
	dec	<L107+p_1
L10061:
	lda	<L107+p_1
	cmp	<L107+out_1
	lda	<L107+p_1+2
	sbc	<L107+out_1+2
	bcs	L20027
L10062:
	lda	<L107+p_1
	cmp	<L107+out_1
	lda	<L107+p_1+2
	sbc	<L107+out_1+2
	bcs	L10063
	pea	#^L96
	pea	#<L96
	pei	<L107+out_1+2
	pei	<L107+out_1
	jsl	~~strcat
	sta	<L107+out_1
	stx	<L107+out_1+2
L10063:
	ldx	<L107+out_1+2
	lda	<L107+out_1
	tay
	lda	<L106+2
	sta	<L106+2+4
	lda	<L106+1
	sta	<L106+1+4
	pld
	tsc
	clc
	adc	#L106+4
	tcs
	tya
	rtl
L106	equ	14
L107	equ	5
	ends
	efunc
	data
L96:
	db	$2E,$45,$58,$45,$00
	ends
	code
	xdef	~~getParams
	func
~~getParams:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L114
	tcs
	phd
	tcd
tc_1	set	0
p_1	set	4
str_1	set	8
i_1	set	12
j_1	set	14
len_1	set	16
cnt_1	set	18
	pea	#^$51
	pea	#<$51
	pea	#^$1
	pea	#<$1
	jsl	~~calloc
	sta	<L115+str_1
	stx	<L115+str_1+2
	lda	#<~~shellpath
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	pea	#^L113
	pea	#<L113
	pea	#10
	jsl	~~printf
	lda	|~~stdin+2
	pha
	lda	|~~stdin
	pha
	pea	#<$50
	pei	<L115+str_1+2
	pei	<L115+str_1
	jsl	~~fgets
	pea	#^$2e
	pea	#<$2e
	pea	#^$1
	pea	#<$1
	jsl	~~calloc
	sta	<L115+tc_1
	stx	<L115+tc_1+2
	lda	<L115+str_1
	sta	[<L115+tc_1]
	lda	<L115+str_1+2
	ldy	#$2
	sta	[<L115+tc_1],Y
	pei	<L115+str_1+2
	pei	<L115+str_1
	jsl	~~strlen
	sta	<L115+len_1
	stz	<L115+cnt_1
	stz	<L115+i_1
	bra	L10067
L10066:
	ldy	<L115+i_1
	lda	[<L115+str_1],Y
	and	#$ff
	beq	L10065
	sep	#$20
	longa	off
	lda	[<L115+str_1],Y
	cmp	#<$20
	rep	#$20
	longa	on
	beq	L117
	sep	#$20
	longa	off
	lda	[<L115+str_1],Y
	cmp	#<$a
	rep	#$20
	longa	on
	bne	L10064
L117:
	sep	#$20
	longa	off
	lda	#$0
	ldy	<L115+i_1
	sta	[<L115+str_1],Y
	rep	#$20
	longa	on
	inc	<L115+cnt_1
L10064:
	inc	<L115+i_1
L10067:
	lda	<L115+i_1
	cmp	<L115+len_1
	bcc	L10066
L10065:
	lda	<L115+cnt_1
	ldy	#$4
	sta	[<L115+tc_1],Y
	lda	<L115+cnt_1
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$2
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~malloc
	stx	<R2+2
	ldy	#$6
	sta	[<L115+tc_1],Y
	lda	<R2+2
	iny
	iny
	sta	[<L115+tc_1],Y
	dey
	dey
	lda	[<L115+tc_1],Y
	sta	<L115+p_1
	iny
	iny
	lda	[<L115+tc_1],Y
	sta	<L115+p_1+2
	stz	<L115+i_1
	stz	<L115+j_1
	bra	L10072
L10071:
	lda	<L115+i_1
	sta	<R0
	stz	<R0+2
	lda	<L115+str_1
	clc
	adc	<R0
	sta	<R1
	lda	<L115+str_1+2
	adc	<R0+2
	sta	<R1+2
	lda	<R1
	sta	[<L115+p_1]
	lda	<R1+2
	ldy	#$2
	sta	[<L115+p_1],Y
	lda	#$4
	clc
	adc	<L115+p_1
	sta	<L115+p_1
	bcc	L121
	inc	<L115+p_1+2
L121:
	inc	<L115+j_1
	bra	L10073
L20029:
	inc	<L115+i_1
L10073:
	ldy	<L115+i_1
	lda	[<L115+str_1],Y
	and	#$ff
	bne	L20029
	inc	<L115+i_1
L10072:
	lda	<L115+j_1
	cmp	<L115+cnt_1
	bcc	L10071
	ldx	<L115+tc_1+2
	lda	<L115+tc_1
	tay
	pld
	tsc
	clc
	adc	#L114
	tcs
	tya
	rtl
L114	equ	32
L115	equ	13
	ends
	efunc
	data
L113:
	db	$25,$73,$3E,$00
	ends
	code
	xdef	~~shellTask
	func
~~shellTask:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L126
	tcs
	phd
	tcd
pvParameters_0	set	4
taskHandle_1	set	0
rc_1	set	4
c_1	set	6
tc_1	set	7
p_1	set	11
fname_1	set	15
breakpoint_1	set	19
callTask_1	set	23
	pea	#<$1
	jsl	~~xQueueCreateMutex
	sta	|~~iocbSemaphore
	stx	|~~iocbSemaphore+2
	lda	|~~iocbSemaphore+2
	pha
	lda	|~~iocbSemaphore
	pha
	pea	#^L125
	pea	#<L125
	pea	#10
	jsl	~~debugf
	pea	#^$0
	pea	#<$0
	pea	#^$0
	pea	#<$0
	jsl	~~vTaskSetApplicationTaskTag
	pea	#^L125+29
	pea	#<L125+29
	pea	#6
	jsl	~~debugf
	pea	#^$1
	pea	#<$1
	pea	#<$0
	pea	#^$0
	pea	#<$0
	lda	|~~stdin+2
	pha
	lda	|~~stdin
	pha
	jsl	~~setvbuf
	pea	#^L125+57
	pea	#<L125+57
	pea	#6
	jsl	~~printf
	pea	#^L125+59
	pea	#<L125+59
	lda	#<~~shellpath
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	jsl	~~strcpy
	lda	#<~~shellpath
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	jsl	~~chdir
L10077:
	sep	#$20
	longa	off
	stz	|~~fd2iocb
	rep	#$20
	longa	on
	jsl	~~getParams
	sta	<L127+tc_1
	stx	<L127+tc_1+2
	ldy	#$6
	lda	[<L127+tc_1],Y
	sta	<L127+p_1
	iny
	iny
	lda	[<L127+tc_1],Y
	sta	<L127+p_1+2
	ldy	#$2
	lda	[<L127+p_1],Y
	pha
	lda	[<L127+p_1]
	pha
	jsl	~~adjustExe
	sta	<L127+fname_1
	stx	<L127+fname_1+2
	pea	#^L125+61
	pea	#<L125+61
	jsl	~~chdir
	sep	#$20
	longa	off
	lda	#$7
	sta	|~~fd2iocb
	rep	#$20
	longa	on
	asmstart
	sei
	asmend
	pei	<L127+tc_1+2
	pei	<L127+tc_1
	pei	<L127+fname_1+2
	pei	<L127+fname_1
	jsl	~~loadExec
	asmstart
	cli
	asmend
	pei	<L127+fname_1+2
	pei	<L127+fname_1
	jsl	~~free
	ldy	#$12
	lda	[<L127+tc_1],Y
	iny
	iny
	ora	[<L127+tc_1],Y
	bne	L10078
	pei	<L127+fname_1+2
	pei	<L127+fname_1
	pea	#^L125+63
	pea	#<L125+63
	pea	#10
	jsl	~~printf
	pei	<L127+tc_1+2
	pei	<L127+tc_1
	jsl	~~freetaskControl
	brl	L10077
L10078:
	lda	#$1
	sta	<L127+callTask_1
	stz	<L127+breakpoint_1
	stz	<L127+breakpoint_1+2
	ldy	#$4
	cmp	[<L127+tc_1],Y
	bcc	*+5
	brl	L10079
	lda	#$ffff
	clc
	adc	[<L127+tc_1],Y
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$2
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	ldy	#$6
	lda	[<L127+tc_1],Y
	adc	<R0
	sta	<R2
	iny
	iny
	lda	[<L127+tc_1],Y
	adc	<R0+2
	sta	<R2+2
	lda	[<R2]
	sta	<R0
	ldy	#$2
	lda	[<R2],Y
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	sta	<L127+c_1
	cmp	#<$23
	rep	#$20
	longa	on
	bne	L10080
	stz	<L127+callTask_1
L10080:
	sep	#$20
	longa	off
	lda	<L127+c_1
	cmp	#<$26
	rep	#$20
	longa	on
	bne	L10081
	lda	#$1
	ldy	#$2c
	sta	[<L127+tc_1],Y
L10081:
	sep	#$20
	longa	off
	lda	<L127+c_1
	cmp	#<$21
	rep	#$20
	longa	on
	bne	L10079
	clc
	lda	#$ffff
	ldy	#$4
	adc	[<L127+tc_1],Y
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$2
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	ldy	#$6
	lda	[<L127+tc_1],Y
	adc	<R0
	sta	<R2
	iny
	iny
	lda	[<L127+tc_1],Y
	adc	<R0+2
	sta	<R2+2
	lda	#$1
	clc
	adc	[<R2]
	sta	<R0
	lda	#$0
	ldy	#$2
	adc	[<R2],Y
	pha
	pei	<R0
	jsl	~~str2hex
	sta	<R2
	stx	<R2+2
	clc
	ldy	#$12
	lda	[<L127+tc_1],Y
	adc	<R2
	sta	<L127+breakpoint_1
	iny
	iny
	lda	[<L127+tc_1],Y
	adc	<R2+2
	sta	<L127+breakpoint_1+2
	sep	#$20
	longa	off
	lda	[<L127+breakpoint_1]
	sta	>845
	lda	#$0
	sta	[<L127+breakpoint_1]
	rep	#$20
	longa	on
L10079:
	lda	<L127+callTask_1
	bne	*+5
	brl	L10077
	ldy	#$14
	lda	[<L127+tc_1],Y
	pha
	dey
	dey
	lda	[<L127+tc_1],Y
	pha
	pea	#^L125+81
	pea	#<L125+81
	pea	#10
	jsl	~~printf
	lda	<L127+breakpoint_1
	ora	<L127+breakpoint_1+2
	beq	L10084
	pei	<L127+breakpoint_1+2
	pei	<L127+breakpoint_1
	lda	<L127+c_1
	and	#$ff
	pha
	pea	#^L125+96
	pea	#<L125+96
	pea	#12
	jsl	~~printf
L10084:
	pea	#^L125+106
	pea	#<L125+106
	pea	#6
	jsl	~~printf
	jsl	~~xTaskGetCurrentTaskHandle
	stx	<R0+2
	ldy	#$a
	sta	[<L127+tc_1],Y
	lda	<R0+2
	iny
	iny
	sta	[<L127+tc_1],Y
	lda	#$e
	clc
	adc	<L127+tc_1
	sta	<R0
	lda	#$0
	adc	<L127+tc_1+2
	pha
	pei	<R0
	pea	#<$0
	pei	<L127+tc_1+2
	pei	<L127+tc_1
	pea	#<$800
	ldy	#$6
	lda	[<L127+tc_1],Y
	sta	<R1
	iny
	iny
	lda	[<L127+tc_1],Y
	sta	<R1+2
	ldy	#$2
	lda	[<R1],Y
	pha
	lda	[<R1]
	pha
	ldy	#$14
	lda	[<L127+tc_1],Y
	pha
	dey
	dey
	lda	[<L127+tc_1],Y
	pha
	jsl	~~xTaskCreate
	sta	<L127+rc_1
	ldy	#$2c
	lda	[<L127+tc_1],Y
	beq	*+5
	brl	L10077
	pea	#<$ffff
	pea	#<$1
	jsl	~~ulTaskNotifyTake
	pei	<L127+tc_1+2
	pei	<L127+tc_1
	jsl	~~vTaskRemove
	brl	L10077
L126	equ	37
L127	equ	13
	ends
	efunc
	data
L125:
	db	$69,$6F,$63,$62,$53,$65,$6D,$61,$70,$68,$6F,$72,$65,$20,$63
	db	$72,$65,$61,$74,$65,$64,$3A,$20,$25,$30,$38,$58,$0A,$00,$76
	db	$54,$61,$73,$6B,$53,$65,$74,$41,$70,$70,$6C,$69,$63,$61,$74
	db	$69,$6F,$6E,$54,$61,$73,$6B,$54,$61,$67,$0A,$00,$0A,$00,$2F
	db	$00,$2F,$00,$45,$72,$72,$6F,$72,$20,$6C,$6F,$61,$64,$69,$6E
	db	$67,$20,$25,$73,$0A,$00,$63,$61,$6C,$6C,$69,$6E,$67,$20,$40
	db	$25,$6C,$30,$38,$58,$00,$25,$63,$20,$25,$6C,$30,$38,$58,$0A
	db	$00,$0A,$00
	ends
	code
	xdef	~~main
	func
~~main:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L137
	tcs
	phd
	tcd
argc_0	set	4
argv_0	set	6
rc_1	set	0
dir_1	set	2
cnt_1	set	6
c_1	set	8
dirent_1	set	10
	jsl	~~vInitRTOS
	sep	#$20
	longa	off
	stz	|~~fd2iocb
	stz	|~~fd2iocb+1
	stz	|~~fd2iocb+2
	lda	#$ff
	sta	|~~fd2iocb+3
	sta	|~~fd2iocb+4
	sta	|~~fd2iocb+5
	sta	|~~fd2iocb+6
	sta	|~~fd2iocb+7
	rep	#$20
	longa	on
	stz	|~~iocbSemaphore
	stz	|~~iocbSemaphore+2
	lda	|~~stdin
	sta	<R0
	lda	|~~stdin+2
	sta	<R0+2
	lda	#$ac
	ldy	#$2
	sta	[<R0],Y
	pea	#^$0
	pea	#<$0
	pea	#<$0
	pea	#^$0
	pea	#<$0
	pea	#<$200
	pea	#^L136
	pea	#<L136
	pea	#^~~shellTask
	pea	#<~~shellTask
	jsl	~~xTaskCreate
	sta	<L138+rc_1
	cmp	#<$1
	beq	L10086
	pei	<L138+rc_1
	pea	#^L136+6
	pea	#<L136+6
	pea	#8
	jsl	~~printf
	lda	#$1
L140:
	tay
	lda	<L137+2
	sta	<L137+2+6
	lda	<L137+1
	sta	<L137+1+6
	pld
	tsc
	clc
	adc	#L137+6
	tcs
	tya
	rtl
L10086:
	jsl	~~vTaskStartScheduler
	pea	#^L136+41
	pea	#<L136+41
	pea	#6
	jsl	~~printf
	lda	#$0
	bra	L140
L137	equ	18
L138	equ	5
	ends
	efunc
	data
L136:
	db	$53,$48,$45,$4C,$4C,$00,$73,$68,$65,$6C,$6C,$20,$63,$6F,$75
	db	$6C,$64,$20,$6E,$6F,$74,$20,$62,$65,$20,$63,$72,$65,$61,$74
	db	$65,$64,$20,$72,$63,$3A,$20,$25,$64,$0A,$00,$45,$72,$72,$6F
	db	$72,$20,$73,$74,$61,$72,$74,$69,$6E,$67,$20,$52,$54,$4F,$53
	db	$20,$73,$63,$68,$65,$64,$75,$6C,$65,$72,$0A,$00
	ends
	xref	~~vInitRTOS
	xref	~~toupper
	xref	~~debugf
	xref	~~xQueueCreateMutex
	xref	~~xTaskGetCurrentTaskHandle
	xref	~~ulTaskNotifyTake
	xref	~~vTaskSetApplicationTaskTag
	xref	~~vTaskStartScheduler
	xref	~~vTaskDelete
	xref	~~xTaskCreate
	xref	~~vPortFree
	xref	~~free
	xref	~~malloc
	xref	~~calloc
	xref	~~read
	xref	~~chdir
	xref	~~strlen
	xref	~~strcat
	xref	~~memmove
	xref	~~strcpy
	xref	~~setvbuf
	xref	~~fileno
	xref	~~fclose
	xref	~~fread
	xref	~~fgets
	xref	~~printf
	xref	~~fopen
	udata
~~dirent
	ds	2136
	ends
	udata
~~dir_fd
	ds	16
	ends
	udata
~~shellpath
	ds	80
	ends
	udata
~~base
	ds	20
	ends
	udata
~~symbols
	ds	4
	ends
	udata
~~header
	ds	28
	ends
	udata
~~s
	ds	80
	ends
	xref	~~fd2iocb
	xref	~~iocbSemaphore
	xref	~~pxEnd16
	xref	~~pxEnd
	xref	~~stdin
