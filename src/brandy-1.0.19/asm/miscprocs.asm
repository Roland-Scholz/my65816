;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
	code
	xdef	~~isidstart
	func
~~isidstart:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
ch_0	set	4
	stz	<R0
	lda	<L2+ch_0
	and	#$ff
	pha
	jsl	~~isalpha
	tax
	beq	L6
	brl	L5
L6:
	sep	#$20
	longa	off
	lda	<L2+ch_0
	cmp	#<$5f
	rep	#$20
	longa	on
	bne	L7
	brl	L5
L7:
	sep	#$20
	longa	off
	lda	<L2+ch_0
	cmp	#<$60
	rep	#$20
	longa	on
	beq	L8
	brl	L4
L8:
L5:
	inc	<R0
L4:
L9:
	tay
	lda	<L2+2
	sta	<L2+2+2
	lda	<L2+1
	sta	<L2+1+2
	pld
	tsc
	clc
	adc	#L2+2
	tcs
	tya
	rtl
L2	equ	4
L3	equ	5
	ends
	efunc
	code
	xdef	~~isidchar
	func
~~isidchar:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L10
	tcs
	phd
	tcd
ch_0	set	4
	stz	<R0
	lda	<L10+ch_0
	and	#$ff
	pha
	jsl	~~isalnum
	tax
	beq	L14
	brl	L13
L14:
	sep	#$20
	longa	off
	lda	<L10+ch_0
	cmp	#<$5f
	rep	#$20
	longa	on
	bne	L15
	brl	L13
L15:
	sep	#$20
	longa	off
	lda	<L10+ch_0
	cmp	#<$60
	rep	#$20
	longa	on
	beq	L16
	brl	L12
L16:
L13:
	inc	<R0
L12:
L17:
	tay
	lda	<L10+2
	sta	<L10+2+2
	lda	<L10+1
	sta	<L10+1+2
	pld
	tsc
	clc
	adc	#L10+2
	tcs
	tya
	rtl
L10	equ	4
L11	equ	5
	ends
	efunc
	code
	xdef	~~isident
	func
~~isident:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L18
	tcs
	phd
	tcd
ch_0	set	4
	stz	<R0
	lda	<L18+ch_0
	and	#$ff
	pha
	jsl	~~isalnum
	tax
	beq	L22
	brl	L21
L22:
	sep	#$20
	longa	off
	lda	<L18+ch_0
	cmp	#<$5f
	rep	#$20
	longa	on
	bne	L23
	brl	L21
L23:
	sep	#$20
	longa	off
	lda	<L18+ch_0
	cmp	#<$60
	rep	#$20
	longa	on
	beq	L24
	brl	L20
L24:
L21:
	inc	<R0
L20:
L25:
	tay
	lda	<L18+2
	sta	<L18+2+2
	lda	<L18+1
	sta	<L18+1+2
	pld
	tsc
	clc
	adc	#L18+2
	tcs
	tya
	rtl
L18	equ	4
L19	equ	5
	ends
	efunc
	code
	xdef	~~skip_blanks
	func
~~skip_blanks:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L26
	tcs
	phd
	tcd
p_0	set	4
L10001:
	sep	#$20
	longa	off
	lda	[<L26+p_0]
	cmp	#<$20
	rep	#$20
	longa	on
	bne	L29
	brl	L28
L29:
	sep	#$20
	longa	off
	lda	[<L26+p_0]
	cmp	#<$9
	rep	#$20
	longa	on
	beq	L30
	brl	L10002
L30:
L28:
	inc	<L26+p_0
	bne	L31
	inc	<L26+p_0+2
L31:
	brl	L10001
L10002:
	ldx	<L26+p_0+2
	lda	<L26+p_0
L32:
	tay
	lda	<L26+2
	sta	<L26+2+4
	lda	<L26+1
	sta	<L26+1+4
	pld
	tsc
	clc
	adc	#L26+4
	tcs
	tya
	rtl
L26	equ	0
L27	equ	1
	ends
	efunc
	code
	xdef	~~skip
	func
~~skip:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L33
	tcs
	phd
	tcd
p_0	set	4
L10003:
	sep	#$20
	longa	off
	lda	[<L33+p_0]
	cmp	#<$20
	rep	#$20
	longa	on
	bne	L36
	brl	L35
L36:
	sep	#$20
	longa	off
	lda	[<L33+p_0]
	cmp	#<$9
	rep	#$20
	longa	on
	beq	L37
	brl	L10004
L37:
L35:
	inc	<L33+p_0
	bne	L38
	inc	<L33+p_0+2
L38:
	brl	L10003
L10004:
	ldx	<L33+p_0+2
	lda	<L33+p_0
L39:
	tay
	lda	<L33+2
	sta	<L33+2+4
	lda	<L33+1
	sta	<L33+1+4
	pld
	tsc
	clc
	adc	#L33+4
	tcs
	tya
	rtl
L33	equ	0
L34	equ	1
	ends
	efunc
	code
	xdef	~~alignaddr
	func
~~alignaddr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L40
	tcs
	phd
	tcd
addr_0	set	4
offset_1	set	0
	sec
	lda	<L40+addr_0
	sbc	|~~basicvars+6
	sta	<R0
	lda	<L40+addr_0+2
	sbc	|~~basicvars+6+2
	sta	<R0+2
	lda	<R0
	sta	<L41+offset_1
	lda	<L41+offset_1
	ina
	and	#<$fffffffe
	sta	<L41+offset_1
	ldy	#$0
	lda	<L41+offset_1
	bpl	L42
	dey
