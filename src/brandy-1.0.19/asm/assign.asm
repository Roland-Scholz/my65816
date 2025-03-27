;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
	code
	func
~~assignment_invalid:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
address_0	set	4
	pea	#^L1
	pea	#<L1
	pea	#<$39
	pea	#<$82
	pea	#10
	jsl	~~error
L4:
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
L2	equ	0
L3	equ	1
	ends
	efunc
	data
L1:
	db	$61,$73,$73,$69,$67,$6E,$00
	ends
	code
	func
~~assign_intword:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L6
	tcs
	phd
	tcd
address_0	set	4
exprtype_1	set	0
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	beq	L8
	brl	L10001
L8:
	pea	#<$5
	pea	#4
	jsl	~~error
L10001:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L7+exprtype_1
	lda	<L7+exprtype_1
	cmp	#<$2
	beq	L9
	brl	L10002
L9:
	jsl	~~pop_int
	sta	[<L6+address_0]
	brl	L10003
L10002:
	lda	<L7+exprtype_1
	cmp	#<$3
	beq	L10
	brl	L10004
L10:
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
	sta	[<L6+address_0]
	brl	L10005
L10004:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10005:
L10003:
L11:
	lda	<L6+2
	sta	<L6+2+4
	lda	<L6+1
	sta	<L6+1+4
	pld
	tsc
	clc
	adc	#L6+4
	tcs
	rtl
L6	equ	6
L7	equ	5
	ends
	efunc
	code
	func
~~assign_float:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L12
	tcs
	phd
	tcd
address_0	set	4
exprtype_1	set	0
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	beq	L14
	brl	L10006
L14:
	pea	#<$5
	pea	#4
	jsl	~~error
L10006:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L13+exprtype_1
	lda	<L13+exprtype_1
	cmp	#<$2
	beq	L15
	brl	L10007
L15:
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L16
	dey
L16:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	pla
	sta	[<L12+address_0]
	pla
	ldy	#$2
	sta	[<L12+address_0],Y
	brl	L10008
L10007:
	lda	<L13+exprtype_1
	cmp	#<$3
	beq	L17
	brl	L10009
L17:
	phy
	phy
	jsl	~~pop_float
	pla
	sta	[<L12+address_0]
	pla
	ldy	#$2
	sta	[<L12+address_0],Y
	brl	L10010
L10009:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10010:
L10008:
L18:
	lda	<L12+2
	sta	<L12+2+4
	lda	<L12+1
	sta	<L12+1+4
	pld
	tsc
	clc
	adc	#L12+4
	tcs
	rtl
L12	equ	6
L13	equ	5
	ends
	efunc
	code
	func
~~assign_stringdol:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L19
	tcs
	phd
	tcd
address_0	set	4
exprtype_1	set	0
result_1	set	2
lhstring_1	set	8
cp_1	set	12
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	beq	L21
	brl	L10011
L21:
	pea	#<$5
	pea	#4
	jsl	~~error
L10011:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L20+exprtype_1
	lda	<L20+exprtype_1
	cmp	#<$4
	bne	L22
	brl	L10012
L22:
	lda	<L20+exprtype_1
	cmp	#<$5
	bne	L23
	brl	L10012
L23:
	pea	#<$40
	pea	#4
	jsl	~~error
L10012:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L20+result_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	lda	<L19+address_0
	sta	<L20+lhstring_1
	lda	<L19+address_0+2
	sta	<L20+lhstring_1+2
	lda	<L20+exprtype_1
	cmp	#<$5
	beq	L24
	brl	L10013
L24:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	pei	<L20+lhstring_1+2
	pei	<L20+lhstring_1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
	clc
	tdc
	adc	#<L20+result_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L20+lhstring_1+2
	pei	<L20+lhstring_1
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	brl	L10014
L10013:
	ldy	#$2
	lda	[<L20+lhstring_1],Y
	cmp	<L20+result_1+2
	bne	L25
	ldy	#$4
	lda	[<L20+lhstring_1],Y
	cmp	<L20+result_1+4
L25:
	bne	L26
	brl	L10015
L26:
	pei	<L20+result_1
	jsl	~~alloc_string
	sta	<L20+cp_1
	stx	<L20+cp_1+2
	ldy	#$0
	lda	<L20+result_1
	bpl	L27
	dey
L27:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L20+result_1+4
	pei	<L20+result_1+2
	pei	<L20+cp_1+2
	pei	<L20+cp_1
	jsl	~~memmove
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	pei	<L20+lhstring_1+2
	pei	<L20+lhstring_1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
	lda	<L20+result_1
	sta	[<L20+lhstring_1]
	lda	<L20+cp_1
	ldy	#$2
	sta	[<L20+lhstring_1],Y
	lda	<L20+cp_1+2
	ldy	#$4
	sta	[<L20+lhstring_1],Y
L10015:
L10014:
L28:
	lda	<L19+2
	sta	<L19+2+4
	lda	<L19+1
	sta	<L19+1+4
	pld
	tsc
	clc
	adc	#L19+4
	tcs
	rtl
L19	equ	20
L20	equ	5
	ends
	efunc
	code
	func
~~assign_intbyteptr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L29
	tcs
	phd
	tcd
address_0	set	4
exprtype_1	set	0
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	beq	L31
	brl	L10016
L31:
	pea	#<$5
	pea	#4
	jsl	~~error
L10016:
	pea	#<$1
	pei	<L29+address_0
	jsl	~~check_write
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L30+exprtype_1
	lda	<L30+exprtype_1
	cmp	#<$2
	beq	L32
	brl	L10017
L32:
	lda	|~~basicvars+6
	sta	<R0
	lda	|~~basicvars+6+2
	sta	<R0+2
	jsl	~~pop_int
	sep	#$20
	longa	off
	ldy	<L29+address_0
	sta	[<R0],Y
	rep	#$20
	longa	on
	brl	L10018
L10017:
	lda	<L30+exprtype_1
	cmp	#<$3
	beq	L33
	brl	L10019
L33:
	lda	|~~basicvars+6
	sta	<R0
	lda	|~~basicvars+6+2
	sta	<R0+2
	phy
	phy
	jsl	~~pop_float
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R1
	pla
	sta	<R1+2
	sep	#$20
	longa	off
	lda	<R1
	ldy	<L29+address_0
	sta	[<R0],Y
	rep	#$20
	longa	on
	brl	L10020
L10019:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10020:
L10018:
L34:
	lda	<L29+2
	sta	<L29+2+4
	lda	<L29+1
	sta	<L29+1+4
	pld
	tsc
	clc
	adc	#L29+4
	tcs
	rtl
L29	equ	10
L30	equ	9
	ends
	efunc
	code
	func
~~assign_intwordptr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L35
	tcs
	phd
	tcd
address_0	set	4
exprtype_1	set	0
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	beq	L37
	brl	L10021
L37:
	pea	#<$5
	pea	#4
	jsl	~~error
L10021:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L36+exprtype_1
	lda	<L36+exprtype_1
	cmp	#<$2
	beq	L38
	brl	L10022
L38:
	jsl	~~pop_int
	pha
	pei	<L35+address_0
	jsl	~~store_integer
	brl	L10023
L10022:
	lda	<L36+exprtype_1
	cmp	#<$3
	beq	L39
	brl	L10024
L39:
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
	pei	<L35+address_0
	jsl	~~store_integer
	brl	L10025
L10024:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10025:
L10023:
L40:
	lda	<L35+2
	sta	<L35+2+4
	lda	<L35+1
	sta	<L35+1+4
	pld
	tsc
	clc
	adc	#L35+4
	tcs
	rtl
L35	equ	6
L36	equ	5
	ends
	efunc
	code
	func
~~assign_floatptr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L41
	tcs
	phd
	tcd
address_0	set	4
exprtype_1	set	0
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	beq	L43
	brl	L10026
L43:
	pea	#<$5
	pea	#4
	jsl	~~error
L10026:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L42+exprtype_1
	lda	<L42+exprtype_1
	cmp	#<$2
	beq	L44
	brl	L10027
L44:
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L45
	dey
L45:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	pei	<L41+address_0
	jsl	~~store_float
	brl	L10028
L10027:
	lda	<L42+exprtype_1
	cmp	#<$3
	beq	L46
	brl	L10029
L46:
	phy
	phy
	jsl	~~pop_float
	pei	<L41+address_0
	jsl	~~store_float
	brl	L10030
L10029:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10030:
L10028:
L47:
	lda	<L41+2
	sta	<L41+2+4
	lda	<L41+1
	sta	<L41+1+4
	pld
	tsc
	clc
	adc	#L41+4
	tcs
	rtl
L41	equ	6
L42	equ	5
	ends
	efunc
	code
	func
~~assign_dolstrptr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L48
	tcs
	phd
	tcd
address_0	set	4
exprtype_1	set	0
result_1	set	2
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	beq	L50
	brl	L10031
L50:
	pea	#<$5
	pea	#4
	jsl	~~error
L10031:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L49+exprtype_1
	lda	<L49+exprtype_1
	cmp	#<$4
	bne	L51
	brl	L10032
L51:
	lda	<L49+exprtype_1
	cmp	#<$5
	bne	L52
	brl	L10032
L52:
	pea	#<$40
	pea	#4
	jsl	~~error
L10032:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L49+result_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	pei	<L49+result_1
	pei	<L48+address_0
	jsl	~~check_write
	ldy	#$0
	lda	<L49+result_1
	bpl	L53
	dey
L53:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L49+result_1+4
	pei	<L49+result_1+2
	ldy	#$0
	lda	<L48+address_0
	bpl	L54
	dey
L54:
	sta	<R1
	sty	<R1+2
	clc
	lda	|~~basicvars+6
	adc	<R1
	sta	<R2
	lda	|~~basicvars+6+2
	adc	<R1+2
	sta	<R2+2
	pei	<R2+2
	pei	<R2
	jsl	~~memmove
	clc
	lda	<L48+address_0
	adc	<L49+result_1
	sta	<R0
	lda	|~~basicvars+6
	sta	<R1
	lda	|~~basicvars+6+2
	sta	<R1+2
	sep	#$20
	longa	off
	lda	#$d
	ldy	<R0
	sta	[<R1],Y
	rep	#$20
	longa	on
	lda	<L49+exprtype_1
	cmp	#<$5
	beq	L55
	brl	L10033
L55:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L49+result_1
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
L10033:
L56:
	lda	<L48+2
	sta	<L48+2+4
	lda	<L48+1
	sta	<L48+1+4
	pld
	tsc
	clc
	adc	#L48+4
	tcs
	rtl
L48	equ	20
L49	equ	13
	ends
	efunc
	code
	func
~~assign_intarray:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L57
	tcs
	phd
	tcd
address_0	set	4
ap_1	set	0
ap2_1	set	4
exprtype_1	set	8
n_1	set	10
value_1	set	12
p_1	set	14
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L58+exprtype_1
	lda	[<L57+address_0]
	sta	<L58+ap_1
	ldy	#$2
	lda	[<L57+address_0],Y
	sta	<L58+ap_1+2
	lda	<L58+ap_1
	ora	<L58+ap_1+2
	beq	L59
	brl	L10034
L59:
	pea	#^L5
	pea	#<L5
	pea	#<$1f
	pea	#8
	jsl	~~error
L10034:
	lda	<L58+exprtype_1
	cmp	#<$2
	bne	L61
	brl	L60
L61:
	lda	<L58+exprtype_1
	cmp	#<$3
	beq	L62
	brl	L10035
L62:
L60:
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
	brl	L10036
L63:
	ldy	#$4
	lda	[<L58+ap_1],Y
	sta	<L58+p_1
	ldy	#$6
	lda	[<L58+ap_1],Y
	sta	<L58+p_1+2
	stz	<L58+n_1
L10039:
	sec
	lda	<L58+n_1
	ldy	#$2
	sbc	[<L58+ap_1],Y
	bvs	L64
	eor	#$8000
L64:
	bmi	L65
	brl	L10040
L65:
	pea	#^L5+2
	pea	#<L5+2
	pei	<L58+n_1
	pea	#<$1c
	pea	#10
	jsl	~~error
L10040:
	ldy	#$0
	lda	<L58+n_1
	bpl	L66
	dey
L66:
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
	lda	<L58+p_1
	adc	<R0
	sta	<R2
	lda	<L58+p_1+2
	adc	<R0+2
	sta	<R2+2
	lda	<L58+exprtype_1
	cmp	#<$2
	beq	L68
	brl	L67
L68:
	jsl	~~pop_int
	bra	L69
L67:
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
L69:
	sta	[<R2]
	inc	<L58+n_1
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
	beq	L70
	brl	L10038
L70:
	inc	|~~basicvars+62
	bne	L71
	inc	|~~basicvars+62+2
L71:
	jsl	~~expression
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L58+exprtype_1
	lda	<L58+exprtype_1
	cmp	#<$2
	bne	L72
	brl	L10041
L72:
	lda	<L58+exprtype_1
	cmp	#<$3
	bne	L73
	brl	L10041
L73:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10041:
L10037:
	brl	L10039
L10038:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	beq	L74
	brl	L10042
L74:
	pea	#<$5
	pea	#4
	jsl	~~error
L10042:
	brl	L10043
L10036:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	beq	L75
	brl	L10044
L75:
	pea	#<$5
	pea	#4
	jsl	~~error
	brl	L10045
L10044:
	lda	<L58+exprtype_1
	cmp	#<$2
	beq	L77
	brl	L76
L77:
	jsl	~~pop_int
	bra	L78
L76:
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
L78:
	sta	<L58+value_1
	ldy	#$4
	lda	[<L58+ap_1],Y
	sta	<L58+p_1
	ldy	#$6
	lda	[<L58+ap_1],Y
	sta	<L58+p_1+2
	stz	<L58+n_1
	brl	L10049
L10048:
	ldy	#$0
	lda	<L58+n_1
	bpl	L79
	dey
L79:
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
	lda	<L58+p_1
	adc	<R0
	sta	<R2
	lda	<L58+p_1+2
	adc	<R0+2
	sta	<R2+2
	lda	<L58+value_1
	sta	[<R2]
L10046:
	inc	<L58+n_1
L10049:
	sec
	lda	<L58+n_1
	ldy	#$2
	sbc	[<L58+ap_1],Y
	bvs	L80
	eor	#$8000
L80:
	bmi	L81
	brl	L10048
L81:
L10047:
L10045:
L10043:
	brl	L10050
L10035:
	lda	<L58+exprtype_1
	cmp	#<$6
	beq	L82
	brl	L10051
L82:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	beq	L83
	brl	L10052
L83:
	pea	#<$5
	pea	#4
	jsl	~~error
L10052:
	jsl	~~pop_array
	sta	<L58+ap2_1
	stx	<L58+ap2_1+2
	lda	<L58+ap2_1
	ora	<L58+ap2_1+2
	beq	L84
	brl	L10053
L84:
	pea	#^L5+4
	pea	#<L5+4
	pea	#<$1f
	pea	#8
	jsl	~~error
L10053:
	pei	<L58+ap2_1+2
	pei	<L58+ap2_1
	pei	<L58+ap_1+2
	pei	<L58+ap_1
	jsl	~~check_arrays
	and	#$ff
	beq	L85
	brl	L10054
L85:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10054:
	lda	<L58+ap_1
	cmp	<L58+ap2_1
	bne	L86
	lda	<L58+ap_1+2
	cmp	<L58+ap2_1+2
L86:
	bne	L87
	brl	L10055
L87:
	ldy	#$0
	phy
	ldy	#$2
	lda	[<L58+ap_1],Y
	ply
	rol	A
	ror	A
	bpl	L88
	dey
L88:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	ldy	#$6
	lda	[<L58+ap2_1],Y
	pha
	ldy	#$4
	lda	[<L58+ap2_1],Y
	pha
	ldy	#$6
	lda	[<L58+ap_1],Y
	pha
	ldy	#$4
	lda	[<L58+ap_1],Y
	pha
	jsl	~~memmove
L10055:
	brl	L10056
L10051:
	lda	<L58+exprtype_1
	cmp	#<$7
	beq	L89
	brl	L10057
L89:
temp_2	set	18
	jsl	~~pop_arraytemp
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L58+temp_2
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$1c
	xref	~~~fmov
	jsl	~~~fmov
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	beq	L90
	brl	L10058
L90:
	pea	#<$5
	pea	#4
	jsl	~~error
L10058:
	pea	#0
	clc
	tdc
	adc	#<L58+temp_2
	pha
	pei	<L58+ap_1+2
	pei	<L58+ap_1
	jsl	~~check_arrays
	and	#$ff
	beq	L91
	brl	L10059
L91:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10059:
	ldy	#$0
	phy
	ldy	#$2
	lda	[<L58+ap_1],Y
	ply
	rol	A
	ror	A
	bpl	L92
	dey
L92:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L58+temp_2+6
	pei	<L58+temp_2+4
	ldy	#$6
	lda	[<L58+ap_1],Y
	pha
	ldy	#$4
	lda	[<L58+ap_1],Y
	pha
	jsl	~~memmove
	jsl	~~free_stackmem
	brl	L10060
L10057:
	lda	<L58+exprtype_1
	cmp	#<$8
	beq	L93
	brl	L10061
L93:
fp_3	set	18
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	beq	L94
	brl	L10062
L94:
	pea	#<$5
	pea	#4
	jsl	~~error
L10062:
	jsl	~~pop_array
	sta	<L58+ap2_1
	stx	<L58+ap2_1+2
	lda	<L58+ap2_1
	ora	<L58+ap2_1+2
	beq	L95
	brl	L10063
L95:
	pea	#^L5+6
	pea	#<L5+6
	pea	#<$1f
	pea	#8
	jsl	~~error
L10063:
	pei	<L58+ap2_1+2
	pei	<L58+ap2_1
	pei	<L58+ap_1+2
	pei	<L58+ap_1
	jsl	~~check_arrays
	and	#$ff
	beq	L96
	brl	L10064
L96:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10064:
	ldy	#$4
	lda	[<L58+ap_1],Y
	sta	<L58+p_1
	ldy	#$6
	lda	[<L58+ap_1],Y
	sta	<L58+p_1+2
	ldy	#$4
	lda	[<L58+ap2_1],Y
	sta	<L58+fp_3
	ldy	#$6
	lda	[<L58+ap2_1],Y
	sta	<L58+fp_3+2
	stz	<L58+n_1
	brl	L10068
L10067:
	ldy	#$0
	lda	<L58+n_1
	bpl	L97
	dey
L97:
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
	lda	<L58+p_1
	adc	<R0
	sta	<R2
	lda	<L58+p_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L58+n_1
	bpl	L98
	dey
