;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
	code
	func
~~bad_token:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
	pea	#^L1
	pea	#<L1
	pea	#<$5f
	pea	#<$82
	pea	#10
	jsl	~~error
L4:
	pld
	tsc
	clc
	adc	#L2
	tcs
	rtl
L2	equ	0
L3	equ	1
	ends
	efunc
	data
L1:
	db	$65,$78,$70,$72,$65,$73,$73,$69,$6F,$6E,$73,$00
	ends
	code
	xdef	~~eval_integer
	func
~~eval_integer:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L6
	tcs
	phd
	tcd
numtype_1	set	0
	jsl	~~expression
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L7+numtype_1
	lda	<L7+numtype_1
	cmp	#<$2
	beq	L8
	brl	L10001
L8:
	jsl	~~pop_int
L9:
	tay
	pld
	tsc
	clc
	adc	#L6
	tcs
	tya
	rtl
L10001:
	lda	<L7+numtype_1
	cmp	#<$3
	beq	L10
	brl	L10002
L10:
	phy
	phy
	jsl	~~pop_float
	ply
	ply
	lda	<R0
	brl	L9
L10002:
	pea	#<$3f
	pea	#4
	jsl	~~error
	lda	#$0
	brl	L9
L6	equ	6
L7	equ	5
	ends
	efunc
	code
	xdef	~~eval_intfactor
	func
~~eval_intfactor:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L11
	tcs
	phd
	tcd
numtype_1	set	0
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	lda	[<R1]
	and	#$ff
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~factor_table
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	tax
	lda	(<R1)
	xref	~~~lcal
	jsl	~~~lcal
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L12+numtype_1
	lda	<L12+numtype_1
	cmp	#<$2
	beq	L13
	brl	L10003
L13:
	jsl	~~pop_int
L14:
	tay
	pld
	tsc
	clc
	adc	#L11
	tcs
	tya
	rtl
L10003:
	lda	<L12+numtype_1
	cmp	#<$3
	beq	L15
	brl	L10004
L15:
	phy
	phy
	jsl	~~pop_float
	ply
	ply
	lda	<R0
	brl	L14
L10004:
	pea	#<$3f
	pea	#4
	jsl	~~error
	lda	#$0
	brl	L14
L11	equ	10
L12	equ	9
	ends
	efunc
	code
	func
~~fn_himem:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L16
	tcs
	phd
	tcd
	sec
	lda	|~~basicvars+50
	sbc	|~~basicvars+6
	sta	<R0
	lda	|~~basicvars+50+2
	sbc	|~~basicvars+6+2
	sta	<R0+2
	pei	<R0
	jsl	~~push_int
L18:
	pld
	tsc
	clc
	adc	#L16
	tcs
	rtl
L16	equ	4
L17	equ	5
	ends
	efunc
	code
	func
~~fn_ext:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L19
	tcs
	phd
	tcd
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$23
	rep	#$20
	longa	on
	bne	L21
	brl	L10005
L21:
	pea	#<$2c
	pea	#4
	jsl	~~error
L10005:
	inc	|~~basicvars+62
	bne	L22
	inc	|~~basicvars+62+2
L22:
	jsl	~~eval_intfactor
	pha
	jsl	~~fileio_getext
	pha
	jsl	~~push_int
L23:
	pld
	tsc
	clc
	adc	#L19
	tcs
	rtl
L19	equ	4
L20	equ	5
	ends
	efunc
	code
	func
~~fn_filepath:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L24
	tcs
	phd
	tcd
length_1	set	0
cp_1	set	2
	lda	|~~basicvars+419
	ora	|~~basicvars+419+2
	beq	L26
	brl	L10006
L26:
	stz	<L25+length_1
	brl	L10007
L10006:
	lda	|~~basicvars+419+2
	pha
	lda	|~~basicvars+419
	pha
	jsl	~~strlen
	sta	<L25+length_1
L10007:
	pei	<L25+length_1
	jsl	~~alloc_string
	sta	<L25+cp_1
	stx	<L25+cp_1+2
	sec
	lda	#$0
	sbc	<L25+length_1
	bvs	L27
	eor	#$8000
L27:
	bpl	L28
	brl	L10008
L28:
	ldy	#$0
	lda	<L25+length_1
	bpl	L29
	dey
L29:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	lda	|~~basicvars+419+2
	pha
	lda	|~~basicvars+419
	pha
	pei	<L25+cp_1+2
	pei	<L25+cp_1
	jsl	~~memcpy
L10008:
	pei	<L25+cp_1+2
	pei	<L25+cp_1
	pei	<L25+length_1
	jsl	~~push_strtemp
L30:
	pld
	tsc
	clc
	adc	#L24
	tcs
	rtl
L24	equ	10
L25	equ	5
	ends
	efunc
	code
	func
~~fn_left:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L31
	tcs
	phd
	tcd
stringtype_1	set	0
descriptor_1	set	2
length_1	set	8
cp_1	set	10
	jsl	~~expression
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L32+stringtype_1
	lda	<L32+stringtype_1
	cmp	#<$4
	bne	L33
	brl	L10009
L33:
	lda	<L32+stringtype_1
	cmp	#<$5
	bne	L34
	brl	L10009
L34:
	pea	#<$40
	pea	#4
	jsl	~~error
L10009:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$2c
	rep	#$20
	longa	on
	beq	L35
	brl	L10010
L35:
	inc	|~~basicvars+62
	bne	L36
	inc	|~~basicvars+62+2
L36:
	jsl	~~eval_integer
	sta	<L32+length_1
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$29
	rep	#$20
	longa	on
	bne	L37
	brl	L10011
L37:
	pea	#<$29
	pea	#4
	jsl	~~error
L10011:
	inc	|~~basicvars+62
	bne	L38
	inc	|~~basicvars+62+2
L38:
	lda	<L32+length_1
	bmi	L39
	brl	L10012
L39:
L40:
	pld
	tsc
	clc
	adc	#L31
	tcs
	rtl
L10012:
	lda	<L32+length_1
	beq	L41
	brl	L10013
L41:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L32+descriptor_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	lda	<L32+stringtype_1
	cmp	#<$5
	beq	L42
	brl	L10014
L42:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L32+descriptor_1
	sta	<R1
	lda	#$0
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
L10014:
	pea	#<$0
	jsl	~~alloc_string
	sta	<L32+cp_1
	stx	<L32+cp_1+2
	pei	<L32+cp_1+2
	pei	<L32+cp_1
	pea	#<$0
	jsl	~~push_strtemp
	brl	L10015
L10013:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L32+descriptor_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	sec
	lda	<L32+length_1
	sbc	<L32+descriptor_1
	bvs	L43
	eor	#$8000
L43:
	bmi	L44
	brl	L10016
L44:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L32+descriptor_1
	sta	<R1
	lda	#$0
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~push_string
	brl	L10017
L10016:
	pei	<L32+length_1
	jsl	~~alloc_string
	sta	<L32+cp_1
	stx	<L32+cp_1+2
	ldy	#$0
	lda	<L32+length_1
	bpl	L45
	dey
L45:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L32+descriptor_1+4
	pei	<L32+descriptor_1+2
	pei	<L32+cp_1+2
	pei	<L32+cp_1
	jsl	~~memcpy
	pei	<L32+cp_1+2
	pei	<L32+cp_1
	pei	<L32+length_1
	jsl	~~push_strtemp
	lda	<L32+stringtype_1
	cmp	#<$5
	beq	L46
	brl	L10018
L46:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L32+descriptor_1
	sta	<R1
	lda	#$0
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
L10018:
L10017:
L10015:
	brl	L10019
L10010:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$29
	rep	#$20
	longa	on
	bne	L47
	brl	L10020
L47:
	pea	#<$29
	pea	#4
	jsl	~~error
L10020:
	inc	|~~basicvars+62
	bne	L48
	inc	|~~basicvars+62+2
L48:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L32+descriptor_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	clc
	lda	#$ffff
	adc	<L32+descriptor_1
	sta	<L32+length_1
	sec
	lda	#$0
	sbc	<L32+length_1
	bvs	L49
	eor	#$8000
L49:
	bmi	L50
	brl	L10021
L50:
	lda	<L32+stringtype_1
	cmp	#<$5
	beq	L51
	brl	L10022
L51:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L32+descriptor_1
	sta	<R1
	lda	#$0
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
L10022:
	pea	#<$0
	jsl	~~alloc_string
	sta	<L32+cp_1
	stx	<L32+cp_1+2
	pei	<L32+cp_1+2
	pei	<L32+cp_1
	pea	#<$0
	jsl	~~push_strtemp
	brl	L10023
L10021:
	pei	<L32+length_1
	jsl	~~alloc_string
	sta	<L32+cp_1
	stx	<L32+cp_1+2
	ldy	#$0
	lda	<L32+length_1
	bpl	L52
	dey
L52:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L32+descriptor_1+4
	pei	<L32+descriptor_1+2
	pei	<L32+cp_1+2
	pei	<L32+cp_1
	jsl	~~memmove
	pei	<L32+cp_1+2
	pei	<L32+cp_1
	pei	<L32+length_1
	jsl	~~push_strtemp
	lda	<L32+stringtype_1
	cmp	#<$5
	beq	L53
	brl	L10024
L53:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L32+descriptor_1
	sta	<R1
	lda	#$0
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
L10024:
L10023:
L10019:
	brl	L40
L31	equ	22
L32	equ	9
	ends
	efunc
	code
	func
~~fn_lomem:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L54
	tcs
	phd
	tcd
	sec
	lda	|~~basicvars+30
	sbc	|~~basicvars+6
	sta	<R0
	lda	|~~basicvars+30+2
	sbc	|~~basicvars+6+2
	sta	<R0+2
	pei	<R0
	jsl	~~push_int
L56:
	pld
	tsc
	clc
	adc	#L54
	tcs
	rtl
L54	equ	4
L55	equ	5
	ends
	efunc
	code
	func
~~fn_mid:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L57
	tcs
	phd
	tcd
stringtype_1	set	0
descriptor_1	set	2
start_1	set	8
length_1	set	10
cp_1	set	12
	jsl	~~expression
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L58+stringtype_1
	lda	<L58+stringtype_1
	cmp	#<$4
	bne	L59
	brl	L10025
L59:
	lda	<L58+stringtype_1
	cmp	#<$5
	bne	L60
	brl	L10025
L60:
	pea	#<$40
	pea	#4
	jsl	~~error
L10025:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$2c
	rep	#$20
	longa	on
	bne	L61
	brl	L10026
L61:
	pea	#<$27
	pea	#4
	jsl	~~error
L10026:
	inc	|~~basicvars+62
	bne	L62
	inc	|~~basicvars+62+2
L62:
	jsl	~~eval_integer
	sta	<L58+start_1
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$2c
	rep	#$20
	longa	on
	beq	L63
	brl	L10027
L63:
	inc	|~~basicvars+62
	bne	L64
	inc	|~~basicvars+62+2
L64:
	jsl	~~eval_integer
	sta	<L58+length_1
	lda	<L58+length_1
	bmi	L65
	brl	L10028
L65:
	lda	#$1000
	sta	<L58+length_1
L10028:
	brl	L10029
L10027:
	lda	#$1000
	sta	<L58+length_1
L10029:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$29
	rep	#$20
	longa	on
	bne	L66
	brl	L10030
L66:
	pea	#<$29
	pea	#4
	jsl	~~error
L10030:
	inc	|~~basicvars+62
	bne	L67
	inc	|~~basicvars+62+2
L67:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L58+descriptor_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	lda	<L58+length_1
	bne	L69
	brl	L68
L69:
	lda	<L58+start_1
	bpl	L70
	brl	L68
L70:
	sec
	lda	<L58+descriptor_1
	sbc	<L58+start_1
	bvs	L71
	eor	#$8000
L71:
	bpl	L72
	brl	L10031
L72:
L68:
	lda	<L58+stringtype_1
	cmp	#<$5
	beq	L73
	brl	L10032
L73:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L58+descriptor_1
	sta	<R1
	lda	#$0
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
L10032:
	pea	#<$0
	jsl	~~alloc_string
	sta	<L58+cp_1
	stx	<L58+cp_1+2
	pei	<L58+cp_1+2
	pei	<L58+cp_1
	pea	#<$0
	jsl	~~push_strtemp
	brl	L10033
L10031:
	sec
	lda	#$0
	sbc	<L58+start_1
	bvs	L74
	eor	#$8000
L74:
	bpl	L75
	brl	L10034
L75:
	dec	<L58+start_1
L10034:
	lda	<L58+start_1
	beq	L76
	brl	L10035
L76:
	sec
	lda	<L58+length_1
	sbc	<L58+descriptor_1
	bvs	L77
	eor	#$8000
L77:
	bmi	L78
	brl	L10035
L78:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L58+descriptor_1
	sta	<R1
	lda	#$0
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~push_string
	brl	L10036
L10035:
	clc
	lda	<L58+start_1
	adc	<L58+length_1
	sta	<R0
	sec
	lda	<L58+descriptor_1
	sbc	<R0
	bvs	L79
	eor	#$8000
L79:
	bpl	L80
	brl	L10037
L80:
	sec
	lda	<L58+descriptor_1
	sbc	<L58+start_1
	sta	<L58+length_1
L10037:
	pei	<L58+length_1
	jsl	~~alloc_string
	sta	<L58+cp_1
	stx	<L58+cp_1+2
	ldy	#$0
	lda	<L58+length_1
	bpl	L81
	dey
L81:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	ldy	#$0
	lda	<L58+start_1
	bpl	L82
	dey
L82:
	sta	<R1
	sty	<R1+2
	clc
	lda	<L58+descriptor_1+2
	adc	<R1
	sta	<R2
	lda	<L58+descriptor_1+4
	adc	<R1+2
	sta	<R2+2
	pei	<R2+2
	pei	<R2
	pei	<L58+cp_1+2
	pei	<L58+cp_1
	jsl	~~memcpy
	pei	<L58+cp_1+2
	pei	<L58+cp_1
	pei	<L58+length_1
	jsl	~~push_strtemp
	lda	<L58+stringtype_1
	cmp	#<$5
	beq	L83
	brl	L10038
L83:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L58+descriptor_1
	sta	<R1
	lda	#$0
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
L10038:
L10036:
L10033:
L84:
	pld
	tsc
	clc
	adc	#L57
	tcs
	rtl
L57	equ	28
L58	equ	13
	ends
	efunc
	code
	func
~~fn_page:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L85
	tcs
	phd
	tcd
	sec
	lda	|~~basicvars+18
	sbc	|~~basicvars+6
	sta	<R0
	lda	|~~basicvars+18+2
	sbc	|~~basicvars+6+2
	sta	<R0+2
	pei	<R0
	jsl	~~push_int
L87:
	pld
	tsc
	clc
	adc	#L85
	tcs
	rtl
L85	equ	4
L86	equ	5
	ends
	efunc
	code
	func
~~fn_ptr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L88
	tcs
	phd
	tcd
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$23
	rep	#$20
	longa	on
	bne	L90
	brl	L10039
L90:
	pea	#<$2c
	pea	#4
	jsl	~~error
L10039:
	inc	|~~basicvars+62
	bne	L91
	inc	|~~basicvars+62+2
L91:
	jsl	~~eval_intfactor
	pha
	jsl	~~fileio_getptr
	pha
	jsl	~~push_int
L92:
	pld
	tsc
	clc
	adc	#L88
	tcs
	rtl
L88	equ	4
L89	equ	5
	ends
	efunc
	code
	func
~~fn_right:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L93
	tcs
	phd
	tcd
stringtype_1	set	0
descriptor_1	set	2
length_1	set	8
cp_1	set	10
	jsl	~~expression
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L94+stringtype_1
	lda	<L94+stringtype_1
	cmp	#<$4
	bne	L95
	brl	L10040
L95:
	lda	<L94+stringtype_1
	cmp	#<$5
	bne	L96
	brl	L10040
L96:
	pea	#<$40
	pea	#4
	jsl	~~error
L10040:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$2c
	rep	#$20
	longa	on
	beq	L97
	brl	L10041
L97:
	inc	|~~basicvars+62
	bne	L98
	inc	|~~basicvars+62+2
L98:
	jsl	~~eval_integer
	sta	<L94+length_1
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$29
	rep	#$20
	longa	on
	bne	L99
	brl	L10042
L99:
	pea	#<$29
	pea	#4
	jsl	~~error
L10042:
	inc	|~~basicvars+62
	bne	L100
	inc	|~~basicvars+62+2
L100:
	sec
	lda	#$0
	sbc	<L94+length_1
	bvs	L101
	eor	#$8000
L101:
	bmi	L102
	brl	L10043
L102:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L94+descriptor_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	lda	<L94+stringtype_1
	cmp	#<$5
	beq	L103
	brl	L10044
L103:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L94+descriptor_1
	sta	<R1
	lda	#$0
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
L10044:
	pea	#<$0
	jsl	~~alloc_string
	sta	<L94+cp_1
	stx	<L94+cp_1+2
	pei	<L94+cp_1+2
	pei	<L94+cp_1
	pea	#<$0
	jsl	~~push_strtemp
	brl	L10045
L10043:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L94+descriptor_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	sec
	lda	<L94+length_1
	sbc	<L94+descriptor_1
	bvs	L104
	eor	#$8000
L104:
	bmi	L105
	brl	L10046
L105:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L94+descriptor_1
	sta	<R1
	lda	#$0
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~push_string
	brl	L10047
L10046:
	pei	<L94+length_1
	jsl	~~alloc_string
	sta	<L94+cp_1
	stx	<L94+cp_1+2
	ldy	#$0
	lda	<L94+length_1
	bpl	L106
	dey
L106:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	ldy	#$0
	lda	<L94+length_1
	bpl	L107
	dey
L107:
	sta	<R1
	sty	<R1+2
	ldy	#$0
	lda	<L94+descriptor_1
	bpl	L108
	dey
