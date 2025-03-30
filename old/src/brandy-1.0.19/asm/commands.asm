;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
	data
~~lastaddr:
	dw	$0
	ends
	code
	func
~~get_number:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
	jsl	~~factor
	jsl	~~get_topitem
	brl	L10001
L10003:
	jsl	~~pop_int
L4:
	tay
	pld
	tsc
	clc
	adc	#L2
	tcs
	tya
	rtl
L10004:
	phy
	phy
	jsl	~~pop_float
	ply
	ply
	lda	<R0
	brl	L4
L10005:
	pea	#<$3f
	pea	#4
	jsl	~~error
	brl	L10002
L10001:
	xref	~~~swt
	jsl	~~~swt
	dw	2
	dw	2
	dw	L10003-1
	dw	3
	dw	L10004-1
	dw	L10005-1
L10002:
	lda	#$0
	brl	L4
L2	equ	4
L3	equ	5
	ends
	efunc
	code
	func
~~get_pair:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L5
	tcs
	phd
	tcd
first_0	set	4
second_0	set	8
firstdef_0	set	12
secondef_0	set	14
low_1	set	0
high_1	set	2
	lda	<L5+firstdef_0
	sta	[<L5+first_0]
	lda	<L5+secondef_0
	sta	[<L5+second_0]
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~isateol
	and	#$ff
	bne	L7
	brl	L10006
L7:
L8:
	lda	<L5+2
	sta	<L5+2+12
	lda	<L5+1
	sta	<L5+1+12
	pld
	tsc
	clc
	adc	#L5+12
	tcs
	rtl
L10006:
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
	bne	L10
	brl	L9
L10:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$2d
	rep	#$20
	longa	on
	beq	L11
	brl	L10007
L11:
L9:
	lda	<L5+firstdef_0
	sta	<L6+low_1
	brl	L10008
L10007:
	jsl	~~get_number
	sta	<L6+low_1
L10008:
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~isateol
	and	#$ff
	bne	L12
	brl	L10009
L12:
	lda	<L6+low_1
	sta	<L6+high_1
	brl	L10010
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
	bne	L14
	brl	L13
L14:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$2d
	rep	#$20
	longa	on
	beq	L15
	brl	L10011
L15:
L13:
	inc	|~~basicvars+62
	bne	L16
	inc	|~~basicvars+62+2
L16:
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~isateol
	and	#$ff
	bne	L17
	brl	L10012
L17:
	lda	<L5+secondef_0
	sta	<L6+high_1
	brl	L10013
L10012:
	jsl	~~get_number
	sta	<L6+high_1
	jsl	~~check_ateol
L10013:
	brl	L10014
L10011:
	pea	#<$5
	pea	#4
	jsl	~~error
L10014:
L10010:
	lda	<L6+low_1
	sta	[<L5+first_0]
	lda	<L6+high_1
	sta	[<L5+second_0]
	brl	L8
L5	equ	8
L6	equ	5
	ends
	efunc
	code
	func
~~get_name:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L18
	tcs
	phd
	tcd
topitem_1	set	0
descriptor_1	set	2
cp_1	set	8
	jsl	~~expression
	jsl	~~get_topitem
	sta	<L19+topitem_1
	lda	<L19+topitem_1
	cmp	#<$4
	bne	L20
	brl	L10015
L20:
	lda	<L19+topitem_1
	cmp	#<$5
	bne	L21
	brl	L10015
L21:
	pea	#<$40
	pea	#4
	jsl	~~error
L10015:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L19+descriptor_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	pei	<L19+descriptor_1
	pei	<L19+descriptor_1+4
	pei	<L19+descriptor_1+2
	jsl	~~tocstring
	sta	<L19+cp_1
	stx	<L19+cp_1+2
	lda	<L19+topitem_1
	cmp	#<$5
	beq	L22
	brl	L10016
L22:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L19+descriptor_1
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
L10016:
	ldx	<L19+cp_1+2
	lda	<L19+cp_1
L23:
	tay
	pld
	tsc
	clc
	adc	#L18
	tcs
	tya
	rtl
L18	equ	20
L19	equ	9
	ends
	efunc
	code
	func
~~exec_new:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L24
	tcs
	phd
	tcd
oldsize_1	set	0
newsize_1	set	2
ok_1	set	4
	lda	|~~basicvars+423
	bit	#$1
	bne	L26
	brl	L10017
L26:
	pea	#<$83
	pea	#4
	jsl	~~error
L10017:
	inc	|~~basicvars+62
	bne	L27
	inc	|~~basicvars+62+2
L27:
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~isateol
	and	#$ff
	beq	L28
	brl	L10018
L28:
	jsl	~~get_number
	sta	<L25+newsize_1
	jsl	~~check_ateol
	lda	|~~basicvars+4
	sta	<L25+oldsize_1
	jsl	~~release_workspace
	ldy	#$0
	lda	<L25+newsize_1
	bpl	L29
	dey
L29:
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
	pei	<R0
	jsl	~~init_workspace
	sep	#$20
	longa	off
	sta	<L25+ok_1
	rep	#$20
	longa	on
	lda	<L25+ok_1
	and	#$ff
	beq	L30
	brl	L10019
L30:
	pei	<L25+oldsize_1
	jsl	~~init_workspace
	pea	#<$81
	pea	#4
	jsl	~~error
L10019:
	lda	|~~basicvars+4
	pha
	pea	#<$8b
	pea	#6
	jsl	~~error
L10018:
	jsl	~~clear_program
	jsl	~~init_expressions
L31:
	pld
	tsc
	clc
	adc	#L24
	tcs
	rtl
L24	equ	13
L25	equ	9
	ends
	efunc
	code
	func
~~exec_old:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L32
	tcs
	phd
	tcd
	inc	|~~basicvars+62
	bne	L34
	inc	|~~basicvars+62+2
L34:
	jsl	~~check_ateol
	lda	|~~basicvars+423
	bit	#$1
	bne	L35
	brl	L10020
L35:
	pea	#<$83
	pea	#4
	jsl	~~error
L10020:
	jsl	~~recover_program
L36:
	pld
	tsc
	clc
	adc	#L32
	tcs
	rtl
L32	equ	0
L33	equ	1
	ends
	efunc
	code
	func
~~list_vars:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L37
	tcs
	phd
	tcd
p_1	set	0
ch_1	set	4
lp_1	set	5
found_1	set	9
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~get_srcaddr
	sta	<L38+p_1
	stx	<L38+p_1+2
	clc
	lda	#$3
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L39
	inc	|~~basicvars+62+2
L39:
	jsl	~~check_ateol
	sep	#$20
	longa	off
	lda	[<L38+p_1]
	sta	<L38+ch_1
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	lda	<L38+ch_1
	cmp	#<$22
	rep	#$20
	longa	on
	beq	L40
	brl	L10021
L40:
len_2	set	10
start_2	set	12
	inc	<L38+p_1
	bne	L41
	inc	<L38+p_1+2
L41:
	lda	<L38+p_1
	sta	<L38+start_2
	lda	<L38+p_1+2
	sta	<L38+start_2+2
L10022:
	sep	#$20
	longa	off
	lda	[<L38+p_1]
	cmp	#<$22
	rep	#$20
	longa	on
	bne	L42
	brl	L10023
L42:
	inc	<L38+p_1
	bne	L43
	inc	<L38+p_1+2
L43:
	brl	L10022
L10023:
	sec
	lda	<L38+p_1
	sbc	<L38+start_2
	sta	<R0
	lda	<L38+p_1+2
	sbc	<L38+start_2+2
	sta	<R0+2
	lda	<R0
	sta	<L38+len_2
	lda	<L38+len_2
	beq	L44
	brl	L10024
L44:
L45:
	pld
	tsc
	clc
	adc	#L37
	tcs
	rtl
