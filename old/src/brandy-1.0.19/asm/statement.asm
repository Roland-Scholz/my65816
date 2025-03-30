;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
	data
	xdef	~~ateol
~~ateol:
	db	$1,$0,$0,$0,$0,$0,$0,$0,$0,$0
	db	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	db	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	db	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	db	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	db	$0,$0,$0,$0,$0,$0,$0,$0,$1,$0
	db	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	db	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	db	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	db	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	db	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	db	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	db	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	db	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	db	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	db	$0,$0,$0,$0,$0,$0,$0,$0,$0,$1
	db	$1,$0,$0,$0,$0,$0,$0,$0,$0,$0
	db	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	db	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	db	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	db	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	db	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	db	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	db	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	db	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	db	$0,$0,$0,$0,$0,$0
	ends
	code
	xdef	~~init_interpreter
	func
~~init_interpreter:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
	stz	|~~basicvars+62
	stz	|~~basicvars+62+2
	jsl	~~init_stack
	jsl	~~init_expressions
	jsl	~~init_staticvars
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
	xdef	~~trace_line
	func
~~trace_line:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L5
	tcs
	phd
	tcd
lineno_0	set	4
len_1	set	0
	pei	<L5+lineno_0
	pea	#^L1
	pea	#<L1
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	pea	#12
	jsl	~~sprintf
	sta	<L6+len_1
	lda	|~~basicvars+427
	beq	L7
	brl	L10001
L7:
	pei	<L6+len_1
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	jsl	~~emulate_vdustr
	brl	L10002
L10001:
	pei	<L6+len_1
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	lda	|~~basicvars+427
	pha
	jsl	~~fileio_bputstr
L10002:
L8:
	lda	<L5+2
	sta	<L5+2+2
	lda	<L5+1
	sta	<L5+1+2
	pld
	tsc
	clc
	adc	#L5+2
	tcs
	rtl
L5	equ	2
L6	equ	1
	ends
	efunc
	data
L1:
	db	$5B,$25,$64,$5D,$00
	ends
	code
	xdef	~~trace_proc
	func
~~trace_proc:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L10
	tcs
	phd
	tcd
np_0	set	4
entering_0	set	8
len_1	set	0
what_1	set	2
	sep	#$20
	longa	off
	lda	[<L10+np_0]
	cmp	#<$cd
	rep	#$20
	longa	on
	beq	L13
	brl	L12
L13:
	lda	#^L9
	tax
	lda	#<L9
	bra	L14
L12:
	lda	#^L9+5
	tax
	lda	#<L9+5
L14:
	sta	<R0
	stx	<R0+2
	lda	<R0
	sta	<L11+what_1
	lda	<R0+2
	sta	<L11+what_1+2
	inc	<L10+np_0
	bne	L15
	inc	<L10+np_0+2
L15:
	lda	<L10+entering_0
	and	#$ff
	bne	L16
	brl	L10003
L16:
	pei	<L10+np_0+2
	pei	<L10+np_0
	pei	<L11+what_1+2
	pei	<L11+what_1
	pea	#^L9+8
	pea	#<L9+8
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	pea	#18
	jsl	~~sprintf
	sta	<L11+len_1
	brl	L10004
L10003:
	pei	<L10+np_0+2
	pei	<L10+np_0
	pei	<L11+what_1+2
	pei	<L11+what_1
	pea	#^L9+17
	pea	#<L9+17
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	pea	#18
	jsl	~~sprintf
	sta	<L11+len_1
L10004:
	lda	|~~basicvars+427
	beq	L17
	brl	L10005
L17:
	pei	<L11+len_1
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	jsl	~~emulate_vdustr
	brl	L10006
L10005:
	pei	<L11+len_1
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	lda	|~~basicvars+427
	pha
	jsl	~~fileio_bputstr
L10006:
L18:
	lda	<L10+2
	sta	<L10+2+6
	lda	<L10+1
	sta	<L10+1+6
	pld
	tsc
	clc
	adc	#L10+6
	tcs
	rtl
L10	equ	10
L11	equ	5
	ends
	efunc
	data
L9:
	db	$50,$52,$4F,$43,$00,$46,$4E,$00,$3D,$3D,$3E,$25,$73,$25,$73
	db	$20,$00,$25,$73,$25,$73,$2D,$2D,$3E,$20,$00
	ends
	code
	xdef	~~trace_branch
	func