L108:
	sta	<R2
	sty	<R2+2
	sec
	lda	<R2
	sbc	<R1
	sta	<R3
	lda	<R2+2
	sbc	<R1+2
	sta	<R3+2
	clc
	lda	<L94+descriptor_1+2
	adc	<R3
	sta	<R1
	lda	<L94+descriptor_1+4
	adc	<R3+2
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<L94+cp_1+2
	pei	<L94+cp_1
	jsl	~~memcpy
	pei	<L94+cp_1+2
	pei	<L94+cp_1
	pei	<L94+length_1
	jsl	~~push_strtemp
	lda	<L94+stringtype_1
	cmp	#<$5
	beq	L109
	brl	L10048
L109:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L94+descriptor_1
	sta	<R1
	lda	#$0
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
L10048:
L10047:
L10045:
	brl	L10049
L10041:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$29
	rep	#$20
	longa	on
	bne	L110
	brl	L10050
L110:
	pea	#<$29
	pea	#4
	jsl	~~error
L10050:
	inc	|~~basicvars+62
	bne	L111
	inc	|~~basicvars+62+2
L111:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L94+descriptor_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	lda	<L94+descriptor_1
	beq	L112
	brl	L10051
L112:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L94+descriptor_1
	sta	<R1
	lda	#$0
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~push_string
	brl	L10052
L10051:
	pea	#<$1
	jsl	~~alloc_string
	sta	<L94+cp_1
	stx	<L94+cp_1+2
	clc
	lda	#$ffff
	adc	<L94+descriptor_1
	sta	<R0
	sep	#$20
	longa	off
	ldy	<R0
	lda	[<L94+descriptor_1+2],Y
	sta	[<L94+cp_1]
	rep	#$20
	longa	on
	pei	<L94+cp_1+2
	pei	<L94+cp_1
	pea	#<$1
	jsl	~~push_strtemp
	lda	<L94+stringtype_1
	cmp	#<$5
	beq	L113
	brl	L10053
L113:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L94+descriptor_1
	sta	<R1
	lda	#$0
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
L10053:
L10052:
L10049:
L114:
	pld
	tsc
	clc
	adc	#L93
	tcs
	rtl
L93	equ	30
L94	equ	17
	ends
	efunc
	code
	func
~~fn_time:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L115
	tcs
	phd
	tcd
	jsl	~~emulate_time
	pha
	jsl	~~push_int
L117:
	pld
	tsc
	clc
	adc	#L115
	tcs
	rtl
L115	equ	0
L116	equ	1
	ends
	efunc
	code
	func
~~fn_timedol:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L118
	tcs
	phd
	tcd
length_1	set	0
thetime_1	set	4
cp_1	set	8
	pea	#^$0
	pea	#<$0
	jsl	~~time
	sta	<L119+thetime_1
	stx	<L119+thetime_1+2
	pea	#0
	clc
	tdc
	adc	#<L119+thetime_1
	pha
	jsl	~~localtime
	sta	<R0
	stx	<R0+2
	phx
	pha
	pea	#^L5
	pea	#<L5
	pea	#^$1000
	pea	#<$1000
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	jsl	~~strftime
	sta	<L119+length_1
	stx	<L119+length_1+2
	pei	<L119+length_1
	jsl	~~alloc_string
	sta	<L119+cp_1
	stx	<L119+cp_1+2
	pei	<L119+length_1+2
	pei	<L119+length_1
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	pei	<L119+cp_1+2
	pei	<L119+cp_1
	jsl	~~memcpy
	pei	<L119+cp_1+2
	pei	<L119+cp_1
	pei	<L119+length_1
	jsl	~~push_strtemp
L120:
	pld
	tsc
	clc
	adc	#L118
	tcs
	rtl
L118	equ	16
L119	equ	5
	ends
	efunc
	data
L5:
	db	$25,$61,$2C,$25,$64,$20,$25,$62,$20,$25,$59,$2E,$25,$48,$3A
	db	$25,$4D,$3A,$25,$53,$00
	ends
	code
	func
~~fn_abs:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L122
	tcs
	phd
	tcd
numtype_1	set	0
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	lda	[<R1]
	and	#$ff
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~factor_table
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	tax
	lda	(<R1)
	xref	~~~lcal
	jsl	~~~lcal
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L123+numtype_1
	lda	<L123+numtype_1
	cmp	#<$2
	beq	L124
	brl	L10054
L124:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	|~~basicvars+42
	sta	<R1
	lda	|~~basicvars+42+2
	sta	<R1+2
	ldy	#$2
	lda	[<R1],Y
	pha
	jsl	~~abs
	ldy	#$2
	sta	[<R0],Y
	brl	L10055
L10054:
	lda	<L123+numtype_1
	cmp	#<$3
	beq	L125
	brl	L10056
L125:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	phy
	phy
	phy
	phy
	lda	|~~basicvars+42
	sta	<R1
	lda	|~~basicvars+42+2
	sta	<R1+2
	ldy	#$4
	lda	[<R1],Y
	pha
	ldy	#$2
	lda	[<R1],Y
	pha
	xref	~~~ftod
	jsl	~~~ftod
	jsl	~~fabs
	xref	~~~dtof
	jsl	~~~dtof
	pla
	ldy	#$2
	sta	[<R0],Y
	pla
	ldy	#$4
	sta	[<R0],Y
	brl	L10057
L10056:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10057:
L10055:
L126:
	pld
	tsc
	clc
	adc	#L122
	tcs
	rtl
L122	equ	10
L123	equ	9
	ends
	efunc
	code
	func
~~fn_acs:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L127
	tcs
	phd
	tcd
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	lda	[<R1]
	and	#$ff
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~factor_table
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	tax
	lda	(<R1)
	xref	~~~lcal
	jsl	~~~lcal
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$2
	beq	L129
	brl	L10058
L129:
	phy
	phy
	phy
	phy
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L130
	dey
L130:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~ftod
	jsl	~~~ftod
	jsl	~~acos
	xref	~~~dtof
	jsl	~~~dtof
	jsl	~~push_float
	brl	L10059
L10058:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$3
	beq	L131
	brl	L10060
L131:
	phy
	phy
	phy
	phy
	phy
	phy
	jsl	~~pop_float
	xref	~~~ftod
	jsl	~~~ftod
	jsl	~~acos
	xref	~~~dtof
	jsl	~~~dtof
	jsl	~~push_float
	brl	L10061
L10060:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10061:
L10059:
L132:
	pld
	tsc
	clc
	adc	#L127
	tcs
	rtl
L127	equ	8
L128	equ	9
	ends
	efunc
	code
	func
~~fn_adval:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L133
	tcs
	phd
	tcd
	jsl	~~eval_intfactor
	pha
	jsl	~~emulate_adval
	pha
	jsl	~~push_int
L135:
	pld
	tsc
	clc
	adc	#L133
	tcs
	rtl
L133	equ	0
L134	equ	1
	ends
	efunc
	code
	func
~~fn_argc:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L136
	tcs
	phd
	tcd
	lda	|~~basicvars+492
	pha
	jsl	~~push_int
L138:
	pld
	tsc
	clc
	adc	#L136
	tcs
	rtl
L136	equ	0
L137	equ	1
	ends
	efunc
	code
	func
~~fn_argvdol:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L139
	tcs
	phd
	tcd
number_1	set	0
length_1	set	2
ap_1	set	4
cp_1	set	8
	jsl	~~eval_intfactor
	sta	<L140+number_1
	lda	<L140+number_1
	bpl	L142
	brl	L141
L142:
	sec
	lda	|~~basicvars+492
	sbc	<L140+number_1
	bvs	L143
	eor	#$8000
L143:
	bpl	L144
	brl	L10062
L144:
L141:
	pea	#<$3a
	pea	#4
	jsl	~~error
L10062:
	lda	|~~basicvars+1386
	sta	<L140+ap_1
	lda	|~~basicvars+1386+2
	sta	<L140+ap_1+2
L10063:
	sec
	lda	#$0
	sbc	<L140+number_1
	bvs	L145
	eor	#$8000
L145:
	bpl	L146
	brl	L10064
L146:
	dec	<L140+number_1
	ldy	#$4
	lda	[<L140+ap_1],Y
	sta	<R0
	ldy	#$6
	lda	[<L140+ap_1],Y
	sta	<R0+2
	lda	<R0
	sta	<L140+ap_1
	lda	<R0+2
	sta	<L140+ap_1+2
	brl	L10063
L10064:
	ldy	#$2
	lda	[<L140+ap_1],Y
	pha
	lda	[<L140+ap_1]
	pha
	jsl	~~strlen
	sta	<L140+length_1
	pei	<L140+length_1
	jsl	~~alloc_string
	sta	<L140+cp_1
	stx	<L140+cp_1+2
	sec
	lda	#$0
	sbc	<L140+length_1
	bvs	L147
	eor	#$8000
L147:
	bpl	L148
	brl	L10065
L148:
	ldy	#$0
	lda	<L140+length_1
	bpl	L149
	dey
L149:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	ldy	#$2
	lda	[<L140+ap_1],Y
	pha
	lda	[<L140+ap_1]
	pha
	pei	<L140+cp_1+2
	pei	<L140+cp_1
	jsl	~~memcpy
L10065:
	pei	<L140+cp_1+2
	pei	<L140+cp_1
	pei	<L140+length_1
	jsl	~~push_strtemp
L150:
	pld
	tsc
	clc
	adc	#L139
	tcs
	rtl
L139	equ	16
L140	equ	5
	ends
	efunc
	code
	func
~~fn_asc:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L151
	tcs
	phd
	tcd
descriptor_1	set	0
topitem_1	set	6
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	lda	[<R1]
	and	#$ff
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~factor_table
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	tax
	lda	(<R1)
	xref	~~~lcal
	jsl	~~~lcal
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L152+topitem_1
	lda	<L152+topitem_1
	cmp	#<$4
	bne	L154
	brl	L153
L154:
	lda	<L152+topitem_1
	cmp	#<$5
	beq	L155
	brl	L10066
L155:
L153:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L152+descriptor_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	lda	<L152+descriptor_1
	beq	L156
	brl	L10067
L156:
	pea	#<$ffffffff
	jsl	~~push_int
	brl	L10068
L10067:
	lda	[<L152+descriptor_1+2]
	and	#<$ff
	pha
	jsl	~~push_int
	lda	<L152+topitem_1
	cmp	#<$5
	beq	L157
	brl	L10069
L157:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L152+descriptor_1
	sta	<R1
	lda	#$0
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
L10069:
L10068:
	brl	L10070
L10066:
	pea	#<$40
	pea	#4
	jsl	~~error
L10070:
L158:
	pld
	tsc
	clc
	adc	#L151
	tcs
	rtl
L151	equ	16
L152	equ	9
	ends
	efunc
	code
	func
~~fn_asn:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L159
	tcs
	phd
	tcd
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	lda	[<R1]
	and	#$ff
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~factor_table
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	tax
	lda	(<R1)
	xref	~~~lcal
	jsl	~~~lcal
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$2
	beq	L161
	brl	L10071
L161:
	phy
	phy
	phy
	phy
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L162
	dey
L162:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~ftod
	jsl	~~~ftod
	jsl	~~asin
	xref	~~~dtof
	jsl	~~~dtof
	jsl	~~push_float
	brl	L10072
L10071:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$3
	beq	L163
	brl	L10073
L163:
	phy
	phy
	phy
	phy
	phy
	phy
	jsl	~~pop_float
	xref	~~~ftod
	jsl	~~~ftod
	jsl	~~asin
	xref	~~~dtof
	jsl	~~~dtof
	jsl	~~push_float
	brl	L10074
L10073:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10074:
L10072:
L164:
	pld
	tsc
	clc
	adc	#L159
	tcs
	rtl
L159	equ	8
L160	equ	9
	ends
	efunc
	code
	func
~~fn_atn:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L165
	tcs
	phd
	tcd
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	lda	[<R1]
	and	#$ff
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~factor_table
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	tax
	lda	(<R1)
	xref	~~~lcal
	jsl	~~~lcal
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$2
	beq	L167
	brl	L10075
L167:
	phy
	phy
	phy
	phy
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L168
	dey
L168:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~ftod
	jsl	~~~ftod
	jsl	~~atan
	xref	~~~dtof
	jsl	~~~dtof
	jsl	~~push_float
	brl	L10076
L10075:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$3
	beq	L169
	brl	L10077
L169:
	phy
	phy
	phy
	phy
	phy
	phy
	jsl	~~pop_float
	xref	~~~ftod
	jsl	~~~ftod
	jsl	~~atan
	xref	~~~dtof
	jsl	~~~dtof
	jsl	~~push_float
	brl	L10078
L10077:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10078:
L10076:
L170:
	pld
	tsc
	clc
	adc	#L165
	tcs
	rtl
L165	equ	8
L166	equ	9
	ends
	efunc
	code
	xdef	~~fn_beat
	func
~~fn_beat:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L171
	tcs
	phd
	tcd
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$8d
	rep	#$20
	longa	on
	beq	L173
	brl	L10079
L173:
	inc	|~~basicvars+62
	bne	L174
	inc	|~~basicvars+62+2
L174:
L10079:
	jsl	~~emulate_beatfn
	pha
	jsl	~~push_int
L175:
	pld
	tsc
	clc
	adc	#L171
	tcs
	rtl
L171	equ	4
L172	equ	5
	ends
	efunc
	code
	func
~~fn_bget:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L176
	tcs
	phd
	tcd
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$23
	rep	#$20
	longa	on
	bne	L178
	brl	L10080
L178:
	pea	#<$2c
	pea	#4
	jsl	~~error
L10080:
	inc	|~~basicvars+62
	bne	L179
	inc	|~~basicvars+62+2
L179:
	jsl	~~eval_intfactor
	pha
	jsl	~~fileio_bget
	pha
	jsl	~~push_int
L180:
	pld
	tsc
	clc
	adc	#L176
	tcs
	rtl
L176	equ	4
L177	equ	5
	ends
	efunc
	code
	func
~~fn_chr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L181
	tcs
	phd
	tcd
cp_1	set	0
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	lda	[<R1]
	and	#$ff
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~factor_table
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	tax
	lda	(<R1)
	xref	~~~lcal
	jsl	~~~lcal
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$2
	beq	L183
	brl	L10081
L183:
	pea	#<$1
	jsl	~~alloc_string
	sta	<L182+cp_1
	stx	<L182+cp_1+2
	jsl	~~pop_int
	sep	#$20
	longa	off
	sta	[<L182+cp_1]
	rep	#$20
	longa	on
	pei	<L182+cp_1+2
	pei	<L182+cp_1
	pea	#<$1
	jsl	~~push_strtemp
	brl	L10082
L10081:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$3
	beq	L184
	brl	L10083
L184:
	pea	#<$1
	jsl	~~alloc_string
	sta	<L182+cp_1
	stx	<L182+cp_1+2
	phy
	phy
	jsl	~~pop_float
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R0
	pla
	sta	<R0+2
	sep	#$20
	longa	off
	lda	<R0
	sta	[<L182+cp_1]
	rep	#$20
	longa	on
	pei	<L182+cp_1+2
	pei	<L182+cp_1
	pea	#<$1
	jsl	~~push_strtemp
	brl	L10084
L10083:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10084:
L10082:
L185:
	pld
	tsc
	clc
	adc	#L181
	tcs
	rtl
L181	equ	12
L182	equ	9
	ends
	efunc
	code
	xdef	~~fn_colour
	func
~~fn_colour:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L186
	tcs
	phd
	tcd
red_1	set	0
green_1	set	2
blue_1	set	4
	inc	|~~basicvars+62
	bne	L188
	inc	|~~basicvars+62+2
L188:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$28
	rep	#$20
	longa	on
	bne	L189
	brl	L10085
L189:
	pea	#<$5
	pea	#4
	jsl	~~error
L10085:
	inc	|~~basicvars+62
	bne	L190
	inc	|~~basicvars+62+2
L190:
	jsl	~~eval_integer
	sta	<L187+red_1
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$2c
	rep	#$20
	longa	on
	bne	L191
	brl	L10086
L191:
	pea	#<$5
	pea	#4
	jsl	~~error
L10086:
	inc	|~~basicvars+62
	bne	L192
	inc	|~~basicvars+62+2
L192:
	jsl	~~eval_integer
	sta	<L187+green_1
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$2c
	rep	#$20
	longa	on
	bne	L193
	brl	L10087
L193:
	pea	#<$5
	pea	#4
	jsl	~~error
L10087:
	inc	|~~basicvars+62
	bne	L194
	inc	|~~basicvars+62+2
L194:
	jsl	~~eval_integer
	sta	<L187+blue_1
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$29
	rep	#$20
	longa	on
	bne	L195
	brl	L10088
L195:
	pea	#<$29
	pea	#4
	jsl	~~error
L10088:
	inc	|~~basicvars+62
	bne	L196
	inc	|~~basicvars+62+2
L196:
	pei	<L187+blue_1
	pei	<L187+green_1
	pei	<L187+red_1
	jsl	~~emulate_colourfn
	pha
	jsl	~~push_int
L197:
	pld
	tsc
	clc
	adc	#L186
	tcs
	rtl
L186	equ	10
L187	equ	5
	ends
	efunc
	code
	func
~~fn_cos:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L198
	tcs
	phd
	tcd
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	lda	[<R1]
	and	#$ff
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~factor_table
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	tax
	lda	(<R1)
	xref	~~~lcal
	jsl	~~~lcal
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$2
	beq	L200
	brl	L10089
L200:
	phy
	phy
	phy
	phy
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L201
	dey
L201:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~ftod
	jsl	~~~ftod
	jsl	~~cos
	xref	~~~dtof
	jsl	~~~dtof
	jsl	~~push_float
	brl	L10090
L10089:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$3
	beq	L202
	brl	L10091
L202:
	phy
	phy
	phy
	phy
	phy
	phy
	jsl	~~pop_float
	xref	~~~ftod
	jsl	~~~ftod
	jsl	~~cos
	xref	~~~dtof
	jsl	~~~dtof
	jsl	~~push_float
	brl	L10092