L42:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars+6
	adc	<R0
	sta	<R1
	lda	|~~basicvars+6+2
	adc	<R0+2
	sta	<R1+2
	ldx	<R1+2
	lda	<R1
L43:
	tay
	lda	<L40+2
	sta	<L40+2+4
	lda	<L40+1
	sta	<L40+1+4
	pld
	tsc
	clc
	adc	#L40+4
	tcs
	tya
	rtl
L40	equ	10
L41	equ	9
	ends
	efunc
	code
	xdef	~~check_read
	func
~~check_read:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L44
	tcs
	phd
	tcd
low_0	set	4
size_0	set	6
lowaddr_1	set	0
	ldy	#$0
	lda	<L44+low_0
	bpl	L46
	dey
L46:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars+6
	adc	<R0
	sta	<L45+lowaddr_1
	lda	|~~basicvars+6+2
	adc	<R0+2
	sta	<L45+lowaddr_1+2
	lda	<L45+lowaddr_1
	cmp	|~~basicvars
	lda	<L45+lowaddr_1+2
	sbc	|~~basicvars+2
	bcs	L48
	brl	L47
L48:
	ldy	#$0
	lda	<L44+size_0
	bpl	L49
	dey
L49:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L45+lowaddr_1
	adc	<R0
	sta	<R1
	lda	<L45+lowaddr_1+2
	adc	<R0+2
	sta	<R1+2
	lda	<R1
	cmp	|~~basicvars+54
	lda	<R1+2
	sbc	|~~basicvars+54+2
	bcs	L50
	brl	L10005
L50:
L47:
	pea	#<$20
	pea	#4
	jsl	~~error
L10005:
L51:
	lda	<L44+2
	sta	<L44+2+4
	lda	<L44+1
	sta	<L44+1+4
	pld
	tsc
	clc
	adc	#L44+4
	tcs
	rtl
L44	equ	12
L45	equ	9
	ends
	efunc
	code
	xdef	~~check_write
	func
~~check_write:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L52
	tcs
	phd
	tcd
low_0	set	4
size_0	set	6
lowaddr_1	set	0
highaddr_1	set	4
	ldy	#$0
	lda	<L52+low_0
	bpl	L54
	dey
L54:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars+6
	adc	<R0
	sta	<L53+lowaddr_1
	lda	|~~basicvars+6+2
	adc	<R0+2
	sta	<L53+lowaddr_1+2
	ldy	#$0
	lda	<L52+size_0
	bpl	L55
	dey
L55:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L53+lowaddr_1
	adc	<R0
	sta	<L53+highaddr_1
	lda	<L53+lowaddr_1+2
	adc	<R0+2
	sta	<L53+highaddr_1+2
	lda	<L53+lowaddr_1
	cmp	|~~basicvars+30
	lda	<L53+lowaddr_1+2
	sbc	|~~basicvars+30+2
	bcs	L56
	brl	L10006
L56:
	lda	<L53+highaddr_1
	cmp	|~~basicvars+54
	lda	<L53+highaddr_1+2
	sbc	|~~basicvars+54+2
	bcc	L57
	brl	L10006
L57:
L58:
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
L10006:
	pea	#<$20
	pea	#4
	jsl	~~error
	brl	L58
L52	equ	12
L53	equ	5
	ends
	efunc
	code
	xdef	~~get_integer
	func
~~get_integer:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L59
	tcs
	phd
	tcd
offset_0	set	4
	pea	#<$2
	pei	<L59+offset_0
	jsl	~~check_read
	clc
	lda	#$3
	adc	<L59+offset_0
	sta	<R1
	lda	|~~basicvars+6
	sta	<R2
	lda	|~~basicvars+6+2
	sta	<R2+2
	ldy	<R1
	lda	[<R2],Y
	and	#$ff
	ldx	#<$18
	xref	~~~asl
	jsl	~~~asl
	sta	<R0
	clc
	lda	#$2
	adc	<L59+offset_0
	sta	<R3
	lda	|~~basicvars+6
	sta	<17
	lda	|~~basicvars+6+2
	sta	<17+2
	ldy	<R3
	lda	[<17],Y
	and	#$ff
	ldx	#<$10
	xref	~~~asl
	jsl	~~~asl
	sta	<R2
	lda	<L59+offset_0
	ina
	sta	<21
	lda	|~~basicvars+6
	sta	<25
	lda	|~~basicvars+6+2
	sta	<25+2
	ldy	<21
	lda	[<25],Y
	and	#$ff
	sta	<25
	lda	<25
	xba
	and	#$ff00
	sta	<17
	lda	|~~basicvars+6
	sta	<25
	lda	|~~basicvars+6+2
	sta	<25+2
	ldy	<L59+offset_0
	lda	[<25],Y
	and	#$ff
	sta	<25
	clc
	lda	<25
	adc	<17
	sta	<29
	clc
	lda	<29
	adc	<R2
	sta	<17
	clc
	lda	<17
	adc	<R0
L61:
	tay
	lda	<L59+2
	sta	<L59+2+2
	lda	<L59+1
	sta	<L59+1+2
	pld
	tsc
	clc
	adc	#L59+2
	tcs
	tya
	rtl
L59	equ	32
L60	equ	33
	ends
	efunc
	code
	xdef	~~get_float
	func
~~get_float:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L62
	tcs
	phd
	tcd
offset_0	set	4
value_1	set	0
	pea	#<$4
	pei	<L62+offset_0
	jsl	~~check_read
	pea	#^$4
	pea	#<$4
	ldy	#$0
	lda	<L62+offset_0
	bpl	L64
	dey