L10024:
	ldy	#$0
	lda	<L38+len_2
	bpl	L46
	dey
L46:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L38+start_2+2
	pei	<L38+start_2
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	jsl	~~memcpy
	lda	|~~basicvars+70
	sta	<R0
	lda	|~~basicvars+70+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$0
	ldy	<L38+len_2
	sta	[<R0],Y
	rep	#$20
	longa	on
	lda	|~~basicvars+411
	sta	<L38+lp_1
	lda	|~~basicvars+411+2
	sta	<L38+lp_1+2
L10025:
	lda	<L38+lp_1
	ora	<L38+lp_1+2
	bne	L47
	brl	L10026
L47:
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	ldy	#$6
	lda	[<L38+lp_1],Y
	pha
	ldy	#$4
	lda	[<L38+lp_1],Y
	pha
	jsl	~~strcmp
	tax
	bne	L48
	brl	L10026
L48:
	lda	[<L38+lp_1]
	sta	<R0
	ldy	#$2
	lda	[<L38+lp_1],Y
	sta	<R0+2
	lda	<R0
	sta	<L38+lp_1
	lda	<R0+2
	sta	<L38+lp_1+2
	brl	L10025
L10026:
	stz	<R0
	lda	<L38+lp_1
	ora	<L38+lp_1+2
	bne	L50
	brl	L49
L50:
	inc	<R0
L49:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L38+found_1
	rep	#$20
	longa	on
	lda	<L38+lp_1
	ora	<L38+lp_1+2
	bne	L51
	brl	L10027
L51:
	pei	<L38+lp_1+2
	pei	<L38+lp_1
	jsl	~~detail_library
L10027:
	lda	|~~basicvars+415
	sta	<L38+lp_1
	lda	|~~basicvars+415+2
	sta	<L38+lp_1+2
L10028:
	lda	<L38+lp_1
	ora	<L38+lp_1+2
	bne	L52
	brl	L10029
L52:
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	ldy	#$6
	lda	[<L38+lp_1],Y
	pha
	ldy	#$4
	lda	[<L38+lp_1],Y
	pha
	jsl	~~strcmp
	tax
	bne	L53
	brl	L10029
L53:
	lda	[<L38+lp_1]
	sta	<R0
	ldy	#$2
	lda	[<L38+lp_1],Y
	sta	<R0+2
	lda	<R0
	sta	<L38+lp_1
	lda	<R0+2
	sta	<L38+lp_1+2
	brl	L10028
L10029:
	stz	<R0
	lda	<L38+found_1
	and	#$ff
	beq	L56
	brl	L55
L56:
	lda	<L38+lp_1
	ora	<L38+lp_1+2
	bne	L57
	brl	L54
L57:
L55:
	inc	<R0
L54:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L38+found_1
	rep	#$20
	longa	on
	lda	<L38+lp_1
	ora	<L38+lp_1+2
	bne	L58
	brl	L10030
L58:
	pei	<L38+lp_1+2
	pei	<L38+lp_1
	jsl	~~detail_library
L10030:
	lda	<L38+found_1
	and	#$ff
	beq	L59
	brl	L10031
L59:
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	pea	#<$6a
	pea	#8
	jsl	~~error
L10031:
	brl	L10032
L10021:
	lda	<L38+ch_1
	and	#$ff
	pha
	jsl	~~isalpha
	tax
	bne	L60
	brl	L10033
L60:
	lda	<L38+ch_1
	and	#$ff
	pha
	pea	#^L1
	pea	#<L1
	pea	#8
	jsl	~~emulate_printf
	brl	L10034
L10033:
	sep	#$20
	longa	off
	lda	#$20
	sta	<L38+ch_1
	rep	#$20
	longa	on
	pea	#^L1+43
	pea	#<L1+43
	pea	#6
	jsl	~~emulate_printf
L10034:
	pei	<L38+ch_1
	jsl	~~list_variables
	pei	<L38+ch_1
	jsl	~~list_libraries
L10032:
	brl	L45
L37	equ	20
L38	equ	5
	ends
	efunc
	data
L1:
	db	$56,$61,$72,$69,$61,$62,$6C,$65,$73,$20,$69,$6E,$20,$70,$72
	db	$6F,$67,$72,$61,$6D,$20,$73,$74,$61,$72,$74,$69,$6E,$67,$20
	db	$77,$69,$74,$68,$20,$27,$25,$63,$27,$3A,$0D,$0A,$00,$56,$61
	db	$72,$69,$61,$62,$6C,$65,$73,$20,$69,$6E,$20,$70,$72,$6F,$67
	db	$72,$61,$6D,$3A,$0D,$0A,$00
	ends
	code
	func
~~list_if:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L62
	tcs
	phd
	tcd
p_1	set	0
tp_1	set	4
targetlen_1	set	8
statelen_1	set	10
first_1	set	12
sp_1	set	13
more_1	set	17
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~get_srcaddr
	sta	<L63+tp_1
	stx	<L63+tp_1+2
	lda	<L63+tp_1
	sta	<L63+p_1
	lda	<L63+tp_1+2
	sta	<L63+p_1+2
	clc
	lda	#$3
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L64
	inc	|~~basicvars+62+2
L64:
	jsl	~~check_ateol
L10035:
	lda	[<L63+p_1]
	and	#$ff
	bne	L65
	brl	L10036
L65:
	inc	<L63+p_1
	bne	L66
	inc	<L63+p_1+2
L66:
	brl	L10035
L10036:
	sec
	lda	<L63+p_1
	sbc	<L63+tp_1
	sta	<R0
	lda	<L63+p_1+2
	sbc	<L63+tp_1+2
	sta	<R0+2
	lda	<R0
	sta	<L63+targetlen_1
	lda	<L63+targetlen_1
	beq	L67
	brl	L10037
L67:
L68:
	pld
	tsc
	clc
	adc	#L62
	tcs
	rtl
L10037:
	lda	|~~basicvars+22
	sta	<L63+p_1
	lda	|~~basicvars+22+2
	sta	<L63+p_1+2
	sep	#$20
	longa	off
	lda	#$1
	sta	<L63+more_1
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	lda	[<L63+tp_1]
	sta	<L63+first_1
	rep	#$20
	longa	on
L10038:
	lda	<L63+more_1
	and	#$ff
	bne	L69
	brl	L10039
L69:
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L63+p_1],Y
	cmp	#<$ff
	rep	#$20
	longa	on
	bne	L70
	brl	L10039
L70:
	jsl	~~reset_indent
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	pei	<L63+p_1+2
	pei	<L63+p_1
	jsl	~~expand
	lda	|~~basicvars+70
	sta	<L63+sp_1
	lda	|~~basicvars+70+2
	sta	<L63+sp_1+2
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	jsl	~~strlen
	sta	<L63+statelen_1
L10042:
	inc	<L63+sp_1
	bne	L71
	inc	<L63+sp_1+2
L71:
L10043:
	sec
	lda	<L63+statelen_1
	sbc	<L63+targetlen_1
	bvs	L72
	eor	#$8000
L72:
	bmi	L73
	brl	L10044
L73:
	sep	#$20
	longa	off
	lda	[<L63+sp_1]
	cmp	<L63+first_1
	rep	#$20
	longa	on
	bne	L74
	brl	L10044
L74:
	dec	<L63+statelen_1
	inc	<L63+sp_1
	bne	L75
	inc	<L63+sp_1+2
L75:
	brl	L10043
L10044:
L10040:
	sec
	lda	<L63+statelen_1
	sbc	<L63+targetlen_1
	bvs	L77
	eor	#$8000
L77:
	bmi	L78
	brl	L76
L78:
	ldy	#$0
	lda	<L63+targetlen_1
	bpl	L79
	dey