L10091:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10092:
L10090:
L203:
	pld
	tsc
	clc
	adc	#L198
	tcs
	rtl
L198	equ	8
L199	equ	9
	ends
	efunc
	code
	func
~~fn_count:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L204
	tcs
	phd
	tcd
	lda	|~~basicvars+494
	pha
	jsl	~~push_int
L206:
	pld
	tsc
	clc
	adc	#L204
	tcs
	rtl
L204	equ	0
L205	equ	1
	ends
	efunc
	code
	func
~~get_arrayname:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L207
	tcs
	phd
	tcd
vp_1	set	0
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$6
	rep	#$20
	longa	on
	beq	L209
	brl	L10093
L209:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	ldy	#$1
	lda	[<R0],Y
	and	#$ff
	sta	<R0
	lda	|~~basicvars+62
	sta	<R2
	lda	|~~basicvars+62+2
	sta	<R2+2
	ldy	#$2
	lda	[<R2],Y
	and	#$ff
	sta	<R2
	lda	<R2
	xba
	and	#$ff00
	sta	<R1
	lda	<R1
	ora	<R0
	sta	<R2
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	ldy	#$3
	lda	[<R1],Y
	and	#$ff
	ldx	#<$10
	xref	~~~asl
	jsl	~~~asl
	sta	<R0
	lda	<R0
	ora	<R2
	sta	<R1
	lda	|~~basicvars+62
	sta	<R2
	lda	|~~basicvars+62+2
	sta	<R2+2
	ldy	#$4
	lda	[<R2],Y
	and	#$ff
	ldx	#<$18
	xref	~~~asl
	jsl	~~~asl
	sta	<R0
	lda	<R0
	ora	<R1
	sta	<R2
	ldy	#$0
	lda	<R2
	bpl	L210
	dey
L210:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars
	adc	<R0
	sta	<L208+vp_1
	lda	|~~basicvars+2
	adc	<R0+2
	sta	<L208+vp_1+2
	brl	L10094
L10093:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$1
	rep	#$20
	longa	on
	beq	L211
	brl	L10095
L211:
base_2	set	4
ep_2	set	8
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~get_srcaddr
	sta	<L208+base_2
	stx	<L208+base_2+2
	pei	<L208+base_2+2
	pei	<L208+base_2
	jsl	~~skip_name
	sta	<L208+ep_2
	stx	<L208+ep_2+2
	sec
	lda	<L208+ep_2
	sbc	<L208+base_2
	sta	<R0
	lda	<L208+ep_2+2
	sbc	<L208+base_2+2
	sta	<R0+2
	pei	<R0
	pei	<L208+base_2+2
	pei	<L208+base_2
	jsl	~~find_variable
	sta	<L208+vp_1
	stx	<L208+vp_1+2
	lda	<L208+vp_1
	ora	<L208+vp_1+2
	beq	L212
	brl	L10096
L212:
	sec
	lda	<L208+ep_2
	sbc	<L208+base_2
	sta	<R0
	lda	<L208+ep_2+2
	sbc	<L208+base_2+2
	sta	<R0+2
	pei	<R0
	pei	<L208+base_2+2
	pei	<L208+base_2
	jsl	~~tocstring
	sta	<R1
	stx	<R1+2
	phx
	pha
	pea	#<$e
	pea	#8
	jsl	~~error
L10096:
	ldy	#$4
	lda	[<L208+vp_1],Y
	and	#<$8
	beq	L213
	brl	L10097
L213:
	pea	#<$46
	pea	#4
	jsl	~~error
L10097:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	#$5
	lda	[<R0],Y
	cmp	#<$29
	rep	#$20
	longa	on
	bne	L214
	brl	L10098
L214:
	pea	#<$29
	pea	#4
	jsl	~~error
L10098:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$6
	sta	[<R0]
	rep	#$20
	longa	on
	pei	<L208+vp_1+2
	pei	<L208+vp_1
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~set_address
	brl	L10099
L10095:
	pea	#<$46
	pea	#4
	jsl	~~error
L10099:
L10094:
	ldy	#$10
	lda	[<L208+vp_1],Y
	ldy	#$12
	ora	[<L208+vp_1],Y
	beq	L215
	brl	L10100
L215:
	ldy	#$8
	lda	[<L208+vp_1],Y
	pha
	ldy	#$6
	lda	[<L208+vp_1],Y
	pha
	pea	#<$1f
	pea	#8
	jsl	~~error
L10100:
	clc
	lda	#$6
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L216
	inc	|~~basicvars+62+2
L216:
	ldx	<L208+vp_1+2
	lda	<L208+vp_1
L217:
	tay
	pld
	tsc
	clc
	adc	#L207
	tcs
	tya
	rtl
L207	equ	24
L208	equ	13
	ends
	efunc
	code
	xdef	~~fn_dim
	func
~~fn_dim:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L218
	tcs
	phd
	tcd
vp_1	set	0
dimension_1	set	4
	inc	|~~basicvars+62
	bne	L220
	inc	|~~basicvars+62+2
L220:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$28
	rep	#$20
	longa	on
	bne	L221
	brl	L10101
L221:
	pea	#<$5
	pea	#4
	jsl	~~error
L10101:
	inc	|~~basicvars+62
	bne	L222
	inc	|~~basicvars+62+2
L222:
	jsl	~~get_arrayname
	sta	<L219+vp_1
	stx	<L219+vp_1+2
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	brl	L10102
L10104:
	inc	|~~basicvars+62
	bne	L223
	inc	|~~basicvars+62+2
L223:
	jsl	~~eval_integer
	sta	<L219+dimension_1
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$29
	rep	#$20
	longa	on
	bne	L224
	brl	L10105
L224:
	pea	#<$29
	pea	#4
	jsl	~~error
L10105:
	inc	|~~basicvars+62
	bne	L225
	inc	|~~basicvars+62+2
L225:
	lda	<L219+dimension_1
	bmi	L227
	dea
	bpl	L228
L227:
	brl	L226
L228:
	ldy	#$10
	lda	[<L219+vp_1],Y
	sta	<R0
	ldy	#$12
	lda	[<L219+vp_1],Y
	sta	<R0+2
	sec
	lda	[<R0]
	sbc	<L219+dimension_1
	bvs	L229
	eor	#$8000
L229:
	bpl	L230
	brl	L10106
L230:
L226:
	pea	#<$1e
	pea	#4
	jsl	~~error
L10106:
	clc
	lda	#$ffff
	adc	<L219+dimension_1
	sta	<R1
	ldy	#$0
	lda	<R1
	bpl	L231
	dey
L231:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	lda	#$8
	ldy	#$10
	adc	[<L219+vp_1],Y
	sta	<R2
	lda	#$0
	ldy	#$12
	adc	[<L219+vp_1],Y
	sta	<R2+2
	clc
	lda	<R2
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	clc
	lda	#$ffff
	adc	[<R3]
	pha
	jsl	~~push_int
	brl	L10103
L10107:
	ldy	#$10
	lda	[<L219+vp_1],Y
	sta	<R0
	ldy	#$12
	lda	[<L219+vp_1],Y
	sta	<R0+2
	lda	[<R0]
	pha
	jsl	~~push_int
	inc	|~~basicvars+62
	bne	L232
	inc	|~~basicvars+62+2
L232:
	brl	L10103
L10108:
	pea	#<$5
	pea	#4
	jsl	~~error
	brl	L10103
L10102:
	xref	~~~swt
	jsl	~~~swt
	dw	2
	dw	41
	dw	L10107-1
	dw	44
	dw	L10104-1
	dw	L10108-1
L10103:
L233:
	pld
	tsc
	clc
	adc	#L218
	tcs
	rtl
L218	equ	22
L219	equ	17
	ends
	efunc
	code
	func
~~fn_deg:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L234
	tcs
	phd
	tcd
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	lda	[<R1]
	and	#$ff
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~factor_table
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	tax
	lda	(<R1)
	xref	~~~lcal
	jsl	~~~lcal
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$2
	beq	L236
	brl	L10109
L236:
	pea	#$404C
	pea	#$A5DC
	pea	#$1A63
	pea	#$C1F8
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L237
	dey
L237:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~ftod
	jsl	~~~ftod
	xref	~~~dmul
	jsl	~~~dmul
	xref	~~~dtof
	jsl	~~~dtof
	jsl	~~push_float
	brl	L10110
L10109:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$3
	beq	L238
	brl	L10111
L238:
	pea	#$404C
	pea	#$A5DC
	pea	#$1A63
	pea	#$C1F8
	phy
	phy
	jsl	~~pop_float
	xref	~~~ftod
	jsl	~~~ftod
	xref	~~~dmul
	jsl	~~~dmul
	xref	~~~dtof
	jsl	~~~dtof
	jsl	~~push_float
	brl	L10112
L10111:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10112:
L10110:
L239:
	pld
	tsc
	clc
	adc	#L234
	tcs
	rtl
L234	equ	8
L235	equ	9
	ends
	efunc
	code
	xdef	~~fn_end
	func
~~fn_end:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L240
	tcs
	phd
	tcd
	inc	|~~basicvars+62
	bne	L242
	inc	|~~basicvars+62+2
L242:
	sec
	lda	|~~basicvars+34
	sbc	|~~basicvars+6
	sta	<R0
	lda	|~~basicvars+34+2
	sbc	|~~basicvars+6+2
	sta	<R0+2
	pei	<R0
	jsl	~~push_int
L243:
	pld
	tsc
	clc
	adc	#L240
	tcs
	rtl
L240	equ	4
L241	equ	5
	ends
	efunc
	code
	func
~~fn_eof:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L244
	tcs
	phd
	tcd
handle_1	set	0
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$23
	rep	#$20
	longa	on
	bne	L246
	brl	L10113
L246:
	pea	#<$2c
	pea	#4
	jsl	~~error
L10113:
	inc	|~~basicvars+62
	bne	L247
	inc	|~~basicvars+62+2
L247:
	jsl	~~eval_intfactor
	sta	<L245+handle_1
	pei	<L245+handle_1
	jsl	~~fileio_eof
	tax
	bne	L249
	brl	L248
L249:
	lda	#$ffff
	bra	L250
L248:
	lda	#$0
L250:
	pha
	jsl	~~push_int
L251:
	pld
	tsc
	clc
	adc	#L244
	tcs
	rtl
L244	equ	6
L245	equ	5
	ends
	efunc
	code
	func
~~fn_erl:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L252
	tcs
	phd
	tcd
	lda	|~~basicvars+228
	pha
	jsl	~~push_int
L254:
	pld
	tsc
	clc
	adc	#L252
	tcs
	rtl
L252	equ	0
L253	equ	1
	ends
	efunc
	code
	func
~~fn_err:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L255
	tcs
	phd
	tcd
	lda	|~~basicvars+230
	pha
	jsl	~~push_int
L257:
	pld
	tsc
	clc
	adc	#L255
	tcs
	rtl
L255	equ	0
L256	equ	1
	ends
	efunc
	code
	func
~~fn_eval:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L258
	tcs
	phd
	tcd
stringtype_1	set	0
descriptor_1	set	2
evalexpr_1	set	8
	pea	#^$400
	pea	#<$400
	jsl	~~malloc
	sta	<L259+evalexpr_1
	stx	<L259+evalexpr_1+2
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	lda	[<R1]
	and	#$ff
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~factor_table
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	tax
	lda	(<R1)
	xref	~~~lcal
	jsl	~~~lcal
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L259+stringtype_1
	lda	<L259+stringtype_1
	cmp	#<$4
	bne	L260
	brl	L10114
L260:
	lda	<L259+stringtype_1
	cmp	#<$5
	bne	L261
	brl	L10114
L261:
	pea	#<$40
	pea	#4
	jsl	~~error
L10114:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L259+descriptor_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	ldy	#$0
	lda	<L259+descriptor_1
	bpl	L262
	dey
L262:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L259+descriptor_1+4
	pei	<L259+descriptor_1+2
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	jsl	~~memmove
	lda	|~~basicvars+70
	sta	<R0
	lda	|~~basicvars+70+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$0
	ldy	<L259+descriptor_1
	sta	[<R0],Y
	rep	#$20
	longa	on
	lda	<L259+stringtype_1
	cmp	#<$5
	beq	L263
	brl	L10115
L263:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L259+descriptor_1
	sta	<R1
	lda	#$0
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
L10115:
	pea	#<$0
	pei	<L259+evalexpr_1+2
	pei	<L259+evalexpr_1
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	jsl	~~tokenize
	jsl	~~save_current
	ldy	#$5
	lda	[<L259+evalexpr_1],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L264
	dey
L264:
	sta	<R0
	sty	<R0+2
	ldy	#$4
	lda	[<L259+evalexpr_1],Y
	and	#$ff
	sta	<R1
	stz	<R1+2
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	lda	<R1+2
	adc	<R0+2
	sta	<R2+2
	clc
	lda	<L259+evalexpr_1
	adc	<R2
	sta	|~~basicvars+62
	lda	<L259+evalexpr_1+2
	adc	<R2+2
	sta	|~~basicvars+62+2
	jsl	~~expression
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	bne	L265
	brl	L10116
L265:
	pea	#<$5
	pea	#4
	jsl	~~error
L10116:
	jsl	~~restore_current
	pei	<L259+evalexpr_1+2
	pei	<L259+evalexpr_1
	jsl	~~free
L266:
	pld
	tsc
	clc
	adc	#L258
	tcs
	rtl
L258	equ	24
L259	equ	13
	ends
	efunc
	code
	func
~~fn_exp:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L267
	tcs
	phd
	tcd
topitem_1	set	0
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	lda	[<R1]
	and	#$ff
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~factor_table
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	tax
	lda	(<R1)
	xref	~~~lcal
	jsl	~~~lcal
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L268+topitem_1
	lda	<L268+topitem_1
	cmp	#<$2
	beq	L269
	brl	L10117
L269:
	phy
	phy
	phy
	phy
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L270
	dey
L270:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~ftod
	jsl	~~~ftod
	jsl	~~exp
	xref	~~~dtof
	jsl	~~~dtof
	jsl	~~push_float
	brl	L10118
L10117:
	lda	<L268+topitem_1
	cmp	#<$3
	beq	L271
	brl	L10119
L271:
	phy
	phy
	phy
	phy
	phy
	phy
	jsl	~~pop_float
	xref	~~~ftod
	jsl	~~~ftod
	jsl	~~exp
	xref	~~~dtof
	jsl	~~~dtof
	jsl	~~push_float
	brl	L10120
L10119:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10120:
L10118:
L272:
	pld
	tsc
	clc
	adc	#L267
	tcs
	rtl
L267	equ	10
L268	equ	9
	ends
	efunc
	code
	xdef	~~fn_false
	func
~~fn_false:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L273
	tcs
	phd
	tcd
	inc	|~~basicvars+62
	bne	L275
	inc	|~~basicvars+62+2
L275:
	clc
	lda	#$fffc
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	lda	#$ffff
	adc	|~~basicvars+42+2
	sta	|~~basicvars+42+2
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	#$2
	sta	[<R0]
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	#$0
	ldy	#$2
	sta	[<R0],Y
L276:
	pld
	tsc
	clc
	adc	#L273
	tcs
	rtl
L273	equ	4
L274	equ	5
	ends
	efunc
	code
	func
~~fn_get:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L277
	tcs
	phd
	tcd
	jsl	~~emulate_get
	pha
	jsl	~~push_int
L279:
	pld
	tsc
	clc
	adc	#L277
	tcs
	rtl
L277	equ	0
L278	equ	1
	ends
	efunc
	code
	func
~~fn_getdol:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L280
	tcs
	phd
	tcd
cp_1	set	0
handle_1	set	4
count_1	set	6
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$23
	rep	#$20
	longa	on
	beq	L282
	brl	L10121
L282:
	inc	|~~basicvars+62
	bne	L283
	inc	|~~basicvars+62+2
L283:
	jsl	~~eval_intfactor
	sta	<L281+handle_1
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	pei	<L281+handle_1
	jsl	~~fileio_getdol
	sta	<L281+count_1
	pei	<L281+count_1
	jsl	~~alloc_string
	sta	<L281+cp_1
	stx	<L281+cp_1+2
	ldy	#$0
	lda	<L281+count_1
	bpl	L284
	dey
L284:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	pei	<L281+cp_1+2
	pei	<L281+cp_1
	jsl	~~memcpy
	pei	<L281+cp_1+2
	pei	<L281+cp_1
	pei	<L281+count_1
	jsl	~~push_strtemp
	brl	L10122
L10121:
	pea	#<$1
	jsl	~~alloc_string
	sta	<L281+cp_1
	stx	<L281+cp_1+2
	jsl	~~emulate_get
	sep	#$20
	longa	off
	sta	[<L281+cp_1]
	rep	#$20
	longa	on
	pei	<L281+cp_1+2
	pei	<L281+cp_1
	pea	#<$1
	jsl	~~push_strtemp
L10122:
L285:
	pld
	tsc
	clc
	adc	#L280
	tcs
	rtl
L280	equ	12
L281	equ	5
	ends
	efunc
	code
	func
~~fn_inkey:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L286
	tcs
	phd
	tcd
	jsl	~~eval_intfactor
	pha
	jsl	~~emulate_inkey
	pha
	jsl	~~push_int
L288:
	pld
	tsc
	clc
	adc	#L286
	tcs
	rtl
L286	equ	0
L287	equ	1
	ends
	efunc
	code
	func
~~fn_inkeydol:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L289
	tcs
	phd
	tcd
result_1	set	0
cp_1	set	2
	jsl	~~eval_intfactor
	pha
	jsl	~~emulate_inkey
	sta	<L290+result_1
	lda	<L290+result_1
	cmp	#<$ffffffff
	beq	L291
	brl	L10123
L291:
	pea	#<$0
	jsl	~~alloc_string
	sta	<L290+cp_1
	stx	<L290+cp_1+2
	pei	<L290+cp_1+2
	pei	<L290+cp_1
	pea	#<$0
	jsl	~~push_strtemp
	brl	L10124
