;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
	code
	xdef	~~todigit
	func
~~todigit:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
x_0	set	4
	sep	#$20
	longa	off
	lda	<L2+x_0
	cmp	#<$30
	rep	#$20
	longa	on
	bcs	L4
	brl	L10001
L4:
	sep	#$20
	longa	off
	lda	#$39
	cmp	<L2+x_0
	rep	#$20
	longa	on
	bcs	L5
	brl	L10001
L5:
	lda	<L2+x_0
	and	#$ff
	sta	<R0
	clc
	lda	#$ffd0
	adc	<R0
L6:
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
L10001:
	sep	#$20
	longa	off
	lda	<L2+x_0
	cmp	#<$41
	rep	#$20
	longa	on
	bcs	L7
	brl	L10002
L7:
	sep	#$20
	longa	off
	lda	#$46
	cmp	<L2+x_0
	rep	#$20
	longa	on
	bcs	L8
	brl	L10002
L8:
	lda	<L2+x_0
	and	#$ff
	sta	<R0
	clc
	lda	#$ffc9
	adc	<R0
	brl	L6
L10002:
	sep	#$20
	longa	off
	lda	<L2+x_0
	cmp	#<$61
	rep	#$20
	longa	on
	bcs	L9
	brl	L10003
L9:
	sep	#$20
	longa	off
	lda	#$66
	cmp	<L2+x_0
	rep	#$20
	longa	on
	bcs	L10
	brl	L10003
L10:
	lda	<L2+x_0
	and	#$ff
	sta	<R0
	clc
	lda	#$ffa9
	adc	<R0
	brl	L6
L10003:
	lda	#$0
	brl	L6
L2	equ	4
L3	equ	5
	ends
	efunc
	code
	xdef	~~tonumber
	func
~~tonumber:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L11
	tcs
	phd
	tcd
cp_0	set	4
isinteger_0	set	8
intvalue_0	set	12
floatvalue_0	set	16
	udata
L10004:
	ds	4
	ends
	udata
L10005:
	ds	4
	ends
value_1	set	0
isint_1	set	2
isneg_1	set	3
negexp_1	set	4
digits_1	set	5
exponent_1	set	7
	stz	<L12+value_1
	stz	<L12+digits_1
	pei	<L11+cp_0+2
	pei	<L11+cp_0
	jsl	~~skip_blanks
	sta	<L11+cp_0
	stx	<L11+cp_0+2
	lda	[<L11+cp_0]
	and	#$ff
	brl	L10006
L10008:
	inc	<L11+cp_0
	bne	L13
	inc	<L11+cp_0+2
L13:
L10009:
	lda	[<L11+cp_0]
	and	#$ff
	pha
	jsl	~~isxdigit
	tax
	bne	L14
	brl	L10010
L14:
	inc	<L12+digits_1
	lda	<L12+value_1
	asl	A
	asl	A
	asl	A
	asl	A
	sta	<R0
	lda	[<L11+cp_0]
	pha
	jsl	~~todigit
	sta	<R1
	clc
	lda	<R1
	adc	<R0
	sta	<L12+value_1
	inc	<L11+cp_0
	bne	L15
	inc	<L11+cp_0+2
L15:
	brl	L10009
L10010:
	lda	<L12+digits_1
	beq	L16
	brl	L10011
L16:
	lda	#$22
	sta	[<L11+intvalue_0]
	stz	<L11+cp_0
	stz	<L11+cp_0+2
	brl	L10012
L10011:
	lda	<L12+value_1
	sta	[<L11+intvalue_0]
	sep	#$20
	longa	off
	lda	#$1
	sta	[<L11+isinteger_0]
	rep	#$20
	longa	on
L10012:
	brl	L10007
L10013:
	inc	<L11+cp_0
	bne	L17
	inc	<L11+cp_0+2
L17:
L10014:
	sep	#$20
	longa	off
	lda	[<L11+cp_0]
	cmp	#<$30
	rep	#$20
	longa	on
	bne	L19
	brl	L18
L19:
	sep	#$20
	longa	off
	lda	[<L11+cp_0]
	cmp	#<$31
	rep	#$20
	longa	on
	beq	L20
	brl	L10015