~~trace_branch:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L20
	tcs
	phd
	tcd
from_0	set	4
to_0	set	8
len_1	set	0
fromline_1	set	2
toline_1	set	6
	pei	<L20+from_0+2
	pei	<L20+from_0
	jsl	~~find_linestart
	sta	<L21+fromline_1
	stx	<L21+fromline_1+2
	pei	<L20+to_0+2
	pei	<L20+to_0
	jsl	~~find_linestart
	sta	<L21+toline_1
	stx	<L21+toline_1+2
	lda	<L21+fromline_1
	ora	<L21+fromline_1+2
	bne	L23
	brl	L22
L23:
	lda	<L21+toline_1
	ora	<L21+toline_1+2
	beq	L24
	brl	L10007
L24:
L22:
L25:
	lda	<L20+2
	sta	<L20+2+8
	lda	<L20+1
	sta	<L20+1+8
	pld
	tsc
	clc
	adc	#L20+8
	tcs
	rtl
L10007:
	pei	<L21+toline_1+2
	pei	<L21+toline_1
	jsl	~~get_lineno
	pha
	pei	<L21+fromline_1+2
	pei	<L21+fromline_1
	jsl	~~get_lineno
	pha
	pea	#^L19
	pea	#<L19
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	pea	#14
	jsl	~~sprintf
	sta	<L21+len_1
	lda	|~~basicvars+427
	beq	L26
	brl	L10008
L26:
	pei	<L21+len_1
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	jsl	~~emulate_vdustr
	brl	L10009
L10008:
	pei	<L21+len_1
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	lda	|~~basicvars+427
	pha
	jsl	~~fileio_bputstr
L10009:
	brl	L25
L20	equ	10
L21	equ	1
	ends
	efunc
	data
L19:
	db	$5B,$25,$64,$2D,$3E,$25,$64,$5D,$00
	ends
	code
	xdef	~~bad_token
	func
~~bad_token:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L28
	tcs
	phd
	tcd
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	pha
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	pea	#^L27
	pea	#<L27
	lda	|~~stderr+2
	pha
	lda	|~~stderr
	pha
	pea	#16
	jsl	~~fprintf
	pea	#^L27+30
	pea	#<L27+30
	pea	#<$a7
	pea	#<$82
	pea	#10
	jsl	~~error
L30:
	pld
	tsc
	clc
	adc	#L28
	tcs
	rtl
L28	equ	4
L29	equ	5
	ends
	efunc
	data
L27:
	db	$42,$61,$64,$20,$74,$6F,$6B,$65,$6E,$20,$61,$74,$20,$25,$70
	db	$2C,$20,$76,$61,$6C,$75,$65,$3D,$26,$25,$30,$32,$78,$0A,$00
	db	$73,$74,$61,$74,$65,$6D,$65,$6E,$74,$00
	ends
	code
	xdef	~~bad_syntax
	func
~~bad_syntax:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L32
	tcs
	phd
	tcd
	pea	#<$5
	pea	#4
	jsl	~~error
L34:
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
~~flag_badline:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L35
	tcs
	phd
	tcd
	inc	|~~basicvars+62
	bne	L37
	inc	|~~basicvars+62+2
L37:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	pha
	pea	#4
	jsl	~~error
L38:
	pld
	tsc
	clc
	adc	#L35
	tcs
	rtl
L35	equ	4
L36	equ	5
	ends
	efunc
	code
	xdef	~~isateol
	func
~~isateol:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L39
	tcs
	phd
	tcd
p_0	set	4
	lda	[<L39+p_0]
	and	#$ff
	sta	<R0
	ldx	<R0
	lda	|~~ateol,X
	and	#$ff
L41:
	tay
	lda	<L39+2
	sta	<L39+2+4
	lda	<L39+1
	sta	<L39+1+4
	pld
	tsc
	clc
	adc	#L39+4
	tcs
	tya
	rtl
L39	equ	4
L40	equ	5
	ends
	efunc
	code
	xdef	~~check_ateol
	func
~~check_ateol:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L42
	tcs
	phd
	tcd
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
	beq	L44
	brl	L10010
L44:
	pea	#<$5
	pea	#4
	jsl	~~error
