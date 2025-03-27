;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
	code
	func
~~fn_spc:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
count_1	set	0
	jsl	~~eval_intfactor
	sta	<L3+count_1
	sec
	lda	#$0
	sbc	<L3+count_1
	bvs	L4
	eor	#$8000
L4:
	bpl	L5
	brl	L10001
L5:
	lda	#$ff00
	trb	<L3+count_1
	clc
	lda	|~~basicvars+494
	adc	<L3+count_1
	sta	|~~basicvars+494
L10002:
	sec
	lda	#$0
	sbc	<L3+count_1
	bvs	L6
	eor	#$8000
L6:
	bpl	L7
	brl	L10003
L7:
	pea	#<$20
	jsl	~~emulate_vdu
	dec	<L3+count_1
	brl	L10002
L10003:
L10001:
L8:
	pld
	tsc
	clc
	adc	#L2
	tcs
	rtl
L2	equ	2
L3	equ	1
	ends
	efunc
	code
	func
~~fn_tab:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L9
	tcs
	phd
	tcd
x_1	set	0
y_1	set	2
	jsl	~~eval_integer
	sta	<L10+x_1
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
	beq	L11
	brl	L10004
L11:
	sec
	lda	#$0
	sbc	<L10+x_1
	bvs	L12
	eor	#$8000
L12:
	bpl	L13
	brl	L10005
L13:
	lda	#$ff00
	trb	<L10+x_1
	sec
	lda	<L10+x_1
	sbc	|~~basicvars+494
	bvs	L14
	eor	#$8000
L14:
	bpl	L15
	brl	L10006
L15:
	jsl	~~emulate_newline
	stz	|~~basicvars+494
L10006:
	sec
	lda	<L10+x_1
	sbc	|~~basicvars+494
	sta	<L10+x_1
	clc
	lda	|~~basicvars+494
	adc	<L10+x_1
	sta	|~~basicvars+494
L10007:
	sec
	lda	#$0
	sbc	<L10+x_1
	bvs	L16
	eor	#$8000
L16:
	bpl	L17
	brl	L10008
L17:
	pea	#<$20
	jsl	~~emulate_vdu
	dec	<L10+x_1
	brl	L10007
L10008:
L10005:
	brl	L10009
L10004:
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
	beq	L18
	brl	L10010
L18:
	inc	|~~basicvars+62
	bne	L19
	inc	|~~basicvars+62+2
L19:
	jsl	~~eval_integer
	sta	<L10+y_1
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
	bne	L20
	brl	L10011
L20:
	pea	#<$29
	pea	#4
	jsl	~~error
L10011:
	pei	<L10+y_1
	pei	<L10+x_1
	jsl	~~emulate_tab
	brl	L10012
L10010:
	pea	#<$32
	pea	#4
	jsl	~~error
L10012:
L10009:
	inc	|~~basicvars+62
	bne	L21
	inc	|~~basicvars+62+2
L21:
L22:
	pld
	tsc
	clc
	adc	#L9
	tcs
	rtl
L9	equ	8
L10	equ	5
	ends
	efunc
	code
	func
~~input_number:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L23
	tcs
	phd
	tcd
destination_0	set	4
p_0	set	10
	udata
L10013:
	ds	4
	ends
isint_1	set	0
intvalue_1	set	1
	lda	#<L10013
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	pea	#0
	clc
	tdc
	adc	#<L24+intvalue_1
	pha
	pea	#0
	clc
	tdc
	adc	#<L24+isint_1
	pha
	pei	<L23+p_0+2
	pei	<L23+p_0
	jsl	~~tonumber
	sta	<L23+p_0
	stx	<L23+p_0+2
	lda	<L23+p_0
	ora	<L23+p_0+2
	beq	L25
	brl	L10014
L25:
	lda	#$0
	tax
	lda	#$0
L26:
	tay
	lda	<L23+2
	sta	<L23+2+10
	lda	<L23+1
	sta	<L23+1+10
	pld
	tsc
	clc
	adc	#L23+10
	tcs
	tya
	rtl
L10014:
L10015:
	lda	[<L23+p_0]
	and	#$ff
	bne	L27
	brl	L10016
L27:
	sep	#$20
	longa	off
	lda	[<L23+p_0]
	cmp	#<$2c
	rep	#$20
	longa	on
	bne	L28
	brl	L10016
L28:
	inc	<L23+p_0
	bne	L29
	inc	<L23+p_0+2
L29:
	brl	L10015
L10016:
	sep	#$20
	longa	off
	lda	[<L23+p_0]
	cmp	#<$2c
	rep	#$20
	longa	on
	beq	L30
	brl	L10017
L30:
	inc	<L23+p_0
	bne	L31
	inc	<L23+p_0+2
L31:
L10017:
	lda	<L23+destination_0
	brl	L10018
L10020:
	lda	<L24+isint_1
	and	#$ff
	bne	L33
	brl	L32
L33:
	lda	<L24+intvalue_1
	bra	L34
L32:
	lda	|L10013+2
	pha
	lda	|L10013
	pha
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R0
	pla
	sta	<R0+2
	lda	<R0
L34:
	sta	[<L23+destination_0+2]
	brl	L10019
L10021:
	lda	<L24+isint_1
	and	#$ff
	bne	L36
	brl	L35
L36:
	ldy	#$0
	lda	<L24+intvalue_1
	bpl	L37
	dey
L37:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	bra	L38
L35:
	lda	|L10013+2
	pha
	lda	|L10013
	pha
L38:
	pla
	sta	[<L23+destination_0+2]
	pla
	ldy	#$2
	sta	[<L23+destination_0+2],Y
	brl	L10019
L10022:
	pea	#<$1
	pei	<L23+destination_0+2
	jsl	~~check_write
	lda	|~~basicvars+6
	sta	<R0
	lda	|~~basicvars+6+2
	sta	<R0+2
	lda	<L24+isint_1
	and	#$ff
	bne	L40
	brl	L39
L40:
	lda	<L24+intvalue_1
	bra	L41
L39:
	lda	|L10013+2
	pha
	lda	|L10013
	pha
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R1
	pla
	sta	<R1+2
	lda	<R1
L41:
	sep	#$20
	longa	off
	ldy	<L23+destination_0+2
	sta	[<R0],Y
	rep	#$20
	longa	on
	brl	L10019
L10023:
	lda	<L24+isint_1
	and	#$ff
	bne	L43
	brl	L42
L43:
	lda	<L24+intvalue_1
	bra	L44
L42:
	lda	|L10013+2
	pha
	lda	|L10013
	pha
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R0
	pla
	sta	<R0+2
	lda	<R0
L44:
	pha
	pei	<L23+destination_0+2
	jsl	~~store_integer
	brl	L10019
L10024:
	lda	<L24+isint_1
	and	#$ff
	bne	L46
	brl	L45
L46:
	ldy	#$0
	lda	<L24+intvalue_1
	bpl	L47
	dey
L47:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	bra	L48
L45:
	lda	|L10013+2
	pha
	lda	|L10013
	pha
L48:
	pei	<L23+destination_0+2
	jsl	~~store_float
	brl	L10019
L10018:
	xref	~~~swt
	jsl	~~~swt
	dw	5
	dw	2
	dw	L10020-1
	dw	3
	dw	L10021-1
	dw	17
	dw	L10022-1
	dw	18
	dw	L10023-1
	dw	19
	dw	L10024-1
	dw	L10019-1
L10019:
	ldx	<L23+p_0+2
	lda	<L23+p_0
	brl	L26
L23	equ	11
L24	equ	9
	ends
	efunc
	code
	func
~~input_string:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L49
	tcs
	phd
	tcd
destination_0	set	4
p_0	set	10
inputall_0	set	14
cp_1	set	0
tempstring_1	set	4
more_1	set	132
index_1	set	133
	stz	<L50+index_1
	lda	<L49+inputall_0
	and	#$ff
	bne	L51
	brl	L10025
L51:
L10026:
	lda	[<L49+p_0]
	and	#$ff
	bne	L52
	brl	L10027
L52:
	lda	<L50+index_1
	cmp	#<$1000
	beq	L53
	brl	L10028
L53:
	pea	#<$3d
	pea	#4
	jsl	~~error
L10028:
	sep	#$20
	longa	off
	lda	[<L49+p_0]
	ldx	<L50+index_1
	sta	<L50+tempstring_1,X
	rep	#$20
	longa	on
	inc	<L50+index_1
	inc	<L49+p_0
	bne	L54
	inc	<L49+p_0+2
L54:
	brl	L10026
L10027:
	brl	L10029
L10025:
	pei	<L49+p_0+2
	pei	<L49+p_0
	jsl	~~skip_blanks
	sta	<L49+p_0
	stx	<L49+p_0+2
	sep	#$20
	longa	off
	lda	[<L49+p_0]
	cmp	#<$22
	rep	#$20
	longa	on
	beq	L55
	brl	L10030
L55:
	inc	<L49+p_0
	bne	L56
	inc	<L49+p_0+2
L56:
	stz	<R0
	lda	[<L49+p_0]
	and	#$ff
	bne	L58
	brl	L57
L58:
	inc	<R0
L57:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L50+more_1
	rep	#$20
	longa	on
L10031:
	lda	<L50+more_1
	and	#$ff
	bne	L59
	brl	L10032
L59:
	sep	#$20
	longa	off
	lda	[<L49+p_0]
	cmp	#<$22
	rep	#$20
	longa	on
	beq	L60
	brl	L10033
L60:
	inc	<L49+p_0
	bne	L61
	inc	<L49+p_0+2
L61:
	stz	<R0
	sep	#$20
	longa	off
	lda	[<L49+p_0]
	cmp	#<$22
	rep	#$20
	longa	on
	beq	L63
	brl	L62
L63:
	inc	<R0
L62:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L50+more_1
	rep	#$20
	longa	on
L10033:
	lda	<L50+more_1
	and	#$ff
	bne	L64
	brl	L10034
L64:
	lda	<L50+index_1
	cmp	#<$1000
	beq	L65
	brl	L10035
L65:
	pea	#<$3d
	pea	#4
	jsl	~~error
L10035:
	sep	#$20
	longa	off
	lda	[<L49+p_0]
	ldx	<L50+index_1
	sta	<L50+tempstring_1,X
	rep	#$20
	longa	on
	inc	<L50+index_1
	inc	<L49+p_0
	bne	L66
	inc	<L49+p_0+2
L66:
	lda	[<L49+p_0]
	and	#$ff
	beq	L67
	brl	L10036
L67:
	pea	#<$2a
	pea	#4
	jsl	~~error
L10036:
L10034:
	brl	L10031
L10032:
	brl	L10037
L10030:
L10038:
	lda	[<L49+p_0]
	and	#$ff
	bne	L68
	brl	L10039
L68:
	sep	#$20
	longa	off
	lda	[<L49+p_0]
	cmp	#<$2c
	rep	#$20
	longa	on
	bne	L69
	brl	L10039
L69:
	lda	<L50+index_1
	cmp	#<$1000
	beq	L70
	brl	L10040
L70:
	pea	#<$3d
	pea	#4
	jsl	~~error
L10040:
	sep	#$20
	longa	off
	lda	[<L49+p_0]
	ldx	<L50+index_1
	sta	<L50+tempstring_1,X
	rep	#$20
	longa	on
	inc	<L50+index_1
	inc	<L49+p_0
	bne	L71
	inc	<L49+p_0+2
L71:
	brl	L10038
L10039:
L10037:
L10041:
	lda	[<L49+p_0]
	and	#$ff
	bne	L72
	brl	L10042
L72:
	sep	#$20
	longa	off
	lda	[<L49+p_0]
	cmp	#<$2c
	rep	#$20
	longa	on
	bne	L73
	brl	L10042
L73:
	inc	<L49+p_0
	bne	L74
	inc	<L49+p_0+2
L74:
	brl	L10041
L10042:
	sep	#$20
	longa	off
	lda	[<L49+p_0]
	cmp	#<$2c
	rep	#$20
	longa	on
	beq	L75
	brl	L10043
L75:
	inc	<L49+p_0
	bne	L76
	inc	<L49+p_0+2
L76:
L10043:
L10029:
	lda	<L49+destination_0
	cmp	#<$4
	beq	L77
	brl	L10044
L77:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	pei	<L49+destination_0+4
	pei	<L49+destination_0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
	pei	<L50+index_1
	jsl	~~alloc_string
	sta	<L50+cp_1
	stx	<L50+cp_1+2
	ldy	#$0
	lda	<L50+index_1
	bpl	L78
	dey
L78:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pea	#0
	clc
	tdc
	adc	#<L50+tempstring_1
	pha
	pei	<L50+cp_1+2
	pei	<L50+cp_1
	jsl	~~memmove
	lda	<L50+index_1
	sta	[<L49+destination_0+2]
	lda	<L50+cp_1
	ldy	#$2
	sta	[<L49+destination_0+2],Y
	lda	<L50+cp_1+2
	ldy	#$4
	sta	[<L49+destination_0+2],Y
	brl	L10045
L10044:
	lda	<L50+index_1
	ina
	pha
	pei	<L49+destination_0+2
	jsl	~~check_write
	sep	#$20
	longa	off
	lda	#$d
	ldx	<L50+index_1
	sta	<L50+tempstring_1,X
	rep	#$20
	longa	on
	lda	<L50+index_1
	ina
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L79
	dey
L79:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pea	#0
	clc
	tdc
	adc	#<L50+tempstring_1
	pha
	ldy	#$0
	lda	<L49+destination_0+2
	bpl	L80
	dey
L80:
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
L10045:
	ldx	<L49+p_0+2
	lda	<L49+p_0
L81:
	tay
	lda	<L49+2
	sta	<L49+2+12
	lda	<L49+1
	sta	<L49+1+12
	pld
	tsc
	clc
	adc	#L49+12
	tcs
	tya
	rtl
L49	equ	147
L50	equ	13
	ends
	efunc
	code
	func
~~read_input:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L82
	tcs
	phd
	tcd
inputline_0	set	4
token_1	set	0
cp_1	set	1
line_1	set	5
destination_1	set	133
bad_1	set	139
prompted_1	set	140
n_1	set	141
length_1	set	143
L10048:
L10049:
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
	bne	L85
	brl	L84
L85:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$3b
	rep	#$20
	longa	on
	beq	L86
	brl	L10050
L86:
L84:
	inc	|~~basicvars+62
	bne	L87
	inc	|~~basicvars+62+2
L87:
	brl	L10049
L10050:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	sta	<L83+token_1
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	stz	<L83+line_1
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	stz	<L83+prompted_1
	rep	#$20
	longa	on
L10051:
	sep	#$20
	longa	off
	lda	<L83+token_1
	cmp	#<$17
	rep	#$20
	longa	on
	bne	L89
	brl	L88
L89:
	sep	#$20
	longa	off
	lda	<L83+token_1
	cmp	#<$18
	rep	#$20
	longa	on
	bne	L90
	brl	L88
L90:
	sep	#$20
	longa	off
	lda	<L83+token_1
	cmp	#<$27
	rep	#$20
	longa	on
	bne	L91
	brl	L88
L91:
	sep	#$20
	longa	off
	lda	<L83+token_1
	cmp	#<$fe
	rep	#$20
	longa	on
	beq	L92
	brl	L10052
L92:
L88:
	sep	#$20
	longa	off
	lda	#$1
	sta	<L83+prompted_1
	rep	#$20
	longa	on
	lda	<L83+token_1
	and	#$ff
	brl	L10053