L98:
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
	lda	<L58+fp_3
	adc	<R0
	sta	<17
	lda	<L58+fp_3+2
	adc	<R0+2
	sta	<17+2
	ldy	#$2
	lda	[<17],Y
	pha
	lda	[<17]
	pha
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R0
	pla
	sta	<R0+2
	lda	<R0
	sta	[<R2]
L10065:
	inc	<L58+n_1
L10068:
	sec
	lda	<L58+n_1
	ldy	#$2
	sbc	[<L58+ap_1],Y
	bvs	L99
	eor	#$8000
L99:
	bmi	L100
	brl	L10067
L100:
L10066:
	brl	L10069
L10061:
	lda	<L58+exprtype_1
	cmp	#<$9
	beq	L101
	brl	L10070
L101:
temp_4	set	18
fp_4	set	46
	jsl	~~pop_arraytemp
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L58+temp_4
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$1c
	xref	~~~fmov
	jsl	~~~fmov
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	beq	L102
	brl	L10071
L102:
	pea	#<$5
	pea	#4
	jsl	~~error
L10071:
	pea	#0
	clc
	tdc
	adc	#<L58+temp_4
	pha
	pei	<L58+ap_1+2
	pei	<L58+ap_1
	jsl	~~check_arrays
	and	#$ff
	beq	L103
	brl	L10072
L103:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10072:
	ldy	#$4
	lda	[<L58+ap_1],Y
	sta	<L58+p_1
	ldy	#$6
	lda	[<L58+ap_1],Y
	sta	<L58+p_1+2
	lda	<L58+temp_4+4
	sta	<L58+fp_4
	lda	<L58+temp_4+6
	sta	<L58+fp_4+2
	stz	<L58+n_1
	brl	L10076
L10075:
	ldy	#$0
	lda	<L58+n_1
	bpl	L104
	dey
L104:
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
	lda	<L58+p_1
	adc	<R0
	sta	<R2
	lda	<L58+p_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L58+n_1
	bpl	L105
	dey
L105:
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
	lda	<L58+fp_4
	adc	<R0
	sta	<17
	lda	<L58+fp_4+2
	adc	<R0+2
	sta	<17+2
	ldy	#$2
	lda	[<17],Y
	pha
	lda	[<17]
	pha
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R0
	pla
	sta	<R0+2
	lda	<R0
	sta	[<R2]
L10073:
	inc	<L58+n_1
L10076:
	sec
	lda	<L58+n_1
	ldy	#$2
	sbc	[<L58+ap_1],Y
	bvs	L106
	eor	#$8000
L106:
	bmi	L107
	brl	L10075
L107:
L10074:
	jsl	~~free_stackmem
	brl	L10077
L10070:
	pea	#<$47
	pea	#4
	jsl	~~error
L10077:
L10069:
L10060:
L10056:
L10050:
L108:
	lda	<L57+2
	sta	<L57+2+4
	lda	<L57+1
	sta	<L57+1+4
	pld
	tsc
	clc
	adc	#L57+4
	tcs
	rtl
L57	equ	70
L58	equ	21
	ends
	efunc
	data
L5:
	db	$28,$00,$28,$00,$28,$00,$28,$00
	ends
	code
	func
~~assign_floatarray:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L110
	tcs
	phd
	tcd
address_0	set	4
	udata
L10078:
	ds	4
	ends
ap_1	set	0
ap2_1	set	4
exprtype_1	set	8
n_1	set	10
p_1	set	12
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L111+exprtype_1
	lda	[<L110+address_0]
	sta	<L111+ap_1
	ldy	#$2
	lda	[<L110+address_0],Y
	sta	<L111+ap_1+2
	lda	<L111+ap_1
	ora	<L111+ap_1+2
	beq	L112
	brl	L10079
L112:
	pea	#^L109
	pea	#<L109
	pea	#<$1f
	pea	#8
	jsl	~~error
L10079:
	lda	<L111+exprtype_1
	cmp	#<$2
	bne	L114
	brl	L113
L114:
	lda	<L111+exprtype_1
	cmp	#<$3
	beq	L115
	brl	L10080
L115:
L113:
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
	beq	L116
	brl	L10081
L116:
	ldy	#$4
	lda	[<L111+ap_1],Y
	sta	<L111+p_1
	ldy	#$6
	lda	[<L111+ap_1],Y
	sta	<L111+p_1+2
	stz	<L111+n_1
L10084:
	sec
	lda	<L111+n_1
	ldy	#$2
	sbc	[<L111+ap_1],Y
	bvs	L117
	eor	#$8000
L117:
	bmi	L118
	brl	L10085
L118:
	pea	#^L109+2
	pea	#<L109+2
	pei	<L111+n_1
	pea	#<$1c
	pea	#10
	jsl	~~error
L10085:
	ldy	#$0
	lda	<L111+n_1
	bpl	L119
	dey
L119:
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
	lda	<L111+p_1
	adc	<R0
	sta	<R2
	lda	<L111+p_1+2
	adc	<R0+2
	sta	<R2+2
	lda	<L111+exprtype_1
	cmp	#<$2
	beq	L121
	brl	L120
L121:
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L122
	dey
L122:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	bra	L123
L120:
	phy
	phy
	jsl	~~pop_float
L123:
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
	inc	<L111+n_1
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
	beq	L124
	brl	L10083
L124:
	inc	|~~basicvars+62
	bne	L125
	inc	|~~basicvars+62+2
L125:
	jsl	~~expression
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L111+exprtype_1
	lda	<L111+exprtype_1
	cmp	#<$2
	bne	L126
	brl	L10086
L126:
	lda	<L111+exprtype_1
	cmp	#<$3
	bne	L127
	brl	L10086
L127:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10086:
L10082:
	brl	L10084
L10083:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	beq	L128
	brl	L10087
L128:
	pea	#<$5
	pea	#4
	jsl	~~error
L10087:
	brl	L10088
L10081:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	beq	L129
	brl	L10089
L129:
	pea	#<$5
	pea	#4
	jsl	~~error
	brl	L10090
L10089:
	lda	<L111+exprtype_1
	cmp	#<$2
	beq	L131
	brl	L130
L131:
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L132
	dey
L132:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	bra	L133
L130:
	phy
	phy
	jsl	~~pop_float
L133:
	pla
	sta	|L10078
	pla
	sta	|L10078+2
	ldy	#$4
	lda	[<L111+ap_1],Y
	sta	<L111+p_1
	ldy	#$6
	lda	[<L111+ap_1],Y
	sta	<L111+p_1+2
	stz	<L111+n_1
	brl	L10094
L10093:
	ldy	#$0
	lda	<L111+n_1
	bpl	L134
	dey
L134:
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
	lda	<L111+p_1
	adc	<R0
	sta	<R2
	lda	<L111+p_1+2
	adc	<R0+2
	sta	<R2+2
	lda	|L10078
	sta	[<R2]
	lda	|L10078+2
	ldy	#$2
	sta	[<R2],Y
L10091:
	inc	<L111+n_1
L10094:
	sec
	lda	<L111+n_1
	ldy	#$2
	sbc	[<L111+ap_1],Y
	bvs	L135
	eor	#$8000
L135:
	bmi	L136
	brl	L10093
L136:
L10092:
L10090:
L10088:
	brl	L10095
L10080:
	lda	<L111+exprtype_1
	cmp	#<$8
	beq	L137
	brl	L10096
L137:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	beq	L138
	brl	L10097
L138:
	pea	#<$5
	pea	#4
	jsl	~~error
L10097:
	jsl	~~pop_array
	sta	<L111+ap2_1
	stx	<L111+ap2_1+2
	lda	<L111+ap2_1
	ora	<L111+ap2_1+2
	beq	L139
	brl	L10098
L139:
	pea	#^L109+4
	pea	#<L109+4
	pea	#<$1f
	pea	#8
	jsl	~~error
L10098:
	pei	<L111+ap2_1+2
	pei	<L111+ap2_1
	pei	<L111+ap_1+2
	pei	<L111+ap_1
	jsl	~~check_arrays
	and	#$ff
	beq	L140
	brl	L10099
L140:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10099:
	lda	<L111+ap_1
	cmp	<L111+ap2_1
	bne	L141
	lda	<L111+ap_1+2
	cmp	<L111+ap2_1+2
L141:
	bne	L142
	brl	L10100
L142:
	ldy	#$0
	phy
	ldy	#$2
	lda	[<L111+ap_1],Y
	ply
	rol	A
	ror	A
	bpl	L143
	dey
L143:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$2
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	ldy	#$6
	lda	[<L111+ap2_1],Y
	pha
	ldy	#$4
	lda	[<L111+ap2_1],Y
	pha
	ldy	#$6
	lda	[<L111+ap_1],Y
	pha
	ldy	#$4
	lda	[<L111+ap_1],Y
	pha
	jsl	~~memmove
L10100:
	brl	L10101
L10096:
	lda	<L111+exprtype_1
	cmp	#<$9
	beq	L144
	brl	L10102
L144:
temp_2	set	16
	jsl	~~pop_arraytemp
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L111+temp_2
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$1c
	xref	~~~fmov
	jsl	~~~fmov
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	beq	L145
	brl	L10103
L145:
	pea	#<$5
	pea	#4
	jsl	~~error
L10103:
	pea	#0
	clc
	tdc
	adc	#<L111+temp_2
	pha
	pei	<L111+ap_1+2
	pei	<L111+ap_1
	jsl	~~check_arrays
	and	#$ff
	beq	L146
	brl	L10104
L146:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10104:
	ldy	#$0
	phy
	ldy	#$2
	lda	[<L111+ap_1],Y
	ply
	rol	A
	ror	A
	bpl	L147
	dey
L147:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$2
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L111+temp_2+6
	pei	<L111+temp_2+4
	ldy	#$6
	lda	[<L111+ap_1],Y
	pha
	ldy	#$4
	lda	[<L111+ap_1],Y
	pha
	jsl	~~memmove
	jsl	~~free_stackmem
	brl	L10105
L10102:
	lda	<L111+exprtype_1
	cmp	#<$6
	beq	L148
	brl	L10106
L148:
ip_3	set	16
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	beq	L149
	brl	L10107
L149:
	pea	#<$5
	pea	#4
	jsl	~~error
L10107:
	jsl	~~pop_array
	sta	<L111+ap2_1
	stx	<L111+ap2_1+2
	lda	<L111+ap2_1
	ora	<L111+ap2_1+2
	beq	L150
	brl	L10108
L150:
	pea	#^L109+6
	pea	#<L109+6
	pea	#<$1f
	pea	#8
	jsl	~~error
L10108:
	pei	<L111+ap2_1+2
	pei	<L111+ap2_1
	pei	<L111+ap_1+2
	pei	<L111+ap_1
	jsl	~~check_arrays
	and	#$ff
	beq	L151
	brl	L10109
L151:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10109:
	ldy	#$4
	lda	[<L111+ap_1],Y
	sta	<L111+p_1
	ldy	#$6
	lda	[<L111+ap_1],Y
	sta	<L111+p_1+2
	ldy	#$4
	lda	[<L111+ap2_1],Y
	sta	<L111+ip_3
	ldy	#$6
	lda	[<L111+ap2_1],Y
	sta	<L111+ip_3+2
	stz	<L111+n_1
	brl	L10113
L10112:
	ldy	#$0
	lda	<L111+n_1
	bpl	L152
	dey
L152:
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
	lda	<L111+p_1
	adc	<R0
	sta	<R2
	lda	<L111+p_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L111+n_1
	bpl	L153
	dey
L153:
	sta	<R3
	sty	<R3+2
	pei	<R3+2
	pei	<R3
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	lda	<L111+ip_3
	adc	<R0
	sta	<17
	lda	<L111+ip_3+2
	adc	<R0+2
	sta	<17+2
	ldy	#$0
	lda	[<17]
	bpl	L154
	dey
L154:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10110:
	inc	<L111+n_1
L10113:
	sec
	lda	<L111+n_1
	ldy	#$2
	sbc	[<L111+ap_1],Y
	bvs	L155
	eor	#$8000
L155:
	bmi	L156
	brl	L10112
L156:
L10111:
	brl	L10114
L10106:
	lda	<L111+exprtype_1
	cmp	#<$7
	beq	L157
	brl	L10115
L157:
temp_4	set	16
ip_4	set	44
	jsl	~~pop_arraytemp
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L111+temp_4
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$1c
	xref	~~~fmov
	jsl	~~~fmov
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	beq	L158
	brl	L10116
L158:
	pea	#<$5
	pea	#4
	jsl	~~error
L10116:
	pea	#0
	clc
	tdc
	adc	#<L111+temp_4
	pha
	pei	<L111+ap_1+2
	pei	<L111+ap_1
	jsl	~~check_arrays
	and	#$ff
	beq	L159
	brl	L10117
L159:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10117:
	ldy	#$4
	lda	[<L111+ap_1],Y
	sta	<L111+p_1
	ldy	#$6
	lda	[<L111+ap_1],Y
	sta	<L111+p_1+2
	lda	<L111+temp_4+4
	sta	<L111+ip_4
	lda	<L111+temp_4+6
	sta	<L111+ip_4+2
	stz	<L111+n_1
	brl	L10121
L10120:
	ldy	#$0
	lda	<L111+n_1
	bpl	L160
	dey
L160:
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
	lda	<L111+p_1
	adc	<R0
	sta	<R2
	lda	<L111+p_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L111+n_1
	bpl	L161
	dey
L161:
	sta	<R3
	sty	<R3+2
	pei	<R3+2
	pei	<R3
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	lda	<L111+ip_4
	adc	<R0
	sta	<17
	lda	<L111+ip_4+2
	adc	<R0+2
	sta	<17+2
	ldy	#$0
	lda	[<17]
	bpl	L162
	dey
L162:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10118:
	inc	<L111+n_1
L10121:
	sec
	lda	<L111+n_1
	ldy	#$2
	sbc	[<L111+ap_1],Y
	bvs	L163
	eor	#$8000
L163:
	bmi	L164
	brl	L10120
L164:
L10119:
	jsl	~~free_stackmem
	brl	L10122
L10115:
	pea	#<$48
	pea	#4
	jsl	~~error
L10122:
L10114:
L10105:
L10101:
L10095:
L165:
	lda	<L110+2
	sta	<L110+2+4
	lda	<L110+1
	sta	<L110+1+4
	pld
	tsc
	clc
	adc	#L110+4
	tcs
	rtl
L110	equ	68
L111	equ	21
	ends
	efunc
	data
L109:
	db	$28,$00,$28,$00,$28,$00,$28,$00
	ends
	code
	func
~~assign_strarray:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L167
	tcs
	phd
	tcd
address_0	set	4
exprtype_1	set	0
n_1	set	2
stringlen_1	set	4
ap_1	set	6
ap2_1	set	10
p_1	set	14
p2_1	set	18
stringvalue_1	set	22
stringaddr_1	set	28
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L168+exprtype_1
	lda	[<L167+address_0]
	sta	<L168+ap_1
	ldy	#$2
	lda	[<L167+address_0],Y
	sta	<L168+ap_1+2
	lda	<L168+ap_1
	ora	<L168+ap_1+2
	beq	L169
	brl	L10123
L169:
	pea	#^L166
	pea	#<L166
	pea	#<$1f
	pea	#8
	jsl	~~error
L10123:
	lda	<L168+exprtype_1
	cmp	#<$4
	bne	L171
	brl	L170
L171:
	lda	<L168+exprtype_1
	cmp	#<$5
	beq	L172
	brl	L10124
L172:
L170:
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
	beq	L173
	brl	L10125
L173:
	ldy	#$4
	lda	[<L168+ap_1],Y
	sta	<L168+p_1
	ldy	#$6
	lda	[<L168+ap_1],Y
	sta	<L168+p_1+2
	stz	<L168+n_1
L10128:
	sec
	lda	<L168+n_1
	ldy	#$2
	sbc	[<L168+ap_1],Y
	bvs	L174
	eor	#$8000
L174:
	bmi	L175
	brl	L10129
L175:
	pea	#^L166+2
	pea	#<L166+2
	pei	<L168+n_1
	pea	#<$1c
	pea	#10
	jsl	~~error
L10129:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L168+stringvalue_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	lda	<L168+stringvalue_1
	beq	L176
	brl	L10130
L176:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	pei	<L168+p_1+2
	pei	<L168+p_1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
	lda	#$0
	sta	[<L168+p_1]
	lda	|~~nullstring
	ldy	#$2
	sta	[<L168+p_1],Y
	lda	|~~nullstring+2
	ldy	#$4
	sta	[<L168+p_1],Y
	brl	L10131
L10130:
	lda	<L168+stringvalue_1
	sta	<L168+stringlen_1
	lda	<L168+exprtype_1
	cmp	#<$4
	beq	L177
	brl	L10132
L177:
	ldy	#$0
	lda	<L168+stringlen_1
	bpl	L178
	dey
L178:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L168+stringvalue_1+4
	pei	<L168+stringvalue_1+2
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	jsl	~~memmove
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	pei	<L168+p_1+2
	pei	<L168+p_1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
	lda	<L168+stringlen_1
	sta	[<L168+p_1]
	pei	<L168+stringlen_1
	jsl	~~alloc_string
	sta	<R0
	stx	<R0+2
	lda	<R0
	ldy	#$2
	sta	[<L168+p_1],Y
	lda	<R0+2
	ldy	#$4
	sta	[<L168+p_1],Y
	ldy	#$0
	lda	<L168+stringlen_1
	bpl	L179
	dey
L179:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	ldy	#$4
	lda	[<L168+p_1],Y
	pha
	ldy	#$2
	lda	[<L168+p_1],Y
	pha
	jsl	~~memmove
	brl	L10133
L10132:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	pei	<L168+p_1+2
	pei	<L168+p_1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
	lda	<L168+stringlen_1
	sta	[<L168+p_1]
	pei	<L168+stringlen_1
	jsl	~~alloc_string
	sta	<R0
	stx	<R0+2
	lda	<R0
	ldy	#$2
	sta	[<L168+p_1],Y
	lda	<R0+2
	ldy	#$4
	sta	[<L168+p_1],Y
	ldy	#$0
	lda	<L168+stringlen_1
	bpl	L180
	dey
L180:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L168+stringvalue_1+4
	pei	<L168+stringvalue_1+2
	ldy	#$4
	lda	[<L168+p_1],Y
	pha
	ldy	#$2
	lda	[<L168+p_1],Y
	pha
	jsl	~~memmove
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L168+stringvalue_1
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
L10133:
L10131:
	clc
	lda	#$6
	adc	<L168+p_1
	sta	<L168+p_1
	bcc	L181
	inc	<L168+p_1+2
L181:
	inc	<L168+n_1
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
	beq	L182
	brl	L10127
L182:
	inc	|~~basicvars+62
	bne	L183
	inc	|~~basicvars+62+2