L10010:
L45:
	pld
	tsc
	clc
	adc	#L42
	tcs
	rtl
L42	equ	4
L43	equ	5
	ends
	efunc
	code
	func
~~skip_colon:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L46
	tcs
	phd
	tcd
	inc	|~~basicvars+62
	bne	L48
	inc	|~~basicvars+62+2
L48:
L49:
	pld
	tsc
	clc
	adc	#L46
	tcs
	rtl
L46	equ	0
L47	equ	1
	ends
	efunc
	code
	xdef	~~end_run
	func
~~end_run:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L50
	tcs
	phd
	tcd
	lda	#$1
	trb	~~basicvars+423
	sep	#$20
	longa	off
	stz	|~~basicvars+489
	rep	#$20
	longa	on
	stz	|~~basicvars+399
	stz	|~~basicvars+399+2
	stz	|~~basicvars+403
	stz	|~~basicvars+403+2
	stz	|~~basicvars+62
	stz	|~~basicvars+62+2
	jsl	~~clear_error
	lda	|~~basicvars+423
	bit	#$4
	bne	L52
	brl	L10011
L52:
	pea	#<$0
	jsl	~~exit_interpreter
L10011:
	pea	#<$1
	lda	#<~~basicvars+74
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~longjmp
L53:
	pld
	tsc
	clc
	adc	#L50
	tcs
	rtl
L50	equ	4
L51	equ	5
	ends
	efunc
	code
	func
~~next_line:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L54
	tcs
	phd
	tcd
lp_1	set	0
	clc
	lda	#$1
	adc	|~~basicvars+62
	sta	<L55+lp_1
	lda	#$0
	adc	|~~basicvars+62+2
	sta	<L55+lp_1+2
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L55+lp_1],Y
	cmp	#<$ff
	rep	#$20
	longa	on
	beq	L56
	brl	L10012
L56:
	jsl	~~end_run
L10012:
	lda	|~~basicvars+425
	bit	#$2
	bne	L57
	brl	L10013
L57:
	pei	<L55+lp_1+2
	pei	<L55+lp_1
	jsl	~~get_lineno
	pha
	jsl	~~trace_line
L10013:
	ldy	#$5
	lda	[<L55+lp_1],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L58
	dey
L58:
	sta	<R0
	sty	<R0+2
	ldy	#$4
	lda	[<L55+lp_1],Y
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
	lda	<L55+lp_1
	adc	<R2
	sta	|~~basicvars+62
	lda	<L55+lp_1+2
	adc	<R2+2
	sta	|~~basicvars+62+2
L59:
	pld
	tsc
	clc
	adc	#L54
	tcs
	rtl
L54	equ	16
L55	equ	13
	ends
	efunc
	code
	xdef	~~store_value
	func
~~store_value:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L60
	tcs
	phd
	tcd
destination_0	set	4
value_0	set	10
nostring_0	set	12
length_1	set	0
cp_1	set	2
	lda	<L60+destination_0
	brl	L10014
L10016:
	lda	<L60+value_0
	sta	[<L60+destination_0+2]
	brl	L10015
L10017:
	ldy	#$0
	lda	<L60+value_0
	bpl	L62
	dey
L62:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	pla
	sta	[<L60+destination_0+2]
	pla
	ldy	#$2
	sta	[<L60+destination_0+2],Y
	brl	L10015
L10018:
	lda	<L60+nostring_0
	and	#$ff
	bne	L63
	brl	L10019
L63:
	pea	#<$43
	pea	#4
	jsl	~~error
L10019:
	ldy	#$0
	lda	<L60+value_0
	bpl	L64
	dey
L64:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~strlen
	sta	<L61+length_1
	sec
	lda	#$1000
	sbc	<L61+length_1
	bvs	L65
	eor	#$8000
L65:
	bpl	L66
	brl	L10020
L66:
	pea	#<$3d
	pea	#4
	jsl	~~error
L10020:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	pei	<L60+destination_0+4
	pei	<L60+destination_0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
	pei	<L61+length_1
	jsl	~~alloc_string
	sta	<L61+cp_1
	stx	<L61+cp_1+2
	sec
	lda	#$0
	sbc	<L61+length_1
	bvs	L67
	eor	#$8000