L64:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars+6
	adc	<R0
	sta	<R1
	lda	|~~basicvars+6+2
	adc	<R0+2
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pea	#0
	clc
	tdc
	adc	#<L63+value_1
	pha
	jsl	~~memmove
	lda	<L63+value_1
	sta	<L62+6
	lda	<L63+value_1+2
	sta	<L62+8
L65:
	lda	<L62+2
	sta	<L62+2+2
	lda	<L62+1
	sta	<L62+1+2
	pld
	tsc
	clc
	adc	#L62+2
	tcs
	rtl
L62	equ	12
L63	equ	9
	ends
	efunc
	code
	xdef	~~store_integer
	func
~~store_integer:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L66
	tcs
	phd
	tcd
offset_0	set	4
value_0	set	6
	pea	#<$2
	pei	<L66+offset_0
	jsl	~~check_write
	lda	|~~basicvars+6
	sta	<R0
	lda	|~~basicvars+6+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	<L66+value_0
	ldy	<L66+offset_0
	sta	[<R0],Y
	rep	#$20
	longa	on
	lda	<L66+offset_0
	ina
	sta	<R0
	lda	|~~basicvars+6
	sta	<R1
	lda	|~~basicvars+6+2
	sta	<R1+2
	lda	<L66+value_0
	ldx	#<$8
	xref	~~~asr
	jsl	~~~asr
	sep	#$20
	longa	off
	ldy	<R0
	sta	[<R1],Y
	rep	#$20
	longa	on
	clc
	lda	#$2
	adc	<L66+offset_0
	sta	<R0
	lda	|~~basicvars+6
	sta	<R1
	lda	|~~basicvars+6+2
	sta	<R1+2
	lda	<L66+value_0
	ldx	#<$10
	xref	~~~asr
	jsl	~~~asr
	sep	#$20
	longa	off
	ldy	<R0
	sta	[<R1],Y
	rep	#$20
	longa	on
	clc
	lda	#$3
	adc	<L66+offset_0
	sta	<R0
	lda	|~~basicvars+6
	sta	<R1
	lda	|~~basicvars+6+2
	sta	<R1+2
	lda	<L66+value_0
	ldx	#<$18
	xref	~~~asr
	jsl	~~~asr
	sep	#$20
	longa	off
	ldy	<R0
	sta	[<R1],Y
	rep	#$20
	longa	on
L68:
	lda	<L66+2
	sta	<L66+2+4
	lda	<L66+1
	sta	<L66+1+4
	pld
	tsc
	clc
	adc	#L66+4
	tcs
	rtl
L66	equ	8
L67	equ	9
	ends
	efunc
	code
	xdef	~~store_float
	func
~~store_float:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L69
	tcs
	phd
	tcd
offset_0	set	4
value_0	set	6
	pea	#<$4
	pei	<L69+offset_0
	jsl	~~check_write
	pea	#^$4
	pea	#<$4
	pea	#0
	clc
	tdc
	adc	#<L69+value_0
	pha
	ldy	#$0
	lda	<L69+offset_0
	bpl	L71
	dey
L71:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars+6
	adc	<R0
	sta	<R1
	lda	|~~basicvars+6+2
	adc	<R0+2
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	jsl	~~memmove
L72:
	lda	<L69+2
	sta	<L69+2+6
	lda	<L69+1
	sta	<L69+1+6
	pld
	tsc
	clc
	adc	#L69+6
	tcs
	rtl
L69	equ	8
L70	equ	9
	ends
	efunc
	code
	xdef	~~save_current
	func
~~save_current:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L73
	tcs
	phd
	tcd
	lda	|~~basicvars+447
	cmp	#<$a
	beq	L75
	brl	L10007
L75:
	pea	#<$5d
	pea	#4
	jsl	~~error
L10007:
	lda	|~~basicvars+447
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~basicvars+449
	adc	<R0
	sta	<R1
	lda	|~~basicvars+62
	sta	(<R1)
	lda	|~~basicvars+62+2
	ldy	#$2
	sta	(<R1),Y
	inc	|~~basicvars+447
L76:
	pld
	tsc
	clc
	adc	#L73
	tcs
	rtl
L73	equ	8
L74	equ	9
	ends
	efunc
	code
	xdef	~~restore_current
	func
~~restore_current:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L77
	tcs
	phd
	tcd
	dec	|~~basicvars+447
	lda	|~~basicvars+447
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~basicvars+449
	adc	<R0
	sta	<R1
	lda	(<R1)
	sta	|~~basicvars+62
	ldy	#$2
	lda	(<R1),Y
	sta	|~~basicvars+62+2
L79:
	pld
	tsc
	clc
	adc	#L77
	tcs
	rtl
L77	equ	8
L78	equ	9
	ends
	efunc
	code
	xdef	~~tocstring
	func
~~tocstring:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L80
	tcs
	phd
	tcd
cp_0	set	4
len_0	set	8
n_1	set	0
	lda	<L80+len_0
	beq	L82
	brl	L10008
L82:
	lda	#^L1
	tax
	lda	#<L1
L83:
	tay
	lda	<L80+2
	sta	<L80+2+6
	lda	<L80+1
	sta	<L80+1+6
	pld
	tsc
	clc
	adc	#L80+6
	tcs
	tya
	rtl
L10008:
	sec
	lda	<L80+len_0
	sbc	#<$80
	bvs	L84
	eor	#$8000
L84:
	bmi	L85
	brl	L10009
L85:
	lda	#$7f
	sta	<L80+len_0
L10009:
	lda	[<L80+cp_0]
	and	#$ff
	brl	L10010