L10055:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	ldy	#$3
	lda	[<R0],Y
	and	#$ff
	sta	<R0
	lda	|~~basicvars+62
	sta	<R2
	lda	|~~basicvars+62+2
	sta	<R2+2
	ldy	#$4
	lda	[<R2],Y
	and	#$ff
	sta	<R2
	lda	<R2
	xba
	and	#$ff00
	sta	<R1
	lda	<R1
	ora	<R0
	sta	<L83+length_1
	sec
	lda	#$0
	sbc	<L83+length_1
	bvs	L93
	eor	#$8000
L93:
	bpl	L94
	brl	L10056
L94:
	pei	<L83+length_1
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~get_srcaddr
	sta	<R0
	stx	<R0+2
	phx
	pha
	jsl	~~emulate_vdustr
L10056:
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~skip_token
	sta	|~~basicvars+62
	stx	|~~basicvars+62+2
	brl	L10054
L10057:
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~get_srcaddr
	sta	<L83+cp_1
	stx	<L83+cp_1+2
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	ldy	#$3
	lda	[<R0],Y
	and	#$ff
	sta	<R0
	lda	|~~basicvars+62
	sta	<R2
	lda	|~~basicvars+62+2
	sta	<R2+2
	ldy	#$4
	lda	[<R2],Y
	and	#$ff
	sta	<R2
	lda	<R2
	xba
	and	#$ff00
	sta	<R1
	lda	<R1
	ora	<R0
	sta	<L83+length_1
	stz	<L83+n_1
	brl	L10061
L10060:
	lda	[<L83+cp_1]
	and	#$ff
	pha
	jsl	~~emulate_vdu
	sep	#$20
	longa	off
	lda	[<L83+cp_1]
	cmp	#<$22
	rep	#$20
	longa	on
	beq	L95
	brl	L10062
L95:
	inc	<L83+cp_1
	bne	L96
	inc	<L83+cp_1+2
L96:
L10062:
	inc	<L83+cp_1
	bne	L97
	inc	<L83+cp_1+2
L97:
L10058:
	inc	<L83+n_1
L10061:
	sec
	lda	<L83+n_1
	sbc	<L83+length_1
	bvs	L98
	eor	#$8000
L98:
	bmi	L99
	brl	L10060
L99:
L10059:
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~skip_token
	sta	|~~basicvars+62
	stx	|~~basicvars+62+2
	brl	L10054
L10063:
	jsl	~~emulate_newline
	inc	|~~basicvars+62
	bne	L100
	inc	|~~basicvars+62+2
L100:
	brl	L10054
L10064:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	ldy	#$1
	lda	[<R0],Y
	and	#$ff
	brl	L10065
L10067:
	clc
	lda	#$2
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L101
	inc	|~~basicvars+62+2
L101:
	jsl	~~fn_spc
	brl	L10066
L10068:
	clc
	lda	#$2
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L102
	inc	|~~basicvars+62+2
L102:
	jsl	~~fn_tab
	brl	L10066
L10069:
	jsl	~~bad_token
	brl	L10066
L10065:
	xref	~~~swt
	jsl	~~~swt
	dw	2
	dw	1
	dw	L10067-1
	dw	2
	dw	L10068-1
	dw	L10069-1
L10066:
	brl	L10054
L10053:
	xref	~~~swt
	jsl	~~~swt
	dw	4
	dw	23
	dw	L10055-1
	dw	24
	dw	L10057-1
	dw	39
	dw	L10063-1
	dw	254
	dw	L10064-1
	dw	L10054-1
L10054:
L10070:
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
	bne	L104
	brl	L103
L104:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$3b
	rep	#$20
	longa	on
	beq	L105
	brl	L10071
L105:
L103:
	sep	#$20
	longa	off
	stz	<L83+prompted_1
	rep	#$20
	longa	on
	inc	|~~basicvars+62
	bne	L106
	inc	|~~basicvars+62+2
L106:
	brl	L10070
L10071:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	sta	<L83+token_1
	rep	#$20
	longa	on
	brl	L10051
L10052:
	clc
	tdc
	adc	#<L83+line_1
	sta	<L83+cp_1
	lda	#$0
	sta	<L83+cp_1+2
L10072:
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
	beq	L107
	brl	L10073
L107:
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	sep	#$20
	longa	off
	lda	[<R1]
	cmp	#<$17
	rep	#$20
	longa	on
	bne	L108
	brl	L10073
L108:
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	sep	#$20
	longa	off
	lda	[<R1]
	cmp	#<$18
	rep	#$20
	longa	on
	bne	L109
	brl	L10073
L109:
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	sep	#$20
	longa	off
	lda	[<R1]
	cmp	#<$27
	rep	#$20
	longa	on
	bne	L110
	brl	L10073
L110:
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	sep	#$20
	longa	off
	lda	[<R1]
	cmp	#<$fe
	rep	#$20
	longa	on
	bne	L111
	brl	L10073
L111:
	pea	#0
	clc
	tdc
	adc	#<L83+destination_1
	pha
	jsl	~~get_lvalue
	lda	[<L83+cp_1]
	and	#$ff
	beq	L112
	brl	L10074
L112:
	lda	<L83+prompted_1
	and	#$ff
	beq	L113
	brl	L10075
L113:
	pea	#<$3f
	jsl	~~emulate_vdu
L10075:
	sep	#$20
	longa	off
	stz	<L83+prompted_1
	rep	#$20
	longa	on
	pea	#<$400
	pea	#0
	clc
	tdc
	adc	#<L83+line_1
	pha
	jsl	~~read_line
	and	#$ff
	beq	L114
	brl	L10076
L114:
	pea	#<$8
	pea	#4
	jsl	~~error
L10076:
	clc
	tdc
	adc	#<L83+line_1
	sta	<L83+cp_1
	lda	#$0
	sta	<L83+cp_1+2
L10074:
	lda	<L83+destination_1
	brl	L10077
L10079:
L10080:
L10081:
L10082:
L10083:
L10086:
	pei	<L83+cp_1+2
	pei	<L83+cp_1
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L83+destination_1
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
	jsl	~~input_number
	sta	<L83+cp_1
	stx	<L83+cp_1+2
	stz	<R0
	lda	<L83+cp_1
	ora	<L83+cp_1+2
	beq	L116
	brl	L115
L116:
	inc	<R0
L115:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L83+bad_1
	rep	#$20
	longa	on
	lda	<L83+bad_1
	and	#$ff
	bne	L117
	brl	L10087
L117:
	pea	#<$3f
	jsl	~~emulate_vdu
	pea	#<$400
	pea	#0
	clc
	tdc
	adc	#<L83+line_1
	pha
	jsl	~~read_line
	and	#$ff
	beq	L118
	brl	L10088
L118:
	pea	#<$8
	pea	#4
	jsl	~~error
L10088:
	clc
	tdc
	adc	#<L83+line_1
	sta	<L83+cp_1
	lda	#$0
	sta	<L83+cp_1+2
L10087:
L10084:
	lda	<L83+bad_1
	and	#$ff
	beq	L119
	brl	L10086
L119:
L10085:
	brl	L10078
L10089:
L10090:
L10093:
	pei	<L82+inputline_0
	pei	<L83+cp_1+2
	pei	<L83+cp_1
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L83+destination_1
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
	jsl	~~input_string
	sta	<L83+cp_1
	stx	<L83+cp_1+2
	stz	<R0
	lda	<L83+cp_1
	ora	<L83+cp_1+2
	beq	L121
	brl	L120
L121:
	inc	<R0
L120:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L83+bad_1
	rep	#$20
	longa	on
	lda	<L83+bad_1
	and	#$ff
	bne	L122
	brl	L10094
L122:
	pea	#<$3f
	jsl	~~emulate_vdu
	pea	#<$400
	pea	#0
	clc
	tdc
	adc	#<L83+line_1
	pha
	jsl	~~read_line
	and	#$ff
	beq	L123
	brl	L10095
L123:
	pea	#<$8
	pea	#4
	jsl	~~error
L10095:
	clc
	tdc
	adc	#<L83+line_1
	sta	<L83+cp_1
	lda	#$0
	sta	<L83+cp_1+2
L10094:
L10091:
	lda	<L83+bad_1
	and	#$ff
	beq	L124
	brl	L10093
L124:
L10092:
	brl	L10078
L10096:
	pea	#<$45
	pea	#4
	jsl	~~error
	brl	L10078
L10077:
	xref	~~~swt
	jsl	~~~swt
	dw	7
	dw	2
	dw	L10079-1
	dw	3
	dw	L10080-1
	dw	4
	dw	L10089-1
	dw	17
	dw	L10081-1
	dw	18
	dw	L10082-1
	dw	19
	dw	L10083-1
	dw	21
	dw	L10090-1
	dw	L10096-1
L10078:
L10097:
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
	bne	L126
	brl	L125
L126:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$3b
	rep	#$20
	longa	on
	beq	L127
	brl	L10098
L127:
L125:
	inc	|~~basicvars+62
	bne	L128
	inc	|~~basicvars+62+2
L128:
	brl	L10097
L10098:
	lda	<L82+inputline_0
	and	#$ff
	bne	L129
	brl	L10099
L129:
	sep	#$20
	longa	off
	stz	<L83+line_1
	rep	#$20
	longa	on
	clc
	tdc
	adc	#<L83+line_1
	sta	<L83+cp_1
	lda	#$0
	sta	<L83+cp_1+2
L10099:
	brl	L10072
L10073:
L10046:
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
	bne	L130
	brl	L10048
L130:
L10047:
	stz	|~~basicvars+494
L131:
	lda	<L82+2
	sta	<L82+2+2
	lda	<L82+1
	sta	<L82+1+2
	pld
	tsc
	clc
	adc	#L82+2
	tcs
	rtl
L82	equ	157
L83	equ	13
	ends
	efunc
	code
	xdef	~~exec_beats
	func
~~exec_beats:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L132
	tcs
	phd
	tcd
beats_1	set	0
	inc	|~~basicvars+62
	bne	L134
	inc	|~~basicvars+62+2
L134:
	jsl	~~eval_integer
	sta	<L133+beats_1
	jsl	~~check_ateol
	pei	<L133+beats_1
	jsl	~~emulate_beats
L135:
	pld
	tsc
	clc
	adc	#L132
	tcs
	rtl
L132	equ	2
L133	equ	1
	ends
	efunc
	code
	xdef	~~exec_bput
	func
~~exec_bput:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L136
	tcs
	phd
	tcd
handle_1	set	0
stringtype_1	set	2
descriptor_1	set	4
	inc	|~~basicvars+62
	bne	L138
	inc	|~~basicvars+62+2
L138:
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
	bne	L139
	brl	L10100
L139:
	pea	#<$2c
	pea	#4
	jsl	~~error
L10100:
	inc	|~~basicvars+62
	bne	L140
	inc	|~~basicvars+62+2
L140:
	jsl	~~eval_intfactor
	sta	<L137+handle_1
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
	bne	L141
	brl	L10101
L141:
	pea	#<$27
	pea	#4
	jsl	~~error
L10101:
	inc	|~~basicvars+62
	bne	L142
	inc	|~~basicvars+62+2
L142:
L10104:
	jsl	~~expression
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	brl	L10105
L10107:
	jsl	~~pop_int
	pha
	pei	<L137+handle_1
	jsl	~~fileio_bput
	brl	L10106
L10108:
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
	pei	<L137+handle_1
	jsl	~~fileio_bput
	brl	L10106
L10109:
L10110:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L137+stringtype_1
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L137+descriptor_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	pei	<L137+descriptor_1
	pei	<L137+descriptor_1+4
	pei	<L137+descriptor_1+2
	pei	<L137+handle_1
	jsl	~~fileio_bputstr
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
	bne	L143
	brl	L10111
L143:
	pea	#<$a
	pei	<L137+handle_1
	jsl	~~fileio_bput
L10111:
	lda	<L137+stringtype_1
	cmp	#<$5
	beq	L144
	brl	L10112
L144:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L137+descriptor_1
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
L10112:
	brl	L10106
L10113:
	pea	#<$45
	pea	#4
	jsl	~~error
	brl	L10106
L10105:
	xref	~~~fsw
	jsl	~~~fsw
	dw	2
	dw	4
	dw	L10113-1
	dw	L10107-1
	dw	L10108-1
	dw	L10109-1
	dw	L10110-1
L10106:
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
	beq	L145
	brl	L10114
L145:
	inc	|~~basicvars+62
	bne	L146
	inc	|~~basicvars+62+2
L146:
	brl	L10115
L10114:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$3b
	rep	#$20
	longa	on
	beq	L147
	brl	L10116
L147:
	inc	|~~basicvars+62
	bne	L148
	inc	|~~basicvars+62+2
L148:
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
	brl	L10103
L149:
	brl	L10117
L10116:
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
	beq	L150
	brl	L10103
L150:
	pea	#<$5
	pea	#4
	jsl	~~error
L10117:
L10115:
L10102:
	brl	L10104
L10103:
L151:
	pld
	tsc
	clc
	adc	#L136
	tcs
	rtl
L136	equ	18
L137	equ	9
	ends
	efunc
	code
	xdef	~~exec_circle
	func
~~exec_circle:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L152
	tcs
	phd
	tcd
x_1	set	0
y_1	set	2
radius_1	set	4
filled_1	set	6
	inc	|~~basicvars+62
	bne	L154
	inc	|~~basicvars+62+2
L154:
	stz	<R0
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	sep	#$20
	longa	off
	lda	[<R1]
	cmp	#<$ab
	rep	#$20
	longa	on
	beq	L156
	brl	L155
L156:
	inc	<R0
L155:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L153+filled_1
	rep	#$20
	longa	on
	lda	<L153+filled_1
	and	#$ff
	bne	L157
	brl	L10118
L157:
	inc	|~~basicvars+62
	bne	L158
	inc	|~~basicvars+62+2
L158:
L10118:
	jsl	~~eval_integer
	sta	<L153+x_1
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
	bne	L159
	brl	L10119
L159:
	pea	#<$27
	pea	#4
	jsl	~~error
L10119:
	inc	|~~basicvars+62
	bne	L160
	inc	|~~basicvars+62+2
L160:
	jsl	~~eval_integer
	sta	<L153+y_1
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
	bne	L161
	brl	L10120
L161:
	pea	#<$27
	pea	#4
	jsl	~~error
L10120:
	inc	|~~basicvars+62
	bne	L162
	inc	|~~basicvars+62+2
L162:
	jsl	~~eval_integer
	sta	<L153+radius_1
	jsl	~~check_ateol
	pei	<L153+filled_1
	pei	<L153+radius_1
	pei	<L153+y_1
	pei	<L153+x_1
	jsl	~~emulate_circle
L163:
	pld
	tsc
	clc
	adc	#L152
	tcs
	rtl
L152	equ	15
L153	equ	9
	ends
	efunc
	code
	xdef	~~exec_clg
	func
~~exec_clg:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L164
	tcs
	phd
	tcd
	inc	|~~basicvars+62
	bne	L166
	inc	|~~basicvars+62+2
L166:
	jsl	~~check_ateol
	pea	#<$10
	jsl	~~emulate_vdu
L167:
	pld
	tsc
	clc
	adc	#L164
	tcs
	rtl
L164	equ	0
L165	equ	1
	ends
	efunc
	code
	xdef	~~exec_close
	func
~~exec_close:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L168
	tcs
	phd
	tcd
handle_1	set	0
	inc	|~~basicvars+62
	bne	L170
	inc	|~~basicvars+62+2
L170:
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
	bne	L171
	brl	L10121
L171:
	pea	#<$2c
	pea	#4
	jsl	~~error