L183:
	jsl	~~expression
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L168+exprtype_1
	lda	<L168+exprtype_1
	cmp	#<$4
	bne	L184
	brl	L10134
L184:
	lda	<L168+exprtype_1
	cmp	#<$5
	bne	L185
	brl	L10134
L185:
	pea	#<$40
	pea	#4
	jsl	~~error
L10134:
L10126:
	brl	L10128
L10127:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	beq	L186
	brl	L10135
L186:
	pea	#<$5
	pea	#4
	jsl	~~error
L10135:
	brl	L10136
L10125:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	beq	L187
	brl	L10137
L187:
	pea	#<$5
	pea	#4
	jsl	~~error
	brl	L10138
L10137:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L168+stringvalue_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	ldy	#$4
	lda	[<L168+ap_1],Y
	sta	<L168+p_1
	ldy	#$6
	lda	[<L168+ap_1],Y
	sta	<L168+p_1+2
	lda	<L168+stringvalue_1
	sta	<L168+stringlen_1
	lda	<L168+stringlen_1
	beq	L188
	brl	L10139
L188:
	stz	<L168+n_1
	brl	L10143
L10142:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	ldy	#$0
	lda	<L168+n_1
	bpl	L189
	dey
L189:
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
	lda	<L168+p_1
	adc	<R1
	sta	<R2
	lda	<L168+p_1+2
	adc	<R1+2
	sta	<R2+2
	pei	<R2+2
	pei	<R2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
	ldy	#$0
	lda	<L168+n_1
	bpl	L190
	dey
L190:
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
	lda	<L168+p_1
	adc	<R0
	sta	<R1
	lda	<L168+p_1+2
	adc	<R0+2
	sta	<R1+2
	lda	#$0
	sta	[<R1]
	ldy	#$0
	lda	<L168+n_1
	bpl	L191
	dey
L191:
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
	lda	#$2
	adc	<L168+p_1
	sta	<R1
	lda	#$0
	adc	<L168+p_1+2
	sta	<R1+2
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	lda	<R1+2
	adc	<R0+2
	sta	<R2+2
	lda	|~~nullstring
	sta	[<R2]
	lda	|~~nullstring+2
	ldy	#$2
	sta	[<R2],Y
L10140:
	inc	<L168+n_1
L10143:
	sec
	lda	<L168+n_1
	ldy	#$2
	sbc	[<L168+ap_1],Y
	bvs	L192
	eor	#$8000
L192:
	bmi	L193
	brl	L10142
L193:
L10141:
	brl	L10144
L10139:
	lda	<L168+exprtype_1
	cmp	#<$4
	beq	L194
	brl	L10145
L194:
	ldy	#$0
	lda	<L168+stringlen_1
	bpl	L195
	dey
L195:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L168+stringvalue_1+4
	pei	<L168+stringvalue_1+2
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	jsl	~~memmove
	lda	|~~basicvars+70
	sta	<L168+stringaddr_1
	lda	|~~basicvars+70+2
	sta	<L168+stringaddr_1+2
	brl	L10146
L10145:
	lda	<L168+stringvalue_1+2
	sta	<L168+stringaddr_1
	lda	<L168+stringvalue_1+4
	sta	<L168+stringaddr_1+2
L10146:
	stz	<L168+n_1
	brl	L10150
L10149:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	pei	<L168+p_1+2
	pei	<L168+p_1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
	lda	<L168+stringlen_1
	sta	[<L168+p_1]
	pei	<L168+stringlen_1
	jsl	~~alloc_string
	sta	<R0
	stx	<R0+2
	lda	<R0
	ldy	#$2
	sta	[<L168+p_1],Y
	lda	<R0+2
	ldy	#$4
	sta	[<L168+p_1],Y
	ldy	#$0
	lda	<L168+stringlen_1
	bpl	L196
	dey
L196:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L168+stringaddr_1+2
	pei	<L168+stringaddr_1
	ldy	#$4
	lda	[<L168+p_1],Y
	pha
	ldy	#$2
	lda	[<L168+p_1],Y
	pha
	jsl	~~memmove
	clc
	lda	#$6
	adc	<L168+p_1
	sta	<L168+p_1
	bcc	L197
	inc	<L168+p_1+2
L197:
L10147:
	inc	<L168+n_1
L10150:
	sec
	lda	<L168+n_1
	ldy	#$2
	sbc	[<L168+ap_1],Y
	bvs	L198
	eor	#$8000
L198:
	bmi	L199
	brl	L10149
L199:
L10148:
	lda	<L168+exprtype_1
	cmp	#<$5
	beq	L200
	brl	L10151
L200:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L168+stringvalue_1
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
L10151:
L10144:
L10138:
L10136:
	brl	L10152
L10124:
	lda	<L168+exprtype_1
	cmp	#<$a
	beq	L201
	brl	L10153
L201:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	beq	L202
	brl	L10154
L202:
	pea	#<$5
	pea	#4
	jsl	~~error
L10154:
	jsl	~~pop_array
	sta	<L168+ap2_1
	stx	<L168+ap2_1+2
	lda	<L168+ap_1
	cmp	<L168+ap2_1
	bne	L203
	lda	<L168+ap_1+2
	cmp	<L168+ap2_1+2
L203:
	bne	L204
	brl	L10155
L204:
	lda	<L168+ap2_1
	ora	<L168+ap2_1+2
	beq	L205
	brl	L10156
L205:
	pea	#^L166+4
	pea	#<L166+4
	pea	#<$1f
	pea	#8
	jsl	~~error
L10156:
	pei	<L168+ap2_1+2
	pei	<L168+ap2_1
	pei	<L168+ap_1+2
	pei	<L168+ap_1
	jsl	~~check_arrays
	and	#$ff
	beq	L206
	brl	L10157
L206:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10157:
	ldy	#$4
	lda	[<L168+ap_1],Y
	sta	<L168+p_1
	ldy	#$6
	lda	[<L168+ap_1],Y
	sta	<L168+p_1+2
	ldy	#$4
	lda	[<L168+ap2_1],Y
	sta	<L168+p2_1
	ldy	#$6
	lda	[<L168+ap2_1],Y
	sta	<L168+p2_1+2
	stz	<L168+n_1
	brl	L10161
L10160:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	pei	<L168+p_1+2
	pei	<L168+p_1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
	lda	[<L168+p2_1]
	sta	[<L168+p_1]
	lda	[<L168+p2_1]
	pha
	jsl	~~alloc_string
	sta	<R0
	stx	<R0+2
	lda	<R0
	ldy	#$2
	sta	[<L168+p_1],Y
	lda	<R0+2
	ldy	#$4
	sta	[<L168+p_1],Y
	ldy	#$0
	lda	[<L168+p2_1]
	bpl	L207
	dey
L207:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	ldy	#$4
	lda	[<L168+p2_1],Y
	pha
	ldy	#$2
	lda	[<L168+p2_1],Y
	pha
	ldy	#$4
	lda	[<L168+p_1],Y
	pha
	ldy	#$2
	lda	[<L168+p_1],Y
	pha
	jsl	~~memmove
	clc
	lda	#$6
	adc	<L168+p_1
	sta	<L168+p_1
	bcc	L208
	inc	<L168+p_1+2
L208:
	clc
	lda	#$6
	adc	<L168+p2_1
	sta	<L168+p2_1
	bcc	L209
	inc	<L168+p2_1+2
L209:
L10158:
	inc	<L168+n_1
L10161:
	sec
	lda	<L168+n_1
	ldy	#$2
	sbc	[<L168+ap_1],Y
	bvs	L210
	eor	#$8000
L210:
	bmi	L211
	brl	L10160
L211:
L10159:
L10155:
	brl	L10162
L10153:
	lda	<L168+exprtype_1
	cmp	#<$b
	beq	L212
	brl	L10163
L212:
temp_2	set	32
n_2	set	60
count_2	set	62
	jsl	~~pop_arraytemp
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L168+temp_2
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$1c
	xref	~~~fmov
	jsl	~~~fmov
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	beq	L213
	brl	L10164
L213:
	pea	#<$5
	pea	#4
	jsl	~~error
L10164:
	pea	#0
	clc
	tdc
	adc	#<L168+temp_2
	pha
	pei	<L168+ap_1+2
	pei	<L168+ap_1
	jsl	~~check_arrays
	and	#$ff
	beq	L214
	brl	L10165
L214:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10165:
	ldy	#$2
	lda	[<L168+ap_1],Y
	sta	<L168+count_2
	ldy	#$4
	lda	[<L168+ap_1],Y
	sta	<L168+p_1
	ldy	#$6
	lda	[<L168+ap_1],Y
	sta	<L168+p_1+2
	stz	<L168+n_2
	brl	L10169
L10168:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	ldy	#$0
	lda	<L168+n_2
	bpl	L215
	dey
L215:
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
	lda	<L168+p_1
	adc	<R1
	sta	<R2
	lda	<L168+p_1+2
	adc	<R1+2
	sta	<R2+2
	pei	<R2+2
	pei	<R2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
L10166:
	inc	<L168+n_2
L10169:
	sec
	lda	<L168+n_2
	sbc	<L168+count_2
	bvs	L216
	eor	#$8000
L216:
	bmi	L217
	brl	L10168
L217:
L10167:
	ldy	#$0
	lda	<L168+count_2
	bpl	L218
	dey
L218:
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
	pei	<R0+2
	pei	<R0
	pei	<L168+temp_2+6
	pei	<L168+temp_2+4
	pei	<L168+p_1+2
	pei	<L168+p_1
	jsl	~~memmove
	jsl	~~free_stackmem
	brl	L10170
L10163:
	pea	#<$49
	pea	#4
	jsl	~~error
L10170:
L10162:
L10152:
L219:
	lda	<L167+2
	sta	<L167+2+4
	lda	<L167+1
	sta	<L167+1+4
	pld
	tsc
	clc
	adc	#L167+4
	tcs
	rtl
L167	equ	76
L168	equ	13
	ends
	efunc
	data
L166:
	db	$28,$00,$28,$00,$28,$00
	ends
	code
	func
~~assiplus_intword:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L221
	tcs
	phd
	tcd
address_0	set	4
exprtype_1	set	0
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L222+exprtype_1
	lda	<L222+exprtype_1
	cmp	#<$2
	beq	L223
	brl	L10171
L223:
	jsl	~~pop_int
	sta	<R0
	clc
	lda	<R0
	adc	[<L221+address_0]
	sta	[<L221+address_0]
	brl	L10172
L10171:
	lda	<L222+exprtype_1
	cmp	#<$3
	beq	L224
	brl	L10173
L224:
	phy
	phy
	jsl	~~pop_float
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R0
	pla
	sta	<R0+2
	clc
	lda	<R0
	adc	[<L221+address_0]
	sta	[<L221+address_0]
	brl	L10174
L10173:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10174:
L10172:
L225:
	lda	<L221+2
	sta	<L221+2+4
	lda	<L221+1
	sta	<L221+1+4
	pld
	tsc
	clc
	adc	#L221+4
	tcs
	rtl
L221	equ	6
L222	equ	5
	ends
	efunc
	code
	func
~~assiplus_float:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L226
	tcs
	phd
	tcd
address_0	set	4
exprtype_1	set	0
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L227+exprtype_1
	lda	<L227+exprtype_1
	cmp	#<$2
	beq	L228
	brl	L10175
L228:
	ldy	#$2
	lda	[<L226+address_0],Y
	pha
	lda	[<L226+address_0]
	pha
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L229
	dey
L229:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~fadc
	jsl	~~~fadc
	pla
	sta	[<L226+address_0]
	pla
	ldy	#$2
	sta	[<L226+address_0],Y
	brl	L10176
L10175:
	lda	<L227+exprtype_1
	cmp	#<$3
	beq	L230
	brl	L10177
L230:
	ldy	#$2
	lda	[<L226+address_0],Y
	pha
	lda	[<L226+address_0]
	pha
	phy
	phy
	jsl	~~pop_float
	xref	~~~fadc
	jsl	~~~fadc
	pla
	sta	[<L226+address_0]
	pla
	ldy	#$2
	sta	[<L226+address_0],Y
	brl	L10178
L10177:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10178:
L10176:
L231:
	lda	<L226+2
	sta	<L226+2+4
	lda	<L226+1
	sta	<L226+1+4
	pld
	tsc
	clc
	adc	#L226+4
	tcs
	rtl
L226	equ	6
L227	equ	5
	ends
	efunc
	code
	func
~~assiplus_stringdol:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L232
	tcs
	phd
	tcd
address_0	set	4
exprtype_1	set	0
result_1	set	2
lhstring_1	set	8
extralen_1	set	12
newlen_1	set	14
cp_1	set	16
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L233+exprtype_1
	lda	<L233+exprtype_1
	cmp	#<$4
	bne	L234
	brl	L10179
L234:
	lda	<L233+exprtype_1
	cmp	#<$5
	bne	L235
	brl	L10179
L235:
	pea	#<$40
	pea	#4
	jsl	~~error
L10179:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L233+result_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	lda	<L233+result_1
	sta	<L233+extralen_1
	lda	<L233+extralen_1
	bne	L236
	brl	L10180
L236:
	lda	<L232+address_0
	sta	<L233+lhstring_1
	lda	<L232+address_0+2
	sta	<L233+lhstring_1+2
	clc
	lda	[<L233+lhstring_1]
	adc	<L233+extralen_1
	sta	<L233+newlen_1
	sec
	lda	#$1000
	sbc	<L233+newlen_1
	bvs	L237
	eor	#$8000
L237:
	bpl	L238
	brl	L10181
L238:
	pea	#<$3d
	pea	#4
	jsl	~~error
L10181:
	pei	<L233+newlen_1
	lda	[<L233+lhstring_1]
	pha
	ldy	#$4
	lda	[<L233+lhstring_1],Y
	pha
	ldy	#$2
	lda	[<L233+lhstring_1],Y
	pha
	jsl	~~resize_string
	sta	<L233+cp_1
	stx	<L233+cp_1+2
	ldy	#$0
	lda	<L233+extralen_1
	bpl	L239
	dey
L239:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L233+result_1+4
	pei	<L233+result_1+2
	ldy	#$0
	lda	[<L233+lhstring_1]
	bpl	L240
	dey
L240:
	sta	<R1
	sty	<R1+2
	clc
	lda	<L233+cp_1
	adc	<R1
	sta	<R2
	lda	<L233+cp_1+2
	adc	<R1+2
	sta	<R2+2
	pei	<R2+2
	pei	<R2
	jsl	~~memmove
	lda	<L233+newlen_1
	sta	[<L233+lhstring_1]
	lda	<L233+cp_1
	ldy	#$2
	sta	[<L233+lhstring_1],Y
	lda	<L233+cp_1+2
	ldy	#$4
	sta	[<L233+lhstring_1],Y
L10180:
	lda	<L233+exprtype_1
	cmp	#<$5
	beq	L241
	brl	L10182
L241:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L233+result_1
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
L10182:
L242:
	lda	<L232+2
	sta	<L232+2+4
	lda	<L232+1
	sta	<L232+1+4
	pld
	tsc
	clc
	adc	#L232+4
	tcs
	rtl
L232	equ	32
L233	equ	13
	ends
	efunc
	code
	func
~~assiplus_intbyteptr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L243
	tcs
	phd
	tcd
address_0	set	4
exprtype_1	set	0
	pea	#<$1
	pei	<L243+address_0
	jsl	~~check_write
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L244+exprtype_1
	lda	<L244+exprtype_1
	cmp	#<$2
	beq	L245
	brl	L10183
L245:
	ldy	#$0
	lda	<L243+address_0
	bpl	L246
	dey
L246:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars+6
	adc	<R0
	sta	<R1
	lda	|~~basicvars+6+2
	adc	<R0+2
	sta	<R1+2
	lda	[<R1]
	and	#$ff
	sta	<R0
	jsl	~~pop_int
	sta	<R2
	clc
	lda	<R2
	adc	<R0
	sta	<R3
	sep	#$20
	longa	off
	lda	<R3
	sta	[<R1]
	rep	#$20
	longa	on
	brl	L10184
L10183:
	lda	<L244+exprtype_1
	cmp	#<$3
	beq	L247
	brl	L10185
L247:
	ldy	#$0
	lda	<L243+address_0
	bpl	L248
	dey
L248:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars+6
	adc	<R0
	sta	<R1
	lda	|~~basicvars+6+2
	adc	<R0+2
	sta	<R1+2
	lda	[<R1]
	and	#$ff
	sta	<R0
	phy
	phy
	jsl	~~pop_float
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R2
	pla
	sta	<R2+2
	clc
	lda	<R2
	adc	<R0
	sta	<R3
	sep	#$20
	longa	off
	lda	<R3
	sta	[<R1]
	rep	#$20
	longa	on
	brl	L10186
L10185:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10186:
L10184:
L249:
	lda	<L243+2
	sta	<L243+2+4
	lda	<L243+1
	sta	<L243+1+4
	pld
	tsc
	clc
	adc	#L243+4
	tcs
	rtl
L243	equ	18
L244	equ	17
	ends
	efunc
	code
	func
~~assiplus_intwordptr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L250
	tcs
	phd
	tcd
address_0	set	4
exprtype_1	set	0
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L251+exprtype_1
	lda	<L251+exprtype_1
	cmp	#<$2
	beq	L252
	brl	L10187
L252:
	jsl	~~pop_int
	sta	<R0
	pei	<L250+address_0
	jsl	~~get_integer
	sta	<R1
	clc
	lda	<R1
	adc	<R0
	pha
	pei	<L250+address_0
	jsl	~~store_integer
	brl	L10188
L10187:
	lda	<L251+exprtype_1
	cmp	#<$3
	beq	L253
	brl	L10189
L253:
	phy
	phy
	jsl	~~pop_float
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R0
	pla
	sta	<R0+2
	pei	<L250+address_0
	jsl	~~get_integer
	sta	<R1
	clc
	lda	<R1
	adc	<R0
	pha
	pei	<L250+address_0
	jsl	~~store_integer
	brl	L10190
L10189:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10190:
L10188:
L254:
	lda	<L250+2
	sta	<L250+2+4
	lda	<L250+1
	sta	<L250+1+4
	pld
	tsc
	clc
	adc	#L250+4
	tcs
	rtl
L250	equ	10
L251	equ	9
	ends
	efunc
	code
	func
~~assiplus_floatptr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L255
	tcs
	phd
	tcd
address_0	set	4
exprtype_1	set	0
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L256+exprtype_1
	lda	<L256+exprtype_1
	cmp	#<$2
	beq	L257
	brl	L10191
L257:
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L258
	dey
L258:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	phy
	phy
	pei	<L255+address_0
	jsl	~~get_float
	xref	~~~fadc
	jsl	~~~fadc
	pei	<L255+address_0
	jsl	~~store_float
	brl	L10192