L79:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L63+tp_1+2
	pei	<L63+tp_1
	pei	<L63+sp_1+2
	pei	<L63+sp_1
	jsl	~~memcmp
	tax
	beq	L80
	brl	L10042
L80:
L76:
L10041:
	sec
	lda	<L63+statelen_1
	sbc	<L63+targetlen_1
	bvs	L81
	eor	#$8000
L81:
	bmi	L82
	brl	L10045
L82:
	lda	|~~basicvars+435
	bit	#$2
	bne	L83
	brl	L10046
L83:
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	pei	<L63+p_1+2
	pei	<L63+p_1
	pea	#^L61
	pea	#<L61
	pea	#14
	jsl	~~emulate_printf
	brl	L10047
L10046:
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	pea	#^L61+11
	pea	#<L61+11
	pea	#10
	jsl	~~emulate_printf
L10047:
L10045:
	ldy	#$2
	lda	[<L63+p_1],Y
	and	#$ff
	sta	<R0
	ldy	#$3
	lda	[<L63+p_1],Y
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
	bpl	L84
	dey
L84:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L63+p_1
	adc	<R0
	sta	<L63+p_1
	lda	<L63+p_1+2
	adc	<R0+2
	sta	<L63+p_1+2
	brl	L10038
L10039:
	brl	L68
L62	equ	30
L63	equ	13
	ends
	efunc
	data
L61:
	db	$25,$30,$38,$70,$20,$20,$25,$73,$0D,$0A,$00,$25,$73,$0D,$0A
	db	$00
	ends
	code
	func
~~set_listoption:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L86
	tcs
	phd
	tcd
listopts_0	set	4
	stz	<R0
	lda	<L86+listopts_0
	and	#<$1
	bne	L89
	brl	L88
L89:
	inc	<R0
L88:
	lda	<R0
	and	#<$1
	sta	<R0
	lda	#$1
	trb	|~~basicvars+429
	lda	<R0
	tsb	|~~basicvars+429
	stz	<R0
	lda	<L86+listopts_0
	and	#<$2
	bne	L91
	brl	L90
L91:
	inc	<R0
L90:
	asl	<R0
	lda	<R0
	and	#<$2
	sta	<R0
	lda	#$2
	trb	|~~basicvars+429
	lda	<R0
	tsb	|~~basicvars+429
	stz	<R0
	lda	<L86+listopts_0
	and	#<$4
	bne	L93
	brl	L92
L93:
	inc	<R0
L92:
	asl	<R0
	asl	<R0
	lda	<R0
	and	#<$4
	sta	<R0
	lda	#$4
	trb	|~~basicvars+429
	lda	<R0
	tsb	|~~basicvars+429
	stz	<R0
	lda	<L86+listopts_0
	and	#<$8
	bne	L95
	brl	L94
L95:
	inc	<R0
L94:
	asl	<R0
	asl	<R0
	asl	<R0
	lda	<R0
	and	#<$8
	sta	<R0
	lda	#$8
	trb	|~~basicvars+429
	lda	<R0
	tsb	|~~basicvars+429
	stz	<R0
	lda	<L86+listopts_0
	and	#<$10
	bne	L97
	brl	L96
L97:
	inc	<R0
L96:
	asl	<R0
	asl	<R0
	asl	<R0
	asl	<R0
	lda	<R0
	and	#<$10
	sta	<R0
	lda	#$10
	trb	|~~basicvars+429
	lda	<R0
	tsb	|~~basicvars+429
	stz	<R0
	lda	<L86+listopts_0
	and	#<$20
	bne	L99
	brl	L98
L99:
	inc	<R0
L98:
	asl	<R0
	asl	<R0
	asl	<R0
	asl	<R0
	asl	<R0
	lda	<R0
	and	#<$20
	sta	<R0
	lda	#$20
	trb	|~~basicvars+429
	lda	<R0
	tsb	|~~basicvars+429
	stz	<R0
	lda	<L86+listopts_0
	and	#<$40
	bne	L101
	brl	L100
L101:
	inc	<R0
L100:
	asl	<R0
	asl	<R0
	asl	<R0
	asl	<R0
	asl	<R0
	asl	<R0
	lda	<R0
	and	#<$40
	sta	<R0
	lda	#$40
	trb	|~~basicvars+429
	lda	<R0
	tsb	|~~basicvars+429
L102:
	lda	<L86+2
	sta	<L86+2+2
	lda	<L86+1
	sta	<L86+1+2
	pld
	tsc
	clc
	adc	#L86+2
	tcs
	rtl
L86	equ	4
L87	equ	5
	ends
	efunc
	code
	func
~~set_listopt:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L103
	tcs
	phd
	tcd
listopts_1	set	0
	inc	|~~basicvars+62
	bne	L105
	inc	|~~basicvars+62+2
L105:
	jsl	~~get_number
	sta	<L104+listopts_1
	jsl	~~check_ateol
	pei	<L104+listopts_1
	jsl	~~set_listoption
	stz	<R0
	lda	<L104+listopts_1
	and	#<$100
	bne	L107
	brl	L106
L107:
	inc	<R0
L106:
	lda	<R0
	and	#<$1
	sta	<R0
	lda	#$1
	trb	|~~basicvars+435
	lda	<R0
	tsb	|~~basicvars+435
	stz	<R0
	lda	<L104+listopts_1
	and	#<$200
	bne	L109
	brl	L108
L109:
	inc	<R0
L108:
	asl	<R0
	lda	<R0
	and	#<$2
	sta	<R0
	lda	#$2
	trb	|~~basicvars+435
	lda	<R0
	tsb	|~~basicvars+435
	stz	<R0
	lda	<L104+listopts_1
	and	#<$400
	bne	L111
	brl	L110
L111:
	inc	<R0
L110:
	asl	<R0
	asl	<R0
	lda	<R0
	and	#<$4
	sta	<R0
	lda	#$4
	trb	|~~basicvars+435
	lda	<R0
	tsb	|~~basicvars+435
	stz	<R0
	lda	<L104+listopts_1
	and	#<$800
	bne	L113
	brl	L112
L113:
	inc	<R0
L112:
	asl	<R0
	asl	<R0
	asl	<R0
	lda	<R0
	and	#<$8
	sta	<R0
	lda	#$8
	trb	|~~basicvars+435
	lda	<R0
	tsb	|~~basicvars+435
	stz	<R0
	lda	<L104+listopts_1
	and	#<$1000
	bne	L115
	brl	L114
L115:
	inc	<R0
L114:
	asl	<R0
	asl	<R0
	asl	<R0
	asl	<R0
	lda	<R0
	and	#<$10
	sta	<R0
	lda	#$10
	trb	|~~basicvars+435
	lda	<R0
	tsb	|~~basicvars+435
	stz	<R0
	lda	<L104+listopts_1
	and	#<$2000
	bne	L117
	brl	L116
L117:
	inc	<R0
L116:
	asl	<R0
	asl	<R0
	asl	<R0
	asl	<R0
	asl	<R0
	lda	<R0
	and	#<$20
	sta	<R0
	lda	#$20
	trb	|~~basicvars+435
	lda	<R0
	tsb	|~~basicvars+435
	stz	<R0
	lda	<L104+listopts_1
	and	#<$4000
	bne	L119
	brl	L118
L119:
	inc	<R0
L118:
	asl	<R0
	asl	<R0
	asl	<R0
	asl	<R0
	asl	<R0
	asl	<R0
	lda	<R0
	and	#<$40
	sta	<R0
	lda	#$40
	trb	|~~basicvars+435
	lda	<R0
	tsb	|~~basicvars+435
L120:
	pld
	tsc
	clc
	adc	#L103
	tcs
	rtl
L103	equ	6
L104	equ	5
	ends
	efunc
	code
	func
~~delete:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L121
	tcs
	phd
	tcd
