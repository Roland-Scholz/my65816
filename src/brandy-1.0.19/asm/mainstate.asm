;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
	code
	xdef	~~exec_assembler
	func
~~exec_assembler:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
	pea	#<$1
	pea	#4
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
	code
	xdef	~~exec_asmend
	func
~~exec_asmend:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L5
	tcs
	phd
	tcd
	pea	#<$1
	pea	#4
	jsl	~~error
L7:
	pld
	tsc
	clc
	adc	#L5
	tcs
	rtl
L5	equ	0
L6	equ	1
	ends
	efunc
	code
	xdef	~~exec_oscmd
	func
~~exec_oscmd:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L8
	tcs
	phd
	tcd
p_1	set	0
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~get_srcaddr
	sta	<L9+p_1
	stx	<L9+p_1+2
	pea	#^$0
	pea	#<$0
	pei	<L9+p_1+2
	pei	<L9+p_1
	jsl	~~emulate_oscli
	clc
	lda	#$3
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L10
	inc	|~~basicvars+62+2
L10:
L11:
	pld
	tsc
	clc
	adc	#L8
	tcs
	rtl
L8	equ	4
L9	equ	1
	ends
	efunc
	code
	xdef	~~exec_call
	func
~~exec_call:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L12
	tcs
	phd
	tcd
address_1	set	0
parmcount_1	set	2
parameters_1	set	4
	inc	|~~basicvars+62
	bne	L14
	inc	|~~basicvars+62+2
L14:
	stz	<L13+parmcount_1
	jsl	~~eval_integer
	sta	<L13+address_1
	jsl	~~check_ateol
	pea	#0
	clc
	tdc
	adc	#<L13+parameters_1
	pha
	pei	<L13+parmcount_1
	pei	<L13+address_1
	jsl	~~emulate_call
L15:
	pld
	tsc
	clc
	adc	#L12
	tcs
	rtl
L12	equ	6
L13	equ	1
	ends
	efunc
	code
	xdef	~~exec_case
	func
~~exec_case:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L16
	tcs
	phd
	tcd
	udata
L10001:
	ds	4
	ends
casetype_1	set	0
whentype_1	set	2
n_1	set	4
intcase_1	set	6
casestring_1	set	8
whenstring_1	set	14
cp_1	set	20
found_1	set	24
here_1	set	25
	lda	|~~basicvars+62
	sta	<L17+here_1
	lda	|~~basicvars+62+2
	sta	<L17+here_1+2
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
	bpl	L18
	dey
L18:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars
	adc	<R0
	sta	<L17+cp_1
	lda	|~~basicvars+2
	adc	<R0+2
	sta	<L17+cp_1+2
	clc
	lda	#$5
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L19
	inc	|~~basicvars+62+2
L19:
	jsl	~~expression
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L17+casetype_1
	lda	<L17+casetype_1
	brl	L10002
L10004:
	jsl	~~pop_int
	sta	<L17+intcase_1
	brl	L10003
L10005:
	phy
	phy
	jsl	~~pop_float
	pla
	sta	|L10001
	pla
	sta	|L10001+2
	brl	L10003
L10006:
L10007:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L17+casestring_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	brl	L10003
L10008:
	pea	#<$45
	pea	#4
	jsl	~~error
	brl	L10003
L10002:
	xref	~~~fsw
	jsl	~~~fsw
	dw	2
	dw	4
	dw	L10008-1
	dw	L10004-1
	dw	L10005-1
	dw	L10006-1
	dw	L10007-1
L10003:
	sep	#$20
	longa	off
	stz	<L17+found_1
	rep	#$20
	longa	on
	stz	<L17+n_1
	brl	L10012
L10011:
	ldy	#$0
	lda	<L17+n_1
	bpl	L20
	dey
L20:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$3
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	lda	#$6
	adc	<L17+cp_1
	sta	<R2
	lda	#$0
	adc	<L17+cp_1+2
	sta	<R2+2
	clc
	lda	<R2
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	lda	[<R3]
	sta	|~~basicvars+62
	ldy	#$2
	lda	[<R3],Y
	sta	|~~basicvars+62+2
	lda	|~~basicvars+425
	bit	#$2
	bne	L21
	brl	L10013
L21:
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~find_linestart
	sta	<R0
	stx	<R0+2
	phx
	pha
	jsl	~~get_lineno
	pha
	jsl	~~trace_line
L10013:
L10014:
	jsl	~~expression
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L17+whentype_1
	lda	<L17+casetype_1
	cmp	#<$2
	beq	L22
	brl	L10016
L22:
	lda	<L17+whentype_1
	cmp	#<$2
	beq	L23
	brl	L10017
L23:
	stz	<R0
	jsl	~~pop_int
	sta	<R1
	lda	<R1
	cmp	<L17+intcase_1
	beq	L25
	brl	L24
L25:
	inc	<R0
L24:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L17+found_1
	rep	#$20
	longa	on
	brl	L10018
L10017:
	lda	<L17+whentype_1
	cmp	#<$3
	beq	L26
	brl	L10019
L26:
	stz	<R0
	ldy	#$0
	lda	<L17+intcase_1
	bpl	L28
	dey
L28:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	phy
	phy
	jsl	~~pop_float
	xref	~~~fcmp
	jsl	~~~fcmp
	beq	L29
	brl	L27
L29:
	inc	<R0
L27:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L17+found_1
	rep	#$20
	longa	on
	brl	L10020
L10019:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10020:
L10018:
	brl	L10021
L10016:
	lda	<L17+casetype_1
	cmp	#<$3
	beq	L30
	brl	L10022
L30:
	lda	<L17+whentype_1
	cmp	#<$2
	beq	L31
	brl	L10023
L31:
	stz	<R0
	lda	|L10001+2
	pha
	lda	|L10001
	pha
	jsl	~~pop_int
	sta	<R1
	ldy	#$0
	lda	<R1
	bpl	L33
	dey
L33:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~fcmp
	jsl	~~~fcmp
	beq	L34
	brl	L32
L34:
	inc	<R0
L32:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L17+found_1
	rep	#$20
	longa	on
	brl	L10024
L10023:
	lda	<L17+whentype_1
	cmp	#<$3
	beq	L35
	brl	L10025
L35:
	stz	<R0
	lda	|L10001+2
	pha
	lda	|L10001
	pha
	phy
	phy
	jsl	~~pop_float
	xref	~~~fcmp
	jsl	~~~fcmp
	beq	L37
	brl	L36
L37:
	inc	<R0
L36:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L17+found_1
	rep	#$20
	longa	on
	brl	L10026
L10025:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10026:
L10024:
	brl	L10027
L10022:
	lda	<L17+whentype_1
	cmp	#<$4
	bne	L38
	brl	L10028
L38:
	lda	<L17+whentype_1
	cmp	#<$5
	bne	L39
	brl	L10028
L39:
	pea	#<$40
	pea	#4
	jsl	~~error
L10028:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L17+whenstring_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	lda	<L17+whenstring_1
	cmp	<L17+casestring_1
	bne	L40
	brl	L10029
L40:
	sep	#$20
	longa	off
	stz	<L17+found_1
	rep	#$20
	longa	on
	brl	L10030
L10029:
	lda	<L17+whenstring_1
	beq	L41
	brl	L10031
L41:
	sep	#$20
	longa	off
	lda	#$1
	sta	<L17+found_1
	rep	#$20
	longa	on
	brl	L10032
L10031:
	stz	<R0
	ldy	#$0
	lda	<L17+whenstring_1
	bpl	L43
	dey
L43:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<L17+casestring_1+4
	pei	<L17+casestring_1+2
	pei	<L17+whenstring_1+4
	pei	<L17+whenstring_1+2
	jsl	~~memcmp
	tax
	beq	L44
	brl	L42
L44:
	inc	<R0
L42:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L17+found_1
	rep	#$20
	longa	on
L10032:
L10030:
	lda	<L17+whentype_1
	cmp	#<$5
	beq	L45
	brl	L10033
L45:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L17+whenstring_1
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
L10027:
L10021:
	lda	<L17+found_1
	and	#$ff
	beq	L46
	brl	L10015
L46:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$3a
	rep	#$20
	longa	on
	bne	L47
	brl	L10015
L47:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	bne	L48
	brl	L10015
L48:
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
	beq	L49
	brl	L10034
L49:
	inc	|~~basicvars+62
	bne	L50
	inc	|~~basicvars+62+2
L50:
	brl	L10035
L10034:
	pea	#<$5
	pea	#4
	jsl	~~error
L10035:
	brl	L10014
L10015:
	lda	<L17+found_1
	and	#$ff
	beq	L51
	brl	L10010
L51:
L10009:
	inc	<L17+n_1
L10012:
	sec
	lda	<L17+n_1
	sbc	[<L17+cp_1]
	bvs	L52
	eor	#$8000
L52:
	bmi	L53
	brl	L10011
L53:
L10010:
	lda	<L17+casetype_1
	cmp	#<$5
	beq	L54
	brl	L10036
L54:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L17+casestring_1
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
L10036:
	lda	<L17+found_1
	and	#$ff
	bne	L55
	brl	L10037
L55:
	lda	|~~basicvars+425
	bit	#$10
	bne	L56
	brl	L10038
L56:
	ldy	#$0
	lda	<L17+n_1
	bpl	L57
	dey
L57:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$3
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	lda	#$a
	adc	<L17+cp_1
	sta	<R2
	lda	#$0
	adc	<L17+cp_1+2
	sta	<R2+2
	clc
	lda	<R2
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	ldy	#$2
	lda	[<R3],Y
	pha
	lda	[<R3]
	pha
	pei	<L17+here_1+2
	pei	<L17+here_1
	jsl	~~trace_branch
L10038:
	ldy	#$0
	lda	<L17+n_1
	bpl	L58
	dey
L58:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$3
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	lda	#$a
	adc	<L17+cp_1
	sta	<R2
	lda	#$0
	adc	<L17+cp_1+2
	sta	<R2+2
	clc
	lda	<R2
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	lda	[<R3]
	sta	|~~basicvars+62
	ldy	#$2
	lda	[<R3],Y
	sta	|~~basicvars+62+2
	brl	L10039
L10037:
	lda	|~~basicvars+425
	bit	#$10
	bne	L59
	brl	L10040
L59:
	ldy	#$4
	lda	[<L17+cp_1],Y
	pha
	ldy	#$2
	lda	[<L17+cp_1],Y
	pha
	pei	<L17+here_1+2
	pei	<L17+here_1
	jsl	~~trace_branch
L10040:
	ldy	#$2
	lda	[<L17+cp_1],Y
	sta	|~~basicvars+62
	ldy	#$4
	lda	[<L17+cp_1],Y
	sta	|~~basicvars+62+2
L10039:
L60:
	pld
	tsc
	clc
	adc	#L16
	tcs
	rtl
L16	equ	45
L17	equ	17
	ends
	efunc
	code
	xdef	~~exec_xcase
	func
~~exec_xcase:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L61
	tcs
	phd
	tcd
tp_1	set	0
lp_1	set	4
defaultaddr_1	set	8
whencount_1	set	12
depth_1	set	14
n_1	set	16
cp_1	set	18
whentable_1	set	22
	lda	|~~basicvars+62
	sta	<L62+lp_1
	lda	|~~basicvars+62+2
	sta	<L62+lp_1+2
L10043:
	lda	<L62+lp_1
	sta	<L62+tp_1
	lda	<L62+lp_1+2
	sta	<L62+tp_1+2
	pei	<L62+lp_1+2
	pei	<L62+lp_1
	jsl	~~skip_token
	sta	<L62+lp_1
	stx	<L62+lp_1+2
L10041:
	lda	[<L62+lp_1]
	and	#$ff
	beq	L63
	brl	L10043
L63:
L10042:
	sep	#$20
	longa	off
	lda	[<L62+tp_1]
	cmp	#<$c0
	rep	#$20
	longa	on
	bne	L64
	brl	L10044
L64:
	pea	#<$30
	pea	#4
	jsl	~~error
L10044:
	inc	<L62+lp_1
	bne	L65
	inc	<L62+lp_1+2
L65:
	stz	<L62+whencount_1
	stz	<L62+defaultaddr_1
	stz	<L62+defaultaddr_1+2
	lda	#$1
	sta	<L62+depth_1
L10045:
	sec
	lda	#$0
	sbc	<L62+depth_1
	bvs	L66
	eor	#$8000
L66:
	bpl	L67
	brl	L10046
L67:
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L62+lp_1],Y
	cmp	#<$ff
	rep	#$20
	longa	on
	beq	L68
	brl	L10047
L68:
	pea	#<$2f
	pea	#4
	jsl	~~error
L10047:
	ldy	#$5
	lda	[<L62+lp_1],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L69
	dey
L69:
	sta	<R0
	sty	<R0+2
	ldy	#$4
	lda	[<L62+lp_1],Y
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
	lda	<L62+lp_1
	adc	<R2
	sta	<L62+tp_1
	lda	<L62+lp_1+2
	adc	<R2+2
	sta	<L62+tp_1+2
	lda	[<L62+tp_1]
	and	#$ff
	brl	L10048
L10050:
L10051:
	clc
	lda	#$3
	adc	<L62+tp_1
	sta	<L62+tp_1
	bcc	L70
	inc	<L62+tp_1+2
L70:
	lda	<L62+depth_1
	cmp	#<$1
	beq	L71
	brl	L10052
L71:
	lda	<L62+whencount_1
	cmp	#<$a
	beq	L72
	brl	L10053
L72:
	pea	#<$5a
	pea	#4
	jsl	~~error
L10053:
	ldy	#$0
	lda	<L62+whencount_1
	bpl	L73
	dey
L73:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$3
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	tdc
	adc	#<L62+whentable_1
	sta	<R2
	lda	#$0
	sta	<R2+2
	clc
	lda	<R2
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	lda	<L62+tp_1
	sta	[<R3]
	lda	<L62+tp_1+2
	ldy	#$2
	sta	[<R3],Y
L10054:
	lda	[<L62+tp_1]
	and	#$ff
	bne	L74
	brl	L10055
L74:
	sep	#$20
	longa	off
	lda	[<L62+tp_1]
	cmp	#<$3a
	rep	#$20
	longa	on
	bne	L75
	brl	L10055
L75:
	pei	<L62+tp_1+2
	pei	<L62+tp_1
	jsl	~~skip_token
	sta	<L62+tp_1
	stx	<L62+tp_1+2
	brl	L10054
L10055:
	sep	#$20
	longa	off
	lda	[<L62+tp_1]
	cmp	#<$3a
	rep	#$20
	longa	on
	beq	L76
	brl	L10056
L76:
	inc	<L62+tp_1
	bne	L77
	inc	<L62+tp_1+2
L77:
L10056:
	lda	[<L62+tp_1]
	and	#$ff
	beq	L78
	brl	L10057
L78:
	inc	<L62+tp_1
	bne	L79
	inc	<L62+tp_1+2
L79:
	ldy	#$5
	lda	[<L62+tp_1],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L80
	dey
L80:
	sta	<R0
	sty	<R0+2
	ldy	#$4
	lda	[<L62+tp_1],Y
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
	lda	<L62+tp_1
	adc	<R2
	sta	<L62+tp_1
	lda	<L62+tp_1+2
	adc	<R2+2
	sta	<L62+tp_1+2
L10057:
	ldy	#$0
	lda	<L62+whencount_1
	bpl	L81
	dey
L81:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$3
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	tdc
	adc	#<L62+whentable_1
	sta	<R2
	lda	#$0
	sta	<R2+2
	clc
	lda	#$4
	adc	<R2
	sta	<R3
	lda	#$0
	adc	<R2+2
	sta	<R3+2
	clc
	lda	<R3
	adc	<R0
	sta	<R2
	lda	<R3+2
	adc	<R0+2
	sta	<R2+2
	lda	<L62+tp_1
	sta	[<R2]
	lda	<L62+tp_1+2
	ldy	#$2
	sta	[<R2],Y
	inc	<L62+whencount_1
L10052:
	brl	L10049
L10058:
L10059:
	lda	<L62+depth_1
	cmp	#<$1
	beq	L82
	brl	L10060
L82:
	clc
	lda	#$3
	adc	<L62+tp_1
	sta	<L62+tp_1
	bcc	L83
	inc	<L62+tp_1+2
L83:
	sep	#$20
	longa	off
	lda	[<L62+tp_1]
	cmp	#<$3a
	rep	#$20
	longa	on
	beq	L84
	brl	L10061
L84:
	inc	<L62+tp_1
	bne	L85
	inc	<L62+tp_1+2
L85:
L10061:
	lda	[<L62+tp_1]
	and	#$ff
	beq	L86
	brl	L10062
L86:
	inc	<L62+tp_1
	bne	L87
	inc	<L62+tp_1+2
L87:
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L62+tp_1],Y
	cmp	#<$ff
	rep	#$20
	longa	on
	beq	L88
	brl	L10063
L88:
	pea	#<$2f
	pea	#4
	jsl	~~error
L10063:
	ldy	#$5
	lda	[<L62+tp_1],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L89
	dey
L89:
	sta	<R0
	sty	<R0+2
	ldy	#$4
	lda	[<L62+tp_1],Y
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
	lda	<L62+tp_1
	adc	<R2
	sta	<L62+tp_1
	lda	<L62+tp_1+2
	adc	<R2+2
	sta	<L62+tp_1+2
L10062:
	lda	<L62+tp_1
	sta	<L62+defaultaddr_1
	lda	<L62+tp_1+2
	sta	<L62+defaultaddr_1+2
L10060:
	brl	L10049
L10064:
	dec	<L62+depth_1
	lda	<L62+depth_1
	beq	L90
	brl	L10065
L90:
	lda	<L62+defaultaddr_1
	ora	<L62+defaultaddr_1+2
	beq	L91
	brl	L10065
L91:
	clc
	lda	#$1
	adc	<L62+tp_1
	sta	<L62+defaultaddr_1
	lda	#$0
	adc	<L62+tp_1+2
	sta	<L62+defaultaddr_1+2
L10065:
	brl	L10049
L10048:
	xref	~~~swt
	jsl	~~~swt
	dw	5
	dw	164
	dw	L10064-1
	dw	197
	dw	L10058-1
	dw	198
	dw	L10059-1
	dw	233
	dw	L10050-1
	dw	234
	dw	L10051-1
	dw	L10049-1
L10049:
	sec
	lda	#$0
	sbc	<L62+depth_1
	bvs	L92
	eor	#$8000
L92:
	bpl	L93
	brl	L10066
L93:
	ldy	#$5
	lda	[<L62+lp_1],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L94
	dey
L94:
	sta	<R0
	sty	<R0+2
	ldy	#$4
	lda	[<L62+lp_1],Y
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
	lda	<L62+lp_1
	adc	<R2
	sta	<L62+tp_1
	lda	<L62+lp_1+2
	adc	<R2+2
	sta	<L62+tp_1+2
L10067:
	lda	[<L62+tp_1]
	and	#$ff
	bne	L95
	brl	L10068
L95:
	sep	#$20
	longa	off
	lda	[<L62+tp_1]
	cmp	#<$90
	rep	#$20
	longa	on
	bne	L96
	brl	L10068
L96:
	pei	<L62+tp_1+2
	pei	<L62+tp_1
	jsl	~~skip_token
	sta	<L62+tp_1
	stx	<L62+tp_1+2
	brl	L10067
L10068:
	sep	#$20
	longa	off
	lda	[<L62+tp_1]
	cmp	#<$90
	rep	#$20
	longa	on
	beq	L97
	brl	L10069
L97:
	inc	<L62+depth_1
L10069:
	ldy	#$2
	lda	[<L62+lp_1],Y
	and	#$ff
	sta	<R0
	ldy	#$3
	lda	[<L62+lp_1],Y
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
	bpl	L98
	dey
L98:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L62+lp_1
	adc	<R0
	sta	<L62+lp_1
	lda	<L62+lp_1+2
	adc	<R0+2
	sta	<L62+lp_1+2
L10066:
	brl	L10045
L10046:
	ldy	#$0
	lda	<L62+whencount_1
	bpl	L99
	dey
L99:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$3
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	lda	#$e
	adc	<R0
	sta	<R2
	lda	#$0
	adc	<R0+2
	sta	<R2+2
	pei	<R2
	jsl	~~allocmem
	sta	<L62+cp_1
	stx	<L62+cp_1+2
	lda	<L62+whencount_1
	sta	[<L62+cp_1]
	lda	<L62+defaultaddr_1
	ldy	#$2
	sta	[<L62+cp_1],Y
	lda	<L62+defaultaddr_1+2
	ldy	#$4
	sta	[<L62+cp_1],Y
	stz	<L62+n_1
	brl	L10073
L10072:
	ldy	#$0
	lda	<L62+n_1
	bpl	L100
	dey
L100:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$3
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	tdc
	adc	#<L62+whentable_1
	sta	<R2
	lda	#$0
	sta	<R2+2
	clc
	lda	<R2
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	pei	<R3+2
	pei	<R3
	ldy	#$0
	lda	<L62+n_1
	bpl	L101
	dey
L101:
	sta	<R2
	sty	<R2+2
	pei	<R2+2
	pei	<R2
	lda	#$3
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	lda	#$6
	adc	<R0
	sta	<R3
	lda	#$0
	adc	<R0+2
	sta	<R3+2
	clc
	lda	<L62+cp_1
	adc	<R3
	sta	<R0
	lda	<L62+cp_1+2
	adc	<R3+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$8
	xref	~~~fmov
	jsl	~~~fmov
L10070:
	inc	<L62+n_1
L10073:
	sec
	lda	<L62+n_1
	sbc	<L62+whencount_1
	bvs	L102
	eor	#$8000
L102:
	bmi	L103
	brl	L10072
L103:
L10071:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$91
	sta	[<R0]
	rep	#$20
	longa	on
	pei	<L62+cp_1+2
	pei	<L62+cp_1
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~set_address
	jsl	~~exec_case
L104:
	pld
	tsc
	clc
	adc	#L61
	tcs
	rtl
L61	equ	118
L62	equ	17
	ends
	efunc
	code
	xdef	~~exec_chain
	func
~~exec_chain:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L105
	tcs
	phd
	tcd
namedesc_1	set	0
stringtype_1	set	6
filename_1	set	8
	inc	|~~basicvars+62
	bne	L107
	inc	|~~basicvars+62+2
L107:
	jsl	~~expression
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L106+stringtype_1
	lda	<L106+stringtype_1
	cmp	#<$4
	bne	L108
	brl	L10074
L108:
	lda	<L106+stringtype_1
	cmp	#<$5
	bne	L109
	brl	L10074
L109:
	pea	#<$40
	pea	#4
	jsl	~~error
L10074:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L106+namedesc_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	pei	<L106+namedesc_1
	pei	<L106+namedesc_1+4
	pei	<L106+namedesc_1+2
	jsl	~~tocstring
	sta	<L106+filename_1
	stx	<L106+filename_1+2
	lda	<L106+stringtype_1
	cmp	#<$5
	beq	L110
	brl	L10075
L110:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L106+namedesc_1
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
L10075:
	jsl	~~check_ateol
	jsl	~~clear_error
	pei	<L106+filename_1+2
	pei	<L106+filename_1
	jsl	~~read_basic
	jsl	~~init_expressions
	stz	|~~basicvars+407
	stz	|~~basicvars+407+2
	stz	|~~basicvars+447
	lda	#$10
	trb	~~basicvars+423
	lda	|~~basicvars+22
	sta	<R1
	lda	|~~basicvars+22+2
	sta	<R1+2
	ldy	#$5
	lda	[<R1],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L111
	dey
L111:
	sta	<R0
	sty	<R0+2
	lda	|~~basicvars+22
	sta	<R1
	lda	|~~basicvars+22+2
	sta	<R1+2
	ldy	#$4
	lda	[<R1],Y
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
	lda	|~~basicvars+22
	adc	<R2
	sta	|~~basicvars+62
	lda	|~~basicvars+22+2
	adc	<R2+2
	sta	|~~basicvars+62+2
L112:
	pld
	tsc
	clc
	adc	#L105
	tcs
	rtl
L105	equ	24
L106	equ	13
	ends
	efunc
	code
	xdef	~~exec_clear
	func
~~exec_clear:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L113
	tcs
	phd
	tcd
	inc	|~~basicvars+62
	bne	L115
	inc	|~~basicvars+62+2
L115:
	jsl	~~check_ateol
	jsl	~~clear_varptrs
	jsl	~~clear_varlists
	jsl	~~clear_strings
	jsl	~~clear_heap
	jsl	~~clear_stack
	jsl	~~init_expressions
L116:
	pld
	tsc
	clc
	adc	#L113
	tcs
	rtl
L113	equ	0
L114	equ	1
	ends
	efunc
	code
	xdef	~~exec_data
	func
~~exec_data:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L117
	tcs
	phd
	tcd
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~skip_token
	sta	|~~basicvars+62
	stx	|~~basicvars+62+2
L119:
	pld
	tsc
	clc
	adc	#L117
	tcs
	rtl
L117	equ	0
L118	equ	1
	ends
	efunc
	code
	xdef	~~exec_def
	func
~~exec_def:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L120
	tcs
	phd
	tcd
tp_1	set	0
base_1	set	4
	inc	|~~basicvars+62
	bne	L122
	inc	|~~basicvars+62+2
L122:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$c
	rep	#$20
	longa	on
	bne	L123
	brl	L10076
L123:
L10077:
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
	beq	L124
	brl	L10078
L124:
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~skip_token
	sta	|~~basicvars+62
	stx	|~~basicvars+62+2
	brl	L10077
L10078:
L125:
	pld
	tsc
	clc
	adc	#L120
	tcs
	rtl
L10076:
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~get_srcaddr
	sta	<L121+tp_1
	stx	<L121+tp_1+2
	sep	#$20
	longa	off
	lda	[<L121+tp_1]
	cmp	#<$cd
	rep	#$20
	longa	on
	beq	L126
	brl	L10079
L126:
	pea	#<$16
	pea	#4
	jsl	~~error
L10079:
	clc
	lda	#$5
	adc	|~~basicvars+62
	sta	<L121+tp_1
	lda	#$0
	adc	|~~basicvars+62+2
	sta	<L121+tp_1+2
	sep	#$20
	longa	off
	lda	[<L121+tp_1]
	cmp	#<$28
	rep	#$20
	longa	on
	beq	L127
	brl	L10080
L127:
	inc	<L121+tp_1
	bne	L128
	inc	<L121+tp_1+2
L128:
L10081:
	lda	[<L121+tp_1]
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	beq	L129
	brl	L10082
L129:
	sep	#$20
	longa	off
	lda	[<L121+tp_1]
	cmp	#<$d5
	rep	#$20
	longa	on
	beq	L130
	brl	L10083
L130:
	inc	<L121+tp_1
	bne	L131
	inc	<L121+tp_1+2
L131:
L10083:
	sep	#$20
	longa	off
	lda	[<L121+tp_1]
	cmp	#<$1
	rep	#$20
	longa	on
	beq	L132
	brl	L10084
L132:
	lda	<L121+tp_1
	sta	<L121+base_1
	lda	<L121+tp_1+2
	sta	<L121+base_1+2
	clc
	lda	#$5
	adc	<L121+tp_1
	sta	<L121+tp_1
	bcc	L133
	inc	<L121+tp_1+2
L133:
	sep	#$20
	longa	off
	lda	[<L121+tp_1]
	cmp	#<$29
	rep	#$20
	longa	on
	beq	L134
	brl	L10085
L134:
	pei	<L121+base_1+2
	pei	<L121+base_1
	jsl	~~get_srcaddr
	sta	<L121+base_1
	stx	<L121+base_1+2
	pei	<L121+base_1+2
	pei	<L121+base_1
	jsl	~~skip_name
	sta	<R0
	stx	<R0+2
	clc
	lda	#$ffff
	adc	<R0
	sta	<R1
	lda	#$ffff
	adc	<R0+2
	sta	<R1+2
	sep	#$20
	longa	off
	lda	[<R1]
	cmp	#<$28
	rep	#$20
	longa	on
	beq	L135
	brl	L10086
L135:
	inc	<L121+tp_1
	bne	L136
	inc	<L121+tp_1+2
L136:
L10086:
L10085:
	brl	L10087
L10084:
	sep	#$20
	longa	off
	lda	[<L121+tp_1]
	cmp	#<$2
	rep	#$20
	longa	on
	beq	L137
	brl	L10088
L137:
	clc
	lda	#$2
	adc	<L121+tp_1
	sta	<L121+tp_1
	bcc	L138
	inc	<L121+tp_1+2
L138:
	brl	L10089
L10088:
	pea	#<$5
	pea	#4
	jsl	~~error
L10089:
L10087:
	sep	#$20
	longa	off
	lda	[<L121+tp_1]
	cmp	#<$29
	rep	#$20
	longa	on
	bne	L139
	brl	L10082
L139:
	sep	#$20
	longa	off
	lda	[<L121+tp_1]
	cmp	#<$2c
	rep	#$20
	longa	on
	bne	L140
	brl	L10090
L140:
	pea	#<$5
	pea	#4
	jsl	~~error
L10090:
	inc	<L121+tp_1
	bne	L141
	inc	<L121+tp_1+2
L141:
	brl	L10081
L10082:
	sep	#$20
	longa	off
	lda	[<L121+tp_1]
	cmp	#<$29
	rep	#$20
	longa	on
	beq	L142
	brl	L10091
L142:
	inc	<L121+tp_1
	bne	L143
	inc	<L121+tp_1+2
L143:
L10091:
L10080:
	sep	#$20
	longa	off
	lda	[<L121+tp_1]
	cmp	#<$3d
	rep	#$20
	longa	on
	bne	L144
	brl	L10092
L144:
	pea	#<$16
	pea	#4
	jsl	~~error
L10092:
L10095:
	pei	<L121+tp_1+2
	pei	<L121+tp_1
	jsl	~~skip_token
	sta	<L121+tp_1
	stx	<L121+tp_1+2
L10093:
	lda	[<L121+tp_1]
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	bne	L145
	brl	L10095
L145:
L10094:
	lda	<L121+tp_1
	sta	|~~basicvars+62
	lda	<L121+tp_1+2
	sta	|~~basicvars+62+2
	brl	L125