L10191:
	lda	<L256+exprtype_1
	cmp	#<$3
	beq	L259
	brl	L10193
L259:
	phy
	phy
	jsl	~~pop_float
	phy
	phy
	pei	<L255+address_0
	jsl	~~get_float
	xref	~~~fadc
	jsl	~~~fadc
	pei	<L255+address_0
	jsl	~~store_float
	brl	L10194
L10193:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10194:
L10192:
L260:
	lda	<L255+2
	sta	<L255+2+4
	lda	<L255+1
	sta	<L255+1+4
	pld
	tsc
	clc
	adc	#L255+4
	tcs
	rtl
L255	equ	6
L256	equ	5
	ends
	efunc
	code
	func
~~assiplus_dolstrptr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L261
	tcs
	phd
	tcd
address_0	set	4
exprtype_1	set	0
result_1	set	2
stringlen_1	set	8
endoff_1	set	10
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L262+exprtype_1
	lda	<L262+exprtype_1
	cmp	#<$4
	bne	L263
	brl	L10195
L263:
	lda	<L262+exprtype_1
	cmp	#<$5
	bne	L264
	brl	L10195
L264:
	pea	#<$40
	pea	#4
	jsl	~~error
L10195:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L262+result_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	lda	<L261+address_0
	sta	<L262+endoff_1
	stz	<L262+stringlen_1
L10196:
	sec
	lda	#$1000
	sbc	<L262+stringlen_1
	bvs	L265
	eor	#$8000
L265:
	bmi	L266
	brl	L10197
L266:
	lda	|~~basicvars+6
	sta	<R0
	lda	|~~basicvars+6+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	<L262+endoff_1
	lda	[<R0],Y
	cmp	#<$d
	rep	#$20
	longa	on
	bne	L267
	brl	L10197
L267:
	inc	<L262+endoff_1
	inc	<L262+stringlen_1
	brl	L10196
L10197:
	sec
	lda	#$1000
	sbc	<L262+stringlen_1
	bvs	L268
	eor	#$8000
L268:
	bpl	L269
	brl	L10198
L269:
	lda	<L261+address_0
	sta	<L262+endoff_1
L10198:
	pei	<L262+result_1
	pei	<L262+endoff_1
	jsl	~~check_write
	ldy	#$0
	lda	<L262+result_1
	bpl	L270
	dey
L270:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L262+result_1+4
	pei	<L262+result_1+2
	ldy	#$0
	lda	<L262+endoff_1
	bpl	L271
	dey
L271:
	sta	<R1
	sty	<R1+2
	clc
	lda	|~~basicvars+6
	adc	<R1
	sta	<R2
	lda	|~~basicvars+6+2
	adc	<R1+2
	sta	<R2+2
	pei	<R2+2
	pei	<R2
	jsl	~~memmove
	clc
	lda	<L262+endoff_1
	adc	<L262+result_1
	sta	<R0
	lda	|~~basicvars+6
	sta	<R1
	lda	|~~basicvars+6+2
	sta	<R1+2
	sep	#$20
	longa	off
	lda	#$d
	ldy	<R0
	sta	[<R1],Y
	rep	#$20
	longa	on
	lda	<L262+exprtype_1
	cmp	#<$5
	beq	L272
	brl	L10199
L272:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L262+result_1
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
L10199:
L273:
	lda	<L261+2
	sta	<L261+2+4
	lda	<L261+1
	sta	<L261+1+4
	pld
	tsc
	clc
	adc	#L261+4
	tcs
	rtl
L261	equ	24
L262	equ	13
	ends
	efunc
	code
	func
~~assiplus_intarray:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L274
	tcs
	phd
	tcd
address_0	set	4
exprtype_1	set	0
ap_1	set	2
ap2_1	set	6
p_1	set	10
p2_1	set	14
n_1	set	18
value_1	set	20
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L275+exprtype_1
	lda	[<L274+address_0]
	sta	<L275+ap_1
	ldy	#$2
	lda	[<L274+address_0],Y
	sta	<L275+ap_1+2
	lda	<L275+ap_1
	ora	<L275+ap_1+2
	beq	L276
	brl	L10200
L276:
	pea	#^L220
	pea	#<L220
	pea	#<$1f
	pea	#8
	jsl	~~error
L10200:
	lda	<L275+exprtype_1
	cmp	#<$2
	bne	L278
	brl	L277
L278:
	lda	<L275+exprtype_1
	cmp	#<$3
	beq	L279
	brl	L10201
L279:
L277:
	lda	<L275+exprtype_1
	cmp	#<$2
	beq	L281
	brl	L280
L281:
	jsl	~~pop_int
	bra	L282
L280:
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
L282:
	sta	<L275+value_1
	ldy	#$4
	lda	[<L275+ap_1],Y
	sta	<L275+p_1
	ldy	#$6
	lda	[<L275+ap_1],Y
	sta	<L275+p_1+2
	stz	<L275+n_1
	brl	L10205
L10204:
	ldy	#$0
	lda	<L275+n_1
	bpl	L283
	dey
L283:
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
	lda	<L275+p_1
	adc	<R0
	sta	<R2
	lda	<L275+p_1+2
	adc	<R0+2
	sta	<R2+2
	clc
	lda	[<R2]
	adc	<L275+value_1
	sta	[<R2]
L10202:
	inc	<L275+n_1
L10205:
	sec
	lda	<L275+n_1
	ldy	#$2
	sbc	[<L275+ap_1],Y
	bvs	L284
	eor	#$8000
L284:
	bmi	L285
	brl	L10204
L285:
L10203:
	brl	L10206
L10201:
	lda	<L275+exprtype_1
	cmp	#<$6
	beq	L286
	brl	L10207
L286:
	jsl	~~pop_array
	sta	<L275+ap2_1
	stx	<L275+ap2_1+2
	lda	<L275+ap2_1
	ora	<L275+ap2_1+2
	beq	L287
	brl	L10208
L287:
	pea	#^L220+2
	pea	#<L220+2
	pea	#<$1f
	pea	#8
	jsl	~~error
L10208:
	pei	<L275+ap2_1+2
	pei	<L275+ap2_1
	pei	<L275+ap_1+2
	pei	<L275+ap_1
	jsl	~~check_arrays
	and	#$ff
	beq	L288
	brl	L10209
L288:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10209:
	ldy	#$4
	lda	[<L275+ap_1],Y
	sta	<L275+p_1
	ldy	#$6
	lda	[<L275+ap_1],Y
	sta	<L275+p_1+2
	ldy	#$4
	lda	[<L275+ap2_1],Y
	sta	<L275+p2_1
	ldy	#$6
	lda	[<L275+ap2_1],Y
	sta	<L275+p2_1+2
	stz	<L275+n_1
	brl	L10213
L10212:
	ldy	#$0
	lda	<L275+n_1
	bpl	L289
	dey
L289:
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
	lda	<L275+p2_1
	adc	<R0
	sta	<R2
	lda	<L275+p2_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L275+n_1
	bpl	L290
	dey
L290:
	sta	<R3
	sty	<R3+2
	pei	<R3+2
	pei	<R3
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	lda	<L275+p_1
	adc	<R0
	sta	<17
	lda	<L275+p_1+2
	adc	<R0+2
	sta	<17+2
	clc
	lda	[<17]
	adc	[<R2]
	sta	[<17]
L10210:
	inc	<L275+n_1
L10213:
	sec
	lda	<L275+n_1
	ldy	#$2
	sbc	[<L275+ap_1],Y
	bvs	L291
	eor	#$8000
L291:
	bmi	L292
	brl	L10212
L292:
L10211:
	brl	L10214
L10207:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10214:
L10206:
L293:
	lda	<L274+2
	sta	<L274+2+4
	lda	<L274+1
	sta	<L274+1+4
	pld
	tsc
	clc
	adc	#L274+4
	tcs
	rtl
L274	equ	42
L275	equ	21
	ends
	efunc
	data
L220:
	db	$28,$00,$28,$00
	ends
	code
	func
~~assiplus_floatarray:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L295
	tcs
	phd
	tcd
address_0	set	4
	udata
L10215:
	ds	4
	ends
exprtype_1	set	0
ap_1	set	2
ap2_1	set	6
p_1	set	10
p2_1	set	14
n_1	set	18
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L296+exprtype_1
	lda	[<L295+address_0]
	sta	<L296+ap_1
	ldy	#$2
	lda	[<L295+address_0],Y
	sta	<L296+ap_1+2
	lda	<L296+ap_1
	ora	<L296+ap_1+2
	beq	L297
	brl	L10216
L297:
	pea	#^L294
	pea	#<L294
	pea	#<$1f
	pea	#8
	jsl	~~error
L10216:
	lda	<L296+exprtype_1
	cmp	#<$2
	bne	L299
	brl	L298
L299:
	lda	<L296+exprtype_1
	cmp	#<$3
	beq	L300
	brl	L10217
L300:
L298:
	lda	<L296+exprtype_1
	cmp	#<$2
	beq	L302
	brl	L301
L302:
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L303
	dey
L303:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	bra	L304
L301:
	phy
	phy
	jsl	~~pop_float
L304:
	pla
	sta	|L10215
	pla
	sta	|L10215+2
	ldy	#$4
	lda	[<L296+ap_1],Y
	sta	<L296+p_1
	ldy	#$6
	lda	[<L296+ap_1],Y
	sta	<L296+p_1+2
	stz	<L296+n_1
	brl	L10221
L10220:
	ldy	#$0
	lda	<L296+n_1
	bpl	L305
	dey
L305:
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
	lda	<L296+p_1
	adc	<R0
	sta	<R2
	lda	<L296+p_1+2
	adc	<R0+2
	sta	<R2+2
	lda	|L10215+2
	pha
	lda	|L10215
	pha
	ldy	#$2
	lda	[<R2],Y
	pha
	lda	[<R2]
	pha
	xref	~~~fadc
	jsl	~~~fadc
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10218:
	inc	<L296+n_1
L10221:
	sec
	lda	<L296+n_1
	ldy	#$2
	sbc	[<L296+ap_1],Y
	bvs	L306
	eor	#$8000
L306:
	bmi	L307
	brl	L10220
L307:
L10219:
	brl	L10222
L10217:
	lda	<L296+exprtype_1
	cmp	#<$8
	beq	L308
	brl	L10223
L308:
	jsl	~~pop_array
	sta	<L296+ap2_1
	stx	<L296+ap2_1+2
	lda	<L296+ap2_1
	ora	<L296+ap2_1+2
	beq	L309
	brl	L10224
L309:
	pea	#^L294+2
	pea	#<L294+2
	pea	#<$1f
	pea	#8
	jsl	~~error
L10224:
	pei	<L296+ap2_1+2
	pei	<L296+ap2_1
	pei	<L296+ap_1+2
	pei	<L296+ap_1
	jsl	~~check_arrays
	and	#$ff
	beq	L310
	brl	L10225
L310:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10225:
	ldy	#$4
	lda	[<L296+ap_1],Y
	sta	<L296+p_1
	ldy	#$6
	lda	[<L296+ap_1],Y
	sta	<L296+p_1+2
	ldy	#$4
	lda	[<L296+ap2_1],Y
	sta	<L296+p2_1
	ldy	#$6
	lda	[<L296+ap2_1],Y
	sta	<L296+p2_1+2
	stz	<L296+n_1
	brl	L10229
L10228:
	ldy	#$0
	lda	<L296+n_1
	bpl	L311
	dey
L311:
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
	lda	<L296+p_1
	adc	<R0
	sta	<R2
	lda	<L296+p_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L296+n_1
	bpl	L312
	dey
L312:
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
	lda	<L296+p2_1
	adc	<R0
	sta	<17
	lda	<L296+p2_1+2
	adc	<R0+2
	sta	<17+2
	ldy	#$2
	lda	[<17],Y
	pha
	lda	[<17]
	pha
	ldy	#$2
	lda	[<R2],Y
	pha
	lda	[<R2]
	pha
	xref	~~~fadc
	jsl	~~~fadc
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10226:
	inc	<L296+n_1
L10229:
	sec
	lda	<L296+n_1
	ldy	#$2
	sbc	[<L296+ap_1],Y
	bvs	L313
	eor	#$8000
L313:
	bmi	L314
	brl	L10228
L314:
L10227:
	brl	L10230
L10223:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10230:
L10222:
L315:
	lda	<L295+2
	sta	<L295+2+4
	lda	<L295+1
	sta	<L295+1+4
	pld
	tsc
	clc
	adc	#L295+4
	tcs
	rtl
L295	equ	40
L296	equ	21
	ends
	efunc
	data
L294:
	db	$28,$00,$28,$00
	ends
	code
	func
~~assiplus_strarray:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L317
	tcs
	phd
	tcd
address_0	set	4
exprtype_1	set	0
ap_1	set	2
ap2_1	set	6
p_1	set	10
p2_1	set	14
n_1	set	18
stringlen_1	set	20
stringaddr_1	set	22
cp_1	set	26
stringvalue_1	set	30
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L318+exprtype_1
	lda	[<L317+address_0]
	sta	<L318+ap_1
	ldy	#$2
	lda	[<L317+address_0],Y
	sta	<L318+ap_1+2
	lda	<L318+ap_1
	ora	<L318+ap_1+2
	beq	L319
	brl	L10231
L319:
	pea	#^L316
	pea	#<L316
	pea	#<$1f
	pea	#8
	jsl	~~error
L10231:
	lda	<L318+exprtype_1
	cmp	#<$4
	bne	L321
	brl	L320
L321:
	lda	<L318+exprtype_1
	cmp	#<$5
	beq	L322
	brl	L10232
L322:
L320:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L318+stringvalue_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	lda	<L318+stringvalue_1
	sta	<L318+stringlen_1
	sec
	lda	#$0
	sbc	<L318+stringlen_1
	bvs	L323
	eor	#$8000
L323:
	bpl	L324
	brl	L10233
L324:
	ldy	#$4
	lda	[<L318+ap_1],Y
	sta	<L318+p_1
	ldy	#$6
	lda	[<L318+ap_1],Y
	sta	<L318+p_1+2
	lda	<L318+exprtype_1
	cmp	#<$4
	beq	L325
	brl	L10234
L325:
	ldy	#$0
	lda	<L318+stringlen_1
	bpl	L326
	dey
L326:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L318+stringvalue_1+4
	pei	<L318+stringvalue_1+2
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	jsl	~~memmove
	lda	|~~basicvars+70
	sta	<L318+stringaddr_1
	lda	|~~basicvars+70+2
	sta	<L318+stringaddr_1+2
	brl	L10235
L10234:
	lda	<L318+stringvalue_1+2
	sta	<L318+stringaddr_1
	lda	<L318+stringvalue_1+4
	sta	<L318+stringaddr_1+2
L10235:
	stz	<L318+n_1
	brl	L10239
L10238:
	clc
	lda	[<L318+p_1]
	adc	<L318+stringlen_1
	sta	<R0
	sec
	lda	#$1000
	sbc	<R0
	bvs	L327
	eor	#$8000
L327:
	bpl	L328
	brl	L10240
L328:
	pea	#<$3d
	pea	#4
	jsl	~~error
L10240:
	clc
	lda	[<L318+p_1]
	adc	<L318+stringlen_1
	pha
	lda	[<L318+p_1]
	pha
	ldy	#$4
	lda	[<L318+p_1],Y
	pha
	ldy	#$2
	lda	[<L318+p_1],Y
	pha
	jsl	~~resize_string
	sta	<L318+cp_1
	stx	<L318+cp_1+2
	ldy	#$0
	lda	<L318+stringlen_1
	bpl	L329
	dey
L329:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L318+stringaddr_1+2
	pei	<L318+stringaddr_1
	ldy	#$0
	lda	[<L318+p_1]
	bpl	L330
	dey
L330:
	sta	<R1
	sty	<R1+2
	clc
	lda	<L318+cp_1
	adc	<R1
	sta	<R2
	lda	<L318+cp_1+2
	adc	<R1+2
	sta	<R2+2
	pei	<R2+2
	pei	<R2
	jsl	~~memmove
	clc
	lda	[<L318+p_1]
	adc	<L318+stringlen_1
	sta	[<L318+p_1]
	lda	<L318+cp_1
	ldy	#$2
	sta	[<L318+p_1],Y
	lda	<L318+cp_1+2
	ldy	#$4
	sta	[<L318+p_1],Y
	clc
	lda	#$6
	adc	<L318+p_1
	sta	<L318+p_1
	bcc	L331
	inc	<L318+p_1+2
L331:
L10236:
	inc	<L318+n_1
L10239:
	sec
	lda	<L318+n_1
	ldy	#$2
	sbc	[<L318+ap_1],Y
	bvs	L332
	eor	#$8000
L332:
	bmi	L333
	brl	L10238
L333:
L10237:
	lda	<L318+exprtype_1
	cmp	#<$5
	beq	L334
	brl	L10241
L334:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L318+stringvalue_1
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
L10241:
L10233:
	brl	L10242
L10232:
	lda	<L318+exprtype_1
	cmp	#<$a
	beq	L335
	brl	L10243
L335:
	jsl	~~pop_array
	sta	<L318+ap2_1
	stx	<L318+ap2_1+2
	lda	<L318+ap2_1
	ora	<L318+ap2_1+2
	beq	L336
	brl	L10244
L336:
	pea	#^L316+2
	pea	#<L316+2
	pea	#<$1f
	pea	#8
	jsl	~~error
L10244:
	pei	<L318+ap2_1+2
	pei	<L318+ap2_1
	pei	<L318+ap_1+2
	pei	<L318+ap_1
	jsl	~~check_arrays
	and	#$ff
	beq	L337
	brl	L10245
L337:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10245:
	ldy	#$4
	lda	[<L318+ap_1],Y
	sta	<L318+p_1
	ldy	#$6
	lda	[<L318+ap_1],Y
	sta	<L318+p_1+2
	ldy	#$4
	lda	[<L318+ap2_1],Y
	sta	<L318+p2_1
	ldy	#$6
	lda	[<L318+ap2_1],Y
	sta	<L318+p2_1+2
	stz	<L318+n_1
	brl	L10249
L10248:
	lda	[<L318+p2_1]
	sta	<L318+stringlen_1
	sec
	lda	#$0
	sbc	<L318+stringlen_1
	bvs	L338
	eor	#$8000
L338:
	bpl	L339
	brl	L10250
L339:
	clc
	lda	[<L318+p_1]
	adc	<L318+stringlen_1
	sta	<R0
	sec
	lda	#$1000
	sbc	<R0
	bvs	L340
	eor	#$8000
L340:
	bpl	L341
	brl	L10251
L341:
	pea	#<$3d
	pea	#4
	jsl	~~error
L10251:
	ldy	#$0
	lda	<L318+stringlen_1
	bpl	L342
	dey