L10123:
	pea	#<$1
	jsl	~~alloc_string
	sta	<L290+cp_1
	stx	<L290+cp_1+2
	sep	#$20
	longa	off
	lda	<L290+result_1
	sta	[<L290+cp_1]
	rep	#$20
	longa	on
	pei	<L290+cp_1+2
	pei	<L290+cp_1
	pea	#<$1
	jsl	~~push_strtemp
L10124:
L292:
	pld
	tsc
	clc
	adc	#L289
	tcs
	rtl
L289	equ	6
L290	equ	1
	ends
	efunc
	code
	func
~~fn_instr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L293
	tcs
	phd
	tcd
needle_1	set	0
haystack_1	set	6
needtype_1	set	12
haytype_1	set	14
hp_1	set	16
p_1	set	20
start_1	set	24
count_1	set	26
first_1	set	28
	jsl	~~expression
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$2c
	rep	#$20
	longa	on
	bne	L295
	brl	L10125
L295:
	pea	#<$27
	pea	#4
	jsl	~~error
L10125:
	inc	|~~basicvars+62
	bne	L296
	inc	|~~basicvars+62+2
L296:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L294+haytype_1
	lda	<L294+haytype_1
	cmp	#<$4
	bne	L297
	brl	L10126
L297:
	lda	<L294+haytype_1
	cmp	#<$5
	bne	L298
	brl	L10126
L298:
	pea	#<$40
	pea	#4
	jsl	~~error
L10126:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L294+haystack_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~expression
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L294+needtype_1
	lda	<L294+needtype_1
	cmp	#<$4
	bne	L299
	brl	L10127
L299:
	lda	<L294+needtype_1
	cmp	#<$5
	bne	L300
	brl	L10127
L300:
	pea	#<$40
	pea	#4
	jsl	~~error
L10127:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L294+needle_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$2c
	rep	#$20
	longa	on
	beq	L301
	brl	L10128
L301:
	inc	|~~basicvars+62
	bne	L302
	inc	|~~basicvars+62+2
L302:
	jsl	~~eval_integer
	sta	<L294+start_1
	lda	<L294+start_1
	bmi	L303
	dea
	bmi	L303
	brl	L10129
L303:
	lda	#$1
	sta	<L294+start_1
L10129:
	brl	L10130
L10128:
	lda	#$1
	sta	<L294+start_1
L10130:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$29
	rep	#$20
	longa	on
	bne	L304
	brl	L10131
L304:
	pea	#<$29
	pea	#4
	jsl	~~error
L10131:
	inc	|~~basicvars+62
	bne	L305
	inc	|~~basicvars+62+2
L305:
	sec
	lda	<L294+haystack_1
	sbc	<L294+start_1
	sta	<R0
	lda	<R0
	ina
	sta	<R1
	sec
	lda	<R1
	sbc	<L294+needle_1
	bvs	L306
	eor	#$8000
L306:
	bpl	L307
	brl	L10132
L307:
	pea	#<$0
	jsl	~~push_int
	brl	L10133
L10132:
	lda	<L294+needle_1
	beq	L308
	brl	L10134
L308:
	lda	<L294+haystack_1
	beq	L309
	brl	L10135
L309:
	pea	#<$1
	jsl	~~push_int
	brl	L10136
L10135:
	lda	<L294+start_1
	bmi	L310
	dea
	dea
	dea
	bmi	L310
	brl	L10137
L310:
	pei	<L294+start_1
	jsl	~~push_int
	brl	L10138
L10137:
	pea	#<$0
	jsl	~~push_int
L10138:
L10136:
	brl	L10139
L10134:
	ldy	#$0
	lda	<L294+start_1
	bpl	L311
	dey
L311:
	sta	<R0
	sty	<R0+2
	clc
	lda	#$ffff
	adc	<R0
	sta	<R1
	lda	#$ffff
	adc	<R0+2
	sta	<R1+2
	clc
	lda	<L294+haystack_1+2
	adc	<R1
	sta	<L294+hp_1
	lda	<L294+haystack_1+4
	adc	<R1+2
	sta	<L294+hp_1+2
	sep	#$20
	longa	off
	lda	[<L294+needle_1+2]
	sta	<L294+first_1
	rep	#$20
	longa	on
	ldy	#$0
	lda	<L294+haystack_1
	bpl	L312
	dey
L312:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L294+haystack_1+2
	adc	<R0
	sta	<R1
	lda	<L294+haystack_1+4
	adc	<R0+2
	sta	<R1+2
	sec
	lda	<R1
	sbc	<L294+hp_1
	sta	<R0
	lda	<R1+2
	sbc	<L294+hp_1+2
	sta	<R0+2
	lda	<R0
	sta	<L294+count_1
	lda	<L294+needle_1
	cmp	#<$1
	beq	L313
	brl	L10140
L313:
	ldy	#$0
	lda	<L294+count_1
	bpl	L314
	dey
L314:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	lda	<L294+first_1
	and	#$ff
	pha
	pei	<L294+hp_1+2
	pei	<L294+hp_1
	jsl	~~memchr
	sta	<L294+p_1
	stx	<L294+p_1+2
	lda	<L294+p_1
	ora	<L294+p_1+2
	beq	L315
	brl	L10141
L315:
	pea	#<$0
	jsl	~~push_int
	brl	L10142
L10141:
	sec
	lda	<L294+p_1
	sbc	<L294+haystack_1+2
	sta	<R0
	lda	<L294+p_1+2
	sbc	<L294+haystack_1+4
	sta	<R0+2
	clc
	lda	#$1
	adc	<R0
	sta	<R1
	lda	#$0
	adc	<R0+2
	sta	<R1+2
	pei	<R1
	jsl	~~push_int
L10142:
	brl	L10143
L10140:
L10146:
	ldy	#$0
	lda	<L294+count_1
	bpl	L316
	dey
L316:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	lda	<L294+first_1
	and	#$ff
	pha
	pei	<L294+hp_1+2
	pei	<L294+hp_1
	jsl	~~memchr
	sta	<L294+p_1
	stx	<L294+p_1+2
	lda	<L294+p_1
	ora	<L294+p_1+2
	beq	L317
	brl	L10147
L317:
	stz	<L294+count_1
	brl	L10148
L10147:
	sec
	lda	<L294+p_1
	sbc	<L294+hp_1
	sta	<R0
	lda	<L294+p_1+2
	sbc	<L294+hp_1+2
	sta	<R0+2
	ldy	#$0
	lda	<L294+count_1
	bpl	L318
	dey
L318:
	sta	<R1
	sty	<R1+2
	sec
	lda	<R1
	sbc	<R0
	sta	<R2
	lda	<R1+2
	sbc	<R0+2
	sta	<R2+2
	lda	<R2
	sta	<L294+count_1
	sec
	lda	<L294+count_1
	sbc	<L294+needle_1
	bvs	L319
	eor	#$8000
L319:
	bpl	L320
	brl	L10149
L320:
	stz	<L294+count_1
	brl	L10150
L10149:
	ldy	#$0
	lda	<L294+needle_1
	bpl	L321
	dey
L321:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L294+needle_1+4
	pei	<L294+needle_1+2
	pei	<L294+p_1+2
	pei	<L294+p_1
	jsl	~~memcmp
	tax
	bne	L322
	brl	L10145
L322:
	clc
	lda	#$1
	adc	<L294+p_1
	sta	<L294+hp_1
	lda	#$0
	adc	<L294+p_1+2
	sta	<L294+hp_1+2
	dec	<L294+count_1
L10150:
L10148:
L10144:
	sec
	lda	#$0
	sbc	<L294+count_1
	bvs	L323
	eor	#$8000
L323:
	bmi	L324
	brl	L10146
L324:
L10145:
	lda	<L294+count_1
	beq	L325
	brl	L10151
L325:
	pea	#<$0
	jsl	~~push_int
	brl	L10152
L10151:
	sec
	lda	<L294+p_1
	sbc	<L294+haystack_1+2
	sta	<R0
	lda	<L294+p_1+2
	sbc	<L294+haystack_1+4
	sta	<R0+2
	clc
	lda	#$1
	adc	<R0
	sta	<R1
	lda	#$0
	adc	<R0+2
	sta	<R1+2
	pei	<R1
	jsl	~~push_int
L10152:
L10143:
L10139:
L10133:
	lda	<L294+haytype_1
	cmp	#<$5
	beq	L326
	brl	L10153
L326:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L294+haystack_1
	sta	<R1
	lda	#$0
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
L10153:
	lda	<L294+needtype_1
	cmp	#<$5
	beq	L327
	brl	L10154
L327:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L294+needle_1
	sta	<R1
	lda	#$0
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
L10154:
L328:
	pld
	tsc
	clc
	adc	#L293
	tcs
	rtl
L293	equ	41
L294	equ	13
	ends
	efunc
	code
	func
~~fn_int:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L329
	tcs
	phd
	tcd
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	lda	[<R1]
	and	#$ff
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~factor_table
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	tax
	lda	(<R1)
	xref	~~~lcal
	jsl	~~~lcal
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$3
	beq	L331
	brl	L10155
L331:
	phy
	phy
	phy
	phy
	phy
	phy
	jsl	~~pop_float
	xref	~~~ftod
	jsl	~~~ftod
	jsl	~~floor
	xref	~~~dfix
	jsl	~~~dfix
	pla
	sta	<R0
	pla
	sta	<R0+2
	pei	<R0
	jsl	~~push_int
	brl	L10156
L10155:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$2
	bne	L332
	brl	L10157
L332:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10157:
L10156:
L333:
	pld
	tsc
	clc
	adc	#L329
	tcs
	rtl
L329	equ	8
L330	equ	9
	ends
	efunc
	code
	func
~~fn_len:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L334
	tcs
	phd
	tcd
descriptor_1	set	0
stringtype_1	set	6
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	lda	[<R1]
	and	#$ff
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~factor_table
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	tax
	lda	(<R1)
	xref	~~~lcal
	jsl	~~~lcal
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L335+stringtype_1
	lda	<L335+stringtype_1
	cmp	#<$4
	bne	L337
	brl	L336
L337:
	lda	<L335+stringtype_1
	cmp	#<$5
	beq	L338
	brl	L10158
L338:
L336:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L335+descriptor_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	clc
	lda	#$fffc
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	lda	#$ffff
	adc	|~~basicvars+42+2
	sta	|~~basicvars+42+2
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	#$2
	sta	[<R0]
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	<L335+descriptor_1
	ldy	#$2
	sta	[<R0],Y
	lda	<L335+stringtype_1
	cmp	#<$5
	beq	L339
	brl	L10159
L339:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L335+descriptor_1
	sta	<R1
	lda	#$0
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
L10159:
	brl	L10160
L10158:
	pea	#<$40
	pea	#4
	jsl	~~error
L10160:
L340:
	pld
	tsc
	clc
	adc	#L334
	tcs
	rtl
L334	equ	16
L335	equ	9
	ends
	efunc
	code
	func
~~fn_listofn:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L341
	tcs
	phd
	tcd
	lda	|~~basicvars+429
	sta	<R0
	lda	<R0
	and	#<$1
	sta	<R0
	lda	|~~basicvars+429
	sta	<R2
	lsr	<R2
	lda	<R2
	and	#<$1
	sta	<R2
	lda	<R2
	asl	A
	sta	<R1
	lda	<R1
	ora	<R0
	sta	<R2
	lda	|~~basicvars+429
	sta	<R1
	lsr	<R1
	lsr	<R1
	lda	<R1
	and	#<$1
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	sta	<R0
	lda	<R0
	ora	<R2
	sta	<R1
	lda	|~~basicvars+429
	sta	<R2
	lsr	<R2
	lsr	<R2
	lsr	<R2
	lda	<R2
	and	#<$1
	sta	<R2
	lda	<R2
	asl	A
	asl	A
	asl	A
	sta	<R0
	lda	<R0
	ora	<R1
	sta	<R2
	lda	|~~basicvars+429
	sta	<R1
	lsr	<R1
	lsr	<R1
	lsr	<R1
	lsr	<R1
	lda	<R1
	and	#<$1
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	asl	A
	asl	A
	sta	<R0
	lda	<R0
	ora	<R2
	sta	<R1
	lda	|~~basicvars+429
	sta	<R2
	lsr	<R2
	lsr	<R2
	lsr	<R2
	lsr	<R2
	lsr	<R2
	lda	<R2
	and	#<$1
	sta	<R2
	lda	<R2
	asl	A
	asl	A
	asl	A
	asl	A
	asl	A
	sta	<R0
	lda	<R0
	ora	<R1
	pha
	jsl	~~push_int
L343:
	pld
	tsc
	clc
	adc	#L341
	tcs
	rtl
L341	equ	12
L342	equ	13
	ends
	efunc
	code
	func
~~fn_ln:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L344
	tcs
	phd
	tcd
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	lda	[<R1]
	and	#$ff
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~factor_table
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	tax
	lda	(<R1)
	xref	~~~lcal
	jsl	~~~lcal
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	brl	L10161
L10163:
value_2	set	0
	jsl	~~pop_int
	sta	<L345+value_2
	sec
	lda	#$0
	sbc	<L345+value_2
	bvs	L346
	eor	#$8000
L346:
	bmi	L347
	brl	L10164
L347:
	pea	#<$39
	pea	#4
	jsl	~~error
L10164:
	phy
	phy
	phy
	phy
	ldy	#$0
	lda	<L345+value_2
	bpl	L348
	dey
L348:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~ftod
	jsl	~~~ftod
	jsl	~~log
	xref	~~~dtof
	jsl	~~~dtof
	jsl	~~push_float
	brl	L10162
L10165:
	phy
	phy
	jsl	~~pop_float
	pla
	sta	|~~floatvalue
	pla
	sta	|~~floatvalue+2
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	xref	~~~ftod
	jsl	~~~ftod
	pea	#$0000
	pea	#$0000
	pea	#$0000
	pea	#$0000
	xref	~~~dcmp
	jsl	~~~dcmp
	bpl	L349
	brl	L10166
L349:
	pea	#<$39
	pea	#4
	jsl	~~error
L10166:
	phy
	phy
	phy
	phy
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	xref	~~~ftod
	jsl	~~~ftod
	jsl	~~log
	xref	~~~dtof
	jsl	~~~dtof
	jsl	~~push_float
	brl	L10162
L10167:
	pea	#<$3f
	pea	#4
	jsl	~~error
	brl	L10162
L10161:
	xref	~~~swt
	jsl	~~~swt
	dw	2
	dw	2
	dw	L10163-1
	dw	3
	dw	L10165-1
	dw	L10167-1
L10162:
L350:
	pld
	tsc
	clc
	adc	#L344
	tcs
	rtl
L344	equ	10
L345	equ	9
	ends
	efunc
	code
	func
~~fn_log:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L351
	tcs
	phd
	tcd
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	lda	[<R1]
	and	#$ff
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~factor_table
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	tax
	lda	(<R1)
	xref	~~~lcal
	jsl	~~~lcal
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	brl	L10168
L10170:
value_2	set	0
	jsl	~~pop_int
	sta	<L352+value_2
	sec
	lda	#$0
	sbc	<L352+value_2
	bvs	L353
	eor	#$8000
L353:
	bmi	L354
	brl	L10171
L354:
	pea	#<$39
	pea	#4
	jsl	~~error
L10171:
	phy
	phy
	phy
	phy
	ldy	#$0
	lda	<L352+value_2
	bpl	L355
	dey
L355:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~ftod
	jsl	~~~ftod
	jsl	~~log10
	xref	~~~dtof
	jsl	~~~dtof
	jsl	~~push_float
	brl	L10169
L10172:
	phy
	phy
	jsl	~~pop_float
	pla
	sta	|~~floatvalue
	pla
	sta	|~~floatvalue+2
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	xref	~~~ftod
	jsl	~~~ftod
	pea	#$0000
	pea	#$0000
	pea	#$0000
	pea	#$0000
	xref	~~~dcmp
	jsl	~~~dcmp
	bpl	L356
	brl	L10173
L356:
	pea	#<$39
	pea	#4
	jsl	~~error
L10173:
	phy
	phy
	phy
	phy
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	xref	~~~ftod
	jsl	~~~ftod
	jsl	~~log10
	xref	~~~dtof
	jsl	~~~dtof
	jsl	~~push_float
	brl	L10169
L10174:
	pea	#<$3f
	pea	#4
	jsl	~~error
	brl	L10169
L10168:
	xref	~~~swt
	jsl	~~~swt
	dw	2
	dw	2
	dw	L10170-1
	dw	3
	dw	L10172-1
	dw	L10174-1
L10169:
L357:
	pld
	tsc
	clc
	adc	#L351
	tcs
	rtl
L351	equ	10
L352	equ	9
	ends
	efunc
	code
	xdef	~~fn_mod
	func
~~fn_mod:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L358
	tcs
	phd
	tcd
	udata
L10175:
	ds	4
	ends
n_1	set	0
elements_1	set	2
vp_1	set	4
	inc	|~~basicvars+62
	bne	L360
	inc	|~~basicvars+62+2
L360:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$28
	rep	#$20
	longa	on
	beq	L361
	brl	L10176
L361:
	inc	|~~basicvars+62
	bne	L362
	inc	|~~basicvars+62+2
L362:
	jsl	~~get_arrayname
	sta	<L359+vp_1
	stx	<L359+vp_1+2
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$29
	rep	#$20
	longa	on
	bne	L363
	brl	L10177
L363:
	pea	#<$29
	pea	#4
	jsl	~~error
L10177:
	inc	|~~basicvars+62
	bne	L364
	inc	|~~basicvars+62+2
L364:
	brl	L10178
L10176:
	jsl	~~get_arrayname
	sta	<L359+vp_1
	stx	<L359+vp_1+2
L10178:
	ldy	#$10
	lda	[<L359+vp_1],Y
	sta	<R0
	ldy	#$12
	lda	[<L359+vp_1],Y
	sta	<R0+2
	ldy	#$2
	lda	[<R0],Y
	sta	<L359+elements_1
	ldy	#$4
	lda	[<L359+vp_1],Y
	brl	L10179