L120	equ	16
L121	equ	9
	ends
	efunc
	code
	func
~~define_byte_array:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L146
	tcs
	phd
	tcd
vp_0	set	4
isindref_1	set	0
islocal_1	set	1
offset_1	set	2
highindex_1	set	4
ep_1	set	6
	ldy	#$4
	lda	[<L146+vp_0],Y
	cmp	#<$2
	bne	L148
	brl	L10096
L148:
	ldy	#$4
	lda	[<L146+vp_0],Y
	cmp	#<$3
	bne	L149
	brl	L10096
L149:
	pea	#<$43
	pea	#4
	jsl	~~error
L10096:
	stz	<R0
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	sep	#$20
	longa	off
	lda	[<R1]
	cmp	#<$21
	rep	#$20
	longa	on
	beq	L151
	brl	L150
L151:
	inc	<R0
L150:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L147+isindref_1
	rep	#$20
	longa	on
	lda	<L147+isindref_1
	and	#$ff
	bne	L152
	brl	L10097
L152:
	inc	|~~basicvars+62
	bne	L153
	inc	|~~basicvars+62+2
L153:
	ldy	#$4
	lda	[<L146+vp_0],Y
	cmp	#<$2
	beq	L154
	brl	L10098
L154:
	jsl	~~eval_intfactor
	sta	<R0
	clc
	lda	<R0
	ldy	#$10
	adc	[<L146+vp_0],Y
	sta	<L147+offset_1
	brl	L10099
L10098:
	ldy	#$12
	lda	[<L146+vp_0],Y
	pha
	ldy	#$10
	lda	[<L146+vp_0],Y
	pha
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R0
	pla
	sta	<R0+2
	jsl	~~eval_intfactor
	sta	<R1
	clc
	lda	<R1
	adc	<R0
	sta	<L147+offset_1
L10099:
L10097:
	stz	<R0
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	sep	#$20
	longa	off
	lda	[<R1]
	cmp	#<$b9
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
	sta	<L147+islocal_1
	rep	#$20
	longa	on
	lda	<L147+islocal_1
	and	#$ff
	bne	L157
	brl	L10100
L157:
	lda	|~~basicvars+399
	ora	|~~basicvars+399+2
	beq	L158
	brl	L10101
L158:
	pea	#<$57
	pea	#4
	jsl	~~error
L10101:
	inc	|~~basicvars+62
	bne	L159
	inc	|~~basicvars+62+2
L159:
	jsl	~~eval_integer
	sta	<L147+highindex_1
	lda	<L147+highindex_1
	bmi	L160
	brl	L10102
L160:
	ldy	#$8
	lda	[<L146+vp_0],Y
	pha
	ldy	#$6
	lda	[<L146+vp_0],Y
	pha
	pea	#<$19
	pea	#8
	jsl	~~error
L10102:
	lda	<L147+highindex_1
	ina
	pha
	jsl	~~alloc_stackmem
	sta	<L147+ep_1
	stx	<L147+ep_1+2
	lda	<L147+ep_1
	ora	<L147+ep_1+2
	beq	L161
	brl	L10103
L161:
	ldy	#$8
	lda	[<L146+vp_0],Y
	pha
	ldy	#$6
	lda	[<L146+vp_0],Y
	pha
	pea	#<$18
	pea	#8
	jsl	~~error
L10103:
	brl	L10104
L10100:
	jsl	~~eval_integer
	sta	<L147+highindex_1
	sec
	lda	<L147+highindex_1
	sbc	#<$ffffffff
	bvs	L162
	eor	#$8000
L162:
	bpl	L163
	brl	L10105
L163:
	ldy	#$8
	lda	[<L146+vp_0],Y
	pha
	ldy	#$6
	lda	[<L146+vp_0],Y
	pha
	pea	#<$19
	pea	#8
	jsl	~~error
L10105:
	lda	<L147+highindex_1
	cmp	#<$ffffffff
	beq	L164
	brl	L10106
L164:
	lda	|~~basicvars+34
	sta	<L147+ep_1
	lda	|~~basicvars+34+2
	sta	<L147+ep_1+2
	brl	L10107
L10106:
	lda	<L147+highindex_1
	ina
	pha
	jsl	~~condalloc
	sta	<L147+ep_1
	stx	<L147+ep_1+2
	lda	<L147+ep_1
	ora	<L147+ep_1+2
	beq	L165
	brl	L10108
L165:
	ldy	#$8
	lda	[<L146+vp_0],Y
	pha
	ldy	#$6
	lda	[<L146+vp_0],Y
	pha
	pea	#<$18
	pea	#8
	jsl	~~error
L10108:
L10107:
L10104:
	lda	<L147+isindref_1
	and	#$ff
	bne	L166
	brl	L10109
L166:
	sec
	lda	<L147+ep_1
	sbc	|~~basicvars+6
	sta	<R0
	lda	<L147+ep_1+2
	sbc	|~~basicvars+6+2
	sta	<R0+2
	pei	<R0
	pei	<L147+offset_1
	jsl	~~store_integer
	brl	L10110
L10109:
	ldy	#$4
	lda	[<L146+vp_0],Y
	cmp	#<$2
	beq	L167
	brl	L10111
L167:
	sec
	lda	<L147+ep_1
	sbc	|~~basicvars+6
	sta	<R0
	lda	<L147+ep_1+2
	sbc	|~~basicvars+6+2
	sta	<R0+2
	lda	<R0
	ldy	#$10
	sta	[<L146+vp_0],Y
	brl	L10112
L10111:
	sec
	lda	<L147+ep_1
	sbc	|~~basicvars+6
	sta	<R0
	lda	<L147+ep_1+2
	sbc	|~~basicvars+6+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	xref	~~~fflt
	jsl	~~~fflt
	pla
	ldy	#$10
	sta	[<L146+vp_0],Y
	pla
	ldy	#$12
	sta	[<L146+vp_0],Y
L10112:
L10110:
L168:
	lda	<L146+2
	sta	<L146+2+4
	lda	<L146+1
	sta	<L146+1+4
	pld
	tsc
	clc
	adc	#L146+4
	tcs
	rtl
L146	equ	18
L147	equ	9
	ends
	efunc
	code
	xdef	~~exec_dim
	func
~~exec_dim:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L169
	tcs
	phd
	tcd
base_1	set	0
ep_1	set	4
vp_1	set	8
blockdef_1	set	12
islocal_1	set	13
L10115:
	inc	|~~basicvars+62
	bne	L171
	inc	|~~basicvars+62+2
L171:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$2
	rep	#$20
	longa	on
	bne	L172
	brl	L10116
L172:
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
	bne	L173
	brl	L10116
L173:
	pea	#<$25
	pea	#4
	jsl	~~error
L10116:
	sep	#$20
	longa	off
	stz	<L170+islocal_1
	rep	#$20
	longa	on
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$2
	rep	#$20
	longa	on
	beq	L174
	brl	L10117
L174:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	ldy	#$1
	lda	[<R0],Y
	and	#$ff
	sta	<R0
	lda	<R0
	ldx	#<$16
	xref	~~~mul
	jsl	~~~mul
	sta	<R0
	clc
	lda	#<~~basicvars+504
	adc	<R0
	sta	<R1
	lda	<R1
	sta	<L170+vp_1
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<L170+vp_1+2
	lda	|~~basicvars+62
	sta	<L170+base_1
	lda	|~~basicvars+62+2
	sta	<L170+base_1+2
	clc
	lda	#$2
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L175
	inc	|~~basicvars+62+2
L175:
	sep	#$20
	longa	off
	lda	#$1
	sta	<L170+blockdef_1
	rep	#$20
	longa	on
	brl	L10118
L10117:
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~get_srcaddr
	sta	<L170+base_1
	stx	<L170+base_1+2
	pei	<L170+base_1+2
	pei	<L170+base_1
	jsl	~~skip_name
	sta	<L170+ep_1
	stx	<L170+ep_1+2
	clc
	lda	#$5
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L176
	inc	|~~basicvars+62+2
L176:
	stz	<R0
	clc
	lda	#$ffff
	adc	<L170+ep_1
	sta	<R1
	lda	#$ffff
	adc	<L170+ep_1+2
	sta	<R1+2
	sep	#$20
	longa	off
	lda	[<R1]
	cmp	#<$28
	rep	#$20
	longa	on
	bne	L178
	brl	L177
L178:
	clc
	lda	#$ffff
	adc	<L170+ep_1
	sta	<R1
	lda	#$ffff
	adc	<L170+ep_1+2
	sta	<R1+2
	sep	#$20
	longa	off
	lda	[<R1]
	cmp	#<$5b
	rep	#$20
	longa	on
	bne	L179
	brl	L177
L179:
	inc	<R0
L177:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L170+blockdef_1
	rep	#$20
	longa	on
	sec
	lda	<L170+ep_1
	sbc	<L170+base_1
	sta	<R0
	lda	<L170+ep_1+2
	sbc	<L170+base_1+2
	sta	<R0+2
	pei	<R0
	pei	<L170+base_1+2
	pei	<L170+base_1
	jsl	~~find_variable
	sta	<L170+vp_1
	stx	<L170+vp_1+2
	lda	<L170+blockdef_1
	and	#$ff
	bne	L180
	brl	L10119
L180:
	lda	<L170+vp_1
	ora	<L170+vp_1+2
	beq	L181
	brl	L10120
L181:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$21
	rep	#$20
	longa	on
	beq	L182
	brl	L10121
L182:
	sec
	lda	<L170+ep_1
	sbc	<L170+base_1
	sta	<R0
	lda	<L170+ep_1+2
	sbc	<L170+base_1+2
	sta	<R0+2
	pei	<R0
	pei	<L170+base_1+2
	pei	<L170+base_1
	jsl	~~tocstring
	sta	<R1
	stx	<R1+2
	phx
	pha
	pea	#<$d
	pea	#8
	jsl	~~error
	brl	L10122
L10121:
	pea	#^$0
	pea	#<$0
	sec
	lda	<L170+ep_1
	sbc	<L170+base_1
	sta	<R0
	lda	<L170+ep_1+2
	sbc	<L170+base_1+2
	sta	<R0+2
	pei	<R0
	pei	<L170+base_1+2
	pei	<L170+base_1
	jsl	~~create_variable
	sta	<L170+vp_1
	stx	<L170+vp_1+2
L10122:
L10120:
	brl	L10123
L10119:
	lda	<L170+vp_1
	ora	<L170+vp_1+2
	beq	L183
	brl	L10124
L183:
	pea	#^$0
	pea	#<$0
	sec
	lda	<L170+ep_1
	sbc	<L170+base_1
	sta	<R0
	lda	<L170+ep_1+2
	sbc	<L170+base_1+2
	sta	<R0+2
	pei	<R0
	pei	<L170+base_1+2
	pei	<L170+base_1
	jsl	~~create_variable
	sta	<L170+vp_1
	stx	<L170+vp_1+2
	brl	L10125
L10124:
	ldy	#$10
	lda	[<L170+vp_1],Y
	ldy	#$12
	ora	[<L170+vp_1],Y
	bne	L184
	brl	L10126
L184:
	ldy	#$8
	lda	[<L170+vp_1],Y
	pha
	ldy	#$6
	lda	[<L170+vp_1],Y
	pha
	pea	#<$1b
	pea	#8
	jsl	~~error
L10126:
	sep	#$20
	longa	off
	lda	#$1
	sta	<L170+islocal_1
	rep	#$20
	longa	on
L10125:
L10123:
L10118:
	lda	<L170+blockdef_1
	and	#$ff
	bne	L185
	brl	L10127
L185:
	pei	<L170+vp_1+2
	pei	<L170+vp_1
	jsl	~~define_byte_array
	brl	L10128
L10127:
	pei	<L170+islocal_1
	pei	<L170+vp_1+2
	pei	<L170+vp_1
	jsl	~~define_array
L10128:
L10113:
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
	bne	L186
	brl	L10115
L186:
L10114:
	jsl	~~check_ateol
L187:
	pld
	tsc
	clc
	adc	#L169
	tcs
	rtl
L169	equ	22
L170	equ	9
	ends
	efunc
	code
	func
~~start_blockif:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L188
	tcs
	phd
	tcd
tp_0	set	4
L10129:
	lda	[<L188+tp_0]
	and	#$ff
	bne	L190
	brl	L10130
L190:
	sep	#$20
	longa	off
	lda	[<L188+tp_0]
	cmp	#<$df
	rep	#$20
	longa	on
	beq	L191
	brl	L10131
L191:
	ldy	#$1
	lda	[<L188+tp_0],Y
	and	#$ff
	beq	L192
	brl	L10131
L192:
	lda	#$1
L193:
	tay
	lda	<L188+2
	sta	<L188+2+4
	lda	<L188+1
	sta	<L188+1+4
	pld
	tsc
	clc
	adc	#L188+4
	tcs
	tya
	rtl
L10131:
	pei	<L188+tp_0+2
	pei	<L188+tp_0
	jsl	~~skip_token
	sta	<L188+tp_0
	stx	<L188+tp_0+2
	brl	L10129
L10130:
	lda	#$0
	brl	L193
L188	equ	0
L189	equ	1
	ends
	efunc
	code
	xdef	~~exec_elsewhen
	func
~~exec_elsewhen:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L194
	tcs
	phd
	tcd
p_1	set	0
	clc
	lda	#$1
	adc	|~~basicvars+62
	sta	<L195+p_1
	lda	#$0
	adc	|~~basicvars+62+2
	sta	<L195+p_1+2
	lda	[<L195+p_1]
	and	#$ff
	sta	<R0
	ldy	#$1
	lda	[<L195+p_1],Y
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
	bpl	L196
	dey
L196:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L195+p_1
	adc	<R0
	sta	<L195+p_1
	lda	<L195+p_1+2
	adc	<R0+2
	sta	<L195+p_1+2
	lda	|~~basicvars+425
	bit	#$1
	bne	L197
	brl	L10132
L197:
	lda	|~~basicvars+425
	bit	#$2
	bne	L198
	brl	L10133
L198:
	pei	<L195+p_1+2
	pei	<L195+p_1
	jsl	~~find_linestart
	sta	<R0
	stx	<R0+2
	phx
	pha
	jsl	~~get_lineno
	pha
	jsl	~~trace_line
L10133:
	lda	|~~basicvars+425
	bit	#$10
	bne	L199
	brl	L10134
L199:
	pei	<L195+p_1+2
	pei	<L195+p_1
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~trace_branch
L10134:
L10132:
	lda	<L195+p_1
	sta	|~~basicvars+62
	lda	<L195+p_1+2
	sta	|~~basicvars+62+2
L200:
	pld
	tsc
	clc
	adc	#L194
	tcs
	rtl
L194	equ	16
L195	equ	13
	ends
	efunc
	code
	xdef	~~exec_xelse
	func
~~exec_xelse:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L201
	tcs
	phd
	tcd
p_1	set	0
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$a0
	sta	[<R0]
	rep	#$20
	longa	on
	clc
	lda	#$3
	adc	|~~basicvars+62
	sta	<L202+p_1
	lda	#$0
	adc	|~~basicvars+62+2
	sta	<L202+p_1+2
L10137:
	pei	<L202+p_1+2
	pei	<L202+p_1
	jsl	~~skip_token
	sta	<L202+p_1
	stx	<L202+p_1+2
L10135:
	lda	[<L202+p_1]
	and	#$ff
	beq	L203
	brl	L10137
L203:
L10136:
	inc	<L202+p_1
	bne	L204
	inc	<L202+p_1+2
L204:
	ldy	#$5
	lda	[<L202+p_1],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L205
	dey
L205:
	sta	<R0
	sty	<R0+2
	ldy	#$4
	lda	[<L202+p_1],Y
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
	lda	<L202+p_1
	adc	<R2
	sta	<R0
	lda	<L202+p_1+2
	adc	<R2+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	lda	#$1
	adc	|~~basicvars+62
	sta	<R1
	lda	#$0
	adc	|~~basicvars+62+2
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	jsl	~~set_dest
	jsl	~~exec_elsewhen
L206:
	pld
	tsc
	clc
	adc	#L201
	tcs
	rtl
L201	equ	16
L202	equ	13
	ends
	efunc
	code
	xdef	~~exec_xlhelse
	func
~~exec_xlhelse:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L207
	tcs
	phd
	tcd
depth_1	set	0
lp_1	set	2
lp2_1	set	6
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~find_linestart
	sta	<L208+lp_1
	stx	<L208+lp_1+2
	lda	|~~basicvars+62
	sta	<L208+lp2_1
	lda	|~~basicvars+62+2
	sta	<L208+lp2_1+2
	lda	#$1
	sta	<L208+depth_1
L10140:
	sep	#$20
	longa	off
	lda	[<L208+lp2_1]
	cmp	#<$a5
	rep	#$20
	longa	on
	beq	L209
	brl	L10141
L209:
	dec	<L208+depth_1
L10141:
	pei	<L208+lp2_1+2
	pei	<L208+lp2_1
	jsl	~~start_blockif
	and	#$ff
	bne	L210
	brl	L10142
L210:
	inc	<L208+depth_1
L10142:
	lda	<L208+depth_1
	bne	L211
	brl	L10139
L211:
	ldy	#$2
	lda	[<L208+lp_1],Y
	and	#$ff
	sta	<R0
	ldy	#$3
	lda	[<L208+lp_1],Y
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
	bpl	L212
	dey
L212:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L208+lp_1
	adc	<R0
	sta	<L208+lp_1
	lda	<L208+lp_1+2
	adc	<R0+2
	sta	<L208+lp_1+2
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L208+lp_1],Y
	cmp	#<$ff
	rep	#$20
	longa	on
	beq	L213
	brl	L10143
L213:
	pea	#<$2d
	pea	#4
	jsl	~~error
L10143:
	ldy	#$5
	lda	[<L208+lp_1],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L214
	dey
L214:
	sta	<R0
	sty	<R0+2
	ldy	#$4
	lda	[<L208+lp_1],Y
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
	lda	<L208+lp_1
	adc	<R2
	sta	<L208+lp2_1
	lda	<L208+lp_1+2
	adc	<R2+2
	sta	<L208+lp2_1+2
L10138:
	brl	L10140
L10139:
	inc	<L208+lp2_1
	bne	L215
	inc	<L208+lp2_1+2
L215:
	lda	[<L208+lp2_1]
	and	#$ff
	beq	L216
	brl	L10144
L216:
	inc	<L208+lp2_1
	bne	L217
	inc	<L208+lp2_1+2
L217:
	lda	|~~basicvars+425
	bit	#$2
	bne	L218
	brl	L10145
L218:
	pei	<L208+lp2_1+2
	pei	<L208+lp2_1
	jsl	~~get_lineno
	pha
	jsl	~~trace_line
L10145:
	ldy	#$5
	lda	[<L208+lp2_1],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L219
	dey
L219:
	sta	<R0
	sty	<R0+2
	ldy	#$4
	lda	[<L208+lp2_1],Y
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
	lda	<L208+lp2_1
	adc	<R2
	sta	<L208+lp2_1
	lda	<L208+lp2_1+2
	adc	<R2+2
	sta	<L208+lp2_1+2
L10144:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$a2
	sta	[<R0]
	rep	#$20
	longa	on
	pei	<L208+lp2_1+2
	pei	<L208+lp2_1
	clc
	lda	#$1
	adc	|~~basicvars+62
	sta	<R0
	lda	#$0
	adc	|~~basicvars+62+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~set_dest
	jsl	~~exec_elsewhen
L220:
	pld
	tsc
	clc
	adc	#L207
	tcs
	rtl
L207	equ	22
L208	equ	13
	ends
	efunc
	code
	xdef	~~exec_end
	func
~~exec_end:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L221
	tcs
	phd
	tcd
newend_1	set	0
	inc	|~~basicvars+62
	bne	L223
	inc	|~~basicvars+62+2
L223:
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
	beq	L224
	brl	L10146
L224:
	inc	|~~basicvars+62
	bne	L225
	inc	|~~basicvars+62+2
L225:
	jsl	~~expression
	jsl	~~check_ateol
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	brl	L10147
L10149:
	jsl	~~pop_int
	sta	<L222+newend_1
	brl	L10148
L10150:
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
	sta	<L222+newend_1
	brl	L10148
L10151:
	pea	#<$3f
	pea	#4
	jsl	~~error
	brl	L10148
L10147:
	xref	~~~swt
	jsl	~~~swt
	dw	2
	dw	2
	dw	L10149-1
	dw	3
	dw	L10150-1
	dw	L10151-1
L10148:
	pei	<L222+newend_1
	jsl	~~emulate_endeq
	brl	L10152
L10146:
	jsl	~~check_ateol
	jsl	~~end_run
L10152:
L226:
	pld
	tsc
	clc
	adc	#L221
	tcs
	rtl
L221	equ	6
L222	equ	5
	ends
	efunc
	code
	xdef	~~exec_endifcase
	func
~~exec_endifcase:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L227
	tcs
	phd
	tcd
	inc	|~~basicvars+62
	bne	L229
	inc	|~~basicvars+62+2
L229:
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
	beq	L230
	brl	L10153
L230:
	pea	#<$5
	pea	#4
	jsl	~~error
L10153:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$3a
	rep	#$20
	longa	on
	beq	L231
	brl	L10154
L231:
	inc	|~~basicvars+62
	bne	L232
	inc	|~~basicvars+62+2
L232:
L10154:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	beq	L233
	brl	L10155
L233:
	inc	|~~basicvars+62
	bne	L234
	inc	|~~basicvars+62+2
L234:
	lda	|~~basicvars+425
	bit	#$2
	bne	L235
	brl	L10156
L235:
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~get_lineno
	pha
	jsl	~~trace_line
L10156:
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	ldy	#$5
	lda	[<R1],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L236
	dey
L236:
	sta	<R0
	sty	<R0+2
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	ldy	#$4
	lda	[<R1],Y
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
	lda	|~~basicvars+62
	adc	<R2
	sta	|~~basicvars+62
	lda	|~~basicvars+62+2
	adc	<R2+2
	sta	|~~basicvars+62+2
L10155:
L237:
	pld
	tsc
	clc
	adc	#L227
	tcs
	rtl
L227	equ	12
L228	equ	13
	ends
	efunc
	code
	xdef	~~exec_endproc
	func
~~exec_endproc:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L238
	tcs
	phd
	tcd
returnblock_1	set	0
	lda	|~~basicvars+399
	ora	|~~basicvars+399+2
	beq	L240
	brl	L10157
L240:
	pea	#<$55
	pea	#4
	jsl	~~error
L10157:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$f
	bne	L241
	brl	L10158
L241:
	pea	#<$f
	jsl	~~empty_stack
L10158:
	jsl	~~pop_proc
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L239+returnblock_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$e
	xref	~~~fmov
	jsl	~~~fmov
	lda	<L239+returnblock_1+8
	bne	L242
	brl	L10159
L242:
	pei	<L239+returnblock_1+8
	jsl	~~restore_parameters
L10159:
	lda	|~~basicvars+425
	bit	#$1
	bne	L243
	brl	L10160
L243:
	lda	|~~basicvars+425
	bit	#$4
	bne	L244
	brl	L10161
L244:
	pea	#<$0
	pei	<L239+returnblock_1+12
	pei	<L239+returnblock_1+10
	jsl	~~trace_proc
L10161:
	lda	|~~basicvars+425
	bit	#$10
	bne	L245
	brl	L10162
L245:
	pei	<L239+returnblock_1+6
	pei	<L239+returnblock_1+4
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~trace_branch
L10162:
L10160:
	lda	<L239+returnblock_1+4
	sta	|~~basicvars+62
	lda	<L239+returnblock_1+6
	sta	|~~basicvars+62+2
L246:
	pld
	tsc
	clc
	adc	#L238
	tcs
	rtl
L238	equ	18
L239	equ	5
	ends
	efunc
	code
	xdef	~~exec_fnreturn
	func
~~exec_fnreturn:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L247
	tcs
	phd
	tcd
	udata
L10163:
	ds	4
	ends
resultype_1	set	0
intresult_1	set	2
stresult_1	set	4
sp_1	set	10
returnblock_1	set	14
	lda	|~~basicvars+399
	ora	|~~basicvars+399+2
	beq	L249
	brl	L10164
L249:
	pea	#<$56
	pea	#4
	jsl	~~error
L10164:
	inc	|~~basicvars+62
	bne	L250
	inc	|~~basicvars+62+2
L250:
	jsl	~~expression
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L248+resultype_1
	lda	<L248+resultype_1
	cmp	#<$2
	beq	L251
	brl	L10165
L251:
	jsl	~~pop_int
	sta	<L248+intresult_1
	brl	L10166
L10165:
	lda	<L248+resultype_1
	cmp	#<$3
	beq	L252
	brl	L10167
L252:
	phy
	phy
	jsl	~~pop_float
	pla
	sta	|L10163
	pla
	sta	|L10163+2
	brl	L10168
L10167:
	lda	<L248+resultype_1
	cmp	#<$4
	beq	L253
	brl	L10169
L253:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L248+stresult_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	pei	<L248+stresult_1
	jsl	~~alloc_string
	sta	<L248+sp_1
	stx	<L248+sp_1+2
	lda	<L248+stresult_1
	bne	L254
	brl	L10170
L254:
	ldy	#$0
	lda	<L248+stresult_1
	bpl	L255
	dey
L255:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L248+stresult_1+4
	pei	<L248+stresult_1+2
	pei	<L248+sp_1+2
	pei	<L248+sp_1
	jsl	~~memmove
L10170:
	lda	<L248+sp_1
	sta	<L248+stresult_1+2
	lda	<L248+sp_1+2
	sta	<L248+stresult_1+4
	lda	#$5
	sta	<L248+resultype_1
	brl	L10171
L10169:
	lda	<L248+resultype_1
	cmp	#<$5
	beq	L256
	brl	L10172
L256:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L248+stresult_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	brl	L10173
L10172:
	pea	#<$45
	pea	#4
	jsl	~~error
L10173:
L10171:
L10168:
L10166:
	pea	#<$10
	jsl	~~empty_stack
	jsl	~~pop_fn
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L248+returnblock_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$e
	xref	~~~fmov
	jsl	~~~fmov
	lda	<L248+returnblock_1+8
	bne	L257
	brl	L10174
L257:
	pei	<L248+returnblock_1+8
	jsl	~~restore_parameters
L10174:
	lda	<L248+resultype_1
	cmp	#<$2
	beq	L258
	brl	L10175
L258:
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
	lda	<L248+intresult_1
	ldy	#$2
	sta	[<R0],Y
	brl	L10176
L10175:
	lda	<L248+resultype_1
	cmp	#<$3
	beq	L259
	brl	L10177
L259:
	clc
	lda	#$fffa
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	lda	#$ffff
	adc	|~~basicvars+42+2
	sta	|~~basicvars+42+2
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	#$3
	sta	[<R0]
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	|L10163
	ldy	#$2
	sta	[<R0],Y
	lda	|L10163+2
	ldy	#$4
	sta	[<R0],Y
	brl	L10178
L10177:
	lda	<L248+resultype_1
	cmp	#<$4
	beq	L260
	brl	L10179
L260:
	clc
	lda	#$fff8
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	lda	#$ffff
	adc	|~~basicvars+42+2
	sta	|~~basicvars+42+2
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	#$4
	sta	[<R0]
	clc
	tdc
	adc	#<L248+stresult_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	lda	#$2
	adc	|~~basicvars+42
	sta	<R0
	lda	#$0
	adc	|~~basicvars+42+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	brl	L10180
L10179:
	lda	<L248+resultype_1
	cmp	#<$5
	beq	L261
	brl	L10181
L261:
	pei	<L248+stresult_1+4
	pei	<L248+stresult_1+2
	pei	<L248+stresult_1
	jsl	~~push_strtemp
L10181:
L10180:
L10178:
L10176:
	lda	|~~basicvars+425
	bit	#$1
	bne	L262
	brl	L10182
L262:
	lda	|~~basicvars+425
	bit	#$4
	bne	L263
	brl	L10183
L263:
	pea	#<$0
	pei	<L248+returnblock_1+12
	pei	<L248+returnblock_1+10
	jsl	~~trace_proc
L10183:
	lda	|~~basicvars+425
	bit	#$10
	bne	L264
	brl	L10184
L264:
	pei	<L248+returnblock_1+6
	pei	<L248+returnblock_1+4
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~trace_branch
L10184:
L10182:
	lda	<L248+returnblock_1+4
	sta	|~~basicvars+62
	lda	<L248+returnblock_1+6
	sta	|~~basicvars+62+2
L265:
	pld
	tsc
	clc
	adc	#L247
	tcs
	rtl
L247	equ	32
L248	equ	5
	ends
	efunc
	code
	xdef	~~exec_endwhile
	func
~~exec_endwhile:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L266
	tcs
	phd
	tcd
tp_1	set	0
wp_1	set	4
result_1	set	8
	clc
	lda	#$1
	adc	|~~basicvars+62
	sta	<L267+tp_1
	lda	#$0
	adc	|~~basicvars+62+2
	sta	<L267+tp_1+2
	lda	[<L267+tp_1]
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	beq	L268
	brl	L10185
L268:
	pea	#<$5
	pea	#4
	jsl	~~error
L10185:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$13
	beq	L269
	brl	L10186
L269:
	lda	|~~basicvars+42
	sta	<L267+wp_1
	lda	|~~basicvars+42+2
	sta	<L267+wp_1+2
	brl	L10187
L10186:
	jsl	~~get_while
	sta	<L267+wp_1
	stx	<L267+wp_1+2
L10187:
	lda	<L267+wp_1
	ora	<L267+wp_1+2
	beq	L270
	brl	L10188
L270:
	pea	#<$33
	pea	#4
	jsl	~~error
L10188:
	lda	|~~basicvars+489
	and	#$ff
	bne	L271
	brl	L10189
L271:
	pea	#<$8
	pea	#4
	jsl	~~error
L10189:
	ldy	#$2
	lda	[<L267+wp_1],Y
	sta	|~~basicvars+62
	ldy	#$4
	lda	[<L267+wp_1],Y
	sta	|~~basicvars+62+2
	jsl	~~expression
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$2
	beq	L272
	brl	L10190
L272:
	jsl	~~pop_int
	sta	<L267+result_1
	brl	L10191