L342:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	ldy	#$4
	lda	[<L318+p2_1],Y
	pha
	ldy	#$2
	lda	[<L318+p2_1],Y
	pha
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	jsl	~~memmove
	clc
	lda	[<L318+p_1]
	adc	<L318+stringlen_1
	pha
	lda	[<L318+p_1]
	pha
	ldy	#$4
	lda	[<L318+p_1],Y
	pha
	ldy	#$2
	lda	[<L318+p_1],Y
	pha
	jsl	~~resize_string
	sta	<L318+cp_1
	stx	<L318+cp_1+2
	ldy	#$0
	lda	<L318+stringlen_1
	bpl	L343
	dey
L343:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	ldy	#$0
	lda	[<L318+p_1]
	bpl	L344
	dey
L344:
	sta	<R1
	sty	<R1+2
	clc
	lda	<L318+cp_1
	adc	<R1
	sta	<R2
	lda	<L318+cp_1+2
	adc	<R1+2
	sta	<R2+2
	pei	<R2+2
	pei	<R2
	jsl	~~memmove
	clc
	lda	[<L318+p_1]
	adc	<L318+stringlen_1
	sta	[<L318+p_1]
	lda	<L318+cp_1
	ldy	#$2
	sta	[<L318+p_1],Y
	lda	<L318+cp_1+2
	ldy	#$4
	sta	[<L318+p_1],Y
L10250:
	clc
	lda	#$6
	adc	<L318+p_1
	sta	<L318+p_1
	bcc	L345
	inc	<L318+p_1+2
L345:
	clc
	lda	#$6
	adc	<L318+p2_1
	sta	<L318+p2_1
	bcc	L346
	inc	<L318+p2_1+2
L346:
L10246:
	inc	<L318+n_1
L10249:
	sec
	lda	<L318+n_1
	ldy	#$2
	sbc	[<L318+ap_1],Y
	bvs	L347
	eor	#$8000
L347:
	bmi	L348
	brl	L10248
L348:
L10247:
	brl	L10252
L10243:
	pea	#<$40
	pea	#4
	jsl	~~error
L10252:
L10242:
L349:
	lda	<L317+2
	sta	<L317+2+4
	lda	<L317+1
	sta	<L317+1+4
	pld
	tsc
	clc
	adc	#L317+4
	tcs
	rtl
L317	equ	48
L318	equ	13
	ends
	efunc
	data
L316:
	db	$28,$00,$28,$00
	ends
	code
	func
~~assiminus_intword:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L351
	tcs
	phd
	tcd
address_0	set	4
exprtype_1	set	0
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L352+exprtype_1
	lda	<L352+exprtype_1
	cmp	#<$2
	beq	L353
	brl	L10253
L353:
	jsl	~~pop_int
	sta	<R0
	sec
	lda	[<L351+address_0]
	sbc	<R0
	sta	[<L351+address_0]
	brl	L10254
L10253:
	lda	<L352+exprtype_1
	cmp	#<$3
	beq	L354
	brl	L10255
L354:
	phy
	phy
	jsl	~~pop_float
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R0
	pla
	sta	<R0+2
	sec
	lda	[<L351+address_0]
	sbc	<R0
	sta	[<L351+address_0]
	brl	L10256
L10255:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10256:
L10254:
L355:
	lda	<L351+2
	sta	<L351+2+4
	lda	<L351+1
	sta	<L351+1+4
	pld
	tsc
	clc
	adc	#L351+4
	tcs
	rtl
L351	equ	6
L352	equ	5
	ends
	efunc
	code
	func
~~assiminus_float:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L356
	tcs
	phd
	tcd
address_0	set	4
exprtype_1	set	0
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L357+exprtype_1
	lda	<L357+exprtype_1
	cmp	#<$2
	beq	L358
	brl	L10257
L358:
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L359
	dey
L359:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	ldy	#$2
	lda	[<L356+address_0],Y
	pha
	lda	[<L356+address_0]
	pha
	xref	~~~fsbc
	jsl	~~~fsbc
	pla
	sta	[<L356+address_0]
	pla
	ldy	#$2
	sta	[<L356+address_0],Y
	brl	L10258
L10257:
	lda	<L357+exprtype_1
	cmp	#<$3
	beq	L360
	brl	L10259
L360:
	phy
	phy
	jsl	~~pop_float
	ldy	#$2
	lda	[<L356+address_0],Y
	pha
	lda	[<L356+address_0]
	pha
	xref	~~~fsbc
	jsl	~~~fsbc
	pla
	sta	[<L356+address_0]
	pla
	ldy	#$2
	sta	[<L356+address_0],Y
	brl	L10260
L10259:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10260:
L10258:
L361:
	lda	<L356+2
	sta	<L356+2+4
	lda	<L356+1
	sta	<L356+1+4
	pld
	tsc
	clc
	adc	#L356+4
	tcs
	rtl
L356	equ	6
L357	equ	5
	ends
	efunc
	code
	func
~~assiminus_intbyteptr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L362
	tcs
	phd
	tcd
address_0	set	4
exprtype_1	set	0
	pea	#<$1
	pei	<L362+address_0
	jsl	~~check_write
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L363+exprtype_1
	lda	<L363+exprtype_1
	cmp	#<$2
	beq	L364
	brl	L10261
L364:
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<L362+address_0
	bpl	L365
	dey
L365:
	sta	<R1
	sty	<R1+2
	clc
	lda	|~~basicvars+6
	adc	<R1
	sta	<R2
	lda	|~~basicvars+6+2
	adc	<R1+2
	sta	<R2+2
	lda	[<R2]
	and	#$ff
	sta	<R1
	sec
	lda	<R1
	sbc	<R0
	sta	<R3
	sep	#$20
	longa	off
	lda	<R3
	sta	[<R2]
	rep	#$20
	longa	on
	brl	L10262
L10261:
	lda	<L363+exprtype_1
	cmp	#<$3
	beq	L366
	brl	L10263
L366:
	phy
	phy
	jsl	~~pop_float
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R0
	pla
	sta	<R0+2
	ldy	#$0
	lda	<L362+address_0
	bpl	L367
	dey
L367:
	sta	<R1
	sty	<R1+2
	clc
	lda	|~~basicvars+6
	adc	<R1
	sta	<R2
	lda	|~~basicvars+6+2
	adc	<R1+2
	sta	<R2+2
	lda	[<R2]
	and	#$ff
	sta	<R1
	sec
	lda	<R1
	sbc	<R0
	sta	<R3
	sep	#$20
	longa	off
	lda	<R3
	sta	[<R2]
	rep	#$20
	longa	on
	brl	L10264
L10263:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10264:
L10262:
L368:
	lda	<L362+2
	sta	<L362+2+4
	lda	<L362+1
	sta	<L362+1+4
	pld
	tsc
	clc
	adc	#L362+4
	tcs
	rtl
L362	equ	18
L363	equ	17
	ends
	efunc
	code
	func
~~assiminus_intwordptr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L369
	tcs
	phd
	tcd
address_0	set	4
exprtype_1	set	0
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L370+exprtype_1
	lda	<L370+exprtype_1
	cmp	#<$2
	beq	L371
	brl	L10265
L371:
	jsl	~~pop_int
	sta	<R0
	pei	<L369+address_0
	jsl	~~get_integer
	sta	<R1
	sec
	lda	<R1
	sbc	<R0
	pha
	pei	<L369+address_0
	jsl	~~store_integer
	brl	L10266
L10265:
	lda	<L370+exprtype_1
	cmp	#<$3
	beq	L372
	brl	L10267
L372:
	phy
	phy
	jsl	~~pop_float
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R0
	pla
	sta	<R0+2
	pei	<L369+address_0
	jsl	~~get_integer
	sta	<R1
	sec
	lda	<R1
	sbc	<R0
	pha
	pei	<L369+address_0
	jsl	~~store_integer
	brl	L10268
L10267:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10268:
L10266:
L373:
	lda	<L369+2
	sta	<L369+2+4
	lda	<L369+1
	sta	<L369+1+4
	pld
	tsc
	clc
	adc	#L369+4
	tcs
	rtl
L369	equ	10
L370	equ	9
	ends
	efunc
	code
	func
~~assiminus_floatptr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L374
	tcs
	phd
	tcd
address_0	set	4
exprtype_1	set	0
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L375+exprtype_1
	lda	<L375+exprtype_1
	cmp	#<$2
	beq	L376
	brl	L10269
L376:
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L377
	dey
L377:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	phy
	phy
	pei	<L374+address_0
	jsl	~~get_float
	xref	~~~fsbc
	jsl	~~~fsbc
	pei	<L374+address_0
	jsl	~~store_float
	brl	L10270
L10269:
	lda	<L375+exprtype_1
	cmp	#<$3
	beq	L378
	brl	L10271
L378:
	phy
	phy
	jsl	~~pop_float
	phy
	phy
	pei	<L374+address_0
	jsl	~~get_float
	xref	~~~fsbc
	jsl	~~~fsbc
	pei	<L374+address_0
	jsl	~~store_float
	brl	L10272
L10271:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10272:
L10270:
L379:
	lda	<L374+2
	sta	<L374+2+4
	lda	<L374+1
	sta	<L374+1+4
	pld
	tsc
	clc
	adc	#L374+4
	tcs
	rtl
L374	equ	6
L375	equ	5
	ends
	efunc
	code
	func
~~assiminus_intarray:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L380
	tcs
	phd
	tcd
address_0	set	4
exprtype_1	set	0
ap_1	set	2
ap2_1	set	6
p_1	set	10
p2_1	set	14
n_1	set	18
value_1	set	20
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L381+exprtype_1
	lda	[<L380+address_0]
	sta	<L381+ap_1
	ldy	#$2
	lda	[<L380+address_0],Y
	sta	<L381+ap_1+2
	lda	<L381+ap_1
	ora	<L381+ap_1+2
	beq	L382
	brl	L10273
L382:
	pea	#^L350
	pea	#<L350
	pea	#<$1f
	pea	#8
	jsl	~~error
L10273:
	lda	<L381+exprtype_1
	cmp	#<$2
	bne	L384
	brl	L383
L384:
	lda	<L381+exprtype_1
	cmp	#<$3
	beq	L385
	brl	L10274
L385:
L383:
	lda	<L381+exprtype_1
	cmp	#<$2
	beq	L387
	brl	L386
L387:
	jsl	~~pop_int
	bra	L388
L386:
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
L388:
	sta	<L381+value_1
	ldy	#$4
	lda	[<L381+ap_1],Y
	sta	<L381+p_1
	ldy	#$6
	lda	[<L381+ap_1],Y
	sta	<L381+p_1+2
	stz	<L381+n_1
	brl	L10278
L10277:
	ldy	#$0
	lda	<L381+n_1
	bpl	L389
	dey
L389:
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
	lda	<L381+p_1
	adc	<R0
	sta	<R2
	lda	<L381+p_1+2
	adc	<R0+2
	sta	<R2+2
	sec
	lda	[<R2]
	sbc	<L381+value_1
	sta	[<R2]
L10275:
	inc	<L381+n_1
L10278:
	sec
	lda	<L381+n_1
	ldy	#$2
	sbc	[<L381+ap_1],Y
	bvs	L390
	eor	#$8000
L390:
	bmi	L391
	brl	L10277
L391:
L10276:
	brl	L10279
L10274:
	lda	<L381+exprtype_1
	cmp	#<$6
	beq	L392
	brl	L10280
L392:
	jsl	~~pop_array
	sta	<L381+ap2_1
	stx	<L381+ap2_1+2
	lda	<L381+ap2_1
	ora	<L381+ap2_1+2
	beq	L393
	brl	L10281
L393:
	pea	#^L350+2
	pea	#<L350+2
	pea	#<$1f
	pea	#8
	jsl	~~error
L10281:
	pei	<L381+ap2_1+2
	pei	<L381+ap2_1
	pei	<L381+ap_1+2
	pei	<L381+ap_1
	jsl	~~check_arrays
	and	#$ff
	beq	L394
	brl	L10282
L394:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10282:
	ldy	#$4
	lda	[<L381+ap_1],Y
	sta	<L381+p_1
	ldy	#$6
	lda	[<L381+ap_1],Y
	sta	<L381+p_1+2
	ldy	#$4
	lda	[<L381+ap2_1],Y
	sta	<L381+p2_1
	ldy	#$6
	lda	[<L381+ap2_1],Y
	sta	<L381+p2_1+2
	stz	<L381+n_1
	brl	L10286
L10285:
	ldy	#$0
	lda	<L381+n_1
	bpl	L395
	dey
L395:
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
	lda	<L381+p2_1
	adc	<R0
	sta	<R2
	lda	<L381+p2_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L381+n_1
	bpl	L396
	dey
L396:
	sta	<R3
	sty	<R3+2
	pei	<R3+2
	pei	<R3
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	lda	<L381+p_1
	adc	<R0
	sta	<17
	lda	<L381+p_1+2
	adc	<R0+2
	sta	<17+2
	sec
	lda	[<17]
	sbc	[<R2]
	sta	[<17]
L10283:
	inc	<L381+n_1
L10286:
	sec
	lda	<L381+n_1
	ldy	#$2
	sbc	[<L381+ap_1],Y
	bvs	L397
	eor	#$8000
L397:
	bmi	L398
	brl	L10285
L398:
L10284:
	brl	L10287
L10280:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10287:
L10279:
L399:
	lda	<L380+2
	sta	<L380+2+4
	lda	<L380+1
	sta	<L380+1+4
	pld
	tsc
	clc
	adc	#L380+4
	tcs
	rtl
L380	equ	42
L381	equ	21
	ends
	efunc
	data
L350:
	db	$28,$00,$28,$00
	ends
	code
	func
~~assiminus_floatarray:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L401
	tcs
	phd
	tcd
address_0	set	4
	udata
L10288:
	ds	4
	ends
exprtype_1	set	0
ap_1	set	2
ap2_1	set	6
p_1	set	10
p2_1	set	14
n_1	set	18
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L402+exprtype_1
	lda	[<L401+address_0]
	sta	<L402+ap_1
	ldy	#$2
	lda	[<L401+address_0],Y
	sta	<L402+ap_1+2
	lda	<L402+ap_1
	ora	<L402+ap_1+2
	beq	L403
	brl	L10289
L403:
	pea	#^L400
	pea	#<L400
	pea	#<$1f
	pea	#8
	jsl	~~error
L10289:
	lda	<L402+exprtype_1
	cmp	#<$2
	bne	L405
	brl	L404
L405:
	lda	<L402+exprtype_1
	cmp	#<$3
	beq	L406
	brl	L10290
L406:
L404:
	lda	<L402+exprtype_1
	cmp	#<$2
	beq	L408
	brl	L407
L408:
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L409
	dey
L409:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	bra	L410
L407:
	phy
	phy
	jsl	~~pop_float
L410:
	pla
	sta	|L10288
	pla
	sta	|L10288+2
	ldy	#$4
	lda	[<L402+ap_1],Y
	sta	<L402+p_1
	ldy	#$6
	lda	[<L402+ap_1],Y
	sta	<L402+p_1+2
	stz	<L402+n_1
	brl	L10294
L10293:
	ldy	#$0
	lda	<L402+n_1
	bpl	L411
	dey
L411:
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
	lda	<L402+p_1
	adc	<R0
	sta	<R2
	lda	<L402+p_1+2
	adc	<R0+2
	sta	<R2+2
	lda	|L10288+2
	pha
	lda	|L10288
	pha
	ldy	#$2
	lda	[<R2],Y
	pha
	lda	[<R2]
	pha
	xref	~~~fsbc
	jsl	~~~fsbc
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10291:
	inc	<L402+n_1
L10294:
	sec
	lda	<L402+n_1
	ldy	#$2
	sbc	[<L402+ap_1],Y
	bvs	L412
	eor	#$8000
L412:
	bmi	L413
	brl	L10293
L413:
L10292:
	brl	L10295
L10290:
	lda	<L402+exprtype_1
	cmp	#<$8
	beq	L414
	brl	L10296
L414:
	jsl	~~pop_array
	sta	<L402+ap2_1
	stx	<L402+ap2_1+2
	lda	<L402+ap2_1
	ora	<L402+ap2_1+2
	beq	L415
	brl	L10297
L415:
	pea	#^L400+2
	pea	#<L400+2
	pea	#<$1f
	pea	#8
	jsl	~~error
L10297:
	pei	<L402+ap2_1+2
	pei	<L402+ap2_1
	pei	<L402+ap_1+2
	pei	<L402+ap_1
	jsl	~~check_arrays
	and	#$ff
	beq	L416
	brl	L10298
L416:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10298:
	ldy	#$4
	lda	[<L402+ap_1],Y
	sta	<L402+p_1
	ldy	#$6
	lda	[<L402+ap_1],Y
	sta	<L402+p_1+2
	ldy	#$4
	lda	[<L402+ap2_1],Y
	sta	<L402+p2_1
	ldy	#$6
	lda	[<L402+ap2_1],Y
	sta	<L402+p2_1+2
	stz	<L402+n_1
	brl	L10302
L10301:
	ldy	#$0
	lda	<L402+n_1
	bpl	L417
	dey
L417:
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
	lda	<L402+p_1
	adc	<R0
	sta	<R2
	lda	<L402+p_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L402+n_1
	bpl	L418
	dey
L418:
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
	lda	<L402+p2_1
	adc	<R0
	sta	<17
	lda	<L402+p2_1+2
	adc	<R0+2
	sta	<17+2
	ldy	#$2
	lda	[<17],Y
	pha
	lda	[<17]
	pha
	ldy	#$2
	lda	[<R2],Y
	pha
	lda	[<R2]
	pha
	xref	~~~fsbc
	jsl	~~~fsbc
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10299:
	inc	<L402+n_1
L10302:
	sec
	lda	<L402+n_1
	ldy	#$2
	sbc	[<L402+ap_1],Y
	bvs	L419
	eor	#$8000
L419:
	bmi	L420
	brl	L10301
L420:
L10300:
	brl	L10303
L10296:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10303:
L10295:
L421:
	lda	<L401+2
	sta	<L401+2+4
	lda	<L401+1
	sta	<L401+1+4
	pld
	tsc
	clc
	adc	#L401+4
	tcs
	rtl
L401	equ	40
L402	equ	21
	ends
	efunc
	data
L400:
	db	$28,$00,$28,$00
	ends
	code
	func
~~assiminus_badtype:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L423
	tcs
	phd
	tcd
address_0	set	4
	pea	#<$50
	pea	#4
	jsl	~~error
L425:
	lda	<L423+2
	sta	<L423+2+4
	lda	<L423+1
	sta	<L423+1+4
	pld
	tsc
	clc
	adc	#L423+4
	tcs
	rtl
