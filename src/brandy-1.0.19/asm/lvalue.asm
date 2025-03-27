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
destination_0	set	4
	pea	#^L1
	pea	#<L1
	pea	#<$3c
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
	db	$6C,$76,$61,$6C,$75,$65,$00
	ends
	code
	func
~~bad_syntax:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L6
	tcs
	phd
	tcd
destination_0	set	4
	pea	#<$5
	pea	#4
	jsl	~~error
L8:
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
L6	equ	0
L7	equ	1
	ends
	efunc
	code
	func
~~fix_address:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L9
	tcs
	phd
	tcd
destination_0	set	4
vp_1	set	0
base_1	set	4
tp_1	set	8
np_1	set	12
isarray_1	set	16
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~get_srcaddr
	sta	<L10+base_1
	stx	<L10+base_1+2
	pei	<L10+base_1+2
	pei	<L10+base_1
	jsl	~~skip_name
	sta	<L10+tp_1
	stx	<L10+tp_1+2
	clc
	lda	#$5
	adc	|~~basicvars+62
	sta	<L10+np_1
	lda	#$0
	adc	|~~basicvars+62+2
	sta	<L10+np_1+2
	sec
	lda	<L10+tp_1
	sbc	<L10+base_1
	sta	<R0
	lda	<L10+tp_1+2
	sbc	<L10+base_1+2
	sta	<R0+2
	pei	<R0
	pei	<L10+base_1+2
	pei	<L10+base_1
	jsl	~~find_variable
	sta	<L10+vp_1
	stx	<L10+vp_1+2
	lda	<L10+vp_1
	ora	<L10+vp_1+2
	beq	L11
	brl	L10001
L11:
	clc
	lda	#$ffff
	adc	<L10+tp_1
	sta	<R0
	lda	#$ffff
	adc	<L10+tp_1+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$28
	rep	#$20
	longa	on
	bne	L13
	brl	L12
L13:
	clc
	lda	#$ffff
	adc	<L10+tp_1
	sta	<R0
	lda	#$ffff
	adc	<L10+tp_1+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$5b
	rep	#$20
	longa	on
	beq	L14
	brl	L10002
L14:
L12:
	lda	|~~basicvars+423
	bit	#$80
	bne	L15
	brl	L10003
L15:
	sep	#$20
	longa	off
	lda	[<L10+np_1]
	cmp	#<$29
	rep	#$20
	longa	on
	beq	L16
	brl	L10003
L16:
	pea	#^$0
	pea	#<$0
	sec
	lda	<L10+tp_1
	sbc	<L10+base_1
	sta	<R0
	lda	<L10+tp_1+2
	sbc	<L10+base_1+2
	sta	<R0+2
	pei	<R0
	pei	<L10+base_1+2
	pei	<L10+base_1
	jsl	~~create_variable
	sta	<L10+vp_1
	stx	<L10+vp_1+2
	brl	L10004
L10003:
	sec
	lda	<L10+tp_1
	sbc	<L10+base_1
	sta	<R0
	lda	<L10+tp_1+2
	sbc	<L10+base_1+2
	sta	<R0+2
	pei	<R0
	pei	<L10+base_1+2
	pei	<L10+base_1
	jsl	~~tocstring
	sta	<R1
	stx	<R1+2
	phx
	pha
	pea	#<$e
	pea	#8
	jsl	~~error
L10004:
	brl	L10005
L10002:
	pea	#^$0
	pea	#<$0
	sec
	lda	<L10+tp_1
	sbc	<L10+base_1
	sta	<R0
	lda	<L10+tp_1+2
	sbc	<L10+base_1+2
	sta	<R0+2
	pei	<R0
	pei	<L10+base_1+2
	pei	<L10+base_1
	jsl	~~create_variable
	sta	<L10+vp_1
	stx	<L10+vp_1+2
L10005:
	brl	L10006