L10190:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$3
	beq	L273
	brl	L10192
L273:
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
	sta	<L267+result_1
	brl	L10193
L10192:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10193:
L10191:
	lda	<L267+result_1
	bne	L274
	brl	L10194
L274:
	lda	|~~basicvars+425
	bit	#$10
	bne	L275
	brl	L10195
L275:
	ldy	#$8
	lda	[<L267+wp_1],Y
	pha
	ldy	#$6
	lda	[<L267+wp_1],Y
	pha
	pei	<L267+tp_1+2
	pei	<L267+tp_1
	jsl	~~trace_branch
L10195:
	ldy	#$6
	lda	[<L267+wp_1],Y
	sta	|~~basicvars+62
	ldy	#$8
	lda	[<L267+wp_1],Y
	sta	|~~basicvars+62+2
	brl	L10196
L10194:
	jsl	~~pop_while
	sep	#$20
	longa	off
	lda	[<L267+tp_1]
	cmp	#<$3a
	rep	#$20
	longa	on
	beq	L276
	brl	L10197
L276:
	inc	<L267+tp_1
	bne	L277
	inc	<L267+tp_1+2
L277:
L10197:
	lda	[<L267+tp_1]
	and	#$ff
	beq	L278
	brl	L10198
L278:
	inc	<L267+tp_1
	bne	L279
	inc	<L267+tp_1+2
L279:
	lda	|~~basicvars+425
	bit	#$2
	bne	L280
	brl	L10199
L280:
	pei	<L267+tp_1+2
	pei	<L267+tp_1
	jsl	~~get_lineno
	pha
	jsl	~~trace_line
L10199:
	ldy	#$5
	lda	[<L267+tp_1],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L281
	dey
L281:
	sta	<R0
	sty	<R0+2
	ldy	#$4
	lda	[<L267+tp_1],Y
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
	lda	<L267+tp_1
	adc	<R2
	sta	<L267+tp_1
	lda	<L267+tp_1+2
	adc	<R2+2
	sta	<L267+tp_1+2
L10198:
	lda	<L267+tp_1
	sta	|~~basicvars+62
	lda	<L267+tp_1+2
	sta	|~~basicvars+62+2
L10196:
L282:
	pld
	tsc
	clc
	adc	#L266
	tcs
	rtl
L266	equ	22
L267	equ	13
	ends
	efunc
	code
	xdef	~~exec_error
	func
~~exec_error:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L283
	tcs
	phd
	tcd
errnumber_1	set	0
stringtype_1	set	2
descriptor_1	set	4
errtext_1	set	10
	inc	|~~basicvars+62
	bne	L285
	inc	|~~basicvars+62+2
L285:
	jsl	~~eval_integer
	sta	<L284+errnumber_1
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
	bne	L286
	brl	L10200
L286:
	pea	#<$27
	pea	#4
	jsl	~~error
L10200:
	inc	|~~basicvars+62
	bne	L287
	inc	|~~basicvars+62+2
L287:
	jsl	~~expression
	jsl	~~check_ateol
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L284+stringtype_1
	lda	<L284+stringtype_1
	cmp	#<$4
	bne	L288
	brl	L10201
L288:
	lda	<L284+stringtype_1
	cmp	#<$5
	bne	L289
	brl	L10201
L289:
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
	adc	#<L284+descriptor_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	pei	<L284+descriptor_1
	pei	<L284+descriptor_1+4
	pei	<L284+descriptor_1+2
	jsl	~~tocstring
	sta	<L284+errtext_1
	stx	<L284+errtext_1+2
	lda	<L284+stringtype_1
	cmp	#<$5
	beq	L290
	brl	L10202
L290:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L284+descriptor_1
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
	pei	<L284+errtext_1+2
	pei	<L284+errtext_1
	pei	<L284+errnumber_1
	jsl	~~show_error
L291:
	pld
	tsc
	clc
	adc	#L283
	tcs
	rtl
L283	equ	22
L284	equ	9
	ends
	efunc
	code
	xdef	~~exec_for
	func
~~exec_for:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L292
	tcs
	phd
	tcd
	udata
L10203:
	ds	4
	ends
	udata
L10204:
	ds	4
	ends
isinteger_1	set	0
forvar_1	set	1
intlimit_1	set	7
intstep_1	set	9
	inc	|~~basicvars+62
	bne	L294
	inc	|~~basicvars+62+2
L294:
	pea	#0
	clc
	tdc
	adc	#<L293+forvar_1
	pha
	jsl	~~get_lvalue
	lda	<L293+forvar_1
	and	#<$8
	beq	L296
	brl	L295
L296:
	lda	<L293+forvar_1
	and	#<$7
	sta	<R0
	sec
	lda	#$3
	sbc	<R0
	bvs	L297
	eor	#$8000
L297:
	bpl	L298
	brl	L10205
L298:
L295:
	pea	#<$43
	pea	#4
	jsl	~~error
L10205:
	stz	<R0
	lda	<L293+forvar_1
	and	#<$7
	sta	<R1
	lda	<R1
	bmi	L300
	dea
	dea
	dea
	bmi	L300
	brl	L299
L300:
	inc	<R0
L299:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L293+isinteger_1
	rep	#$20
	longa	on
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
	bne	L301
	brl	L10206
L301:
	pea	#<$26
	pea	#4
	jsl	~~error
L10206:
	inc	|~~basicvars+62
	bne	L302
	inc	|~~basicvars+62+2
L302:
	jsl	~~expression
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
	bne	L303
	brl	L10207
L303:
	pea	#<$31
	pea	#4
	jsl	~~error
L10207:
	inc	|~~basicvars+62
	bne	L304
	inc	|~~basicvars+62+2
L304:
	lda	<L293+forvar_1
	brl	L10208
L10210:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	brl	L10211
L10213:
	jsl	~~pop_int
	sta	[<L293+forvar_1+2]
	brl	L10212
L10214:
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
	sta	[<L293+forvar_1+2]
	brl	L10212
L10215:
	pea	#<$3f
	pea	#4
	jsl	~~error
	brl	L10212
L10211:
	xref	~~~swt
	jsl	~~~swt
	dw	2
	dw	2
	dw	L10213-1
	dw	3
	dw	L10214-1
	dw	L10215-1
L10212:
	brl	L10209
L10216:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	brl	L10217
L10219:
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L305
	dey
L305:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	pla
	sta	[<L293+forvar_1+2]
	pla
	ldy	#$2
	sta	[<L293+forvar_1+2],Y
	brl	L10218
L10220:
	phy
	phy
	jsl	~~pop_float
	pla
	sta	[<L293+forvar_1+2]
	pla
	ldy	#$2
	sta	[<L293+forvar_1+2],Y
	brl	L10218
L10221:
	pea	#<$3f
	pea	#4
	jsl	~~error
	brl	L10218
L10217:
	xref	~~~swt
	jsl	~~~swt
	dw	2
	dw	2
	dw	L10219-1
	dw	3
	dw	L10220-1
	dw	L10221-1
L10218:
	brl	L10209
L10222:
	pea	#<$1
	pei	<L293+forvar_1+2
	jsl	~~check_write
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	brl	L10223
L10225:
	lda	|~~basicvars+6
	sta	<R0
	lda	|~~basicvars+6+2
	sta	<R0+2
	jsl	~~pop_int
	sep	#$20
	longa	off
	ldy	<L293+forvar_1+2
	sta	[<R0],Y
	rep	#$20
	longa	on
	brl	L10224
L10226:
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
	ldy	<L293+forvar_1+2
	sta	[<R0],Y
	rep	#$20
	longa	on
	brl	L10224
L10227:
	pea	#<$3f
	pea	#4
	jsl	~~error
	brl	L10224
L10223:
	xref	~~~swt
	jsl	~~~swt
	dw	2
	dw	2
	dw	L10225-1
	dw	3
	dw	L10226-1
	dw	L10227-1
L10224:
	brl	L10209
L10228:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	brl	L10229
L10231:
	jsl	~~pop_int
	pha
	pei	<L293+forvar_1+2
	jsl	~~store_integer
	brl	L10230
L10232:
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
	pei	<L293+forvar_1+2
	jsl	~~store_integer
	brl	L10230
L10233:
	pea	#<$3f
	pea	#4
	jsl	~~error
	brl	L10230
L10229:
	xref	~~~swt
	jsl	~~~swt
	dw	2
	dw	2
	dw	L10231-1
	dw	3
	dw	L10232-1
	dw	L10233-1
L10230:
	brl	L10209
L10234:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	brl	L10235
L10237:
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L306
	dey
L306:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	pei	<L293+forvar_1+2
	jsl	~~store_float
	brl	L10236
L10238:
	phy
	phy
	jsl	~~pop_float
	pei	<L293+forvar_1+2
	jsl	~~store_float
	brl	L10236
L10239:
	pea	#<$3f
	pea	#4
	jsl	~~error
	brl	L10236
L10235:
	xref	~~~swt
	jsl	~~~swt
	dw	2
	dw	2
	dw	L10237-1
	dw	3
	dw	L10238-1
	dw	L10239-1
L10236:
	brl	L10209
L10240:
	pea	#^L1
	pea	#<L1
	pea	#<$351
	pea	#<$82
	pea	#10
	jsl	~~error
	brl	L10209
L10208:
	xref	~~~swt
	jsl	~~~swt
	dw	5
	dw	2
	dw	L10210-1
	dw	3
	dw	L10216-1
	dw	17
	dw	L10222-1
	dw	18
	dw	L10228-1
	dw	19
	dw	L10234-1
	dw	L10240-1
L10209:
	jsl	~~expression
	lda	<L293+isinteger_1
	and	#$ff
	bne	L307
	brl	L10241
L307:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$2
	beq	L308
	brl	L10242
L308:
	jsl	~~pop_int
	sta	<L293+intlimit_1
	brl	L10243
L10242:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$3
	beq	L309
	brl	L10244
L309:
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
	sta	<L293+intlimit_1
	brl	L10245
L10244:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10245:
L10243:
	brl	L10246
L10241:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$2
	beq	L310
	brl	L10247
L310:
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L311
	dey
L311:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	pla
	sta	|L10203
	pla
	sta	|L10203+2
	brl	L10248
L10247:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$3
	beq	L312
	brl	L10249
L312:
	phy
	phy
	jsl	~~pop_float
	pla
	sta	|L10203
	pla
	sta	|L10203+2
	brl	L10250
L10249:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10250:
L10248:
L10246:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$d9
	rep	#$20
	longa	on
	beq	L313
	brl	L10251
L313:
	inc	|~~basicvars+62
	bne	L314
	inc	|~~basicvars+62+2
L314:
	jsl	~~expression
	lda	<L293+isinteger_1
	and	#$ff
	bne	L315
	brl	L10252
L315:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$2
	beq	L316
	brl	L10253
L316:
	jsl	~~pop_int
	sta	<L293+intstep_1
	brl	L10254
L10253:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$3
	beq	L317
	brl	L10255
L317:
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
	sta	<L293+intstep_1
	brl	L10256
L10255:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10256:
L10254:
	lda	<L293+intstep_1
	beq	L318
	brl	L10257
L318:
	pea	#<$6
	pea	#4
	jsl	~~error
L10257:
	brl	L10258
L10252:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$2
	beq	L319
	brl	L10259
L319:
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L320
	dey
L320:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	pla
	sta	|L10204
	pla
	sta	|L10204+2
	brl	L10260
L10259:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$3
	beq	L321
	brl	L10261
L321:
	phy
	phy
	jsl	~~pop_float
	pla
	sta	|L10204
	pla
	sta	|L10204+2
	brl	L10262
L10261:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10262:
L10260:
	lda	|L10204+2
	pha
	lda	|L10204
	pha
	xref	~~~ftod
	jsl	~~~ftod
	xref	~~~dtst
	jsl	~~~dtst
	beq	L322
	brl	L10263
L322:
	pea	#<$6
	pea	#4
	jsl	~~error
L10263:
L10258:
	brl	L10264
L10251:
	lda	<L293+isinteger_1
	and	#$ff
	bne	L323
	brl	L10265
L323:
	lda	#$1
	sta	<L293+intstep_1
	brl	L10266
L10265:
	lda	#$0
	sta	|L10204
	lda	#$3f80
	sta	|L10204+2
L10266:
L10264:
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
	beq	L324
	brl	L10267
L324:
	pea	#<$5
	pea	#4
	jsl	~~error
L10267:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$3a
	rep	#$20
	longa	on
	beq	L325
	brl	L10268
L325:
	inc	|~~basicvars+62
	bne	L326
	inc	|~~basicvars+62+2
L326:
L10268:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	beq	L327
	brl	L10269
L327:
	inc	|~~basicvars+62
	bne	L328
	inc	|~~basicvars+62+2
L328:
	lda	|~~basicvars+425
	bit	#$2
	bne	L329
	brl	L10270
L329:
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~get_lineno
	pha
	jsl	~~trace_line
L10270:
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	ldy	#$5
	lda	[<R1],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L330
	dey
L330:
	sta	<R0
	sty	<R0+2
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	ldy	#$4
	lda	[<R1],Y
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
	lda	|~~basicvars+62
	adc	<R2
	sta	|~~basicvars+62
	lda	|~~basicvars+62+2
	adc	<R2+2
	sta	|~~basicvars+62+2
L10269:
	lda	<L293+isinteger_1
	and	#$ff
	bne	L331
	brl	L10271
L331:
simple_2	set	11
	stz	<R0
	lda	<L293+forvar_1
	cmp	#<$2
	beq	L333
	brl	L332
L333:
	lda	<L293+intstep_1
	cmp	#<$1
	beq	L334
	brl	L332
L334:
	inc	<R0
L332:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L293+simple_2
	rep	#$20
	longa	on
	pei	<L293+simple_2
	pei	<L293+intstep_1
	pei	<L293+intlimit_1
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L293+forvar_1
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
	jsl	~~push_intfor
	brl	L10272
L10271:
	pea	#<$0
	lda	|L10204+2
	pha
	lda	|L10204
	pha
	lda	|L10203+2
	pha
	lda	|L10203
	pha
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L293+forvar_1
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
	jsl	~~push_floatfor
L10272:
L335:
	pld
	tsc
	clc
	adc	#L292
	tcs
	rtl
L292	equ	24
L293	equ	13
	ends
	efunc
	data
L1:
	db	$6D,$61,$69,$6E,$73,$74,$61,$74,$65,$00
	ends
	code
	func
~~set_linedest:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L337
	tcs
	phd
	tcd
tp_0	set	4
line_1	set	0
dest_1	set	2
	pei	<L337+tp_0+2
	pei	<L337+tp_0
	jsl	~~get_linenum
	sta	<L338+line_1
	pei	<L338+line_1
	jsl	~~find_line
	sta	<L338+dest_1
	stx	<L338+dest_1+2
	pei	<L338+dest_1+2
	pei	<L338+dest_1
	jsl	~~get_lineno
	sta	<R0
	lda	<R0
	cmp	<L338+line_1
	bne	L339
	brl	L10273
L339:
	pei	<L338+line_1
	pea	#<$c
	pea	#6
	jsl	~~error
L10273:
	ldy	#$5
	lda	[<L338+dest_1],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L340
	dey
L340:
	sta	<R0
	sty	<R0+2
	ldy	#$4
	lda	[<L338+dest_1],Y
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
	lda	<L338+dest_1
	adc	<R2
	sta	<L338+dest_1
	lda	<L338+dest_1+2
	adc	<R2+2
	sta	<L338+dest_1+2
	sep	#$20
	longa	off
	lda	#$1f
	sta	[<L337+tp_0]
	rep	#$20
	longa	on
	pei	<L338+dest_1+2
	pei	<L338+dest_1
	pei	<L337+tp_0+2
	pei	<L337+tp_0
	jsl	~~set_address
	ldx	<L338+dest_1+2
	lda	<L338+dest_1
L341:
	tay
	lda	<L337+2
	sta	<L337+2+4
	lda	<L337+1
	sta	<L337+1+4
	pld
	tsc
	clc
	adc	#L337+4
	tcs
	tya
	rtl
L337	equ	18
L338	equ	13
	ends
	efunc
	code
	xdef	~~exec_gosub
	func
~~exec_gosub:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L342
	tcs
	phd
	tcd
dest_1	set	0
line_1	set	4
	lda	|~~basicvars+489
	and	#$ff
	bne	L344
	brl	L10274
L344:
	pea	#<$8
	pea	#4
	jsl	~~error
L10274:
	inc	|~~basicvars+62
	bne	L345
	inc	|~~basicvars+62+2
L345:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$1f
	rep	#$20
	longa	on
	beq	L346
	brl	L10275
L346:
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
	bpl	L347
	dey
L347:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars
	adc	<R0
	sta	<L343+dest_1
	lda	|~~basicvars+2
	adc	<R0+2
	sta	<L343+dest_1+2
	clc
	lda	#$5
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L348
	inc	|~~basicvars+62+2
L348:
	brl	L10276
L10275:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$1e
	rep	#$20
	longa	on
	beq	L349
	brl	L10277
L349:
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~set_linedest
	sta	<L343+dest_1
	stx	<L343+dest_1+2
	clc
	lda	#$5
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L350
	inc	|~~basicvars+62+2
L350:
	brl	L10278
L10277:
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
	beq	L351
	brl	L10279
L351:
	jsl	~~eval_intfactor
	sta	<L343+line_1
	pei	<L343+line_1
	jsl	~~find_line
	sta	<L343+dest_1
	stx	<L343+dest_1+2
	pei	<L343+dest_1+2
	pei	<L343+dest_1
	jsl	~~get_lineno
	sta	<R0
	lda	<R0
	cmp	<L343+line_1
	bne	L352
	brl	L10280
L352:
	pei	<L343+line_1
	pea	#<$c
	pea	#6
	jsl	~~error
L10280:
	ldy	#$5
	lda	[<L343+dest_1],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L353
	dey
L353:
	sta	<R0
	sty	<R0+2
	ldy	#$4
	lda	[<L343+dest_1],Y
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
	lda	<L343+dest_1
	adc	<R2
	sta	<L343+dest_1
	lda	<L343+dest_1+2
	adc	<R2+2
	sta	<L343+dest_1+2
	brl	L10281
L10279:
	pea	#<$5
	pea	#4
	jsl	~~error
L10281:
L10278:
L10276:
	jsl	~~check_ateol
	jsl	~~push_gosub
	lda	|~~basicvars+425
	bit	#$10
	bne	L354
	brl	L10282
L354:
	pei	<L343+dest_1+2
	pei	<L343+dest_1
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~trace_branch
L10282:
	lda	<L343+dest_1
	sta	|~~basicvars+62
	lda	<L343+dest_1+2
	sta	|~~basicvars+62+2
L355:
	pld
	tsc
	clc
	adc	#L342
	tcs
	rtl
L342	equ	18
L343	equ	13
	ends
	efunc
	code
	xdef	~~exec_goto
	func
~~exec_goto:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L356
	tcs
	phd
	tcd
dest_1	set	0
line_1	set	4
	lda	|~~basicvars+489
	and	#$ff
	bne	L358
	brl	L10283
L358:
	pea	#<$8
	pea	#4
	jsl	~~error
L10283:
	inc	|~~basicvars+62
	bne	L359
	inc	|~~basicvars+62+2
L359:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$1f
	rep	#$20
	longa	on
	beq	L360
	brl	L10284
L360:
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
	bpl	L361
	dey
L361:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars
	adc	<R0
	sta	<L357+dest_1
	lda	|~~basicvars+2
	adc	<R0+2
	sta	<L357+dest_1+2
	clc
	lda	#$5
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L362
	inc	|~~basicvars+62+2
L362:
	brl	L10285
L10284:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$1e
	rep	#$20
	longa	on
	beq	L363
	brl	L10286
L363:
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~set_linedest
	sta	<L357+dest_1
	stx	<L357+dest_1+2
	clc
	lda	#$5
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L364
	inc	|~~basicvars+62+2
L364:
	brl	L10287
L10286:
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
	beq	L365
	brl	L10288
L365:
	jsl	~~eval_intfactor
	sta	<L357+line_1
	lda	<L357+line_1
	bpl	L367
	brl	L366
L367:
	ldy	#$0
	lda	<L357+line_1
	bpl	L368
	dey
L368:
	sta	<R0
	sty	<R0+2
	sec
	lda	#$feff
	sbc	<R0
	lda	#$0
	sbc	<R0+2
	bvs	L369
	eor	#$8000
L369:
	bpl	L370
	brl	L10289
L370:
L366:
	pea	#<$b
	pea	#4
	jsl	~~error
L10289:
	pei	<L357+line_1
	jsl	~~find_line
	sta	<L357+dest_1
	stx	<L357+dest_1+2
	pei	<L357+dest_1+2
	pei	<L357+dest_1
	jsl	~~get_lineno
	sta	<R0
	lda	<R0
	cmp	<L357+line_1
	bne	L371
	brl	L10290
L371:
	pei	<L357+line_1
	pea	#<$c
	pea	#6
	jsl	~~error
L10290:
	ldy	#$5
	lda	[<L357+dest_1],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L372
	dey
L372:
	sta	<R0
	sty	<R0+2
	ldy	#$4
	lda	[<L357+dest_1],Y
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
	lda	<L357+dest_1
	adc	<R2
	sta	<L357+dest_1
	lda	<L357+dest_1+2
	adc	<R2+2
	sta	<L357+dest_1+2
	brl	L10291
L10288:
	pea	#<$5
	pea	#4
	jsl	~~error
L10291:
L10287:
L10285:
	jsl	~~check_ateol
	lda	|~~basicvars+425
	bit	#$10
	bne	L373
	brl	L10292
L373:
	pei	<L357+dest_1+2
	pei	<L357+dest_1
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~trace_branch
L10292:
	lda	<L357+dest_1
	sta	|~~basicvars+62
	lda	<L357+dest_1+2
	sta	|~~basicvars+62+2
L374:
	pld
	tsc
	clc
	adc	#L356
	tcs
	rtl
L356	equ	18
L357	equ	13
	ends
	efunc
	code
	xdef	~~exec_blockif
	func
~~exec_blockif:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L375
	tcs
	phd
	tcd
dest_1	set	0
	clc
	lda	#$1
	adc	|~~basicvars+62
	sta	<L376+dest_1
	lda	#$0
	adc	|~~basicvars+62+2
	sta	<L376+dest_1+2
	clc
	lda	#$5
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L377
	inc	|~~basicvars+62+2
L377:
	jsl	~~expression
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$2
	beq	L378
	brl	L10293
L378:
	jsl	~~pop_int
	tax
	beq	L379
	brl	L10294
L379:
	clc
	lda	#$2
	adc	<L376+dest_1
	sta	<L376+dest_1
	bcc	L380
	inc	<L376+dest_1+2
L380:
L10294:
	brl	L10295
L10293:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$3
	beq	L381
	brl	L10296
L381:
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
	beq	L382
	brl	L10297
L382:
	clc
	lda	#$2
	adc	<L376+dest_1
	sta	<L376+dest_1
	bcc	L383
	inc	<L376+dest_1+2
L383:
L10297:
	brl	L10298
L10296:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10298:
L10295:
	lda	|~~basicvars+425
	bit	#$1
	bne	L384
	brl	L10299
L384:
	lda	|~~basicvars+425
	bit	#$2
	bne	L385
	brl	L10300
L385:
	lda	[<L376+dest_1]
	and	#$ff
	sta	<R0
	ldy	#$1
	lda	[<L376+dest_1],Y
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
	bpl	L386
	dey
L386:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L376+dest_1
	adc	<R0
	sta	<R1
	lda	<L376+dest_1+2
	adc	<R0+2
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	jsl	~~find_linestart
	sta	<R0
	stx	<R0+2
	phx
	pha
	jsl	~~get_lineno
	pha
	jsl	~~trace_line
L10300:
	lda	|~~basicvars+425
	bit	#$10
	bne	L387
	brl	L10301
L387:
	lda	[<L376+dest_1]
	and	#$ff
	sta	<R0
	ldy	#$1
	lda	[<L376+dest_1],Y
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
	bpl	L388
	dey
L388:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L376+dest_1
	adc	<R0
	sta	<R1
	lda	<L376+dest_1+2
	adc	<R0+2
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<L376+dest_1+2
	pei	<L376+dest_1
	jsl	~~trace_branch
L10301:
L10299:
	lda	[<L376+dest_1]
	and	#$ff
	sta	<R0
	ldy	#$1
	lda	[<L376+dest_1],Y
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
	bpl	L389
	dey
L389:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L376+dest_1
	adc	<R0
	sta	|~~basicvars+62
	lda	<L376+dest_1+2
	adc	<R0+2
	sta	|~~basicvars+62+2
L390:
	pld
	tsc
	clc
	adc	#L375
	tcs
	rtl
L375	equ	16
L376	equ	13
	ends
	efunc
	code
	xdef	~~exec_singlif
	func
~~exec_singlif:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L391
	tcs
	phd
	tcd
dest_1	set	0
here_1	set	4
	clc
	lda	#$1
	adc	|~~basicvars+62
	sta	<L392+dest_1
	lda	#$0
	adc	|~~basicvars+62+2
	sta	<L392+dest_1+2
	lda	<L392+dest_1
	sta	<L392+here_1
	lda	<L392+dest_1+2
	sta	<L392+here_1+2
	clc
	lda	#$5
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L393
	inc	|~~basicvars+62+2
L393:
	jsl	~~expression
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$2
	beq	L394
	brl	L10302
L394:
	jsl	~~pop_int
	tax
	beq	L395
	brl	L10303
L395:
	clc
	lda	#$2
	adc	<L392+dest_1
	sta	<L392+dest_1
	bcc	L396
	inc	<L392+dest_1+2
L396:
L10303:
	brl	L10304
L10302:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$3
	beq	L397
	brl	L10305
L397:
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
	beq	L398
	brl	L10306
L398:
	clc
	lda	#$2
	adc	<L392+dest_1
	sta	<L392+dest_1
	bcc	L399
	inc	<L392+dest_1+2
L399:
L10306:
	brl	L10307
L10305:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10307:
L10304:
	lda	[<L392+dest_1]
	and	#$ff
	sta	<R0
	ldy	#$1
	lda	[<L392+dest_1],Y
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
	bpl	L400
	dey
L400:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L392+dest_1
	adc	<R0
	sta	<L392+dest_1
	lda	<L392+dest_1+2
	adc	<R0+2
	sta	<L392+dest_1+2
	sep	#$20
	longa	off
	lda	[<L392+dest_1]
	cmp	#<$1f
	rep	#$20
	longa	on
	beq	L401
	brl	L10308
L401:
	ldy	#$1
	lda	[<L392+dest_1],Y
	and	#$ff
	sta	<R0
	ldy	#$2
	lda	[<L392+dest_1],Y
	and	#$ff
	sta	<R2
	lda	<R2
	xba
	and	#$ff00
	sta	<R1
	lda	<R1
	ora	<R0
	sta	<R2
	ldy	#$3
	lda	[<L392+dest_1],Y
	and	#$ff
	ldx	#<$10
	xref	~~~asl
	jsl	~~~asl
	sta	<R0
	lda	<R0
	ora	<R2
	sta	<R1
	ldy	#$4
	lda	[<L392+dest_1],Y
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
	bpl	L402
	dey
L402:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars
	adc	<R0
	sta	<L392+dest_1
	lda	|~~basicvars+2
	adc	<R0+2
	sta	<L392+dest_1+2
	brl	L10309
L10308:
	sep	#$20
	longa	off
	lda	[<L392+dest_1]
	cmp	#<$1e
	rep	#$20
	longa	on
	beq	L403
	brl	L10310
L403:
	pei	<L392+dest_1+2
	pei	<L392+dest_1
	jsl	~~set_linedest
	sta	<L392+dest_1
	stx	<L392+dest_1+2
L10310:
L10309:
	lda	|~~basicvars+425
	bit	#$1
	bne	L404
	brl	L10311
L404:
	lda	|~~basicvars+425
	bit	#$2
	bne	L405
	brl	L10312
L405:
destline_2	set	8
	pei	<L392+dest_1+2
	pei	<L392+dest_1
	jsl	~~find_linestart
	sta	<R0
	stx	<R0+2
	phx
	pha
	jsl	~~get_lineno
	sta	<L392+destline_2
	pei	<L392+here_1+2
	pei	<L392+here_1
	jsl	~~get_lineno
	sta	<R0
	lda	<R0
	cmp	<L392+destline_2
	bne	L406
	brl	L10313
L406:
	pei	<L392+destline_2
	jsl	~~trace_line
L10313:
L10312:
	lda	|~~basicvars+425
	bit	#$10
	bne	L407
	brl	L10314
L407:
	pei	<L392+dest_1+2
	pei	<L392+dest_1
	pei	<L392+here_1+2
	pei	<L392+here_1
	jsl	~~trace_branch
L10314:
L10311:
	lda	<L392+dest_1
	sta	|~~basicvars+62
	lda	<L392+dest_1+2
	sta	|~~basicvars+62+2
L408:
	pld
	tsc
	clc
	adc	#L391
	tcs
	rtl
L391	equ	22
L392	equ	13
	ends
	efunc
	code
	xdef	~~exec_xif
	func
~~exec_xif:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L409
	tcs
	phd
	tcd
lp2_1	set	0
dest_1	set	4
ifplace_1	set	8
thenplace_1	set	12
elseplace_1	set	16
result_1	set	20
single_1	set	22
	lda	|~~basicvars+62
	sta	<L410+ifplace_1
	lda	|~~basicvars+62+2
	sta	<L410+ifplace_1+2
	clc
	lda	#$1
	adc	<L410+ifplace_1
	sta	<L410+thenplace_1
	lda	#$0
	adc	<L410+ifplace_1+2
	sta	<L410+thenplace_1+2
	clc
	lda	#$3
	adc	<L410+ifplace_1
	sta	<L410+elseplace_1
	lda	#$0
	adc	<L410+ifplace_1+2
	sta	<L410+elseplace_1+2
	clc
	lda	#$5
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L411
	inc	|~~basicvars+62+2
L411:
	jsl	~~expression
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$2
	beq	L412
	brl	L10315
L412:
	jsl	~~pop_int
	sta	<L410+result_1
	brl	L10316