L423	equ	0
L424	equ	1
	ends
	efunc
	data
~~assign_table:
	dl	~~assignment_invalid
	dl	~~assignment_invalid
	dl	~~assign_intword
	dl	~~assign_float
	dl	~~assign_stringdol
	dl	~~assignment_invalid
	dl	~~assignment_invalid
	dl	~~assignment_invalid
	dl	~~assignment_invalid
	dl	~~assignment_invalid
	dl	~~assign_intarray
	dl	~~assign_floatarray
	dl	~~assign_strarray
	dl	~~assignment_invalid
	dl	~~assignment_invalid
	dl	~~assignment_invalid
	dl	~~assignment_invalid
	dl	~~assign_intbyteptr
	dl	~~assign_intwordptr
	dl	~~assign_floatptr
	dl	~~assignment_invalid
	dl	~~assign_dolstrptr
	dl	~~assignment_invalid
	dl	~~assignment_invalid
	ends
	data
~~assiplus_table:
	dl	~~assignment_invalid
	dl	~~assignment_invalid
	dl	~~assiplus_intword
	dl	~~assiplus_float
	dl	~~assiplus_stringdol
	dl	~~assignment_invalid
	dl	~~assignment_invalid
	dl	~~assignment_invalid
	dl	~~assignment_invalid
	dl	~~assignment_invalid
	dl	~~assiplus_intarray
	dl	~~assiplus_floatarray
	dl	~~assiplus_strarray
	dl	~~assignment_invalid
	dl	~~assignment_invalid
	dl	~~assignment_invalid
	dl	~~assignment_invalid
	dl	~~assiplus_intbyteptr
	dl	~~assiplus_intwordptr
	dl	~~assiplus_floatptr
	dl	~~assignment_invalid
	dl	~~assiplus_dolstrptr
	dl	~~assignment_invalid
	dl	~~assignment_invalid
	ends
	data
~~assiminus_table:
	dl	~~assignment_invalid
	dl	~~assignment_invalid
	dl	~~assiminus_intword
	dl	~~assiminus_float
	dl	~~assiminus_badtype
	dl	~~assignment_invalid
	dl	~~assignment_invalid
	dl	~~assignment_invalid
	dl	~~assignment_invalid
	dl	~~assignment_invalid
	dl	~~assiminus_intarray
	dl	~~assiminus_floatarray
	dl	~~assiminus_badtype
	dl	~~assignment_invalid
	dl	~~assignment_invalid
	dl	~~assignment_invalid
	dl	~~assignment_invalid
	dl	~~assiminus_intbyteptr
	dl	~~assiminus_intwordptr
	dl	~~assiminus_floatptr
	dl	~~assignment_invalid
	dl	~~assiminus_badtype
	dl	~~assignment_invalid
	dl	~~assignment_invalid
	ends
	code
	xdef	~~exec_assignment
	func
~~exec_assignment:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L426
	tcs
	phd
	tcd
assignop_1	set	0
destination_1	set	1
	pea	#0
	clc
	tdc
	adc	#<L427+destination_1
	pha
	jsl	~~get_lvalue
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	sta	<L427+assignop_1
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	lda	<L427+assignop_1
	cmp	#<$3d
	rep	#$20
	longa	on
	beq	L428
	brl	L10304
L428:
	inc	|~~basicvars+62
	bne	L429
	inc	|~~basicvars+62+2
L429:
	jsl	~~expression
	sec
	tsc
	sbc	#4
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L427+destination_1+2
	sta	<R1
	lda	#$0
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$4
	xref	~~~fmov
	jsl	~~~fmov
	lda	<L427+destination_1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~assign_table
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	tax
	lda	(<R1)
	xref	~~~lcal
	jsl	~~~lcal
	brl	L10305
L10304:
	sep	#$20
	longa	off
	lda	<L427+assignop_1
	cmp	#<$8c
	rep	#$20
	longa	on
	beq	L430
	brl	L10306
L430:
	inc	|~~basicvars+62
	bne	L431
	inc	|~~basicvars+62+2
L431:
	jsl	~~expression
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	beq	L432
	brl	L10307
L432:
	pea	#<$5
	pea	#4
	jsl	~~error
L10307:
	sec
	tsc
	sbc	#4
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L427+destination_1+2
	sta	<R1
	lda	#$0
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$4
	xref	~~~fmov
	jsl	~~~fmov
	lda	<L427+destination_1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~assiplus_table
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	tax
	lda	(<R1)
	xref	~~~lcal
	jsl	~~~lcal
	brl	L10308
L10306:
	sep	#$20
	longa	off
	lda	<L427+assignop_1
	cmp	#<$88
	rep	#$20
	longa	on
	beq	L433
	brl	L10309
L433:
	inc	|~~basicvars+62
	bne	L434
	inc	|~~basicvars+62+2
L434:
	jsl	~~expression
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	beq	L435
	brl	L10310
L435:
	pea	#<$5
	pea	#4
	jsl	~~error
L10310:
	sec
	tsc
	sbc	#4
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L427+destination_1+2
	sta	<R1
	lda	#$0
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$4
	xref	~~~fmov
	jsl	~~~fmov
	lda	<L427+destination_1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~assiminus_table
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	tax
	lda	(<R1)
	xref	~~~lcal
	jsl	~~~lcal
	brl	L10311
L10309:
	pea	#<$26
	pea	#4
	jsl	~~error
L10311:
L10308:
L10305:
L436:
	pld
	tsc
	clc
	adc	#L426
	tcs
	rtl
L426	equ	15
L427	equ	9
	ends
	efunc
	code
	func
~~decode_format:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L437
	tcs
	phd
	tcd
format_0	set	4
FORMATMASK_1	set	0
DECPTMASK_1	set	2
WIDTHMASK_1	set	4
GFORMAT_1	set	6
EFORMAT_1	set	8
FFORMAT_1	set	10
DECPTSHIFT_1	set	12
original_1	set	14
newformat_1	set	16
fp_1	set	18
ep_1	set	22
	lda	#$0
	sta	<L438+FORMATMASK_1
	lda	#$ff00
	sta	<L438+DECPTMASK_1
	lda	#$ff
	sta	<L438+WIDTHMASK_1
	stz	<L438+GFORMAT_1
	lda	#$0
	sta	<L438+EFORMAT_1
	lda	#$0
	sta	<L438+FFORMAT_1
	lda	#$8
	sta	<L438+DECPTSHIFT_1
	lda	|~~basicvars+520
	sta	<L438+newformat_1
	lda	<L438+newformat_1
	sta	<L438+original_1
	lda	<L437+format_0+2
	sta	<L438+fp_1
	lda	<L437+format_0+4
	sta	<L438+fp_1+2
	ldy	#$0
	lda	<L437+format_0
	bpl	L439
	dey
L439:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L438+fp_1
	adc	<R0
	sta	<L438+ep_1
	lda	<L438+fp_1+2
	adc	<R0+2
	sta	<L438+ep_1+2
	lda	<L438+fp_1
	cmp	<L438+ep_1
	bne	L440
	lda	<L438+fp_1+2
	cmp	<L438+ep_1+2
L440:
	beq	L441
	brl	L10312
L441:
	ldy	#$0
	lda	<L438+newformat_1
	bpl	L442
	dey
L442:
	sta	<R0
	sty	<R0+2
	lda	<R0
	sta	<R1
	lda	<R0+2
	and	#^$feffffff
	sta	<R1+2
	lda	<R1
L443:
	tay
	lda	<L437+2
	sta	<L437+2+6
	lda	<L437+1
	sta	<L437+1+6
	pld
	tsc
	clc
	adc	#L437+6
	tcs
	tya
	rtl
L10312:
	sep	#$20
	longa	off
	lda	[<L438+fp_1]
	cmp	#<$2b
	rep	#$20
	longa	on
	beq	L444
	brl	L10313
L444:
	lda	#$0
	tsb	<L438+newformat_1
	inc	<L438+fp_1
	bne	L445
	inc	<L438+fp_1+2
L445:
	lda	<L438+fp_1
	cmp	<L438+ep_1
	bne	L446
	lda	<L438+fp_1+2
	cmp	<L438+ep_1+2
L446:
	beq	L447
	brl	L10314
L447:
	lda	<L438+newformat_1
	brl	L443
L10314:
	brl	L10315
L10313:
	lda	#$0
	trb	<L438+newformat_1
L10315:
	lda	[<L438+fp_1]
	and	#$ff
	pha
	jsl	~~tolower
	sta	<R0
	sec
	lda	<R0
	sbc	#<$65
	bvs	L448
	eor	#$8000
L448:
	bmi	L449
	brl	L10316
L449:
	lda	[<L438+fp_1]
	and	#$ff
	pha
	jsl	~~tolower
	sta	<R0
	sec
	lda	#$67
	sbc	<R0
	bvs	L450
	eor	#$8000
L450:
	bmi	L451
	brl	L10316
L451:
	lda	[<L438+fp_1]
	and	#$ff
	pha
	jsl	~~tolower
	brl	L10317
L10319:
	ldy	#$0
	lda	<L438+newformat_1
	bpl	L452
	dey
L452:
	sta	<R0
	sty	<R0+2
	lda	<R0
	sta	<R1
	lda	<R0+2
	and	#^$ff00ffff
	sta	<R1+2
	lda	<R1
	sta	<R0
	lda	<R1+2
	ora	#^$10000
	sta	<R0+2
	lda	<R0
	sta	<L438+newformat_1
	brl	L10318
L10320:
	ldy	#$0
	lda	<L438+newformat_1
	bpl	L453
	dey
L453:
	sta	<R0
	sty	<R0+2
	lda	<R0
	sta	<R1
	lda	<R0+2
	and	#^$ff00ffff
	sta	<R1+2
	lda	<R1
	sta	<R0
	lda	<R1+2
	ora	#^$20000
	sta	<R0+2
	lda	<R0
	sta	<L438+newformat_1
	brl	L10318
L10321:
	lda	#$0
	trb	<L438+newformat_1
	brl	L10318
L10317:
	xref	~~~swt
	jsl	~~~swt
	dw	2
	dw	101
	dw	L10319-1
	dw	102
	dw	L10320-1
	dw	L10321-1
L10318:
	inc	<L438+fp_1
	bne	L454
	inc	<L438+fp_1+2
L454:
	lda	<L438+fp_1
	cmp	<L438+ep_1
	bne	L455
	lda	<L438+fp_1+2
	cmp	<L438+ep_1+2
L455:
	beq	L456
	brl	L10322
L456:
	lda	<L438+newformat_1
	brl	L443
L10322:
L10316:
	lda	[<L438+fp_1]
	and	#$ff
	pha
	jsl	~~isdigit
	tax
	bne	L457
	brl	L10323
L457:
	pea	#<$a
	pea	#0
	clc
	tdc
	adc	#<L438+fp_1
	pha
	pei	<L438+fp_1+2
	pei	<L438+fp_1
	jsl	~~strtol
	sta	<R0
	stx	<R0+2
	lda	<R0
	and	#<$ff
	sta	<R1
	lda	<L438+newformat_1
	and	#<$ffffff00
	sta	<R0
	lda	<R0
	ora	<R1
	sta	<L438+newformat_1
	lda	<L438+fp_1
	cmp	<L438+ep_1
	bne	L458
	lda	<L438+fp_1+2
	cmp	<L438+ep_1+2
L458:
	beq	L459
	brl	L10324
L459:
	lda	<L438+newformat_1
	brl	L443
L10324:
L10323:
	sep	#$20
	longa	off
	lda	[<L438+fp_1]
	cmp	#<$2c
	rep	#$20
	longa	on
	bne	L461
	brl	L460
L461:
	sep	#$20
	longa	off
	lda	[<L438+fp_1]
	cmp	#<$2e
	rep	#$20
	longa	on
	beq	L462
	brl	L10325
L462:
L460:
	sep	#$20
	longa	off
	lda	[<L438+fp_1]
	cmp	#<$2c
	rep	#$20
	longa	on
	beq	L463
	brl	L10326
L463:
	lda	#$0
	tsb	<L438+newformat_1
	brl	L10327
L10326:
	lda	#$0
	trb	<L438+newformat_1
L10327:
	inc	<L438+fp_1
	bne	L464
	inc	<L438+fp_1+2
L464:
	lda	<L438+fp_1
	cmp	<L438+ep_1
	bne	L465
	lda	<L438+fp_1+2
	cmp	<L438+ep_1+2
L465:
	beq	L466
	brl	L10328
L466:
	lda	<L438+newformat_1
	brl	L443
L10328:
	lda	[<L438+fp_1]
	and	#$ff
	pha
	jsl	~~isdigit
	tax
	beq	L467
	brl	L10329
L467:
	lda	<L438+original_1
	brl	L443
L10329:
	pea	#<$a
	pea	#0
	clc
	tdc
	adc	#<L438+fp_1
	pha
	pei	<L438+fp_1+2
	pei	<L438+fp_1
	jsl	~~strtol
	sta	<R1
	stx	<R1+2
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	lda	<R0
	and	#<$ff00
	sta	<R1
	stz	<R1+2
	ldy	#$0
	lda	<L438+newformat_1
	bpl	L468
	dey
L468:
	sta	<R0
	sty	<R0+2
	lda	<R0
	and	#<$ffff00ff
	sta	<R2
	lda	<R0+2
	sta	<R2+2
	lda	<R2
	ora	<R1
	sta	<R0
	lda	<R2+2
	ora	<R1+2
	sta	<R0+2
	lda	<R0
	sta	<L438+newformat_1
L10325:
	lda	<L438+fp_1
	cmp	<L438+ep_1
	bne	L469
	lda	<L438+fp_1+2
	cmp	<L438+ep_1+2
L469:
	bne	L470
	brl	L10330
L470:
	lda	<L438+original_1
	brl	L443
L10330:
	lda	<L438+newformat_1
	brl	L443
L437	equ	38
L438	equ	13
	ends
	efunc
	code
	xdef	~~assign_staticvar
	func
~~assign_staticvar:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L471
	tcs
	phd
	tcd
assignop_1	set	0
value_1	set	1
varindex_1	set	3
exprtype_1	set	5
	inc	|~~basicvars+62
	bne	L473
	inc	|~~basicvars+62+2
L473:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	sta	<L472+varindex_1
	inc	|~~basicvars+62
	bne	L474
	inc	|~~basicvars+62+2
L474:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	sta	<L472+assignop_1
	rep	#$20
	longa	on
	inc	|~~basicvars+62
	bne	L475
	inc	|~~basicvars+62+2
L475:
	sep	#$20
	longa	off
	lda	<L472+assignop_1
	cmp	#<$3d
	rep	#$20
	longa	on
	bne	L476
	brl	L10331
L476:
	sep	#$20
	longa	off
	lda	<L472+assignop_1
	cmp	#<$8c
	rep	#$20
	longa	on
	bne	L477
	brl	L10331
L477:
	sep	#$20
	longa	off
	lda	<L472+assignop_1
	cmp	#<$88
	rep	#$20
	longa	on
	bne	L478
	brl	L10331
L478:
	pea	#<$26
	pea	#4
	jsl	~~error
L10331:
	jsl	~~expression
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	beq	L479
	brl	L10332
L479:
	pea	#<$5
	pea	#4
	jsl	~~error
L10332:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L472+exprtype_1
	lda	<L472+varindex_1
	beq	L480
	brl	L10333
L480:
	sep	#$20
	longa	off
	lda	<L472+assignop_1
	cmp	#<$3d
	rep	#$20
	longa	on
	beq	L481
	brl	L10333
L481:
	lda	<L472+exprtype_1
	cmp	#<$2
	beq	L482
	brl	L10334
L482:
	jsl	~~pop_int
	sta	|~~basicvars+520
	brl	L10335
L10334:
	lda	<L472+exprtype_1
	cmp	#<$3
	beq	L483
	brl	L10336
L483:
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
	sta	|~~basicvars+520
	brl	L10337
L10336:
format_2	set	7
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L472+format_2
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L472+format_2
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
	jsl	~~decode_format
	sta	|~~basicvars+520
	lda	<L472+exprtype_1
	cmp	#<$5
	beq	L484
	brl	L10338
L484:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L472+format_2
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
L10338:
L10337:
L10335:
	brl	L10339
L10333:
	lda	<L472+exprtype_1
	cmp	#<$2
	beq	L485
	brl	L10340
L485:
	jsl	~~pop_int
	sta	<L472+value_1
	brl	L10341
L10340:
	lda	<L472+exprtype_1
	cmp	#<$3
	beq	L486
	brl	L10342
L486:
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
	sta	<L472+value_1
	brl	L10343
L10342:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10343:
L10341:
	sep	#$20
	longa	off
	lda	<L472+assignop_1
	cmp	#<$3d
	rep	#$20
	longa	on
	beq	L487
	brl	L10344
L487:
	lda	<L472+varindex_1
	ldx	#<$16
	xref	~~~mul
	jsl	~~~mul
	sta	<R0
	lda	<L472+value_1
	ldx	<R0
	sta	|~~basicvars+504+16,X
	brl	L10345
L10344:
	sep	#$20
	longa	off
	lda	<L472+assignop_1
	cmp	#<$8c
	rep	#$20
	longa	on
	beq	L488
	brl	L10346
L488:
	lda	<L472+varindex_1
	ldx	#<$16
	xref	~~~mul
	jsl	~~~mul
	sta	<R0
	clc
	lda	#$10
	adc	<R0
	sta	<R1
	clc
	lda	#<~~basicvars+504
	adc	<R1
	sta	<R0
	clc
	lda	(<R0)
	adc	<L472+value_1
	sta	(<R0)
	brl	L10347
L10346:
	lda	<L472+varindex_1
	ldx	#<$16
	xref	~~~mul
	jsl	~~~mul
	sta	<R0
	clc
	lda	#$10
	adc	<R0
	sta	<R1
	clc
	lda	#<~~basicvars+504
	adc	<R1
	sta	<R0
	sec
	lda	(<R0)
	sbc	<L472+value_1
	sta	(<R0)
L10347:
L10345:
L10339:
L489:
	pld
	tsc
	clc
	adc	#L471
	tcs
	rtl
L471	equ	21
L472	equ	9
	ends
	efunc
	code
	xdef	~~assign_intvar
	func
~~assign_intvar:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L490
	tcs
	phd
	tcd
assignop_1	set	0
value_1	set	1
ip_1	set	3
exprtype_1	set	7
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
	bpl	L492
	dey
L492:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars
	adc	<R0
	sta	<L491+ip_1
	lda	|~~basicvars+2
	adc	<R0+2
	sta	<L491+ip_1+2
	clc
	lda	#$5
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L493
	inc	|~~basicvars+62+2
L493:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	sta	<L491+assignop_1
	rep	#$20
	longa	on
	inc	|~~basicvars+62
	bne	L494
	inc	|~~basicvars+62+2