L10181:
p_2	set	8
	ldy	#$10
	lda	[<L359+vp_1],Y
	sta	<R0
	ldy	#$12
	lda	[<L359+vp_1],Y
	sta	<R0+2
	ldy	#$4
	lda	[<R0],Y
	sta	<L359+p_2
	ldy	#$6
	lda	[<R0],Y
	sta	<L359+p_2+2
	lda	#$0
	sta	|L10175
	lda	#$0
	sta	|L10175+2
	stz	<L359+n_1
	brl	L10185
L10184:
	lda	|L10175+2
	pha
	lda	|L10175
	pha
	ldy	#$0
	lda	<L359+n_1
	bpl	L365
	dey
L365:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	lda	<L359+p_2
	adc	<R0
	sta	<R2
	lda	<L359+p_2+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	[<R2]
	bpl	L366
	dey
L366:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	ldy	#$0
	lda	<L359+n_1
	bpl	L367
	dey
L367:
	sta	<R2
	sty	<R2+2
	pei	<R2+2
	pei	<R2
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	lda	<L359+p_2
	adc	<R0
	sta	<R3
	lda	<L359+p_2+2
	adc	<R0+2
	sta	<R3+2
	ldy	#$0
	lda	[<R3]
	bpl	L368
	dey
L368:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~fmul
	jsl	~~~fmul
	xref	~~~fadc
	jsl	~~~fadc
	pla
	sta	|L10175
	pla
	sta	|L10175+2
L10182:
	inc	<L359+n_1
L10185:
	sec
	lda	<L359+n_1
	sbc	<L359+elements_1
	bvs	L369
	eor	#$8000
L369:
	bmi	L370
	brl	L10184
L370:
L10183:
	phy
	phy
	phy
	phy
	lda	|L10175+2
	pha
	lda	|L10175
	pha
	xref	~~~ftod
	jsl	~~~ftod
	jsl	~~sqrt
	xref	~~~dtof
	jsl	~~~dtof
	jsl	~~push_float
	brl	L10180
L10186:
p_3	set	8
	ldy	#$10
	lda	[<L359+vp_1],Y
	sta	<R0
	ldy	#$12
	lda	[<L359+vp_1],Y
	sta	<R0+2
	ldy	#$4
	lda	[<R0],Y
	sta	<L359+p_3
	ldy	#$6
	lda	[<R0],Y
	sta	<L359+p_3+2
	lda	#$0
	sta	|L10175
	lda	#$0
	sta	|L10175+2
	stz	<L359+n_1
	brl	L10190
L10189:
	lda	|L10175+2
	pha
	lda	|L10175
	pha
	ldy	#$0
	lda	<L359+n_1
	bpl	L371
	dey
L371:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$2
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	lda	<L359+p_3
	adc	<R0
	sta	<R2
	lda	<L359+p_3+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$2
	lda	[<R2],Y
	pha
	lda	[<R2]
	pha
	ldy	#$0
	lda	<L359+n_1
	bpl	L372
	dey
L372:
	sta	<R3
	sty	<R3+2
	pei	<R3+2
	pei	<R3
	lda	#$2
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	lda	<L359+p_3
	adc	<R0
	sta	<17
	lda	<L359+p_3+2
	adc	<R0+2
	sta	<17+2
	ldy	#$2
	lda	[<17],Y
	pha
	lda	[<17]
	pha
	xref	~~~fmul
	jsl	~~~fmul
	xref	~~~fadc
	jsl	~~~fadc
	pla
	sta	|L10175
	pla
	sta	|L10175+2
L10187:
	inc	<L359+n_1
L10190:
	sec
	lda	<L359+n_1
	sbc	<L359+elements_1
	bvs	L373
	eor	#$8000
L373:
	bmi	L374
	brl	L10189
L374:
L10188:
	phy
	phy
	phy
	phy
	lda	|L10175+2
	pha
	lda	|L10175
	pha
	xref	~~~ftod
	jsl	~~~ftod
	jsl	~~sqrt
	xref	~~~dtof
	jsl	~~~dtof
	jsl	~~push_float
	brl	L10180
L10191:
	pea	#<$4a
	pea	#4
	jsl	~~error
	brl	L10180
L10192:
	pea	#^L121
	pea	#<L121
	pea	#<$3f4
	pea	#<$82
	pea	#10
	jsl	~~error
	brl	L10180
L10179:
	xref	~~~swt
	jsl	~~~swt
	dw	3
	dw	10
	dw	L10181-1
	dw	11
	dw	L10186-1
	dw	12
	dw	L10191-1
	dw	L10192-1
L10180:
L375:
	pld
	tsc
	clc
	adc	#L358
	tcs
	rtl
L358	equ	32
L359	equ	21
	ends
	efunc
	data
L121:
	db	$65,$78,$70,$72,$65,$73,$73,$69,$6F,$6E,$73,$00
	ends
	code
	xdef	~~fn_mode
	func
~~fn_mode:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L377
	tcs
	phd
	tcd
	inc	|~~basicvars+62
	bne	L379
	inc	|~~basicvars+62+2
L379:
	jsl	~~emulate_modefn
	pha
	jsl	~~push_int
L380:
	pld
	tsc
	clc
	adc	#L377
	tcs
	rtl
L377	equ	0
L378	equ	1
	ends
	efunc
	code
	xdef	~~fn_not
	func
~~fn_not:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L381
	tcs
	phd
	tcd
	inc	|~~basicvars+62
	bne	L383
	inc	|~~basicvars+62+2
L383:
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	lda	[<R1]
	and	#$ff
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~factor_table
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	tax
	lda	(<R1)
	xref	~~~lcal
	jsl	~~~lcal
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$2
	beq	L384
	brl	L10193
L384:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	|~~basicvars+42
	sta	<R1
	lda	|~~basicvars+42+2
	sta	<R1+2
	ldy	#$2
	lda	[<R1],Y
	eor	#<$ffffffff
	ldy	#$2
	sta	[<R0],Y
	brl	L10194
L10193:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$3
	beq	L385
	brl	L10195
L385:
	phy
	phy
	jsl	~~pop_float
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R0
	pla
	sta	<R0+2
	lda	<R0
	eor	#<$ffffffff
	pha
	jsl	~~push_int
	brl	L10196
L10195:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10196:
L10194:
L386:
	pld
	tsc
	clc
	adc	#L381
	tcs
	rtl
L381	equ	8
L382	equ	9
	ends
	efunc
	code
	func
~~fn_openin:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L387
	tcs
	phd
	tcd
stringtype_1	set	0
descriptor_1	set	2
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	lda	[<R1]
	and	#$ff
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~factor_table
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	tax
	lda	(<R1)
	xref	~~~lcal
	jsl	~~~lcal
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L388+stringtype_1
	lda	<L388+stringtype_1
	cmp	#<$4
	bne	L389
	brl	L10197
L389:
	lda	<L388+stringtype_1
	cmp	#<$5
	bne	L390
	brl	L10197
L390:
	pea	#<$40
	pea	#4
	jsl	~~error
L10197:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L388+descriptor_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	pei	<L388+descriptor_1
	pei	<L388+descriptor_1+4
	pei	<L388+descriptor_1+2
	jsl	~~fileio_openin
	pha
	jsl	~~push_int
	lda	<L388+stringtype_1
	cmp	#<$5
	beq	L391
	brl	L10198
L391:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L388+descriptor_1
	sta	<R1
	lda	#$0
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
L10198:
L392:
	pld
	tsc
	clc
	adc	#L387
	tcs
	rtl
L387	equ	16
L388	equ	9
	ends
	efunc
	code
	func
~~fn_openout:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L393
	tcs
	phd
	tcd
stringtype_1	set	0
descriptor_1	set	2
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	lda	[<R1]
	and	#$ff
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~factor_table
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	tax
	lda	(<R1)
	xref	~~~lcal
	jsl	~~~lcal
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L394+stringtype_1
	lda	<L394+stringtype_1
	cmp	#<$4
	bne	L395
	brl	L10199
L395:
	lda	<L394+stringtype_1
	cmp	#<$5
	bne	L396
	brl	L10199
L396:
	pea	#<$40
	pea	#4
	jsl	~~error
L10199:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L394+descriptor_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	pei	<L394+descriptor_1
	pei	<L394+descriptor_1+4
	pei	<L394+descriptor_1+2
	jsl	~~fileio_openout
	pha
	jsl	~~push_int
	lda	<L394+stringtype_1
	cmp	#<$5
	beq	L397
	brl	L10200
L397:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L394+descriptor_1
	sta	<R1
	lda	#$0
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
L10200:
L398:
	pld
	tsc
	clc
	adc	#L393
	tcs
	rtl
L393	equ	16
L394	equ	9
	ends
	efunc
	code
	func
~~fn_openup:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L399
	tcs
	phd
	tcd
stringtype_1	set	0
descriptor_1	set	2
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	lda	[<R1]
	and	#$ff
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~factor_table
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	tax
	lda	(<R1)
	xref	~~~lcal
	jsl	~~~lcal
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L400+stringtype_1
	lda	<L400+stringtype_1
	cmp	#<$4
	bne	L401
	brl	L10201
L401:
	lda	<L400+stringtype_1
	cmp	#<$5
	bne	L402
	brl	L10201
L402:
	pea	#<$40
	pea	#4
	jsl	~~error
L10201:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L400+descriptor_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	pei	<L400+descriptor_1
	pei	<L400+descriptor_1+4
	pei	<L400+descriptor_1+2
	jsl	~~fileio_openup
	pha
	jsl	~~push_int
	lda	<L400+stringtype_1
	cmp	#<$5
	beq	L403
	brl	L10202
L403:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L400+descriptor_1
	sta	<R1
	lda	#$0
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
L10202:
L404:
	pld
	tsc
	clc
	adc	#L399
	tcs
	rtl
L399	equ	16
L400	equ	9
	ends
	efunc
	code
	func
~~fn_pi:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L405
	tcs
	phd
	tcd
	pea	#$4049
	pea	#$0FDB
	jsl	~~push_float
L407:
	pld
	tsc
	clc
	adc	#L405
	tcs
	rtl
L405	equ	0
L406	equ	1
	ends
	efunc
	code
	func
~~fn_pointfn:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L408
	tcs
	phd
	tcd
x_1	set	0
y_1	set	2
	jsl	~~eval_integer
	sta	<L409+x_1
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$2c
	rep	#$20
	longa	on
	bne	L410
	brl	L10203
L410:
	pea	#<$27
	pea	#4
	jsl	~~error
L10203:
	inc	|~~basicvars+62
	bne	L411
	inc	|~~basicvars+62+2
L411:
	jsl	~~eval_integer
	sta	<L409+y_1
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$29
	rep	#$20
	longa	on
	bne	L412
	brl	L10204
L412:
	pea	#<$29
	pea	#4
	jsl	~~error
L10204:
	inc	|~~basicvars+62
	bne	L413
	inc	|~~basicvars+62+2
L413:
	pei	<L409+y_1
	pei	<L409+x_1
	jsl	~~emulate_pointfn
	pha
	jsl	~~push_int
L414:
	pld
	tsc
	clc
	adc	#L408
	tcs
	rtl
L408	equ	8
L409	equ	5
	ends
	efunc
	code
	func
~~fn_pos:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L415
	tcs
	phd
	tcd
	jsl	~~emulate_pos
	pha
	jsl	~~push_int
L417:
	pld
	tsc
	clc
	adc	#L415
	tcs
	rtl
L415	equ	0
L416	equ	1
	ends
	efunc
	code
	xdef	~~fn_quit
	func
~~fn_quit:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L418
	tcs
	phd
	tcd
	inc	|~~basicvars+62
	bne	L420
	inc	|~~basicvars+62+2
L420:
	lda	|~~basicvars+423
	sta	<R0
	lsr	<R0
	lsr	<R0
	lda	<R0
	and	#<$1
	sta	<R0
	pei	<R0
	jsl	~~push_int
L421:
	pld
	tsc
	clc
	adc	#L418
	tcs
	rtl
L418	equ	4
L419	equ	5
	ends
	efunc
	code
	func
~~fn_rad:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L422
	tcs
	phd
	tcd
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	lda	[<R1]
	and	#$ff
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~factor_table
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	tax
	lda	(<R1)
	xref	~~~lcal
	jsl	~~~lcal
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$2
	beq	L424
	brl	L10205
L424:
	pea	#$404C
	pea	#$A5DC
	pea	#$1A63
	pea	#$C1F8
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L425
	dey
L425:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~ftod
	jsl	~~~ftod
	xref	~~~ddiv
	jsl	~~~ddiv
	xref	~~~dtof
	jsl	~~~dtof
	jsl	~~push_float
	brl	L10206
L10205:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$3
	beq	L426
	brl	L10207
L426:
	pea	#$404C
	pea	#$A5DC
	pea	#$1A63
	pea	#$C1F8
	phy
	phy
	jsl	~~pop_float
	xref	~~~ftod
	jsl	~~~ftod
	xref	~~~ddiv
	jsl	~~~ddiv
	xref	~~~dtof
	jsl	~~~dtof
	jsl	~~push_float
	brl	L10208
L10207:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10208:
L10206:
L427:
	pld
	tsc
	clc
	adc	#L422
	tcs
	rtl
L422	equ	8
L423	equ	9
	ends
	efunc
	code
	func
~~fn_reportdol:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L428
	tcs
	phd
	tcd
p_1	set	0
length_1	set	4
	jsl	~~get_lasterror
	sta	<R0
	stx	<R0+2
	phx
	pha
	jsl	~~strlen
	sta	<L429+length_1
	pei	<L429+length_1
	jsl	~~alloc_string
	sta	<L429+p_1
	stx	<L429+p_1+2
	ldy	#$0
	lda	<L429+length_1
	bpl	L430
	dey
L430:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~get_lasterror
	sta	<R1
	stx	<R1+2
	phx
	pha
	pei	<L429+p_1+2
	pei	<L429+p_1
	jsl	~~memmove
	pei	<L429+p_1+2
	pei	<L429+p_1
	pei	<L429+length_1
	jsl	~~push_strtemp
L431:
	pld
	tsc
	clc
	adc	#L428
	tcs
	rtl
L428	equ	14
L429	equ	9
	ends
	efunc
	code
	func
~~fn_retcode:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L432
	tcs
	phd
	tcd
	lda	|~~basicvars+490
	pha
	jsl	~~push_int
L434:
	pld
	tsc
	clc
	adc	#L432
	tcs
	rtl
L432	equ	0
L433	equ	1
	ends
	efunc
	code
	func
~~nextrandom:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L435
	tcs
	phd
	tcd
n_1	set	0
	stz	<L436+n_1
L10211:
newbit_2	set	2
	lda	|~~lastrandom
	ldx	#<$13
	xref	~~~asr
	jsl	~~~asr
	sta	<R0
	lda	|~~randomoverflow
	eor	<R0
	and	#<$1
	sta	<L436+newbit_2
	lda	|~~lastrandom
	ldx	#<$1f
	xref	~~~asr
	jsl	~~~asr
	sta	|~~randomoverflow
	lda	|~~lastrandom
	asl	A
	sta	<R0
	lda	<L436+newbit_2
	ora	<R0
	sta	|~~lastrandom
L10209:
	inc	<L436+n_1
	sec
	lda	<L436+n_1
	sbc	#<$20
	bvs	L437
	eor	#$8000
L437:
	bmi	L438
	brl	L10211
L438:
L10210:
L439:
	pld
	tsc
	clc
	adc	#L435
	tcs
	rtl
L435	equ	8
L436	equ	5
	ends
	efunc
	code
	func
~~randomfraction:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L440
	tcs
	phd
	tcd
reversed_1	set	0
	lda	|~~lastrandom
	ldx	#<$18
	xref	~~~asr
	jsl	~~~asr
	and	#<$ff
	sta	<R0
	lda	|~~lastrandom
	ldx	#<$8
	xref	~~~asr
	jsl	~~~asr
	and	#<$ff00
	sta	<R1
	lda	<R1
	ora	<R0
	sta	<R2
	lda	<R2
	sta	<R0
	stz	<R0+2
	lda	|~~lastrandom
	xba
	and	#$ff00
	sta	<R1
	ldy	#$0
	lda	<R1
	bpl	L442
	dey
L442:
	sta	<R1
	sty	<R1+2
	stz	<R2
	lda	<R1+2
	and	#^$ff0000
	sta	<R2+2
	lda	<R2
	ora	<R0
	sta	<R1
	lda	<R2+2
	ora	<R0+2
	sta	<R1+2
	lda	|~~lastrandom
	ldx	#<$18
	xref	~~~asl
	jsl	~~~asl
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L443
	dey
L443:
	sta	<R0
	sty	<R0+2
	stz	<R2
	lda	<R0+2
	and	#^$ff000000
	sta	<R2+2
	lda	<R2
	ora	<R1
	sta	<R0
	lda	<R2+2
	ora	<R1+2
	sta	<R0+2
	lda	<R0
	sta	<L441+reversed_1
	pea	#$41F0
	pea	#$0000
	pea	#$0000
	pea	#$0000
	pea	#0
	pei	<L441+reversed_1
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~ftod
	jsl	~~~ftod
	xref	~~~ddiv
	jsl	~~~ddiv
	xref	~~~dtof
	jsl	~~~dtof
	pla
	sta	<L440+4
	pla
	sta	<L440+6
L444:
	pld
	tsc
	clc
	adc	#L440+0
	tcs
	rtl
L440	equ	14
L441	equ	13
	ends
	efunc
	code
	func
~~fn_rnd:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L445
	tcs
	phd
	tcd
value_1	set	0
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$28
	rep	#$20
	longa	on
	beq	L447
	brl	L10212
L447:
	inc	|~~basicvars+62
	bne	L448
	inc	|~~basicvars+62+2
L448:
	jsl	~~eval_integer
	sta	<L446+value_1
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$29
	rep	#$20
	longa	on
	bne	L449
	brl	L10213