L10001:
	stz	<R0
	ldy	#$4
	lda	[<L10+vp_1],Y
	and	#<$8
	bne	L18
	brl	L17
L18:
	inc	<R0
L17:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L10+isarray_1
	rep	#$20
	longa	on
	lda	<L10+isarray_1
	and	#$ff
	bne	L19
	brl	L10007
L19:
	lda	|~~basicvars+423
	bit	#$80
	beq	L20
	brl	L10007
L20:
	ldy	#$10
	lda	[<L10+vp_1],Y
	ldy	#$12
	ora	[<L10+vp_1],Y
	beq	L21
	brl	L10007
L21:
	ldy	#$8
	lda	[<L10+vp_1],Y
	pha
	ldy	#$6
	lda	[<L10+vp_1],Y
	pha
	pea	#<$1f
	pea	#8
	jsl	~~error
L10007:
L10006:
	lda	<L10+isarray_1
	and	#$ff
	beq	L22
	brl	L10008
L22:
	sep	#$20
	longa	off
	lda	[<L10+np_1]
	cmp	#<$3f
	rep	#$20
	longa	on
	bne	L24
	brl	L23
L24:
	sep	#$20
	longa	off
	lda	[<L10+np_1]
	cmp	#<$21
	rep	#$20
	longa	on
	beq	L25
	brl	L10008
L25:
L23:
	ldy	#$4
	lda	[<L10+vp_1],Y
	brl	L10009
L10011:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$9
	sta	[<R0]
	rep	#$20
	longa	on
	clc
	lda	#$10
	adc	<L10+vp_1
	sta	<R0
	lda	#$0
	adc	<L10+vp_1+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~set_address
	brl	L10010
L10012:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$a
	sta	[<R0]
	rep	#$20
	longa	on
	clc
	lda	#$10
	adc	<L10+vp_1
	sta	<R0
	lda	#$0
	adc	<L10+vp_1+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~set_address
	brl	L10010
L10013:
	pea	#<$43
	pea	#4
	jsl	~~error
	brl	L10010
L10009:
	xref	~~~swt
	jsl	~~~swt
	dw	2
	dw	2
	dw	L10011-1
	dw	3
	dw	L10012-1
	dw	L10013-1
L10010:
	brl	L10014
L10008:
	ldy	#$4
	lda	[<L10+vp_1],Y
	brl	L10015
L10017:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$3
	sta	[<R0]
	rep	#$20
	longa	on
	clc
	lda	#$10
	adc	<L10+vp_1
	sta	<R0
	lda	#$0
	adc	<L10+vp_1+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~set_address
	brl	L10016
L10018:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$4
	sta	[<R0]
	rep	#$20
	longa	on
	clc
	lda	#$10
	adc	<L10+vp_1
	sta	<R0
	lda	#$0
	adc	<L10+vp_1+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~set_address
	brl	L10016
L10019:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$5
	sta	[<R0]
	rep	#$20
	longa	on
	clc
	lda	#$10
	adc	<L10+vp_1
	sta	<R0
	lda	#$0
	adc	<L10+vp_1+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~set_address
	brl	L10016
L10020:
	sep	#$20
	longa	off
	lda	[<L10+np_1]
	cmp	#<$29
	rep	#$20
	longa	on
	beq	L26
	brl	L10021
L26:
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
	brl	L10022
L10021:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$7
	sta	[<R0]
	rep	#$20
	longa	on
L10022:
	pei	<L10+vp_1+2
	pei	<L10+vp_1
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~set_address
	brl	L10016
L10015:
	xref	~~~swt
	jsl	~~~swt
	dw	3
	dw	2
	dw	L10017-1
	dw	3
	dw	L10018-1
	dw	4
	dw	L10019-1
	dw	L10020-1
L10016:
L10014:
	pei	<L9+destination_0+2
	pei	<L9+destination_0
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
	lda	#<~~lvalue_table
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	tax
	lda	(<R1)
	xref	~~~lcal
	jsl	~~~lcal