L494:
	jsl	~~expression
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L491+exprtype_1
	lda	<L491+exprtype_1
	cmp	#<$2
	beq	L495
	brl	L10348
L495:
	jsl	~~pop_int
	sta	<L491+value_1
	brl	L10349
L10348:
	lda	<L491+exprtype_1
	cmp	#<$3
	beq	L496
	brl	L10350
L496:
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
	sta	<L491+value_1
	brl	L10351
L10350:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10351:
L10349:
	sep	#$20
	longa	off
	lda	<L491+assignop_1
	cmp	#<$3d
	rep	#$20
	longa	on
	beq	L497
	brl	L10352
L497:
	lda	<L491+value_1
	sta	[<L491+ip_1]
	brl	L10353
L10352:
	sep	#$20
	longa	off
	lda	<L491+assignop_1
	cmp	#<$8c
	rep	#$20
	longa	on
	beq	L498
	brl	L10354
L498:
	clc
	lda	[<L491+ip_1]
	adc	<L491+value_1
	sta	[<L491+ip_1]
	brl	L10355
L10354:
	sec
	lda	[<L491+ip_1]
	sbc	<L491+value_1
	sta	[<L491+ip_1]
L10355:
L10353:
L499:
	pld
	tsc
	clc
	adc	#L490
	tcs
	rtl
L490	equ	21
L491	equ	13
	ends
	efunc
	code
	xdef	~~assign_floatvar
	func
~~assign_floatvar:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L500
	tcs
	phd
	tcd
	udata
L10356:
	ds	4
	ends
assignop_1	set	0
fp_1	set	1
exprtype_1	set	5
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
	bpl	L502
	dey
L502:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars
	adc	<R0
	sta	<L501+fp_1
	lda	|~~basicvars+2
	adc	<R0+2
	sta	<L501+fp_1+2
	clc
	lda	#$5
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L503
	inc	|~~basicvars+62+2
L503:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	sta	<L501+assignop_1
	rep	#$20
	longa	on
	inc	|~~basicvars+62
	bne	L504
	inc	|~~basicvars+62+2
L504:
	jsl	~~expression
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L501+exprtype_1
	lda	<L501+exprtype_1
	cmp	#<$2
	beq	L505
	brl	L10357
L505:
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L506
	dey
L506:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	pla
	sta	|L10356
	pla
	sta	|L10356+2
	brl	L10358
L10357:
	lda	<L501+exprtype_1
	cmp	#<$3
	beq	L507
	brl	L10359
L507:
	phy
	phy
	jsl	~~pop_float
	pla
	sta	|L10356
	pla
	sta	|L10356+2
	brl	L10360
L10359:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10360:
L10358:
	sep	#$20
	longa	off
	lda	<L501+assignop_1
	cmp	#<$3d
	rep	#$20
	longa	on
	beq	L508
	brl	L10361
L508:
	lda	|L10356
	sta	[<L501+fp_1]
	lda	|L10356+2
	ldy	#$2
	sta	[<L501+fp_1],Y
	brl	L10362
L10361:
	sep	#$20
	longa	off
	lda	<L501+assignop_1
	cmp	#<$8c
	rep	#$20
	longa	on
	beq	L509
	brl	L10363
L509:
	lda	|L10356+2
	pha
	lda	|L10356
	pha
	ldy	#$2
	lda	[<L501+fp_1],Y
	pha
	lda	[<L501+fp_1]
	pha
	xref	~~~fadc
	jsl	~~~fadc
	pla
	sta	[<L501+fp_1]
	pla
	ldy	#$2
	sta	[<L501+fp_1],Y
	brl	L10364
L10363:
	lda	|L10356+2
	pha
	lda	|L10356
	pha
	ldy	#$2
	lda	[<L501+fp_1],Y
	pha
	lda	[<L501+fp_1]
	pha
	xref	~~~fsbc
	jsl	~~~fsbc
	pla
	sta	[<L501+fp_1]
	pla
	ldy	#$2
	sta	[<L501+fp_1],Y
L10364:
L10362:
L510:
	pld
	tsc
	clc
	adc	#L500
	tcs
	rtl
L500	equ	19
L501	equ	13
	ends
	efunc
	code
	xdef	~~assign_stringvar
	func
~~assign_stringvar:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L511
	tcs
	phd
	tcd
assignop_1	set	0
address_1	set	1
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
	bpl	L513
	dey
L513:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars
	adc	<R0
	sta	<L512+address_1
	lda	|~~basicvars+2
	adc	<R0+2
	sta	<L512+address_1+2
	clc
	lda	#$5
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L514
	inc	|~~basicvars+62+2
L514:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	sta	<L512+assignop_1
	rep	#$20
	longa	on
	inc	|~~basicvars+62
	bne	L515
	inc	|~~basicvars+62+2
L515:
	sep	#$20
	longa	off
	lda	<L512+assignop_1
	cmp	#<$3d
	rep	#$20
	longa	on
	beq	L516
	brl	L10365
L516:
	jsl	~~expression
	sec
	tsc
	sbc	#4
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L512+address_1
	sta	<R1
	lda	#$0
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$4
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~assign_stringdol
	brl	L10366
L10365:
	sep	#$20
	longa	off
	lda	<L512+assignop_1
	cmp	#<$8c
	rep	#$20
	longa	on
	beq	L517
	brl	L10367
L517:
	jsl	~~expression
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	beq	L518
	brl	L10368
L518:
	pea	#<$5
	pea	#4
	jsl	~~error
L10368:
	sec
	tsc
	sbc	#4
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L512+address_1
	sta	<R1
	lda	#$0
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$4
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~assiplus_stringdol
	brl	L10369
L10367:
	sep	#$20
	longa	off
	lda	<L512+assignop_1
	cmp	#<$88
	rep	#$20
	longa	on
	beq	L519
	brl	L10370
L519:
	sec
	tsc
	sbc	#4
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L512+address_1
	sta	<R1
	lda	#$0
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$4
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~assiminus_badtype
	brl	L10371
L10370:
	pea	#<$26
	pea	#4
	jsl	~~error
L10371:
L10369:
L10366:
L520:
	pld
	tsc
	clc
	adc	#L511
	tcs
	rtl
L511	equ	17
L512	equ	13
	ends
	efunc
	code
	func
~~assign_himem:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L521
	tcs
	phd
	tcd
offset_1	set	0
address_1	set	2
	inc	|~~basicvars+62
	bne	L523
	inc	|~~basicvars+62+2
L523:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$3d
	rep	#$20
	longa	on
	bne	L524
	brl	L10372
L524:
	pea	#<$26
	pea	#4
	jsl	~~error
L10372:
	inc	|~~basicvars+62
	bne	L525
	inc	|~~basicvars+62+2
L525:
	jsl	~~eval_integer
	sta	<R0
	lda	<R0
	ina
	and	#<$fffffffe
	sta	<L522+offset_1
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	beq	L526
	brl	L10373
L526:
	pea	#<$5
	pea	#4
	jsl	~~error
L10373:
	ldy	#$0
	lda	<L522+offset_1
	bpl	L527
	dey
L527:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars+6
	adc	<R0
	sta	<L522+address_1
	lda	|~~basicvars+6+2
	adc	<R0+2
	sta	<L522+address_1+2
	clc
	lda	#$400
	adc	|~~basicvars+34
	sta	<R0
	lda	#$0
	adc	|~~basicvars+34+2
	sta	<R0+2
	lda	<L522+address_1
	cmp	<R0
	lda	<L522+address_1+2
	sbc	<R0+2
	bcs	L529
	brl	L528
L529:
	lda	<L522+address_1
	cmp	|~~basicvars+54
	lda	<L522+address_1+2
	sbc	|~~basicvars+54+2
	bcs	L530
	brl	L10374
L530:
L528:
	pea	#<$5e
	pea	#4
	jsl	~~error
	brl	L10375
L10374:
	jsl	~~safestack
	and	#$ff
	beq	L531
	brl	L10376
L531:
	pea	#<$62
	pea	#4
	jsl	~~error
	brl	L10377
L10376:
	lda	<L522+address_1
	sta	|~~basicvars+50
	lda	<L522+address_1+2
	sta	|~~basicvars+50+2
	jsl	~~init_stack
	jsl	~~init_expressions
L10377:
L10375:
L532:
	pld
	tsc
	clc
	adc	#L521
	tcs
	rtl
L521	equ	10
L522	equ	5
	ends
	efunc
	code
	func
~~assign_ext:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L533
	tcs
	phd
	tcd
handle_1	set	0
newsize_1	set	2
	inc	|~~basicvars+62
	bne	L535
	inc	|~~basicvars+62+2
L535:
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
	bne	L536
	brl	L10378
L536:
	pea	#<$2c
	pea	#4
	jsl	~~error
L10378:
	inc	|~~basicvars+62
	bne	L537
	inc	|~~basicvars+62+2
L537:
	jsl	~~eval_intfactor
	sta	<L534+handle_1
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$3d
	rep	#$20
	longa	on
	bne	L538
	brl	L10379
L538:
	pea	#<$26
	pea	#4
	jsl	~~error
L10379:
	inc	|~~basicvars+62
	bne	L539
	inc	|~~basicvars+62+2
L539:
	jsl	~~eval_integer
	sta	<L534+newsize_1
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	beq	L540
	brl	L10380
L540:
	pea	#<$5
	pea	#4
	jsl	~~error
L10380:
	pei	<L534+newsize_1
	pei	<L534+handle_1
	jsl	~~fileio_setext
L541:
	pld
	tsc
	clc
	adc	#L533
	tcs
	rtl
L533	equ	8
L534	equ	5
	ends
	efunc
	code
	func
~~assign_filepath:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L542
	tcs
	phd
	tcd
stringtype_1	set	0
string_1	set	2
	inc	|~~basicvars+62
	bne	L544
	inc	|~~basicvars+62+2
L544:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$3d
	rep	#$20
	longa	on
	bne	L545
	brl	L10381
L545:
	pea	#<$26
	pea	#4
	jsl	~~error
L10381:
	inc	|~~basicvars+62
	bne	L546
	inc	|~~basicvars+62+2
L546:
	jsl	~~expression
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	beq	L547
	brl	L10382
L547:
	pea	#<$5
	pea	#4
	jsl	~~error
L10382:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L543+stringtype_1
	lda	<L543+stringtype_1
	cmp	#<$4
	bne	L548
	brl	L10383
L548:
	lda	<L543+stringtype_1
	cmp	#<$5
	bne	L549
	brl	L10383
L549:
	pea	#<$40
	pea	#4
	jsl	~~error
L10383:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L543+string_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	lda	|~~basicvars+419
	ora	|~~basicvars+419+2
	bne	L550
	brl	L10384
L550:
	lda	|~~basicvars+419+2
	pha
	lda	|~~basicvars+419
	pha
	jsl	~~free
L10384:
	lda	<L543+string_1
	beq	L551
	brl	L10385
L551:
	stz	|~~basicvars+419
	stz	|~~basicvars+419+2
	brl	L10386
L10385:
	lda	<L543+string_1
	ina
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L552
	dey
L552:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~malloc
	sta	|~~basicvars+419
	stx	|~~basicvars+419+2
	lda	|~~basicvars+419
	ora	|~~basicvars+419+2
	beq	L553
	brl	L10387
L553:
	pea	#<$59
	pea	#4
	jsl	~~error
L10387:
	ldy	#$0
	lda	<L543+string_1
	bpl	L554
	dey
L554:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L543+string_1+4
	pei	<L543+string_1+2
	lda	|~~basicvars+419+2
	pha
	lda	|~~basicvars+419
	pha
	jsl	~~memcpy
	lda	|~~basicvars+419
	sta	<R0
	lda	|~~basicvars+419+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$0
	ldy	<L543+string_1
	sta	[<R0],Y
	rep	#$20
	longa	on
L10386:
	lda	<L543+stringtype_1
	cmp	#<$5
	beq	L555
	brl	L10388
L555:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L543+string_1
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
L10388:
L556:
	pld
	tsc
	clc
	adc	#L542
	tcs
	rtl
L542	equ	16
L543	equ	9
	ends
	efunc
	code
	func
~~assign_left:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L557
	tcs
	phd
	tcd
count_1	set	0
destination_1	set	2
stringtype_1	set	8
lhstring_1	set	10
rhstring_1	set	16
	inc	|~~basicvars+62
	bne	L559
	inc	|~~basicvars+62+2
L559:
	pea	#0
	clc
	tdc
	adc	#<L558+destination_1
	pha
	jsl	~~get_lvalue
	lda	<L558+destination_1
	cmp	#<$4
	bne	L560
	brl	L10389
L560:
	lda	<L558+destination_1
	cmp	#<$15
	bne	L561
	brl	L10389
L561:
	pea	#<$40
	pea	#4
	jsl	~~error
L10389:
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
	beq	L562
	brl	L10390
L562:
	inc	|~~basicvars+62
	bne	L563
	inc	|~~basicvars+62+2
L563:
	jsl	~~eval_integer
	sta	<L558+count_1
	lda	<L558+count_1
	bmi	L564
	brl	L10391
L564:
	lda	#$1000
	sta	<L558+count_1
	brl	L10392
L10391:
	lda	<L558+count_1
	beq	L565
	brl	L10393
L565:
	lda	#$1
	sta	<L558+count_1
L10393:
L10392:
	brl	L10394
L10390:
	lda	#$1000
	sta	<L558+count_1
L10394:
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
	bne	L566
	brl	L10395
L566:
	pea	#<$29
	pea	#4
	jsl	~~error
L10395:
	inc	|~~basicvars+62
	bne	L567
	inc	|~~basicvars+62+2
L567:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$3d
	rep	#$20
	longa	on
	bne	L568
	brl	L10396
L568:
	pea	#<$26
	pea	#4
	jsl	~~error
L10396:
	inc	|~~basicvars+62
	bne	L569
	inc	|~~basicvars+62+2
L569:
	jsl	~~expression
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	beq	L570
	brl	L10397
L570:
	pea	#<$5
	pea	#4
	jsl	~~error
L10397:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L558+stringtype_1
	lda	<L558+stringtype_1
	cmp	#<$4
	bne	L571
	brl	L10398
L571:
	lda	<L558+stringtype_1
	cmp	#<$5
	bne	L572
	brl	L10398
L572:
	pea	#<$40
	pea	#4
	jsl	~~error
L10398:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L558+rhstring_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	sec
	lda	<L558+rhstring_1
	sbc	<L558+count_1
	bvs	L573
	eor	#$8000
L573:
	bpl	L574
	brl	L10399
L574:
	lda	<L558+rhstring_1
	sta	<L558+count_1
L10399:
	lda	<L558+destination_1
	cmp	#<$4
	beq	L575
	brl	L10400
L575:
	pei	<L558+destination_1+4
	pei	<L558+destination_1+2
	clc
	tdc
	adc	#<L558+lhstring_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	brl	L10401
L10400:
	ldy	#$0
	lda	<L558+destination_1+2
	bpl	L576
	dey
L576:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars+6
	adc	<R0
	sta	<L558+lhstring_1+2
	lda	|~~basicvars+6+2
	adc	<R0+2
	sta	<L558+lhstring_1+4
	pei	<L558+destination_1+2
	jsl	~~get_stringlen
	sta	<L558+lhstring_1
L10401:
	sec
	lda	<L558+lhstring_1
	sbc	<L558+count_1
	bvs	L577
	eor	#$8000
L577:
	bpl	L578
	brl	L10402
L578:
	lda	<L558+lhstring_1
	sta	<L558+count_1
L10402:
	sec
	lda	#$0
	sbc	<L558+count_1
	bvs	L579
	eor	#$8000
L579:
	bpl	L580
	brl	L10403
L580:
	ldy	#$0
	lda	<L558+count_1
	bpl	L581
	dey
L581:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L558+rhstring_1+4
	pei	<L558+rhstring_1+2
	pei	<L558+lhstring_1+4
	pei	<L558+lhstring_1+2
	jsl	~~memmove
L10403:
	lda	<L558+stringtype_1
	cmp	#<$5
	beq	L582
	brl	L10404
L582:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L558+rhstring_1
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
L10404:
L583:
	pld
	tsc
	clc
	adc	#L557
	tcs
	rtl
L557	equ	30
L558	equ	9
	ends
	efunc
	code
	func
~~assign_lomem:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L584
	tcs
	phd
	tcd
address_1	set	0
	inc	|~~basicvars+62
	bne	L586
	inc	|~~basicvars+62+2
L586:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$3d
	rep	#$20
	longa	on
	bne	L587
	brl	L10405
L587:
	pea	#<$26
	pea	#4
	jsl	~~error
L10405:
	inc	|~~basicvars+62
	bne	L588
	inc	|~~basicvars+62+2
L588:
	jsl	~~eval_integer
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L589
	dey
L589:
	sta	<R0
	sty	<R0+2
	clc
	lda	#$1
	adc	<R0
	sta	<R1
	lda	#$0
	adc	<R0+2
	sta	<R1+2
	lda	<R1
	and	#<$fffffffe
	sta	<R0
	lda	<R1+2
	sta	<R0+2
	clc
	lda	|~~basicvars+6
	adc	<R0
	sta	<L585+address_1
	lda	|~~basicvars+6+2
	adc	<R0+2
	sta	<L585+address_1+2
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	beq	L590
	brl	L10406
L590:
	pea	#<$5
	pea	#4
	jsl	~~error
L10406:
	lda	<L585+address_1
	cmp	|~~basicvars+26
	lda	<L585+address_1+2
	sbc	|~~basicvars+26+2
	bcs	L592
	brl	L591
L592:
	lda	<L585+address_1
	cmp	|~~basicvars+50
	lda	<L585+address_1+2
	sbc	|~~basicvars+50+2
	bcs	L593
	brl	L10407
L593:
L591:
	pea	#<$5f
	pea	#4
	jsl	~~error
	brl	L10408
L10407:
	lda	|~~basicvars+399
	ora	|~~basicvars+399+2
	bne	L594
	brl	L10409
L594:
	pea	#<$61
	pea	#4
	jsl	~~error
	brl	L10410
L10409:
	lda	<L585+address_1
	sta	|~~basicvars+34
	lda	<L585+address_1+2
	sta	|~~basicvars+34+2
	lda	<L585+address_1
	sta	|~~basicvars+30
	lda	<L585+address_1+2
	sta	|~~basicvars+30+2
	clc
	lda	#$100
	adc	<L585+address_1
	sta	|~~basicvars+38
	lda	#$0
	adc	<L585+address_1+2
	sta	|~~basicvars+38+2
	jsl	~~clear_varlists
	jsl	~~clear_strings
	jsl	~~clear_heap
	jsl	~~clear_varptrs