L449:
	pea	#<$29
	pea	#4
	jsl	~~error
L10213:
	inc	|~~basicvars+62
	bne	L450
	inc	|~~basicvars+62+2
L450:
	lda	<L446+value_1
	bmi	L451
	brl	L10214
L451:
	lda	<L446+value_1
	sta	|~~lastrandom
	stz	|~~randomoverflow
	pei	<L446+value_1
	jsl	~~push_int
	brl	L10215
L10214:
	lda	<L446+value_1
	beq	L452
	brl	L10216
L452:
	phy
	phy
	jsl	~~randomfraction
	jsl	~~push_float
	brl	L10217
L10216:
	lda	<L446+value_1
	cmp	#<$1
	beq	L453
	brl	L10218
L453:
	jsl	~~nextrandom
	phy
	phy
	jsl	~~randomfraction
	jsl	~~push_float
	brl	L10219
L10218:
	jsl	~~nextrandom
	ldy	#$0
	lda	<L446+value_1
	bpl	L454
	dey
L454:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	phy
	phy
	jsl	~~randomfraction
	xref	~~~fmul
	jsl	~~~fmul
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R0
	pla
	sta	<R0+2
	pei	<R0
	jsl	~~push_int
L10219:
L10217:
L10215:
	brl	L10220
L10212:
	jsl	~~nextrandom
	lda	|~~lastrandom
	pha
	jsl	~~push_int
L10220:
L455:
	pld
	tsc
	clc
	adc	#L445
	tcs
	rtl
L445	equ	6
L446	equ	5
	ends
	efunc
	code
	func
~~fn_sgn:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L456
	tcs
	phd
	tcd
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	lda	[<R1]
	and	#$ff
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~factor_table
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	tax
	lda	(<R1)
	xref	~~~lcal
	jsl	~~~lcal
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$2
	beq	L458
	brl	L10221
L458:
value_2	set	0
	jsl	~~pop_int
	sta	<L457+value_2
	sec
	lda	#$0
	sbc	<L457+value_2
	bvs	L459
	eor	#$8000
L459:
	bpl	L460
	brl	L10222
L460:
	clc
	lda	#$fffc
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	lda	#$ffff
	adc	|~~basicvars+42+2
	sta	|~~basicvars+42+2
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	#$2
	sta	[<R0]
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	#$1
	ldy	#$2
	sta	[<R0],Y
	brl	L10223
L10222:
	lda	<L457+value_2
	beq	L461
	brl	L10224
L461:
	clc
	lda	#$fffc
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	lda	#$ffff
	adc	|~~basicvars+42+2
	sta	|~~basicvars+42+2
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	#$2
	sta	[<R0]
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	#$0
	ldy	#$2
	sta	[<R0],Y
	brl	L10225
L10224:
	clc
	lda	#$fffc
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	lda	#$ffff
	adc	|~~basicvars+42+2
	sta	|~~basicvars+42+2
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	#$2
	sta	[<R0]
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	#$ffff
	ldy	#$2
	sta	[<R0],Y
L10225:
L10223:
	brl	L10226
L10221:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$3
	beq	L462
	brl	L10227
L462:
	phy
	phy
	jsl	~~pop_float
	pla
	sta	|~~floatvalue
	pla
	sta	|~~floatvalue+2
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	xref	~~~ftod
	jsl	~~~ftod
	pea	#$0000
	pea	#$0000
	pea	#$0000
	pea	#$0000
	xref	~~~dcmp
	jsl	~~~dcmp
	bmi	L463
	brl	L10228
L463:
	clc
	lda	#$fffc
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	lda	#$ffff
	adc	|~~basicvars+42+2
	sta	|~~basicvars+42+2
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	#$2
	sta	[<R0]
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	#$1
	ldy	#$2
	sta	[<R0],Y
	brl	L10229
L10228:
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	xref	~~~ftod
	jsl	~~~ftod
	xref	~~~dtst
	jsl	~~~dtst
	beq	L464
	brl	L10230
L464:
	clc
	lda	#$fffc
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	lda	#$ffff
	adc	|~~basicvars+42+2
	sta	|~~basicvars+42+2
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	#$2
	sta	[<R0]
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	#$0
	ldy	#$2
	sta	[<R0],Y
	brl	L10231
L10230:
	clc
	lda	#$fffc
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	lda	#$ffff
	adc	|~~basicvars+42+2
	sta	|~~basicvars+42+2
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	#$2
	sta	[<R0]
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	#$ffff
	ldy	#$2
	sta	[<R0],Y
L10231:
L10229:
	brl	L10232
L10227:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10232:
L10226:
L465:
	pld
	tsc
	clc
	adc	#L456
	tcs
	rtl
L456	equ	10
L457	equ	9
	ends
	efunc
	code
	func
~~fn_sin:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L466
	tcs
	phd
	tcd
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	lda	[<R1]
	and	#$ff
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~factor_table
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	tax
	lda	(<R1)
	xref	~~~lcal
	jsl	~~~lcal
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$2
	beq	L468
	brl	L10233
L468:
	phy
	phy
	phy
	phy
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L469
	dey
L469:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~ftod
	jsl	~~~ftod
	jsl	~~sin
	xref	~~~dtof
	jsl	~~~dtof
	jsl	~~push_float
	brl	L10234
L10233:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$3
	beq	L470
	brl	L10235
L470:
	phy
	phy
	phy
	phy
	phy
	phy
	jsl	~~pop_float
	xref	~~~ftod
	jsl	~~~ftod
	jsl	~~sin
	xref	~~~dtof
	jsl	~~~dtof
	jsl	~~push_float
	brl	L10236
L10235:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10236:
L10234:
L471:
	pld
	tsc
	clc
	adc	#L466
	tcs
	rtl
L466	equ	8
L467	equ	9
	ends
	efunc
	code
	func
~~fn_sqr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L472
	tcs
	phd
	tcd
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	lda	[<R1]
	and	#$ff
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~factor_table
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	tax
	lda	(<R1)
	xref	~~~lcal
	jsl	~~~lcal
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$2
	beq	L474
	brl	L10237
L474:
value_2	set	0
	jsl	~~pop_int
	sta	<L473+value_2
	lda	<L473+value_2
	bmi	L475
	brl	L10238
L475:
	pea	#<$38
	pea	#4
	jsl	~~error
L10238:
	phy
	phy
	phy
	phy
	ldy	#$0
	lda	<L473+value_2
	bpl	L476
	dey
L476:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~ftod
	jsl	~~~ftod
	jsl	~~sqrt
	xref	~~~dtof
	jsl	~~~dtof
	jsl	~~push_float
	brl	L10239
L10237:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$3
	beq	L477
	brl	L10240
L477:
	phy
	phy
	jsl	~~pop_float
	pla
	sta	|~~floatvalue
	pla
	sta	|~~floatvalue+2
	pea	#$0000
	pea	#$0000
	pea	#$0000
	pea	#$0000
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	xref	~~~ftod
	jsl	~~~ftod
	xref	~~~dcmp
	jsl	~~~dcmp
	bmi	L478
	brl	L10241
L478:
	pea	#<$38
	pea	#4
	jsl	~~error
L10241:
	phy
	phy
	phy
	phy
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	xref	~~~ftod
	jsl	~~~ftod
	jsl	~~sqrt
	xref	~~~dtof
	jsl	~~~dtof
	jsl	~~push_float
	brl	L10242
L10240:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10242:
L10239:
L479:
	pld
	tsc
	clc
	adc	#L472
	tcs
	rtl
L472	equ	10
L473	equ	9
	ends
	efunc
	code
	func
~~fn_str:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L480
	tcs
	phd
	tcd
ishex_1	set	0
length_1	set	1
cp_1	set	3
	stz	<R0
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	sep	#$20
	longa	off
	lda	[<R1]
	cmp	#<$7e
	rep	#$20
	longa	on
	beq	L483
	brl	L482
L483:
	inc	<R0
L482:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L481+ishex_1
	rep	#$20
	longa	on
	lda	<L481+ishex_1
	and	#$ff
	bne	L484
	brl	L10243
L484:
	inc	|~~basicvars+62
	bne	L485
	inc	|~~basicvars+62+2
L485:
L10243:
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	lda	[<R1]
	and	#$ff
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~factor_table
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	tax
	lda	(<R1)
	xref	~~~lcal
	jsl	~~~lcal
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$2
	beq	L486
	brl	L10244
L486:
	lda	<L481+ishex_1
	and	#$ff
	bne	L487
	brl	L10245
L487:
	jsl	~~pop_int
	pha
	pea	#^L376
	pea	#<L376
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	pea	#12
	jsl	~~sprintf
	sta	<L481+length_1
	brl	L10246
L10245:
	jsl	~~pop_int
	pha
	pea	#^L376+3
	pea	#<L376+3
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	pea	#12
	jsl	~~sprintf
	sta	<L481+length_1
L10246:
	brl	L10247
L10244:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$3
	beq	L488
	brl	L10248
L488:
	lda	<L481+ishex_1
	and	#$ff
	bne	L489
	brl	L10249
L489:
	phy
	phy
	jsl	~~pop_float
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R0
	pla
	sta	<R0+2
	pei	<R0
	pea	#^L376+6
	pea	#<L376+6
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	pea	#12
	jsl	~~sprintf
	sta	<L481+length_1
	brl	L10250
L10249:
format_2	set	7
numdigits_2	set	9
fmt_2	set	11
	lda	|~~basicvars+520
	sta	<L481+format_2
	ldy	#$0
	lda	<L481+format_2
	bpl	L490
	dey
L490:
	sta	<R0
	sty	<R0+2
	lda	<R0+2
	and	#^$1000000
	beq	L491
	brl	L10251
L491:
	lda	#$a0a
	sta	<L481+format_2
L10251:
	lda	<L481+format_2
	ldx	#<$10
	xref	~~~asr
	jsl	~~~asr
	and	#<$ff
	brl	L10252
L10254:
	lda	#<L376+9
	sta	<L481+fmt_2
	lda	#^L376+9
	sta	<L481+fmt_2+2
	brl	L10253
L10255:
	lda	#<L376+14
	sta	<L481+fmt_2
	lda	#^L376+14
	sta	<L481+fmt_2+2
	brl	L10253
L10256:
	lda	#<L376+19
	sta	<L481+fmt_2
	lda	#^L376+19
	sta	<L481+fmt_2+2
	brl	L10253
L10252:
	xref	~~~swt
	jsl	~~~swt
	dw	2
	dw	1
	dw	L10254-1
	dw	2
	dw	L10255-1
	dw	L10256-1
L10253:
	lda	<L481+format_2
	ldx	#<$8
	xref	~~~asr
	jsl	~~~asr
	and	#<$ff
	sta	<L481+numdigits_2
	lda	<L481+numdigits_2
	beq	L492
	brl	L10257
L492:
	lda	#$a
	sta	<L481+numdigits_2
L10257:
	phy
	phy
	jsl	~~pop_float
	xref	~~~ftod
	jsl	~~~ftod
	pei	<L481+numdigits_2
	pei	<L481+fmt_2+2
	pei	<L481+fmt_2
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	pea	#20
	jsl	~~sprintf
	sta	<L481+length_1
L10250:
	brl	L10258
L10248:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10258:
L10247:
	pei	<L481+length_1
	jsl	~~alloc_string
	sta	<L481+cp_1
	stx	<L481+cp_1+2
	ldy	#$0
	lda	<L481+length_1
	bpl	L493
	dey
L493:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	pei	<L481+cp_1+2
	pei	<L481+cp_1
	jsl	~~memcpy
	pei	<L481+cp_1+2
	pei	<L481+cp_1
	pei	<L481+length_1
	jsl	~~push_strtemp
L494:
	pld
	tsc
	clc
	adc	#L480
	tcs
	rtl
L480	equ	23
L481	equ	9
	ends
	efunc
	data
L376:
	db	$25,$58,$00,$25,$64,$00,$25,$58,$00,$25,$2E,$2A,$45,$00,$25
	db	$2E,$2A,$46,$00,$25,$2E,$2A,$47,$00
	ends
	code
	func
~~fn_string:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L496
	tcs
	phd
	tcd
count_1	set	0
newlen_1	set	2
descriptor_1	set	4
base_1	set	10
cp_1	set	14
stringtype_1	set	18
	jsl	~~eval_integer
	sta	<L497+count_1
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$2c
	rep	#$20
	longa	on
	bne	L498
	brl	L10259
L498:
	pea	#<$27
	pea	#4
	jsl	~~error
L10259:
	inc	|~~basicvars+62
	bne	L499
	inc	|~~basicvars+62+2
L499:
	jsl	~~expression
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$29
	rep	#$20
	longa	on
	bne	L500
	brl	L10260
L500:
	pea	#<$29
	pea	#4
	jsl	~~error
L10260:
	inc	|~~basicvars+62
	bne	L501
	inc	|~~basicvars+62+2
L501:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L497+stringtype_1
	lda	<L497+stringtype_1
	cmp	#<$4
	bne	L502
	brl	L10261
L502:
	lda	<L497+stringtype_1
	cmp	#<$5
	bne	L503
	brl	L10261
L503:
	pea	#<$40
	pea	#4
	jsl	~~error
L10261:
	lda	<L497+count_1
	cmp	#<$1
	beq	L504
	brl	L10262
L504:
L505:
	pld
	tsc
	clc
	adc	#L496
	tcs
	rtl
L10262:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L497+descriptor_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	sec
	lda	#$0
	sbc	<L497+count_1
	bvs	L506
	eor	#$8000
L506:
	bmi	L507
	brl	L10263
L507:
	stz	<L497+newlen_1
	brl	L10264
L10263:
	lda	<L497+count_1
	ldx	<L497+descriptor_1
	xref	~~~mul
	jsl	~~~mul
	sta	<L497+newlen_1
	sec
	lda	#$1000
	sbc	<L497+newlen_1
	bvs	L508
	eor	#$8000
L508:
	bpl	L509
	brl	L10265
L509:
	pea	#<$3d
	pea	#4
	jsl	~~error
L10265:
L10264:
	pei	<L497+newlen_1
	jsl	~~alloc_string
	sta	<L497+cp_1
	stx	<L497+cp_1+2
	lda	<L497+cp_1
	sta	<L497+base_1
	lda	<L497+cp_1+2
	sta	<L497+base_1+2
L10266:
	sec
	lda	#$0
	sbc	<L497+count_1
	bvs	L510
	eor	#$8000
L510:
	bpl	L511
	brl	L10267
L511:
	ldy	#$0
	lda	<L497+descriptor_1
	bpl	L512
	dey
L512:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L497+descriptor_1+4
	pei	<L497+descriptor_1+2
	pei	<L497+cp_1+2
	pei	<L497+cp_1
	jsl	~~memmove
	ldy	#$0
	lda	<L497+descriptor_1
	bpl	L513
	dey
L513:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L497+cp_1
	adc	<R0
	sta	<L497+cp_1
	lda	<L497+cp_1+2
	adc	<R0+2
	sta	<L497+cp_1+2
	dec	<L497+count_1
	brl	L10266
L10267:
	lda	<L497+stringtype_1
	cmp	#<$5
	beq	L514
	brl	L10268
L514:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L497+descriptor_1
	sta	<R1
	lda	#$0
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
L10268:
	pei	<L497+base_1+2
	pei	<L497+base_1
	pei	<L497+newlen_1
	jsl	~~push_strtemp
	brl	L505
L496	equ	28
L497	equ	9
	ends
	efunc
	code
	func
~~fn_sum:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L515
	tcs
	phd
	tcd
n_1	set	0
elements_1	set	2
vp_1	set	4
sumlen_1	set	8
	stz	<R0
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	sep	#$20
	longa	off
	lda	[<R1]
	cmp	#<$ff
	rep	#$20
	longa	on
	beq	L518
	brl	L517
L518:
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<R1],Y
	cmp	#<$29
	rep	#$20
	longa	on
	beq	L519
	brl	L517
L519:
	inc	<R0
L517:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L516+sumlen_1
	rep	#$20
	longa	on
	lda	<L516+sumlen_1
	and	#$ff
	bne	L520
	brl	L10269
L520:
	clc
	lda	#$2
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L521
	inc	|~~basicvars+62+2
L521:
L10269:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$28
	rep	#$20
	longa	on
	beq	L522
	brl	L10270
L522:
	inc	|~~basicvars+62
	bne	L523
	inc	|~~basicvars+62+2
L523:
	jsl	~~get_arrayname
	sta	<L516+vp_1
	stx	<L516+vp_1+2
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$29
	rep	#$20
	longa	on
	bne	L524
	brl	L10271
L524:
	pea	#<$29
	pea	#4
	jsl	~~error
L10271:
	inc	|~~basicvars+62
	bne	L525
	inc	|~~basicvars+62+2
L525:
	brl	L10272
L10270:
	jsl	~~get_arrayname
	sta	<L516+vp_1
	stx	<L516+vp_1+2
L10272:
	ldy	#$10
	lda	[<L516+vp_1],Y
	sta	<R0
	ldy	#$12
	lda	[<L516+vp_1],Y
	sta	<R0+2
	ldy	#$2
	lda	[<R0],Y
	sta	<L516+elements_1
	lda	<L516+sumlen_1
	and	#$ff
	bne	L526
	brl	L10273
L526:
length_2	set	9
p_2	set	11
	ldy	#$4
	lda	[<L516+vp_1],Y
	cmp	#<$c
	bne	L527
	brl	L10274
L527:
	pea	#<$40
	pea	#4
	jsl	~~error
L10274:
	ldy	#$10
	lda	[<L516+vp_1],Y
	sta	<R0
	ldy	#$12
	lda	[<L516+vp_1],Y
	sta	<R0+2
	ldy	#$4
	lda	[<R0],Y
	sta	<L516+p_2
	ldy	#$6
	lda	[<R0],Y
	sta	<L516+p_2+2
	stz	<L516+length_2
	stz	<L516+n_1
	brl	L10278
L10277:
	ldy	#$0
	lda	<L516+n_1
	bpl	L528
	dey