L10121:
	inc	|~~basicvars+62
	bne	L172
	inc	|~~basicvars+62+2
L172:
	jsl	~~expression
	jsl	~~check_ateol
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	brl	L10122
L10124:
	jsl	~~pop_int
	sta	<L169+handle_1
	brl	L10123
L10125:
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
	sta	<L169+handle_1
	brl	L10123
L10126:
	pea	#<$3f
	pea	#4
	jsl	~~error
	brl	L10123
L10122:
	xref	~~~swt
	jsl	~~~swt
	dw	2
	dw	2
	dw	L10124-1
	dw	3
	dw	L10125-1
	dw	L10126-1
L10123:
	pei	<L169+handle_1
	jsl	~~fileio_close
L173:
	pld
	tsc
	clc
	adc	#L168
	tcs
	rtl
L168	equ	6
L169	equ	5
	ends
	efunc
	code
	xdef	~~exec_cls
	func
~~exec_cls:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L174
	tcs
	phd
	tcd
	inc	|~~basicvars+62
	bne	L176
	inc	|~~basicvars+62+2
L176:
	jsl	~~check_ateol
	pea	#<$c
	jsl	~~emulate_vdu
	stz	|~~basicvars+494
L177:
	pld
	tsc
	clc
	adc	#L174
	tcs
	rtl
L174	equ	0
L175	equ	1
	ends
	efunc
	code
	func
~~exec_colofon:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L178
	tcs
	phd
	tcd
red_1	set	0
green_1	set	2
blue_1	set	4
backred_1	set	6
backgreen_1	set	8
backblue_1	set	10
form_1	set	12
	stz	<L179+form_1
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$c0
	rep	#$20
	longa	on
	beq	L180
	brl	L10127
L180:
	inc	|~~basicvars+62
	bne	L181
	inc	|~~basicvars+62+2
L181:
	clc
	lda	#$4
	adc	<L179+form_1
	sta	<L179+form_1
	jsl	~~eval_integer
	sta	<L179+red_1
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
	brl	L10128
L182:
	inc	<L179+form_1
	inc	|~~basicvars+62
	bne	L183
	inc	|~~basicvars+62+2
L183:
	jsl	~~eval_integer
	sta	<L179+green_1
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
	bne	L184
	brl	L10129
L184:
	pea	#<$27
	pea	#4
	jsl	~~error
L10129:
	inc	|~~basicvars+62
	bne	L185
	inc	|~~basicvars+62+2
L185:
	jsl	~~eval_integer
	sta	<L179+blue_1
L10128:
L10127:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$c2
	rep	#$20
	longa	on
	beq	L186
	brl	L10130
L186:
	inc	|~~basicvars+62
	bne	L187
	inc	|~~basicvars+62+2
L187:
	clc
	lda	#$8
	adc	<L179+form_1
	sta	<L179+form_1
	jsl	~~eval_integer
	sta	<L179+backred_1
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
	beq	L188
	brl	L10131
L188:
	inc	<L179+form_1
	inc	<L179+form_1
	inc	|~~basicvars+62
	bne	L189
	inc	|~~basicvars+62+2
L189:
	jsl	~~eval_integer
	sta	<L179+backgreen_1
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
	bne	L190
	brl	L10132
L190:
	pea	#<$27
	pea	#4
	jsl	~~error
L10132:
	inc	|~~basicvars+62
	bne	L191
	inc	|~~basicvars+62+2
L191:
	jsl	~~eval_integer
	sta	<L179+backblue_1
L10131:
L10130:
	jsl	~~check_ateol
	lda	<L179+form_1
	and	#<$4
	bne	L192
	brl	L10133
L192:
	lda	<L179+form_1
	and	#<$1
	bne	L193
	brl	L10134
L193:
	pei	<L179+blue_1
	pei	<L179+green_1
	pei	<L179+red_1
	pea	#<$0
	jsl	~~emulate_setcolour
	brl	L10135
L10134:
	pei	<L179+red_1
	pea	#<$0
	jsl	~~emulate_setcolnum
L10135:
L10133:
	lda	<L179+form_1
	and	#<$8
	bne	L194
	brl	L10136
L194:
	lda	<L179+form_1
	and	#<$2
	bne	L195
	brl	L10137
L195:
	pei	<L179+backblue_1
	pei	<L179+backgreen_1
	pei	<L179+backred_1
	pea	#<$1
	jsl	~~emulate_setcolour
	brl	L10138
L10137:
	pei	<L179+backred_1
	pea	#<$1
	jsl	~~emulate_setcolnum
L10138:
L10136:
L196:
	pld
	tsc
	clc
	adc	#L178
	tcs
	rtl
L178	equ	18
L179	equ	5
	ends
	efunc
	code
	func
~~exec_colnum:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L197
	tcs
	phd
	tcd
colour_1	set	0
tint_1	set	2
parm2_1	set	4
parm3_1	set	6
parm4_1	set	8
	jsl	~~eval_integer
	sta	<L198+colour_1
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	brl	L10139
L10141:
	inc	|~~basicvars+62
	bne	L199
	inc	|~~basicvars+62+2
L199:
	jsl	~~eval_integer
	sta	<L198+tint_1
	jsl	~~check_ateol
	pei	<L198+tint_1
	pei	<L198+colour_1
	jsl	~~emulate_colourtint
	brl	L10140
L10142:
	inc	|~~basicvars+62
	bne	L200
	inc	|~~basicvars+62+2
L200:
	jsl	~~eval_integer
	sta	<L198+parm2_1
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
	bne	L201
	brl	L10143
L201:
	jsl	~~check_ateol
	pei	<L198+parm2_1
	pei	<L198+colour_1
	jsl	~~emulate_mapcolour
	brl	L10144
L10143:
	inc	|~~basicvars+62
	bne	L202
	inc	|~~basicvars+62+2
L202:
	jsl	~~eval_integer
	sta	<L198+parm3_1
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
	bne	L203
	brl	L10145
L203:
	jsl	~~check_ateol
	pei	<L198+parm3_1
	pei	<L198+parm2_1
	pei	<L198+colour_1
	pea	#<$0
	jsl	~~emulate_setcolour
	brl	L10146
L10145:
	inc	|~~basicvars+62
	bne	L204
	inc	|~~basicvars+62+2
L204:
	jsl	~~eval_integer
	sta	<L198+parm4_1
	jsl	~~check_ateol
	pei	<L198+parm4_1
	pei	<L198+parm3_1
	pei	<L198+parm2_1
	pei	<L198+colour_1
	jsl	~~emulate_defcolour
L10146:
L10144:
	brl	L10140
L10147:
	jsl	~~check_ateol
	pea	#<$11
	jsl	~~emulate_vdu
	pei	<L198+colour_1
	jsl	~~emulate_vdu
	brl	L10140
L10139:
	xref	~~~swt
	jsl	~~~swt
	dw	2
	dw	44
	dw	L10142-1
	dw	224
	dw	L10141-1
	dw	L10147-1
L10140:
L205:
	pld
	tsc
	clc
	adc	#L197
	tcs
	rtl
L197	equ	14
L198	equ	5
	ends
	efunc
	code
	xdef	~~exec_colour
	func
~~exec_colour:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L206
	tcs
	phd
	tcd
	inc	|~~basicvars+62
	bne	L208
	inc	|~~basicvars+62+2
L208:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$c0
	rep	#$20
	longa	on
	bne	L210
	brl	L209
L210:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$c2
	rep	#$20
	longa	on
	beq	L211
	brl	L10148
L211:
L209:
	jsl	~~exec_colofon
	brl	L10149
L10148:
	jsl	~~exec_colnum
L10149:
L212:
	pld
	tsc
	clc
	adc	#L206
	tcs
	rtl
L206	equ	4
L207	equ	5
	ends
	efunc
	code
	xdef	~~exec_draw
	func
~~exec_draw:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L213
	tcs
	phd
	tcd
x_1	set	0
y_1	set	2
	inc	|~~basicvars+62
	bne	L215
	inc	|~~basicvars+62+2
L215:
	jsl	~~eval_integer
	sta	<L214+x_1
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
	bne	L216
	brl	L10150
L216:
	pea	#<$27
	pea	#4
	jsl	~~error
L10150:
	inc	|~~basicvars+62
	bne	L217
	inc	|~~basicvars+62+2
L217:
	jsl	~~eval_integer
	sta	<L214+y_1
	jsl	~~check_ateol
	pei	<L214+y_1
	pei	<L214+x_1
	jsl	~~emulate_draw
L218:
	pld
	tsc
	clc
	adc	#L213
	tcs
	rtl
L213	equ	8
L214	equ	5
	ends
	efunc
	code
	xdef	~~exec_drawby
	func
~~exec_drawby:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L219
	tcs
	phd
	tcd
x_1	set	0
y_1	set	2
	inc	|~~basicvars+62
	bne	L221
	inc	|~~basicvars+62+2
L221:
	jsl	~~eval_integer
	sta	<L220+x_1
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
	bne	L222
	brl	L10151
L222:
	pea	#<$27
	pea	#4
	jsl	~~error
L10151:
	inc	|~~basicvars+62
	bne	L223
	inc	|~~basicvars+62+2
L223:
	jsl	~~eval_integer
	sta	<L220+y_1
	jsl	~~check_ateol
	pei	<L220+y_1
	pei	<L220+x_1
	jsl	~~emulate_drawby
L224:
	pld
	tsc
	clc
	adc	#L219
	tcs
	rtl
L219	equ	8
L220	equ	5
	ends
	efunc
	code
	xdef	~~exec_ellipse
	func
~~exec_ellipse:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L225
	tcs
	phd
	tcd
	udata
L10152:
	ds	4
	ends
x_1	set	0
y_1	set	2
majorlen_1	set	4
minorlen_1	set	6
isfilled_1	set	8
	inc	|~~basicvars+62
	bne	L227
	inc	|~~basicvars+62+2
L227:
	stz	<R0
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	sep	#$20
	longa	off
	lda	[<R1]
	cmp	#<$ab
	rep	#$20
	longa	on
	beq	L229
	brl	L228
L229:
	inc	<R0
L228:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L226+isfilled_1
	rep	#$20
	longa	on
	lda	<L226+isfilled_1
	and	#$ff
	bne	L230
	brl	L10153
L230:
	inc	|~~basicvars+62
	bne	L231
	inc	|~~basicvars+62+2
L231:
L10153:
	jsl	~~eval_integer
	sta	<L226+x_1
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
	bne	L232
	brl	L10154
L232:
	pea	#<$27
	pea	#4
	jsl	~~error
L10154:
	inc	|~~basicvars+62
	bne	L233
	inc	|~~basicvars+62+2
L233:
	jsl	~~eval_integer
	sta	<L226+y_1
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
	bne	L234
	brl	L10155
L234:
	pea	#<$27
	pea	#4
	jsl	~~error
L10155:
	inc	|~~basicvars+62
	bne	L235
	inc	|~~basicvars+62+2
L235:
	jsl	~~eval_integer
	sta	<L226+majorlen_1
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
	bne	L236
	brl	L10156
L236:
	pea	#<$27
	pea	#4
	jsl	~~error
L10156:
	inc	|~~basicvars+62
	bne	L237
	inc	|~~basicvars+62+2
L237:
	jsl	~~eval_integer
	sta	<L226+minorlen_1
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
	beq	L238
	brl	L10157
L238:
	inc	|~~basicvars+62
	bne	L239
	inc	|~~basicvars+62+2
L239:
	jsl	~~expression
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	brl	L10158
L10160:
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L240
	dey
L240:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	pla
	sta	|L10152
	pla
	sta	|L10152+2
	brl	L10159
L10161:
	phy
	phy
	jsl	~~pop_float
	pla
	sta	|L10152
	pla
	sta	|L10152+2
	brl	L10159
L10162:
	pea	#<$3f
	pea	#4
	jsl	~~error
	brl	L10159
L10158:
	xref	~~~swt
	jsl	~~~swt
	dw	2
	dw	2
	dw	L10160-1
	dw	3
	dw	L10161-1
	dw	L10162-1
L10159:
	brl	L10163
L10157:
	lda	#$0
	sta	|L10152
	lda	#$0
	sta	|L10152+2
L10163:
	jsl	~~check_ateol
	pei	<L226+isfilled_1
	lda	|L10152+2
	pha
	lda	|L10152
	pha
	pei	<L226+minorlen_1
	pei	<L226+majorlen_1
	pei	<L226+y_1
	pei	<L226+x_1
	jsl	~~emulate_ellipse
L241:
	pld
	tsc
	clc
	adc	#L225
	tcs
	rtl
L225	equ	17
L226	equ	9
	ends
	efunc
	code
	xdef	~~exec_envelope
	func
~~exec_envelope:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L242
	tcs
	phd
	tcd
n_1	set	0
	inc	|~~basicvars+62
	bne	L244
	inc	|~~basicvars+62+2
L244:
	lda	#$1
	sta	<L243+n_1
L10166:
	jsl	~~eval_integer
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
	bne	L245
	brl	L10167
L245:
	pea	#<$27
	pea	#4
	jsl	~~error
L10167:
	inc	|~~basicvars+62
	bne	L246
	inc	|~~basicvars+62+2
L246:
L10164:
	inc	<L243+n_1
	sec
	lda	<L243+n_1
	sbc	#<$e
	bvs	L247
	eor	#$8000
L247:
	bmi	L248
	brl	L10166
L248:
L10165:
	jsl	~~eval_integer
	jsl	~~check_ateol
L249:
	pld
	tsc
	clc
	adc	#L242
	tcs
	rtl
L242	equ	6
L243	equ	5
	ends
	efunc
	code
	xdef	~~exec_fill
	func
~~exec_fill:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L250
	tcs
	phd
	tcd
x_1	set	0
y_1	set	2
	inc	|~~basicvars+62
	bne	L252
	inc	|~~basicvars+62+2
L252:
	jsl	~~eval_integer
	sta	<L251+x_1
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
	bne	L253
	brl	L10168
L253:
	pea	#<$27
	pea	#4
	jsl	~~error
L10168:
	inc	|~~basicvars+62
	bne	L254
	inc	|~~basicvars+62+2
L254:
	jsl	~~eval_integer
	sta	<L251+y_1
	jsl	~~check_ateol
	pei	<L251+y_1
	pei	<L251+x_1
	jsl	~~emulate_fill
L255:
	pld
	tsc
	clc
	adc	#L250
	tcs
	rtl
L250	equ	8
L251	equ	5
	ends
	efunc
	code
	xdef	~~exec_fillby
	func
~~exec_fillby:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L256
	tcs
	phd
	tcd
x_1	set	0
y_1	set	2
	inc	|~~basicvars+62
	bne	L258
	inc	|~~basicvars+62+2
L258:
	jsl	~~eval_integer
	sta	<L257+x_1
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
	bne	L259
	brl	L10169
L259:
	pea	#<$27
	pea	#4
	jsl	~~error
L10169:
	inc	|~~basicvars+62
	bne	L260
	inc	|~~basicvars+62+2
L260:
	jsl	~~eval_integer
	sta	<L257+y_1
	jsl	~~check_ateol
	pei	<L257+y_1
	pei	<L257+x_1
	jsl	~~emulate_fillby
L261:
	pld
	tsc
	clc
	adc	#L256
	tcs
	rtl
L256	equ	8
L257	equ	5
	ends
	efunc
	code
	func
~~exec_gcolofon:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L262
	tcs
	phd
	tcd