L10410:
L10408:
L595:
	pld
	tsc
	clc
	adc	#L584
	tcs
	rtl
L584	equ	12
L585	equ	9
	ends
	efunc
	code
	func
~~assign_mid:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L596
	tcs
	phd
	tcd
start_1	set	0
count_1	set	2
destination_1	set	4
stringtype_1	set	10
lhstring_1	set	12
rhstring_1	set	18
	inc	|~~basicvars+62
	bne	L598
	inc	|~~basicvars+62+2
L598:
	pea	#0
	clc
	tdc
	adc	#<L597+destination_1
	pha
	jsl	~~get_lvalue
	lda	<L597+destination_1
	cmp	#<$4
	bne	L599
	brl	L10411
L599:
	lda	<L597+destination_1
	cmp	#<$15
	bne	L600
	brl	L10411
L600:
	pea	#<$40
	pea	#4
	jsl	~~error
L10411:
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
	bne	L601
	brl	L10412
L601:
	pea	#<$27
	pea	#4
	jsl	~~error
L10412:
	inc	|~~basicvars+62
	bne	L602
	inc	|~~basicvars+62+2
L602:
	jsl	~~eval_integer
	sta	<L597+start_1
	lda	<L597+start_1
	bmi	L603
	dea
	bmi	L603
	brl	L10413
L603:
	lda	#$1
	sta	<L597+start_1
L10413:
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
	beq	L604
	brl	L10414
L604:
	inc	|~~basicvars+62
	bne	L605
	inc	|~~basicvars+62+2
L605:
	jsl	~~eval_integer
	sta	<L597+count_1
	lda	<L597+count_1
	bmi	L606
	brl	L10415
L606:
	lda	#$1000
	sta	<L597+count_1
	brl	L10416
L10415:
	lda	<L597+count_1
	beq	L607
	brl	L10417
L607:
	lda	#$1
	sta	<L597+count_1
L10417:
L10416:
	brl	L10418
L10414:
	lda	#$1000
	sta	<L597+count_1
L10418:
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
	bne	L608
	brl	L10419
L608:
	pea	#<$29
	pea	#4
	jsl	~~error
L10419:
	inc	|~~basicvars+62
	bne	L609
	inc	|~~basicvars+62+2
L609:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$3d
	rep	#$20
	longa	on
	bne	L610
	brl	L10420
L610:
	pea	#<$26
	pea	#4
	jsl	~~error
L10420:
	inc	|~~basicvars+62
	bne	L611
	inc	|~~basicvars+62+2
L611:
	jsl	~~expression
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	beq	L612
	brl	L10421
L612:
	pea	#<$5
	pea	#4
	jsl	~~error
L10421:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L597+stringtype_1
	lda	<L597+stringtype_1
	cmp	#<$4
	bne	L613
	brl	L10422
L613:
	lda	<L597+stringtype_1
	cmp	#<$5
	bne	L614
	brl	L10422
L614:
	pea	#<$40
	pea	#4
	jsl	~~error
L10422:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L597+rhstring_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	lda	<L597+destination_1
	cmp	#<$4
	beq	L615
	brl	L10423
L615:
	pei	<L597+destination_1+4
	pei	<L597+destination_1+2
	clc
	tdc
	adc	#<L597+lhstring_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	brl	L10424
L10423:
	ldy	#$0
	lda	<L597+destination_1+2
	bpl	L616
	dey
L616:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars+6
	adc	<R0
	sta	<L597+lhstring_1+2
	lda	|~~basicvars+6+2
	adc	<R0+2
	sta	<L597+lhstring_1+4
	pei	<L597+destination_1+2
	jsl	~~get_stringlen
	sta	<L597+lhstring_1
L10424:
	sec
	lda	<L597+lhstring_1
	sbc	<L597+start_1
	bvs	L617
	eor	#$8000
L617:
	bmi	L618
	brl	L10425
L618:
	dec	<L597+start_1
	sec
	lda	<L597+rhstring_1
	sbc	<L597+count_1
	bvs	L619
	eor	#$8000
L619:
	bpl	L620
	brl	L10426
L620:
	lda	<L597+rhstring_1
	sta	<L597+count_1
L10426:
	clc
	lda	<L597+start_1
	adc	<L597+count_1
	sta	<R0
	sec
	lda	<L597+lhstring_1
	sbc	<R0
	bvs	L621
	eor	#$8000
L621:
	bpl	L622
	brl	L10427
L622:
	sec
	lda	<L597+lhstring_1
	sbc	<L597+start_1
	sta	<L597+count_1
L10427:
	sec
	lda	#$0
	sbc	<L597+count_1
	bvs	L623
	eor	#$8000
L623:
	bpl	L624
	brl	L10428
L624:
	ldy	#$0
	lda	<L597+count_1
	bpl	L625
	dey
L625:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L597+rhstring_1+4
	pei	<L597+rhstring_1+2
	ldy	#$0
	lda	<L597+start_1
	bpl	L626
	dey
L626:
	sta	<R1
	sty	<R1+2
	clc
	lda	<L597+lhstring_1+2
	adc	<R1
	sta	<R2
	lda	<L597+lhstring_1+4
	adc	<R1+2
	sta	<R2+2
	pei	<R2+2
	pei	<R2
	jsl	~~memmove
L10428:
L10425:
	lda	<L597+stringtype_1
	cmp	#<$5
	beq	L627
	brl	L10429
L627:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L597+rhstring_1
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
L10429:
L628:
	pld
	tsc
	clc
	adc	#L596
	tcs
	rtl
L596	equ	36
L597	equ	13
	ends
	efunc
	code
	func
~~assign_page:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L629
	tcs
	phd
	tcd
offset_1	set	0
	inc	|~~basicvars+62
	bne	L631
	inc	|~~basicvars+62+2
L631:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$3d
	rep	#$20
	longa	on
	bne	L632
	brl	L10430
L632:
	pea	#<$26
	pea	#4
	jsl	~~error
L10430:
	inc	|~~basicvars+62
	bne	L633
	inc	|~~basicvars+62+2
L633:
	jsl	~~eval_integer
	sta	<L630+offset_1
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	beq	L634
	brl	L10431
L634:
	pea	#<$5
	pea	#4
	jsl	~~error
L10431:
	lda	<L630+offset_1
	bpl	L636
	brl	L635
L636:
	sec
	lda	<L630+offset_1
	sbc	|~~basicvars+4
	bvs	L637
	eor	#$8000
L637:
	bmi	L638
	brl	L10432
L638:
L635:
	pea	#<$60
	pea	#4
	jsl	~~error
L639:
	pld
	tsc
	clc
	adc	#L629
	tcs
	rtl
L10432:
	ldy	#$0
	lda	<L630+offset_1
	bpl	L640
	dey
L640:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars+6
	adc	<R0
	sta	|~~basicvars+18
	lda	|~~basicvars+6+2
	adc	<R0+2
	sta	|~~basicvars+18+2
	jsl	~~clear_program
	brl	L639
L629	equ	6
L630	equ	5
	ends
	efunc
	code
	func
~~assign_ptr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L641
	tcs
	phd
	tcd
handle_1	set	0
newplace_1	set	2
	inc	|~~basicvars+62
	bne	L643
	inc	|~~basicvars+62+2
L643:
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
	bne	L644
	brl	L10433
L644:
	pea	#<$2c
	pea	#4
	jsl	~~error
L10433:
	inc	|~~basicvars+62
	bne	L645
	inc	|~~basicvars+62+2
L645:
	jsl	~~eval_intfactor
	sta	<L642+handle_1
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$3d
	rep	#$20
	longa	on
	bne	L646
	brl	L10434
L646:
	pea	#<$26
	pea	#4
	jsl	~~error
L10434:
	inc	|~~basicvars+62
	bne	L647
	inc	|~~basicvars+62+2
L647:
	jsl	~~eval_integer
	sta	<L642+newplace_1
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	beq	L648
	brl	L10435
L648:
	pea	#<$5
	pea	#4
	jsl	~~error
L10435:
	pei	<L642+newplace_1
	pei	<L642+handle_1
	jsl	~~fileio_setptr
L649:
	pld
	tsc
	clc
	adc	#L641
	tcs
	rtl
L641	equ	8
L642	equ	5
	ends
	efunc
	code
	func
~~assign_right:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L650
	tcs
	phd
	tcd
count_1	set	0
destination_1	set	2
stringtype_1	set	8
lhstring_1	set	10
rhstring_1	set	16
	inc	|~~basicvars+62
	bne	L652
	inc	|~~basicvars+62+2
L652:
	pea	#0
	clc
	tdc
	adc	#<L651+destination_1
	pha
	jsl	~~get_lvalue
	lda	<L651+destination_1
	cmp	#<$4
	bne	L653
	brl	L10436
L653:
	lda	<L651+destination_1
	cmp	#<$15
	bne	L654
	brl	L10436
L654:
	pea	#<$40
	pea	#4
	jsl	~~error
L10436:
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
	beq	L655
	brl	L10437
L655:
	inc	|~~basicvars+62
	bne	L656
	inc	|~~basicvars+62+2
L656:
	jsl	~~eval_integer
	sta	<L651+count_1
	lda	<L651+count_1
	bmi	L657
	brl	L10438
L657:
	stz	<L651+count_1
L10438:
	brl	L10439
L10437:
	lda	#$1000
	sta	<L651+count_1
L10439:
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
	bne	L658
	brl	L10440
L658:
	pea	#<$29
	pea	#4
	jsl	~~error
L10440:
	inc	|~~basicvars+62
	bne	L659
	inc	|~~basicvars+62+2
L659:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$3d
	rep	#$20
	longa	on
	bne	L660
	brl	L10441
L660:
	pea	#<$26
	pea	#4
	jsl	~~error
L10441:
	inc	|~~basicvars+62
	bne	L661
	inc	|~~basicvars+62+2
L661:
	jsl	~~expression
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	beq	L662
	brl	L10442
L662:
	pea	#<$5
	pea	#4
	jsl	~~error
L10442:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L651+stringtype_1
	lda	<L651+stringtype_1
	cmp	#<$4
	bne	L663
	brl	L10443
L663:
	lda	<L651+stringtype_1
	cmp	#<$5
	bne	L664
	brl	L10443
L664:
	pea	#<$40
	pea	#4
	jsl	~~error
L10443:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L651+rhstring_1
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
	sbc	<L651+count_1
	bvs	L665
	eor	#$8000
L665:
	bpl	L666
	brl	L10444
L666:
	lda	<L651+destination_1
	cmp	#<$4
	beq	L667
	brl	L10445
L667:
	pei	<L651+destination_1+4
	pei	<L651+destination_1+2
	clc
	tdc
	adc	#<L651+lhstring_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	brl	L10446
L10445:
	ldy	#$0
	lda	<L651+destination_1+2
	bpl	L668
	dey
L668:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars+6
	adc	<R0
	sta	<L651+lhstring_1+2
	lda	|~~basicvars+6+2
	adc	<R0+2
	sta	<L651+lhstring_1+4
	pei	<L651+destination_1+2
	jsl	~~get_stringlen
	sta	<L651+lhstring_1
L10446:
	sec
	lda	<L651+rhstring_1
	sbc	<L651+count_1
	bvs	L669
	eor	#$8000
L669:
	bpl	L670
	brl	L10447
L670:
	lda	<L651+rhstring_1
	sta	<L651+count_1
L10447:
	sec
	lda	<L651+lhstring_1
	sbc	<L651+count_1
	bvs	L671
	eor	#$8000
L671:
	bmi	L672
	brl	L10448
L672:
	ldy	#$0
	lda	<L651+count_1
	bpl	L673
	dey
L673:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L651+rhstring_1+4
	pei	<L651+rhstring_1+2
	ldy	#$0
	lda	<L651+count_1
	bpl	L674
	dey
L674:
	sta	<R1
	sty	<R1+2
	ldy	#$0
	lda	<L651+lhstring_1
	bpl	L675
	dey
L675:
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
	lda	<L651+lhstring_1+2
	adc	<R3
	sta	<R1
	lda	<L651+lhstring_1+4
	adc	<R3+2
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	jsl	~~memmove
L10448:
L10444:
	lda	<L651+stringtype_1
	cmp	#<$5
	beq	L676
	brl	L10449
L676:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L651+rhstring_1
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
L10449:
L677:
	pld
	tsc
	clc
	adc	#L650
	tcs
	rtl
L650	equ	38
L651	equ	17
	ends
	efunc
	code
	func
~~assign_time:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L678
	tcs
	phd
	tcd
time_1	set	0
	inc	|~~basicvars+62
	bne	L680
	inc	|~~basicvars+62+2
L680:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$3d
	rep	#$20
	longa	on
	bne	L681
	brl	L10450
L681:
	pea	#<$26
	pea	#4
	jsl	~~error
L10450:
	inc	|~~basicvars+62
	bne	L682
	inc	|~~basicvars+62+2
L682:
	jsl	~~eval_integer
	sta	<L679+time_1
	jsl	~~check_ateol
	pei	<L679+time_1
	jsl	~~emulate_setime
L683:
	pld
	tsc
	clc
	adc	#L678
	tcs
	rtl
L678	equ	6
L679	equ	5
	ends
	efunc
	code
	func
~~assign_timedol:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L684
	tcs
	phd
	tcd
time_1	set	0
stringtype_1	set	6
	inc	|~~basicvars+62
	bne	L686
	inc	|~~basicvars+62+2
L686:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$3d
	rep	#$20
	longa	on
	bne	L687
	brl	L10451
L687:
	pea	#<$26
	pea	#4
	jsl	~~error
L10451:
	inc	|~~basicvars+62
	bne	L688
	inc	|~~basicvars+62+2
L688:
	jsl	~~expression
	jsl	~~check_ateol
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L685+stringtype_1
	lda	<L685+stringtype_1
	cmp	#<$4
	bne	L689
	brl	L10452
L689:
	lda	<L685+stringtype_1
	cmp	#<$5
	bne	L690
	brl	L10452
L690:
	pea	#<$40
	pea	#4
	jsl	~~error
L10452:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L685+time_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	pei	<L685+time_1
	pei	<L685+time_1+4
	pei	<L685+time_1+2
	jsl	~~tocstring
	sta	<R0
	stx	<R0+2
	phx
	pha
	jsl	~~emulate_setimedol
	lda	<L685+stringtype_1
	cmp	#<$5
	beq	L691
	brl	L10453
L691:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L685+time_1
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
L10453:
L692:
	pld
	tsc
	clc
	adc	#L684
	tcs
	rtl
L684	equ	16
L685	equ	9
	ends
	efunc
	data
~~pseudovars:
	dl	$0
	dl	~~assign_himem
	dl	~~assign_ext
	dl	~~assign_filepath
	dl	~~assign_left
	dl	~~assign_lomem
	dl	~~assign_mid
	dl	~~assign_page
	dl	~~assign_ptr
	dl	~~assign_right
	dl	~~assign_time
	dl	~~assign_timedol
	ends
	code
	xdef	~~assign_pseudovar
	func
~~assign_pseudovar:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L693
	tcs
	phd
	tcd
token_1	set	0
	inc	|~~basicvars+62
	bne	L695
	inc	|~~basicvars+62+2
L695:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	sta	<L694+token_1
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	lda	<L694+token_1
	cmp	#<$1
	rep	#$20
	longa	on
	bcs	L696
	brl	L10454
L696:
	sep	#$20
	longa	off
	lda	#$b
	cmp	<L694+token_1
	rep	#$20
	longa	on
	bcs	L697
	brl	L10454
L697:
	lda	<L694+token_1
	and	#$ff
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~pseudovars
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	tax
	lda	(<R1)
	xref	~~~lcal
	jsl	~~~lcal
	brl	L10455
L10454:
	sep	#$20
	longa	off
	lda	#$42
	cmp	<L694+token_1
	rep	#$20
	longa	on
	bcs	L698
	brl	L10456
L698:
	pea	#<$5
	pea	#4
	jsl	~~error
	brl	L10457
L10456:
	pea	#^L422
	pea	#<L422
	pea	#<$5c1
	pea	#<$82
	pea	#10
	jsl	~~error
L10457:
L10455:
L699:
	pld
	tsc
	clc
	adc	#L693
	tcs
	rtl
L693	equ	9
L694	equ	9
	ends
	efunc
	data
L422:
	db	$61,$73,$73,$69,$67,$6E,$00
	ends
	code
	xdef	~~exec_let
	func
~~exec_let:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L701
	tcs
	phd
	tcd
destination_1	set	0
	inc	|~~basicvars+62
	bne	L703
	inc	|~~basicvars+62+2
L703:
	pea	#0
	clc
	tdc
	adc	#<L702+destination_1
	pha
	jsl	~~get_lvalue
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$3d
	rep	#$20
	longa	on
	beq	L704
	brl	L10458
L704:
	inc	|~~basicvars+62
	bne	L705
	inc	|~~basicvars+62+2
L705:
	jsl	~~expression
	sec
	tsc
	sbc	#4
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L702+destination_1+2
	sta	<R1
	lda	#$0
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$4
	xref	~~~fmov
	jsl	~~~fmov
	lda	<L702+destination_1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~assign_table
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	tax
	lda	(<R1)
	xref	~~~lcal
	jsl	~~~lcal
	brl	L10459
L10458:
	pea	#<$26
	pea	#4
	jsl	~~error
L10459:
L706:
	pld
	tsc
	clc
	adc	#L701
	tcs
	rtl
L701	equ	14
L702	equ	9
	ends
	efunc
	xref	~~emulate_setimedol
	xref	~~emulate_setime
	xref	~~fileio_setext
	xref	~~fileio_setptr
	xref	~~check_ateol
	xref	~~get_lvalue
	xref	~~init_expressions
	xref	~~eval_intfactor
	xref	~~eval_integer
	xref	~~expression
	xref	~~check_arrays
	xref	~~clear_program
	xref	~~tocstring
	xref	~~store_float
	xref	~~store_integer
	xref	~~get_float
	xref	~~get_integer
	xref	~~check_write
	xref	~~error
	xref	~~clear_varlists
	xref	~~get_stringlen
	xref	~~clear_strings
	xref	~~resize_string
	xref	~~free_string
	xref	~~alloc_string
	xref	~~init_stack
	xref	~~pop_arraytemp
	xref	~~pop_array
	xref	~~pop_string
	xref	~~pop_float
	xref	~~pop_int
	xref	~~safestack
	xref	~~free_stackmem
	xref	~~clear_heap
	xref	~~clear_varptrs
	xref	~~tolower
	xref	~~isdigit
	xref	~~memcpy
	xref	~~memmove
	xref	~~strtol
	xref	~~free
	xref	~~malloc
	xref	~~ateol
	xref	~~nullstring
	xref	~~basicvars
	end