L20:
L18:
	inc	<L12+digits_1
	lda	[<L11+cp_0]
	and	#$ff
	sta	<R0
	lda	<L12+value_1
	asl	A
	sta	<R1
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	clc
	lda	#$ffd0
	adc	<R2
	sta	<L12+value_1
	inc	<L11+cp_0
	bne	L21
	inc	<L11+cp_0+2
L21:
	brl	L10014
L10015:
	lda	<L12+digits_1
	beq	L22
	brl	L10016
L22:
	lda	#$23
	sta	[<L11+intvalue_0]
	stz	<L11+cp_0
	stz	<L11+cp_0+2
	brl	L10017
L10016:
	lda	<L12+value_1
	sta	[<L11+intvalue_0]
	sep	#$20
	longa	off
	lda	#$1
	sta	[<L11+isinteger_0]
	rep	#$20
	longa	on
L10017:
	brl	L10007
L10018:
	sep	#$20
	longa	off
	lda	#$1
	sta	<L12+isint_1
	rep	#$20
	longa	on
	stz	<R0
	sep	#$20
	longa	off
	lda	[<L11+cp_0]
	cmp	#<$2d
	rep	#$20
	longa	on
	beq	L24
	brl	L23
L24:
	inc	<R0
L23:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L12+isneg_1
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	lda	[<L11+cp_0]
	cmp	#<$2b
	rep	#$20
	longa	on
	bne	L26
	brl	L25
L26:
	sep	#$20
	longa	off
	lda	[<L11+cp_0]
	cmp	#<$2d
	rep	#$20
	longa	on
	beq	L27
	brl	L10019
L27:
L25:
	inc	<L11+cp_0
	bne	L28
	inc	<L11+cp_0+2
L28:
L10019:
L10020:
	sep	#$20
	longa	off
	lda	[<L11+cp_0]
	cmp	#<$30
	rep	#$20
	longa	on
	bcs	L29
	brl	L10021
L29:
	sep	#$20
	longa	off
	lda	#$39
	cmp	[<L11+cp_0]
	rep	#$20
	longa	on
	bcs	L30
	brl	L10021
L30:
	stz	<L12+digits_1
	lda	<L12+isint_1
	and	#$ff
	bne	L31
	brl	L10022
L31:
	ldy	#$0
	lda	<L12+value_1
	bpl	L32
	dey
L32:
	sta	<R0
	sty	<R0+2
	sec
	lda	<R0
	sbc	#<$ccccccc
	lda	<R0+2
	sbc	#^$ccccccc
	bvs	L33
	eor	#$8000
L33:
	bmi	L34
	brl	L10022
L34:
	sep	#$20
	longa	off
	stz	<L12+isint_1
	rep	#$20
	longa	on
	ldy	#$0
	lda	<L12+value_1
	bpl	L35
	dey
L35:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	pla
	sta	|L10004
	pla
	sta	|L10004+2
L10022:
	lda	<L12+isint_1
	and	#$ff
	bne	L36
	brl	L10023
L36:
	lda	[<L11+cp_0]
	and	#$ff
	sta	<R0
	lda	<L12+value_1
	asl	A
	asl	A
	adc	<L12+value_1
	asl	A
	sta	<R1
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	clc
	lda	#$ffd0
	adc	<R2
	sta	<L12+value_1
	brl	L10024
L10023:
	lda	[<L11+cp_0]
	and	#$ff
	sta	<R0
	clc
	lda	#$ffd0
	adc	<R0
	sta	<R1
	ldy	#$0
	lda	<R1
	bpl	L37
	dey
L37:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~ftod
	jsl	~~~ftod
	pea	#$4024
	pea	#$0000
	pea	#$0000
	pea	#$0000
	lda	|L10004+2
	pha
	lda	|L10004
	pha
	xref	~~~ftod
	jsl	~~~ftod
	xref	~~~dmul
	jsl	~~~dmul
	xref	~~~dadc
	jsl	~~~dadc
	xref	~~~dtof
	jsl	~~~dtof
	pla
	sta	|L10004
	pla
	sta	|L10004+2