low_1	set	0
high_1	set	2
	lda	|~~basicvars+437
	bit	#$1
	bne	L123
	brl	L10048
L123:
	pea	#<$7
	pea	#4
	jsl	~~error
L10048:
	lda	|~~basicvars+423
	bit	#$1
	bne	L124
	brl	L10049
L124:
	pea	#<$83
	pea	#4
	jsl	~~error
L10049:
	inc	|~~basicvars+62
	bne	L125
	inc	|~~basicvars+62+2
L125:
	pea	#<$feff
	pea	#<$0
	pea	#0
	clc
	tdc
	adc	#<L122+high_1
	pha
	pea	#0
	clc
	tdc
	adc	#<L122+low_1
	pha
	jsl	~~get_pair
	jsl	~~check_ateol
	lda	<L122+low_1
	bpl	L127
	brl	L126
L127:
	ldy	#$0
	lda	<L122+low_1
	bpl	L128
	dey
L128:
	sta	<R0
	sty	<R0+2
	sec
	lda	#$feff
	sbc	<R0
	lda	#$0
	sbc	<R0+2
	bvs	L129
	eor	#$8000
L129:
	bmi	L130
	brl	L126
L130:
	lda	<L122+high_1
	bpl	L131
	brl	L126
L131:
	ldy	#$0
	lda	<L122+high_1
	bpl	L132
	dey
L132:
	sta	<R0
	sty	<R0+2
	sec
	lda	#$feff
	sbc	<R0
	lda	#$0
	sbc	<R0+2
	bvs	L133
	eor	#$8000
L133:
	bpl	L134
	brl	L10050
L134:
L126:
	pea	#<$b
	pea	#4
	jsl	~~error
L10050:
	pei	<L122+high_1
	pei	<L122+low_1
	jsl	~~delete_range
L135:
	pld
	tsc
	clc
	adc	#L121
	tcs
	rtl
L121	equ	8
L122	equ	5
	ends
	efunc
	code
	func
~~renumber:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L136
	tcs
	phd
	tcd
start_1	set	0
step_1	set	2
	lda	|~~basicvars+437
	bit	#$1
	bne	L138
	brl	L10051
L138:
	pea	#<$7
	pea	#4
	jsl	~~error
L10051:
	lda	|~~basicvars+423
	bit	#$1
	bne	L139
	brl	L10052
L139:
	pea	#<$83
	pea	#4
	jsl	~~error
L10052:
	inc	|~~basicvars+62
	bne	L140
	inc	|~~basicvars+62+2
L140:
	pea	#<$a
	pea	#<$a
	pea	#0
	clc
	tdc
	adc	#<L137+step_1
	pha
	pea	#0
	clc
	tdc
	adc	#<L137+start_1
	pha
	jsl	~~get_pair
	jsl	~~check_ateol
	lda	<L137+start_1
	bpl	L142
	brl	L141
L142:
	ldy	#$0
	lda	<L137+start_1
	bpl	L143
	dey
L143:
	sta	<R0
	sty	<R0+2
	sec
	lda	#$feff
	sbc	<R0
	lda	#$0
	sbc	<R0+2
	bvs	L144
	eor	#$8000
L144:
	bpl	L145
	brl	L10053
L145:
L141:
	pea	#<$b
	pea	#4
	jsl	~~error
L10053:
	sec
	lda	#$0
	sbc	<L137+step_1
	bvs	L147
	eor	#$8000
L147:
	bpl	L148
	brl	L146
L148:
	ldy	#$0
	lda	<L137+step_1
	bpl	L149
	dey
L149:
	sta	<R0
	sty	<R0+2
	sec
	lda	<R0
	sbc	#<$feff
	lda	<R0+2
	sbc	#^$feff
	bvs	L150
	eor	#$8000
L150:
	bmi	L151
	brl	L10054
L151:
L146:
	pea	#<$6
	pea	#4
	jsl	~~error
L10054:
	pei	<L137+step_1
	pei	<L137+start_1
	lda	|~~basicvars+22+2
	pha
	lda	|~~basicvars+22
	pha
	jsl	~~renumber_program
L152:
	pld
	tsc
	clc
	adc	#L136
	tcs
	rtl
L136	equ	8
L137	equ	5
	ends
	efunc
	code
	func
~~show_memory:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L153
	tcs
	phd
	tcd
which_1	set	0
lowaddr_1	set	1
highaddr_1	set	3
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	sta	<L154+which_1
	rep	#$20
	longa	on
	inc	|~~basicvars+62
	bne	L155
	inc	|~~basicvars+62+2
L155:
	clc
	lda	#$40
	adc	|~~lastaddr
	pha
	lda	|~~lastaddr
	pha
	pea	#0
	clc
	tdc
	adc	#<L154+highaddr_1
	pha
	pea	#0
	clc
	tdc
	adc	#<L154+lowaddr_1
	pha
	jsl	~~get_pair
	jsl	~~check_ateol
	lda	<L154+highaddr_1
	cmp	<L154+lowaddr_1
	beq	L156
	brl	L10055
L156:
	clc
	lda	#$40
	adc	<L154+lowaddr_1
	sta	<L154+highaddr_1
L10055:
	sep	#$20
	longa	off
	lda	<L154+which_1
	cmp	#<$a
	rep	#$20
	longa	on
	beq	L157
	brl	L10056
L157:
	pei	<L154+highaddr_1
	pei	<L154+lowaddr_1
	jsl	~~show_byte
	brl	L10057
L10056:
	pei	<L154+highaddr_1
	pei	<L154+lowaddr_1
	jsl	~~show_word
L10057:
	lda	<L154+highaddr_1
	sta	|~~lastaddr
L158:
	pld
	tsc
	clc
	adc	#L153
	tcs
	rtl
L153	equ	9
L154	equ	5
	ends
	efunc
	code
	func
~~list_program:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L159
	tcs
	phd
	tcd
lowline_1	set	0
highline_1	set	2
count_1	set	4
more_1	set	6
paused_1	set	7
p_1	set	8
	lda	|~~basicvars+437
	bit	#$1
	bne	L161
	brl	L10058
L161:
	pea	#<$7
	pea	#4
	jsl	~~error
L10058:
	inc	|~~basicvars+62
	bne	L162
	inc	|~~basicvars+62+2
L162:
	pea	#<$feff
	pea	#<$0
	pea	#0
	clc
	tdc
	adc	#<L160+highline_1
	pha
	pea	#0
	clc
	tdc
	adc	#<L160+lowline_1
	pha
	jsl	~~get_pair
	jsl	~~check_ateol
	lda	<L160+lowline_1
	bpl	L164
	brl	L163
L164:
	ldy	#$0
	lda	<L160+lowline_1
	bpl	L165
	dey
L165:
	sta	<R0
	sty	<R0+2
	sec
	lda	#$feff
	sbc	<R0
	lda	#$0
	sbc	<R0+2
	bvs	L166
	eor	#$8000
L166:
	bmi	L167
	brl	L163
L167:
	lda	<L160+highline_1
	bpl	L168
	brl	L163
L168:
	ldy	#$0
	lda	<L160+highline_1
	bpl	L169
	dey
L169:
	sta	<R0
	sty	<R0+2
	sec
	lda	#$feff
	sbc	<R0
	lda	#$0
	sbc	<R0+2
	bvs	L170
	eor	#$8000
L170:
	bpl	L171
	brl	L10059
L171:
L163:
	pea	#<$b
	pea	#4
	jsl	~~error
L10059:
	lda	<L160+lowline_1
	beq	L172
	brl	L10060
L172:
	lda	|~~basicvars+22
	sta	<L160+p_1
	lda	|~~basicvars+22+2
	sta	<L160+p_1+2
	brl	L10061
L10060:
	pei	<L160+lowline_1
	jsl	~~find_line
	sta	<L160+p_1
	stx	<L160+p_1+2