L67:
	bpl	L68
	brl	L10021
L68:
	ldy	#$0
	lda	<L61+length_1
	bpl	L69
	dey
L69:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	ldy	#$0
	lda	<L60+value_0
	bpl	L70
	dey
L70:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<L61+cp_1+2
	pei	<L61+cp_1
	jsl	~~memmove
L10021:
	lda	<L61+length_1
	sta	[<L60+destination_0+2]
	lda	<L61+cp_1
	ldy	#$2
	sta	[<L60+destination_0+2],Y
	lda	<L61+cp_1+2
	ldy	#$4
	sta	[<L60+destination_0+2],Y
	brl	L10015
L10022:
	pea	#<$1
	pei	<L60+destination_0+2
	jsl	~~check_write
	lda	|~~basicvars+6
	sta	<R0
	lda	|~~basicvars+6+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	<L60+value_0
	ldy	<L60+destination_0+2
	sta	[<R0],Y
	rep	#$20
	longa	on
	brl	L10015
L10023:
	pei	<L60+value_0
	pei	<L60+destination_0+2
	jsl	~~store_integer
	brl	L10015
L10024:
	ldy	#$0
	lda	<L60+value_0
	bpl	L71
	dey
L71:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	pei	<L60+destination_0+2
	jsl	~~store_float
	brl	L10015
L10025:
	lda	<L60+nostring_0
	and	#$ff
	bne	L72
	brl	L10026
L72:
	pea	#<$43
	pea	#4
	jsl	~~error
L10026:
	ldy	#$0
	lda	<L60+value_0
	bpl	L73
	dey
L73:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~strlen
	sta	<L61+length_1
	sec
	lda	#$1000
	sbc	<L61+length_1
	bvs	L74
	eor	#$8000
L74:
	bpl	L75
	brl	L10027
L75:
	pea	#<$3d
	pea	#4
	jsl	~~error
L10027:
	lda	<L61+length_1
	ina
	pha
	pei	<L60+destination_0+2
	jsl	~~check_write
	sec
	lda	#$0
	sbc	<L61+length_1
	bvs	L76
	eor	#$8000
L76:
	bpl	L77
	brl	L10028
L77:
	ldy	#$0
	lda	<L61+length_1
	bpl	L78
	dey
L78:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	ldy	#$0
	lda	<L60+value_0
	bpl	L79
	dey
L79:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	ldy	#$0
	lda	<L60+destination_0+2
	bpl	L80
	dey
L80:
	sta	<R2
	sty	<R2+2
	clc
	lda	|~~basicvars+6
	adc	<R2
	sta	<R3
	lda	|~~basicvars+6+2
	adc	<R2+2
	sta	<R3+2
	pei	<R3+2
	pei	<R3
	jsl	~~memmove
L10028:
	clc
	lda	<L60+destination_0+2
	adc	<L61+length_1
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
	brl	L10015
L10029:
	pea	#<$43
	pea	#4
	jsl	~~error
	brl	L10015
L10014:
	xref	~~~swt
	jsl	~~~swt
	dw	7
	dw	2
	dw	L10016-1
	dw	3
	dw	L10017-1
	dw	4
	dw	L10018-1
	dw	17
	dw	L10022-1
	dw	18
	dw	L10023-1
	dw	19
	dw	L10024-1
	dw	21
	dw	L10025-1
	dw	L10029-1
L10015:
L81:
	lda	<L60+2
	sta	<L60+2+10
	lda	<L60+1
	sta	<L60+1+10
	pld
	tsc
	clc
	adc	#L60+10
	tcs
	rtl
L60	equ	22
L61	equ	17
	ends
	efunc
	data