L10012:
	pea	#^L1+1
	pea	#<L1+1
	lda	#<~~cstring
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~strcpy
	lda	#$4
	sta	<L81+n_1
	inc	<L80+cp_0
	bne	L86
	inc	<L80+cp_0+2
L86:
	brl	L10011
L10013:
	pea	#^L1+6
	pea	#<L1+6
	lda	#<~~cstring
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~strcpy
	lda	#$2
	sta	<L81+n_1
	inc	<L80+cp_0
	bne	L87
	inc	<L80+cp_0+2
L87:
	brl	L10011
L10014:
L10015:
	sep	#$20
	longa	off
	clc
	lda	#$40
	ldy	#$1
	adc	[<L80+cp_0],Y
	sta	|~~cstring
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	lda	#$25
	sta	|~~cstring+1
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	stz	|~~cstring+2
	rep	#$20
	longa	on
	lda	#<~~cstring
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	ldx	<R0+2
	lda	<R0
	brl	L83
L10016:
	stz	<L81+n_1
	brl	L10011
L10010:
	xref	~~~swt
	jsl	~~~swt
	dw	4
	dw	2
	dw	L10014-1
	dw	11
	dw	L10015-1
	dw	173
	dw	L10013-1
	dw	205
	dw	L10012-1
	dw	L10016-1
L10011:
L10017:
	sep	#$20
	longa	off
	lda	[<L80+cp_0]
	cmp	#<$20
	rep	#$20
	longa	on
	bcs	L88
	brl	L10018
L88:
	sec
	lda	<L81+n_1
	sbc	<L80+len_0
	bvs	L89
	eor	#$8000
L89:
	bpl	L90
	brl	L10018
L90:
	sep	#$20
	longa	off
	lda	[<L80+cp_0]
	ldx	<L81+n_1
	sta	|~~cstring,X
	rep	#$20
	longa	on
	inc	<L80+cp_0
	bne	L91
	inc	<L80+cp_0+2
L91:
	inc	<L81+n_1
	brl	L10017
L10018:
	lda	<L81+n_1
	cmp	#<$80
	beq	L92
	brl	L10019
L92:
	sep	#$20
	longa	off
	lda	#$2e
	ldx	<L81+n_1
	sta	|~~cstring+2,X
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	lda	#$2e
	ldx	<L81+n_1
	sta	|~~cstring+1,X
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	lda	#$2e
	ldx	<L81+n_1
	sta	|~~cstring,X
	rep	#$20
	longa	on
	inc	<L81+n_1
	inc	<L81+n_1
	inc	<L81+n_1
L10019:
	sep	#$20
	longa	off
	lda	#$0
	ldx	<L81+n_1
	sta	|~~cstring,X
	rep	#$20
	longa	on
	lda	#<~~cstring
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	ldx	<R0+2
	lda	<R0
	brl	L83
L80	equ	6
L81	equ	5
	ends
	efunc
	data
L1:
	db	$00,$50,$52,$4F,$43,$00,$46,$4E,$00
	ends
	code
	xdef	~~find_library
	func
~~find_library:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L94
	tcs
	phd
	tcd
wanted_0	set	4
lp_1	set	0
	lda	|~~basicvars+411
	sta	<L95+lp_1
	lda	|~~basicvars+411+2
	sta	<L95+lp_1+2
L10020:
	lda	<L95+lp_1
	ora	<L95+lp_1+2
	bne	L96
	brl	L10021
L96:
	lda	<L94+wanted_0
	ldy	#$8
	cmp	[<L95+lp_1],Y
	lda	<L94+wanted_0+2
	ldy	#$a
	sbc	[<L95+lp_1],Y
	bcs	L98
	brl	L97
L98:
	ldy	#$0
	phy
	ldy	#$c
	lda	[<L95+lp_1],Y
	ply
	rol	A
	ror	A
	bpl	L99
	dey
L99:
	sta	<R0
	sty	<R0+2
	clc
	ldy	#$8
	lda	[<L95+lp_1],Y
	adc	<R0
	sta	<R1
	ldy	#$a
	lda	[<L95+lp_1],Y
	adc	<R0+2
	sta	<R1+2
	lda	<L94+wanted_0
	cmp	<R1
	lda	<L94+wanted_0+2
	sbc	<R1+2
	bcs	L100
	brl	L10021
L100:
L97:
	lda	[<L95+lp_1]
	sta	<R0
	ldy	#$2
	lda	[<L95+lp_1],Y
	sta	<R0+2
	lda	<R0
	sta	<L95+lp_1
	lda	<R0+2
	sta	<L95+lp_1+2
	brl	L10020
L10021:
	lda	<L95+lp_1
	ora	<L95+lp_1+2
	beq	L101
	brl	L10022
L101:
	lda	|~~basicvars+415
	sta	<L95+lp_1
	lda	|~~basicvars+415+2
	sta	<L95+lp_1+2
L10023:
	lda	<L95+lp_1
	ora	<L95+lp_1+2
	bne	L102
	brl	L10024
L102:
	lda	<L94+wanted_0
	ldy	#$8
	cmp	[<L95+lp_1],Y
	lda	<L94+wanted_0+2
	ldy	#$a
	sbc	[<L95+lp_1],Y
	bcs	L104
	brl	L103
L104:
	ldy	#$0
	phy
	ldy	#$c
	lda	[<L95+lp_1],Y
	ply
	rol	A
	ror	A
	bpl	L105
	dey