L27:
	lda	<L9+2
	sta	<L9+2+4
	lda	<L9+1
	sta	<L9+1+4
	pld
	tsc
	clc
	adc	#L9+4
	tcs
	rtl
L9	equ	25
L10	equ	9
	ends
	efunc
	code
	func
~~do_staticvar:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L28
	tcs
	phd
	tcd
destination_0	set	4
	lda	#$2
	sta	[<L28+destination_0]
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	ldy	#$1
	lda	[<R1],Y
	and	#$ff
	sta	<R1
	lda	<R1
	ldx	#<$16
	xref	~~~mul
	jsl	~~~mul
	sta	<R1
	clc
	lda	#$10
	adc	<R1
	sta	<R2
	clc
	lda	#<~~basicvars+504
	adc	<R2
	sta	<R1
	lda	<R1
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	lda	<R0
	ldy	#$2
	sta	[<L28+destination_0],Y
	lda	<R0+2
	ldy	#$4
	sta	[<L28+destination_0],Y
	clc
	lda	#$2
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L30
	inc	|~~basicvars+62+2
L30:
L31:
	lda	<L28+2
	sta	<L28+2+4
	lda	<L28+1
	sta	<L28+1+4
	pld
	tsc
	clc
	adc	#L28+4
	tcs
	rtl
L28	equ	12
L29	equ	13
	ends
	efunc
	code
	func
~~do_intvar:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L32
	tcs
	phd
	tcd
destination_0	set	4
	lda	#$2
	sta	[<L32+destination_0]
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
	bpl	L34
	dey
L34:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars
	adc	<R0
	sta	<R1
	lda	|~~basicvars+2
	adc	<R0+2
	sta	<R1+2
	lda	<R1
	ldy	#$2
	sta	[<L32+destination_0],Y
	lda	<R1+2
	ldy	#$4
	sta	[<L32+destination_0],Y
	clc
	lda	#$5
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L35
	inc	|~~basicvars+62+2
L35:
L36:
	lda	<L32+2
	sta	<L32+2+4
	lda	<L32+1
	sta	<L32+1+4
	pld
	tsc
	clc
	adc	#L32+4
	tcs
	rtl
L32	equ	12
L33	equ	13
	ends
	efunc
	code
	func
~~do_floatvar:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L37
	tcs
	phd
	tcd
destination_0	set	4
	lda	#$3
	sta	[<L37+destination_0]
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
	bpl	L39
	dey
L39:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars
	adc	<R0
	sta	<R1
	lda	|~~basicvars+2
	adc	<R0+2
	sta	<R1+2
	lda	<R1
	ldy	#$2
	sta	[<L37+destination_0],Y
	lda	<R1+2
	ldy	#$4
	sta	[<L37+destination_0],Y
	clc
	lda	#$5
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L40
	inc	|~~basicvars+62+2
L40:
L41:
	lda	<L37+2
	sta	<L37+2+4
	lda	<L37+1
	sta	<L37+1+4
	pld
	tsc
	clc
	adc	#L37+4
	tcs
	rtl
L37	equ	12
L38	equ	13
	ends
	efunc
	code
	func
~~do_stringvar:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L42
	tcs
	phd
	tcd
destination_0	set	4
	lda	#$4
	sta	[<L42+destination_0]
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
	bpl	L44
	dey
L44:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars
	adc	<R0
	sta	<R1
	lda	|~~basicvars+2
	adc	<R0+2
	sta	<R1+2
	lda	<R1
	ldy	#$2
	sta	[<L42+destination_0],Y
	lda	<R1+2
	ldy	#$4
	sta	[<L42+destination_0],Y
	clc
	lda	#$5
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L45
	inc	|~~basicvars+62+2
L45:
L46:
	lda	<L42+2
	sta	<L42+2+4
	lda	<L42+1
	sta	<L42+1+4
	pld
	tsc
	clc
	adc	#L42+4
	tcs
	rtl