form_1	set	0
action_1	set	2
red_1	set	4
green_1	set	6
blue_1	set	8
backact_1	set	10
backred_1	set	12
backgreen_1	set	14
backblue_1	set	16
	stz	<L263+form_1
	stz	<L263+backact_1
	stz	<L263+action_1
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$c0
	rep	#$20
	longa	on
	beq	L264
	brl	L10170
L264:
	clc
	lda	#$4
	adc	<L263+form_1
	sta	<L263+form_1
	inc	|~~basicvars+62
	bne	L265
	inc	|~~basicvars+62+2
L265:
	jsl	~~eval_integer
	sta	<L263+red_1
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
	beq	L266
	brl	L10171
L266:
	inc	|~~basicvars+62
	bne	L267
	inc	|~~basicvars+62+2
L267:
	jsl	~~eval_integer
	sta	<L263+green_1
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
	beq	L268
	brl	L10172
L268:
	inc	|~~basicvars+62
	bne	L269
	inc	|~~basicvars+62+2
L269:
	inc	<L263+form_1
	jsl	~~eval_integer
	sta	<L263+blue_1
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
	beq	L270
	brl	L10173
L270:
	inc	|~~basicvars+62
	bne	L271
	inc	|~~basicvars+62+2
L271:
	lda	<L263+red_1
	sta	<L263+action_1
	lda	<L263+green_1
	sta	<L263+red_1
	lda	<L263+blue_1
	sta	<L263+green_1
	jsl	~~eval_integer
	sta	<L263+blue_1
L10173:
	brl	L10174
L10172:
	lda	<L263+red_1
	sta	<L263+action_1
	lda	<L263+green_1
	sta	<L263+red_1
L10174:
L10171:
L10170:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$c2
	rep	#$20
	longa	on
	beq	L272
	brl	L10175
L272:
	clc
	lda	#$8
	adc	<L263+form_1
	sta	<L263+form_1
	inc	|~~basicvars+62
	bne	L273
	inc	|~~basicvars+62+2
L273:
	jsl	~~eval_integer
	sta	<L263+backred_1
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
	beq	L274
	brl	L10176
L274:
	inc	|~~basicvars+62
	bne	L275
	inc	|~~basicvars+62+2
L275:
	jsl	~~eval_integer
	sta	<L263+backgreen_1
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
	beq	L276
	brl	L10177
L276:
	inc	|~~basicvars+62
	bne	L277
	inc	|~~basicvars+62+2
L277:
	inc	<L263+form_1
	inc	<L263+form_1
	jsl	~~eval_integer
	sta	<L263+backblue_1
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
	beq	L278
	brl	L10178
L278:
	inc	|~~basicvars+62
	bne	L279
	inc	|~~basicvars+62+2
L279:
	lda	<L263+backred_1
	sta	<L263+backact_1
	lda	<L263+backgreen_1
	sta	<L263+backred_1
	lda	<L263+backblue_1
	sta	<L263+backgreen_1
	jsl	~~eval_integer
	sta	<L263+backblue_1
L10178:
	brl	L10179
L10177:
	lda	<L263+backred_1
	sta	<L263+backact_1
	lda	<L263+backgreen_1
	sta	<L263+backred_1
L10179:
L10176:
L10175:
	jsl	~~check_ateol
	lda	<L263+form_1
	and	#<$4
	bne	L280
	brl	L10180
L280:
	lda	<L263+form_1
	and	#<$1
	bne	L281
	brl	L10181
L281:
	pei	<L263+blue_1
	pei	<L263+green_1
	pei	<L263+red_1
	pea	#<$0
	pei	<L263+action_1
	jsl	~~emulate_gcolrgb
	brl	L10182
L10181:
	pei	<L263+red_1
	pea	#<$0
	pei	<L263+action_1
	jsl	~~emulate_gcolnum
L10182:
L10180:
	lda	<L263+form_1
	and	#<$8
	bne	L282
	brl	L10183
L282:
	lda	<L263+form_1
	and	#<$2
	bne	L283
	brl	L10184
L283:
	pei	<L263+backblue_1
	pei	<L263+backgreen_1
	pei	<L263+backred_1
	pea	#<$1
	pei	<L263+backact_1
	jsl	~~emulate_gcolrgb
	brl	L10185
L10184:
	pei	<L263+backred_1
	pea	#<$1
	pei	<L263+backact_1
	jsl	~~emulate_gcolnum
L10185:
L10183:
L284:
	pld
	tsc
	clc
	adc	#L262
	tcs
	rtl
L262	equ	22
L263	equ	5
	ends
	efunc
	code
	func
~~exec_gcolnum:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L285
	tcs
	phd
	tcd
colour_1	set	0
action_1	set	2
tint_1	set	4
gotrgb_1	set	6
green_1	set	8
blue_1	set	10
	stz	<L286+action_1
	stz	<L286+tint_1
	stz	<L286+gotrgb_1
	jsl	~~eval_integer
	sta	<L286+colour_1
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
	beq	L287
	brl	L10186
L287:
	inc	|~~basicvars+62
	bne	L288
	inc	|~~basicvars+62+2
L288:
	lda	<L286+colour_1
	sta	<L286+action_1
	jsl	~~eval_integer
	sta	<L286+colour_1
L10186:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$e0
	rep	#$20
	longa	on
	beq	L289
	brl	L10187
L289:
	inc	|~~basicvars+62
	bne	L290
	inc	|~~basicvars+62+2
L290:
	jsl	~~eval_integer
	sta	<L286+tint_1
	brl	L10188
L10187:
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
	beq	L291
	brl	L10189
L291:
	lda	#$1
	sta	<L286+gotrgb_1
	inc	|~~basicvars+62
	bne	L292
	inc	|~~basicvars+62+2
L292:
	jsl	~~eval_integer
	sta	<L286+green_1
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
	beq	L293
	brl	L10190
L293:
	inc	|~~basicvars+62
	bne	L294
	inc	|~~basicvars+62+2
L294:
	jsl	~~eval_integer
	sta	<L286+blue_1
	brl	L10191
L10190:
	lda	<L286+green_1
	sta	<L286+blue_1
	lda	<L286+colour_1
	sta	<L286+green_1
	lda	<L286+action_1
	sta	<L286+colour_1
	stz	<L286+action_1
L10191:
L10189:
L10188:
	jsl	~~check_ateol
	lda	<L286+gotrgb_1
	bne	L295
	brl	L10192
L295:
	pei	<L286+blue_1
	pei	<L286+green_1
	pei	<L286+colour_1
	pea	#<$0
	pei	<L286+action_1
	jsl	~~emulate_gcolrgb
	brl	L10193
L10192:
	pei	<L286+tint_1
	pei	<L286+colour_1
	pei	<L286+action_1
	jsl	~~emulate_gcol
L10193:
L296:
	pld
	tsc
	clc
	adc	#L285
	tcs
	rtl
L285	equ	16
L286	equ	5
	ends
	efunc
	code
	xdef	~~exec_gcol
	func
~~exec_gcol:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L297
	tcs
	phd
	tcd
	inc	|~~basicvars+62
	bne	L299
	inc	|~~basicvars+62+2
L299:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$c0
	rep	#$20
	longa	on
	bne	L301
	brl	L300
L301:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$c2
	rep	#$20
	longa	on
	beq	L302
	brl	L10194
L302:
L300:
	jsl	~~exec_gcolofon
	brl	L10195
L10194:
	jsl	~~exec_gcolnum
L10195:
L303:
	pld
	tsc
	clc
	adc	#L297
	tcs
	rtl
L297	equ	4
L298	equ	5
	ends
	efunc
	code
	func
~~input_file:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L304
	tcs
	phd
	tcd
handle_1	set	0
length_1	set	2
intvalue_1	set	4
floatvalue_1	set	6
cp_1	set	10
isint_1	set	14
destination_1	set	15
	inc	|~~basicvars+62
	bne	L306
	inc	|~~basicvars+62+2
L306:
	jsl	~~eval_intfactor
	sta	<L305+handle_1
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
	bne	L307
	brl	L10196
L307:
L308:
	pld
	tsc
	clc
	adc	#L304
	tcs
	rtl
L10196:
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
	bne	L309
	brl	L10197
L309:
	pea	#<$5
	pea	#4
	jsl	~~error
L10197:
L10200:
	inc	|~~basicvars+62
	bne	L310
	inc	|~~basicvars+62+2
L310:
	pea	#0
	clc
	tdc
	adc	#<L305+destination_1
	pha
	jsl	~~get_lvalue
	lda	<L305+destination_1
	and	#<$1f
	brl	L10201
L10203:
	pea	#0
	clc
	tdc
	adc	#<L305+floatvalue_1
	pha
	pea	#0
	clc
	tdc
	adc	#<L305+intvalue_1
	pha
	pea	#0
	clc
	tdc
	adc	#<L305+isint_1
	pha
	pei	<L305+handle_1
	jsl	~~fileio_getnumber
	lda	<L305+isint_1
	and	#$ff
	bne	L312
	brl	L311
L312:
	lda	<L305+intvalue_1
	bra	L313
L311:
	pei	<L305+floatvalue_1+2
	pei	<L305+floatvalue_1
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R0
	pla
	sta	<R0+2
	lda	<R0
L313:
	sta	[<L305+destination_1+2]
	brl	L10202
L10204:
	pea	#0
	clc
	tdc
	adc	#<L305+floatvalue_1
	pha
	pea	#0
	clc
	tdc
	adc	#<L305+intvalue_1
	pha
	pea	#0
	clc
	tdc
	adc	#<L305+isint_1
	pha
	pei	<L305+handle_1
	jsl	~~fileio_getnumber
	lda	<L305+isint_1
	and	#$ff
	bne	L315
	brl	L314
L315:
	ldy	#$0
	lda	<L305+intvalue_1
	bpl	L316
	dey
L316:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	bra	L317
L314:
	pei	<L305+floatvalue_1+2
	pei	<L305+floatvalue_1
L317:
	pla
	sta	[<L305+destination_1+2]
	pla
	ldy	#$2
	sta	[<L305+destination_1+2],Y
	brl	L10202
L10205:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	pei	<L305+destination_1+4
	pei	<L305+destination_1+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	pei	<L305+handle_1
	jsl	~~fileio_getstring
	sta	<L305+length_1
	pei	<L305+length_1
	jsl	~~alloc_string
	sta	<L305+cp_1
	stx	<L305+cp_1+2
	sec
	lda	#$0
	sbc	<L305+length_1
	bvs	L318
	eor	#$8000
L318:
	bpl	L319
	brl	L10206
L319:
	ldy	#$0
	lda	<L305+length_1
	bpl	L320
	dey
L320:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	pei	<L305+cp_1+2
	pei	<L305+cp_1
	jsl	~~memmove
L10206:
	lda	<L305+length_1
	sta	[<L305+destination_1+2]
	lda	<L305+cp_1
	ldy	#$2
	sta	[<L305+destination_1+2],Y
	lda	<L305+cp_1+2
	ldy	#$4
	sta	[<L305+destination_1+2],Y
	brl	L10202
L10207:
	pea	#0
	clc
	tdc
	adc	#<L305+floatvalue_1
	pha
	pea	#0
	clc
	tdc
	adc	#<L305+intvalue_1
	pha
	pea	#0
	clc
	tdc
	adc	#<L305+isint_1
	pha
	pei	<L305+handle_1
	jsl	~~fileio_getnumber
	pea	#<$1
	pei	<L305+destination_1+2
	jsl	~~check_write
	lda	|~~basicvars+6
	sta	<R0
	lda	|~~basicvars+6+2
	sta	<R0+2
	lda	<L305+isint_1
	and	#$ff
	bne	L322
	brl	L321
L322:
	lda	<L305+intvalue_1
	bra	L323
L321:
	pei	<L305+floatvalue_1+2
	pei	<L305+floatvalue_1
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R1
	pla
	sta	<R1+2
	lda	<R1
L323:
	sep	#$20
	longa	off
	ldy	<L305+destination_1+2
	sta	[<R0],Y
	rep	#$20
	longa	on
	brl	L10202
L10208:
	pea	#0
	clc
	tdc
	adc	#<L305+floatvalue_1
	pha
	pea	#0
	clc
	tdc
	adc	#<L305+intvalue_1
	pha
	pea	#0
	clc
	tdc
	adc	#<L305+isint_1
	pha
	pei	<L305+handle_1
	jsl	~~fileio_getnumber
	lda	<L305+isint_1
	and	#$ff
	bne	L325
	brl	L324
L325:
	lda	<L305+intvalue_1
	bra	L326
L324:
	pei	<L305+floatvalue_1+2
	pei	<L305+floatvalue_1
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R0
	pla
	sta	<R0+2
	lda	<R0
L326:
	pha
	pei	<L305+destination_1+2
	jsl	~~store_integer
	brl	L10202
L10209:
	pea	#0
	clc
	tdc
	adc	#<L305+floatvalue_1
	pha
	pea	#0
	clc
	tdc
	adc	#<L305+intvalue_1
	pha
	pea	#0
	clc
	tdc
	adc	#<L305+isint_1
	pha
	pei	<L305+handle_1
	jsl	~~fileio_getnumber
	lda	<L305+isint_1
	and	#$ff
	bne	L328
	brl	L327
L328:
	ldy	#$0
	lda	<L305+intvalue_1
	bpl	L329
	dey
L329:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	bra	L330
L327:
	pei	<L305+floatvalue_1+2
	pei	<L305+floatvalue_1
L330:
	pei	<L305+destination_1+2
	jsl	~~store_float
	brl	L10202
L10210:
	pea	#<$1000
	pei	<L305+destination_1+2
	jsl	~~check_write
	ldy	#$0
	lda	<L305+destination_1+2
	bpl	L331
	dey
L331:
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
	pei	<L305+handle_1
	jsl	~~fileio_getstring
	sta	<L305+length_1
	clc
	lda	<L305+destination_1+2
	adc	<L305+length_1
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
	brl	L10202
L10211:
	pea	#<$45
	pea	#4
	jsl	~~error
	brl	L10202
L10201:
	xref	~~~swt
	jsl	~~~swt
	dw	7
	dw	2
	dw	L10203-1
	dw	3
	dw	L10204-1
	dw	4
	dw	L10205-1
	dw	17
	dw	L10207-1
	dw	18
	dw	L10208-1
	dw	19
	dw	L10209-1
	dw	21
	dw	L10210-1
	dw	L10211-1
L10202:
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
	beq	L332
	brl	L10199
L332:
L10198:
	brl	L10200
L10199:
	jsl	~~check_ateol
	brl	L308
L304	equ	29
L305	equ	9
	ends
	efunc
	code
	xdef	~~exec_input
	func
~~exec_input:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L333
	tcs
	phd
	tcd
	inc	|~~basicvars+62
	bne	L335
	inc	|~~basicvars+62+2
L335:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	brl	L10212
L10214:
	inc	|~~basicvars+62
	bne	L336
	inc	|~~basicvars+62+2
L336:
	pea	#<$1
	jsl	~~read_input
	brl	L10213
L10215:
	jsl	~~input_file
	brl	L10213
L10216:
	pea	#<$0
	jsl	~~read_input
	brl	L10213
L10212:
	xref	~~~swt
	jsl	~~~swt
	dw	2
	dw	35
	dw	L10215-1
	dw	184
	dw	L10214-1
	dw	L10216-1
L10213:
L337:
	pld
	tsc
	clc
	adc	#L333
	tcs
	rtl
L333	equ	4
L334	equ	5
	ends
	efunc
	code
	xdef	~~exec_line
	func
~~exec_line:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L338
	tcs
	phd
	tcd
	inc	|~~basicvars+62
	bne	L340
	inc	|~~basicvars+62+2