L105:
	sta	<R0
	sty	<R0+2
	clc
	ldy	#$8
	lda	[<L95+lp_1],Y
	adc	<R0
	sta	<R1
	ldy	#$a
	lda	[<L95+lp_1],Y
	adc	<R0+2
	sta	<R1+2
	lda	<L94+wanted_0
	cmp	<R1
	lda	<L94+wanted_0+2
	sbc	<R1+2
	bcs	L106
	brl	L10024
L106:
L103:
	lda	[<L95+lp_1]
	sta	<R0
	ldy	#$2
	lda	[<L95+lp_1],Y
	sta	<R0+2
	lda	<R0
	sta	<L95+lp_1
	lda	<R0+2
	sta	<L95+lp_1+2
	brl	L10023
L10024:
L10022:
	ldx	<L95+lp_1+2
	lda	<L95+lp_1
L107:
	tay
	lda	<L94+2
	sta	<L94+2+4
	lda	<L94+1
	sta	<L94+1+4
	pld
	tsc
	clc
	adc	#L94+4
	tcs
	tya
	rtl
L94	equ	12
L95	equ	9
	ends
	efunc
	code
	xdef	~~find_linestart
	func
~~find_linestart:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L108
	tcs
	phd
	tcd
wanted_0	set	4
p_1	set	0
last_1	set	4
lp_1	set	8
	stz	<L109+p_1
	stz	<L109+p_1+2
	lda	<L108+wanted_0
	cmp	|~~basicvars+18
	lda	<L108+wanted_0+2
	sbc	|~~basicvars+18+2
	bcs	L110
	brl	L10025
L110:
	lda	<L108+wanted_0
	cmp	|~~basicvars+26
	lda	<L108+wanted_0+2
	sbc	|~~basicvars+26+2
	bcc	L111
	brl	L10025
L111:
	lda	|~~basicvars+22
	sta	<L109+p_1
	lda	|~~basicvars+22+2
	sta	<L109+p_1+2
	brl	L10026
L10025:
	pei	<L108+wanted_0+2
	pei	<L108+wanted_0
	jsl	~~find_library
	sta	<L109+lp_1
	stx	<L109+lp_1+2
	lda	<L109+lp_1
	ora	<L109+lp_1+2
	beq	L112
	brl	L10027
L112:
	lda	#$0
	tax
	lda	#$0
L113:
	tay
	lda	<L108+2
	sta	<L108+2+4
	lda	<L108+1
	sta	<L108+1+4
	pld
	tsc
	clc
	adc	#L108+4
	tcs
	tya
	rtl
L10027:
	ldy	#$8
	lda	[<L109+lp_1],Y
	sta	<L109+p_1
	ldy	#$a
	lda	[<L109+lp_1],Y
	sta	<L109+p_1+2
L10026:
	lda	<L109+p_1
	sta	<L109+last_1
	lda	<L109+p_1+2
	sta	<L109+last_1+2
L10028:
	lda	<L108+wanted_0
	cmp	<L109+p_1
	lda	<L108+wanted_0+2
	sbc	<L109+p_1+2
	bcs	L114
	brl	L10029
L114:
	lda	<L109+p_1
	sta	<L109+last_1
	lda	<L109+p_1+2
	sta	<L109+last_1+2
	ldy	#$2
	lda	[<L109+p_1],Y
	and	#$ff
	sta	<R0
	ldy	#$3
	lda	[<L109+p_1],Y
	and	#$ff
	sta	<R2
	lda	<R2
	xba
	and	#$ff00
	sta	<R1
	lda	<R1
	ora	<R0
	sta	<R2
	ldy	#$0
	lda	<R2
	bpl	L115
	dey
L115:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L109+p_1
	adc	<R0
	sta	<L109+p_1
	lda	<L109+p_1+2
	adc	<R0+2
	sta	<L109+p_1+2
	brl	L10028
L10029:
	ldx	<L109+last_1+2
	lda	<L109+last_1
	brl	L113
L108	equ	24
L109	equ	13
	ends
	efunc
	code
	xdef	~~find_line
	func
~~find_line:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L116
	tcs
	phd
	tcd
lineno_0	set	4
p_1	set	0
cp_1	set	4
lp_1	set	8
	lda	|~~basicvars+423
	bit	#$1
	bne	L118
	brl	L10030
L118:
	lda	|~~basicvars+62
	sta	<L117+cp_1
	lda	|~~basicvars+62+2
	sta	<L117+cp_1+2
	lda	<L117+cp_1
	cmp	|~~basicvars+18
	lda	<L117+cp_1+2
	sbc	|~~basicvars+18+2
	bcs	L119
	brl	L10031
L119:
	lda	<L117+cp_1
	cmp	|~~basicvars+26
	lda	<L117+cp_1+2
	sbc	|~~basicvars+26+2
	bcc	L120
	brl	L10031
L120:
	lda	|~~basicvars+22
	sta	<L117+p_1
	lda	|~~basicvars+22+2
	sta	<L117+p_1+2
	brl	L10032
L10031:
	pei	<L117+cp_1+2
	pei	<L117+cp_1
	jsl	~~find_library
	sta	<L117+lp_1
	stx	<L117+lp_1+2
	lda	<L117+lp_1
	ora	<L117+lp_1+2
	beq	L121
	brl	L10033
L121:
	pea	#^L93
	pea	#<L93
	pea	#<$156
	pea	#<$82
	pea	#10
	jsl	~~error
L10033:
	ldy	#$8
	lda	[<L117+lp_1],Y
	sta	<L117+p_1
	ldy	#$a
	lda	[<L117+lp_1],Y
	sta	<L117+p_1+2
L10032:
	brl	L10034