L528:
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
	clc
	lda	<L516+p_2
	adc	<R0
	sta	<R1
	lda	<L516+p_2+2
	adc	<R0+2
	sta	<R1+2
	clc
	lda	[<R1]
	adc	<L516+length_2
	sta	<L516+length_2
L10275:
	inc	<L516+n_1
L10278:
	sec
	lda	<L516+n_1
	sbc	<L516+elements_1
	bvs	L529
	eor	#$8000
L529:
	bmi	L530
	brl	L10277
L530:
L10276:
	pei	<L516+length_2
	jsl	~~push_int
	brl	L10279
L10273:
	ldy	#$4
	lda	[<L516+vp_1],Y
	brl	L10280
L10282:
intsum_3	set	9
p_3	set	11
	ldy	#$10
	lda	[<L516+vp_1],Y
	sta	<R0
	ldy	#$12
	lda	[<L516+vp_1],Y
	sta	<R0+2
	ldy	#$4
	lda	[<R0],Y
	sta	<L516+p_3
	ldy	#$6
	lda	[<R0],Y
	sta	<L516+p_3+2
	stz	<L516+intsum_3
	stz	<L516+n_1
	brl	L10286
L10285:
	ldy	#$0
	lda	<L516+n_1
	bpl	L531
	dey
L531:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	lda	<L516+p_3
	adc	<R0
	sta	<R2
	lda	<L516+p_3+2
	adc	<R0+2
	sta	<R2+2
	clc
	lda	[<R2]
	adc	<L516+intsum_3
	sta	<L516+intsum_3
L10283:
	inc	<L516+n_1
L10286:
	sec
	lda	<L516+n_1
	sbc	<L516+elements_1
	bvs	L532
	eor	#$8000
L532:
	bmi	L533
	brl	L10285
L533:
L10284:
	pei	<L516+intsum_3
	jsl	~~push_int
	brl	L10281
L10287:
fpsum_4	set	9
p_4	set	13
	lda	#$0
	sta	<L516+fpsum_4
	lda	#$0
	sta	<L516+fpsum_4+2
	ldy	#$10
	lda	[<L516+vp_1],Y
	sta	<R0
	ldy	#$12
	lda	[<L516+vp_1],Y
	sta	<R0+2
	ldy	#$4
	lda	[<R0],Y
	sta	<L516+p_4
	ldy	#$6
	lda	[<R0],Y
	sta	<L516+p_4+2
	stz	<L516+n_1
	brl	L10291
L10290:
	pei	<L516+fpsum_4+2
	pei	<L516+fpsum_4
	ldy	#$0
	lda	<L516+n_1
	bpl	L534
	dey
L534:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$2
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	lda	<L516+p_4
	adc	<R0
	sta	<R2
	lda	<L516+p_4+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$2
	lda	[<R2],Y
	pha
	lda	[<R2]
	pha
	xref	~~~fadc
	jsl	~~~fadc
	pla
	sta	<L516+fpsum_4
	pla
	sta	<L516+fpsum_4+2
L10288:
	inc	<L516+n_1
L10291:
	sec
	lda	<L516+n_1
	sbc	<L516+elements_1
	bvs	L535
	eor	#$8000
L535:
	bmi	L536
	brl	L10290
L536:
L10289:
	pei	<L516+fpsum_4+2
	pei	<L516+fpsum_4
	jsl	~~push_float
	brl	L10281
L10292:
length_5	set	9
strlen_5	set	11
cp_5	set	13
cp2_5	set	17
p_5	set	21
	ldy	#$10
	lda	[<L516+vp_1],Y
	sta	<R0
	ldy	#$12
	lda	[<L516+vp_1],Y
	sta	<R0+2
	ldy	#$4
	lda	[<R0],Y
	sta	<L516+p_5
	ldy	#$6
	lda	[<R0],Y
	sta	<L516+p_5+2
	stz	<L516+length_5
	stz	<L516+n_1
	brl	L10296
L10295:
	ldy	#$0
	lda	<L516+n_1
	bpl	L537
	dey
L537:
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
	clc
	lda	<L516+p_5
	adc	<R0
	sta	<R1
	lda	<L516+p_5+2
	adc	<R0+2
	sta	<R1+2
	clc
	lda	[<R1]
	adc	<L516+length_5
	sta	<L516+length_5
L10293:
	inc	<L516+n_1
L10296:
	sec
	lda	<L516+n_1
	sbc	<L516+elements_1
	bvs	L538
	eor	#$8000
L538:
	bmi	L539
	brl	L10295
L539:
L10294:
	sec
	lda	#$1000
	sbc	<L516+length_5
	bvs	L540
	eor	#$8000
L540:
	bpl	L541
	brl	L10297
L541:
	pea	#<$3d
	pea	#4
	jsl	~~error
L10297:
	pei	<L516+length_5
	jsl	~~alloc_string
	sta	<L516+cp2_5
	stx	<L516+cp2_5+2
	lda	<L516+cp2_5
	sta	<L516+cp_5
	lda	<L516+cp2_5+2
	sta	<L516+cp_5+2
	sec
	lda	#$0
	sbc	<L516+length_5
	bvs	L542
	eor	#$8000
L542:
	bpl	L543
	brl	L10298
L543:
	stz	<L516+n_1
	brl	L10302
L10301:
	ldy	#$0
	lda	<L516+n_1
	bpl	L544
	dey
L544:
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
	clc
	lda	<L516+p_5
	adc	<R0
	sta	<R1
	lda	<L516+p_5+2
	adc	<R0+2
	sta	<R1+2
	lda	[<R1]
	sta	<L516+strlen_5
	sec
	lda	#$0
	sbc	<L516+strlen_5
	bvs	L545
	eor	#$8000
L545:
	bpl	L546
	brl	L10303
L546:
	ldy	#$0
	lda	<L516+strlen_5
	bpl	L547
	dey
L547:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	ldy	#$0
	lda	<L516+n_1
	bpl	L548
	dey
L548:
	sta	<R1
	sty	<R1+2
	pea	#^$6
	pea	#<$6
	pei	<R1+2
	pei	<R1
	xref	~~~lmul
	jsl	~~~lmul
	sta	<R1
	stx	<R1+2
	clc
	lda	#$2
	adc	<L516+p_5
	sta	<R2
	lda	#$0
	adc	<L516+p_5+2
	sta	<R2+2
	clc
	lda	<R2
	adc	<R1
	sta	<R3
	lda	<R2+2
	adc	<R1+2
	sta	<R3+2
	ldy	#$2
	lda	[<R3],Y
	pha
	lda	[<R3]
	pha
	pei	<L516+cp2_5+2
	pei	<L516+cp2_5
	jsl	~~memmove
	ldy	#$0
	lda	<L516+strlen_5
	bpl	L549
	dey
L549:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L516+cp2_5
	adc	<R0
	sta	<L516+cp2_5
	lda	<L516+cp2_5+2
	adc	<R0+2
	sta	<L516+cp2_5+2
L10303:
L10299:
	inc	<L516+n_1
L10302:
	sec
	lda	<L516+n_1
	sbc	<L516+elements_1
	bvs	L550
	eor	#$8000
L550:
	bmi	L551
	brl	L10301
L551:
L10300:
L10298:
	pei	<L516+cp_5+2
	pei	<L516+cp_5
	pei	<L516+length_5
	jsl	~~push_strtemp
	brl	L10281
L10304:
	pea	#^L495
	pea	#<L495
	pea	#<$5a1
	pea	#<$82
	pea	#10
	jsl	~~error
	brl	L10281
L10280:
	xref	~~~swt
	jsl	~~~swt
	dw	3
	dw	10
	dw	L10282-1
	dw	11
	dw	L10287-1
	dw	12
	dw	L10292-1
	dw	L10304-1
L10281:
L10279:
L552:
	pld
	tsc
	clc
	adc	#L515
	tcs
	rtl
L515	equ	41
L516	equ	17
	ends
	efunc
	data
L495:
	db	$65,$78,$70,$72,$65,$73,$73,$69,$6F,$6E,$73,$00
	ends
	code
	func
~~fn_tan:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L554
	tcs
	phd
	tcd
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	lda	[<R1]
	and	#$ff
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~factor_table
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	tax
	lda	(<R1)
	xref	~~~lcal
	jsl	~~~lcal
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$2
	beq	L556
	brl	L10305
L556:
	phy
	phy
	phy
	phy
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L557
	dey
L557:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~ftod
	jsl	~~~ftod
	jsl	~~tan
	xref	~~~dtof
	jsl	~~~dtof
	jsl	~~push_float
	brl	L10306
L10305:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$3
	beq	L558
	brl	L10307
L558:
	phy
	phy
	phy
	phy
	phy
	phy
	jsl	~~pop_float
	xref	~~~ftod
	jsl	~~~ftod
	jsl	~~tan
	xref	~~~dtof
	jsl	~~~dtof
	jsl	~~push_float
	brl	L10308
L10307:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10308:
L10306:
L559:
	pld
	tsc
	clc
	adc	#L554
	tcs
	rtl
L554	equ	8
L555	equ	9
	ends
	efunc
	code
	func
~~fn_tempofn:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L560
	tcs
	phd
	tcd
	jsl	~~emulate_tempofn
	pha
	jsl	~~push_int
L562:
	pld
	tsc
	clc
	adc	#L560
	tcs
	rtl
L560	equ	0
L561	equ	1
	ends
	efunc
	code
	xdef	~~fn_tint
	func
~~fn_tint:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L563
	tcs
	phd
	tcd
x_1	set	0
y_1	set	2
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$28
	rep	#$20
	longa	on
	bne	L565
	brl	L10309
L565:
	pea	#<$28
	pea	#4
	jsl	~~error
L10309:
	inc	|~~basicvars+62
	bne	L566
	inc	|~~basicvars+62+2
L566:
	jsl	~~eval_integer
	sta	<L564+x_1
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$2c
	rep	#$20
	longa	on
	bne	L567
	brl	L10310
L567:
	pea	#<$27
	pea	#4
	jsl	~~error
L10310:
	inc	|~~basicvars+62
	bne	L568
	inc	|~~basicvars+62+2
L568:
	jsl	~~eval_integer
	sta	<L564+y_1
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$29
	rep	#$20
	longa	on
	bne	L569
	brl	L10311
L569:
	pea	#<$29
	pea	#4
	jsl	~~error
L10311:
	pei	<L564+y_1
	pei	<L564+x_1
	jsl	~~emulate_tintfn
	pha
	jsl	~~push_int
L570:
	pld
	tsc
	clc
	adc	#L563
	tcs
	rtl
L563	equ	8
L564	equ	5
	ends
	efunc
	code
	xdef	~~fn_top
	func
~~fn_top:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L571
	tcs
	phd
	tcd
p_1	set	0
	inc	|~~basicvars+62
	bne	L573
	inc	|~~basicvars+62+2
L573:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$1
	rep	#$20
	longa	on
	bne	L574
	brl	L10312
L574:
	pea	#<$5
	pea	#4
	jsl	~~error
L10312:
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~get_srcaddr
	sta	<L572+p_1
	stx	<L572+p_1+2
	sep	#$20
	longa	off
	lda	[<L572+p_1]
	cmp	#<$50
	rep	#$20
	longa	on
	bne	L575
	brl	L10313
L575:
	pea	#<$5
	pea	#4
	jsl	~~error
L10313:
	clc
	lda	#$5
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L576
	inc	|~~basicvars+62+2
L576:
	sec
	lda	|~~basicvars+26
	sbc	|~~basicvars+6
	sta	<R0
	lda	|~~basicvars+26+2
	sbc	|~~basicvars+6+2
	sta	<R0+2
	pei	<R0
	jsl	~~push_int
L577:
	pld
	tsc
	clc
	adc	#L571
	tcs
	rtl
L571	equ	8
L572	equ	5
	ends
	efunc
	code
	xdef	~~fn_trace
	func
~~fn_trace:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L578
	tcs
	phd
	tcd
	inc	|~~basicvars+62
	bne	L580
	inc	|~~basicvars+62+2
L580:
	lda	|~~basicvars+427
	pha
	jsl	~~push_int
L581:
	pld
	tsc
	clc
	adc	#L578
	tcs
	rtl
L578	equ	0
L579	equ	1
	ends
	efunc
	code
	xdef	~~fn_true
	func
~~fn_true:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L582
	tcs
	phd
	tcd
	inc	|~~basicvars+62
	bne	L584
	inc	|~~basicvars+62+2
L584:
	pea	#<$ffffffff
	jsl	~~push_int
L585:
	pld
	tsc
	clc
	adc	#L582
	tcs
	rtl
L582	equ	0
L583	equ	1
	ends
	efunc
	code
	func
~~fn_usr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L586
	tcs
	phd
	tcd
	jsl	~~eval_intfactor
	pha
	jsl	~~emulate_usr
	pha
	jsl	~~push_int
L588:
	pld
	tsc
	clc
	adc	#L586
	tcs
	rtl
L586	equ	0
L587	equ	1
	ends
	efunc
	code
	func
~~fn_val:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L589
	tcs
	phd
	tcd
	udata
L10314:
	ds	4
	ends
stringtype_1	set	0
descriptor_1	set	2
cp_1	set	8
isint_1	set	12
intvalue_1	set	13
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	lda	[<R1]
	and	#$ff
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~factor_table
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	tax
	lda	(<R1)
	xref	~~~lcal
	jsl	~~~lcal
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L590+stringtype_1
	lda	<L590+stringtype_1
	cmp	#<$4
	bne	L591
	brl	L10315
L591:
	lda	<L590+stringtype_1
	cmp	#<$5
	bne	L592
	brl	L10315
L592:
	pea	#<$40
	pea	#4
	jsl	~~error
L10315:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L590+descriptor_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	lda	<L590+descriptor_1
	beq	L593
	brl	L10316
L593:
	pea	#<$0
	jsl	~~push_int
	brl	L10317
L10316:
	ldy	#$0
	lda	<L590+descriptor_1
	bpl	L594
	dey
L594:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L590+descriptor_1+4
	pei	<L590+descriptor_1+2
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	jsl	~~memmove
	lda	|~~basicvars+70
	sta	<R0
	lda	|~~basicvars+70+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$0
	ldy	<L590+descriptor_1
	sta	[<R0],Y
	rep	#$20
	longa	on
	lda	<L590+stringtype_1
	cmp	#<$5
	beq	L595
	brl	L10318
L595:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L590+descriptor_1
	sta	<R1
	lda	#$0
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
L10318:
	lda	#<L10314
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	pea	#0
	clc
	tdc
	adc	#<L590+intvalue_1
	pha
	pea	#0
	clc
	tdc
	adc	#<L590+isint_1
	pha
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	jsl	~~tonumber
	sta	<L590+cp_1
	stx	<L590+cp_1+2
	lda	<L590+cp_1
	ora	<L590+cp_1+2
	beq	L596
	brl	L10319
L596:
	pei	<L590+intvalue_1
	pea	#4
	jsl	~~error
L10319:
	lda	<L590+isint_1
	and	#$ff
	bne	L597
	brl	L10320
L597:
	pei	<L590+intvalue_1
	jsl	~~push_int
	brl	L10321
L10320:
	lda	|L10314+2
	pha
	lda	|L10314
	pha
	jsl	~~push_float
L10321:
L10317:
L598:
	pld
	tsc
	clc
	adc	#L589
	tcs
	rtl
L589	equ	23
L590	equ	9
	ends
	efunc
	code
	xdef	~~fn_vdu
	func
~~fn_vdu:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L599
	tcs
	phd
	tcd
variable_1	set	0
	inc	|~~basicvars+62
	bne	L601
	inc	|~~basicvars+62+2
L601:
	jsl	~~eval_intfactor
	sta	<L600+variable_1
	pei	<L600+variable_1
	jsl	~~emulate_vdufn
	pha
	jsl	~~push_int
L602:
	pld
	tsc
	clc
	adc	#L599
	tcs
	rtl
L599	equ	2
L600	equ	1
	ends
	efunc
	code
	func
~~fn_verify:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L603
	tcs
	phd
	tcd
stringtype_1	set	0
veritype_1	set	2
string_1	set	4
verify_1	set	10
start_1	set	16
n_1	set	18
present_1	set	20
	pea	#^$100
	pea	#<$100
	jsl	~~malloc
	sta	<L604+present_1
	stx	<L604+present_1+2
	jsl	~~expression
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L604+stringtype_1
	lda	<L604+stringtype_1
	cmp	#<$4
	bne	L605
	brl	L10322
L605:
	lda	<L604+stringtype_1
	cmp	#<$5
	bne	L606
	brl	L10322
L606:
	pea	#<$40
	pea	#4
	jsl	~~error
L10322:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L604+string_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$2c
	rep	#$20
	longa	on
	bne	L607
	brl	L10323
L607:
	pea	#<$27
	pea	#4
	jsl	~~error
L10323:
	inc	|~~basicvars+62
	bne	L608
	inc	|~~basicvars+62+2
L608:
	jsl	~~expression
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L604+veritype_1
	lda	<L604+veritype_1
	cmp	#<$4
	bne	L609
	brl	L10324
L609:
	lda	<L604+veritype_1
	cmp	#<$5
	bne	L610
	brl	L10324
L610:
	pea	#<$40
	pea	#4
	jsl	~~error
L10324:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L604+verify_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$2c
	rep	#$20
	longa	on
	beq	L611
	brl	L10325
L611:
	inc	|~~basicvars+62
	bne	L612
	inc	|~~basicvars+62+2
L612:
	jsl	~~eval_integer
	sta	<L604+start_1
	lda	<L604+start_1
	bmi	L613
	dea
	bmi	L613
	brl	L10326
L613:
	lda	#$1
	sta	<L604+start_1
L10326:
	brl	L10327
L10325:
	lda	#$1
	sta	<L604+start_1
L10327:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$29
	rep	#$20
	longa	on
	bne	L614
	brl	L10328
L614:
	pea	#<$29
	pea	#4
	jsl	~~error