L340:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$b5
	rep	#$20
	longa	on
	beq	L341
	brl	L10217
L341:
	inc	|~~basicvars+62
	bne	L342
	inc	|~~basicvars+62+2
L342:
	pea	#<$1
	jsl	~~read_input
	brl	L10218
L10217:
x1_2	set	0
y1_2	set	2
x2_2	set	4
y2_2	set	6
	jsl	~~eval_integer
	sta	<L339+x1_2
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
	bne	L343
	brl	L10219
L343:
	pea	#<$27
	pea	#4
	jsl	~~error
L10219:
	inc	|~~basicvars+62
	bne	L344
	inc	|~~basicvars+62+2
L344:
	jsl	~~eval_integer
	sta	<L339+y1_2
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
	bne	L345
	brl	L10220
L345:
	pea	#<$27
	pea	#4
	jsl	~~error
L10220:
	inc	|~~basicvars+62
	bne	L346
	inc	|~~basicvars+62+2
L346:
	jsl	~~eval_integer
	sta	<L339+x2_2
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
	bne	L347
	brl	L10221
L347:
	pea	#<$27
	pea	#4
	jsl	~~error
L10221:
	inc	|~~basicvars+62
	bne	L348
	inc	|~~basicvars+62+2
L348:
	jsl	~~eval_integer
	sta	<L339+y2_2
	jsl	~~check_ateol
	pei	<L339+y2_2
	pei	<L339+x2_2
	pei	<L339+y1_2
	pei	<L339+x1_2
	jsl	~~emulate_line
L10218:
L349:
	pld
	tsc
	clc
	adc	#L338
	tcs
	rtl
L338	equ	12
L339	equ	5
	ends
	efunc
	code
	func
~~exec_modenum:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L350
	tcs
	phd
	tcd
itemtype_0	set	4
xres_1	set	0
yres_1	set	2
bpp_1	set	4
rate_1	set	6
	lda	#$ffff
	sta	<L351+rate_1
	lda	#$6
	sta	<L351+bpp_1
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
	beq	L352
	brl	L10222
L352:
	lda	<L350+itemtype_0
	cmp	#<$2
	beq	L354
	brl	L353
L354:
	jsl	~~pop_int
	bra	L355
L353:
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
L355:
	sta	<L351+xres_1
	inc	|~~basicvars+62
	bne	L356
	inc	|~~basicvars+62+2
L356:
	jsl	~~eval_integer
	sta	<L351+yres_1
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
	beq	L357
	brl	L10223
L357:
	inc	|~~basicvars+62
	bne	L358
	inc	|~~basicvars+62+2
L358:
	jsl	~~eval_integer
	sta	<L351+bpp_1
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
	beq	L359
	brl	L10224
L359:
	inc	|~~basicvars+62
	bne	L360
	inc	|~~basicvars+62+2
L360:
	jsl	~~eval_integer
	sta	<L351+rate_1
L10224:
L10223:
	jsl	~~check_ateol
	pei	<L351+rate_1
	pei	<L351+bpp_1
	pei	<L351+yres_1
	pei	<L351+xres_1
	jsl	~~emulate_newmode
	brl	L10225
L10222:
	jsl	~~check_ateol
	lda	<L350+itemtype_0
	cmp	#<$2
	beq	L361
	brl	L10226
L361:
	jsl	~~pop_int
	pha
	jsl	~~emulate_mode
	brl	L10227
L10226:
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
	jsl	~~emulate_mode
L10227:
L10225:
L362:
	lda	<L350+2
	sta	<L350+2+2
	lda	<L350+1
	sta	<L350+1+2
	pld
	tsc
	clc
	adc	#L350+2
	tcs
	rtl
L350	equ	12
L351	equ	5
	ends
	efunc
	code
	func
~~exec_modestr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L363
	tcs
	phd
	tcd
itemtype_0	set	4
descriptor_1	set	0
cp_1	set	6
	jsl	~~check_ateol
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L364+descriptor_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	lda	<L364+descriptor_1+2
	sta	<L364+cp_1
	lda	<L364+descriptor_1+4
	sta	<L364+cp_1+2
	sec
	lda	#$0
	sbc	<L364+descriptor_1
	bvs	L365
	eor	#$8000
L365:
	bpl	L366
	brl	L10228
L366:
	ldy	#$0
	lda	<L364+descriptor_1
	bpl	L367
	dey
L367:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L364+descriptor_1+4
	pei	<L364+descriptor_1+2
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	jsl	~~memmove
L10228:
	lda	|~~basicvars+70
	sta	<R0
	lda	|~~basicvars+70+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$0
	ldy	<L364+descriptor_1
	sta	[<R0],Y
	rep	#$20
	longa	on
	lda	<L363+itemtype_0
	cmp	#<$5
	beq	L368
	brl	L10229
L368:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L364+descriptor_1
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
L10229:
	lda	|~~basicvars+70
	sta	<L364+cp_1
	lda	|~~basicvars+70+2
	sta	<L364+cp_1+2
L10230:
	sep	#$20
	longa	off
	lda	[<L364+cp_1]
	cmp	#<$20
	rep	#$20
	longa	on
	bne	L370
	brl	L369
L370:
	sep	#$20
	longa	off
	lda	[<L364+cp_1]
	cmp	#<$2c
	rep	#$20
	longa	on
	beq	L371
	brl	L10231
L371:
L369:
	inc	<L364+cp_1
	bne	L372
	inc	<L364+cp_1+2
L372:
	brl	L10230
L10231:
	lda	[<L364+cp_1]
	and	#$ff
	beq	L373
	brl	L10232
L373:
L374:
	lda	<L363+2
	sta	<L363+2+2
	lda	<L363+1
	sta	<L363+1+2
	pld
	tsc
	clc
	adc	#L363+2
	tcs
	rtl
L10232:
	lda	[<L364+cp_1]
	and	#$ff
	pha
	jsl	~~isdigit
	tax
	bne	L375
	brl	L10233
L375:
mode_2	set	10
	stz	<L364+mode_2
L10236:
	lda	[<L364+cp_1]
	and	#$ff
	sta	<R0
	lda	<L364+mode_2
	asl	A
	asl	A
	adc	<L364+mode_2
	asl	A
	sta	<R1
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	clc
	lda	#$ffd0
	adc	<R2
	sta	<L364+mode_2
	inc	<L364+cp_1
	bne	L376
	inc	<L364+cp_1+2
L376:
L10234:
	lda	[<L364+cp_1]
	and	#$ff
	pha
	jsl	~~isdigit
	tax
	beq	L377
	brl	L10236
L377:
L10235:
	pei	<L364+mode_2
	jsl	~~emulate_mode
	brl	L10237
L10233:
xres_3	set	10
yres_3	set	12
colours_3	set	14
greys_3	set	16
xeig_3	set	18
yeig_3	set	20
rate_3	set	22
value_3	set	24
what_3	set	26
	stz	<L364+yres_3
	stz	<L364+xres_3
	stz	<L364+greys_3
	stz	<L364+colours_3
	lda	#$1
	sta	<L364+yeig_3
	lda	#$1
	sta	<L364+xeig_3
	lda	#$ffff
	sta	<L364+rate_3
L10240:
	stz	<L364+value_3
	lda	[<L364+cp_1]
	and	#$ff
	pha
	jsl	~~toupper
	brl	L10241
L10243:
L10244:
L10245:
	lda	[<L364+cp_1]
	and	#$ff
	pha
	jsl	~~toupper
	sep	#$20
	longa	off
	sta	<L364+what_3
	rep	#$20
	longa	on
	inc	<L364+cp_1
	bne	L378
	inc	<L364+cp_1+2
L378:
L10246:
	lda	[<L364+cp_1]
	and	#$ff
	pha
	jsl	~~isdigit
	tax
	bne	L379
	brl	L10247
L379:
	lda	[<L364+cp_1]
	and	#$ff
	sta	<R0
	lda	<L364+value_3
	asl	A
	asl	A
	adc	<L364+value_3
	asl	A
	sta	<R1
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	clc
	lda	#$ffd0
	adc	<R2
	sta	<L364+value_3
	inc	<L364+cp_1
	bne	L380
	inc	<L364+cp_1+2
L380:
	brl	L10246
L10247:
	lda	<L364+value_3
	bmi	L381
	dea
	bmi	L381
	brl	L10248
L381:
	pea	#<$67
	pea	#4
	jsl	~~error
L10248:
	sep	#$20
	longa	off
	lda	<L364+what_3
	cmp	#<$58
	rep	#$20
	longa	on
	beq	L382
	brl	L10249
L382:
	lda	<L364+value_3
	sta	<L364+xres_3
	brl	L10250
L10249:
	sep	#$20
	longa	off
	lda	<L364+what_3
	cmp	#<$59
	rep	#$20
	longa	on
	beq	L383
	brl	L10251
L383:
	lda	<L364+value_3
	sta	<L364+yres_3
	brl	L10252
L10251:
	sec
	lda	#$0
	sbc	<L364+colours_3
	bvs	L384
	eor	#$8000
L384:
	bpl	L385
	brl	L10253
L385:
	pea	#<$67
	pea	#4
	jsl	~~error
L10253:
	lda	<L364+value_3
	sta	<L364+greys_3
L10252:
L10250:
	brl	L10242
L10254:
	sec
	lda	#$0
	sbc	<L364+greys_3
	bvs	L386
	eor	#$8000
L386:
	bpl	L387
	brl	L10255
L387:
	pea	#<$67
	pea	#4
	jsl	~~error
L10255:
	inc	<L364+cp_1
	bne	L388
	inc	<L364+cp_1+2
L388:
L10256:
	lda	[<L364+cp_1]
	and	#$ff
	pha
	jsl	~~isdigit
	tax
	bne	L389
	brl	L10257
L389:
	lda	[<L364+cp_1]
	and	#$ff
	sta	<R0
	lda	<L364+colours_3
	asl	A
	asl	A
	adc	<L364+colours_3
	asl	A
	sta	<R1
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	clc
	lda	#$ffd0
	adc	<R2
	sta	<L364+colours_3
	inc	<L364+cp_1
	bne	L390
	inc	<L364+cp_1+2
L390:
	brl	L10256
L10257:
	lda	<L364+colours_3
	bmi	L391
	dea
	bmi	L391
	brl	L10258
L391:
	pea	#<$67
	pea	#4
	jsl	~~error
L10258:
	lda	[<L364+cp_1]
	and	#$ff
	pha
	jsl	~~toupper
	sta	<R0
	lda	<R0
	cmp	#<$4b
	beq	L392
	brl	L10259
L392:
	lda	<L364+colours_3
	cmp	#<$20
	bne	L393
	brl	L10260
L393:
	pea	#<$67
	pea	#4
	jsl	~~error
L10260:
	lda	#$8000
	sta	<L364+colours_3
	inc	<L364+cp_1
	bne	L394
	inc	<L364+cp_1+2
L394:
	brl	L10261
L10259:
	lda	[<L364+cp_1]
	and	#$ff
	pha
	jsl	~~toupper
	sta	<R0
	lda	<R0
	cmp	#<$4d
	beq	L395
	brl	L10262
L395:
	lda	<L364+colours_3
	cmp	#<$10
	bne	L396
	brl	L10263
L396:
	pea	#<$67
	pea	#4
	jsl	~~error
L10263:
	stz	<L364+colours_3
	inc	<L364+cp_1
	bne	L397
	inc	<L364+cp_1+2
L397:
L10262:
L10261:
	brl	L10242
L10264:
	inc	<L364+cp_1
	bne	L398
	inc	<L364+cp_1+2
L398:
	sep	#$20
	longa	off
	lda	[<L364+cp_1]
	cmp	#<$2d
	rep	#$20
	longa	on
	beq	L399
	brl	L10265
L399:
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L364+cp_1],Y
	cmp	#<$31
	rep	#$20
	longa	on
	beq	L400
	brl	L10265
L400:
	clc
	lda	#$2
	adc	<L364+cp_1
	sta	<L364+cp_1
	bcc	L401
	inc	<L364+cp_1+2
L401:
	brl	L10266
L10265:
	stz	<L364+rate_3
L10267:
	lda	[<L364+cp_1]
	and	#$ff
	pha
	jsl	~~isdigit
	tax
	bne	L402
	brl	L10268
L402:
	lda	[<L364+cp_1]
	and	#$ff
	sta	<R0
	lda	<L364+rate_3
	asl	A
	asl	A
	adc	<L364+rate_3
	asl	A
	sta	<R1
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	clc
	lda	#$ffd0
	adc	<R2
	sta	<L364+rate_3
	inc	<L364+cp_1
	bne	L403
	inc	<L364+cp_1+2
L403:
	brl	L10267
L10268:
	lda	<L364+rate_3
	bmi	L404
	dea
	bmi	L404
	brl	L10269
L404:
	pea	#<$67
	pea	#4
	jsl	~~error
L10269:
L10266:
	brl	L10242
L10270:
	inc	<L364+cp_1
	bne	L405
	inc	<L364+cp_1+2
L405:
	lda	[<L364+cp_1]
	and	#$ff
	pha
	jsl	~~toupper
	sta	<R0
	lda	<R0
	cmp	#<$58
	beq	L406
	brl	L10271
L406:
	ldy	#$1
	lda	[<L364+cp_1],Y
	and	#$ff
	sta	<R0
	clc
	lda	#$ffd0
	adc	<R0
	sta	<L364+xeig_3
	brl	L10272
L10271:
	lda	[<L364+cp_1]
	and	#$ff
	pha
	jsl	~~toupper
	sta	<R0
	lda	<R0
	cmp	#<$59
	beq	L407
	brl	L10273
L407:
	ldy	#$1
	lda	[<L364+cp_1],Y
	and	#$ff
	sta	<R0
	clc
	lda	#$ffd0
	adc	<R0
	sta	<L364+yeig_3
	brl	L10274
L10273:
	pea	#<$67
	pea	#4
	jsl	~~error
L10274:
L10272:
	clc
	lda	#$2
	adc	<L364+cp_1
	sta	<L364+cp_1
	bcc	L408
	inc	<L364+cp_1+2
L408:
	brl	L10242
L10275:
	pea	#<$67
	pea	#4
	jsl	~~error
	brl	L10242
L10241:
	xref	~~~swt
	jsl	~~~swt
	dw	6
	dw	67
	dw	L10254-1
	dw	69
	dw	L10270-1
	dw	70
	dw	L10264-1
	dw	71
	dw	L10245-1
	dw	88
	dw	L10243-1
	dw	89
	dw	L10244-1
	dw	L10275-1
L10242:
L10276:
	sep	#$20
	longa	off
	lda	[<L364+cp_1]
	cmp	#<$20
	rep	#$20
	longa	on
	bne	L410
	brl	L409
L410:
	sep	#$20
	longa	off
	lda	[<L364+cp_1]
	cmp	#<$2c
	rep	#$20
	longa	on
	beq	L411
	brl	L10277
L411:
L409:
	inc	<L364+cp_1
	bne	L412
	inc	<L364+cp_1+2
L412:
	brl	L10276
L10277:
L10238:
	lda	[<L364+cp_1]
	and	#$ff
	beq	L413
	brl	L10240
L413:
L10239:
	pei	<L364+rate_3
	pei	<L364+yeig_3
	pei	<L364+xeig_3
	pei	<L364+greys_3
	pei	<L364+colours_3
	pei	<L364+yres_3
	pei	<L364+xres_3
	jsl	~~emulate_modestr
L10237:
	brl	L374