L10030:
	lda	|~~basicvars+22
	sta	<L117+p_1
	lda	|~~basicvars+22+2
	sta	<L117+p_1+2
L10034:
L10035:
	pei	<L117+p_1+2
	pei	<L117+p_1
	jsl	~~get_lineno
	sta	<R0
	sec
	lda	<R0
	sbc	<L116+lineno_0
	bvs	L122
	eor	#$8000
L122:
	bpl	L123
	brl	L10036
L123:
	pei	<L117+p_1+2
	pei	<L117+p_1
	jsl	~~get_linelen
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L124
	dey
L124:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L117+p_1
	adc	<R0
	sta	<L117+p_1
	lda	<L117+p_1+2
	adc	<R0+2
	sta	<L117+p_1+2
	brl	L10035
L10036:
	ldx	<L117+p_1+2
	lda	<L117+p_1
L125:
	tay
	lda	<L116+2
	sta	<L116+2+2
	lda	<L116+1
	sta	<L116+1+2
	pld
	tsc
	clc
	adc	#L116+2
	tcs
	tya
	rtl
L116	equ	16
L117	equ	5
	ends
	efunc
	data
L93:
	db	$6D,$69,$73,$63,$00
	ends
	code
	xdef	~~show_byte
	func
~~show_byte:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L127
	tcs
	phd
	tcd
low_0	set	4
high_0	set	6
n_1	set	0
x_1	set	2
ll_1	set	4
count_1	set	6
ch_1	set	8
	lda	<L127+low_0
	bpl	L130
	brl	L129
L130:
	sec
	lda	<L127+low_0
	sbc	|~~basicvars+4
	bvs	L131
	eor	#$8000
L131:
	bpl	L132
	brl	L129
L132:
	lda	<L127+high_0
	bpl	L133
	brl	L129
L133:
	sec
	lda	<L127+high_0
	sbc	<L127+low_0
	bvs	L134
	eor	#$8000
L134:
	bpl	L135
	brl	L10037
L135:
L129:
L136:
	lda	<L127+2
	sta	<L127+2+4
	lda	<L127+1
	sta	<L127+1+4
	pld
	tsc
	clc
	adc	#L127+4
	tcs
	rtl
L10037:
	sec
	lda	|~~basicvars+4
	sbc	<L127+high_0
	bvs	L137
	eor	#$8000
L137:
	bpl	L138
	brl	L10038
L138:
	clc
	lda	#$ffff
	adc	|~~basicvars+4
	sta	<L127+high_0
L10038:
	sec
	lda	<L127+high_0
	sbc	<L127+low_0
	sta	<L128+count_1
	stz	<L128+n_1
	brl	L10042
L10041:
	pei	<L127+low_0
	pea	#^L126
	pea	#<L126
	pea	#8
	jsl	~~emulate_printf
	stz	<L128+x_1
	stz	<L128+ll_1
L10045:
	clc
	lda	<L128+n_1
	adc	<L128+ll_1
	sta	<R0
	sec
	lda	<R0
	sbc	<L128+count_1
	bvs	L139
	eor	#$8000
L139:
	bmi	L140
	brl	L10046
L140:
	pea	#^L126+7
	pea	#<L126+7
	pea	#6
	jsl	~~emulate_printf
	brl	L10047
L10046:
	clc
	lda	<L127+low_0
	adc	<L128+ll_1
	sta	<R0
	lda	|~~basicvars+6
	sta	<R1
	lda	|~~basicvars+6+2
	sta	<R1+2
	ldy	<R0
	lda	[<R1],Y
	and	#$ff
	pha
	pea	#^L126+11
	pea	#<L126+11
	pea	#8
	jsl	~~emulate_printf
L10047:
	inc	<L128+x_1
	lda	<L128+x_1
	cmp	#<$4
	beq	L141
	brl	L10048
L141:
	stz	<L128+x_1
	pea	#<$20
	jsl	~~emulate_vdu
L10048:
L10043:
	inc	<L128+ll_1
	sec
	lda	<L128+ll_1
	sbc	#<$10
	bvs	L142
	eor	#$8000
L142:
	bmi	L143
	brl	L10045
L143:
L10044:
	stz	<L128+ll_1
L10051:
	clc
	lda	<L128+n_1
	adc	<L128+ll_1
	sta	<R0
	sec
	lda	<R0
	sbc	<L128+count_1
	bvs	L144
	eor	#$8000
L144:
	bmi	L145
	brl	L10052
L145:
	pea	#<$2e
	jsl	~~emulate_vdu
	brl	L10053
L10052:
	clc
	lda	<L127+low_0
	adc	<L128+ll_1
	sta	<R0
	lda	|~~basicvars+6
	sta	<R1
	lda	|~~basicvars+6+2
	sta	<R1+2
	sep	#$20
	longa	off
	ldy	<R0
	lda	[<R1],Y
	sta	<L128+ch_1
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	lda	<L128+ch_1
	cmp	#<$20
	rep	#$20
	longa	on
	bcs	L146
	brl	L10054
L146:
	sep	#$20
	longa	off
	lda	#$7e
	cmp	<L128+ch_1
	rep	#$20
	longa	on
	bcs	L147
	brl	L10054
L147:
	lda	<L128+ch_1
	and	#$ff
	pha
	jsl	~~emulate_vdu
	brl	L10055
L10054:
	pea	#<$2e
	jsl	~~emulate_vdu
L10055:
L10053:
L10049:
	inc	<L128+ll_1
	sec
	lda	<L128+ll_1
	sbc	#<$10
	bvs	L148
	eor	#$8000
L148:
	bmi	L149
	brl	L10051