L42	equ	12
L43	equ	13
	ends
	efunc
	code
	func
~~do_arrayvar:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L47
	tcs
	phd
	tcd
destination_0	set	4
vp_1	set	0
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
	bpl	L49
	dey
L49:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars
	adc	<R0
	sta	<L48+vp_1
	lda	|~~basicvars+2
	adc	<R0+2
	sta	<L48+vp_1+2
	clc
	lda	#$6
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L50
	inc	|~~basicvars+62+2
L50:
	ldy	#$4
	lda	[<L48+vp_1],Y
	sta	[<L47+destination_0]
	clc
	lda	#$10
	adc	<L48+vp_1
	sta	<R0
	lda	#$0
	adc	<L48+vp_1+2
	sta	<R0+2
	lda	<R0
	ldy	#$2
	sta	[<L47+destination_0],Y
	lda	<R0+2
	ldy	#$4
	sta	[<L47+destination_0],Y
L51:
	lda	<L47+2
	sta	<L47+2+4
	lda	<L47+1
	sta	<L47+1+4
	pld
	tsc
	clc
	adc	#L47+4
	tcs
	rtl
L47	equ	16
L48	equ	13
	ends
	efunc
	code
	func
~~do_elementvar:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L52
	tcs
	phd
	tcd
destination_0	set	4
vp_1	set	0
vartype_1	set	4
offset_1	set	6
element_1	set	8
descriptor_1	set	10
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
	bpl	L54
	dey
L54:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars
	adc	<R0
	sta	<L53+vp_1
	lda	|~~basicvars+2
	adc	<R0+2
	sta	<L53+vp_1+2
	clc
	lda	#$5
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L55
	inc	|~~basicvars+62+2
L55:
	ldy	#$4
	lda	[<L53+vp_1],Y
	sta	<L53+vartype_1
	ldy	#$10
	lda	[<L53+vp_1],Y
	sta	<L53+descriptor_1
	ldy	#$12
	lda	[<L53+vp_1],Y
	sta	<L53+descriptor_1+2
	lda	[<L53+descriptor_1]
	cmp	#<$1
	beq	L56
	brl	L10023
L56:
	jsl	~~expression
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$2
	beq	L57
	brl	L10024
L57:
	jsl	~~pop_int
	sta	<L53+element_1
	brl	L10025
L10024:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$3
	beq	L58
	brl	L10026
L58:
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
	sta	<L53+element_1
	brl	L10027
L10026:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10027:
L10025:
	lda	<L53+element_1
	bpl	L60
	brl	L59
L60:
	sec
	lda	<L53+element_1
	ldy	#$8
	sbc	[<L53+descriptor_1],Y
	bvs	L61
	eor	#$8000
L61:
	bmi	L62
	brl	L10028
L62:
L59:
	ldy	#$8
	lda	[<L53+vp_1],Y
	pha
	ldy	#$6
	lda	[<L53+vp_1],Y
	pha
	pei	<L53+element_1
	pea	#<$1c
	pea	#10
	jsl	~~error
L10028:
	brl	L10029
L10023:
index_2	set	14
maxdims_2	set	16
dimcount_2	set	18
	lda	[<L53+descriptor_1]
	sta	<L53+maxdims_2
	stz	<L53+dimcount_2
	stz	<L53+element_1
L10032:
	jsl	~~expression
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$2
	beq	L63
	brl	L10033
L63:
	jsl	~~pop_int
	sta	<L53+index_2
	brl	L10034
L10033:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$3
	beq	L64
	brl	L10035
L64:
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
	sta	<L53+index_2
	brl	L10036
L10035:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10036:
L10034:
	lda	<L53+index_2
	bpl	L66
	brl	L65
L66:
	ldy	#$0
	lda	<L53+dimcount_2
	bpl	L67
	dey