L363	equ	39
L364	equ	13
	ends
	efunc
	code
	xdef	~~exec_mode
	func
~~exec_mode:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L414
	tcs
	phd
	tcd
itemtype_1	set	0
	inc	|~~basicvars+62
	bne	L416
	inc	|~~basicvars+62+2
L416:
	jsl	~~expression
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L415+itemtype_1
	lda	<L415+itemtype_1
	brl	L10278
L10280:
L10281:
	pei	<L415+itemtype_1
	jsl	~~exec_modenum
	brl	L10279
L10282:
L10283:
	pei	<L415+itemtype_1
	jsl	~~exec_modestr
	brl	L10279
L10284:
	pea	#<$45
	pea	#4
	jsl	~~error
	brl	L10279
L10278:
	xref	~~~fsw
	jsl	~~~fsw
	dw	2
	dw	4
	dw	L10284-1
	dw	L10280-1
	dw	L10281-1
	dw	L10282-1
	dw	L10283-1
L10279:
	stz	|~~basicvars+494
L417:
	pld
	tsc
	clc
	adc	#L414
	tcs
	rtl
L414	equ	6
L415	equ	5
	ends
	efunc
	code
	func
~~exec_mouse_on:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L418
	tcs
	phd
	tcd
pointer_1	set	0
	inc	|~~basicvars+62
	bne	L420
	inc	|~~basicvars+62+2
L420:
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
	beq	L421
	brl	L10285
L421:
	jsl	~~eval_integer
	sta	<L419+pointer_1
	brl	L10286
L10285:
	stz	<L419+pointer_1
L10286:
	jsl	~~check_ateol
	pei	<L419+pointer_1
	jsl	~~emulate_mouse_on
L422:
	pld
	tsc
	clc
	adc	#L418
	tcs
	rtl
L418	equ	6
L419	equ	5
	ends
	efunc
	code
	func
~~exec_mouse_off:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L423
	tcs
	phd
	tcd
	inc	|~~basicvars+62
	bne	L425
	inc	|~~basicvars+62+2
L425:
	jsl	~~check_ateol
	jsl	~~emulate_mouse_off
L426:
	pld
	tsc
	clc
	adc	#L423
	tcs
	rtl
L423	equ	0
L424	equ	1
	ends
	efunc
	code
	func
~~exec_mouse_to:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L427
	tcs
	phd
	tcd
x_1	set	0
y_1	set	2
	inc	|~~basicvars+62
	bne	L429
	inc	|~~basicvars+62+2
L429:
	jsl	~~eval_integer
	sta	<L428+x_1
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
	bne	L430
	brl	L10287
L430:
	pea	#<$27
	pea	#4
	jsl	~~error
L10287:
	inc	|~~basicvars+62
	bne	L431
	inc	|~~basicvars+62+2
L431:
	jsl	~~eval_integer
	sta	<L428+y_1
	jsl	~~check_ateol
	pei	<L428+y_1
	pei	<L428+x_1
	jsl	~~emulate_mouse_to
L432:
	pld
	tsc
	clc
	adc	#L427
	tcs
	rtl
L427	equ	8
L428	equ	5
	ends
	efunc
	code
	func
~~exec_mouse_step:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L433
	tcs
	phd
	tcd
x_1	set	0
y_1	set	2
	inc	|~~basicvars+62
	bne	L435
	inc	|~~basicvars+62+2
L435:
	jsl	~~eval_integer
	sta	<L434+x_1
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
	beq	L436
	brl	L10288
L436:
	inc	|~~basicvars+62
	bne	L437
	inc	|~~basicvars+62+2
L437:
	jsl	~~eval_integer
	sta	<L434+y_1
	brl	L10289
L10288:
	lda	<L434+x_1
	sta	<L434+y_1
L10289:
	jsl	~~check_ateol
	pei	<L434+y_1
	pei	<L434+x_1
	jsl	~~emulate_mouse_step
L438:
	pld
	tsc
	clc
	adc	#L433
	tcs
	rtl
L433	equ	8
L434	equ	5
	ends
	efunc
	code
	func
~~exec_mouse_colour:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L439
	tcs
	phd
	tcd
colour_1	set	0
red_1	set	2
green_1	set	4
blue_1	set	6
	inc	|~~basicvars+62
	bne	L441
	inc	|~~basicvars+62+2
L441:
	jsl	~~eval_integer
	sta	<L440+colour_1
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
	bne	L442
	brl	L10290
L442:
	pea	#<$27
	pea	#4
	jsl	~~error
L10290:
	inc	|~~basicvars+62
	bne	L443
	inc	|~~basicvars+62+2
L443:
	jsl	~~eval_integer
	sta	<L440+red_1
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
	bne	L444
	brl	L10291
L444:
	pea	#<$27
	pea	#4
	jsl	~~error
L10291:
	inc	|~~basicvars+62
	bne	L445
	inc	|~~basicvars+62+2
L445:
	jsl	~~eval_integer
	sta	<L440+green_1
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
	bne	L446
	brl	L10292
L446:
	pea	#<$27
	pea	#4
	jsl	~~error
L10292:
	inc	|~~basicvars+62
	bne	L447
	inc	|~~basicvars+62+2
L447:
	jsl	~~eval_integer
	sta	<L440+blue_1
	jsl	~~check_ateol
	pei	<L440+blue_1
	pei	<L440+green_1
	pei	<L440+red_1
	pei	<L440+colour_1
	jsl	~~emulate_mouse_colour
L448:
	pld
	tsc
	clc
	adc	#L439
	tcs
	rtl
L439	equ	12
L440	equ	5
	ends
	efunc
	code
	func
~~exec_mouse_rectangle:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L449
	tcs
	phd
	tcd
left_1	set	0
bottom_1	set	2
right_1	set	4
top_1	set	6
	inc	|~~basicvars+62
	bne	L451
	inc	|~~basicvars+62+2
L451:
	jsl	~~eval_integer
	sta	<L450+left_1
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
	bne	L452
	brl	L10293
L452:
	pea	#<$27
	pea	#4
	jsl	~~error
L10293:
	inc	|~~basicvars+62
	bne	L453
	inc	|~~basicvars+62+2
L453:
	jsl	~~eval_integer
	sta	<L450+bottom_1
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
	bne	L454
	brl	L10294
L454:
	pea	#<$27
	pea	#4
	jsl	~~error
L10294:
	inc	|~~basicvars+62
	bne	L455
	inc	|~~basicvars+62+2
L455:
	jsl	~~eval_integer
	sta	<L450+right_1
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
	bne	L456
	brl	L10295
L456:
	pea	#<$27
	pea	#4
	jsl	~~error
L10295:
	inc	|~~basicvars+62
	bne	L457
	inc	|~~basicvars+62+2
L457:
	jsl	~~eval_integer
	sta	<L450+top_1
	jsl	~~check_ateol
	pei	<L450+top_1
	pei	<L450+right_1
	pei	<L450+bottom_1
	pei	<L450+left_1
	jsl	~~emulate_mouse_rectangle
L458:
	pld
	tsc
	clc
	adc	#L449
	tcs
	rtl
L449	equ	12
L450	equ	5
	ends
	efunc
	code
	func
~~exec_mouse_position:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L459
	tcs
	phd
	tcd
mousevalues_1	set	0
destination_1	set	8
	pea	#0
	clc
	tdc
	adc	#<L460+mousevalues_1
	pha
	jsl	~~emulate_mouse
	pea	#0
	clc
	tdc
	adc	#<L460+destination_1
	pha
	jsl	~~get_lvalue
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
	bne	L461
	brl	L10296
L461:
	pea	#<$27
	pea	#4
	jsl	~~error
L10296:
	pea	#<$1
	pei	<L460+mousevalues_1
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L460+destination_1
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
	jsl	~~store_value
	inc	|~~basicvars+62
	bne	L462
	inc	|~~basicvars+62+2
L462:
	pea	#0
	clc
	tdc
	adc	#<L460+destination_1
	pha
	jsl	~~get_lvalue
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
	bne	L463
	brl	L10297
L463:
	pea	#<$27
	pea	#4
	jsl	~~error
L10297:
	pea	#<$1
	pei	<L460+mousevalues_1+2
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L460+destination_1
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
	jsl	~~store_value
	inc	|~~basicvars+62
	bne	L464
	inc	|~~basicvars+62+2
L464:
	pea	#0
	clc
	tdc
	adc	#<L460+destination_1
	pha
	jsl	~~get_lvalue
	pea	#<$1
	pei	<L460+mousevalues_1+4
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L460+destination_1
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
	jsl	~~store_value
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
	beq	L465
	brl	L10298
L465:
	inc	|~~basicvars+62
	bne	L466
	inc	|~~basicvars+62+2
L466:
	pea	#0
	clc
	tdc
	adc	#<L460+destination_1
	pha
	jsl	~~get_lvalue
	pea	#<$1
	pei	<L460+mousevalues_1+6
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L460+destination_1
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
	jsl	~~store_value
L10298:
	jsl	~~check_ateol
L467:
	pld
	tsc
	clc
	adc	#L459
	tcs
	rtl
L459	equ	22
L460	equ	9
	ends
	efunc
	code
	xdef	~~exec_mouse
	func
~~exec_mouse:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L468
	tcs
	phd
	tcd
	inc	|~~basicvars+62
	bne	L470
	inc	|~~basicvars+62+2
L470:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	brl	L10299
L10301:
	jsl	~~exec_mouse_on
	brl	L10300
L10302:
	jsl	~~exec_mouse_off
	brl	L10300
L10303:
	jsl	~~exec_mouse_to
	brl	L10300
L10304:
	jsl	~~exec_mouse_step
	brl	L10300
L10305:
	jsl	~~exec_mouse_colour
	brl	L10300
L10306:
	jsl	~~exec_mouse_rectangle
	brl	L10300
L10307:
	jsl	~~exec_mouse_position
	brl	L10300
L10299:
	xref	~~~swt
	jsl	~~~swt
	dw	6
	dw	152
	dw	L10305-1
	dw	193
	dw	L10302-1
	dw	194
	dw	L10301-1
	dw	208
	dw	L10306-1
	dw	217
	dw	L10304-1
	dw	225
	dw	L10303-1
	dw	L10307-1
L10300:
L471:
	pld
	tsc
	clc
	adc	#L468
	tcs
	rtl
L468	equ	4
L469	equ	5
	ends
	efunc
	code
	xdef	~~exec_move
	func
~~exec_move:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L472
	tcs
	phd
	tcd
x_1	set	0
y_1	set	2
	inc	|~~basicvars+62
	bne	L474
	inc	|~~basicvars+62+2
L474:
	jsl	~~eval_integer
	sta	<L473+x_1
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
	bne	L475
	brl	L10308
L475:
	pea	#<$27
	pea	#4
	jsl	~~error
L10308:
	inc	|~~basicvars+62
	bne	L476
	inc	|~~basicvars+62+2
L476:
	jsl	~~eval_integer
	sta	<L473+y_1
	jsl	~~check_ateol
	pei	<L473+y_1
	pei	<L473+x_1
	jsl	~~emulate_move
L477:
	pld
	tsc
	clc
	adc	#L472
	tcs
	rtl
L472	equ	8
L473	equ	5
	ends
	efunc
	code
	xdef	~~exec_moveby
	func
~~exec_moveby:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L478
	tcs
	phd
	tcd
x_1	set	0
y_1	set	2
	inc	|~~basicvars+62
	bne	L480
	inc	|~~basicvars+62+2
L480:
	jsl	~~eval_integer
	sta	<L479+x_1
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
	bne	L481
	brl	L10309
L481:
	pea	#<$27
	pea	#4
	jsl	~~error
L10309:
	inc	|~~basicvars+62
	bne	L482
	inc	|~~basicvars+62+2
L482:
	jsl	~~eval_integer
	sta	<L479+y_1
	jsl	~~check_ateol
	pei	<L479+y_1
	pei	<L479+x_1
	jsl	~~emulate_moveby
L483:
	pld
	tsc
	clc
	adc	#L478
	tcs
	rtl
L478	equ	8
L479	equ	5
	ends
	efunc
	code
	xdef	~~exec_off
	func
~~exec_off:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L484
	tcs
	phd
	tcd
	inc	|~~basicvars+62
	bne	L486
	inc	|~~basicvars+62+2
L486:
	jsl	~~check_ateol
	jsl	~~emulate_off
L487:
	pld
	tsc
	clc
	adc	#L484
	tcs
	rtl
L484	equ	0
L485	equ	1
	ends
	efunc
	code
	xdef	~~exec_origin
	func
~~exec_origin:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L488
	tcs
	phd
	tcd
x_1	set	0
y_1	set	2
	inc	|~~basicvars+62
	bne	L490
	inc	|~~basicvars+62+2
L490:
	jsl	~~eval_integer
	sta	<L489+x_1
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
	bne	L491
	brl	L10310
L491:
	pea	#<$27
	pea	#4
	jsl	~~error
L10310:
	inc	|~~basicvars+62
	bne	L492
	inc	|~~basicvars+62+2
L492:
	jsl	~~eval_integer
	sta	<L489+y_1
	jsl	~~check_ateol
	pei	<L489+y_1
	pei	<L489+x_1
	jsl	~~emulate_origin
L493:
	pld
	tsc
	clc
	adc	#L488
	tcs
	rtl
L488	equ	8
L489	equ	5
	ends
	efunc
	code
	xdef	~~exec_plot
	func
~~exec_plot:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L494
	tcs
	phd
	tcd
code_1	set	0
x_1	set	2
y_1	set	4
	inc	|~~basicvars+62
	bne	L496
	inc	|~~basicvars+62+2
L496:
	jsl	~~eval_integer
	sta	<L495+code_1
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
	bne	L497
	brl	L10311
L497:
	pea	#<$27
	pea	#4
	jsl	~~error
L10311:
	inc	|~~basicvars+62
	bne	L498
	inc	|~~basicvars+62+2
L498:
	jsl	~~eval_integer
	sta	<L495+x_1
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
	bne	L499
	brl	L10312
L499:
	pea	#<$27
	pea	#4
	jsl	~~error
L10312:
	inc	|~~basicvars+62
	bne	L500
	inc	|~~basicvars+62+2
L500:
	jsl	~~eval_integer
	sta	<L495+y_1
	jsl	~~check_ateol
	pei	<L495+y_1
	pei	<L495+x_1
	pei	<L495+code_1
	jsl	~~emulate_plot
L501:
	pld
	tsc
	clc
	adc	#L494
	tcs
	rtl
L494	equ	10
L495	equ	5
	ends
	efunc
	code
	xdef	~~exec_point
	func
~~exec_point:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L502
	tcs
	phd
	tcd
x_1	set	0
y_1	set	2
	inc	|~~basicvars+62
	bne	L504
	inc	|~~basicvars+62+2
L504:
	jsl	~~eval_integer
	sta	<L503+x_1
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
	bne	L505
	brl	L10313
L505:
	pea	#<$27
	pea	#4
	jsl	~~error
L10313:
	inc	|~~basicvars+62
	bne	L506
	inc	|~~basicvars+62+2
L506:
	jsl	~~eval_integer
	sta	<L503+y_1
	jsl	~~check_ateol
	pei	<L503+y_1
	pei	<L503+x_1
	jsl	~~emulate_point
L507:
	pld
	tsc
	clc
	adc	#L502
	tcs
	rtl
L502	equ	8
L503	equ	5
	ends
	efunc
	code
	xdef	~~exec_pointby
	func
~~exec_pointby:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L508
	tcs
	phd
	tcd