L149:
L10050:
	pea	#<$d
	jsl	~~emulate_vdu
	pea	#<$a
	jsl	~~emulate_vdu
	clc
	lda	#$10
	adc	<L127+low_0
	sta	<L127+low_0
L10039:
	clc
	lda	#$10
	adc	<L128+n_1
	sta	<L128+n_1
L10042:
	sec
	lda	<L128+n_1
	sbc	<L128+count_1
	bvs	L150
	eor	#$8000
L150:
	bmi	L151
	brl	L10041
L151:
L10040:
	brl	L136
L127	equ	17
L128	equ	9
	ends
	efunc
	data
L126:
	db	$25,$30,$36,$78,$20,$20,$00,$20,$20,$20,$00,$25,$30,$32,$78
	db	$20,$00
	ends
	code
	xdef	~~show_word
	func
~~show_word:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L153
	tcs
	phd
	tcd
low_0	set	4
high_0	set	6
n_1	set	0
ll_1	set	2
count_1	set	4
ch_1	set	6
	lda	<L153+low_0
	ina
	and	#<$fffffffe
	sta	<L153+low_0
	lda	<L153+high_0
	ina
	and	#<$fffffffe
	sta	<L153+high_0
	lda	<L153+low_0
	bpl	L156
	brl	L155
L156:
	sec
	lda	<L153+low_0
	sbc	|~~basicvars+4
	bvs	L157
	eor	#$8000
L157:
	bpl	L158
	brl	L155
L158:
	lda	<L153+high_0
	bpl	L159
	brl	L155
L159:
	sec
	lda	<L153+high_0
	sbc	<L153+low_0
	bvs	L160
	eor	#$8000
L160:
	bpl	L161
	brl	L10056
L161:
L155:
L162:
	lda	<L153+2
	sta	<L153+2+4
	lda	<L153+1
	sta	<L153+1+4
	pld
	tsc
	clc
	adc	#L153+4
	tcs
	rtl
L10056:
	sec
	lda	|~~basicvars+4
	sbc	<L153+high_0
	bvs	L163
	eor	#$8000
L163:
	bpl	L164
	brl	L10057
L164:
	lda	|~~basicvars+4
	sta	<L153+high_0
L10057:
	sec
	lda	<L153+high_0
	sbc	<L153+low_0
	sta	<L154+count_1
	stz	<L154+n_1
	brl	L10061
L10060:
	clc
	lda	#$c
	adc	<L153+low_0
	pha
	jsl	~~get_integer
	pha
	clc
	lda	#$8
	adc	<L153+low_0
	pha
	jsl	~~get_integer
	pha
	clc
	lda	#$4
	adc	<L153+low_0
	pha
	jsl	~~get_integer
	pha
	pei	<L153+low_0
	jsl	~~get_integer
	pha
	pei	<L154+n_1
	pei	<L153+low_0
	pea	#^L152
	pea	#<L152
	pea	#18
	jsl	~~emulate_printf
	stz	<L154+ll_1
L10064:
	clc
	lda	<L154+n_1
	adc	<L154+ll_1
	sta	<R0
	sec
	lda	<R0
	sbc	<L154+count_1
	bvs	L165
	eor	#$8000
L165:
	bmi	L166
	brl	L10065
L166:
	pea	#<$2e
	jsl	~~emulate_vdu
	brl	L10066
L10065:
	clc
	lda	<L153+low_0
	adc	<L154+ll_1
	sta	<R0
	lda	|~~basicvars+6
	sta	<R1
	lda	|~~basicvars+6+2
	sta	<R1+2
	sep	#$20
	longa	off
	ldy	<R0
	lda	[<R1],Y
	sta	<L154+ch_1
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	lda	<L154+ch_1
	cmp	#<$20
	rep	#$20
	longa	on
	bcs	L167
	brl	L10067
L167:
	sep	#$20
	longa	off
	lda	#$7e
	cmp	<L154+ch_1
	rep	#$20
	longa	on
	bcs	L168
	brl	L10067
L168:
	lda	<L154+ch_1
	and	#$ff
	pha
	jsl	~~emulate_vdu
	brl	L10068
L10067:
	pea	#<$2e
	jsl	~~emulate_vdu
L10068:
L10066:
L10062:
	inc	<L154+ll_1
	sec
	lda	<L154+ll_1
	sbc	#<$10
	bvs	L169
	eor	#$8000
L169:
	bmi	L170
	brl	L10064
L170:
L10063:
	pea	#<$d
	jsl	~~emulate_vdu
	pea	#<$a
	jsl	~~emulate_vdu
	clc
	lda	#$10
	adc	<L153+low_0
	sta	<L153+low_0
L10058:
	clc
	lda	#$10
	adc	<L154+n_1
	sta	<L154+n_1
L10061:
	sec
	lda	<L154+n_1
	sbc	<L154+count_1
	bvs	L171
	eor	#$8000
L171:
	bmi	L172
	brl	L10060
L172:
L10059:
	brl	L162
L153	equ	15
L154	equ	9
	ends
	efunc
	data
L152:
	db	$25,$30,$36,$78,$20,$20,$2B,$25,$30,$34,$78,$20,$20,$25,$30
	db	$38,$78,$20,$20,$25,$30,$38,$78,$20,$20,$25,$30,$38,$78,$20
	db	$20,$25,$30,$38,$78,$20,$20,$00
	ends
	code
	func
~~strip:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L174
	tcs
	phd
	tcd
line_0	set	4
n_1	set	0
	pei	<L174+line_0+2
	pei	<L174+line_0
	jsl	~~strlen
	sta	<L175+n_1
	lda	<L175+n_1
	bne	L176
	brl	L10069