~~statements:
	dl	~~next_line
	dl	~~exec_assignment
	dl	~~assign_staticvar
	dl	~~assign_intvar
	dl	~~assign_floatvar
	dl	~~assign_stringvar
	dl	~~exec_assignment
	dl	~~exec_assignment
	dl	~~exec_assignment
	dl	~~exec_assignment
	dl	~~exec_assignment
	dl	~~exec_assignment
	dl	~~exec_xproc
	dl	~~exec_proc
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~exec_assignment
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~exec_assignment
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~skip_colon
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~exec_fnreturn
	dl	~~bad_syntax
	dl	~~exec_assignment
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~exec_assembler
	dl	~~bad_syntax
	dl	~~exec_asmend
	dl	~~bad_syntax
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_syntax
	dl	~~exec_assignment
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_token
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~exec_oscmd
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~exec_oscmd
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~exec_oscmd
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~exec_beats
	dl	~~exec_bput
	dl	~~exec_call
	dl	~~exec_xcase
	dl	~~exec_case
	dl	~~exec_chain
	dl	~~exec_circle
	dl	~~exec_clg
	dl	~~exec_clear
	dl	~~exec_close
	dl	~~exec_cls
	dl	~~exec_colour
	dl	~~exec_data
	dl	~~exec_def
	dl	~~exec_dim
	dl	~~exec_draw
	dl	~~exec_drawby
	dl	~~exec_ellipse
	dl	~~exec_xelse
	dl	~~exec_elsewhen
	dl	~~exec_xlhelse
	dl	~~exec_elsewhen
	dl	~~exec_end
	dl	~~exec_endifcase
	dl	~~exec_endifcase
	dl	~~exec_endproc
	dl	~~exec_endwhile
	dl	~~exec_envelope
	dl	~~exec_error
	dl	~~bad_syntax
	dl	~~exec_fill
	dl	~~exec_fillby
	dl	~~bad_token
	dl	~~exec_for
	dl	~~exec_gcol
	dl	~~exec_gosub
	dl	~~exec_goto
	dl	~~exec_xif
	dl	~~exec_blockif
	dl	~~exec_singlif
	dl	~~exec_input
	dl	~~exec_let
	dl	~~exec_library
	dl	~~exec_line
	dl	~~exec_local
	dl	~~exec_mode
	dl	~~exec_mouse
	dl	~~exec_move
	dl	~~exec_moveby
	dl	~~exec_next
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~exec_off
	dl	~~exec_on
	dl	~~exec_origin
	dl	~~exec_oscli
	dl	~~exec_xwhen
	dl	~~exec_elsewhen
	dl	~~exec_overlay
	dl	~~exec_plot
	dl	~~exec_point
	dl	~~exec_pointby
	dl	~~exec_pointto
	dl	~~exec_print
	dl	~~exec_proc
	dl	~~exec_quit
	dl	~~exec_read
	dl	~~exec_rectangle
	dl	~~bad_token
	dl	~~exec_repeat
	dl	~~exec_report
	dl	~~exec_restore
	dl	~~exec_return
	dl	~~exec_run
	dl	~~exec_sound
	dl	~~exec_oscmd
	dl	~~bad_syntax
	dl	~~exec_stereo
	dl	~~exec_stop
	dl	~~exec_swap
	dl	~~exec_sys
	dl	~~exec_tempo
	dl	~~bad_syntax
	dl	~~exec_tint
	dl	~~bad_syntax
	dl	~~exec_trace
	dl	~~bad_syntax
	dl	~~exec_until
	dl	~~exec_vdu
	dl	~~exec_voice
	dl	~~exec_voices
	dl	~~exec_wait
	dl	~~exec_xwhen
	dl	~~exec_elsewhen
	dl	~~exec_while
	dl	~~exec_while
	dl	~~exec_width
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~exec_command
	dl	~~flag_badline
	dl	~~bad_syntax
	dl	~~assign_pseudovar
	ends
	code
	xdef	~~exec_fnstatements
	func
~~exec_fnstatements:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L82
	tcs
	phd
	tcd
lp_0	set	4
token_1	set	0
	lda	<L82+lp_0
	sta	|~~basicvars+62
	lda	<L82+lp_0+2
	sta	|~~basicvars+62+2
L10032:
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
	lda	<L83+token_1
	and	#$ff
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~statements
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	tax
	lda	(<R1)
	xref	~~~lcal
	jsl	~~~lcal
L10030:
	sep	#$20
	longa	off
	lda	<L83+token_1
	cmp	#<$3d
	rep	#$20
	longa	on
	beq	L84
	brl	L10032
L84:
L10031:
L85:
	lda	<L82+2
	sta	<L82+2+4
	lda	<L82+1
	sta	<L82+1+4
	pld
	tsc
	clc
	adc	#L82+4
	tcs
	rtl