x_1	set	0
y_1	set	2
	inc	|~~basicvars+62
	bne	L510
	inc	|~~basicvars+62+2
L510:
	jsl	~~eval_integer
	sta	<L509+x_1
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
	bne	L511
	brl	L10314
L511:
	pea	#<$27
	pea	#4
	jsl	~~error
L10314:
	inc	|~~basicvars+62
	bne	L512
	inc	|~~basicvars+62+2
L512:
	jsl	~~eval_integer
	sta	<L509+y_1
	jsl	~~check_ateol
	pei	<L509+y_1
	pei	<L509+x_1
	jsl	~~emulate_pointby
L513:
	pld
	tsc
	clc
	adc	#L508
	tcs
	rtl
L508	equ	8
L509	equ	5
	ends
	efunc
	code
	xdef	~~exec_pointto
	func
~~exec_pointto:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L514
	tcs
	phd
	tcd
x_1	set	0
y_1	set	2
	inc	|~~basicvars+62
	bne	L516
	inc	|~~basicvars+62+2
L516:
	jsl	~~eval_integer
	sta	<L515+x_1
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
	bne	L517
	brl	L10315
L517:
	pea	#<$27
	pea	#4
	jsl	~~error
L10315:
	inc	|~~basicvars+62
	bne	L518
	inc	|~~basicvars+62+2
L518:
	jsl	~~eval_integer
	sta	<L515+y_1
	jsl	~~check_ateol
	pei	<L515+y_1
	pei	<L515+x_1
	jsl	~~emulate_pointto
L519:
	pld
	tsc
	clc
	adc	#L514
	tcs
	rtl
L514	equ	8
L515	equ	5
	ends
	efunc
	code
	func
~~print_screen:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L520
	tcs
	phd
	tcd
resultype_1	set	0
hex_1	set	2
rightjust_1	set	3
newline_1	set	4
format_1	set	5
fieldwidth_1	set	7
numdigits_1	set	9
size_1	set	11
leftfmt_1	set	13
rightfmt_1	set	17
	sep	#$20
	longa	off
	stz	<L521+hex_1
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	lda	#$1
	sta	<L521+rightjust_1
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	lda	#$1
	sta	<L521+newline_1
	rep	#$20
	longa	on
	lda	|~~basicvars+520
	sta	<L521+format_1
	lda	<L521+format_1
	beq	L522
	brl	L10316
L522:
	lda	#$90a
	sta	<L521+format_1
L10316:
	lda	<L521+format_1
	and	#<$ff
	sta	<L521+fieldwidth_1
	lda	<L521+format_1
	ldx	#<$8
	xref	~~~asr
	jsl	~~~asr
	and	#<$ff
	sta	<L521+numdigits_1
	lda	<L521+numdigits_1
	beq	L523
	brl	L10317
L523:
	lda	#$a
	sta	<L521+numdigits_1
L10317:
	lda	<L521+format_1
	ldx	#<$10
	xref	~~~asr
	jsl	~~~asr
	and	#<$ff
	brl	L10318
L10320:
	lda	#<L1
	sta	<L521+leftfmt_1
	lda	#^L1
	sta	<L521+leftfmt_1+2
	lda	#<L1+5
	sta	<L521+rightfmt_1
	lda	#^L1+5
	sta	<L521+rightfmt_1+2
	brl	L10319
L10321:
	lda	#<L1+11
	sta	<L521+leftfmt_1
	lda	#^L1+11
	sta	<L521+leftfmt_1+2
	lda	#<L1+16
	sta	<L521+rightfmt_1
	lda	#^L1+16
	sta	<L521+rightfmt_1+2
	brl	L10319
L10322:
	lda	#<L1+22
	sta	<L521+leftfmt_1
	lda	#^L1+22
	sta	<L521+leftfmt_1+2
	lda	#<L1+27
	sta	<L521+rightfmt_1
	lda	#^L1+27
	sta	<L521+rightfmt_1+2
	brl	L10319
L10318:
	xref	~~~swt
	jsl	~~~swt
	dw	2
	dw	1
	dw	L10320-1
	dw	2
	dw	L10321-1
	dw	L10322-1
L10319:
L10323:
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
	beq	L524
	brl	L10324
L524:
	sep	#$20
	longa	off
	lda	#$1
	sta	<L521+newline_1
	rep	#$20
	longa	on
L10325:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$7e
	rep	#$20
	longa	on
	bne	L526
	brl	L525
L526:
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
	bne	L527
	brl	L525
L527:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$3b
	rep	#$20
	longa	on
	bne	L528
	brl	L525
L528:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$27
	rep	#$20
	longa	on
	bne	L529
	brl	L525
L529:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$fe
	rep	#$20
	longa	on
	beq	L530
	brl	L10326
L530:
L525:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$fe
	rep	#$20
	longa	on
	beq	L531
	brl	L10327
L531:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<R0],Y
	cmp	#<$2
	rep	#$20
	longa	on
	beq	L532
	brl	L10328
L532:
	clc
	lda	#$2
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L533
	inc	|~~basicvars+62+2
L533:
	jsl	~~fn_tab
	brl	L10329
L10328:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<R0],Y
	cmp	#<$1
	rep	#$20
	longa	on
	beq	L534
	brl	L10330
L534:
	clc
	lda	#$2
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L535
	inc	|~~basicvars+62+2
L535:
	jsl	~~fn_spc
	brl	L10331
L10330:
	jsl	~~bad_token
L10331:
L10329:
	brl	L10332
L10327:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	brl	L10333
L10335:
	sep	#$20
	longa	off
	lda	#$1
	sta	<L521+hex_1
	rep	#$20
	longa	on
	inc	|~~basicvars+62
	bne	L536
	inc	|~~basicvars+62+2
L536:
	brl	L10334
L10336:
	sep	#$20
	longa	off
	stz	<L521+hex_1
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	lda	#$1
	sta	<L521+rightjust_1
	rep	#$20
	longa	on
	lda	|~~basicvars+494
	ldx	<L521+fieldwidth_1
	xref	~~~mod
	jsl	~~~mod
	sta	<L521+size_1
	lda	<L521+size_1
	bne	L537
	brl	L10337
L537:
L10340:
	pea	#<$20
	jsl	~~emulate_vdu
	inc	<L521+size_1
	inc	|~~basicvars+494
L10338:
	sec
	lda	<L521+size_1
	sbc	<L521+fieldwidth_1
	bvs	L538
	eor	#$8000
L538:
	bmi	L539
	brl	L10340
L539:
L10339:
L10337:
	inc	|~~basicvars+62
	bne	L540
	inc	|~~basicvars+62+2
L540:
	brl	L10334
L10341:
	sep	#$20
	longa	off
	stz	<L521+hex_1
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	stz	<L521+rightjust_1
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	stz	<L521+newline_1
	rep	#$20
	longa	on
	inc	|~~basicvars+62
	bne	L541
	inc	|~~basicvars+62+2
L541:
	brl	L10334
L10342:
	sep	#$20
	longa	off
	stz	<L521+hex_1
	rep	#$20
	longa	on
	jsl	~~emulate_newline
	stz	|~~basicvars+494
	inc	|~~basicvars+62
	bne	L542
	inc	|~~basicvars+62+2
L542:
	brl	L10334
L10343:
	pea	#^L1+33
	pea	#<L1+33
	pea	#<$597
	pea	#<$82
	pea	#10
	jsl	~~error
	brl	L10334
L10333:
	xref	~~~swt
	jsl	~~~swt
	dw	4
	dw	39
	dw	L10342-1
	dw	44
	dw	L10336-1
	dw	59
	dw	L10341-1
	dw	126
	dw	L10335-1
	dw	L10343-1
L10334:
L10332:
	brl	L10325
L10326:
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
	beq	L543
	brl	L10324
L543:
	sep	#$20
	longa	off
	lda	#$1
	sta	<L521+newline_1
	rep	#$20
	longa	on
	jsl	~~expression
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L521+resultype_1
	lda	<L521+resultype_1
	brl	L10344
L10346:
	lda	<L521+rightjust_1
	and	#$ff
	bne	L544
	brl	L10347
L544:
	lda	<L521+hex_1
	and	#$ff
	bne	L545
	brl	L10348
L545:
	jsl	~~pop_int
	pha
	pei	<L521+fieldwidth_1
	pea	#^L1+41
	pea	#<L1+41
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	pea	#14
	jsl	~~sprintf
	sta	<L521+size_1
	brl	L10349
L10348:
	jsl	~~pop_int
	pha
	pei	<L521+fieldwidth_1
	pea	#^L1+45
	pea	#<L1+45
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	pea	#14
	jsl	~~sprintf
	sta	<L521+size_1
L10349:
	brl	L10350
L10347:
	lda	<L521+hex_1
	and	#$ff
	bne	L546
	brl	L10351
L546:
	jsl	~~pop_int
	pha
	pea	#^L1+49
	pea	#<L1+49
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	pea	#12
	jsl	~~sprintf
	sta	<L521+size_1
	brl	L10352
L10351:
	jsl	~~pop_int
	pha
	pea	#^L1+52
	pea	#<L1+52
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	pea	#12
	jsl	~~sprintf
	sta	<L521+size_1
L10352:
L10350:
	pei	<L521+size_1
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	jsl	~~emulate_vdustr
	clc
	lda	|~~basicvars+494
	adc	<L521+size_1
	sta	|~~basicvars+494
	brl	L10345
L10353:
	lda	<L521+rightjust_1
	and	#$ff
	bne	L547
	brl	L10354
L547:
	lda	<L521+hex_1
	and	#$ff
	bne	L548
	brl	L10355
L548:
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
	pei	<L521+fieldwidth_1
	pea	#^L1+55
	pea	#<L1+55
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	pea	#14
	jsl	~~sprintf
	sta	<L521+size_1
	brl	L10356
L10355:
	phy
	phy
	jsl	~~pop_float
	xref	~~~ftod
	jsl	~~~ftod
	pei	<L521+numdigits_1
	pei	<L521+fieldwidth_1
	pei	<L521+rightfmt_1+2
	pei	<L521+rightfmt_1
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	pea	#22
	jsl	~~sprintf
	sta	<L521+size_1
L10356:
	brl	L10357
L10354:
	lda	<L521+hex_1
	and	#$ff
	bne	L549
	brl	L10358
L549:
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
	pea	#^L1+59
	pea	#<L1+59
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	pea	#12
	jsl	~~sprintf
	sta	<L521+size_1
	brl	L10359
L10358:
	phy
	phy
	jsl	~~pop_float
	xref	~~~ftod
	jsl	~~~ftod
	pei	<L521+numdigits_1
	pei	<L521+leftfmt_1+2
	pei	<L521+leftfmt_1
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	pea	#20
	jsl	~~sprintf
	sta	<L521+size_1
L10359:
L10357:
	pei	<L521+size_1
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	jsl	~~emulate_vdustr
	clc
	lda	|~~basicvars+494
	adc	<L521+size_1
	sta	|~~basicvars+494
	brl	L10345
L10360:
L10361:
descriptor_2	set	21
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L521+descriptor_2
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
	sbc	<L521+descriptor_2
	bvs	L550
	eor	#$8000
L550:
	bpl	L551
	brl	L10362
L551:
	pei	<L521+descriptor_2
	pei	<L521+descriptor_2+4
	pei	<L521+descriptor_2+2
	jsl	~~emulate_vdustr
	clc
	lda	|~~basicvars+494
	adc	<L521+descriptor_2
	sta	|~~basicvars+494
L10362:
	lda	<L521+resultype_1
	cmp	#<$5
	beq	L552
	brl	L10363
L552:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L521+descriptor_2
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
L10363:
	brl	L10345
L10364:
	pea	#<$45
	pea	#4
	jsl	~~error
	brl	L10345
L10344:
	xref	~~~fsw
	jsl	~~~fsw
	dw	2
	dw	4
	dw	L10364-1
	dw	L10346-1
	dw	L10353-1
	dw	L10360-1
	dw	L10361-1
L10345:
	brl	L10323
L10324:
	lda	<L521+newline_1
	and	#$ff
	bne	L553
	brl	L10365
L553:
	jsl	~~emulate_newline
	stz	|~~basicvars+494
L10365:
L554:
	pld
	tsc
	clc
	adc	#L520
	tcs
	rtl
L520	equ	35
L521	equ	9
	ends
	efunc
	data
L1:
	db	$25,$2E,$2A,$65,$00,$25,$2A,$2E,$2A,$65,$00,$25,$2E,$2A,$66
	db	$00,$25,$2A,$2E,$2A,$66,$00,$25,$2E,$2A,$67,$00,$25,$2A,$2E
	db	$2A,$67,$00,$69,$6F,$73,$74,$61,$74,$65,$00,$25,$2A,$58,$00
	db	$25,$2A,$64,$00,$25,$58,$00,$25,$64,$00,$25,$2A,$58,$00,$25
	db	$58,$00
	ends
	code
	func
~~print_file:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L556
	tcs
	phd
	tcd
descriptor_1	set	0
handle_1	set	6
more_1	set	8
	inc	|~~basicvars+62
	bne	L558
	inc	|~~basicvars+62+2
L558:
	jsl	~~eval_intfactor
	sta	<L557+handle_1
	stz	<R0
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	lda	[<R1]
	and	#$ff
	sta	<R1
	ldx	<R1
	lda	|~~ateol,X
	and	#$ff
	beq	L560
	brl	L559
L560:
	inc	<R0
L559:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L557+more_1
	rep	#$20
	longa	on
L10366:
	lda	<L557+more_1
	and	#$ff
	bne	L561
	brl	L10367
L561:
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
	bne	L562
	brl	L10368
L562:
	pea	#<$5
	pea	#4
	jsl	~~error
L10368:
	inc	|~~basicvars+62
	bne	L563
	inc	|~~basicvars+62+2
L563:
	jsl	~~expression
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	brl	L10369
L10371:
	jsl	~~pop_int
	pha
	pei	<L557+handle_1
	jsl	~~fileio_printint
	brl	L10370
L10372:
	phy
	phy
	jsl	~~pop_float
	pei	<L557+handle_1
	jsl	~~fileio_printfloat
	brl	L10370
L10373:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L557+descriptor_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	pei	<L557+descriptor_1
	pei	<L557+descriptor_1+4
	pei	<L557+descriptor_1+2
	pei	<L557+handle_1
	jsl	~~fileio_printstring
	brl	L10370
L10374:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L557+descriptor_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	pei	<L557+descriptor_1
	pei	<L557+descriptor_1+4
	pei	<L557+descriptor_1+2
	pei	<L557+handle_1
	jsl	~~fileio_printstring
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L557+descriptor_1
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
	brl	L10370
L10375:
	pea	#<$45
	pea	#4
	jsl	~~error
	brl	L10370
L10369:
	xref	~~~fsw
	jsl	~~~fsw
	dw	2
	dw	4
	dw	L10375-1
	dw	L10371-1
	dw	L10372-1
	dw	L10373-1
	dw	L10374-1
L10370:
	stz	<R0
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	lda	[<R1]
	and	#$ff
	sta	<R1
	ldx	<R1
	lda	|~~ateol,X
	and	#$ff
	beq	L565
	brl	L564
L565:
	inc	<R0
L564:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L557+more_1
	rep	#$20
	longa	on
	brl	L10366
L10367:
L566:
	pld
	tsc
	clc
	adc	#L556
	tcs
	rtl
L556	equ	17
L557	equ	9
	ends
	efunc
	code
	xdef	~~exec_print
	func
~~exec_print:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L567
	tcs
	phd
	tcd
	inc	|~~basicvars+62
	bne	L569
	inc	|~~basicvars+62+2