L176:
L10072:
	dec	<L175+n_1
L10070:
	lda	<L175+n_1
	bpl	L178
	brl	L177
L178:
	ldy	<L175+n_1
	lda	[<L174+line_0],Y
	and	#$ff
	pha
	jsl	~~isspace
	tax
	beq	L179
	brl	L10072
L179:
L177:
L10071:
	inc	<L175+n_1
L10069:
	sep	#$20
	longa	off
	lda	#$0
	ldy	<L175+n_1
	sta	[<L174+line_0],Y
	rep	#$20
	longa	on
L180:
	lda	<L174+2
	sta	<L174+2+4
	lda	<L174+1
	sta	<L174+1+4
	pld
	tsc
	clc
	adc	#L174+4
	tcs
	rtl
L174	equ	2
L175	equ	1
	ends
	efunc
	code
	xdef	~~read_line
	func
~~read_line:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L181
	tcs
	phd
	tcd
line_0	set	4
linelen_0	set	8
result_1	set	0
	sep	#$20
	longa	off
	lda	#$0
	sta	[<L181+line_0]
	rep	#$20
	longa	on
	pei	<L181+linelen_0
	pei	<L181+line_0+2
	pei	<L181+line_0
	jsl	~~emulate_readline
	sta	<L182+result_1
	lda	<L182+result_1
	cmp	#<$1
	bne	L184
	brl	L183
L184:
	lda	|~~basicvars+489
	and	#$ff
	bne	L185
	brl	L10073
L185:
L183:
	pea	#<$8
	pea	#4
	jsl	~~error
L10073:
	lda	<L182+result_1
	cmp	#<$2
	beq	L186
	brl	L10074
L186:
	lda	#$0
L187:
	tay
	lda	<L181+2
	sta	<L181+2+6
	lda	<L181+1
	sta	<L181+1+6
	pld
	tsc
	clc
	adc	#L181+6
	tcs
	tya
	rtl
L10074:
	pei	<L181+line_0+2
	pei	<L181+line_0
	jsl	~~strip
	lda	#$1
	brl	L187
L181	equ	2
L182	equ	1
	ends
	efunc
	code
	xdef	~~amend_line
	func
~~amend_line:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L188
	tcs
	phd
	tcd
line_0	set	4
linelen_0	set	8
result_1	set	0
	pei	<L188+linelen_0
	pei	<L188+line_0+2
	pei	<L188+line_0
	jsl	~~emulate_readline
	sta	<L189+result_1
	lda	<L189+result_1
	cmp	#<$1
	bne	L191
	brl	L190
L191:
	lda	|~~basicvars+489
	and	#$ff
	bne	L192
	brl	L10075
L192:
L190:
	pea	#<$8
	pea	#4
	jsl	~~error
L10075:
	lda	<L189+result_1
	cmp	#<$2
	beq	L193
	brl	L10076
L193:
	lda	#$0
L194:
	tay
	lda	<L188+2
	sta	<L188+2+6
	lda	<L188+1
	sta	<L188+1+6
	pld
	tsc
	clc
	adc	#L188+6
	tcs
	tya
	rtl
L10076:
	pei	<L188+line_0+2
	pei	<L188+line_0
	jsl	~~strip
	lda	#$1
	brl	L194
L188	equ	2
L189	equ	1
	ends
	efunc
	code
	xdef	~~secure_tmpnam
	func
~~secure_tmpnam:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L195
	tcs
	phd
	tcd
name_0	set	4
retry_1	set	0
	lda	#$4
	sta	<L196+retry_1
L10079:
	pei	<L195+name_0+2
	pei	<L195+name_0
	jsl	~~tmpnam
	sta	<R0
	stx	<R0+2
	lda	<R0
	ora	<R0+2
	bne	L197
	brl	L10077
L197:
info_2	set	2
	pea	#0
	clc
	tdc
	adc	#<L196+info_2
	pha
	pei	<L195+name_0+2
	pei	<L195+name_0
	jsl	~~stat
	tax
	bne	L198
	brl	L10080
L198:
	jsl	~~__errno_location
	sta	<R0
	stx	<R0+2
	lda	[<R0]
	cmp	#<$1
	beq	L199
	brl	L10081
L199:
	lda	#$1
L200:
	tay
	lda	<L195+2
	sta	<L195+2+4
	lda	<L195+1
	sta	<L195+1+4
	pld
	tsc
	clc
	adc	#L195+4
	tcs
	tya
	rtl
L10081:
	brl	L10082
L10080:
	pei	<L195+name_0+2
	pei	<L195+name_0
	jsl	~~remove
	tax
	beq	L201
	brl	L10083
L201:
	lda	#$1
	brl	L200
L10083:
L10082:
L10077:
	dec	<L196+retry_1
	lda	<L196+retry_1
	beq	L202
	brl	L10079
L202:
L10078:
	lda	#$0
	brl	L200
L195	equ	12
L196	equ	5
	ends
	efunc
	xref	~~stat
	xref	~~emulate_printf
	xref	~~emulate_vdu
	xref	~~emulate_readline
	xref	~~error
	xref	~~get_linelen
	xref	~~get_lineno
	xref	~~__errno_location
	xref	~~strlen
	xref	~~memmove
	xref	~~strcpy
	xref	~~isspace
	xref	~~isalpha
	xref	~~isalnum
	xref	~~tmpnam
	xref	~~remove
	udata
	xdef	~~cstring
~~cstring
	ds	132
	ends
	xref	~~basicvars
	end