L10315:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$3
	beq	L413
	brl	L10317
L413:
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
	sta	<L410+result_1
	brl	L10318
L10317:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10318:
L10316:
	stz	<R0
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	sep	#$20
	longa	off
	lda	[<R1]
	cmp	#<$df
	rep	#$20
	longa	on
	bne	L415
	brl	L414
L415:
	inc	<R0
L414:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L410+single_1
	rep	#$20
	longa	on
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$df
	rep	#$20
	longa	on
	beq	L416
	brl	L10319
L416:
	clc
	lda	#$1
	adc	|~~basicvars+62
	sta	<L410+lp2_1
	lda	#$0
	adc	|~~basicvars+62+2
	sta	<L410+lp2_1+2
	stz	<R0
	lda	[<L410+lp2_1]
	and	#$ff
	bne	L418
	brl	L417
L418:
	inc	<R0
L417:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L410+single_1
	rep	#$20
	longa	on
L10319:
	lda	<L410+single_1
	and	#$ff
	bne	L419
	brl	L10320
L419:
	sep	#$20
	longa	off
	lda	#$b4
	sta	[<L410+ifplace_1]
	rep	#$20
	longa	on
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$9f
	rep	#$20
	longa	on
	beq	L420
	brl	L10321
L420:
	clc
	lda	#$3
	adc	|~~basicvars+62
	sta	<L410+lp2_1
	lda	#$0
	adc	|~~basicvars+62+2
	sta	<L410+lp2_1+2
	pei	<L410+lp2_1+2
	pei	<L410+lp2_1
	pei	<L410+elseplace_1+2
	pei	<L410+elseplace_1
	jsl	~~set_dest
L10322:
	lda	[<L410+lp2_1]
	and	#$ff
	bne	L421
	brl	L10323
L421:
	pei	<L410+lp2_1+2
	pei	<L410+lp2_1
	jsl	~~skip_token
	sta	<L410+lp2_1
	stx	<L410+lp2_1+2
	brl	L10322
L10323:
	inc	<L410+lp2_1
	bne	L422
	inc	<L410+lp2_1+2
L422:
	ldy	#$5
	lda	[<L410+lp2_1],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L423
	dey
L423:
	sta	<R0
	sty	<R0+2
	ldy	#$4
	lda	[<L410+lp2_1],Y
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
	lda	<L410+lp2_1
	adc	<R2
	sta	<R0
	lda	<L410+lp2_1+2
	adc	<R2+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L410+thenplace_1+2
	pei	<L410+thenplace_1
	jsl	~~set_dest
	brl	L10324
L10321:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$df
	rep	#$20
	longa	on
	bne	L424
	brl	L10325
L424:
	lda	|~~basicvars+62
	sta	<L410+lp2_1
	lda	|~~basicvars+62+2
	sta	<L410+lp2_1+2
L10325:
	pei	<L410+lp2_1+2
	pei	<L410+lp2_1
	pei	<L410+thenplace_1+2
	pei	<L410+thenplace_1
	jsl	~~set_dest
L10326:
	lda	[<L410+lp2_1]
	and	#$ff
	bne	L425
	brl	L10327
L425:
	sep	#$20
	longa	off
	lda	[<L410+lp2_1]
	cmp	#<$9f
	rep	#$20
	longa	on
	bne	L426
	brl	L10327
L426:
	pei	<L410+lp2_1+2
	pei	<L410+lp2_1
	jsl	~~skip_token
	sta	<L410+lp2_1
	stx	<L410+lp2_1+2
	brl	L10326
L10327:
	sep	#$20
	longa	off
	lda	[<L410+lp2_1]
	cmp	#<$9f
	rep	#$20
	longa	on
	beq	L427
	brl	L10328
L427:
	clc
	lda	#$3
	adc	<L410+lp2_1
	sta	<L410+lp2_1
	bcc	L428
	inc	<L410+lp2_1+2
L428:
L10328:
	lda	[<L410+lp2_1]
	and	#$ff
	beq	L429
	brl	L10329
L429:
	inc	<L410+lp2_1
	bne	L430
	inc	<L410+lp2_1+2
L430:
	ldy	#$5
	lda	[<L410+lp2_1],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L431
	dey
L431:
	sta	<R0
	sty	<R0+2
	ldy	#$4
	lda	[<L410+lp2_1],Y
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
	lda	<L410+lp2_1
	adc	<R2
	sta	<L410+lp2_1
	lda	<L410+lp2_1+2
	adc	<R2+2
	sta	<L410+lp2_1+2
L10329:
	pei	<L410+lp2_1+2
	pei	<L410+lp2_1
	pei	<L410+elseplace_1+2
	pei	<L410+elseplace_1
	jsl	~~set_dest
L10324:
	brl	L10330
L10320:
depth_2	set	23
	sep	#$20
	longa	off
	lda	#$b3
	sta	[<L410+ifplace_1]
	rep	#$20
	longa	on
	clc
	lda	#$1
	adc	<L410+lp2_1
	sta	|~~basicvars+62
	lda	#$0
	adc	<L410+lp2_1+2
	sta	|~~basicvars+62+2
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	ldy	#$5
	lda	[<R1],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L432
	dey
L432:
	sta	<R0
	sty	<R0+2
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	ldy	#$4
	lda	[<R1],Y
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
	lda	|~~basicvars+62
	adc	<R2
	sta	<R0
	lda	|~~basicvars+62+2
	adc	<R2+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L410+thenplace_1+2
	pei	<L410+thenplace_1
	jsl	~~set_dest
	lda	#$1
	sta	<L410+depth_2
L10331:
	sec
	lda	#$0
	sbc	<L410+depth_2
	bvs	L433
	eor	#$8000
L433:
	bpl	L434
	brl	L10332
L434:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<R0],Y
	cmp	#<$ff
	rep	#$20
	longa	on
	beq	L435
	brl	L10333
L435:
	lda	<L410+result_1
	beq	L436
	brl	L10334
L436:
	pea	#<$2d
	pea	#4
	jsl	~~error
	brl	L10335
L10334:
	brl	L10332
L10335:
L10333:
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	ldy	#$5
	lda	[<R1],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L437
	dey
L437:
	sta	<R0
	sty	<R0+2
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	ldy	#$4
	lda	[<R1],Y
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
	lda	|~~basicvars+62
	adc	<R2
	sta	<L410+lp2_1
	lda	|~~basicvars+62+2
	adc	<R2+2
	sta	<L410+lp2_1+2
	sep	#$20
	longa	off
	lda	[<L410+lp2_1]
	cmp	#<$a5
	rep	#$20
	longa	on
	beq	L438
	brl	L10336
L438:
	dec	<L410+depth_2
	brl	L10337
L10336:
	sep	#$20
	longa	off
	lda	[<L410+lp2_1]
	cmp	#<$a1
	rep	#$20
	longa	on
	beq	L439
	brl	L10338
L439:
	lda	<L410+depth_2
	cmp	#<$1
	beq	L440
	brl	L10339
L440:
	stz	<L410+depth_2
L10339:
	brl	L10340
L10338:
	pei	<L410+lp2_1+2
	pei	<L410+lp2_1
	jsl	~~start_blockif
	and	#$ff
	bne	L441
	brl	L10341
L441:
	inc	<L410+depth_2
L10341:
L10340:
L10337:
	sec
	lda	#$0
	sbc	<L410+depth_2
	bvs	L442
	eor	#$8000
L442:
	bpl	L443
	brl	L10342
L443:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	ldy	#$2
	lda	[<R0],Y
	and	#$ff
	sta	<R0
	lda	|~~basicvars+62
	sta	<R2
	lda	|~~basicvars+62+2
	sta	<R2+2
	ldy	#$3
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
	ldy	#$0
	lda	<R2
	bpl	L444
	dey
L444:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars+62
	adc	<R0
	sta	|~~basicvars+62
	lda	|~~basicvars+62+2
	adc	<R0+2
	sta	|~~basicvars+62+2
L10342:
	brl	L10331
L10332:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<R0],Y
	cmp	#<$ff
	rep	#$20
	longa	on
	beq	L445
	brl	L10343
L445:
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	ldy	#$5
	lda	[<R1],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L446
	dey
L446:
	sta	<R0
	sty	<R0+2
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	ldy	#$4
	lda	[<R1],Y
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
	lda	|~~basicvars+62
	adc	<R2
	sta	<L410+lp2_1
	lda	|~~basicvars+62+2
	adc	<R2+2
	sta	<L410+lp2_1+2
	brl	L10344
L10343:
	sep	#$20
	longa	off
	lda	[<L410+lp2_1]
	cmp	#<$a1
	rep	#$20
	longa	on
	beq	L447
	brl	L10345
L447:
	clc
	lda	#$3
	adc	<L410+lp2_1
	sta	<L410+lp2_1
	bcc	L448
	inc	<L410+lp2_1+2
L448:
	brl	L10346
L10345:
	inc	<L410+lp2_1
	bne	L449
	inc	<L410+lp2_1+2
L449:
L10346:
	lda	[<L410+lp2_1]
	and	#$ff
	beq	L450
	brl	L10347
L450:
	inc	<L410+lp2_1
	bne	L451
	inc	<L410+lp2_1+2
L451:
	ldy	#$5
	lda	[<L410+lp2_1],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L452
	dey
L452:
	sta	<R0
	sty	<R0+2
	ldy	#$4
	lda	[<L410+lp2_1],Y
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
	lda	<L410+lp2_1
	adc	<R2
	sta	<L410+lp2_1
	lda	<L410+lp2_1+2
	adc	<R2+2
	sta	<L410+lp2_1+2
L10347:
L10344:
	pei	<L410+lp2_1+2
	pei	<L410+lp2_1
	pei	<L410+elseplace_1+2
	pei	<L410+elseplace_1
	jsl	~~set_dest
L10330:
	lda	<L410+result_1
	bne	L453
	brl	L10348
L453:
	lda	[<L410+thenplace_1]
	and	#$ff
	sta	<R0
	ldy	#$1
	lda	[<L410+thenplace_1],Y
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
	bpl	L454
	dey
L454:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L410+thenplace_1
	adc	<R0
	sta	<L410+dest_1
	lda	<L410+thenplace_1+2
	adc	<R0+2
	sta	<L410+dest_1+2
	brl	L10349
L10348:
	lda	[<L410+elseplace_1]
	and	#$ff
	sta	<R0
	ldy	#$1
	lda	[<L410+elseplace_1],Y
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
	bpl	L455
	dey
L455:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L410+elseplace_1
	adc	<R0
	sta	<L410+dest_1
	lda	<L410+elseplace_1+2
	adc	<R0+2
	sta	<L410+dest_1+2
L10349:
	lda	<L410+single_1
	and	#$ff
	bne	L456
	brl	L10350
L456:
	sep	#$20
	longa	off
	lda	[<L410+dest_1]
	cmp	#<$1e
	rep	#$20
	longa	on
	beq	L457
	brl	L10351
L457:
	pei	<L410+dest_1+2
	pei	<L410+dest_1
	jsl	~~set_linedest
	sta	<L410+dest_1
	stx	<L410+dest_1+2
	brl	L10352
L10351:
	sep	#$20
	longa	off
	lda	[<L410+dest_1]
	cmp	#<$1f
	rep	#$20
	longa	on
	beq	L458
	brl	L10353
L458:
	ldy	#$1
	lda	[<L410+dest_1],Y
	and	#$ff
	sta	<R0
	ldy	#$2
	lda	[<L410+dest_1],Y
	and	#$ff
	sta	<R2
	lda	<R2
	xba
	and	#$ff00
	sta	<R1
	lda	<R1
	ora	<R0
	sta	<R2
	ldy	#$3
	lda	[<L410+dest_1],Y
	and	#$ff
	ldx	#<$10
	xref	~~~asl
	jsl	~~~asl
	sta	<R0
	lda	<R0
	ora	<R2
	sta	<R1
	ldy	#$4
	lda	[<L410+dest_1],Y
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
	bpl	L459
	dey
L459:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars
	adc	<R0
	sta	<L410+dest_1
	lda	|~~basicvars+2
	adc	<R0+2
	sta	<L410+dest_1+2
L10353:
L10352:
L10350:
	lda	|~~basicvars+425
	bit	#$2
	bne	L460
	brl	L10354
L460:
destline_3	set	23
	pei	<L410+dest_1+2
	pei	<L410+dest_1
	jsl	~~find_linestart
	sta	<R0
	stx	<R0+2
	phx
	pha
	jsl	~~get_lineno
	sta	<L410+destline_3
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~get_lineno
	sta	<R0
	lda	<R0
	cmp	<L410+destline_3
	bne	L461
	brl	L10355
L461:
	pei	<L410+destline_3
	jsl	~~trace_line
L10355:
L10354:
	lda	|~~basicvars+425
	bit	#$10
	bne	L462
	brl	L10356
L462:
	pei	<L410+dest_1+2
	pei	<L410+dest_1
	pei	<L410+ifplace_1+2
	pei	<L410+ifplace_1
	jsl	~~trace_branch
L10356:
	lda	<L410+dest_1
	sta	|~~basicvars+62
	lda	<L410+dest_1+2
	sta	|~~basicvars+62+2
L463:
	pld
	tsc
	clc
	adc	#L409
	tcs
	rtl
L409	equ	37
L410	equ	13
	ends
	efunc
	code
	xdef	~~exec_library
	func
~~exec_library:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L464
	tcs
	phd
	tcd
stringtype_1	set	0
name_1	set	2
libname_1	set	8
	inc	|~~basicvars+62
	bne	L466
	inc	|~~basicvars+62+2
L466:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$b9
	rep	#$20
	longa	on
	beq	L467
	brl	L10357
L467:
	pea	#<$6c
	pea	#4
	jsl	~~error
L10357:
L10360:
	jsl	~~expression
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L465+stringtype_1
	lda	<L465+stringtype_1
	cmp	#<$4
	bne	L468
	brl	L10361
L468:
	lda	<L465+stringtype_1
	cmp	#<$5
	bne	L469
	brl	L10361
L469:
	pea	#<$40
	pea	#4
	jsl	~~error
L10361:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L465+name_1
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
	sbc	<L465+name_1
	bvs	L470
	eor	#$8000
L470:
	bpl	L471
	brl	L10362
L471:
	pei	<L465+name_1
	pei	<L465+name_1+4
	pei	<L465+name_1+2
	jsl	~~tocstring
	sta	<L465+libname_1
	stx	<L465+libname_1+2
	lda	<L465+stringtype_1
	cmp	#<$5
	beq	L472
	brl	L10363
L472:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L465+name_1
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
	pea	#<$1
	pei	<L465+libname_1+2
	pei	<L465+libname_1
	jsl	~~read_library
L10362:
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
	beq	L473
	brl	L10359
L473:
	inc	|~~basicvars+62
	bne	L474
	inc	|~~basicvars+62+2
L474:
L10358:
	brl	L10360
L10359:
	jsl	~~check_ateol
L475:
	pld
	tsc
	clc
	adc	#L464
	tcs
	rtl
L464	equ	20
L465	equ	9
	ends
	efunc
	code
	func
~~def_locvar:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L476
	tcs
	phd
	tcd
descriptor_1	set	0
locvar_1	set	6
	lda	|~~basicvars+399
	ora	|~~basicvars+399+2
	beq	L478
	brl	L10364
L478:
	pea	#<$57
	pea	#4
	jsl	~~error
L10364:
	lda	#$80
	tsb	~~basicvars+423
L10367:
	pea	#0
	clc
	tdc
	adc	#<L477+locvar_1
	pha
	jsl	~~get_lvalue
	lda	<L477+locvar_1
	brl	L10368
L10370:
	lda	[<L477+locvar_1+2]
	pha
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L477+locvar_1
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
	jsl	~~save_int
	lda	#$0
	sta	[<L477+locvar_1+2]
	brl	L10369
L10371:
	ldy	#$2
	lda	[<L477+locvar_1+2],Y
	pha
	lda	[<L477+locvar_1+2]
	pha
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L477+locvar_1
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
	jsl	~~save_float
	lda	#$0
	sta	[<L477+locvar_1+2]
	lda	#$0
	ldy	#$2
	sta	[<L477+locvar_1+2],Y
	brl	L10369
L10372:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	pei	<L477+locvar_1+4
	pei	<L477+locvar_1+2
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
	adc	#<L477+locvar_1
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
	jsl	~~save_string
	lda	#$0
	sta	[<L477+locvar_1+2]
	lda	|~~nullstring
	ldy	#$2
	sta	[<L477+locvar_1+2],Y
	lda	|~~nullstring+2
	ldy	#$4
	sta	[<L477+locvar_1+2],Y
	brl	L10369
L10373:
	pea	#<$1
	pei	<L477+locvar_1+2
	jsl	~~check_write
	lda	|~~basicvars+6
	sta	<R0
	lda	|~~basicvars+6+2
	sta	<R0+2
	ldy	<L477+locvar_1+2
	lda	[<R0],Y
	and	#$ff
	pha
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L477+locvar_1
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
	jsl	~~save_int
	lda	|~~basicvars+6
	sta	<R0
	lda	|~~basicvars+6+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$0
	ldy	<L477+locvar_1+2
	sta	[<R0],Y
	rep	#$20
	longa	on
	brl	L10369
L10374:
	pei	<L477+locvar_1+2
	jsl	~~get_integer
	pha
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L477+locvar_1
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
	jsl	~~save_int
	pea	#<$0
	pei	<L477+locvar_1+2
	jsl	~~store_integer
	brl	L10369
L10375:
	phy
	phy
	pei	<L477+locvar_1+2
	jsl	~~get_float
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L477+locvar_1
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
	jsl	~~save_float
	pea	#$0000
	pea	#$0000
	pei	<L477+locvar_1+2
	jsl	~~store_float
	brl	L10369
L10376:
	pea	#<$1
	pei	<L477+locvar_1+2
	jsl	~~check_write
	pei	<L477+locvar_1+2
	jsl	~~get_stringlen
	sta	<R0
	lda	<R0
	ina
	sta	<L477+descriptor_1
	pei	<L477+descriptor_1
	jsl	~~alloc_string
	sta	<L477+descriptor_1+2
	stx	<L477+descriptor_1+4
	ldy	#$0
	lda	<L477+descriptor_1
	bpl	L479
	dey
L479:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	ldy	#$0
	lda	<L477+locvar_1+2
	bpl	L480
	dey
L480:
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
	pei	<L477+descriptor_1+4
	pei	<L477+descriptor_1+2
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
	adc	#<L477+descriptor_1
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
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L477+locvar_1
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
	jsl	~~save_string
	lda	|~~basicvars+6
	sta	<R0
	lda	|~~basicvars+6+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$d
	ldy	<L477+locvar_1+2
	sta	[<R0],Y
	rep	#$20
	longa	on
	brl	L10369
L10377:
L10378:
L10379:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L477+locvar_1
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
	jsl	~~save_array
	lda	#$0
	sta	[<L477+locvar_1+2]
	lda	#$0
	ldy	#$2
	sta	[<L477+locvar_1+2],Y
	brl	L10369
L10380:
	pea	#^L336
	pea	#<L336
	pea	#<$4f7
	pea	#<$82
	pea	#10
	jsl	~~error
	brl	L10369
L10368:
	xref	~~~fsw
	jsl	~~~fsw
	dw	2
	dw	20
	dw	L10380-1
	dw	L10370-1
	dw	L10371-1
	dw	L10372-1
	dw	L10380-1
	dw	L10380-1
	dw	L10380-1
	dw	L10380-1
	dw	L10380-1
	dw	L10377-1
	dw	L10378-1
	dw	L10379-1
	dw	L10380-1
	dw	L10380-1
	dw	L10380-1
	dw	L10380-1
	dw	L10373-1
	dw	L10374-1
	dw	L10375-1
	dw	L10380-1
	dw	L10376-1
L10369:
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
	beq	L481
	brl	L10366
L481:
	inc	|~~basicvars+62
	bne	L482
	inc	|~~basicvars+62+2
L482:
L10365:
	brl	L10367
L10366:
	lda	#$80
	trb	~~basicvars+423
	jsl	~~check_ateol
L483:
	pld
	tsc
	clc
	adc	#L476
	tcs
	rtl
L476	equ	24
L477	equ	13
	ends
	efunc
	data
L336:
	db	$6D,$61,$69,$6E,$73,$74,$61,$74,$65,$00
	ends
	code
	xdef	~~exec_local
	func
~~exec_local:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L485
	tcs
	phd
	tcd
	inc	|~~basicvars+62
	bne	L487
	inc	|~~basicvars+62+2
L487:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	brl	L10381
L10383:
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~skip_token
	sta	|~~basicvars+62
	stx	|~~basicvars+62+2
	jsl	~~check_ateol
	sec
	tsc
	sbc	#9
	tcs
	ina
	sta	<R0
	stz	<R0+2
	pea	#<~~basicvars+232
	pei	<R0+2
	pei	<R0
	lda	#$9
	xref	~~~nfmov
	jsl	~~~nfmov
	jsl	~~push_error
	brl	L10382
L10384:
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~skip_token
	sta	|~~basicvars+62
	stx	|~~basicvars+62+2
	jsl	~~check_ateol
	lda	|~~basicvars+407+2
	pha
	lda	|~~basicvars+407
	pha
	jsl	~~push_data
	brl	L10382
L10385:
	jsl	~~def_locvar
	brl	L10382
L10381:
	xref	~~~swt
	jsl	~~~swt
	dw	2
	dw	153
	dw	L10384-1
	dw	169
	dw	L10383-1
	dw	L10385-1
L10382:
L488:
	pld
	tsc
	clc
	adc	#L485
	tcs
	rtl
L485	equ	4
L486	equ	5
	ends
	efunc
	code
	xdef	~~exec_next
	func
~~exec_next:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L489
	tcs
	phd
	tcd
	udata
L10386:
	ds	4
	ends
fp_1	set	0
nextvar_1	set	4
contloop_1	set	10
intvalue_1	set	11
	lda	|~~basicvars+489
	and	#$ff
	bne	L491
	brl	L10387
L491:
	pea	#<$8
	pea	#4
	jsl	~~error
L10387:
L10390:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$15
	bne	L493
	brl	L492
L493:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$16
	beq	L494
	brl	L10391
L494:
L492:
	lda	|~~basicvars+42
	sta	<L490+fp_1
	lda	|~~basicvars+42+2
	sta	<L490+fp_1+2
	brl	L10392
L10391:
	jsl	~~get_for
	sta	<L490+fp_1
	stx	<L490+fp_1+2
L10392:
	lda	<L490+fp_1
	ora	<L490+fp_1+2
	beq	L495
	brl	L10393
L495:
	pea	#<$35
	pea	#4
	jsl	~~error
L10393:
	inc	|~~basicvars+62
	bne	L496
	inc	|~~basicvars+62+2
L496:
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
	beq	L497
	brl	L10394
L497:
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
	brl	L10395
L498:
	pea	#0
	clc
	tdc
	adc	#<L490+nextvar_1
	pha
	jsl	~~get_lvalue
	lda	<L490+nextvar_1+2
	ldy	#$5
	cmp	[<L490+fp_1],Y
	bne	L499
	lda	<L490+nextvar_1+4
	ldy	#$7
	cmp	[<L490+fp_1],Y
L499:
	bne	L500
	brl	L10396
L500:
	pea	#<$36
	pea	#4
	jsl	~~error
L10396:
L10395:
L10394:
	ldy	#$2
	lda	[<L490+fp_1],Y
	and	#$ff
	bne	L501
	brl	L10397
L501:
	ldy	#$5
	lda	[<L490+fp_1],Y
	sta	<R0
	ldy	#$7
	lda	[<L490+fp_1],Y
	sta	<R0+2
	lda	[<R0]
	ina
	sta	[<R0]
	lda	[<R0]
	sta	<L490+intvalue_1
	sec
	ldy	#$d
	lda	[<L490+fp_1],Y
	sbc	<L490+intvalue_1
	bvs	L502
	eor	#$8000
L502:
	bmi	L503
	brl	L10398
L503:
	lda	|~~basicvars+425
	bit	#$10
	bne	L504
	brl	L10399
L504:
	ldy	#$b
	lda	[<L490+fp_1],Y
	pha
	ldy	#$9
	lda	[<L490+fp_1],Y
	pha
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~trace_branch
L10399:
	ldy	#$9
	lda	[<L490+fp_1],Y
	sta	|~~basicvars+62
	ldy	#$b
	lda	[<L490+fp_1],Y
	sta	|~~basicvars+62+2
L505:
	pld
	tsc
	clc
	adc	#L489
	tcs
	rtl
L10398:
	sep	#$20
	longa	off
	stz	<L490+contloop_1
	rep	#$20
	longa	on
	brl	L10400
L10397:
	ldy	#$3
	lda	[<L490+fp_1],Y
	brl	L10401
L10403:
	ldy	#$5
	lda	[<L490+fp_1],Y
	sta	<R0
	ldy	#$7
	lda	[<L490+fp_1],Y
	sta	<R0+2
	clc
	lda	[<R0]
	ldy	#$f
	adc	[<L490+fp_1],Y
	sta	<L490+intvalue_1
	ldy	#$5
	lda	[<L490+fp_1],Y
	sta	<R0
	ldy	#$7
	lda	[<L490+fp_1],Y
	sta	<R0+2
	lda	<L490+intvalue_1
	sta	[<R0]
	sec
	lda	#$0
	ldy	#$f
	sbc	[<L490+fp_1],Y
	bvs	L506
	eor	#$8000
L506:
	bpl	L507
	brl	L10404
L507:
	stz	<R0
	sec
	ldy	#$d
	lda	[<L490+fp_1],Y
	sbc	<L490+intvalue_1
	bvs	L509
	eor	#$8000
L509:
	bmi	L510
	brl	L508
L510:
	inc	<R0
L508:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L490+contloop_1
	rep	#$20
	longa	on
	brl	L10405
L10404:
	stz	<R0
	sec
	lda	<L490+intvalue_1
	ldy	#$d
	sbc	[<L490+fp_1],Y
	bvs	L512
	eor	#$8000
L512:
	bmi	L513
	brl	L511
L513:
	inc	<R0
L511:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L490+contloop_1
	rep	#$20
	longa	on
L10405:
	brl	L10402
L10406:
	ldy	#$13
	lda	[<L490+fp_1],Y
	pha
	ldy	#$11
	lda	[<L490+fp_1],Y
	pha
	ldy	#$5
	lda	[<L490+fp_1],Y
	sta	<R0
	ldy	#$7
	lda	[<L490+fp_1],Y
	sta	<R0+2
	ldy	#$2
	lda	[<R0],Y
	pha
	lda	[<R0]
	pha
	xref	~~~fadc
	jsl	~~~fadc
	pla
	sta	|L10386
	pla
	sta	|L10386+2
	ldy	#$5
	lda	[<L490+fp_1],Y
	sta	<R0
	ldy	#$7
	lda	[<L490+fp_1],Y
	sta	<R0+2
	lda	|L10386
	sta	[<R0]
	lda	|L10386+2
	ldy	#$2
	sta	[<R0],Y
	ldy	#$13
	lda	[<L490+fp_1],Y
	pha
	ldy	#$11
	lda	[<L490+fp_1],Y
	pha
	pea	#$0000
	pea	#$0000
	xref	~~~fcmp
	jsl	~~~fcmp
	bmi	L514
	brl	L10407
L514:
	stz	<R0
	lda	|L10386+2
	pha
	lda	|L10386
	pha
	ldy	#$f
	lda	[<L490+fp_1],Y
	pha
	ldy	#$d
	lda	[<L490+fp_1],Y
	pha
	xref	~~~fcmp
	jsl	~~~fcmp
	bpl	L516
	brl	L515
L516:
	inc	<R0
L515:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L490+contloop_1
	rep	#$20
	longa	on
	brl	L10408
L10407:
	stz	<R0
	ldy	#$f
	lda	[<L490+fp_1],Y
	pha
	ldy	#$d
	lda	[<L490+fp_1],Y
	pha
	lda	|L10386+2
	pha
	lda	|L10386
	pha
	xref	~~~fcmp
	jsl	~~~fcmp
	bpl	L518
	brl	L517
L518:
	inc	<R0
L517:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L490+contloop_1
	rep	#$20
	longa	on
L10408:
	brl	L10402
L10409:
	ldy	#$5
	lda	[<L490+fp_1],Y
	sta	<R0
	lda	|~~basicvars+6
	sta	<R1
	lda	|~~basicvars+6+2
	sta	<R1+2
	ldy	<R0
	lda	[<R1],Y
	and	#$ff
	sta	<R1
	clc
	lda	<R1
	ldy	#$f
	adc	[<L490+fp_1],Y
	sta	<L490+intvalue_1
	ldy	#$5
	lda	[<L490+fp_1],Y
	sta	<R0
	lda	|~~basicvars+6
	sta	<R1
	lda	|~~basicvars+6+2
	sta	<R1+2
	sep	#$20
	longa	off
	lda	<L490+intvalue_1
	ldy	<R0
	sta	[<R1],Y
	rep	#$20
	longa	on
	sec
	lda	#$0
	ldy	#$f
	sbc	[<L490+fp_1],Y
	bvs	L519
	eor	#$8000
L519:
	bpl	L520
	brl	L10410
L520:
	stz	<R0
	sec
	ldy	#$d
	lda	[<L490+fp_1],Y
	sbc	<L490+intvalue_1
	bvs	L522
	eor	#$8000
L522:
	bmi	L523
	brl	L521
L523:
	inc	<R0
L521:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L490+contloop_1
	rep	#$20
	longa	on
	brl	L10411
L10410:
	stz	<R0
	sec
	lda	<L490+intvalue_1
	ldy	#$d
	sbc	[<L490+fp_1],Y
	bvs	L525
	eor	#$8000
L525:
	bmi	L526
	brl	L524
L526:
	inc	<R0
L524:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L490+contloop_1
	rep	#$20
	longa	on
L10411:
	brl	L10402
L10412:
	ldy	#$5
	lda	[<L490+fp_1],Y
	pha
	jsl	~~get_integer
	sta	<R0
	clc
	lda	<R0
	ldy	#$f
	adc	[<L490+fp_1],Y
	sta	<L490+intvalue_1
	pei	<L490+intvalue_1
	ldy	#$5
	lda	[<L490+fp_1],Y
	pha
	jsl	~~store_integer
	sec
	lda	#$0
	ldy	#$f
	sbc	[<L490+fp_1],Y
	bvs	L527
	eor	#$8000