L10061:
	jsl	~~reset_indent
	stz	|~~basicvars+494
	stz	<L160+count_1
	sep	#$20
	longa	off
	lda	#$1
	sta	<L160+more_1
	rep	#$20
	longa	on
L10062:
	lda	<L160+more_1
	and	#$ff
	bne	L173
	brl	L10063
L173:
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L160+p_1],Y
	cmp	#<$ff
	rep	#$20
	longa	on
	bne	L174
	brl	L10063
L174:
	pei	<L160+p_1+2
	pei	<L160+p_1
	jsl	~~get_lineno
	sta	<R0
	sec
	lda	<L160+highline_1
	sbc	<R0
	bvs	L175
	eor	#$8000
L175:
	bmi	L176
	brl	L10063
L176:
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	pei	<L160+p_1+2
	pei	<L160+p_1
	jsl	~~expand
	lda	|~~basicvars+435
	bit	#$2
	bne	L177
	brl	L10064
L177:
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	pei	<L160+p_1+2
	pei	<L160+p_1
	pea	#^L85
	pea	#<L85
	pea	#14
	jsl	~~emulate_printf
	brl	L10065
L10064:
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	pea	#^L85+9
	pea	#<L85+9
	pea	#10
	jsl	~~emulate_printf
L10065:
	ldy	#$2
	lda	[<L160+p_1],Y
	and	#$ff
	sta	<R0
	ldy	#$3
	lda	[<L160+p_1],Y
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
	bpl	L178
	dey
L178:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L160+p_1
	adc	<R0
	sta	<L160+p_1
	lda	<L160+p_1+2
	adc	<R0+2
	sta	<L160+p_1+2
	lda	|~~basicvars+429
	bit	#$20
	bne	L179
	brl	L10066
L179:
	inc	<L160+count_1
	lda	<L160+count_1
	cmp	#<$14
	beq	L180
	brl	L10067
L180:
	sep	#$20
	longa	off
	lda	#$1
	sta	<L160+paused_1
	rep	#$20
	longa	on
	pea	#^L85+14
	pea	#<L85+14
	pea	#6
	jsl	~~emulate_printf
L10070:
	lda	|~~basicvars+489
	and	#$ff
	bne	L181
	brl	L10071
L181:
	pea	#<$8
	pea	#4
	jsl	~~error
L10071:
	jsl	~~emulate_get
	sta	<L160+count_1
	lda	<L160+count_1
	brl	L10072
L10074:
	stz	<L160+count_1
	sep	#$20
	longa	off
	stz	<L160+paused_1
	rep	#$20
	longa	on
	brl	L10073
L10075:
L10076:
	lda	#$13
	sta	<L160+count_1
	sep	#$20
	longa	off
	stz	<L160+paused_1
	rep	#$20
	longa	on
	brl	L10073
L10077:
	sep	#$20
	longa	off
	stz	<L160+more_1
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	stz	<L160+paused_1
	rep	#$20
	longa	on
	brl	L10073
L10072:
	xref	~~~swt
	jsl	~~~swt
	dw	4
	dw	10
	dw	L10076-1
	dw	13
	dw	L10075-1
	dw	27
	dw	L10077-1
	dw	32
	dw	L10074-1
	dw	L10073-1
L10073:
L10068:
	lda	<L160+paused_1
	and	#$ff
	beq	L182
	brl	L10070
L182:
L10069:
	pea	#^L85+25
	pea	#<L85+25
	pea	#6
	jsl	~~emulate_printf
L10067:
L10066:
	lda	|~~basicvars+489
	and	#$ff
	bne	L183
	brl	L10078
L183:
	pea	#<$8
	pea	#4
	jsl	~~error
L10078:
	brl	L10062
L10063:
L184:
	pld
	tsc
	clc
	adc	#L159
	tcs
	rtl
L159	equ	24
L160	equ	13
	ends
	efunc
	data
L85:
	db	$25,$70,$20,$20,$25,$73,$0D,$0A,$00,$25,$73,$0D,$0A,$00,$2D
	db	$2D,$20,$4D,$6F,$72,$65,$20,$2D,$2D,$00,$0D,$20,$20,$20,$20
	db	$20,$20,$20,$20,$20,$20,$0D,$00
	ends
	code
	func
~~list_hexline:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L186
	tcs
	phd
	tcd
length_1	set	0
theline_1	set	2
where_1	set	4
	inc	|~~basicvars+62
	bne	L188
	inc	|~~basicvars+62+2
L188:
	pea	#<$0
	pea	#<$0
	pea	#0
	clc
	tdc
	adc	#<L187+theline_1
	pha
	pea	#0
	clc
	tdc
	adc	#<L187+theline_1
	pha
	jsl	~~get_pair
	jsl	~~check_ateol
	lda	<L187+theline_1
	bpl	L190
	brl	L189
L190:
	ldy	#$0
	lda	<L187+theline_1
	bpl	L191
	dey
L191:
	sta	<R0
	sty	<R0+2
	sec
	lda	#$feff
	sbc	<R0
	lda	#$0
	sbc	<R0+2
	bvs	L192
	eor	#$8000
L192:
	bpl	L193
	brl	L10079
L193:
L189:
	pea	#<$b
	pea	#4
	jsl	~~error
L10079:
	lda	<L187+theline_1
	beq	L194
	brl	L10080
L194:
	lda	|~~basicvars+22
	sta	<L187+where_1
	lda	|~~basicvars+22+2
	sta	<L187+where_1+2
	brl	L10081
L10080:
	pei	<L187+theline_1
	jsl	~~find_line
	sta	<L187+where_1
	stx	<L187+where_1+2
L10081:
	pei	<L187+where_1+2
	pei	<L187+where_1
	jsl	~~get_lineno
	sta	<R0
	lda	<R0
	cmp	<L187+theline_1
	bne	L195
	brl	L10082
L195:
	pei	<L187+theline_1
	pea	#<$c
	pea	#6
	jsl	~~error
L10082:
	pei	<L187+where_1+2
	pei	<L187+where_1
	jsl	~~get_linelen
	sta	<L187+length_1
	pei	<L187+length_1
	pei	<L187+where_1+2
	pei	<L187+where_1
	pei	<L187+where_1+2
	pei	<L187+where_1
	jsl	~~get_lineno
	pha
	pea	#^L185
	pea	#<L185
	pea	#14
	jsl	~~emulate_printf
	sec
	lda	<L187+length_1
	sbc	#<$7
	bvs	L197
	eor	#$8000
L197:
	bmi	L198
	brl	L196
L198:
	sec
	lda	#$400
	sbc	<L187+length_1
	bvs	L199
	eor	#$8000
L199:
	bpl	L200
	brl	L10083
L200:
L196:
	pea	#^L185+25
	pea	#<L185+25
	pea	#6
	jsl	~~emulate_printf
	lda	#$60
	sta	<L187+length_1
	brl	L10084
L10083:
	pea	#^L185+59
	pea	#<L185+59
	pea	#6
	jsl	~~emulate_printf
L10084:
	ldy	#$0
	lda	<L187+length_1
	bpl	L201
	dey
L201:
	sta	<R0
	sty	<R0+2
	sec
	lda	<L187+where_1
	sbc	|~~basicvars+6
	sta	<R1
	lda	<L187+where_1+2
	sbc	|~~basicvars+6+2
	sta	<R1+2
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	lda	<R1+2
	adc	<R0+2
	sta	<R2+2
	pei	<R2
	sec
	lda	<L187+where_1
	sbc	|~~basicvars+6
	sta	<R0
	lda	<L187+where_1+2
	sbc	|~~basicvars+6+2
	sta	<R0+2
	pei	<R0
	jsl	~~show_byte
L202:
	pld
	tsc
	clc
	adc	#L186
	tcs
	rtl