L82	equ	9
L83	equ	9
	ends
	efunc
	code
	xdef	~~exec_statements
	func
~~exec_statements:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L86
	tcs
	phd
	tcd
lp_0	set	4
	lda	<L86+lp_0
	sta	|~~basicvars+62
	lda	<L86+lp_0+2
	sta	|~~basicvars+62+2
L10035:
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
	lda	#<~~statements
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	tax
	lda	(<R1)
	xref	~~~lcal
	jsl	~~~lcal
L10033:
	brl	L10035
L88:
	lda	<L86+2
	sta	<L86+2+4
	lda	<L86+1
	sta	<L86+1+4
	pld
	tsc
	clc
	adc	#L86+4
	tcs
	rtl
L86	equ	8
L87	equ	9
	ends
	efunc
	code
	xdef	~~run_program
	func
~~run_program:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L89
	tcs
	phd
	tcd
lp_0	set	4
	lda	|~~basicvars+437
	bit	#$1
	bne	L91
	brl	L10036
L91:
	pea	#<$7
	pea	#4
	jsl	~~error
L10036:
	jsl	~~clear_error
	lda	|~~basicvars+423
	bit	#$20
	bne	L92
	brl	L10037
L92:
	jsl	~~clear_varptrs
L10037:
	lda	|~~basicvars+423
	bit	#$40
	bne	L93
	brl	L10038
L93:
	jsl	~~clear_varlists
L10038:
	jsl	~~clear_strings
	jsl	~~clear_heap
	jsl	~~clear_stack
	jsl	~~init_expressions
	lda	<L89+lp_0
	ora	<L89+lp_0+2
	beq	L94
	brl	L10039
L94:
	lda	|~~basicvars+22
	sta	<L89+lp_0
	lda	|~~basicvars+22+2
	sta	<L89+lp_0+2
L10039:
	lda	|~~basicvars+22
	sta	|~~basicvars+498
	lda	|~~basicvars+22+2
	sta	|~~basicvars+498+2
	stz	|~~basicvars+447
	stz	|~~basicvars+494
	stz	|~~basicvars+407
	stz	|~~basicvars+407+2
	lda	#$10
	trb	~~basicvars+423
	lda	#$1
	tsb	~~basicvars+423
	pea	#<$0
	lda	#<~~basicvars+241
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~__sigsetjmp
	tax
	beq	L95
	brl	L10040
L95:
	lda	#<~~basicvars+241
	sta	|~~basicvars+395
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	|~~basicvars+395+2
	ldy	#$5
	lda	[<L89+lp_0],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L96
	dey
L96:
	sta	<R0
	sty	<R0+2
	ldy	#$4
	lda	[<L89+lp_0],Y
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
	lda	<L89+lp_0
	adc	<R2
	sta	<R0
	lda	<L89+lp_0+2
	adc	<R2+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~exec_statements
	brl	L10041
L10040:
	jsl	~~reset_opstack
	lda	|~~basicvars+233+2
	pha
	lda	|~~basicvars+233
	pha
	jsl	~~exec_statements
L10041:
L97:
	lda	<L89+2
	sta	<L89+2+4
	lda	<L89+1
	sta	<L89+1+4
	pld
	tsc
	clc
	adc	#L89+4
	tcs
	rtl
L89	equ	12
L90	equ	13
	ends
	efunc
	code
	xdef	~~exec_thisline
	func
~~exec_thisline:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L98
	tcs
	phd
	tcd
linelen_1	set	0
	lda	#<~~thisline
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~get_linelen
	sta	<L99+linelen_1
	lda	<L99+linelen_1
	beq	L100
	brl	L10042
L100:
L101:
	pld
	tsc
	clc
	adc	#L98
	tcs
	rtl
L10042:
	clc
	lda	#<~~thisline
	adc	<L99+linelen_1
	sta	<R1
	lda	<R1
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~mark_end
	lda	|~~basicvars+22
	sta	|~~basicvars+498
	lda	|~~basicvars+22+2
	sta	|~~basicvars+498+2
	stz	|~~basicvars+447
	stz	|~~basicvars+407
	stz	|~~basicvars+407+2
	lda	#$10
	trb	~~basicvars+423
	jsl	~~clear_error
	jsl	~~reset_opstack
	lda	|~~thisline+5
	and	#$ff
	sta	<R2
	lda	<R2
	xba
	and	#$ff00
	sta	<R1
	lda	|~~thisline+4
	and	#$ff
	sta	<R2
	clc
	lda	<R2
	adc	<R1
	sta	<R3
	clc
	lda	#<~~thisline
	adc	<R3
	sta	<R1
	lda	<R1
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~exec_statements
	brl	L101