L67:
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
	adc	<L53+descriptor_1
	sta	<R2
	lda	#$0
	adc	<L53+descriptor_1+2
	sta	<R2+2
	clc
	lda	<R2
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	sec
	lda	<L53+index_2
	sbc	[<R3]
	bvs	L68
	eor	#$8000
L68:
	bmi	L69
	brl	L10037
L69:
L65:
	ldy	#$8
	lda	[<L53+vp_1],Y
	pha
	ldy	#$6
	lda	[<L53+vp_1],Y
	pha
	pei	<L53+index_2
	pea	#<$1c
	pea	#10
	jsl	~~error
L10037:
	clc
	lda	<L53+element_1
	adc	<L53+index_2
	sta	<L53+element_1
	inc	<L53+dimcount_2
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
	brl	L10031
L70:
	inc	|~~basicvars+62
	bne	L71
	inc	|~~basicvars+62+2
L71:
	sec
	lda	<L53+maxdims_2
	sbc	<L53+dimcount_2
	bvs	L72
	eor	#$8000
L72:
	bpl	L73
	brl	L10038
L73:
	ldy	#$8
	lda	[<L53+vp_1],Y
	pha
	ldy	#$6
	lda	[<L53+vp_1],Y
	pha
	pea	#<$1d
	pea	#8
	jsl	~~error
L10038:
	lda	<L53+dimcount_2
	cmp	<L53+maxdims_2
	bne	L74
	brl	L10039
L74:
	ldy	#$0
	lda	<L53+dimcount_2
	bpl	L75
	dey
L75:
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
	adc	<L53+descriptor_1
	sta	<R2
	lda	#$0
	adc	<L53+descriptor_1+2
	sta	<R2+2
	clc
	lda	<R2
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	lda	[<R3]
	ldx	<L53+element_1
	xref	~~~mul
	jsl	~~~mul
	sta	<L53+element_1
L10039:
L10030:
	brl	L10032
L10031:
	lda	<L53+dimcount_2
	cmp	<L53+maxdims_2
	bne	L76
	brl	L10040
L76:
	ldy	#$8
	lda	[<L53+vp_1],Y
	pha
	ldy	#$6
	lda	[<L53+vp_1],Y
	pha
	pea	#<$1d
	pea	#8
	jsl	~~error
L10040:
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
	bne	L77
	brl	L10041
L77:
	pea	#<$29
	pea	#4
	jsl	~~error
L10041:
	inc	|~~basicvars+62
	bne	L78
	inc	|~~basicvars+62+2
L78:
	clc
	lda	#$fff8
	adc	<L53+vartype_1
	sta	<L53+vartype_1
	lda	<L53+vartype_1
	sta	[<L52+destination_0]
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$3f
	rep	#$20
	longa	on
	bne	L79
	brl	L10042
L79:
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
	bne	L80
	brl	L10042
L80:
	lda	<L53+vartype_1
	cmp	#<$2
	beq	L81
	brl	L10043
L81:
	ldy	#$0
	lda	<L53+element_1
	bpl	L82
	dey
L82:
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
	ldy	#$4
	lda	[<L53+descriptor_1],Y
	adc	<R0
	sta	<R2
	ldy	#$6
	lda	[<L53+descriptor_1],Y
	adc	<R0+2
	sta	<R2+2
	lda	<R2
	ldy	#$2
	sta	[<L52+destination_0],Y
	lda	<R2+2
	ldy	#$4
	sta	[<L52+destination_0],Y
	brl	L10044
L10043:
	lda	<L53+vartype_1
	cmp	#<$3
	beq	L83
	brl	L10045
L83:
	ldy	#$0
	lda	<L53+element_1
	bpl	L84
	dey
L84:
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
	ldy	#$4
	lda	[<L53+descriptor_1],Y
	adc	<R0
	sta	<R2
	ldy	#$6
	lda	[<L53+descriptor_1],Y
	adc	<R0+2
	sta	<R2+2
	lda	<R2
	ldy	#$2
	sta	[<L52+destination_0],Y
	lda	<R2+2
	ldy	#$4
	sta	[<L52+destination_0],Y
	brl	L10046