L527:
	bpl	L528
	brl	L10413
L528:
	stz	<R0
	sec
	ldy	#$d
	lda	[<L490+fp_1],Y
	sbc	<L490+intvalue_1
	bvs	L530
	eor	#$8000
L530:
	bmi	L531
	brl	L529
L531:
	inc	<R0
L529:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L490+contloop_1
	rep	#$20
	longa	on
	brl	L10414
L10413:
	stz	<R0
	sec
	lda	<L490+intvalue_1
	ldy	#$d
	sbc	[<L490+fp_1],Y
	bvs	L533
	eor	#$8000
L533:
	bmi	L534
	brl	L532
L534:
	inc	<R0
L532:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L490+contloop_1
	rep	#$20
	longa	on
L10414:
	brl	L10402
L10415:
	ldy	#$13
	lda	[<L490+fp_1],Y
	pha
	ldy	#$11
	lda	[<L490+fp_1],Y
	pha
	phy
	phy
	ldy	#$5
	lda	[<L490+fp_1],Y
	pha
	jsl	~~get_float
	xref	~~~fadc
	jsl	~~~fadc
	pla
	sta	|L10386
	pla
	sta	|L10386+2
	lda	|L10386+2
	pha
	lda	|L10386
	pha
	ldy	#$5
	lda	[<L490+fp_1],Y
	pha
	jsl	~~store_float
	ldy	#$13
	lda	[<L490+fp_1],Y
	pha
	ldy	#$11
	lda	[<L490+fp_1],Y
	pha
	pea	#$0000
	pea	#$0000
	xref	~~~fcmp
	jsl	~~~fcmp
	bmi	L535
	brl	L10416
L535:
	stz	<R0
	lda	|L10386+2
	pha
	lda	|L10386
	pha
	ldy	#$f
	lda	[<L490+fp_1],Y
	pha
	ldy	#$d
	lda	[<L490+fp_1],Y
	pha
	xref	~~~fcmp
	jsl	~~~fcmp
	bpl	L537
	brl	L536
L537:
	inc	<R0
L536:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L490+contloop_1
	rep	#$20
	longa	on
	brl	L10417
L10416:
	stz	<R0
	ldy	#$f
	lda	[<L490+fp_1],Y
	pha
	ldy	#$d
	lda	[<L490+fp_1],Y
	pha
	lda	|L10386+2
	pha
	lda	|L10386
	pha
	xref	~~~fcmp
	jsl	~~~fcmp
	bpl	L539
	brl	L538
L539:
	inc	<R0
L538:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L490+contloop_1
	rep	#$20
	longa	on
L10417:
	brl	L10402
L10418:
	pea	#^L484
	pea	#<L484
	pea	#<$56c
	pea	#<$82
	pea	#10
	jsl	~~error
	brl	L10402
L10401:
	xref	~~~swt
	jsl	~~~swt
	dw	5
	dw	2
	dw	L10403-1
	dw	3
	dw	L10406-1
	dw	17
	dw	L10409-1
	dw	18
	dw	L10412-1
	dw	19
	dw	L10415-1
	dw	L10418-1
L10402:
L10400:
	lda	<L490+contloop_1
	and	#$ff
	bne	L540
	brl	L10419
L540:
	lda	|~~basicvars+425
	bit	#$10
	bne	L541
	brl	L10420
L541:
	ldy	#$b
	lda	[<L490+fp_1],Y
	pha
	ldy	#$9
	lda	[<L490+fp_1],Y
	pha
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~trace_branch
L10420:
	ldy	#$9
	lda	[<L490+fp_1],Y
	sta	|~~basicvars+62
	ldy	#$b
	lda	[<L490+fp_1],Y
	sta	|~~basicvars+62+2
	brl	L505
L10419:
	jsl	~~pop_for
L10388:
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
	bne	L542
	brl	L10390
L542:
L10389:
	jsl	~~check_ateol
	brl	L505
L489	equ	21
L490	equ	9
	ends
	efunc
	data
L484:
	db	$6D,$61,$69,$6E,$73,$74,$61,$74,$65,$00
	ends
	code
	func
~~exec_onerror:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L544
	tcs
	phd
	tcd
	inc	|~~basicvars+62
	bne	L546
	inc	|~~basicvars+62+2
L546:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	brl	L10421
L10423:
	jsl	~~clear_error
	inc	|~~basicvars+62
	bne	L547
	inc	|~~basicvars+62+2
L547:
	jsl	~~check_ateol
	brl	L10422
L10424:
	inc	|~~basicvars+62
	bne	L548
	inc	|~~basicvars+62+2
L548:
	jsl	~~set_local_error
L10425:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	bne	L549
	brl	L10426
L549:
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~skip_token
	sta	|~~basicvars+62
	stx	|~~basicvars+62+2
	brl	L10425
L10426:
	brl	L10422
L10427:
	jsl	~~set_error
L10428:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	bne	L550
	brl	L10429
L550:
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~skip_token
	sta	|~~basicvars+62
	stx	|~~basicvars+62+2
	brl	L10428
L10429:
	brl	L10422
L10421:
	xref	~~~swt
	jsl	~~~swt
	dw	2
	dw	185
	dw	L10424-1
	dw	193
	dw	L10423-1
	dw	L10427-1
L10422:
L551:
	pld
	tsc
	clc
	adc	#L544
	tcs
	rtl
L544	equ	4
L545	equ	5
	ends
	efunc
	code
	func
~~find_else:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L552
	tcs
	phd
	tcd
tp_0	set	4
index_0	set	8
L10430:
	lda	[<L552+tp_0]
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	beq	L554
	brl	L10431
L554:
	pei	<L552+tp_0+2
	pei	<L552+tp_0
	jsl	~~skip_token
	sta	<L552+tp_0
	stx	<L552+tp_0+2
	brl	L10430
L10431:
	sep	#$20
	longa	off
	lda	[<L552+tp_0]
	cmp	#<$9f
	rep	#$20
	longa	on
	beq	L555
	brl	L10432
L555:
	lda	|~~basicvars+425
	bit	#$10
	bne	L556
	brl	L10433
L556:
	pei	<L552+tp_0+2
	pei	<L552+tp_0
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~trace_branch
L10433:
	clc
	lda	#$3
	adc	<L552+tp_0
	sta	|~~basicvars+62
	lda	#$0
	adc	<L552+tp_0+2
	sta	|~~basicvars+62+2
	brl	L10434
L10432:
	pei	<L552+index_0
	pea	#<$3b
	pea	#6
	jsl	~~error
L10434:
L557:
	lda	<L552+2
	sta	<L552+2+6
	lda	<L552+1
	sta	<L552+1+6
	pld
	tsc
	clc
	adc	#L552+6
	tcs
	rtl
L552	equ	4
L553	equ	5
	ends
	efunc
	code
	func
~~find_onentry:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L558
	tcs
	phd
	tcd
tp_0	set	4
wanted_0	set	8
brackets_1	set	0
count_1	set	2
	lda	#$1
	sta	<L559+count_1
	stz	<L559+brackets_1
L10437:
L10438:
	sep	#$20
	longa	off
	lda	[<L558+tp_0]
	cmp	#<$3a
	rep	#$20
	longa	on
	bne	L560
	brl	L10439
L560:
	lda	[<L558+tp_0]
	and	#$ff
	bne	L561
	brl	L10439
L561:
	sep	#$20
	longa	off
	lda	[<L558+tp_0]
	cmp	#<$9f
	rep	#$20
	longa	on
	bne	L562
	brl	L10439
L562:
	sep	#$20
	longa	off
	lda	[<L558+tp_0]
	cmp	#<$2c
	rep	#$20
	longa	on
	beq	L564
	brl	L563
L564:
	lda	<L559+brackets_1
	bne	L565
	brl	L10439
L565:
L563:
	pei	<L558+tp_0+2
	pei	<L558+tp_0
	jsl	~~skip_token
	sta	<L558+tp_0
	stx	<L558+tp_0+2
	sep	#$20
	longa	off
	lda	[<L558+tp_0]
	cmp	#<$28
	rep	#$20
	longa	on
	beq	L566
	brl	L10440
L566:
	inc	<L559+brackets_1
	brl	L10441
L10440:
	sep	#$20
	longa	off
	lda	[<L558+tp_0]
	cmp	#<$29
	rep	#$20
	longa	on
	beq	L567
	brl	L10442
L567:
	dec	<L559+brackets_1
L10442:
L10441:
	brl	L10438
L10439:
	sep	#$20
	longa	off
	lda	[<L558+tp_0]
	cmp	#<$9f
	rep	#$20
	longa	on
	bne	L568
	brl	L10436
L568:
	lda	[<L558+tp_0]
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	bne	L569
	brl	L10443
L569:
	pei	<L558+wanted_0
	pea	#<$3b
	pea	#6
	jsl	~~error
L10443:
	inc	<L559+count_1
	lda	<L559+count_1
	cmp	<L558+wanted_0
	bne	L570
	brl	L10436
L570:
	sep	#$20
	longa	off
	lda	[<L558+tp_0]
	cmp	#<$2c
	rep	#$20
	longa	on
	bne	L571
	brl	L10444
L571:
	pea	#<$27
	pea	#4
	jsl	~~error
L10444:
	inc	<L558+tp_0
	bne	L572
	inc	<L558+tp_0+2
L572:
L10435:
	brl	L10437
L10436:
	sep	#$20
	longa	off
	lda	[<L558+tp_0]
	cmp	#<$2c
	rep	#$20
	longa	on
	beq	L573
	brl	L10445
L573:
	inc	<L558+tp_0
	bne	L574
	inc	<L558+tp_0+2
L574:
L10445:
	ldx	<L558+tp_0+2
	lda	<L558+tp_0
L575:
	tay
	lda	<L558+2
	sta	<L558+2+6
	lda	<L558+1
	sta	<L558+1+6
	pld
	tsc
	clc
	adc	#L558+6
	tcs
	tya
	rtl
L558	equ	8
L559	equ	5
	ends
	efunc
	code
	func
~~exec_onbranch:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L576
	tcs
	phd
	tcd
index_1	set	0
onwhat_1	set	2
	jsl	~~eval_integer
	sta	<L577+index_1
	lda	<L577+index_1
	bmi	L578
	dea
	bmi	L578
	brl	L10446
L578:
	pei	<L577+index_1
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~find_else
	brl	L10447
L10446:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	sta	<L577+onwhat_1
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	lda	<L577+onwhat_1
	cmp	#<$b1
	rep	#$20
	longa	on
	bne	L580
	brl	L579
L580:
	sep	#$20
	longa	off
	lda	<L577+onwhat_1
	cmp	#<$b0
	rep	#$20
	longa	on
	beq	L581
	brl	L10448
L581:
L579:
line_2	set	3
dest_2	set	5
	inc	|~~basicvars+62
	bne	L582
	inc	|~~basicvars+62+2
L582:
	sec
	lda	#$1
	sbc	<L577+index_1
	bvs	L583
	eor	#$8000
L583:
	bpl	L584
	brl	L10449
L584:
	pei	<L577+index_1
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~find_onentry
	sta	|~~basicvars+62
	stx	|~~basicvars+62+2
L10449:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$9f
	rep	#$20
	longa	on
	beq	L585
	brl	L10450
L585:
	clc
	lda	#$3
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L586
	inc	|~~basicvars+62+2
L586:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$1e
	rep	#$20
	longa	on
	beq	L587
	brl	L10451
L587:
	pea	#<$5
	pea	#4
	jsl	~~error
L10451:
	brl	L10452
L10450:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$1f
	rep	#$20
	longa	on
	beq	L588
	brl	L10453
L588:
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
	bpl	L589
	dey
L589:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars
	adc	<R0
	sta	<L577+dest_2
	lda	|~~basicvars+2
	adc	<R0+2
	sta	<L577+dest_2+2
	brl	L10454
L10453:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$1e
	rep	#$20
	longa	on
	beq	L590
	brl	L10455
L590:
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~set_linedest
	sta	<L577+dest_2
	stx	<L577+dest_2+2
	brl	L10456
L10455:
	jsl	~~eval_integer
	sta	<L577+line_2
	lda	<L577+line_2
	bpl	L592
	brl	L591
L592:
	ldy	#$0
	lda	<L577+line_2
	bpl	L593
	dey
L593:
	sta	<R0
	sty	<R0+2
	sec
	lda	#$feff
	sbc	<R0
	lda	#$0
	sbc	<R0+2
	bvs	L594
	eor	#$8000
L594:
	bpl	L595
	brl	L10457
L595:
L591:
	pea	#<$b
	pea	#4
	jsl	~~error
L10457:
	pei	<L577+line_2
	jsl	~~find_line
	sta	<L577+dest_2
	stx	<L577+dest_2+2
	pei	<L577+dest_2+2
	pei	<L577+dest_2
	jsl	~~get_lineno
	sta	<R0
	lda	<R0
	cmp	<L577+line_2
	bne	L596
	brl	L10458
L596:
	pei	<L577+line_2
	pea	#<$c
	pea	#6
	jsl	~~error
L10458:
	ldy	#$5
	lda	[<L577+dest_2],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L597
	dey
L597:
	sta	<R0
	sty	<R0+2
	ldy	#$4
	lda	[<L577+dest_2],Y
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
	lda	<L577+dest_2
	adc	<R2
	sta	<L577+dest_2
	lda	<L577+dest_2+2
	adc	<R2+2
	sta	<L577+dest_2+2
L10456:
L10454:
	lda	|~~basicvars+425
	bit	#$10
	bne	L598
	brl	L10459
L598:
	pei	<L577+dest_2+2
	pei	<L577+dest_2
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~trace_branch
L10459:
	sep	#$20
	longa	off
	lda	<L577+onwhat_1
	cmp	#<$b0
	rep	#$20
	longa	on
	beq	L599
	brl	L10460
L599:
L10461:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$3a
	rep	#$20
	longa	on
	bne	L600
	brl	L10462
L600:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	bne	L601
	brl	L10462
L601:
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~skip_token
	sta	|~~basicvars+62
	stx	|~~basicvars+62+2
	brl	L10461
L10462:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$3a
	rep	#$20
	longa	on
	beq	L602
	brl	L10463
L602:
	inc	|~~basicvars+62
	bne	L603
	inc	|~~basicvars+62+2
L603:
L10463:
	jsl	~~push_gosub
L10460:
	lda	<L577+dest_2
	sta	|~~basicvars+62
	lda	<L577+dest_2+2
	sta	|~~basicvars+62+2
L10452:
	brl	L10464
L10448:
	sep	#$20
	longa	off
	lda	<L577+onwhat_1
	cmp	#<$c
	rep	#$20
	longa	on
	bne	L605
	brl	L604
L605:
	sep	#$20
	longa	off
	lda	<L577+onwhat_1
	cmp	#<$d
	rep	#$20
	longa	on
	beq	L606
	brl	L10465
L606:
L604:
base_3	set	3
dp_3	set	7
pp_3	set	11
	sec
	lda	#$1
	sbc	<L577+index_1
	bvs	L607
	eor	#$8000
L607:
	bpl	L608
	brl	L10466
L608:
	pei	<L577+index_1
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~find_onentry
	sta	|~~basicvars+62
	stx	|~~basicvars+62+2
L10466:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$9f
	rep	#$20
	longa	on
	beq	L609
	brl	L10467
L609:
	clc
	lda	#$3
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L610
	inc	|~~basicvars+62+2
L610:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$1e
	rep	#$20
	longa	on
	beq	L611
	brl	L10468
L611:
	pea	#<$5
	pea	#4
	jsl	~~error
L10468:
	brl	L10469
L10467:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$c
	rep	#$20
	longa	on
	beq	L612
	brl	L10470
L612:
ep_4	set	15
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~get_srcaddr
	sta	<L577+base_3
	stx	<L577+base_3+2
	pei	<L577+base_3+2
	pei	<L577+base_3
	jsl	~~skip_name
	sta	<L577+ep_4
	stx	<L577+ep_4+2
	clc
	lda	#$ffff
	adc	<L577+ep_4
	sta	<R0
	lda	#$ffff
	adc	<L577+ep_4+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$28
	rep	#$20
	longa	on
	beq	L613
	brl	L10471
L613:
	lda	<L577+ep_4
	bne	L614
	dec	<L577+ep_4+2
L614:
	dec	<L577+ep_4
L10471:
	sec
	lda	<L577+ep_4
	sbc	<L577+base_3
	sta	<R0
	lda	<L577+ep_4+2
	sbc	<L577+base_3+2
	sta	<R0+2
	pei	<R0
	pei	<L577+base_3+2
	pei	<L577+base_3
	jsl	~~find_fnproc
	sta	<L577+pp_3
	stx	<L577+pp_3+2
	ldy	#$10
	lda	[<L577+pp_3],Y
	sta	<L577+dp_3
	ldy	#$12
	lda	[<L577+pp_3],Y
	sta	<L577+dp_3+2
	pei	<L577+pp_3+2
	pei	<L577+pp_3
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~set_address
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$d
	sta	[<R0]
	rep	#$20
	longa	on
	clc
	lda	#$5
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L615
	inc	|~~basicvars+62+2
L615:
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
	bne	L616
	brl	L10472
L616:
	ldy	#$7
	lda	[<L577+dp_3],Y
	ldy	#$9
	ora	[<L577+dp_3],Y
	bne	L617
	brl	L10473
L617:
	ldy	#$8
	lda	[<L577+pp_3],Y
	pha
	ldy	#$6
	lda	[<L577+pp_3],Y
	pha
	pea	#<$12
	pea	#8
	jsl	~~error
L10473:
	brl	L10474
L10472:
	ldy	#$7
	lda	[<L577+dp_3],Y
	ldy	#$9
	ora	[<L577+dp_3],Y
	beq	L618
	brl	L10475
L618:
	ldy	#$8
	lda	[<L577+pp_3],Y
	pha
	ldy	#$6
	lda	[<L577+pp_3],Y
	pha
	pea	#<$11
	pea	#8
	jsl	~~error
L10475:
L10474:
	brl	L10476
L10470:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$d
	rep	#$20
	longa	on
	beq	L619
	brl	L10477
L619:
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
	bpl	L620
	dey
L620:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars
	adc	<R0
	sta	<L577+pp_3
	lda	|~~basicvars+2
	adc	<R0+2
	sta	<L577+pp_3+2
	ldy	#$10
	lda	[<L577+pp_3],Y
	sta	<L577+dp_3
	ldy	#$12
	lda	[<L577+pp_3],Y
	sta	<L577+dp_3+2
	clc
	lda	#$5
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L621
	inc	|~~basicvars+62+2
L621:
	brl	L10478
L10477:
	pea	#<$5
	pea	#4
	jsl	~~error
L10478:
L10476:
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
	beq	L622
	brl	L10479
L622:
	ldy	#$8
	lda	[<L577+pp_3],Y
	pha
	ldy	#$6
	lda	[<L577+pp_3],Y
	pha
	pei	<L577+dp_3+2
	pei	<L577+dp_3
	jsl	~~push_parameters
L10479:
	lda	|~~basicvars+425
	bit	#$1
	bne	L623
	brl	L10480
L623:
	lda	|~~basicvars+425
	bit	#$4
	bne	L624
	brl	L10481
L624:
	pea	#<$1
	ldy	#$8
	lda	[<L577+pp_3],Y
	pha
	ldy	#$6
	lda	[<L577+pp_3],Y
	pha
	jsl	~~trace_proc
L10481:
	lda	|~~basicvars+425
	bit	#$10
	bne	L625
	brl	L10482
L625:
	ldy	#$2
	lda	[<L577+dp_3],Y
	pha
	lda	[<L577+dp_3]
	pha
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~trace_branch
L10482:
L10480:
L10483:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$3a
	rep	#$20
	longa	on
	bne	L626
	brl	L10484
L626:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	bne	L627
	brl	L10484
L627:
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~skip_token
	sta	|~~basicvars+62
	stx	|~~basicvars+62+2
	brl	L10483
L10484:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$3a
	rep	#$20
	longa	on
	beq	L628
	brl	L10485
L628:
	inc	|~~basicvars+62
	bne	L629
	inc	|~~basicvars+62+2
L629:
L10485:
	ldy	#$4
	lda	[<L577+dp_3],Y
	pha
	ldy	#$8
	lda	[<L577+pp_3],Y
	pha
	ldy	#$6
	lda	[<L577+pp_3],Y
	pha
	jsl	~~push_proc
	lda	[<L577+dp_3]
	sta	|~~basicvars+62
	ldy	#$2
	lda	[<L577+dp_3],Y
	sta	|~~basicvars+62+2
L10469:
	brl	L10486
L10465:
	pea	#<$5
	pea	#4
	jsl	~~error
L10486:
L10464:
L10447:
L630:
	pld
	tsc
	clc
	adc	#L576
	tcs
	rtl
L576	equ	31
L577	equ	13
	ends
	efunc
	code
	xdef	~~exec_on
	func
~~exec_on:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L631
	tcs
	phd
	tcd
	inc	|~~basicvars+62
	bne	L633
	inc	|~~basicvars+62+2
L633:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$a9
	rep	#$20
	longa	on
	beq	L634
	brl	L10487
L634:
	jsl	~~exec_onerror
	brl	L10488
L10487:
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
	bne	L635
	brl	L10489
L635:
	jsl	~~emulate_on
	brl	L10490
L10489:
	jsl	~~exec_onbranch
L10490:
L10488:
L636:
	pld
	tsc
	clc
	adc	#L631
	tcs
	rtl
L631	equ	4
L632	equ	5
	ends
	efunc
	code
	xdef	~~exec_oscli
	func
~~exec_oscli:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L637
	tcs
	phd
	tcd
stringtype_1	set	0
descriptor_1	set	2
response_1	set	8
linecount_1	set	14
tofile_1	set	20
respname_1	set	21
length_1	set	37
count_1	set	39
n_1	set	41
respfile_1	set	43
p_1	set	47
ap_1	set	51
	inc	|~~basicvars+62
	bne	L639
	inc	|~~basicvars+62+2
L639:
	jsl	~~expression
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L638+stringtype_1
	lda	<L638+stringtype_1
	cmp	#<$4
	bne	L640
	brl	L10491
L640:
	lda	<L638+stringtype_1
	cmp	#<$5
	bne	L641
	brl	L10491
L641:
	pea	#<$40
	pea	#4
	jsl	~~error
L10491:
	stz	<R0
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	sep	#$20
	longa	off
	lda	[<R1]
	cmp	#<$e1
	rep	#$20
	longa	on
	beq	L643
	brl	L642
L643:
	inc	<R0
L642:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L638+tofile_1
	rep	#$20
	longa	on
	lda	<L638+tofile_1
	and	#$ff
	bne	L644
	brl	L10492
L644:
	inc	|~~basicvars+62
	bne	L645
	inc	|~~basicvars+62+2
L645:
	pea	#0
	clc
	tdc
	adc	#<L638+response_1
	pha
	jsl	~~get_lvalue
	lda	<L638+response_1
	cmp	#<$c
	bne	L646
	brl	L10493
L646:
	pea	#<$49
	pea	#4
	jsl	~~error
L10493:
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
	beq	L647
	brl	L10494
L647:
	inc	|~~basicvars+62
	bne	L648
	inc	|~~basicvars+62+2
L648:
	pea	#0
	clc
	tdc
	adc	#<L638+linecount_1
	pha
	jsl	~~get_lvalue
	brl	L10495
L10494:
	stz	<L638+linecount_1
L10495:
L10492:
	jsl	~~check_ateol
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L638+descriptor_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	ldy	#$0
	lda	<L638+descriptor_1
	bpl	L649
	dey
L649:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L638+descriptor_1+4
	pei	<L638+descriptor_1+2
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
	ldy	<L638+descriptor_1
	sta	[<R0],Y
	rep	#$20
	longa	on
	lda	<L638+stringtype_1
	cmp	#<$5
	beq	L650
	brl	L10496
L650:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L638+descriptor_1
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
L10496:
	lda	<L638+tofile_1
	and	#$ff
	beq	L651
	brl	L10497
L651:
	pea	#^$0
	pea	#<$0
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	jsl	~~emulate_oscli
L652:
	pld
	tsc
	clc
	adc	#L637
	tcs
	rtl
L10497:
	pea	#0
	clc
	tdc
	adc	#<L638+respname_1
	pha
	jsl	~~secure_tmpnam
	and	#$ff
	beq	L653
	brl	L10498
L653:
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
	pea	#<$8f
	pea	#8
	jsl	~~error
	brl	L652
L10498:
	pea	#0
	clc
	tdc
	adc	#<L638+respname_1
	pha
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	jsl	~~emulate_oscli
	pea	#^L543
	pea	#<L543
	pea	#0
	clc
	tdc
	adc	#<L638+respname_1
	pha
	jsl	~~fopen
	sta	<L638+respfile_1
	stx	<L638+respfile_1+2
	lda	<L638+respfile_1
	ora	<L638+respfile_1+2
	beq	L654
	brl	L10499
L654:
	brl	L652
L10499:
	lda	[<L638+response_1+2]
	sta	<L638+ap_1
	ldy	#$2
	lda	[<L638+response_1+2],Y
	sta	<L638+ap_1+2
	stz	<L638+descriptor_1
	lda	|~~nullstring
	sta	<L638+descriptor_1+2
	lda	|~~nullstring+2
	sta	<L638+descriptor_1+4
	stz	<L638+n_1
	brl	L10503
L10502:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	ldy	#$0
	lda	<L638+n_1
	bpl	L655
	dey
L655:
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
	ldy	#$4
	lda	[<L638+ap_1],Y
	adc	<R1
	sta	<R2
	ldy	#$6
	lda	[<L638+ap_1],Y
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
	clc
	tdc
	adc	#<L638+descriptor_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	ldy	#$0
	lda	<L638+n_1
	bpl	L656
	dey
L656:
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
	ldy	#$4
	lda	[<L638+ap_1],Y
	adc	<R0
	sta	<R1
	ldy	#$6
	lda	[<L638+ap_1],Y
	adc	<R0+2
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
L10500:
	inc	<L638+n_1
L10503:
	sec
	lda	<L638+n_1
	ldy	#$2
	sbc	[<L638+ap_1],Y
	bvs	L657
	eor	#$8000
L657:
	bmi	L658
	brl	L10502
L658:
L10501:
	stz	<L638+count_1
L10504:
	pei	<L638+respfile_1+2
	pei	<L638+respfile_1
	jsl	~~feof
	tax
	beq	L659
	brl	L10505
L659:
	lda	<L638+count_1
	ina
	sta	<R0
	sec
	lda	<R0
	ldy	#$2
	sbc	[<L638+ap_1],Y
	bvs	L660
	eor	#$8000
L660:
	bpl	L661
	brl	L10505
L661:
	pei	<L638+respfile_1+2
	pei	<L638+respfile_1
	pea	#<$1000
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	jsl	~~fgets
	sta	<L638+p_1
	stx	<L638+p_1+2
	lda	<L638+p_1
	ora	<L638+p_1+2
	beq	L662
	brl	L10506
L662:
	pei	<L638+respfile_1+2
	pei	<L638+respfile_1
	jsl	~~ferror
	tax
	bne	L663
	brl	L10505
L663:
	pei	<L638+respfile_1+2
	pei	<L638+respfile_1
	jsl	~~fclose
	pea	#0
	clc
	tdc
	adc	#<L638+respname_1
	pha
	jsl	~~remove
	pea	#^L543+3
	pea	#<L543+3
	pea	#<$67c
	pea	#<$82
	pea	#10
	jsl	~~error
L10506:
	lda	<L638+p_1
	ora	<L638+p_1+2
	bne	L664
	brl	L10505
L664:
	lda	|~~basicvars+70
	sta	<L638+p_1
	lda	|~~basicvars+70+2
	sta	<L638+p_1+2
	sep	#$20
	longa	off
	lda	[<L638+p_1]
	cmp	#<$d
	rep	#$20
	longa	on
	beq	L665
	brl	L10507
L665:
	inc	<L638+p_1
	bne	L666
	inc	<L638+p_1+2
L666:
L10507:
	pei	<L638+p_1+2
	pei	<L638+p_1
	jsl	~~strlen
	sta	<L638+length_1
L10508:
	sec
	lda	#$0
	sbc	<L638+length_1
	bvs	L667
	eor	#$8000
L667:
	bpl	L668
	brl	L10509
L668:
	clc
	lda	#$ffff
	adc	<L638+length_1
	sta	<R0
	sep	#$20
	longa	off
	ldy	<R0
	lda	[<L638+p_1],Y
	cmp	#<$a
	rep	#$20
	longa	on
	bne	L670
	brl	L669
L670:
	clc
	lda	#$ffff
	adc	<L638+length_1
	sta	<R1
	sep	#$20
	longa	off
	ldy	<R1
	lda	[<L638+p_1],Y
	cmp	#<$d
	rep	#$20
	longa	on
	bne	L671
	brl	L669
L671:
	clc
	lda	#$ffff
	adc	<L638+length_1
	sta	<R2
	sep	#$20
	longa	off
	ldy	<R2
	lda	[<L638+p_1],Y
	cmp	#<$20
	rep	#$20
	longa	on
	beq	L672
	brl	L10509
L672:
L669:
	dec	<L638+length_1
	brl	L10508
L10509:
	sec
	lda	#$0
	sbc	<L638+length_1
	bvs	L674
	eor	#$8000
L674:
	bmi	L675
	brl	L673
L675:
	pei	<L638+respfile_1+2
	pei	<L638+respfile_1
	jsl	~~feof
	tax
	beq	L676
	brl	L10510
L676:
L673:
	lda	<L638+length_1
	sta	<L638+descriptor_1
	pei	<L638+length_1
	jsl	~~alloc_string
	sta	<L638+descriptor_1+2
	stx	<L638+descriptor_1+4
	sec
	lda	#$0
	sbc	<L638+length_1
	bvs	L677
	eor	#$8000
L677:
	bpl	L678
	brl	L10511
L678:
	ldy	#$0
	lda	<L638+length_1
	bpl	L679
	dey