L10024:
	inc	<L12+digits_1
	inc	<L11+cp_0
	bne	L38
	inc	<L11+cp_0+2
L38:
	brl	L10020
L10021:
	lda	<L12+isint_1
	and	#$ff
	beq	L39
	brl	L10025
L39:
	sep	#$20
	longa	off
	lda	[<L11+cp_0]
	cmp	#<$2e
	rep	#$20
	longa	on
	bne	L40
	brl	L10025
L40:
	sep	#$20
	longa	off
	lda	[<L11+cp_0]
	cmp	#<$45
	rep	#$20
	longa	on
	bne	L41
	brl	L10025
L41:
	lda	|L10004+2
	pha
	lda	|L10004
	pha
	pea	#$4F00
	pea	#$0000
	xref	~~~fcmp
	jsl	~~~fcmp
	bpl	L42
	brl	L10025
L42:
	lda	|L10004+2
	pha
	lda	|L10004
	pha
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R0
	pla
	sta	<R0+2
	lda	<R0
	sta	<L12+value_1
	sep	#$20
	longa	off
	lda	#$1
	sta	<L12+isint_1
	rep	#$20
	longa	on
L10025:
	sep	#$20
	longa	off
	lda	[<L11+cp_0]
	cmp	#<$2e
	rep	#$20
	longa	on
	beq	L43
	brl	L10026
L43:
	lda	<L12+isint_1
	and	#$ff
	bne	L44
	brl	L10027
L44:
	sep	#$20
	longa	off
	stz	<L12+isint_1
	rep	#$20
	longa	on
	ldy	#$0
	lda	<L12+value_1
	bpl	L45
	dey
L45:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	pla
	sta	|L10004
	pla
	sta	|L10004+2
L10027:
	lda	#$0
	sta	|L10005
	lda	#$3f80
	sta	|L10005+2
	inc	<L11+cp_0
	bne	L46
	inc	<L11+cp_0+2
L46:
L10028:
	sep	#$20
	longa	off
	lda	[<L11+cp_0]
	cmp	#<$30
	rep	#$20
	longa	on
	bcs	L47
	brl	L10029
L47:
	sep	#$20
	longa	off
	lda	#$39
	cmp	[<L11+cp_0]
	rep	#$20
	longa	on
	bcs	L48
	brl	L10029
L48:
	lda	[<L11+cp_0]
	and	#$ff
	sta	<R0
	clc
	lda	#$ffd0
	adc	<R0
	sta	<R1
	ldy	#$0
	lda	<R1
	bpl	L49
	dey
L49:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~ftod
	jsl	~~~ftod
	pea	#$4024
	pea	#$0000
	pea	#$0000
	pea	#$0000
	lda	|L10004+2
	pha
	lda	|L10004
	pha
	xref	~~~ftod
	jsl	~~~ftod
	xref	~~~dmul
	jsl	~~~dmul
	xref	~~~dadc
	jsl	~~~dadc
	xref	~~~dtof
	jsl	~~~dtof
	pla
	sta	|L10004
	pla
	sta	|L10004+2
	pea	#$4024
	pea	#$0000
	pea	#$0000
	pea	#$0000
	lda	|L10005+2
	pha
	lda	|L10005
	pha
	xref	~~~ftod
	jsl	~~~ftod
	xref	~~~dmul
	jsl	~~~dmul
	xref	~~~dtof
	jsl	~~~dtof
	pla
	sta	|L10005
	pla
	sta	|L10005+2
	inc	<L11+cp_0
	bne	L50
	inc	<L11+cp_0+2
L50:
	brl	L10028
L10029:
	lda	|L10005+2
	pha
	lda	|L10005
	pha
	lda	|L10004+2
	pha
	lda	|L10004
	pha
	xref	~~~fdiv
	jsl	~~~fdiv
	pla
	sta	|L10004
	pla
	sta	|L10004+2
L10026:
	lda	[<L11+cp_0]
	and	#$ff
	pha
	jsl	~~toupper
	sta	<R0
	lda	<R0
	cmp	#<$45
	beq	L51
	brl	L10030