L98	equ	18
L99	equ	17
	ends
	efunc
	xref	~~assign_pseudovar
	xref	~~assign_stringvar
	xref	~~assign_floatvar
	xref	~~assign_intvar
	xref	~~assign_staticvar
	xref	~~exec_assignment
	xref	~~exec_while
	xref	~~exec_xwhen
	xref	~~exec_wait
	xref	~~exec_until
	xref	~~exec_trace
	xref	~~exec_sys
	xref	~~exec_swap
	xref	~~exec_stop
	xref	~~exec_run
	xref	~~exec_return
	xref	~~exec_restore
	xref	~~exec_report
	xref	~~exec_repeat
	xref	~~exec_read
	xref	~~exec_quit
	xref	~~exec_xproc
	xref	~~exec_proc
	xref	~~exec_overlay
	xref	~~exec_oscli
	xref	~~exec_on
	xref	~~exec_next
	xref	~~exec_local
	xref	~~exec_library
	xref	~~exec_let
	xref	~~exec_xif
	xref	~~exec_singlif
	xref	~~exec_blockif
	xref	~~exec_goto
	xref	~~exec_gosub
	xref	~~exec_for
	xref	~~exec_error
	xref	~~exec_endwhile
	xref	~~exec_fnreturn
	xref	~~exec_endproc
	xref	~~exec_endifcase
	xref	~~exec_end
	xref	~~exec_xlhelse
	xref	~~exec_xelse
	xref	~~exec_elsewhen
	xref	~~exec_dim
	xref	~~exec_def
	xref	~~exec_data
	xref	~~exec_clear
	xref	~~exec_chain
	xref	~~exec_xcase
	xref	~~exec_case
	xref	~~exec_call
	xref	~~exec_oscmd
	xref	~~exec_asmend
	xref	~~exec_assembler
	xref	~~exec_width
	xref	~~exec_voices
	xref	~~exec_voice
	xref	~~exec_vdu
	xref	~~exec_tint
	xref	~~exec_tempo
	xref	~~exec_stereo
	xref	~~exec_sound
	xref	~~exec_rectangle
	xref	~~exec_print
	xref	~~exec_pointto
	xref	~~exec_pointby
	xref	~~exec_point
	xref	~~exec_plot
	xref	~~exec_origin
	xref	~~exec_off
	xref	~~exec_moveby
	xref	~~exec_move
	xref	~~exec_mouse
	xref	~~exec_mode
	xref	~~exec_line
	xref	~~exec_input
	xref	~~exec_gcol
	xref	~~exec_fillby
	xref	~~exec_fill
	xref	~~exec_envelope
	xref	~~exec_ellipse
	xref	~~exec_drawby
	xref	~~exec_draw
	xref	~~exec_colour
	xref	~~exec_cls
	xref	~~exec_close
	xref	~~exec_clg
	xref	~~exec_circle
	xref	~~exec_bput
	xref	~~exec_beats
	xref	~~clear_strings
	xref	~~free_string
	xref	~~alloc_string
	xref	~~fileio_bputstr
	xref	~~emulate_vdustr
	xref	~~reset_opstack
	xref	~~init_expressions
	xref	~~init_staticvars
	xref	~~clear_varlists
	xref	~~find_linestart
	xref	~~store_float
	xref	~~store_integer
	xref	~~check_write
	xref	~~mark_end
	xref	~~clear_error
	xref	~~error
	xref	~~clear_heap
	xref	~~clear_stack
	xref	~~init_stack
	xref	~~exec_command
	xref	~~clear_varptrs
	xref	~~get_linelen
	xref	~~get_lineno
	xref	~~exit_interpreter
	xref	~~longjmp
	xref	~~__sigsetjmp
	xref	~~strlen
	xref	~~memmove
	xref	~~sprintf
	xref	~~fprintf
	xref	~~thisline
	xref	~~basicvars
	xref	~~stderr
	end