L679:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L638+p_1+2
	pei	<L638+p_1
	pei	<L638+descriptor_1+4
	pei	<L638+descriptor_1+2
	jsl	~~memmove
L10511:
	inc	<L638+count_1
	clc
	tdc
	adc	#<L638+descriptor_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	ldy	#$0
	lda	<L638+count_1
	bpl	L680
	dey
L680:
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
	ldy	#$4
	lda	[<L638+ap_1],Y
	adc	<R0
	sta	<R1
	ldy	#$6
	lda	[<L638+ap_1],Y
	adc	<R0+2
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
L10510:
	brl	L10504
L10505:
	pei	<L638+respfile_1+2
	pei	<L638+respfile_1
	jsl	~~fclose
	pea	#0
	clc
	tdc
	adc	#<L638+respname_1
	pha
	jsl	~~remove
	lda	<L638+linecount_1
	bne	L681
	brl	L10512
L681:
	pea	#<$1
	pei	<L638+count_1
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L638+linecount_1
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
L10512:
	brl	L652
L637	equ	67
L638	equ	13
	ends
	efunc
	data
L543:
	db	$72,$62,$00,$6D,$61,$69,$6E,$73,$74,$61,$74,$65,$00
	ends
	code
	xdef	~~exec_overlay
	func
~~exec_overlay:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L683
	tcs
	phd
	tcd
	pea	#<$2
	pea	#4
	jsl	~~error
L685:
	pld
	tsc
	clc
	adc	#L683
	tcs
	rtl
L683	equ	0
L684	equ	1
	ends
	efunc
	code
	xdef	~~exec_proc
	func
~~exec_proc:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L686
	tcs
	phd
	tcd
dp_1	set	0
vp_1	set	4
	lda	|~~basicvars+489
	and	#$ff
	bne	L688
	brl	L10513
L688:
	pea	#<$8
	pea	#4
	jsl	~~error
L10513:
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
	bpl	L689
	dey
L689:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars
	adc	<R0
	sta	<L687+vp_1
	lda	|~~basicvars+2
	adc	<R0+2
	sta	<L687+vp_1+2
	ldy	#$10
	lda	[<L687+vp_1],Y
	sta	<L687+dp_1
	ldy	#$12
	lda	[<L687+vp_1],Y
	sta	<L687+dp_1+2
	clc
	lda	#$5
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L690
	inc	|~~basicvars+62+2
L690:
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
	beq	L691
	brl	L10514
L691:
	ldy	#$8
	lda	[<L687+vp_1],Y
	pha
	ldy	#$6
	lda	[<L687+vp_1],Y
	pha
	pei	<L687+dp_1+2
	pei	<L687+dp_1
	jsl	~~push_parameters
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
	beq	L692
	brl	L10515
L692:
	pea	#<$5
	pea	#4
	jsl	~~error
L10515:
L10514:
	ldy	#$4
	lda	[<L687+dp_1],Y
	pha
	ldy	#$8
	lda	[<L687+vp_1],Y
	pha
	ldy	#$6
	lda	[<L687+vp_1],Y
	pha
	jsl	~~push_proc
	lda	|~~basicvars+425
	bit	#$1
	bne	L693
	brl	L10516
L693:
	lda	|~~basicvars+425
	bit	#$4
	bne	L694
	brl	L10517
L694:
	pea	#<$1
	ldy	#$8
	lda	[<L687+vp_1],Y
	pha
	ldy	#$6
	lda	[<L687+vp_1],Y
	pha
	jsl	~~trace_proc
L10517:
	lda	|~~basicvars+425
	bit	#$10
	bne	L695
	brl	L10518
L695:
	ldy	#$2
	lda	[<L687+dp_1],Y
	pha
	lda	[<L687+dp_1]
	pha
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~trace_branch
L10518:
L10516:
	lda	[<L687+dp_1]
	sta	|~~basicvars+62
	ldy	#$2
	lda	[<L687+dp_1],Y
	sta	|~~basicvars+62+2
L696:
	pld
	tsc
	clc
	adc	#L686
	tcs
	rtl
L686	equ	20
L687	equ	13
	ends
	efunc
	code
	xdef	~~exec_xproc
	func
~~exec_xproc:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L697
	tcs
	phd
	tcd
tp_1	set	0
base_1	set	4
vp_1	set	8
dp_1	set	12
	lda	|~~basicvars+62
	sta	<L698+tp_1
	lda	|~~basicvars+62+2
	sta	<L698+tp_1+2
	pei	<L698+tp_1+2
	pei	<L698+tp_1
	jsl	~~get_srcaddr
	sta	<L698+base_1
	stx	<L698+base_1+2
	sep	#$20
	longa	off
	lda	[<L698+base_1]
	cmp	#<$cd
	rep	#$20
	longa	on
	bne	L699
	brl	L10519
L699:
	pea	#<$53
	pea	#4
	jsl	~~error
L10519:
	pei	<L698+base_1+2
	pei	<L698+base_1
	jsl	~~skip_name
	sta	<L698+tp_1
	stx	<L698+tp_1+2
	clc
	lda	#$ffff
	adc	<L698+tp_1
	sta	<R0
	lda	#$ffff
	adc	<L698+tp_1+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$28
	rep	#$20
	longa	on
	beq	L700
	brl	L10520
L700:
	lda	<L698+tp_1
	bne	L701
	dec	<L698+tp_1+2
L701:
	dec	<L698+tp_1
L10520:
	sec
	lda	<L698+tp_1
	sbc	<L698+base_1
	sta	<R0
	lda	<L698+tp_1+2
	sbc	<L698+base_1+2
	sta	<R0+2
	pei	<R0
	pei	<L698+base_1+2
	pei	<L698+base_1
	jsl	~~find_fnproc
	sta	<L698+vp_1
	stx	<L698+vp_1+2
	ldy	#$10
	lda	[<L698+vp_1],Y
	sta	<L698+dp_1
	ldy	#$12
	lda	[<L698+vp_1],Y
	sta	<L698+dp_1+2
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$d
	sta	[<R0]
	rep	#$20
	longa	on
	pei	<L698+vp_1+2
	pei	<L698+vp_1
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~set_address
	clc
	lda	#$5
	adc	|~~basicvars+62
	sta	<L698+tp_1
	lda	#$0
	adc	|~~basicvars+62+2
	sta	<L698+tp_1+2
	sep	#$20
	longa	off
	lda	[<L698+tp_1]
	cmp	#<$28
	rep	#$20
	longa	on
	bne	L702
	brl	L10521
L702:
	ldy	#$7
	lda	[<L698+dp_1],Y
	ldy	#$9
	ora	[<L698+dp_1],Y
	bne	L703
	brl	L10522
L703:
	ldy	#$8
	lda	[<L698+vp_1],Y
	pha
	ldy	#$6
	lda	[<L698+vp_1],Y
	pha
	pea	#<$12
	pea	#8
	jsl	~~error
L10522:
	lda	[<L698+tp_1]
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	beq	L704
	brl	L10523
L704:
	pea	#<$5
	pea	#4
	jsl	~~error
L10523:
	brl	L10524
L10521:
	ldy	#$7
	lda	[<L698+dp_1],Y
	ldy	#$9
	ora	[<L698+dp_1],Y
	beq	L705
	brl	L10525
L705:
	ldy	#$8
	lda	[<L698+vp_1],Y
	pha
	ldy	#$6
	lda	[<L698+vp_1],Y
	pha
	pea	#<$11
	pea	#8
	jsl	~~error
L10525:
L10524:
	jsl	~~exec_proc
L706:
	pld
	tsc
	clc
	adc	#L697
	tcs
	rtl
L697	equ	20
L698	equ	5
	ends
	efunc
	code
	xdef	~~exec_quit
	func
~~exec_quit:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L707
	tcs
	phd
	tcd
retcode_1	set	0
	inc	|~~basicvars+62
	bne	L709
	inc	|~~basicvars+62+2
L709:
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~isateol
	and	#$ff
	bne	L710
	brl	L10526
L710:
	stz	<L708+retcode_1
	brl	L10527
L10526:
	jsl	~~eval_integer
	sta	<L708+retcode_1
	jsl	~~check_ateol
L10527:
	pei	<L708+retcode_1
	jsl	~~exit_interpreter
L711:
	pld
	tsc
	clc
	adc	#L707
	tcs
	rtl
L707	equ	2
L708	equ	1
	ends
	efunc
	code
	func
~~find_data:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L712
	tcs
	phd
	tcd
dp_1	set	0
	lda	|~~basicvars+407
	sta	<L713+dp_1
	lda	|~~basicvars+407+2
	sta	<L713+dp_1+2
	lda	<L713+dp_1
	ora	<L713+dp_1+2
	bne	L714
	brl	L10528
L714:
	sep	#$20
	longa	off
	lda	[<L713+dp_1]
	cmp	#<$2c
	rep	#$20
	longa	on
	bne	L716
	brl	L715
L716:
	sep	#$20
	longa	off
	lda	[<L713+dp_1]
	cmp	#<$99
	rep	#$20
	longa	on
	beq	L717
	brl	L10528
L717:
L715:
	inc	|~~basicvars+407
	bne	L718
	inc	|~~basicvars+407+2
L718:
L719:
	pld
	tsc
	clc
	adc	#L712
	tcs
	rtl
L10528:
	lda	<L713+dp_1
	ora	<L713+dp_1+2
	beq	L720
	brl	L10529
L720:
	lda	|~~basicvars+22
	sta	<L713+dp_1
	lda	|~~basicvars+22+2
	sta	<L713+dp_1+2
	brl	L10530
L10529:
	clc
	lda	#$1
	adc	<L713+dp_1
	sta	<R0
	lda	#$0
	adc	<L713+dp_1+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~skip_token
	sta	<R1
	stx	<R1+2
	clc
	lda	#$1
	adc	<R1
	sta	<L713+dp_1
	lda	#$0
	adc	<R1+2
	sta	<L713+dp_1+2
L10530:
L10531:
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L713+dp_1],Y
	cmp	#<$ff
	rep	#$20
	longa	on
	bne	L721
	brl	L10532
L721:
	ldy	#$5
	lda	[<L713+dp_1],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L722
	dey
L722:
	sta	<R0
	sty	<R0+2
	ldy	#$4
	lda	[<L713+dp_1],Y
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
	lda	<L713+dp_1
	adc	<R2
	sta	<R0
	lda	<L713+dp_1+2
	adc	<R2+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$99
	rep	#$20
	longa	on
	bne	L723
	brl	L10532
L723:
	ldy	#$2
	lda	[<L713+dp_1],Y
	and	#$ff
	sta	<R0
	ldy	#$3
	lda	[<L713+dp_1],Y
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
	bpl	L724
	dey
L724:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L713+dp_1
	adc	<R0
	sta	<L713+dp_1
	lda	<L713+dp_1+2
	adc	<R0+2
	sta	<L713+dp_1+2
	brl	L10531
L10532:
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L713+dp_1],Y
	cmp	#<$ff
	rep	#$20
	longa	on
	beq	L725
	brl	L10533
L725:
	pea	#<$58
	pea	#4
	jsl	~~error
L10533:
	ldy	#$5
	lda	[<L713+dp_1],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L726
	dey
L726:
	sta	<R0
	sty	<R0+2
	ldy	#$4
	lda	[<L713+dp_1],Y
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
	lda	<L713+dp_1
	adc	<R2
	sta	<R0
	lda	<L713+dp_1+2
	adc	<R2+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~get_srcaddr
	sta	|~~basicvars+407
	stx	|~~basicvars+407+2
	brl	L719
L712	equ	16
L713	equ	13
	ends
	efunc
	code
	func
~~read_numeric:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L727
	tcs
	phd
	tcd
destination_0	set	4
dp_1	set	0
itemtype_1	set	4
n_1	set	6
text_1	set	8
readexpr_1	set	12
	pea	#^$400
	pea	#<$400
	jsl	~~malloc
	sta	<L728+text_1
	stx	<L728+text_1+2
	pea	#^$400
	pea	#<$400
	jsl	~~malloc
	sta	<L728+readexpr_1
	stx	<L728+readexpr_1+2
	stz	<L728+n_1
	lda	|~~basicvars+407+2
	pha
	lda	|~~basicvars+407
	pha
	jsl	~~skip
	sta	<L728+dp_1
	stx	<L728+dp_1+2
L10534:
	lda	[<L728+dp_1]
	and	#$ff
	bne	L729
	brl	L10535
L729:
	sep	#$20
	longa	off
	lda	[<L728+dp_1]
	cmp	#<$2c
	rep	#$20
	longa	on
	bne	L730
	brl	L10535
L730:
	sep	#$20
	longa	off
	lda	[<L728+dp_1]
	ldy	<L728+n_1
	sta	[<L728+text_1],Y
	rep	#$20
	longa	on
	inc	<L728+dp_1
	bne	L731
	inc	<L728+dp_1+2
L731:
	inc	<L728+n_1
	brl	L10534
L10535:
	sep	#$20
	longa	off
	lda	#$0
	ldy	<L728+n_1
	sta	[<L728+text_1],Y
	rep	#$20
	longa	on
	lda	<L728+n_1
	beq	L732
	brl	L10536
L732:
	pea	#<$51
	pea	#4
	jsl	~~error
L10536:
	lda	<L728+dp_1
	sta	|~~basicvars+407
	lda	<L728+dp_1+2
	sta	|~~basicvars+407+2
	pea	#<$0
	pei	<L728+readexpr_1+2
	pei	<L728+readexpr_1
	pei	<L728+text_1+2
	pei	<L728+text_1
	jsl	~~tokenize
	jsl	~~save_current
	ldy	#$5
	lda	[<L728+readexpr_1],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L733
	dey
L733:
	sta	<R0
	sty	<R0+2
	ldy	#$4
	lda	[<L728+readexpr_1],Y
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
	lda	<L728+readexpr_1
	adc	<R2
	sta	|~~basicvars+62
	lda	<L728+readexpr_1+2
	adc	<R2+2
	sta	|~~basicvars+62+2
	jsl	~~expression
	jsl	~~restore_current
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L728+itemtype_1
	lda	<L727+destination_0
	brl	L10537
L10539:
	lda	<L728+itemtype_1
	brl	L10540
L10542:
	jsl	~~pop_int
	sta	[<L727+destination_0+2]
	brl	L10541
L10543:
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
	sta	[<L727+destination_0+2]
	brl	L10541
L10544:
	pea	#<$3f
	pea	#4
	jsl	~~error
	brl	L10541
L10540:
	xref	~~~swt
	jsl	~~~swt
	dw	2
	dw	2
	dw	L10542-1
	dw	3
	dw	L10543-1
	dw	L10544-1
L10541:
	brl	L10538
L10545:
	lda	<L728+itemtype_1
	brl	L10546
L10548:
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L734
	dey
L734:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	pla
	sta	[<L727+destination_0+2]
	pla
	ldy	#$2
	sta	[<L727+destination_0+2],Y
	brl	L10547
L10549:
	phy
	phy
	jsl	~~pop_float
	pla
	sta	[<L727+destination_0+2]
	pla
	ldy	#$2
	sta	[<L727+destination_0+2],Y
	brl	L10547
L10550:
	pea	#<$3f
	pea	#4
	jsl	~~error
	brl	L10547
L10546:
	xref	~~~swt
	jsl	~~~swt
	dw	2
	dw	2
	dw	L10548-1
	dw	3
	dw	L10549-1
	dw	L10550-1
L10547:
	brl	L10538
L10551:
	pea	#<$1
	pei	<L727+destination_0+2
	jsl	~~check_write
	lda	<L728+itemtype_1
	brl	L10552
L10554:
	lda	|~~basicvars+6
	sta	<R0
	lda	|~~basicvars+6+2
	sta	<R0+2
	jsl	~~pop_int
	sep	#$20
	longa	off
	ldy	<L727+destination_0+2
	sta	[<R0],Y
	rep	#$20
	longa	on
	brl	L10553
L10555:
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
	ldy	<L727+destination_0+2
	sta	[<R0],Y
	rep	#$20
	longa	on
	brl	L10553
L10556:
	pea	#<$3f
	pea	#4
	jsl	~~error
	brl	L10553
L10552:
	xref	~~~swt
	jsl	~~~swt
	dw	2
	dw	2
	dw	L10554-1
	dw	3
	dw	L10555-1
	dw	L10556-1
L10553:
	brl	L10538
L10557:
	lda	<L728+itemtype_1
	brl	L10558
L10560:
	jsl	~~pop_int
	pha
	pei	<L727+destination_0+2
	jsl	~~store_integer
	brl	L10559
L10561:
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
	pei	<L727+destination_0+2
	jsl	~~store_integer
	brl	L10559
L10562:
	pea	#<$3f
	pea	#4
	jsl	~~error
	brl	L10559
L10558:
	xref	~~~swt
	jsl	~~~swt
	dw	2
	dw	2
	dw	L10560-1
	dw	3
	dw	L10561-1
	dw	L10562-1
L10559:
	brl	L10538
L10563:
	lda	<L728+itemtype_1
	brl	L10564
L10566:
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L735
	dey
L735:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	pei	<L727+destination_0+2
	jsl	~~store_float
	brl	L10565
L10567:
	phy
	phy
	jsl	~~pop_float
	pei	<L727+destination_0+2
	jsl	~~store_float
	brl	L10565
L10568:
	pea	#<$3f
	pea	#4
	jsl	~~error
	brl	L10565
L10564:
	xref	~~~swt
	jsl	~~~swt
	dw	2
	dw	2
	dw	L10566-1
	dw	3
	dw	L10567-1
	dw	L10568-1
L10565:
	brl	L10538
L10569:
	pea	#<$45
	pea	#4
	jsl	~~error
	brl	L10538
L10537:
	xref	~~~swt
	jsl	~~~swt
	dw	5
	dw	2
	dw	L10539-1
	dw	3
	dw	L10545-1
	dw	17
	dw	L10551-1
	dw	18
	dw	L10557-1
	dw	19
	dw	L10563-1
	dw	L10569-1
L10538:
L736:
	lda	<L727+2
	sta	<L727+2+6
	lda	<L727+1
	sta	<L727+1+6
	pld
	tsc
	clc
	adc	#L727+6
	tcs
	rtl
L727	equ	28
L728	equ	13
	ends
	efunc
	code
	func
~~read_string:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L737
	tcs
	phd
	tcd
destination_0	set	4
length_1	set	0
start_1	set	2
cp_1	set	6
	lda	|~~basicvars+407+2
	pha
	lda	|~~basicvars+407
	pha
	jsl	~~skip
	sta	<L738+cp_1
	stx	<L738+cp_1+2
	lda	<L738+cp_1
	sta	<L738+start_1
	lda	<L738+cp_1+2
	sta	<L738+start_1+2
	sep	#$20
	longa	off
	lda	[<L738+cp_1]
	cmp	#<$22
	rep	#$20
	longa	on
	beq	L739
	brl	L10570
L739:
	inc	<L738+start_1
	bne	L740
	inc	<L738+start_1+2
L740:
L10573:
	inc	<L738+cp_1
	bne	L741
	inc	<L738+cp_1+2
L741:
L10571:
	lda	[<L738+cp_1]
	and	#$ff
	bne	L743
	brl	L742
L743:
	sep	#$20
	longa	off
	lda	[<L738+cp_1]
	cmp	#<$22
	rep	#$20
	longa	on
	beq	L744
	brl	L10573
L744:
L742:
L10572:
	sep	#$20
	longa	off
	lda	[<L738+cp_1]
	cmp	#<$22
	rep	#$20
	longa	on
	bne	L745
	brl	L10574
L745:
	pea	#<$2b
	pea	#4
	jsl	~~error
L10574:
	sec
	lda	<L738+cp_1
	sbc	<L738+start_1
	sta	<R0
	lda	<L738+cp_1+2
	sbc	<L738+start_1+2
	sta	<R0+2
	lda	<R0
	sta	<L738+length_1
L10577:
	inc	<L738+cp_1
	bne	L746
	inc	<L738+cp_1+2
L746:
L10575:
	lda	[<L738+cp_1]
	and	#$ff
	bne	L748
	brl	L747
L748:
	sep	#$20
	longa	off
	lda	[<L738+cp_1]
	cmp	#<$2c
	rep	#$20
	longa	on
	beq	L749
	brl	L10577
L749:
L747:
L10576:
	brl	L10578
L10570:
L10579:
	lda	[<L738+cp_1]
	and	#$ff
	bne	L750
	brl	L10580
L750:
	sep	#$20
	longa	off
	lda	[<L738+cp_1]
	cmp	#<$2c
	rep	#$20
	longa	on
	bne	L751
	brl	L10580
L751:
	inc	<L738+cp_1
	bne	L752
	inc	<L738+cp_1+2
L752:
	brl	L10579
L10580:
	sec
	lda	<L738+cp_1
	sbc	<L738+start_1
	sta	<R0
	lda	<L738+cp_1+2
	sbc	<L738+start_1+2
	sta	<R0+2
	lda	<R0
	sta	<L738+length_1
L10578:
	lda	<L738+cp_1
	sta	|~~basicvars+407
	lda	<L738+cp_1+2
	sta	|~~basicvars+407+2
	lda	<L737+destination_0
	brl	L10581
L10583:
	lda	[<L737+destination_0+2]
	cmp	<L738+length_1
	bne	L753
	brl	L10584
L753:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	pei	<L737+destination_0+4
	pei	<L737+destination_0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
	lda	<L738+length_1
	sta	[<L737+destination_0+2]
	pei	<L738+length_1
	jsl	~~alloc_string
	sta	<R0
	stx	<R0+2
	lda	<R0
	ldy	#$2
	sta	[<L737+destination_0+2],Y
	lda	<R0+2
	ldy	#$4
	sta	[<L737+destination_0+2],Y
L10584:
	lda	<L738+length_1
	bne	L754
	brl	L10585
L754:
	ldy	#$0
	lda	<L738+length_1
	bpl	L755
	dey
L755:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L738+start_1+2
	pei	<L738+start_1
	ldy	#$4
	lda	[<L737+destination_0+2],Y
	pha
	ldy	#$2
	lda	[<L737+destination_0+2],Y
	pha
	jsl	~~memmove
L10585:
	brl	L10582
L10586:
	lda	<L738+length_1
	ina
	pha
	pei	<L737+destination_0+2
	jsl	~~check_write
	lda	<L738+length_1
	bne	L756
	brl	L10587
L756:
	ldy	#$0
	lda	<L738+length_1
	bpl	L757
	dey
L757:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L738+start_1+2
	pei	<L738+start_1
	ldy	#$0
	lda	<L737+destination_0+2
	bpl	L758
	dey
L758:
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
L10587:
	clc
	lda	<L737+destination_0+2
	adc	<L738+length_1
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
	brl	L10582
L10588:
	pea	#<$45
	pea	#4
	jsl	~~error
	brl	L10582
L10581:
	xref	~~~swt
	jsl	~~~swt
	dw	2
	dw	4
	dw	L10583-1
	dw	21
	dw	L10586-1
	dw	L10588-1
L10582:
L759:
	lda	<L737+2
	sta	<L737+2+6
	lda	<L737+1
	sta	<L737+1+6
	pld
	tsc
	clc
	adc	#L737+6
	tcs
	rtl
L737	equ	22
L738	equ	13
	ends
	efunc
	code
	xdef	~~exec_read
	func
~~exec_read:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L760
	tcs
	phd
	tcd
destination_1	set	0
	inc	|~~basicvars+62
	bne	L762
	inc	|~~basicvars+62+2
L762:
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
	bne	L763
	brl	L10589
L763:
L764:
	pld
	tsc
	clc
	adc	#L760
	tcs
	rtl
L10589:
	lda	|~~basicvars+423
	bit	#$10
	bne	L765
	brl	L10590
L765:
	pea	#<$58
	pea	#4
	jsl	~~error
L10590:
L10591:
	pea	#0
	clc
	tdc
	adc	#<L761+destination_1
	pha
	jsl	~~get_lvalue
	jsl	~~find_data
	lda	<L761+destination_1
	and	#<$7
	sta	<R0
	lda	<R0
	bmi	L766
	dea
	dea
	dea
	dea
	bmi	L766
	brl	L10593
L766:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L761+destination_1
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
	jsl	~~read_numeric
	brl	L10594
L10593:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L761+destination_1
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
	jsl	~~read_string
L10594:
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
	beq	L767
	brl	L10592
L767:
	inc	|~~basicvars+62
	bne	L768
	inc	|~~basicvars+62+2
L768:
	brl	L10591
L10592:
	jsl	~~check_ateol
	brl	L764
L760	equ	14
L761	equ	9
	ends
	efunc
	code
	xdef	~~exec_repeat
	func
~~exec_repeat:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L769
	tcs
	phd
	tcd
	inc	|~~basicvars+62
	bne	L771
	inc	|~~basicvars+62+2
L771:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$3a
	rep	#$20
	longa	on
	beq	L772
	brl	L10595
L772:
	inc	|~~basicvars+62
	bne	L773
	inc	|~~basicvars+62+2
L773:
L10595:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	beq	L774
	brl	L10596
L774:
	inc	|~~basicvars+62
	bne	L775
	inc	|~~basicvars+62+2
L775:
	lda	|~~basicvars+425
	bit	#$2
	bne	L776
	brl	L10597
L776:
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~get_lineno
	pha
	jsl	~~trace_line
L10597:
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	ldy	#$5
	lda	[<R1],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L777
	dey
L777:
	sta	<R0
	sty	<R0+2
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	ldy	#$4
	lda	[<R1],Y
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
	lda	|~~basicvars+62
	adc	<R2
	sta	|~~basicvars+62
	lda	|~~basicvars+62+2
	adc	<R2+2
	sta	|~~basicvars+62+2
L10596:
	jsl	~~push_repeat
L778:
	pld
	tsc
	clc
	adc	#L769
	tcs
	rtl
L769	equ	12
L770	equ	13
	ends
	efunc
	code
	xdef	~~exec_report
	func
~~exec_report:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L779
	tcs
	phd
	tcd
p_1	set	0
	inc	|~~basicvars+62
	bne	L781
	inc	|~~basicvars+62+2
L781:
	jsl	~~check_ateol
	jsl	~~get_lasterror
	sta	<L780+p_1
	stx	<L780+p_1+2
	pei	<L780+p_1+2
	pei	<L780+p_1
	jsl	~~strlen
	sta	<R0
	stx	<R0+2
	pei	<R0
	pei	<L780+p_1+2
	pei	<L780+p_1
	jsl	~~emulate_vdustr
	ldy	#$0
	lda	|~~basicvars+494
	bpl	L782
	dey
L782:
	sta	<R0
	sty	<R0+2
	pei	<L780+p_1+2
	pei	<L780+p_1
	jsl	~~strlen
	sta	<R1
	stx	<R1+2
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	lda	<R1+2
	adc	<R0+2
	sta	<R2+2
	lda	<R2
	sta	|~~basicvars+494
L783:
	pld
	tsc
	clc
	adc	#L779
	tcs
	rtl
L779	equ	16
L780	equ	13
	ends
	efunc
	code
	func
~~restore_dataptr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L784
	tcs
	phd
	tcd
dest_1	set	0
p_1	set	4
line_1	set	8
	lda	#$10
	trb	~~basicvars+423
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	brl	L10598
L10600:
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~set_linedest
	sta	<R0
	stx	<R0+2
	phx
	pha
	jsl	~~find_linestart
	sta	<L785+dest_1
	stx	<L785+dest_1+2
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~skip_token
	sta	|~~basicvars+62
	stx	|~~basicvars+62+2
	jsl	~~check_ateol
	brl	L10599
L10601:
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
	bpl	L786
	dey
L786:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars
	adc	<R0
	sta	<L785+dest_1
	lda	|~~basicvars+2
	adc	<R0+2
	sta	<L785+dest_1+2
	pei	<L785+dest_1+2
	pei	<L785+dest_1
	jsl	~~find_linestart
	sta	<L785+dest_1
	stx	<L785+dest_1+2
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~skip_token
	sta	|~~basicvars+62
	stx	|~~basicvars+62+2
	jsl	~~check_ateol
	brl	L10599
L10602:
	inc	|~~basicvars+62
	bne	L787
	inc	|~~basicvars+62+2
L787:
	jsl	~~eval_integer
	sta	<L785+line_1
	jsl	~~check_ateol
	lda	|~~basicvars+62
	sta	<L785+p_1
	lda	|~~basicvars+62+2
	sta	<L785+p_1+2
L10603:
	lda	[<L785+p_1]
	and	#$ff
	bne	L788
	brl	L10604
L788:
	pei	<L785+p_1+2
	pei	<L785+p_1
	jsl	~~skip_token
	sta	<L785+p_1
	stx	<L785+p_1+2
	brl	L10603
L10604:
	inc	<L785+p_1
	bne	L789
	inc	<L785+p_1+2
L789:
	dec	<L785+line_1
L10605:
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L785+p_1],Y
	cmp	#<$ff
	rep	#$20
	longa	on
	bne	L790
	brl	L10606
L790:
	sec
	lda	#$0
	sbc	<L785+line_1
	bvs	L791
	eor	#$8000
L791:
	bpl	L792
	brl	L10606
L792:
	ldy	#$2
	lda	[<L785+p_1],Y
	and	#$ff
	sta	<R0
	ldy	#$3
	lda	[<L785+p_1],Y
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
	bpl	L793
	dey
L793:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L785+p_1
	adc	<R0
	sta	<L785+p_1
	lda	<L785+p_1+2
	adc	<R0+2
	sta	<L785+p_1+2
	dec	<L785+line_1
	brl	L10605
L10606:
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L785+p_1],Y
	cmp	#<$ff
	rep	#$20
	longa	on
	beq	L794
	brl	L10607
L794:
	lda	#$10
	tsb	~~basicvars+423
L795:
	pld
	tsc
	clc
	adc	#L784
	tcs
	rtl
L10607:
	lda	<L785+p_1
	sta	<L785+dest_1
	lda	<L785+p_1+2
	sta	<L785+dest_1+2
	brl	L10599
L10608:
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
	bne	L796
	brl	L10609
L796:
	lda	|~~basicvars+22
	sta	<L785+dest_1
	lda	|~~basicvars+22+2
	sta	<L785+dest_1+2
	brl	L10610