L10328:
	inc	|~~basicvars+62
	bne	L615
	inc	|~~basicvars+62+2
L615:
	sec
	lda	<L604+string_1
	sbc	<L604+start_1
	bvs	L617
	eor	#$8000
L617:
	bmi	L618
	brl	L616
L618:
	lda	<L604+verify_1
	beq	L619
	brl	L10329
L619:
L616:
	lda	<L604+veritype_1
	cmp	#<$5
	beq	L620
	brl	L10330
L620:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L604+verify_1
	sta	<R1
	lda	#$0
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
L10330:
	lda	<L604+stringtype_1
	cmp	#<$5
	beq	L621
	brl	L10331
L621:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L604+string_1
	sta	<R1
	lda	#$0
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
L10331:
	lda	<L604+verify_1
	beq	L622
	brl	L10332
L622:
	pei	<L604+start_1
	jsl	~~push_int
	brl	L10333
L10332:
	pea	#<$0
	jsl	~~push_int
L10333:
L10329:
	pea	#^$4
	pea	#<$4
	pea	#<$0
	pei	<L604+present_1+2
	pei	<L604+present_1
	jsl	~~memset
	stz	<L604+n_1
	brl	L10337
L10336:
	ldy	<L604+n_1
	lda	[<L604+verify_1+2],Y
	and	#$ff
	sta	<R0
	sep	#$20
	longa	off
	lda	#$1
	ldy	<R0
	sta	[<L604+present_1],Y
	rep	#$20
	longa	on
L10334:
	inc	<L604+n_1
L10337:
	sec
	lda	<L604+n_1
	sbc	<L604+verify_1
	bvs	L623
	eor	#$8000
L623:
	bmi	L624
	brl	L10336
L624:
L10335:
	dec	<L604+start_1
L10338:
	sec
	lda	<L604+start_1
	sbc	<L604+string_1
	bvs	L625
	eor	#$8000
L625:
	bpl	L626
	brl	L10339
L626:
	ldy	<L604+start_1
	lda	[<L604+string_1+2],Y
	and	#$ff
	sta	<R0
	ldy	<R0
	lda	[<L604+present_1],Y
	and	#$ff
	bne	L627
	brl	L10339
L627:
	inc	<L604+start_1
	brl	L10338
L10339:
	lda	<L604+start_1
	cmp	<L604+string_1
	beq	L628
	brl	L10340
L628:
	pea	#<$0
	jsl	~~push_int
	brl	L10341
L10340:
	lda	<L604+start_1
	ina
	pha
	jsl	~~push_int
L10341:
	lda	<L604+veritype_1
	cmp	#<$5
	beq	L629
	brl	L10342
L629:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L604+verify_1
	sta	<R1
	lda	#$0
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
L10342:
	lda	<L604+stringtype_1
	cmp	#<$5
	beq	L630
	brl	L10343
L630:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L604+string_1
	sta	<R1
	lda	#$0
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
L10343:
	pei	<L604+present_1+2
	pei	<L604+present_1
	jsl	~~free
L631:
	pld
	tsc
	clc
	adc	#L603
	tcs
	rtl
L603	equ	32
L604	equ	9
	ends
	efunc
	code
	func
~~fn_vpos:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L632
	tcs
	phd
	tcd
	jsl	~~emulate_vpos
	pha
	jsl	~~push_int
L634:
	pld
	tsc
	clc
	adc	#L632
	tcs
	rtl
L632	equ	0
L633	equ	1
	ends
	efunc
	code
	xdef	~~fn_width
	func
~~fn_width:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L635
	tcs
	phd
	tcd
	inc	|~~basicvars+62
	bne	L637
	inc	|~~basicvars+62+2
L637:
	lda	|~~basicvars+496
	pha
	jsl	~~push_int
L638:
	pld
	tsc
	clc
	adc	#L635
	tcs
	rtl
L635	equ	0
L636	equ	1
	ends
	efunc
	code
	func
~~fn_xlatedol:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L639
	tcs
	phd
	tcd
stringtype_1	set	0
transtype_1	set	2
string_1	set	4
transtring_1	set	10
transarray_1	set	16
cp_1	set	20
n_1	set	24
ch_1	set	26
	jsl	~~expression
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L640+stringtype_1
	lda	<L640+stringtype_1
	cmp	#<$4
	bne	L641
	brl	L10344
L641:
	lda	<L640+stringtype_1
	cmp	#<$5
	bne	L642
	brl	L10344
L642:
	pea	#<$40
	pea	#4
	jsl	~~error
L10344:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L640+string_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$2c
	rep	#$20
	longa	on
	beq	L643
	brl	L10345
L643:
	inc	|~~basicvars+62
	bne	L644
	inc	|~~basicvars+62+2
L644:
	jsl	~~expression
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$29
	rep	#$20
	longa	on
	bne	L645
	brl	L10346
L645:
	pea	#<$29
	pea	#4
	jsl	~~error
L10346:
	inc	|~~basicvars+62
	bne	L646
	inc	|~~basicvars+62+2
L646:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L640+transtype_1
	lda	<L640+transtype_1
	cmp	#<$4
	bne	L648
	brl	L647
L648:
	lda	<L640+transtype_1
	cmp	#<$5
	beq	L649
	brl	L10347
L649:
L647:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L640+transtring_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	brl	L10348
L10347:
	lda	<L640+transtype_1
	cmp	#<$a
	beq	L650
	brl	L10349
L650:
	jsl	~~pop_array
	sta	<L640+transarray_1
	stx	<L640+transarray_1+2
	lda	[<L640+transarray_1]
	cmp	#<$1
	bne	L651
	brl	L10350
L651:
	pea	#<$4b
	pea	#4
	jsl	~~error
L10350:
	brl	L10351
L10349:
	pea	#<$40
	pea	#4
	jsl	~~error
L10351:
L10348:
	lda	<L640+string_1
	bne	L653
	brl	L652
L653:
	lda	<L640+transtype_1
	cmp	#<$a
	bne	L654
	brl	L10352
L654:
	lda	<L640+transtring_1
	beq	L655
	brl	L10352
L655:
L652:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L640+string_1
	sta	<R1
	lda	#$0
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~push_string
L656:
	pld
	tsc
	clc
	adc	#L639
	tcs
	rtl
L10352:
	lda	<L640+stringtype_1
	cmp	#<$4
	beq	L657
	brl	L10353
L657:
	pei	<L640+string_1
	jsl	~~alloc_string
	sta	<L640+cp_1
	stx	<L640+cp_1+2
	ldy	#$0
	lda	<L640+string_1
	bpl	L658
	dey
L658:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L640+string_1+4
	pei	<L640+string_1+2
	pei	<L640+cp_1+2
	pei	<L640+cp_1
	jsl	~~memmove
	brl	L10354
L10353:
	lda	<L640+string_1+2
	sta	<L640+cp_1
	lda	<L640+string_1+4
	sta	<L640+cp_1+2
L10354:
	lda	<L640+transtype_1
	cmp	#<$a
	beq	L659
	brl	L10355
L659:
highcode_2	set	27
arraybase_2	set	29
	ldy	#$8
	lda	[<L640+transarray_1],Y
	sta	<L640+highcode_2
	ldy	#$4
	lda	[<L640+transarray_1],Y
	sta	<L640+arraybase_2
	ldy	#$6
	lda	[<L640+transarray_1],Y
	sta	<L640+arraybase_2+2
	stz	<L640+n_1
	brl	L10359
L10358:
	sep	#$20
	longa	off
	ldy	<L640+n_1
	lda	[<L640+cp_1],Y
	sta	<L640+ch_1
	rep	#$20
	longa	on
	lda	<L640+ch_1
	and	#$ff
	sta	<R0
	sec
	lda	<R0
	sbc	<L640+highcode_2
	bvs	L660
	eor	#$8000
L660:
	bpl	L661
	brl	L10360
L661:
	lda	<L640+ch_1
	and	#$ff
	sta	<R0
	stz	<R0+2
	pea	#^$6
	pea	#<$6
	pei	<R0+2
	pei	<R0
	xref	~~~lmul
	jsl	~~~lmul
	sta	<R0
	stx	<R0+2
	clc
	lda	<L640+arraybase_2
	adc	<R0
	sta	<R1
	lda	<L640+arraybase_2+2
	adc	<R0+2
	sta	<R1+2
	sec
	lda	#$0
	sbc	[<R1]
	bvs	L662
	eor	#$8000
L662:
	bpl	L663
	brl	L10360
L663:
	lda	<L640+ch_1
	and	#$ff
	sta	<R0
	stz	<R0+2
	pea	#^$6
	pea	#<$6
	pei	<R0+2
	pei	<R0
	xref	~~~lmul
	jsl	~~~lmul
	sta	<R0
	stx	<R0+2
	clc
	lda	#$2
	adc	<L640+arraybase_2
	sta	<R1
	lda	#$0
	adc	<L640+arraybase_2+2
	sta	<R1+2
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	lda	<R1+2
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
	ldy	<L640+n_1
	sta	[<L640+cp_1],Y
	rep	#$20
	longa	on
L10360:
L10356:
	inc	<L640+n_1
L10359:
	sec
	lda	<L640+n_1
	sbc	<L640+string_1
	bvs	L664
	eor	#$8000
L664:
	bmi	L665
	brl	L10358
L665:
L10357:
	brl	L10361
L10355:
	stz	<L640+n_1
	brl	L10365
L10364:
	sep	#$20
	longa	off
	ldy	<L640+n_1
	lda	[<L640+cp_1],Y
	sta	<L640+ch_1
	rep	#$20
	longa	on
	lda	<L640+ch_1
	and	#$ff
	sta	<R0
	sec
	lda	<R0
	sbc	<L640+transtring_1
	bvs	L666
	eor	#$8000
L666:
	bpl	L667
	brl	L10366
L667:
	lda	<L640+ch_1
	and	#$ff
	sta	<R0
	sep	#$20
	longa	off
	ldy	<R0
	lda	[<L640+transtring_1+2],Y
	ldy	<L640+n_1
	sta	[<L640+cp_1],Y
	rep	#$20
	longa	on
L10366:
L10362:
	inc	<L640+n_1
L10365:
	sec
	lda	<L640+n_1
	sbc	<L640+string_1
	bvs	L668
	eor	#$8000
L668:
	bmi	L669
	brl	L10364
L669:
L10363:
	lda	<L640+transtype_1
	cmp	#<$5
	beq	L670
	brl	L10367
L670:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L640+transtring_1
	sta	<R1
	lda	#$0
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
L10367:
L10361:
	pei	<L640+cp_1+2
	pei	<L640+cp_1
	pei	<L640+string_1
	jsl	~~push_strtemp
	brl	L10368
L10345:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$29
	rep	#$20
	longa	on
	bne	L671
	brl	L10369
L671:
	pea	#<$29
	pea	#4
	jsl	~~error
	brl	L10370
L10369:
	inc	|~~basicvars+62
	bne	L672
	inc	|~~basicvars+62+2
L672:
	lda	<L640+string_1
	beq	L673
	brl	L10371
L673:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L640+string_1
	sta	<R1
	lda	#$0
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~push_string
	brl	L656
L10371:
	lda	<L640+stringtype_1
	cmp	#<$4
	beq	L674
	brl	L10372
L674:
	pei	<L640+string_1
	jsl	~~alloc_string
	sta	<L640+cp_1
	stx	<L640+cp_1+2
	ldy	#$0
	lda	<L640+string_1
	bpl	L675
	dey
L675:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L640+string_1+4
	pei	<L640+string_1+2
	pei	<L640+cp_1+2
	pei	<L640+cp_1
	jsl	~~memmove
	brl	L10373
L10372:
	lda	<L640+string_1+2
	sta	<L640+cp_1
	lda	<L640+string_1+4
	sta	<L640+cp_1+2
L10373:
	stz	<L640+n_1
	brl	L10377
L10376:
	sep	#$20
	longa	off
	ldy	<L640+n_1
	lda	[<L640+cp_1],Y
	cmp	#<$80
	rep	#$20
	longa	on
	bcc	L676
	brl	L10378
L676:
	ldy	<L640+n_1
	lda	[<L640+cp_1],Y
	and	#$ff
	pha
	jsl	~~tolower
	sep	#$20
	longa	off
	ldy	<L640+n_1
	sta	[<L640+cp_1],Y
	rep	#$20
	longa	on
L10378:
L10374:
	inc	<L640+n_1
L10377:
	sec
	lda	<L640+n_1
	sbc	<L640+string_1
	bvs	L677
	eor	#$8000
L677:
	bmi	L678
	brl	L10376
L678:
L10375:
	pei	<L640+cp_1+2
	pei	<L640+cp_1
	pei	<L640+string_1
	jsl	~~push_strtemp
L10370:
L10368:
	brl	L656
L639	equ	45
L640	equ	13
	ends
	efunc
	data
~~function_table:
	dl	~~bad_token
	dl	~~fn_himem
	dl	~~fn_ext
	dl	~~fn_filepath
	dl	~~fn_left
	dl	~~fn_lomem
	dl	~~fn_mid
	dl	~~fn_page
	dl	~~fn_ptr
	dl	~~fn_right
	dl	~~fn_time
	dl	~~fn_timedol
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~fn_abs
	dl	~~fn_acs
	dl	~~fn_adval
	dl	~~fn_argc
	dl	~~fn_argvdol
	dl	~~fn_asc
	dl	~~fn_asn
	dl	~~fn_atn
	dl	~~fn_beat
	dl	~~fn_bget
	dl	~~fn_chr
	dl	~~fn_cos
	dl	~~fn_count
	dl	~~fn_deg
	dl	~~fn_eof
	dl	~~fn_erl
	dl	~~fn_err
	dl	~~fn_eval
	dl	~~fn_exp
	dl	~~fn_get
	dl	~~fn_getdol
	dl	~~fn_inkey
	dl	~~fn_inkeydol
	dl	~~fn_instr
	dl	~~fn_int
	dl	~~fn_len
	dl	~~fn_listofn
	dl	~~fn_ln
	dl	~~fn_log
	dl	~~fn_openin
	dl	~~fn_openout
	dl	~~fn_openup
	dl	~~fn_pi
	dl	~~fn_pointfn
	dl	~~fn_pos
	dl	~~fn_rad
	dl	~~fn_reportdol
	dl	~~fn_retcode
	dl	~~fn_rnd
	dl	~~fn_sgn
	dl	~~fn_sin
	dl	~~fn_sqr
	dl	~~fn_str
	dl	~~fn_string
	dl	~~fn_sum
	dl	~~fn_tan
	dl	~~fn_tempofn
	dl	~~fn_usr
	dl	~~fn_val
	dl	~~fn_verify
	dl	~~fn_vpos
	dl	~~fn_xlatedol
	ends
	code
	xdef	~~exec_function
	func
~~exec_function:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L679
	tcs
	phd
	tcd
token_1	set	0
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<R0],Y
	sta	<L680+token_1
	rep	#$20
	longa	on
	clc
	lda	#$2
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L681
	inc	|~~basicvars+62+2
L681:
	sep	#$20
	longa	off
	lda	#$43
	cmp	<L680+token_1
	rep	#$20
	longa	on
	bcc	L682
	brl	L10379
L682:
	jsl	~~bad_token
L10379:
	lda	<L680+token_1
	and	#$ff
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~function_table
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	tax
	lda	(<R1)
	xref	~~~lcal
	jsl	~~~lcal
L683:
	pld
	tsc
	clc
	adc	#L679
	tcs
	rtl
L679	equ	9
L680	equ	9
	ends
	efunc
	code
	xdef	~~init_functions
	func
~~init_functions:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L684
	tcs
	phd
	tcd
	lda	#$5241
	sta	|~~lastrandom
	stz	|~~randomoverflow
L686:
	pld
	tsc
	clc
	adc	#L684
	tcs
	rtl
L684	equ	0
L685	equ	1
	ends
	efunc
	xref	~~fileio_getext
	xref	~~fileio_getptr
	xref	~~fileio_eof
	xref	~~fileio_getdol
	xref	~~fileio_bget
	xref	~~fileio_openup
	xref	~~fileio_openout
	xref	~~fileio_openin
	xref	~~restore_current
	xref	~~save_current
	xref	~~tocstring
	xref	~~emulate_tempofn
	xref	~~emulate_beatfn
	xref	~~emulate_adval
	xref	~~emulate_time
	xref	~~emulate_usr
	xref	~~emulate_pointfn
	xref	~~emulate_tintfn
	xref	~~emulate_colourfn
	xref	~~emulate_modefn
	xref	~~emulate_vpos
	xref	~~emulate_pos
	xref	~~emulate_vdufn
	xref	~~emulate_inkey
	xref	~~emulate_get
	xref	~~expression
	xref	~~get_lasterror
	xref	~~error
	xref	~~pop_array
	xref	~~pop_string
	xref	~~pop_float
	xref	~~pop_int
	xref	~~push_strtemp
	xref	~~push_string
	xref	~~push_float
	xref	~~push_int
	xref	~~tonumber
	xref	~~free_string
	xref	~~alloc_string
	xref	~~find_variable
	xref	~~get_srcaddr
	xref	~~set_address
	xref	~~skip_name
	xref	~~tokenize
	xref	~~tolower
	xref	~~localtime
	xref	~~time
	xref	~~strftime
	xref	~~floor
	xref	~~fabs
	xref	~~sqrt
	xref	~~log10
	xref	~~log
	xref	~~exp
	xref	~~atan
	xref	~~acos
	xref	~~asin
	xref	~~tan
	xref	~~cos
	xref	~~sin
	xref	~~memchr
	xref	~~strlen
	xref	~~memcpy
	xref	~~memcmp
	xref	~~memset
	xref	~~memmove
	xref	~~abs
	xref	~~free
	xref	~~malloc
	xref	~~sprintf
	udata
~~floatvalue
	ds	4
	ends
	udata
~~randomoverflow
	ds	2
	ends
	udata
~~lastrandom
	ds	2
	ends
	xref	~~factor_table
	xref	~~basicvars
	end