L186	equ	20
L187	equ	13
	ends
	efunc
	data
L185:
	db	$4C,$69,$6E,$65,$20,$25,$64,$20,$61,$74,$20,$25,$70,$2C,$20
	db	$6C,$65,$6E,$67,$74,$68,$3D,$25,$64,$00,$20,$20,$2A,$2A,$20
	db	$53,$74,$61,$74,$65,$6D,$65,$6E,$74,$20,$6C,$65,$6E,$67,$74
	db	$68,$20,$69,$73,$20,$62,$61,$64,$20,$2A,$2A,$0D,$0A,$00,$0D
	db	$0A,$00
	ends
	code
	func
~~check_incore:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L204
	tcs
	phd
	tcd
p_1	set	0
	lda	|~~basicvars+22
	sta	<R0
	lda	|~~basicvars+22+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<R0],Y
	cmp	#<$ff
	rep	#$20
	longa	on
	beq	L206
	brl	L10085
L206:
	lda	#$0
	tax
	lda	#$0
L207:
	tay
	pld
	tsc
	clc
	adc	#L204
	tcs
	tya
	rtl
L10085:
	clc
	lda	#$6
	adc	|~~basicvars+22
	sta	<L205+p_1
	lda	#$0
	adc	|~~basicvars+22+2
	sta	<L205+p_1+2
L10086:
	lda	[<L205+p_1]
	and	#$ff
	bne	L208
	brl	L10087
L208:
	sep	#$20
	longa	off
	lda	[<L205+p_1]
	cmp	#<$3e
	rep	#$20
	longa	on
	bne	L209
	brl	L10087
L209:
	inc	<L205+p_1
	bne	L210
	inc	<L205+p_1+2
L210:
	brl	L10086
L10087:
	lda	[<L205+p_1]
	and	#$ff
	beq	L211
	brl	L10088
L211:
	lda	#$0
	tax
	lda	#$0
	brl	L207
L10088:
	clc
	lda	#$1
	adc	<L205+p_1
	sta	<R0
	lda	#$0
	adc	<L205+p_1+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~skip
	sta	<L205+p_1
	stx	<L205+p_1+2
	lda	[<L205+p_1]
	and	#$ff
	beq	L212
	brl	L10089
L212:
	lda	#$0
	tax
	lda	#$0
	brl	L207
L10089:
	ldx	<L205+p_1+2
	lda	<L205+p_1
	brl	L207
L204	equ	8
L205	equ	5
	ends
	efunc
	code
	func
~~get_savefile:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L213
	tcs
	phd
	tcd
np_1	set	0
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~isateol
	and	#$ff
	bne	L215
	brl	L10090
L215:
	jsl	~~check_incore
	sta	<L214+np_1
	stx	<L214+np_1+2
	lda	<L214+np_1
	ora	<L214+np_1+2
	beq	L216
	brl	L10091
L216:
	lda	|~~basicvars+1354
	and	#$ff
	beq	L217
	brl	L10092
L217:
	pea	#<$6d
	pea	#4
	jsl	~~error
	brl	L10093
L10092:
	lda	#<~~basicvars+1354
	sta	<L214+np_1
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<L214+np_1+2
L10093:
L10091:
	brl	L10094
L10090:
	jsl	~~get_name
	sta	<L214+np_1
	stx	<L214+np_1+2
	jsl	~~check_ateol
L10094:
	ldx	<L214+np_1+2
	lda	<L214+np_1
L218:
	tay
	pld
	tsc
	clc
	adc	#L213
	tcs
	tya
	rtl
L213	equ	4
L214	equ	1
	ends
	efunc
	code
	func
~~save_program:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L219
	tcs
	phd
	tcd
np_1	set	0
	lda	|~~basicvars+437
	bit	#$1
	bne	L221
	brl	L10095
L221:
	pea	#<$7
	pea	#4
	jsl	~~error
L10095:
	inc	|~~basicvars+62
	bne	L222
	inc	|~~basicvars+62+2
L222:
	jsl	~~get_savefile
	sta	<L220+np_1
	stx	<L220+np_1+2
	jsl	~~reset_indent
	pei	<L220+np_1+2
	pei	<L220+np_1
	jsl	~~write_text
	pei	<L220+np_1+2
	pei	<L220+np_1
	lda	#<~~basicvars+1354
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~strcpy
L223:
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
	func
~~saveo_program:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L224
	tcs
	phd
	tcd
np_1	set	0
saveopts_1	set	4
	lda	|~~basicvars+437
	bit	#$1
	bne	L226
	brl	L10096
L226:
	pea	#<$7
	pea	#4
	jsl	~~error
L10096:
	inc	|~~basicvars+62
	bne	L227
	inc	|~~basicvars+62+2
L227:
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~isateol
	and	#$ff
	bne	L228
	brl	L10097
L228:
	pea	#<$5
	pea	#4
	jsl	~~error
L10097:
	jsl	~~get_number
	sta	<L225+saveopts_1
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
	beq	L229
	brl	L10098
L229:
	inc	|~~basicvars+62
	bne	L230
	inc	|~~basicvars+62+2
L230:
L10098:
	jsl	~~get_savefile
	sta	<L225+np_1
	stx	<L225+np_1+2
	pea	#<~~basicvars+429
	pea	#<~~basicvars+431
	lda	#$2
	xref	~~~mov
	jsl	~~~mov
	pei	<L225+saveopts_1
	jsl	~~set_listoption
	lda	#$10
	trb	~~basicvars+429
	lda	#$20
	trb	~~basicvars+429
	lda	#$40
	trb	~~basicvars+429
	jsl	~~reset_indent
	pei	<L225+np_1+2
	pei	<L225+np_1
	jsl	~~write_text
	pei	<L225+np_1+2
	pei	<L225+np_1
	lda	#<~~basicvars+1354
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~strcpy
	pea	#<~~basicvars+431
	pea	#<~~basicvars+429
	lda	#$2
	xref	~~~mov
	jsl	~~~mov
L231:
	pld
	tsc
	clc
	adc	#L224
	tcs
	rtl
L224	equ	10
L225	equ	5
	ends
	efunc
	code
	func
~~load_program:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L232
	tcs
	phd
	tcd
np_1	set	0
	lda	|~~basicvars+423
	bit	#$1
	bne	L234
	brl	L10099
L234:
	pea	#<$83
	pea	#4
	jsl	~~error
L10099:
	inc	|~~basicvars+62
	bne	L235
	inc	|~~basicvars+62+2
L235:
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~isateol
	and	#$ff
	bne	L236
	brl	L10100
L236:
	pea	#<$6d
	pea	#4
	jsl	~~error
L10100:
	jsl	~~get_name
	sta	<L233+np_1
	stx	<L233+np_1+2
	jsl	~~check_ateol
	jsl	~~clear_varlists
	jsl	~~clear_strings
	jsl	~~clear_heap
	pei	<L233+np_1+2
	pei	<L233+np_1
	jsl	~~read_basic
	lda	#<~~basicvars+1370
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#<~~basicvars+1354
	sta	<R1
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	jsl	~~strcpy
L237:
	pld
	tsc
	clc
	adc	#L232
	tcs
	rtl
L232	equ	12
L233	equ	9
	ends
	efunc
	code
	func
~~install_library:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L238
	tcs
	phd
	tcd
name_1	set	0
	inc	|~~basicvars+62
	bne	L240
	inc	|~~basicvars+62+2
L240:
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~isateol
	and	#$ff
	bne	L241
	brl	L10101
L241:
	pea	#<$6d
	pea	#4
	jsl	~~error
	brl	L10102