L10045:
	ldy	#$0
	lda	<L53+element_1
	bpl	L85
	dey
L85:
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
	lda	[<L53+descriptor_1],Y
	adc	<R0
	sta	<R1
	ldy	#$6
	lda	[<L53+descriptor_1],Y
	adc	<R0+2
	sta	<R1+2
	lda	<R1
	ldy	#$2
	sta	[<L52+destination_0],Y
	lda	<R1+2
	ldy	#$4
	sta	[<L52+destination_0],Y
L10046:
L10044:
L86:
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
L10042:
	lda	<L53+vartype_1
	cmp	#<$2
	beq	L87
	brl	L10047
L87:
	ldy	#$0
	lda	<L53+element_1
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
	clc
	ldy	#$4
	lda	[<L53+descriptor_1],Y
	adc	<R0
	sta	<R2
	ldy	#$6
	lda	[<L53+descriptor_1],Y
	adc	<R0+2
	sta	<R2+2
	lda	[<R2]
	sta	<L53+offset_1
	brl	L10048
L10047:
	lda	<L53+vartype_1
	cmp	#<$3
	beq	L89
	brl	L10049
L89:
	ldy	#$0
	lda	<L53+element_1
	bpl	L90
	dey
L90:
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
	ldy	#$4
	lda	[<L53+descriptor_1],Y
	adc	<R0
	sta	<R2
	ldy	#$6
	lda	[<L53+descriptor_1],Y
	adc	<R0+2
	sta	<R2+2
	ldy	#$2
	lda	[<R2],Y
	pha
	lda	[<R2]
	pha
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R0
	pla
	sta	<R0+2
	lda	<R0
	sta	<L53+offset_1
	brl	L10050
L10049:
	pea	#<$43
	pea	#4
	jsl	~~error
L10050:
L10048:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$3f
	rep	#$20
	longa	on
	beq	L91
	brl	L10051
L91:
	lda	#$11
	sta	[<L52+destination_0]
	brl	L10052
L10051:
	lda	#$12
	sta	[<L52+destination_0]
L10052:
	inc	|~~basicvars+62
	bne	L92
	inc	|~~basicvars+62+2
L92:
	jsl	~~factor
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$2
	beq	L93
	brl	L10053
L93:
	jsl	~~pop_int
	sta	<R0
	clc
	lda	<R0
	adc	<L53+offset_1
	ldy	#$2
	sta	[<L52+destination_0],Y
	brl	L10054
L10053:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$3
	beq	L94
	brl	L10055
L94:
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
	adc	<L53+offset_1
	ldy	#$2
	sta	[<L52+destination_0],Y
	brl	L10056
L10055:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10056:
L10054:
	brl	L86
L52	equ	36
L53	equ	17
	ends
	efunc
	code
	func
~~do_intindvar:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L95
	tcs
	phd
	tcd
destination_0	set	4
ip_1	set	0
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
	bpl	L97
	dey
L97:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars
	adc	<R0
	sta	<L96+ip_1
	lda	|~~basicvars+2
	adc	<R0+2
	sta	<L96+ip_1+2
	clc
	lda	#$5
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L98
	inc	|~~basicvars+62+2
L98:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$3f
	rep	#$20
	longa	on
	beq	L99
	brl	L10057
L99:
	lda	#$11
	sta	[<L95+destination_0]
	brl	L10058
L10057:
	lda	#$12
	sta	[<L95+destination_0]
L10058:
	inc	|~~basicvars+62
	bne	L100
	inc	|~~basicvars+62+2
L100:
	jsl	~~factor
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$2
	beq	L101
	brl	L10059
L101:
	jsl	~~pop_int
	sta	<R0
	clc
	lda	<R0
	adc	[<L96+ip_1]
	ldy	#$2
	sta	[<L95+destination_0],Y
	brl	L10060
L10059:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$3
	beq	L102
	brl	L10061