L51:
	ldy	#$1
	lda	[<L11+cp_0],Y
	and	#$ff
	pha
	jsl	~~isalpha
	tax
	beq	L52
	brl	L10030
L52:
	lda	<L12+isint_1
	and	#$ff
	bne	L53
	brl	L10031
L53:
	sep	#$20
	longa	off
	stz	<L12+isint_1
	rep	#$20
	longa	on
	ldy	#$0
	lda	<L12+value_1
	bpl	L54
	dey
L54:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	pla
	sta	|L10004
	pla
	sta	|L10004+2
L10031:
	stz	<L12+exponent_1
	inc	<L11+cp_0
	bne	L55
	inc	<L11+cp_0+2
L55:
	stz	<R0
	sep	#$20
	longa	off
	lda	[<L11+cp_0]
	cmp	#<$2d
	rep	#$20
	longa	on
	beq	L57
	brl	L56
L57:
	inc	<R0
L56:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L12+negexp_1
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	lda	[<L11+cp_0]
	cmp	#<$2b
	rep	#$20
	longa	on
	bne	L59
	brl	L58
L59:
	sep	#$20
	longa	off
	lda	[<L11+cp_0]
	cmp	#<$2d
	rep	#$20
	longa	on
	beq	L60
	brl	L10032
L60:
L58:
	inc	<L11+cp_0
	bne	L61
	inc	<L11+cp_0+2
L61:
L10032:
L10033:
	sep	#$20
	longa	off
	lda	[<L11+cp_0]
	cmp	#<$30
	rep	#$20
	longa	on
	bcs	L62
	brl	L10034
L62:
	sep	#$20
	longa	off
	lda	#$39
	cmp	[<L11+cp_0]
	rep	#$20
	longa	on
	bcs	L63
	brl	L10034
L63:
	sec
	lda	#$134
	sbc	<L12+exponent_1
	bvs	L64
	eor	#$8000
L64:
	bmi	L65
	brl	L10034
L65:
	lda	[<L11+cp_0]
	and	#$ff
	sta	<R0
	lda	<L12+exponent_1
	asl	A
	asl	A
	adc	<L12+exponent_1
	asl	A
	sta	<R1
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	clc
	lda	#$ffd0
	adc	<R2
	sta	<L12+exponent_1
	inc	<L11+cp_0
	bne	L66
	inc	<L11+cp_0+2
L66:
	brl	L10033
L10034:
	lda	<L12+negexp_1
	and	#$ff
	bne	L67
	brl	L10035
L67:
	sec
	lda	<L12+exponent_1
	sbc	<L12+digits_1
	sta	<R0
	sec
	lda	#$134
	sbc	<R0
	bvs	L68
	eor	#$8000
L68:
	bmi	L69
	brl	L10036
L69:
	sec
	lda	#$0
	sbc	<L12+exponent_1
	sta	<L12+exponent_1
	brl	L10037
L10036:
	stz	<L12+exponent_1
	lda	#$0
	sta	|L10004
	lda	#$0
	sta	|L10004+2
L10037:
	brl	L10038
L10035:
	clc
	lda	<L12+exponent_1
	adc	<L12+digits_1
	sta	<R0
	clc
	lda	#$ffff
	adc	<R0
	sta	<R1
	sec
	lda	#$134
	sbc	<R1
	bvs	L70
	eor	#$8000
L70:
	bpl	L71
	brl	L10039
L71:
	lda	#$24
	sta	[<L11+intvalue_0]
	stz	<L11+cp_0
	stz	<L11+cp_0+2
	stz	<L12+exponent_1
L10039:
L10038:
	lda	|L10004+2
	pha
	lda	|L10004
	pha
	xref	~~~ftod
	jsl	~~~ftod
	phy
	phy
	phy
	phy
	ldy	#$0
	lda	<L12+exponent_1
	bpl	L72
	dey
L72:
	phy
	pha
	xref	~~~dflt
	jsl	~~~dflt
	pea	#$4024
	pea	#$0000
	pea	#$0000
	pea	#$0000
	jsl	~~pow
	xref	~~~dmul
	jsl	~~~dmul
	xref	~~~dtof
	jsl	~~~dtof
	pla
	sta	|L10004
	pla
	sta	|L10004+2