L10101:
L10105:
	jsl	~~get_name
	sta	<L239+name_1
	stx	<L239+name_1+2
	pei	<L239+name_1+2
	pei	<L239+name_1
	jsl	~~strlen
	sta	<R0
	stx	<R0+2
	lda	#$0
	cmp	<R0
	lda	#$0
	sbc	<R0+2
	bcc	L242
	brl	L10106
L242:
	pea	#<$0
	pei	<L239+name_1+2
	pei	<L239+name_1
	jsl	~~read_library
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
	beq	L243
	brl	L10104
L243:
	inc	|~~basicvars+62
	bne	L244
	inc	|~~basicvars+62+2
L244:
L10103:
	brl	L10105
L10104:
	jsl	~~check_ateol
L10102:
L245:
	pld
	tsc
	clc
	adc	#L238
	tcs
	rtl
L238	equ	8
L239	equ	5
	ends
	efunc
	code
	func
~~print_help:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L246
	tcs
	phd
	tcd
	inc	|~~basicvars+62
	bne	L248
	inc	|~~basicvars+62+2
L248:
	jsl	~~check_ateol
	jsl	~~show_options
L249:
	pld
	tsc
	clc
	adc	#L246
	tcs
	rtl
L246	equ	0
L247	equ	1
	ends
	efunc
	code
	func
~~invoke_editor:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L250
	tcs
	phd
	tcd
tempname_1	set	0
savedname_1	set	16
retcode_1	set	32
	lda	|~~basicvars+423
	bit	#$1
	bne	L252
	brl	L10107
L252:
	pea	#<$83
	pea	#4
	jsl	~~error
L10107:
	pea	#0
	clc
	tdc
	adc	#<L251+tempname_1
	pha
	jsl	~~secure_tmpnam
	and	#$ff
	beq	L253
	brl	L10108
L253:
	jsl	~~__errno_location
	sta	<R0
	stx	<R0+2
	lda	[<R0]
	pha
	jsl	~~strerror
	sta	<R0
	stx	<R0+2
	phx
	pha
	pea	#<$8e
	pea	#8
	jsl	~~error
L254:
	pld
	tsc
	clc
	adc	#L250
	tcs
	rtl
L10108:
	pea	#<~~basicvars+429
	pea	#<~~basicvars+431
	lda	#$2
	xref	~~~mov
	jsl	~~~mov
	lda	|~~basicvars+437
	bit	#$8
	bne	L255
	brl	L10109
L255:
	pea	#<~~basicvars+433
	pea	#<~~basicvars+429
	lda	#$2
	xref	~~~mov
	jsl	~~~mov
L10109:
	lda	#$10
	trb	~~basicvars+429
	lda	#$40
	trb	~~basicvars+429
	jsl	~~reset_indent
	pea	#0
	clc
	tdc
	adc	#<L251+tempname_1
	pha
	jsl	~~write_text
	pea	#<~~basicvars+431
	pea	#<~~basicvars+429
	lda	#$2
	xref	~~~mov
	jsl	~~~mov
	lda	#<~~editname
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	jsl	~~strcpy
	pea	#^L203
	pea	#<L203
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	jsl	~~strcat
	pea	#0
	clc
	tdc
	adc	#<L251+tempname_1
	pha
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	jsl	~~strcat
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	jsl	~~system
	sta	<L251+retcode_1
	lda	<L251+retcode_1
	beq	L256
	brl	L10110
L256:
	lda	#<~~basicvars+1354
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	pea	#0
	clc
	tdc
	adc	#<L251+savedname_1
	pha
	jsl	~~strcpy
	jsl	~~clear_program
	pea	#0
	clc
	tdc
	adc	#<L251+tempname_1
	pha
	jsl	~~read_basic
	pea	#0
	clc
	tdc
	adc	#<L251+savedname_1
	pha
	lda	#<~~basicvars+1354
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~strcpy
	brl	L10111
L10110:
	jsl	~~__errno_location
	sta	<R0
	stx	<R0+2
	lda	[<R0]
	pha
	jsl	~~strerror
	sta	<R0
	stx	<R0+2
	phx
	pha
	pea	#<$8e
	pea	#8
	jsl	~~error
L10111:
	pea	#0
	clc
	tdc
	adc	#<L251+tempname_1
	pha
	jsl	~~remove
	brl	L254
L250	equ	38
L251	equ	5
	ends
	efunc
	data
L203:
	db	$20,$00
	ends
	code
	func
~~alter_line:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L258
	tcs
	phd
	tcd
lineno_1	set	0
p_1	set	2
ok_1	set	6
	jsl	~~get_number
	sta	<L259+lineno_1
	jsl	~~check_ateol
	lda	|~~basicvars+423
	bit	#$1
	bne	L260
	brl	L10112
L260:
	pea	#<$83
	pea	#4
	jsl	~~error
L10112:
	lda	|~~basicvars+437
	bit	#$1
	bne	L261
	brl	L10113
L261:
	pea	#<$7
	pea	#4
	jsl	~~error
L10113:
	lda	<L259+lineno_1
	bpl	L263
	brl	L262
L263:
	ldy	#$0
	lda	<L259+lineno_1
	bpl	L264
	dey
L264:
	sta	<R0
	sty	<R0+2
	sec
	lda	#$feff
	sbc	<R0
	lda	#$0
	sbc	<R0+2
	bvs	L265
	eor	#$8000
L265:
	bpl	L266
	brl	L10114
L266:
L262:
	pea	#<$b
	pea	#4
	jsl	~~error
L10114:
	pei	<L259+lineno_1
	jsl	~~find_line
	sta	<L259+p_1
	stx	<L259+p_1+2
	pei	<L259+p_1+2
	pei	<L259+p_1
	jsl	~~get_lineno
	sta	<R0
	lda	<R0
	cmp	<L259+lineno_1
	bne	L267
	brl	L10115
L267:
	pei	<L259+lineno_1
	pea	#<$c
	pea	#6
	jsl	~~error
L10115:
	pea	#<~~basicvars+429
	pea	#<~~basicvars+431
	lda	#$2
	xref	~~~mov
	jsl	~~~mov
	lda	#$1
	trb	~~basicvars+429
	lda	#$2
	trb	~~basicvars+429
	lda	#$4
	trb	~~basicvars+429
	lda	#$8
	trb	~~basicvars+429
	lda	#$10
	trb	~~basicvars+429
	lda	#$40
	trb	~~basicvars+429
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	pei	<L259+p_1+2
	pei	<L259+p_1
	jsl	~~expand
	pea	#<~~basicvars+431
	pea	#<~~basicvars+429
	lda	#$2
	xref	~~~mov
	jsl	~~~mov
	pea	#<$400
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	jsl	~~amend_line
	sep	#$20
	longa	off
	sta	<L259+ok_1
	rep	#$20
	longa	on
	lda	<L259+ok_1
	and	#$ff
	beq	L268
	brl	L10116
L268:
	pea	#<$8
	pea	#4
	jsl	~~error
L10116:
	pea	#<$1
	lda	#<~~thisline
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	jsl	~~tokenize
	lda	#<~~thisline
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~get_lineno
	sta	<R1
	lda	<R1
	cmp	#<$ffff
	beq	L269
	brl	L10117
L269:
	jsl	~~exec_thisline
	brl	L10118
L10117:
	jsl	~~edit_line
L10118:
	pea	#<$1
	lda	#<~~basicvars+74
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~longjmp
L270:
	pld
	tsc
	clc
	adc	#L258
	tcs
	rtl
L258	equ	15
L259	equ	9
	ends
	efunc
	code
	func
~~exec_editor:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L271
	tcs
	phd
	tcd
	lda	|~~basicvars+437
	bit	#$1
	bne	L273
	brl	L10119
L273:
	pea	#<$7
	pea	#4
	jsl	~~error
L10119:
	inc	|~~basicvars+62
	bne	L274
	inc	|~~basicvars+62+2
L274:
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~isateol
	and	#$ff
	bne	L275
	brl	L10120