L102:
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
	adc	[<L96+ip_1]
	ldy	#$2
	sta	[<L95+destination_0],Y
	brl	L10062
L10061:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10062:
L10060:
L103:
	lda	<L95+2
	sta	<L95+2+4
	lda	<L95+1
	sta	<L95+1+4
	pld
	tsc
	clc
	adc	#L95+4
	tcs
	rtl
L95	equ	16
L96	equ	13
	ends
	efunc
	code
	func
~~do_floatindvar:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L104
	tcs
	phd
	tcd
destination_0	set	4
fp_1	set	0
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
	bpl	L106
	dey
L106:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars
	adc	<R0
	sta	<L105+fp_1
	lda	|~~basicvars+2
	adc	<R0+2
	sta	<L105+fp_1+2
	clc
	lda	#$5
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L107
	inc	|~~basicvars+62+2
L107:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$3f
	rep	#$20
	longa	on
	beq	L108
	brl	L10063
L108:
	lda	#$11
	sta	[<L104+destination_0]
	brl	L10064
L10063:
	lda	#$12
	sta	[<L104+destination_0]
L10064:
	inc	|~~basicvars+62
	bne	L109
	inc	|~~basicvars+62+2
L109:
	jsl	~~factor
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$2
	beq	L110
	brl	L10065
L110:
	ldy	#$2
	lda	[<L105+fp_1],Y
	pha
	lda	[<L105+fp_1]
	pha
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R0
	pla
	sta	<R0+2
	jsl	~~pop_int
	sta	<R1
	clc
	lda	<R1
	adc	<R0
	ldy	#$2
	sta	[<L104+destination_0],Y
	brl	L10066
L10065:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$3
	beq	L111
	brl	L10067
L111:
	ldy	#$2
	lda	[<L105+fp_1],Y
	pha
	lda	[<L105+fp_1]
	pha
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R0
	pla
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
	clc
	lda	<R1
	adc	<R0
	ldy	#$2
	sta	[<L104+destination_0],Y
	brl	L10068
L10067:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10068:
L10066:
L112:
	lda	<L104+2
	sta	<L104+2+4
	lda	<L104+1
	sta	<L104+1+4
	pld
	tsc
	clc
	adc	#L104+4
	tcs
	rtl
L104	equ	16
L105	equ	13
	ends
	efunc
	code
	func
~~do_statindvar:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L113
	tcs
	phd
	tcd
destination_0	set	4
index_1	set	0
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<R0],Y
	sta	<L114+index_1
	rep	#$20
	longa	on
	clc
	lda	#$2
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L115
	inc	|~~basicvars+62+2
L115:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$3f
	rep	#$20
	longa	on
	beq	L116
	brl	L10069
L116:
	lda	#$11
	sta	[<L113+destination_0]
	brl	L10070
L10069:
	lda	#$12
	sta	[<L113+destination_0]
L10070:
	inc	|~~basicvars+62
	bne	L117
	inc	|~~basicvars+62+2
L117:
	jsl	~~factor
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$2
	beq	L118
	brl	L10071
L118:
	lda	<L114+index_1
	and	#$ff
	sta	<R0
	lda	<R0
	ldx	#<$16
	xref	~~~mul
	jsl	~~~mul
	sta	<R0
	jsl	~~pop_int
	sta	<R1
	clc
	lda	<R1
	ldx	<R0
	adc	|~~basicvars+504+16,X
	ldy	#$2
	sta	[<L113+destination_0],Y
	brl	L10072
L10071:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$3
	beq	L119
	brl	L10073
L119:
	lda	<L114+index_1
	and	#$ff
	sta	<R0
	lda	<R0
	ldx	#<$16
	xref	~~~mul
	jsl	~~~mul
	sta	<R0
	phy
	phy
	jsl	~~pop_float
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R1
	pla
	sta	<R1+2
	clc
	lda	<R1
	ldx	<R0
	adc	|~~basicvars+504+16,X
	ldy	#$2
	sta	[<L113+destination_0],Y
	brl	L10074