L10609:
	jsl	~~eval_integer
	sta	<L785+line_1
	jsl	~~check_ateol
	pei	<L785+line_1
	jsl	~~find_line
	sta	<L785+dest_1
	stx	<L785+dest_1+2
	pei	<L785+dest_1+2
	pei	<L785+dest_1
	jsl	~~get_lineno
	sta	<R0
	lda	<R0
	cmp	<L785+line_1
	bne	L797
	brl	L10611
L797:
	pei	<L785+line_1
	pea	#<$c
	pea	#6
	jsl	~~error
L10611:
L10610:
	brl	L10599
L10598:
	xref	~~~swt
	jsl	~~~swt
	dw	3
	dw	30
	dw	L10600-1
	dw	31
	dw	L10601-1
	dw	43
	dw	L10602-1
	dw	L10608-1
L10599:
L10612:
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L785+dest_1],Y
	cmp	#<$ff
	rep	#$20
	longa	on
	bne	L798
	brl	L10613
L798:
	ldy	#$5
	lda	[<L785+dest_1],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L799
	dey
L799:
	sta	<R0
	sty	<R0+2
	ldy	#$4
	lda	[<L785+dest_1],Y
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
	lda	<L785+dest_1
	adc	<R2
	sta	<R0
	lda	<L785+dest_1+2
	adc	<R2+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$99
	rep	#$20
	longa	on
	bne	L800
	brl	L10613
L800:
	ldy	#$2
	lda	[<L785+dest_1],Y
	and	#$ff
	sta	<R0
	ldy	#$3
	lda	[<L785+dest_1],Y
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
	bpl	L801
	dey
L801:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L785+dest_1
	adc	<R0
	sta	<L785+dest_1
	lda	<L785+dest_1+2
	adc	<R0+2
	sta	<L785+dest_1+2
	brl	L10612
L10613:
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L785+dest_1],Y
	cmp	#<$ff
	rep	#$20
	longa	on
	beq	L802
	brl	L10614
L802:
	lda	#$10
	tsb	~~basicvars+423
	brl	L10615
L10614:
	ldy	#$5
	lda	[<L785+dest_1],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L803
	dey
L803:
	sta	<R0
	sty	<R0+2
	ldy	#$4
	lda	[<L785+dest_1],Y
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
	lda	<L785+dest_1
	adc	<R2
	sta	<R0
	lda	<L785+dest_1+2
	adc	<R2+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~get_srcaddr
	sta	<R1
	stx	<R1+2
	clc
	lda	#$ffff
	adc	<R1
	sta	|~~basicvars+407
	lda	#$ffff
	adc	<R1+2
	sta	|~~basicvars+407+2
L10615:
	brl	L795
L784	equ	22
L785	equ	13
	ends
	efunc
	code
	xdef	~~exec_restore
	func
~~exec_restore:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L804
	tcs
	phd
	tcd
	inc	|~~basicvars+62
	bne	L806
	inc	|~~basicvars+62+2
L806:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	brl	L10616
L10618:
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~skip_token
	sta	|~~basicvars+62
	stx	|~~basicvars+62+2
	jsl	~~check_ateol
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$17
	bne	L807
	brl	L10619
L807:
	pea	#<$64
	pea	#4
	jsl	~~error
L10619:
	jsl	~~pop_error
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	pea	#<~~basicvars+232
	lda	#$9
	xref	~~~fnmov
	jsl	~~~fnmov
	brl	L10617
L10620:
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~skip_token
	sta	|~~basicvars+62
	stx	|~~basicvars+62+2
	jsl	~~check_ateol
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$18
	bne	L808
	brl	L10621
L808:
	pea	#<$65
	pea	#4
	jsl	~~error
L10621:
	jsl	~~pop_data
	sta	|~~basicvars+407
	stx	|~~basicvars+407+2
	brl	L10617
L10622:
	jsl	~~restore_dataptr
	brl	L10617
L10616:
	xref	~~~swt
	jsl	~~~swt
	dw	2
	dw	153
	dw	L10620-1
	dw	169
	dw	L10618-1
	dw	L10622-1
L10617:
L809:
	pld
	tsc
	clc
	adc	#L804
	tcs
	rtl
L804	equ	4
L805	equ	5
	ends
	efunc
	code
	xdef	~~exec_return
	func
~~exec_return:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L810
	tcs
	phd
	tcd
returnblock_1	set	0
	inc	|~~basicvars+62
	bne	L812
	inc	|~~basicvars+62+2
L812:
	jsl	~~check_ateol
	lda	|~~basicvars+403
	ora	|~~basicvars+403+2
	beq	L813
	brl	L10623
L813:
	pea	#<$52
	pea	#4
	jsl	~~error
L10623:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$e
	bne	L814
	brl	L10624
L814:
	pea	#<$e
	jsl	~~empty_stack
L10624:
	jsl	~~pop_gosub
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L811+returnblock_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$8
	xref	~~~fmov
	jsl	~~~fmov
	lda	|~~basicvars+425
	bit	#$10
	bne	L815
	brl	L10625
L815:
	pei	<L811+returnblock_1+6
	pei	<L811+returnblock_1+4
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~trace_branch
L10625:
	lda	<L811+returnblock_1+4
	sta	|~~basicvars+62
	lda	<L811+returnblock_1+6
	sta	|~~basicvars+62+2
L816:
	pld
	tsc
	clc
	adc	#L810
	tcs
	rtl
L810	equ	12
L811	equ	5
	ends
	efunc
	code
	xdef	~~exec_run
	func
~~exec_run:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L817
	tcs
	phd
	tcd
string_1	set	0
topitem_1	set	6
bp_1	set	8
line_1	set	12
filename_1	set	14
	inc	|~~basicvars+62
	bne	L819
	inc	|~~basicvars+62+2
L819:
	stz	<L818+bp_1
	stz	<L818+bp_1+2
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
	beq	L820
	brl	L10626
L820:
	jsl	~~expression
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L818+topitem_1
	lda	<L818+topitem_1
	brl	L10627
L10629:
L10630:
	lda	<L818+topitem_1
	cmp	#<$2
	beq	L821
	brl	L10631
L821:
	jsl	~~pop_int
	sta	<L818+line_1
	brl	L10632
L10631:
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
	sta	<L818+line_1
L10632:
	lda	<L818+line_1
	bpl	L823
	brl	L822
L823:
	ldy	#$0
	lda	<L818+line_1
	bpl	L824
	dey
L824:
	sta	<R0
	sty	<R0+2
	sec
	lda	#$feff
	sbc	<R0
	lda	#$0
	sbc	<R0+2
	bvs	L825
	eor	#$8000
L825:
	bpl	L826
	brl	L10633
L826:
L822:
	pea	#<$b
	pea	#4
	jsl	~~error
L10633:
	pei	<L818+line_1
	jsl	~~find_line
	sta	<L818+bp_1
	stx	<L818+bp_1+2
	pei	<L818+bp_1+2
	pei	<L818+bp_1
	jsl	~~get_lineno
	sta	<R0
	lda	<R0
	cmp	<L818+line_1
	bne	L827
	brl	L10634
L827:
	pei	<L818+line_1
	pea	#<$c
	pea	#6
	jsl	~~error
L10634:
	brl	L10628
L10635:
L10636:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L818+string_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	pei	<L818+string_1
	pei	<L818+string_1+4
	pei	<L818+string_1+2
	jsl	~~tocstring
	sta	<L818+filename_1
	stx	<L818+filename_1+2
	lda	<L818+topitem_1
	cmp	#<$5
	beq	L828
	brl	L10637
L828:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L818+string_1
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
L10637:
	jsl	~~check_ateol
	jsl	~~clear_error
	jsl	~~clear_varlists
	jsl	~~clear_strings
	jsl	~~clear_heap
	pei	<L818+filename_1+2
	pei	<L818+filename_1
	jsl	~~read_basic
	brl	L10628
L10638:
	pea	#<$3e
	pea	#4
	jsl	~~error
	brl	L10628
L10627:
	xref	~~~fsw
	jsl	~~~fsw
	dw	2
	dw	4
	dw	L10638-1
	dw	L10629-1
	dw	L10630-1
	dw	L10635-1
	dw	L10636-1
L10628:
L10626:
	pei	<L818+bp_1+2
	pei	<L818+bp_1
	jsl	~~run_program
L829:
	pld
	tsc
	clc
	adc	#L817
	tcs
	rtl
L817	equ	26
L818	equ	9
	ends
	efunc
	code
	xdef	~~exec_stop
	func
~~exec_stop:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L830
	tcs
	phd
	tcd
	inc	|~~basicvars+62
	bne	L832
	inc	|~~basicvars+62+2
L832:
	jsl	~~check_ateol
	pea	#<$9
	pea	#4
	jsl	~~error
L833:
	pld
	tsc
	clc
	adc	#L830
	tcs
	rtl
L830	equ	0
L831	equ	1
	ends
	efunc
	code
	xdef	~~exec_swap
	func
~~exec_swap:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L834
	tcs
	phd
	tcd
first_1	set	0
second_1	set	6
	inc	|~~basicvars+62
	bne	L836
	inc	|~~basicvars+62+2
L836:
	pea	#0
	clc
	tdc
	adc	#<L835+first_1
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
	bne	L837
	brl	L10639
L837:
	pea	#<$27
	pea	#4
	jsl	~~error
L10639:
	inc	|~~basicvars+62
	bne	L838
	inc	|~~basicvars+62+2
L838:
	pea	#0
	clc
	tdc
	adc	#<L835+second_1
	pha
	jsl	~~get_lvalue
	jsl	~~check_ateol
	lda	<L835+first_1
	bmi	L840
	dea
	dea
	dea
	dea
	bpl	L841
L840:
	brl	L839
L841:
	sec
	lda	<L835+first_1
	sbc	#<$11
	bvs	L842
	eor	#$8000
L842:
	bmi	L843
	brl	L10640
L843:
	sec
	lda	#$13
	sbc	<L835+first_1
	bvs	L844
	eor	#$8000
L844:
	bmi	L845
	brl	L10640
L845:
L839:
	lda	<L835+second_1
	bmi	L847
	dea
	dea
	dea
	dea
	bpl	L848
L847:
	brl	L846
L848:
	sec
	lda	<L835+second_1
	sbc	#<$11
	bvs	L849
	eor	#$8000
L849:
	bmi	L850
	brl	L10640
L850:
	sec
	lda	#$13
	sbc	<L835+second_1
	bvs	L851
	eor	#$8000
L851:
	bmi	L852
	brl	L10640
L852:
L846:
	udata
L10641:
	ds	4
	ends
	udata
L10642:
	ds	4
	ends
ival1_2	set	12
ival2_2	set	14
isint_2	set	16
	lda	<L835+first_1
	brl	L10643
L10645:
	lda	[<L835+first_1+2]
	sta	<L835+ival1_2
	sep	#$20
	longa	off
	lda	#$1
	sta	<L835+isint_2
	rep	#$20
	longa	on
	brl	L10644
L10646:
	lda	[<L835+first_1+2]
	sta	|L10641
	ldy	#$2
	lda	[<L835+first_1+2],Y
	sta	|L10641+2
	sep	#$20
	longa	off
	stz	<L835+isint_2
	rep	#$20
	longa	on
	brl	L10644
L10647:
	pea	#<$1
	pei	<L835+first_1+2
	jsl	~~check_write
	lda	|~~basicvars+6
	sta	<R0
	lda	|~~basicvars+6+2
	sta	<R0+2
	ldy	<L835+first_1+2
	lda	[<R0],Y
	and	#$ff
	sta	<L835+ival1_2
	sep	#$20
	longa	off
	lda	#$1
	sta	<L835+isint_2
	rep	#$20
	longa	on
	brl	L10644
L10648:
	pei	<L835+first_1+2
	jsl	~~get_integer
	sta	<L835+ival1_2
	sep	#$20
	longa	off
	lda	#$1
	sta	<L835+isint_2
	rep	#$20
	longa	on
	brl	L10644
L10649:
	phy
	phy
	pei	<L835+first_1+2
	jsl	~~get_float
	pla
	sta	|L10641
	pla
	sta	|L10641+2
	sep	#$20
	longa	off
	stz	<L835+isint_2
	rep	#$20
	longa	on
	brl	L10644
L10650:
	pea	#^L682
	pea	#<L682
	pea	#<$894
	pea	#<$82
	pea	#10
	jsl	~~error
	brl	L10644
L10643:
	xref	~~~swt
	jsl	~~~swt
	dw	5
	dw	2
	dw	L10645-1
	dw	3
	dw	L10646-1
	dw	17
	dw	L10647-1
	dw	18
	dw	L10648-1
	dw	19
	dw	L10649-1
	dw	L10650-1
L10644:
	lda	<L835+second_1
	brl	L10651
L10653:
	lda	[<L835+second_1+2]
	sta	<L835+ival2_2
	lda	<L835+isint_2
	and	#$ff
	bne	L854
	brl	L853
L854:
	lda	<L835+ival1_2
	bra	L855
L853:
	lda	|L10641+2
	pha
	lda	|L10641
	pha
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R0
	pla
	sta	<R0+2
	lda	<R0
L855:
	sta	[<L835+second_1+2]
	sep	#$20
	longa	off
	lda	#$1
	sta	<L835+isint_2
	rep	#$20
	longa	on
	brl	L10652
L10654:
	lda	[<L835+second_1+2]
	sta	|L10642
	ldy	#$2
	lda	[<L835+second_1+2],Y
	sta	|L10642+2
	lda	<L835+isint_2
	and	#$ff
	bne	L857
	brl	L856
L857:
	ldy	#$0
	lda	<L835+ival1_2
	bpl	L858
	dey
L858:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	bra	L859
L856:
	lda	|L10641+2
	pha
	lda	|L10641
	pha
L859:
	pla
	sta	[<L835+second_1+2]
	pla
	ldy	#$2
	sta	[<L835+second_1+2],Y
	sep	#$20
	longa	off
	stz	<L835+isint_2
	rep	#$20
	longa	on
	brl	L10652
L10655:
	pea	#<$1
	pei	<L835+second_1+2
	jsl	~~check_write
	lda	|~~basicvars+6
	sta	<R0
	lda	|~~basicvars+6+2
	sta	<R0+2
	ldy	<L835+second_1+2
	lda	[<R0],Y
	and	#$ff
	sta	<L835+ival2_2
	lda	|~~basicvars+6
	sta	<R0
	lda	|~~basicvars+6+2
	sta	<R0+2
	lda	<L835+isint_2
	and	#$ff
	bne	L861
	brl	L860
L861:
	lda	<L835+ival1_2
	bra	L862
L860:
	lda	|L10641+2
	pha
	lda	|L10641
	pha
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R1
	pla
	sta	<R1+2
	lda	<R1
L862:
	sep	#$20
	longa	off
	ldy	<L835+second_1+2
	sta	[<R0],Y
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	lda	#$1
	sta	<L835+isint_2
	rep	#$20
	longa	on
	brl	L10652
L10656:
	pei	<L835+second_1+2
	jsl	~~get_integer
	sta	<L835+ival2_2
	lda	<L835+isint_2
	and	#$ff
	bne	L864
	brl	L863
L864:
	lda	<L835+ival1_2
	bra	L865
L863:
	lda	|L10641+2
	pha
	lda	|L10641
	pha
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R0
	pla
	sta	<R0+2
	lda	<R0
L865:
	pha
	pei	<L835+second_1+2
	jsl	~~store_integer
	sep	#$20
	longa	off
	lda	#$1
	sta	<L835+isint_2
	rep	#$20
	longa	on
	brl	L10652
L10657:
	phy
	phy
	pei	<L835+second_1+2
	jsl	~~get_float
	pla
	sta	|L10642
	pla
	sta	|L10642+2
	lda	<L835+isint_2
	and	#$ff
	bne	L867
	brl	L866
L867:
	ldy	#$0
	lda	<L835+ival1_2
	bpl	L868
	dey
L868:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	bra	L869
L866:
	lda	|L10641+2
	pha
	lda	|L10641
	pha
L869:
	pei	<L835+second_1+2
	jsl	~~store_float
	sep	#$20
	longa	off
	stz	<L835+isint_2
	rep	#$20
	longa	on
	brl	L10652
L10658:
	pea	#^L682+10
	pea	#<L682+10
	pea	#<$8b5
	pea	#<$82
	pea	#10
	jsl	~~error
	brl	L10652
L10651:
	xref	~~~swt
	jsl	~~~swt
	dw	5
	dw	2
	dw	L10653-1
	dw	3
	dw	L10654-1
	dw	17
	dw	L10655-1
	dw	18
	dw	L10656-1
	dw	19
	dw	L10657-1
	dw	L10658-1
L10652:
	lda	<L835+first_1
	brl	L10659
L10661:
	lda	<L835+isint_2
	and	#$ff
	bne	L871
	brl	L870
L871:
	lda	<L835+ival2_2
	bra	L872
L870:
	lda	|L10642+2
	pha
	lda	|L10642
	pha
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R0
	pla
	sta	<R0+2
	lda	<R0
L872:
	sta	[<L835+first_1+2]
	brl	L10660
L10662:
	lda	<L835+isint_2
	and	#$ff
	bne	L874
	brl	L873
L874:
	ldy	#$0
	lda	<L835+ival2_2
	bpl	L875
	dey
L875:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	bra	L876
L873:
	lda	|L10642+2
	pha
	lda	|L10642
	pha
L876:
	pla
	sta	[<L835+first_1+2]
	pla
	ldy	#$2
	sta	[<L835+first_1+2],Y
	brl	L10660
L10663:
	lda	|~~basicvars+6
	sta	<R0
	lda	|~~basicvars+6+2
	sta	<R0+2
	lda	<L835+isint_2
	and	#$ff
	bne	L878
	brl	L877
L878:
	lda	<L835+ival2_2
	bra	L879
L877:
	lda	|L10642+2
	pha
	lda	|L10642
	pha
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R1
	pla
	sta	<R1+2
	lda	<R1
L879:
	sep	#$20
	longa	off
	ldy	<L835+first_1+2
	sta	[<R0],Y
	rep	#$20
	longa	on
	brl	L10660
L10664:
	lda	<L835+isint_2
	and	#$ff
	bne	L881
	brl	L880
L881:
	lda	<L835+ival2_2
	bra	L882
L880:
	lda	|L10642+2
	pha
	lda	|L10642
	pha
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R0
	pla
	sta	<R0+2
	lda	<R0
L882:
	pha
	pei	<L835+first_1+2
	jsl	~~store_integer
	brl	L10660
L10665:
	lda	<L835+isint_2
	and	#$ff
	bne	L884
	brl	L883
L884:
	ldy	#$0
	lda	<L835+ival2_2
	bpl	L885
	dey
L885:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	bra	L886
L883:
	lda	|L10642+2
	pha
	lda	|L10642
	pha
L886:
	pei	<L835+first_1+2
	jsl	~~store_float
	brl	L10660
L10666:
	pea	#^L682+20
	pea	#<L682+20
	pea	#<$8cb
	pea	#<$82
	pea	#10
	jsl	~~error
	brl	L10660
L10659:
	xref	~~~swt
	jsl	~~~swt
	dw	5
	dw	2
	dw	L10661-1
	dw	3
	dw	L10662-1
	dw	17
	dw	L10663-1
	dw	18
	dw	L10664-1
	dw	19
	dw	L10665-1
	dw	L10666-1
L10660:
	brl	L10667
L10640:
	lda	<L835+first_1
	cmp	#<$4
	bne	L888
	brl	L887
L888:
	lda	<L835+first_1
	cmp	#<$15
	beq	L889
	brl	L10668
L889:
L887:
stringtemp_3	set	12
	lda	<L835+second_1
	cmp	#<$4
	bne	L890
	brl	L10669
L890:
	lda	<L835+second_1
	cmp	#<$15
	bne	L891
	brl	L10669
L891:
	pea	#<$4e
	pea	#4
	jsl	~~error
L10669:
	lda	<L835+first_1
	cmp	#<$4
	beq	L892
	brl	L10670
L892:
	lda	<L835+second_1
	cmp	#<$4
	beq	L893
	brl	L10670
L893:
	pei	<L835+first_1+4
	pei	<L835+first_1+2
	clc
	tdc
	adc	#<L835+stringtemp_3
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	pei	<L835+second_1+4
	pei	<L835+second_1+2
	pei	<L835+first_1+4
	pei	<L835+first_1+2
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	clc
	tdc
	adc	#<L835+stringtemp_3
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L835+second_1+4
	pei	<L835+second_1+2
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	brl	L10671
L10670:
	lda	<L835+first_1
	cmp	#<$15
	beq	L894
	brl	L10672
L894:
	lda	<L835+second_1
	cmp	#<$15
	beq	L895
	brl	L10672
L895:
len1_4	set	18
len2_4	set	20
	pei	<L835+first_1+2
	jsl	~~get_stringlen
	sta	<R0
	lda	<R0
	ina
	sta	<L835+len1_4
	pei	<L835+second_1+2
	jsl	~~get_stringlen
	sta	<R0
	lda	<R0
	ina
	sta	<L835+len2_4
	pei	<L835+len2_4
	pei	<L835+first_1+2
	jsl	~~check_write
	pei	<L835+len1_4
	pei	<L835+second_1+2
	jsl	~~check_write
	ldy	#$0
	lda	<L835+len1_4
	bpl	L896
	dey
L896:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	ldy	#$0
	lda	<L835+first_1+2
	bpl	L897
	dey
L897:
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
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	jsl	~~memmove
	ldy	#$0
	lda	<L835+len2_4
	bpl	L898
	dey
L898:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	ldy	#$0
	lda	<L835+second_1+2
	bpl	L899
	dey
L899:
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
	ldy	#$0
	lda	<L835+first_1+2
	bpl	L900
	dey
L900:
	sta	<R1
	sty	<R1+2
	clc
	lda	|~~basicvars+6
	adc	<R1
	sta	<R3
	lda	|~~basicvars+6+2
	adc	<R1+2
	sta	<R3+2
	pei	<R3+2
	pei	<R3
	jsl	~~memmove
	ldy	#$0
	lda	<L835+len1_4
	bpl	L901
	dey
L901:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	ldy	#$0
	lda	<L835+second_1+2
	bpl	L902
	dey
L902:
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
	brl	L10673
L10672:
len_5	set	18
	lda	<L835+first_1
	cmp	#<$15
	beq	L903
	brl	L10674
L903:
temp_6	set	20
	clc
	tdc
	adc	#<L835+first_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L835+temp_6
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	clc
	tdc
	adc	#<L835+second_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L835+first_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	clc
	tdc
	adc	#<L835+temp_6
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L835+second_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
L10674:
	lda	[<L835+first_1+2]
	ina
	pha
	pei	<L835+second_1+2
	jsl	~~check_write
	pei	<L835+second_1+2
	jsl	~~get_stringlen
	sta	<L835+len_5
	lda	<L835+len_5
	sta	<L835+stringtemp_3
	pei	<L835+len_5
	jsl	~~alloc_string
	sta	<L835+stringtemp_3+2
	stx	<L835+stringtemp_3+4
	sec
	lda	#$0
	sbc	<L835+len_5
	bvs	L904
	eor	#$8000
L904:
	bpl	L905
	brl	L10675
L905:
	ldy	#$0
	lda	<L835+len_5
	bpl	L906
	dey
L906:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	ldy	#$0
	lda	<L835+second_1+2
	bpl	L907
	dey
L907:
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
	pei	<L835+stringtemp_3+4
	pei	<L835+stringtemp_3+2
	jsl	~~memmove
L10675:
	lda	[<L835+first_1+2]
	sta	<L835+len_5
	sec
	lda	#$0
	sbc	<L835+len_5
	bvs	L908
	eor	#$8000
L908:
	bpl	L909
	brl	L10676
L909:
	ldy	#$0
	lda	<L835+len_5
	bpl	L910
	dey
L910:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	ldy	#$4
	lda	[<L835+first_1+2],Y
	pha
	ldy	#$2
	lda	[<L835+first_1+2],Y
	pha
	ldy	#$0
	lda	<L835+second_1+2
	bpl	L911
	dey
L911:
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
L10676:
	clc
	lda	<L835+second_1+2
	adc	<L835+len_5
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
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	pei	<L835+first_1+4
	pei	<L835+first_1+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
	clc
	tdc
	adc	#<L835+stringtemp_3
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L835+first_1+4
	pei	<L835+first_1+2
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
L10673:
L10671:
	brl	L10677
L10668:
	lda	<L835+first_1
	and	#<$8
	bne	L912
	brl	L10678
L912:
arraytemp_7	set	12
	lda	<L835+second_1
	cmp	<L835+first_1
	bne	L913
	brl	L10679
L913:
	pea	#<$4e
	pea	#4
	jsl	~~error
L10679:
	lda	[<L835+first_1+2]
	sta	<L835+arraytemp_7
	ldy	#$2
	lda	[<L835+first_1+2],Y
	sta	<L835+arraytemp_7+2
	lda	[<L835+second_1+2]
	sta	[<L835+first_1+2]
	ldy	#$2
	lda	[<L835+second_1+2],Y
	ldy	#$2
	sta	[<L835+first_1+2],Y
	lda	<L835+arraytemp_7
	sta	[<L835+second_1+2]
	lda	<L835+arraytemp_7+2
	ldy	#$2
	sta	[<L835+second_1+2],Y
	brl	L10680
L10678:
	pea	#<$4e
	pea	#4
	jsl	~~error
L10680:
L10677:
L10667:
L914:
	pld
	tsc
	clc
	adc	#L834
	tcs
	rtl
L834	equ	42
L835	equ	17
	ends
	efunc
	data
L682:
	db	$6D,$61,$69,$6E,$73,$74,$61,$74,$65,$00,$6D,$61,$69,$6E,$73
	db	$74,$61,$74,$65,$00,$6D,$61,$69,$6E,$73,$74,$61,$74,$65,$00
	ends
	code
	xdef	~~exec_sys
	func
~~exec_sys:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L916
	tcs
	phd
	tcd
n_1	set	0
parmcount_1	set	2
flags_1	set	4
swino_1	set	6
inregs_1	set	8
outregs_1	set	28
parmtype_1	set	48
descriptor_1	set	50
tempdesc_1	set	56
destination_1	set	116
	inc	|~~basicvars+62
	bne	L918
	inc	|~~basicvars+62+2
L918:
	jsl	~~expression
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L917+parmtype_1
	lda	<L917+parmtype_1
	brl	L10681
L10683:
	jsl	~~pop_int
	sta	<L917+swino_1
	brl	L10682
L10684:
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
	sta	<L917+swino_1
	brl	L10682
L10685:
L10686:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L917+descriptor_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	pei	<L917+descriptor_1
	pei	<L917+descriptor_1+4
	pei	<L917+descriptor_1+2
	jsl	~~emulate_getswino
	sta	<L917+swino_1
	lda	<L917+parmtype_1
	cmp	#<$5
	beq	L919
	brl	L10687
L919:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L917+descriptor_1
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
L10687:
	brl	L10682
L10688:
	pea	#<$3f
	pea	#4
	jsl	~~error
	brl	L10682
L10681:
	xref	~~~fsw
	jsl	~~~fsw
	dw	2
	dw	4
	dw	L10688-1
	dw	L10683-1
	dw	L10684-1
	dw	L10685-1
	dw	L10686-1
L10682:
	stz	<L917+n_1
L10691:
	ldy	#$0
	lda	<L917+n_1
	bpl	L920
	dey
L920:
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
	tdc
	adc	#<L917+inregs_1
	sta	<R2
	lda	#$0
	sta	<R2+2
	clc
	lda	<R2
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	lda	#$0
	sta	[<R3]
	ldy	#$0
	lda	<L917+n_1
	bpl	L921
	dey
L921:
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
	tdc
	adc	#<L917+tempdesc_1
	sta	<R1
	lda	#$0
	sta	<R1+2
	clc
	lda	#$2
	adc	<R1
	sta	<R2
	lda	#$0
	adc	<R1+2
	sta	<R2+2
	clc
	lda	<R2
	adc	<R0
	sta	<R1
	lda	<R2+2
	adc	<R0+2
	sta	<R1+2
	lda	#$0
	sta	[<R1]
	lda	#$0
	ldy	#$2
	sta	[<R1],Y
L10689:
	inc	<L917+n_1
	sec
	lda	<L917+n_1
	sbc	#<$a
	bvs	L922
	eor	#$8000
L922:
	bmi	L923
	brl	L10691
L923:
L10690:
	stz	<L917+parmcount_1
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
	beq	L924
	brl	L10692
L924:
	inc	|~~basicvars+62
	bne	L925
	inc	|~~basicvars+62+2
L925:
L10692:
L10693:
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
	beq	L926
	brl	L10694
L926:
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	sep	#$20
	longa	off
	lda	[<R1]
	cmp	#<$e1
	rep	#$20
	longa	on
	bne	L927
	brl	L10694
L927:
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
	bne	L928
	brl	L10695
L928:
	jsl	~~expression
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L917+parmtype_1
	lda	<L917+parmtype_1
	brl	L10696
L10698:
	ldy	#$0
	lda	<L917+parmcount_1
	bpl	L929
	dey
L929:
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
	tdc
	adc	#<L917+inregs_1
	sta	<R2
	lda	#$0
	sta	<R2+2
	clc
	lda	<R2
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	jsl	~~pop_int
	sta	[<R3]
	brl	L10697
L10699:
	ldy	#$0
	lda	<L917+parmcount_1
	bpl	L930
	dey
L930:
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
	tdc
	adc	#<L917+inregs_1
	sta	<R2
	lda	#$0
	sta	<R2+2
	clc
	lda	<R2
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
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
	sta	[<R3]
	brl	L10697
L10700:
L10701:
length_2	set	122
cp_2	set	124
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L917+descriptor_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	lda	<L917+descriptor_1
	sta	<L917+length_2
	ldy	#$0
	lda	<L917+parmcount_1
	bpl	L931
	dey
L931:
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
	tdc
	adc	#<L917+tempdesc_1
	sta	<R1
	lda	#$0
	sta	<R1+2
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	lda	<R1+2
	adc	<R0+2
	sta	<R2+2
	lda	<L917+length_2
	ina
	sta	[<R2]
	ldy	#$0
	lda	<L917+parmcount_1
	bpl	L932
	dey