L275:
	jsl	~~invoke_editor
	brl	L10121
L10120:
	jsl	~~alter_line
L10121:
L276:
	pld
	tsc
	clc
	adc	#L271
	tcs
	rtl
L271	equ	0
L272	equ	1
	ends
	efunc
	code
	func
~~exec_edito:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L277
	tcs
	phd
	tcd
editopts_1	set	0
	lda	|~~basicvars+437
	bit	#$1
	bne	L279
	brl	L10122
L279:
	pea	#<$7
	pea	#4
	jsl	~~error
L10122:
	inc	|~~basicvars+62
	bne	L280
	inc	|~~basicvars+62+2
L280:
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~isateol
	and	#$ff
	bne	L281
	brl	L10123
L281:
	pea	#<$5
	pea	#4
	jsl	~~error
L10123:
	jsl	~~get_number
	sta	<L278+editopts_1
	jsl	~~check_ateol
	stz	<R0
	lda	<L278+editopts_1
	and	#<$1
	bne	L283
	brl	L282
L283:
	inc	<R0
L282:
	lda	<R0
	and	#<$1
	sta	<R0
	lda	#$1
	trb	|~~basicvars+433
	lda	<R0
	tsb	|~~basicvars+433
	stz	<R0
	lda	<L278+editopts_1
	and	#<$2
	bne	L285
	brl	L284
L285:
	inc	<R0
L284:
	asl	<R0
	lda	<R0
	and	#<$2
	sta	<R0
	lda	#$2
	trb	|~~basicvars+433
	lda	<R0
	tsb	|~~basicvars+433
	lda	#$4
	trb	~~basicvars+433
	stz	<R0
	lda	<L278+editopts_1
	and	#<$8
	bne	L287
	brl	L286
L287:
	inc	<R0
L286:
	asl	<R0
	asl	<R0
	asl	<R0
	lda	<R0
	and	#<$8
	sta	<R0
	lda	#$8
	trb	|~~basicvars+433
	lda	<R0
	tsb	|~~basicvars+433
	lda	#$10
	trb	~~basicvars+433
	lda	#$20
	trb	~~basicvars+433
	lda	#$40
	trb	~~basicvars+433
	lda	#$8
	tsb	~~basicvars+437
	jsl	~~invoke_editor
L288:
	pld
	tsc
	clc
	adc	#L277
	tcs
	rtl
L277	equ	6
L278	equ	5
	ends
	efunc
	code
	func
~~exec_crunch:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L289
	tcs
	phd
	tcd
	inc	|~~basicvars+62
	bne	L291
	inc	|~~basicvars+62+2
L291:
	jsl	~~get_number
	jsl	~~check_ateol
L292:
	pld
	tsc
	clc
	adc	#L289
	tcs
	rtl
L289	equ	4
L290	equ	5
	ends
	efunc
	code
	xdef	~~exec_command
	func
~~exec_command:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L293
	tcs
	phd
	tcd
	inc	|~~basicvars+62
	bne	L295
	inc	|~~basicvars+62+2
L295:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	brl	L10124
L10126:
	jsl	~~exec_new
	brl	L10125
L10127:
	jsl	~~exec_old
	brl	L10125
L10128:
L10129:
	jsl	~~load_program
	brl	L10125
L10130:
L10131:
	jsl	~~save_program
	brl	L10125
L10132:
L10133:
	jsl	~~saveo_program
	brl	L10125
L10134:
	jsl	~~install_library
	brl	L10125
L10135:
	jsl	~~list_program
	brl	L10125
L10136:
L10137:
	jsl	~~show_memory
	brl	L10125
L10138:
	jsl	~~list_hexline
	brl	L10125
L10139:
	jsl	~~list_if
	brl	L10125
L10140:
	jsl	~~set_listopt
	brl	L10125
L10141:
	jsl	~~list_vars
	brl	L10125
L10142:
	jsl	~~renumber
	brl	L10125
L10143:
	jsl	~~delete
	brl	L10125
L10144:
	jsl	~~print_help
	brl	L10125
L10145:
L10146:
	jsl	~~exec_editor
	brl	L10125
L10147:
L10148:
	jsl	~~exec_edito
	brl	L10125
L10149:
	jsl	~~exec_crunch
	brl	L10125
L10150:
	pea	#<$2
	pea	#4
	jsl	~~error
	brl	L10125
L10124:
	xref	~~~fsw
	jsl	~~~fsw
	dw	3
	dw	24
	dw	L10150-1
	dw	L10149-1
	dw	L10143-1
	dw	L10145-1
	dw	L10147-1
	dw	L10144-1
	dw	L10134-1
	dw	L10135-1
	dw	L10136-1
	dw	L10139-1
	dw	L10138-1
	dw	L10140-1
	dw	L10137-1
	dw	L10128-1
	dw	L10141-1
	dw	L10126-1
	dw	L10127-1
	dw	L10142-1
	dw	L10130-1
	dw	L10132-1
	dw	L10129-1
	dw	L10131-1
	dw	L10133-1
	dw	L10146-1
	dw	L10148-1
L10125:
L296:
	pld
	tsc
	clc
	adc	#L293
	tcs
	rtl
L293	equ	4
L294	equ	5
	ends
	efunc
	code
	xdef	~~init_commands
	func
~~init_commands:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L297
	tcs
	phd
	tcd
editor_1	set	0
	pea	#^L257
	pea	#<L257
	jsl	~~getenv
	sta	<L298+editor_1
	stx	<L298+editor_1+2
	lda	<L298+editor_1
	ora	<L298+editor_1+2
	bne	L299
	brl	L10151
L299:
	pei	<L298+editor_1+2
	pei	<L298+editor_1
	lda	#<~~editname
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~strcpy
	brl	L10152
L10151:
	pea	#^L257+7
	pea	#<L257+7
	lda	#<~~editname
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~strcpy
L10152:
L300:
	pld
	tsc
	clc
	adc	#L297
	tcs
	rtl
L297	equ	8
L298	equ	5
	ends
	efunc
	data
L257:
	db	$45,$44,$49,$54,$4F,$52,$00,$76,$69,$00
	ends
	xref	~~emulate_get
	xref	~~emulate_printf
	xref	~~init_expressions
	xref	~~factor
	xref	~~expression
	xref	~~clear_strings
	xref	~~free_string
	xref	~~pop_string
	xref	~~pop_float
	xref	~~pop_int
	xref	~~get_topitem
	xref	~~clear_heap
	xref	~~release_workspace
	xref	~~init_workspace
	xref	~~show_options
	xref	~~error
	xref	~~renumber_program
	xref	~~recover_program
	xref	~~write_text
	xref	~~read_library
	xref	~~read_basic
	xref	~~clear_program
	xref	~~delete_range
	xref	~~edit_line
	xref	~~detail_library
	xref	~~list_libraries
	xref	~~list_variables
	xref	~~clear_varlists
	xref	~~check_ateol
	xref	~~isateol
	xref	~~exec_thisline
	xref	~~reset_indent
	xref	~~get_linelen
	xref	~~get_lineno
	xref	~~get_srcaddr
	xref	~~expand
	xref	~~tokenize
	xref	~~secure_tmpnam
	xref	~~show_word
	xref	~~show_byte
	xref	~~find_line
	xref	~~tocstring
	xref	~~skip
	xref	~~amend_line
	xref	~~longjmp
	xref	~~__errno_location
	xref	~~isalpha
	xref	~~strerror
	xref	~~strlen
	xref	~~strcmp
	xref	~~strcat
	xref	~~memcpy
	xref	~~memcmp
	xref	~~strcpy
	xref	~~system
	xref	~~getenv
	xref	~~remove
	udata
~~editname
	ds	20
	ends
	xref	~~thisline
	xref	~~basicvars
	end