L10073:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10074:
L10072:
L120:
	lda	<L113+2
	sta	<L113+2+4
	lda	<L113+1
	sta	<L113+1+4
	pld
	tsc
	clc
	adc	#L113+4
	tcs
	rtl
L113	equ	9
L114	equ	9
	ends
	efunc
	code
	func
~~do_unaryind:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L121
	tcs
	phd
	tcd
destination_0	set	4
operator_1	set	0
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	sta	<L122+operator_1
	rep	#$20
	longa	on
	inc	|~~basicvars+62
	bne	L123
	inc	|~~basicvars+62+2
L123:
	sep	#$20
	longa	off
	lda	<L122+operator_1
	cmp	#<$3f
	rep	#$20
	longa	on
	beq	L124
	brl	L10075
L124:
	lda	#$11
	sta	[<L121+destination_0]
	brl	L10076
L10075:
	sep	#$20
	longa	off
	lda	<L122+operator_1
	cmp	#<$21
	rep	#$20
	longa	on
	beq	L125
	brl	L10077
L125:
	lda	#$12
	sta	[<L121+destination_0]
	brl	L10078
L10077:
	sep	#$20
	longa	off
	lda	<L122+operator_1
	cmp	#<$7c
	rep	#$20
	longa	on
	beq	L126
	brl	L10079
L126:
	lda	#$13
	sta	[<L121+destination_0]
	brl	L10080
L10079:
	lda	#$15
	sta	[<L121+destination_0]
L10080:
L10078:
L10076:
	jsl	~~factor
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$2
	beq	L127
	brl	L10081
L127:
	jsl	~~pop_int
	ldy	#$2
	sta	[<L121+destination_0],Y
	brl	L10082
L10081:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$3
	beq	L128
	brl	L10083
L128:
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
	ldy	#$2
	sta	[<L121+destination_0],Y
	brl	L10084
L10083:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10084:
L10082:
L129:
	lda	<L121+2
	sta	<L121+2+4
	lda	<L121+1
	sta	<L121+1+4
	pld
	tsc
	clc
	adc	#L121+4
	tcs
	rtl
L121	equ	5
L122	equ	5
	ends
	efunc
	data
~~lvalue_table:
	dl	~~bad_syntax
	dl	~~fix_address
	dl	~~do_staticvar
	dl	~~do_intvar
	dl	~~do_floatvar
	dl	~~do_stringvar
	dl	~~do_arrayvar
	dl	~~do_elementvar
	dl	~~do_elementvar
	dl	~~do_intindvar
	dl	~~do_floatindvar
	dl	~~do_statindvar
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
	dl	~~do_unaryind
	dl	~~bad_token
	dl	~~bad_token
	dl	~~do_unaryind
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
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~do_unaryind
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
	dl	~~do_unaryind
	dl	~~bad_syntax
	dl	~~bad_syntax
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
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_syntax
	ends
	code
	xdef	~~get_lvalue
	func
~~get_lvalue:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L130
	tcs
	phd
	tcd
destination_0	set	4
	pei	<L130+destination_0+2
	pei	<L130+destination_0
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
	lda	#<~~lvalue_table
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	tax
	lda	(<R1)
	xref	~~~lcal
	jsl	~~~lcal
L132:
	lda	<L130+2
	sta	<L130+2+4
	lda	<L130+1
	sta	<L130+1+4
	pld
	tsc
	clc
	adc	#L130+4
	tcs
	rtl
L130	equ	8
L131	equ	9
	ends
	efunc
	xref	~~tocstring
	xref	~~create_variable
	xref	~~find_variable
	xref	~~error
	xref	~~pop_float
	xref	~~pop_int
	xref	~~factor
	xref	~~expression
	xref	~~get_srcaddr
	xref	~~set_address
	xref	~~skip_name
	xref	~~basicvars
	end