L569:
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
	beq	L570
	brl	L10376
L570:
	jsl	~~print_file
	brl	L10377
L10376:
	jsl	~~print_screen
L10377:
L571:
	pld
	tsc
	clc
	adc	#L567
	tcs
	rtl
L567	equ	4
L568	equ	5
	ends
	efunc
	code
	xdef	~~exec_rectangle
	func
~~exec_rectangle:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L572
	tcs
	phd
	tcd
x1_1	set	0
y1_1	set	2
width_1	set	4
height_1	set	6
x2_1	set	8
y2_1	set	10
filled_1	set	12
	inc	|~~basicvars+62
	bne	L574
	inc	|~~basicvars+62+2
L574:
	stz	<R0
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	sep	#$20
	longa	off
	lda	[<R1]
	cmp	#<$ab
	rep	#$20
	longa	on
	beq	L576
	brl	L575
L576:
	inc	<R0
L575:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L573+filled_1
	rep	#$20
	longa	on
	lda	<L573+filled_1
	and	#$ff
	bne	L577
	brl	L10378
L577:
	inc	|~~basicvars+62
	bne	L578
	inc	|~~basicvars+62+2
L578:
L10378:
	jsl	~~eval_integer
	sta	<L573+x1_1
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
	bne	L579
	brl	L10379
L579:
	pea	#<$27
	pea	#4
	jsl	~~error
L10379:
	inc	|~~basicvars+62
	bne	L580
	inc	|~~basicvars+62+2
L580:
	jsl	~~eval_integer
	sta	<L573+y1_1
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
	bne	L581
	brl	L10380
L581:
	pea	#<$27
	pea	#4
	jsl	~~error
L10380:
	inc	|~~basicvars+62
	bne	L582
	inc	|~~basicvars+62+2
L582:
	jsl	~~eval_integer
	sta	<L573+width_1
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
	beq	L583
	brl	L10381
L583:
	inc	|~~basicvars+62
	bne	L584
	inc	|~~basicvars+62+2
L584:
	jsl	~~eval_integer
	sta	<L573+height_1
	brl	L10382
L10381:
	lda	<L573+width_1
	sta	<L573+height_1
L10382:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$e1
	rep	#$20
	longa	on
	beq	L585
	brl	L10383
L585:
	inc	|~~basicvars+62
	bne	L586
	inc	|~~basicvars+62+2
L586:
	jsl	~~eval_integer
	sta	<L573+x2_1
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
	bne	L587
	brl	L10384
L587:
	pea	#<$27
	pea	#4
	jsl	~~error
L10384:
	inc	|~~basicvars+62
	bne	L588
	inc	|~~basicvars+62+2
L588:
	jsl	~~eval_integer
	sta	<L573+y2_1
	jsl	~~check_ateol
	pei	<L573+filled_1
	pei	<L573+y2_1
	pei	<L573+x2_1
	pei	<L573+height_1
	pei	<L573+width_1
	pei	<L573+y1_1
	pei	<L573+x1_1
	jsl	~~emulate_moverect
	brl	L10385
L10383:
	jsl	~~check_ateol
	pei	<L573+filled_1
	pei	<L573+height_1
	pei	<L573+width_1
	pei	<L573+y1_1
	pei	<L573+x1_1
	jsl	~~emulate_drawrect
L10385:
L589:
	pld
	tsc
	clc
	adc	#L572
	tcs
	rtl
L572	equ	21
L573	equ	9
	ends
	efunc
	code
	xdef	~~exec_sound
	func
~~exec_sound:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L590
	tcs
	phd
	tcd
channel_1	set	0
amplitude_1	set	2
pitch_1	set	4
duration_1	set	6
delay_1	set	8
	inc	|~~basicvars+62
	bne	L592
	inc	|~~basicvars+62+2
L592:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	brl	L10386
L10388:
	inc	|~~basicvars+62
	bne	L593
	inc	|~~basicvars+62+2
L593:
	jsl	~~check_ateol
	jsl	~~emulate_sound_on
	brl	L10387
L10389:
	inc	|~~basicvars+62
	bne	L594
	inc	|~~basicvars+62+2
L594:
	jsl	~~check_ateol
	jsl	~~emulate_sound_off
	brl	L10387
L10390:
	stz	<L591+delay_1
	jsl	~~eval_integer
	sta	<L591+channel_1
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
	bne	L595
	brl	L10391
L595:
	pea	#<$27
	pea	#4
	jsl	~~error
L10391:
	inc	|~~basicvars+62
	bne	L596
	inc	|~~basicvars+62+2
L596:
	jsl	~~eval_integer
	sta	<L591+amplitude_1
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
	bne	L597
	brl	L10392
L597:
	pea	#<$27
	pea	#4
	jsl	~~error
L10392:
	inc	|~~basicvars+62
	bne	L598
	inc	|~~basicvars+62+2
L598:
	jsl	~~eval_integer
	sta	<L591+pitch_1
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
	bne	L599
	brl	L10393
L599:
	pea	#<$27
	pea	#4
	jsl	~~error
L10393:
	inc	|~~basicvars+62
	bne	L600
	inc	|~~basicvars+62+2
L600:
	jsl	~~eval_integer
	sta	<L591+duration_1
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
	beq	L601
	brl	L10394
L601:
	inc	|~~basicvars+62
	bne	L602
	inc	|~~basicvars+62+2
L602:
	jsl	~~eval_integer
	sta	<L591+delay_1
L10394:
	jsl	~~check_ateol
	pei	<L591+delay_1
	pei	<L591+duration_1
	pei	<L591+pitch_1
	pei	<L591+amplitude_1
	pei	<L591+channel_1
	jsl	~~emulate_sound
	brl	L10387
L10386:
	xref	~~~swt
	jsl	~~~swt
	dw	2
	dw	193
	dw	L10389-1
	dw	194
	dw	L10388-1
	dw	L10390-1
L10387:
L603:
	pld
	tsc
	clc
	adc	#L590
	tcs
	rtl
L590	equ	14
L591	equ	5
	ends
	efunc
	code
	xdef	~~exec_stereo
	func
~~exec_stereo:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L604
	tcs
	phd
	tcd
channel_1	set	0
position_1	set	2
	inc	|~~basicvars+62
	bne	L606
	inc	|~~basicvars+62+2
L606:
	jsl	~~eval_integer
	sta	<L605+channel_1
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
	brl	L10395
L607:
	pea	#<$27
	pea	#4
	jsl	~~error
L10395:
	inc	|~~basicvars+62
	bne	L608
	inc	|~~basicvars+62+2
L608:
	jsl	~~eval_integer
	sta	<L605+position_1
	jsl	~~check_ateol
	pei	<L605+position_1
	pei	<L605+channel_1
	jsl	~~emulate_stereo
L609:
	pld
	tsc
	clc
	adc	#L604
	tcs
	rtl
L604	equ	8
L605	equ	5
	ends
	efunc
	code
	xdef	~~exec_tempo
	func
~~exec_tempo:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L610
	tcs
	phd
	tcd
tempo_1	set	0
	inc	|~~basicvars+62
	bne	L612
	inc	|~~basicvars+62+2
L612:
	jsl	~~eval_integer
	sta	<L611+tempo_1
	jsl	~~check_ateol
	pei	<L611+tempo_1
	jsl	~~emulate_tempo
L613:
	pld
	tsc
	clc
	adc	#L610
	tcs
	rtl
L610	equ	2
L611	equ	1
	ends
	efunc
	code
	xdef	~~exec_tint
	func
~~exec_tint:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L614
	tcs
	phd
	tcd
colour_1	set	0
tint_1	set	2
	inc	|~~basicvars+62
	bne	L616
	inc	|~~basicvars+62+2
L616:
	jsl	~~eval_integer
	sta	<L615+colour_1
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
	bne	L617
	brl	L10396
L617:
	pea	#<$27
	pea	#4
	jsl	~~error
L10396:
	inc	|~~basicvars+62
	bne	L618
	inc	|~~basicvars+62+2
L618:
	jsl	~~eval_integer
	sta	<L615+tint_1
	jsl	~~check_ateol
	pei	<L615+tint_1
	pei	<L615+colour_1
	jsl	~~emulate_tint
L619:
	pld
	tsc
	clc
	adc	#L614
	tcs
	rtl
L614	equ	8
L615	equ	5
	ends
	efunc
	code
	xdef	~~exec_vdu
	func
~~exec_vdu:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L620
	tcs
	phd
	tcd
n_1	set	0
value_1	set	2
	inc	|~~basicvars+62
	bne	L622
	inc	|~~basicvars+62+2
L622:
L10399:
	jsl	~~eval_integer
	sta	<L621+value_1
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$3b
	rep	#$20
	longa	on
	beq	L623
	brl	L10400
L623:
	pei	<L621+value_1
	jsl	~~emulate_vdu
	lda	<L621+value_1
	ldx	#<$8
	xref	~~~asr
	jsl	~~~asr
	pha
	jsl	~~emulate_vdu
	inc	|~~basicvars+62
	bne	L624
	inc	|~~basicvars+62+2
L624:
	brl	L10401
L10400:
	pei	<L621+value_1
	jsl	~~emulate_vdu
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
	beq	L625
	brl	L10402
L625:
	inc	|~~basicvars+62
	bne	L626
	inc	|~~basicvars+62+2
L626:
	brl	L10403
L10402:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$7c
	rep	#$20
	longa	on
	beq	L627
	brl	L10404
L627:
	lda	#$1
	sta	<L621+n_1
L10407:
	pea	#<$0
	jsl	~~emulate_vdu
L10405:
	inc	<L621+n_1
	sec
	lda	#$9
	sbc	<L621+n_1
	bvs	L628
	eor	#$8000
L628:
	bpl	L629
	brl	L10407
L629:
L10406:
	inc	|~~basicvars+62
	bne	L630
	inc	|~~basicvars+62+2
L630:
L10404:
L10403:
L10401:
L10397:
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
	bne	L631
	brl	L10399
L631:
L10398:
L632:
	pld
	tsc
	clc
	adc	#L620
	tcs
	rtl
L620	equ	8
L621	equ	5
	ends
	efunc
	code
	xdef	~~exec_voice
	func
~~exec_voice:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L633
	tcs
	phd
	tcd
channel_1	set	0
name_1	set	2
stringtype_1	set	8
	inc	|~~basicvars+62
	bne	L635
	inc	|~~basicvars+62+2
L635:
	jsl	~~eval_integer
	sta	<L634+channel_1
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
	bne	L636
	brl	L10408
L636:
	pea	#<$27
	pea	#4
	jsl	~~error
L10408:
	inc	|~~basicvars+62
	bne	L637
	inc	|~~basicvars+62+2
L637:
	jsl	~~expression
	jsl	~~check_ateol
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L634+stringtype_1
	lda	<L634+stringtype_1
	cmp	#<$4
	bne	L638
	brl	L10409
L638:
	lda	<L634+stringtype_1
	cmp	#<$5
	bne	L639
	brl	L10409
L639:
	pea	#<$40
	pea	#4
	jsl	~~error
L10409:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L634+name_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	pei	<L634+name_1
	pei	<L634+name_1+4
	pei	<L634+name_1+2
	jsl	~~tocstring
	sta	<R0
	stx	<R0+2
	phx
	pha
	pei	<L634+channel_1
	jsl	~~emulate_voice
	lda	<L634+stringtype_1
	cmp	#<$5
	beq	L640
	brl	L10410
L640:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L634+name_1
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
L10410:
L641:
	pld
	tsc
	clc
	adc	#L633
	tcs
	rtl
L633	equ	18
L634	equ	9
	ends
	efunc
	code
	xdef	~~exec_voices
	func
~~exec_voices:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L642
	tcs
	phd
	tcd
count_1	set	0
	inc	|~~basicvars+62
	bne	L644
	inc	|~~basicvars+62+2
L644:
	jsl	~~eval_integer
	sta	<L643+count_1
	jsl	~~check_ateol
	pei	<L643+count_1
	jsl	~~emulate_voices
L645:
	pld
	tsc
	clc
	adc	#L642
	tcs
	rtl
L642	equ	2
L643	equ	1
	ends
	efunc
	code
	xdef	~~exec_width
	func
~~exec_width:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L646
	tcs
	phd
	tcd
width_1	set	0
	inc	|~~basicvars+62
	bne	L648
	inc	|~~basicvars+62+2
L648:
	jsl	~~eval_integer
	sta	<L647+width_1
	jsl	~~check_ateol
	lda	<L647+width_1
	bpl	L650
	brl	L649
L650:
	lda	<L647+width_1
	bra	L651
L649:
	lda	#$0
L651:
	sta	|~~basicvars+496
L652:
	pld
	tsc
	clc
	adc	#L646
	tcs
	rtl
L646	equ	2
L647	equ	1
	ends
	efunc
	xref	~~store_value
	xref	~~bad_token
	xref	~~check_ateol
	xref	~~get_lvalue
	xref	~~emulate_origin
	xref	~~emulate_fillby
	xref	~~emulate_fill
	xref	~~emulate_moverect
	xref	~~emulate_drawrect
	xref	~~emulate_ellipse
	xref	~~emulate_circle
	xref	~~emulate_line
	xref	~~emulate_pointto
	xref	~~emulate_pointby
	xref	~~emulate_point
	xref	~~emulate_drawby
	xref	~~emulate_draw
	xref	~~emulate_moveby
	xref	~~emulate_move
	xref	~~emulate_plot
	xref	~~emulate_tint
	xref	~~emulate_gcolnum
	xref	~~emulate_gcolrgb
	xref	~~emulate_gcol
	xref	~~emulate_defcolour
	xref	~~emulate_setcolnum
	xref	~~emulate_setcolour
	xref	~~emulate_mapcolour
	xref	~~emulate_colourtint
	xref	~~emulate_off
	xref	~~emulate_newmode
	xref	~~emulate_modestr
	xref	~~emulate_mode
	xref	~~emulate_newline
	xref	~~emulate_vdustr
	xref	~~emulate_vdu
	xref	~~emulate_tab
	xref	~~fileio_printstring
	xref	~~fileio_printfloat
	xref	~~fileio_printint
	xref	~~fileio_bputstr
	xref	~~fileio_bput
	xref	~~fileio_getstring
	xref	~~fileio_getnumber
	xref	~~fileio_close
	xref	~~emulate_stereo
	xref	~~emulate_voices
	xref	~~emulate_voice
	xref	~~emulate_tempo
	xref	~~emulate_beats
	xref	~~emulate_sound
	xref	~~emulate_sound_off
	xref	~~emulate_sound_on
	xref	~~emulate_mouse
	xref	~~emulate_mouse_rectangle
	xref	~~emulate_mouse_colour
	xref	~~emulate_mouse_step
	xref	~~emulate_mouse_to
	xref	~~emulate_mouse_off
	xref	~~emulate_mouse_on
	xref	~~tonumber
	xref	~~eval_intfactor
	xref	~~eval_integer
	xref	~~expression
	xref	~~tocstring
	xref	~~skip_blanks
	xref	~~store_float
	xref	~~store_integer
	xref	~~check_write
	xref	~~read_line
	xref	~~error
	xref	~~free_string
	xref	~~alloc_string
	xref	~~pop_string
	xref	~~pop_float
	xref	~~pop_int
	xref	~~get_srcaddr
	xref	~~skip_token
	xref	~~toupper
	xref	~~isdigit
	xref	~~memmove
	xref	~~sprintf
	xref	~~ateol
	xref	~~basicvars
	end