L932:
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
	tdc
	adc	#<L917+tempdesc_1
	sta	<R1
	lda	#$0
	sta	<R1+2
	clc
	lda	#$2
	adc	<R1
	sta	<R2
	lda	#$0
	adc	<R1+2
	sta	<R2+2
	clc
	lda	<R2
	adc	<R0
	sta	<R1
	lda	<R2+2
	adc	<R0+2
	sta	<R1+2
	lda	<L917+length_2
	ina
	pha
	jsl	~~alloc_string
	sta	<L917+cp_2
	stx	<L917+cp_2+2
	lda	<L917+cp_2
	sta	[<R1]
	lda	<L917+cp_2+2
	ldy	#$2
	sta	[<R1],Y
	sec
	lda	#$0
	sbc	<L917+length_2
	bvs	L933
	eor	#$8000
L933:
	bpl	L934
	brl	L10702
L934:
	ldy	#$0
	lda	<L917+length_2
	bpl	L935
	dey
L935:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L917+descriptor_1+4
	pei	<L917+descriptor_1+2
	pei	<L917+cp_2+2
	pei	<L917+cp_2
	jsl	~~memmove
L10702:
	sep	#$20
	longa	off
	lda	#$0
	ldy	<L917+length_2
	sta	[<L917+cp_2],Y
	rep	#$20
	longa	on
	lda	<L917+parmtype_1
	cmp	#<$5
	beq	L936
	brl	L10703
L936:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L917+descriptor_1
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
L10703:
	ldy	#$0
	lda	<L917+parmcount_1
	bpl	L937
	dey
L937:
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
	tdc
	adc	#<L917+inregs_1
	sta	<R2
	lda	#$0
	sta	<R2+2
	clc
	lda	<R2
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	sec
	lda	<L917+cp_2
	sbc	|~~basicvars+6
	sta	<R0
	lda	<L917+cp_2+2
	sbc	|~~basicvars+6+2
	sta	<R0+2
	lda	<R0
	sta	[<R3]
	brl	L10697
L10704:
	pea	#<$45
	pea	#4
	jsl	~~error
	brl	L10697
L10696:
	xref	~~~fsw
	jsl	~~~fsw
	dw	2
	dw	4
	dw	L10704-1
	dw	L10698-1
	dw	L10699-1
	dw	L10700-1
	dw	L10701-1
L10697:
L10695:
	inc	<L917+parmcount_1
	sec
	lda	<L917+parmcount_1
	sbc	#<$a
	bvs	L938
	eor	#$8000
L938:
	bmi	L939
	brl	L10705
L939:
	pea	#<$5b
	pea	#4
	jsl	~~error
L10705:
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
	beq	L940
	brl	L10706
L940:
	inc	|~~basicvars+62
	bne	L941
	inc	|~~basicvars+62+2
L941:
	brl	L10707
L10706:
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
	beq	L942
	brl	L10708
L942:
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	sep	#$20
	longa	off
	lda	[<R1]
	cmp	#<$e1
	rep	#$20
	longa	on
	bne	L943
	brl	L10708
L943:
	pea	#<$5
	pea	#4
	jsl	~~error
L10708:
L10707:
	brl	L10693
L10694:
	pea	#0
	clc
	tdc
	adc	#<L917+flags_1
	pha
	pea	#0
	clc
	tdc
	adc	#<L917+outregs_1
	pha
	pea	#0
	clc
	tdc
	adc	#<L917+inregs_1
	pha
	pei	<L917+swino_1
	jsl	~~emulate_sys
	stz	<L917+n_1
L10711:
	ldy	#$0
	lda	<L917+n_1
	bpl	L944
	dey
L944:
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
	tdc
	adc	#<L917+tempdesc_1
	sta	<R1
	lda	#$0
	sta	<R1+2
	clc
	lda	#$2
	adc	<R1
	sta	<R2
	lda	#$0
	adc	<R1+2
	sta	<R2+2
	clc
	lda	<R2
	adc	<R0
	sta	<R1
	lda	<R2+2
	adc	<R0+2
	sta	<R1+2
	lda	[<R1]
	ldy	#$2
	ora	[<R1],Y
	bne	L945
	brl	L10712
L945:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	ldy	#$0
	lda	<L917+n_1
	bpl	L946
	dey
L946:
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
	tdc
	adc	#<L917+tempdesc_1
	sta	<R2
	lda	#$0
	sta	<R2+2
	clc
	lda	<R2
	adc	<R1
	sta	<R3
	lda	<R2+2
	adc	<R1+2
	sta	<R3+2
	pei	<R3+2
	pei	<R3
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
L10712:
L10709:
	inc	<L917+n_1
	sec
	lda	<L917+n_1
	sbc	#<$a
	bvs	L947
	eor	#$8000
L947:
	bmi	L948
	brl	L10711
L948:
L10710:
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
	bne	L949
	brl	L10713
L949:
L950:
	pld
	tsc
	clc
	adc	#L916
	tcs
	rtl
L10713:
	inc	|~~basicvars+62
	bne	L951
	inc	|~~basicvars+62+2
L951:
	stz	<L917+parmcount_1
L10714:
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
	beq	L952
	brl	L10715
L952:
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	sep	#$20
	longa	off
	lda	[<R1]
	cmp	#<$3b
	rep	#$20
	longa	on
	bne	L953
	brl	L10715
L953:
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
	bne	L954
	brl	L10716
L954:
	pea	#0
	clc
	tdc
	adc	#<L917+destination_1
	pha
	jsl	~~get_lvalue
	pea	#<$0
	ldy	#$0
	lda	<L917+parmcount_1
	bpl	L955
	dey
L955:
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
	tdc
	adc	#<L917+outregs_1
	sta	<R2
	lda	#$0
	sta	<R2+2
	clc
	lda	<R2
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	lda	[<R3]
	pha
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L917+destination_1
	sta	<R2
	lda	#$0
	sta	<R2+2
	pei	<R2+2
	pei	<R2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~store_value
L10716:
	inc	<L917+parmcount_1
	sec
	lda	<L917+parmcount_1
	sbc	#<$a
	bvs	L956
	eor	#$8000
L956:
	bmi	L957
	brl	L10717
L957:
	pea	#<$5b
	pea	#4
	jsl	~~error
L10717:
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
	beq	L958
	brl	L10718
L958:
	inc	|~~basicvars+62
	bne	L959
	inc	|~~basicvars+62+2
L959:
	brl	L10719
L10718:
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
	beq	L960
	brl	L10720
L960:
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	sep	#$20
	longa	off
	lda	[<R1]
	cmp	#<$3b
	rep	#$20
	longa	on
	bne	L961
	brl	L10720
L961:
	pea	#<$5
	pea	#4
	jsl	~~error
L10720:
L10719:
	brl	L10714
L10715:
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
	beq	L962
	brl	L10721
L962:
	inc	|~~basicvars+62
	bne	L963
	inc	|~~basicvars+62+2
L963:
	pea	#0
	clc
	tdc
	adc	#<L917+destination_1
	pha
	jsl	~~get_lvalue
	pea	#<$1
	pei	<L917+flags_1
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L917+destination_1
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
L10721:
	jsl	~~check_ateol
	brl	L950
L916	equ	144
L917	equ	17
	ends
	efunc
	code
	xdef	~~exec_trace
	func
~~exec_trace:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L964
	tcs
	phd
	tcd
yes_1	set	0
option_1	set	1
	inc	|~~basicvars+62
	bne	L966
	inc	|~~basicvars+62+2
L966:
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
	beq	L967
	brl	L10722
L967:
	lda	#$1
	tsb	~~basicvars+425
	lda	#$2
	tsb	~~basicvars+425
	brl	L10723
L10722:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$c1
	rep	#$20
	longa	on
	beq	L968
	brl	L10724
L968:
	lda	#$1
	trb	~~basicvars+425
	lda	#$2
	trb	~~basicvars+425
	lda	#$4
	trb	~~basicvars+425
	lda	#$8
	trb	~~basicvars+425
	lda	#$10
	trb	~~basicvars+425
	brl	L10725
L10724:
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
	beq	L969
	brl	L10726
L969:
stringtype_2	set	2
descriptor_2	set	4
	inc	|~~basicvars+62
	bne	L970
	inc	|~~basicvars+62+2
L970:
	jsl	~~expression
	jsl	~~check_ateol
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L965+stringtype_2
	lda	<L965+stringtype_2
	cmp	#<$4
	bne	L971
	brl	L10727
L971:
	lda	<L965+stringtype_2
	cmp	#<$5
	bne	L972
	brl	L10727
L972:
	pea	#<$40
	pea	#4
	jsl	~~error
L10727:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L965+descriptor_2
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	pei	<L965+descriptor_2
	pei	<L965+descriptor_2+4
	pei	<L965+descriptor_2+2
	jsl	~~fileio_openout
	sta	|~~basicvars+427
	lda	<L965+stringtype_2
	cmp	#<$5
	beq	L973
	brl	L10728
L973:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L965+descriptor_2
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
L10728:
L974:
	pld
	tsc
	clc
	adc	#L964
	tcs
	rtl
L10726:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$96
	rep	#$20
	longa	on
	beq	L975
	brl	L10729
L975:
	lda	|~~basicvars+427
	bne	L976
	brl	L10730
L976:
	lda	|~~basicvars+427
	pha
	jsl	~~fileio_close
	stz	|~~basicvars+427
L10730:
	brl	L10731
L10729:
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
	bne	L977
	brl	L10732
L977:
	pea	#<$63
	pea	#4
	jsl	~~error
	brl	L10733
L10732:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<R0],Y
	sta	<L965+option_1
	rep	#$20
	longa	on
	lda	<L965+option_1
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	beq	L978
	brl	L10734
L978:
	sep	#$20
	longa	off
	lda	<L965+option_1
	cmp	#<$c2
	rep	#$20
	longa	on
	bne	L979
	brl	L10734
L979:
	sep	#$20
	longa	off
	lda	<L965+option_1
	cmp	#<$c1
	rep	#$20
	longa	on
	bne	L980
	brl	L10734
L980:
	pea	#<$63
	pea	#4
	jsl	~~error
L10734:
	stz	<R0
	sep	#$20
	longa	off
	lda	<L965+option_1
	cmp	#<$c1
	rep	#$20
	longa	on
	bne	L982
	brl	L981
L982:
	inc	<R0
L981:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L965+yes_1
	rep	#$20
	longa	on
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	brl	L10735
L10737:
L10738:
	lda	<L965+yes_1
	and	#$ff
	sta	<R0
	asl	<R0
	asl	<R0
	lda	<R0
	and	#<$4
	sta	<R0
	lda	#$4
	trb	|~~basicvars+425
	lda	<R0
	tsb	|~~basicvars+425
	brl	L10736
L10739:
	lda	<L965+yes_1
	and	#$ff
	sta	<R0
	asl	<R0
	asl	<R0
	asl	<R0
	asl	<R0
	lda	<R0
	and	#<$10
	sta	<R0
	lda	#$10
	trb	|~~basicvars+425
	lda	<R0
	tsb	|~~basicvars+425
	brl	L10736
L10740:
	lda	<L965+yes_1
	and	#$ff
	sta	<R0
	asl	<R0
	asl	<R0
	asl	<R0
	lda	<R0
	and	#<$8
	sta	<R0
	lda	#$8
	trb	|~~basicvars+425
	lda	<R0
	tsb	|~~basicvars+425
	brl	L10736
L10741:
	lda	<L965+yes_1
	and	#$ff
	sta	<R0
	asl	<R0
	asl	<R0
	asl	<R0
	asl	<R0
	asl	<R0
	lda	<R0
	and	#<$20
	sta	<R0
	lda	#$20
	trb	|~~basicvars+425
	lda	<R0
	tsb	|~~basicvars+425
	brl	L10736
L10742:
	pea	#<$63
	pea	#4
	jsl	~~error
	brl	L10736
L10735:
	xref	~~~swt
	jsl	~~~swt
	dw	5
	dw	173
	dw	L10738-1
	dw	177
	dw	L10739-1
	dw	205
	dw	L10737-1
	dw	213
	dw	L10741-1
	dw	217
	dw	L10740-1
	dw	L10742-1
L10736:
	stz	<R0
	lda	|~~basicvars+425
	bit	#$4
	beq	L985
	brl	L984
L985:
	lda	|~~basicvars+425
	bit	#$10
	bne	L986
	brl	L983
L986:
L984:
	inc	<R0
L983:
	lda	<R0
	and	#<$1
	sta	<R0
	lda	#$1
	trb	|~~basicvars+425
	lda	<R0
	tsb	|~~basicvars+425
	lda	<L965+option_1
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
	beq	L987
	brl	L10743
L987:
	inc	|~~basicvars+62
	bne	L988
	inc	|~~basicvars+62+2
L988:
L10743:
L10733:
L10731:
L10725:
L10723:
	inc	|~~basicvars+62
	bne	L989
	inc	|~~basicvars+62+2
L989:
	jsl	~~check_ateol
	brl	L974
L964	equ	18
L965	equ	9
	ends
	efunc
	code
	xdef	~~exec_until
	func
~~exec_until:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L990
	tcs
	phd
	tcd
here_1	set	0
rp_1	set	4
result_1	set	8
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$14
	beq	L992
	brl	L10744
L992:
	lda	|~~basicvars+42
	sta	<L991+rp_1
	lda	|~~basicvars+42+2
	sta	<L991+rp_1+2
	brl	L10745
L10744:
	jsl	~~get_repeat
	sta	<L991+rp_1
	stx	<L991+rp_1+2
L10745:
	lda	<L991+rp_1
	ora	<L991+rp_1+2
	beq	L993
	brl	L10746
L993:
	pea	#<$34
	pea	#4
	jsl	~~error
L10746:
	lda	|~~basicvars+489
	and	#$ff
	bne	L994
	brl	L10747
L994:
	pea	#<$8
	pea	#4
	jsl	~~error
L10747:
	lda	|~~basicvars+62
	sta	<L991+here_1
	lda	|~~basicvars+62+2
	sta	<L991+here_1+2
	inc	|~~basicvars+62
	bne	L995
	inc	|~~basicvars+62+2
L995:
	jsl	~~expression
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$2
	beq	L996
	brl	L10748
L996:
	jsl	~~pop_int
	sta	<L991+result_1
	brl	L10749
L10748:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$3
	beq	L997
	brl	L10750
L997:
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
	sta	<L991+result_1
	brl	L10751
L10750:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10751:
L10749:
	lda	<L991+result_1
	beq	L998
	brl	L10752
L998:
	lda	|~~basicvars+425
	bit	#$10
	bne	L999
	brl	L10753
L999:
	ldy	#$4
	lda	[<L991+rp_1],Y
	pha
	ldy	#$2
	lda	[<L991+rp_1],Y
	pha
	pei	<L991+here_1+2
	pei	<L991+here_1
	jsl	~~trace_branch
L10753:
	ldy	#$2
	lda	[<L991+rp_1],Y
	sta	|~~basicvars+62
	ldy	#$4
	lda	[<L991+rp_1],Y
	sta	|~~basicvars+62+2
	brl	L10754
L10752:
	jsl	~~pop_repeat
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
	beq	L1000
	brl	L10755
L1000:
	pea	#<$5
	pea	#4
	jsl	~~error
L10755:
L10754:
L1001:
	pld
	tsc
	clc
	adc	#L990
	tcs
	rtl
L990	equ	14
L991	equ	5
	ends
	efunc
	code
	xdef	~~exec_wait
	func
~~exec_wait:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1002
	tcs
	phd
	tcd
	inc	|~~basicvars+62
	bne	L1004
	inc	|~~basicvars+62+2
L1004:
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
	bne	L1005
	brl	L10756
L1005:
	jsl	~~emulate_wait
	brl	L10757
L10756:
delay_2	set	0
	jsl	~~eval_integer
	sta	<L1003+delay_2
	jsl	~~check_ateol
	pei	<L1003+delay_2
	jsl	~~emulate_waitdelay
L10757:
L1006:
	pld
	tsc
	clc
	adc	#L1002
	tcs
	rtl
L1002	equ	6
L1003	equ	5
	ends
	efunc
	code
	xdef	~~exec_xwhen
	func
~~exec_xwhen:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1007
	tcs
	phd
	tcd
lp_1	set	0
lp2_1	set	4
depth_1	set	8
	clc
	lda	#$3
	adc	|~~basicvars+62
	sta	<L1008+lp_1
	lda	#$0
	adc	|~~basicvars+62+2
	sta	<L1008+lp_1+2
L10758:
	lda	[<L1008+lp_1]
	and	#$ff
	bne	L1009
	brl	L10759
L1009:
	pei	<L1008+lp_1+2
	pei	<L1008+lp_1
	jsl	~~skip_token
	sta	<L1008+lp_1
	stx	<L1008+lp_1+2
	brl	L10758
L10759:
	inc	<L1008+lp_1
	bne	L1010
	inc	<L1008+lp_1+2
L1010:
	lda	#$1
	sta	<L1008+depth_1
L10762:
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L1008+lp_1],Y
	cmp	#<$ff
	rep	#$20
	longa	on
	beq	L1011
	brl	L10763
L1011:
	pea	#<$2f
	pea	#4
	jsl	~~error
L10763:
	ldy	#$5
	lda	[<L1008+lp_1],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L1012
	dey
L1012:
	sta	<R0
	sty	<R0+2
	ldy	#$4
	lda	[<L1008+lp_1],Y
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
	lda	<L1008+lp_1
	adc	<R2
	sta	<L1008+lp2_1
	lda	<L1008+lp_1+2
	adc	<R2+2
	sta	<L1008+lp2_1+2
	sep	#$20
	longa	off
	lda	[<L1008+lp2_1]
	cmp	#<$a4
	rep	#$20
	longa	on
	beq	L1013
	brl	L10764
L1013:
	dec	<L1008+depth_1
	lda	<L1008+depth_1
	bne	L1014
	brl	L10761
L1014:
	brl	L10765
L10764:
L10766:
	lda	[<L1008+lp2_1]
	and	#$ff
	bne	L1015
	brl	L10767
L1015:
	sep	#$20
	longa	off
	lda	[<L1008+lp2_1]
	cmp	#<$90
	rep	#$20
	longa	on
	bne	L1016
	brl	L10767
L1016:
	sep	#$20
	longa	off
	lda	[<L1008+lp2_1]
	cmp	#<$91
	rep	#$20
	longa	on
	bne	L1017
	brl	L10767
L1017:
	pei	<L1008+lp2_1+2
	pei	<L1008+lp2_1
	jsl	~~skip_token
	sta	<L1008+lp2_1
	stx	<L1008+lp2_1+2
	brl	L10766
L10767:
	lda	[<L1008+lp2_1]
	and	#$ff
	bne	L1018
	brl	L10768
L1018:
	inc	<L1008+depth_1
L10768:
L10765:
	ldy	#$2
	lda	[<L1008+lp_1],Y
	and	#$ff
	sta	<R0
	ldy	#$3
	lda	[<L1008+lp_1],Y
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
	bpl	L1019
	dey
L1019:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L1008+lp_1
	adc	<R0
	sta	<L1008+lp_1
	lda	<L1008+lp_1+2
	adc	<R0+2
	sta	<L1008+lp_1+2
L10760:
	brl	L10762
L10761:
	inc	<L1008+lp2_1
	bne	L1020
	inc	<L1008+lp2_1+2
L1020:
	sep	#$20
	longa	off
	lda	[<L1008+lp2_1]
	cmp	#<$3a
	rep	#$20
	longa	on
	beq	L1021
	brl	L10769
L1021:
	inc	<L1008+lp2_1
	bne	L1022
	inc	<L1008+lp2_1+2
L1022:
L10769:
	lda	[<L1008+lp2_1]
	and	#$ff
	beq	L1023
	brl	L10770
L1023:
	inc	<L1008+lp2_1
	bne	L1024
	inc	<L1008+lp2_1+2
L1024:
	ldy	#$5
	lda	[<L1008+lp2_1],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L1025
	dey
L1025:
	sta	<R0
	sty	<R0+2
	ldy	#$4
	lda	[<L1008+lp2_1],Y
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
	lda	<L1008+lp2_1
	adc	<R2
	sta	<L1008+lp2_1
	lda	<L1008+lp2_1+2
	adc	<R2+2
	sta	<L1008+lp2_1+2
L10770:
	pei	<L1008+lp2_1+2
	pei	<L1008+lp2_1
	clc
	lda	#$1
	adc	|~~basicvars+62
	sta	<R0
	lda	#$0
	adc	|~~basicvars+62+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~set_dest
	jsl	~~exec_elsewhen
L1026:
	pld
	tsc
	clc
	adc	#L1007
	tcs
	rtl
L1007	equ	22
L1008	equ	13
	ends
	efunc
	code
	xdef	~~exec_while
	func
~~exec_while:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1027
	tcs
	phd
	tcd
expr_1	set	0
here_1	set	4
result_1	set	8
	lda	|~~basicvars+62
	sta	<L1028+here_1
	lda	|~~basicvars+62+2
	sta	<L1028+here_1+2
	clc
	lda	#$3
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L1029
	inc	|~~basicvars+62+2
L1029:
	lda	|~~basicvars+62
	sta	<L1028+expr_1
	lda	|~~basicvars+62+2
	sta	<L1028+expr_1+2
	jsl	~~expression
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$2
	beq	L1030
	brl	L10771
L1030:
	jsl	~~pop_int
	sta	<L1028+result_1
	brl	L10772
L10771:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$3
	beq	L1031
	brl	L10773
L1031:
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
	sta	<L1028+result_1
	brl	L10774
L10773:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10774:
L10772:
	lda	<L1028+result_1
	bne	L1032
	brl	L10775
L1032:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$3a
	rep	#$20
	longa	on
	beq	L1033
	brl	L10776
L1033:
	inc	|~~basicvars+62
	bne	L1034
	inc	|~~basicvars+62+2
L1034:
L10776:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	beq	L1035
	brl	L10777
L1035:
	inc	|~~basicvars+62
	bne	L1036
	inc	|~~basicvars+62+2
L1036:
	lda	|~~basicvars+425
	bit	#$2
	bne	L1037
	brl	L10778
L1037:
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~get_lineno
	pha
	jsl	~~trace_line
L10778:
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	ldy	#$5
	lda	[<R1],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L1038
	dey
L1038:
	sta	<R0
	sty	<R0+2
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	ldy	#$4
	lda	[<R1],Y
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
	lda	|~~basicvars+62
	adc	<R2
	sta	|~~basicvars+62
	lda	|~~basicvars+62+2
	adc	<R2+2
	sta	|~~basicvars+62+2
L10777:
	pei	<L1028+expr_1+2
	pei	<L1028+expr_1
	jsl	~~push_while
	brl	L10779
L10775:
	sep	#$20
	longa	off
	lda	[<L1028+here_1]
	cmp	#<$ec
	rep	#$20
	longa	on
	beq	L1039
	brl	L10780
L1039:
	inc	<L1028+here_1
	bne	L1040
	inc	<L1028+here_1+2
L1040:
	lda	[<L1028+here_1]
	and	#$ff
	sta	<R0
	ldy	#$1
	lda	[<L1028+here_1],Y
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
	bpl	L1041
	dey
L1041:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L1028+here_1
	adc	<R0
	sta	|~~basicvars+62
	lda	<L1028+here_1+2
	adc	<R0+2
	sta	|~~basicvars+62+2
	lda	|~~basicvars+425
	bit	#$10
	bne	L1042
	brl	L10781
L1042:
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	pei	<L1028+here_1+2
	pei	<L1028+here_1
	jsl	~~trace_branch
L10781:
	brl	L10782
L10780:
depth_2	set	10
	lda	#$1
	sta	<L1028+depth_2
L10783:
	sec
	lda	#$0
	sbc	<L1028+depth_2
	bvs	L1043
	eor	#$8000
L1043:
	bpl	L1044
	brl	L10784
L1044:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	beq	L1045
	brl	L10785
L1045:
	inc	|~~basicvars+62
	bne	L1046
	inc	|~~basicvars+62+2
L1046:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<R0],Y
	cmp	#<$ff
	rep	#$20
	longa	on
	beq	L1047
	brl	L10786
L1047:
	pea	#<$2e
	pea	#4
	jsl	~~error
L10786:
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	ldy	#$5
	lda	[<R1],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L1048
	dey
L1048:
	sta	<R0
	sty	<R0+2
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	ldy	#$4
	lda	[<R1],Y
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
	lda	|~~basicvars+62
	adc	<R2
	sta	|~~basicvars+62
	lda	|~~basicvars+62+2
	adc	<R2+2
	sta	|~~basicvars+62+2
L10785:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$a7
	rep	#$20
	longa	on
	beq	L1049
	brl	L10787
L1049:
	dec	<L1028+depth_2
	brl	L10788
L10787:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$ec
	rep	#$20
	longa	on
	bne	L1051
	brl	L1050
L1051:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$eb
	rep	#$20
	longa	on
	beq	L1052
	brl	L10789
L1052:
L1050:
	inc	<L1028+depth_2
L10789:
L10788:
	sec
	lda	#$0
	sbc	<L1028+depth_2
	bvs	L1053
	eor	#$8000
L1053:
	bpl	L1054
	brl	L10790
L1054:
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~skip_token
	sta	|~~basicvars+62
	stx	|~~basicvars+62+2
L10790:
	brl	L10783
L10784:
	inc	|~~basicvars+62
	bne	L1055
	inc	|~~basicvars+62+2
L1055:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$3a
	rep	#$20
	longa	on
	beq	L1056
	brl	L10791
L1056:
	inc	|~~basicvars+62
	bne	L1057
	inc	|~~basicvars+62+2
L1057:
L10791:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	beq	L1058
	brl	L10792
L1058:
	inc	|~~basicvars+62
	bne	L1059
	inc	|~~basicvars+62+2
L1059:
	lda	|~~basicvars+425
	bit	#$2
	bne	L1060
	brl	L10793
L1060:
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~get_lineno
	pha
	jsl	~~trace_line
L10793:
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	ldy	#$5
	lda	[<R1],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L1061
	dey
L1061:
	sta	<R0
	sty	<R0+2
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	ldy	#$4
	lda	[<R1],Y
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
	lda	|~~basicvars+62
	adc	<R2
	sta	|~~basicvars+62
	lda	|~~basicvars+62+2
	adc	<R2+2
	sta	|~~basicvars+62+2
L10792:
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	clc
	lda	#$1
	adc	<L1028+here_1
	sta	<R0
	lda	#$0
	adc	<L1028+here_1+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~set_dest
	sep	#$20
	longa	off
	lda	#$ec
	sta	[<L1028+here_1]
	rep	#$20
	longa	on
	lda	|~~basicvars+425
	bit	#$10
	bne	L1062
	brl	L10794
L1062:
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	pei	<L1028+here_1+2
	pei	<L1028+here_1
	jsl	~~trace_branch
L10794:
L10782:
L10779:
L1063:
	pld
	tsc
	clc
	adc	#L1027
	tcs
	rtl
L1027	equ	24
L1028	equ	13
	ends
	efunc
	xref	~~fileio_close
	xref	~~fileio_openout
	xref	~~get_lvalue
	xref	~~emulate_wait
	xref	~~emulate_on
	xref	~~emulate_vdustr
	xref	~~emulate_call
	xref	~~emulate_sys
	xref	~~emulate_getswino
	xref	~~emulate_waitdelay
	xref	~~emulate_endeq
	xref	~~emulate_oscli
	xref	~~read_library
	xref	~~read_basic
	xref	~~secure_tmpnam
	xref	~~restore_current
	xref	~~save_current
	xref	~~find_linestart
	xref	~~find_line
	xref	~~tocstring
	xref	~~skip
	xref	~~store_float
	xref	~~store_integer
	xref	~~check_write
	xref	~~init_expressions
	xref	~~push_parameters
	xref	~~eval_intfactor
	xref	~~eval_integer
	xref	~~expression
	xref	~~get_float
	xref	~~get_integer
	xref	~~end_run
	xref	~~store_value
	xref	~~check_ateol
	xref	~~isateol
	xref	~~trace_branch
	xref	~~trace_proc
	xref	~~trace_line
	xref	~~run_program
	xref	~~clear_error
	xref	~~set_local_error
	xref	~~set_error
	xref	~~show_error
	xref	~~get_lasterror
	xref	~~error
	xref	~~get_stringlen
	xref	~~clear_strings
	xref	~~free_string
	xref	~~alloc_string
	xref	~~clear_heap
	xref	~~condalloc
	xref	~~allocmem
	xref	~~clear_stack
	xref	~~empty_stack
	xref	~~restore_parameters
	xref	~~save_array
	xref	~~save_string
	xref	~~save_float
	xref	~~save_int
	xref	~~pop_error
	xref	~~pop_data
	xref	~~pop_for
	xref	~~pop_repeat
	xref	~~pop_while
	xref	~~get_for
	xref	~~get_repeat
	xref	~~get_while
	xref	~~pop_gosub
	xref	~~pop_fn
	xref	~~pop_proc
	xref	~~pop_string
	xref	~~pop_float
	xref	~~pop_int
	xref	~~push_error
	xref	~~push_data
	xref	~~push_floatfor
	xref	~~push_intfor
	xref	~~push_repeat
	xref	~~push_while
	xref	~~push_gosub
	xref	~~push_proc
	xref	~~push_strtemp
	xref	~~alloc_stackmem
	xref	~~define_array
	xref	~~create_variable
	xref	~~find_fnproc
	xref	~~find_variable
	xref	~~clear_varlists
	xref	~~clear_varptrs
	xref	~~get_linenum
	xref	~~get_lineno
	xref	~~get_srcaddr
	xref	~~set_address
	xref	~~set_dest
	xref	~~skip_name
	xref	~~skip_token
	xref	~~tokenize
	xref	~~exit_interpreter
	xref	~~__errno_location
	xref	~~strerror
	xref	~~strlen
	xref	~~memcmp
	xref	~~memmove
	xref	~~malloc
	xref	~~remove
	xref	~~ferror
	xref	~~feof
	xref	~~fclose
	xref	~~fgets
	xref	~~fopen
	xref	~~ateol
	xref	~~nullstring
	xref	~~basicvars
	end