L10030:
	sep	#$20
	longa	off
	lda	<L12+isint_1
	sta	[<L11+isinteger_0]
	rep	#$20
	longa	on
	lda	<L12+isint_1
	and	#$ff
	bne	L73
	brl	L10040
L73:
	lda	<L12+isneg_1
	and	#$ff
	bne	L75
	brl	L74
L75:
	sec
	lda	#$0
	sbc	<L12+value_1
	bra	L76
L74:
	lda	<L12+value_1
L76:
	sta	[<L11+intvalue_0]
	brl	L10041
L10040:
	lda	<L12+isneg_1
	and	#$ff
	bne	L78
	brl	L77
L78:
	lda	|L10004+2
	pha
	lda	|L10004
	pha
	xref	~~~fneg
	jsl	~~~fneg
	bra	L79
L77:
	lda	|L10004+2
	pha
	lda	|L10004
	pha
L79:
	pla
	sta	[<L11+floatvalue_0]
	pla
	ldy	#$2
	sta	[<L11+floatvalue_0],Y
L10041:
	brl	L10007
L10006:
	xref	~~~swt
	jsl	~~~swt
	dw	2
	dw	37
	dw	L10013-1
	dw	38
	dw	L10008-1
	dw	L10018-1
L10007:
	ldx	<L11+cp_0+2
	lda	<L11+cp_0
L80:
	tay
	lda	<L11+2
	sta	<L11+2+16
	lda	<L11+1
	sta	<L11+1+16
	pld
	tsc
	clc
	adc	#L11+16
	tcs
	tya
	rtl
L11	equ	21
L12	equ	13
	ends
	efunc
	code
	xdef	~~itob
	func
~~itob:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L81
	tcs
	phd
	tcd
dest_0	set	4
value_0	set	8
width_0	set	10
count_1	set	0
n_1	set	2
temp_1	set	4
	stz	<L82+n_1
	brl	L10045
L10044:
	lda	<L81+value_0
	and	#<$1
	sta	<R0
	clc
	lda	#$30
	adc	<R0
	sep	#$20
	longa	off
	ldx	<L82+n_1
	sta	<L82+temp_1,X
	rep	#$20
	longa	on
	lda	<L81+value_0
	asl	A
	ror	<L81+value_0
L10042:
	inc	<L82+n_1
L10045:
	lda	<L82+n_1
	cmp	#<$10
	bcs	L83
	brl	L10044
L83:
L10043:
	lda	#$f
	sta	<L82+n_1
L10046:
	sec
	lda	#$0
	sbc	<L82+n_1
	bvs	L84
	eor	#$8000
L84:
	bpl	L85
	brl	L10047
L85:
	sep	#$20
	longa	off
	ldx	<L82+n_1
	lda	<L82+temp_1,X
	cmp	#<$30
	rep	#$20
	longa	on
	beq	L86
	brl	L10047
L86:
	dec	<L82+n_1
	brl	L10046
L10047:
	lda	<L82+n_1
	ina
	sta	<L82+count_1
L10048:
	lda	<L82+n_1
	bpl	L87
	brl	L10049
L87:
	sep	#$20
	longa	off
	ldx	<L82+n_1
	lda	<L82+temp_1,X
	sta	[<L81+dest_0]
	rep	#$20
	longa	on
	inc	<L81+dest_0
	bne	L88
	inc	<L81+dest_0+2
L88:
	dec	<L82+n_1
	brl	L10048
L10049:
	sep	#$20
	longa	off
	lda	#$0
	sta	[<L81+dest_0]
	rep	#$20
	longa	on
	lda	<L82+count_1
L89:
	tay
	lda	<L81+2
	sta	<L81+2+8
	lda	<L81+1
	sta	<L81+1+8
	pld
	tsc
	clc
	adc	#L81+8
	tcs
	tya
	rtl
L81	equ	24
L82	equ	5
	ends
	efunc
	xref	~~skip_blanks
	xref	~~pow
	xref	~~isxdigit
	xref	~~toupper
	xref	~~isalpha
	end
