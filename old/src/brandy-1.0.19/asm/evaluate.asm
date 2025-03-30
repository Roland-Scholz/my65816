;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
	code
	xdef	~~check_arrays
	func
~~check_arrays:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
p1_0	set	4
p2_0	set	8
n_1	set	0
	lda	[<L2+p1_0]
	cmp	[<L2+p2_0]
	bne	L4
	brl	L10001
L4:
	lda	#$0
L5:
	tay
	lda	<L2+2
	sta	<L2+2+8
	lda	<L2+1
	sta	<L2+1+8
	pld
	tsc
	clc
	adc	#L2+8
	tcs
	tya
	rtl
L10001:
	stz	<L3+n_1
L10002:
	sec
	lda	<L3+n_1
	sbc	[<L2+p1_0]
	bvs	L6
	eor	#$8000
L6:
	bpl	L7
	brl	L10003
L7:
	ldy	#$0
	lda	<L3+n_1
	bpl	L8
	dey
L8:
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
	adc	<L2+p2_0
	sta	<R2
	lda	#$0
	adc	<L2+p2_0+2
	sta	<R2+2
	clc
	lda	<R2
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	ldy	#$0
	lda	<L3+n_1
	bpl	L9
	dey
L9:
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
	lda	#$8
	adc	<L2+p1_0
	sta	<17
	lda	#$0
	adc	<L2+p1_0+2
	sta	<17+2
	clc
	lda	<17
	adc	<R0
	sta	<21
	lda	<17+2
	adc	<R0+2
	sta	<21+2
	lda	[<21]
	cmp	[<R3]
	beq	L10
	brl	L10003
L10:
	inc	<L3+n_1
	brl	L10002
L10003:
	stz	<R0
	lda	<L3+n_1
	cmp	[<L2+p1_0]
	beq	L12
	brl	L11
L12:
	inc	<R0
L11:
	lda	<R0
	and	#$ff
	brl	L5
L2	equ	26
L3	equ	25
	ends
	efunc
	data
~~type_table:
	dw	$82,$82,$82,$82,$82,$82,$82,$82,$82,$82
	dw	$82,$82
	ds	2
	dw	$82,$82,$0,$0,$41,$41,$41,$41,$41,$41
	dw	$41,$41
	ds	2
	dw	$82,$82,$0,$0,$41,$41,$41,$41,$41,$41
	dw	$41,$41
	ds	2
	dw	$82,$82,$0,$0,$41,$41,$41,$41,$41,$41
	dw	$41,$41
	ds	2
	dw	$82,$82,$42,$42,$0,$0,$42,$42,$42,$42
	dw	$42,$42
	ds	2
	dw	$82,$82,$42,$42,$0,$0,$42,$42,$42,$42
	dw	$42,$42
	ds	2
	dw	$82,$82,$82,$82,$82,$82,$82,$82,$82,$82
	dw	$82,$82
	ds	2
	dw	$82,$82,$82,$82,$82,$82,$82,$82,$82,$82
	dw	$82,$82
	ds	2
	dw	$82,$82,$82,$82,$82,$82,$82,$82,$82,$82
	dw	$82,$82
	ds	2
	dw	$82,$82,$82,$82,$82,$82,$82,$82,$82,$82
	dw	$82,$82
	ds	2
	dw	$82,$82,$41,$41,$41,$41,$0,$0,$41,$41
	dw	$41,$41
	ds	2
	dw	$82,$82,$41,$41,$41,$41,$41,$41,$0,$0
	dw	$41,$41
	ds	2
	dw	$82,$82,$42,$42,$42,$42,$42,$42,$42,$42
	dw	$0,$0
	ds	2
	dw	$82,$82,$82,$82,$82,$82,$82,$82,$82,$82
	dw	$82,$82
	ds	2
	dw	$82,$82,$82,$82,$82,$82,$82,$82,$82,$82
	dw	$82,$82
	ds	2
	dw	$82,$82,$82,$82,$82,$82,$82,$82,$82,$82
	dw	$82,$82
	ds	2
	ends
	code
	func
~~push_oneparm:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L13
	tcs
	phd
	tcd
fp_0	set	4
parmno_0	set	8
procname_0	set	10
intparm_1	set	0
typerr_1	set	2
floatparm_1	set	4
stringparm_1	set	8
arrayparm_1	set	14
retparm_1	set	18
parmtype_1	set	24
isreturn_1	set	26
	stz	<R0
	ldy	#$4
	lda	[<L13+fp_0],Y
	and	#<$200
	bne	L16
	brl	L15
L16:
	inc	<R0
L15:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L14+isreturn_1
	rep	#$20
	longa	on
	lda	<L14+isreturn_1
	and	#$ff
	beq	L17
	brl	L10004
L17:
	jsl	~~expression
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L14+parmtype_1
	lda	<L14+parmtype_1
	cmp	#<$2
	beq	L18
	brl	L10005
L18:
	jsl	~~pop_int
	sta	<L14+intparm_1
	brl	L10006
L10005:
	lda	<L14+parmtype_1
	cmp	#<$3
	beq	L19
	brl	L10007
L19:
	phy
	phy
	jsl	~~pop_float
	pla
	sta	<L14+floatparm_1
	pla
	sta	<L14+floatparm_1+2
	brl	L10008
L10007:
	lda	<L14+parmtype_1
	cmp	#<$4
	bne	L21
	brl	L20
L21:
	lda	<L14+parmtype_1
	cmp	#<$5
	beq	L22
	brl	L10009
L22:
L20:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L14+stringparm_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	brl	L10010
L10009:
	sec
	lda	<L14+parmtype_1
	sbc	#<$6
	bvs	L23
	eor	#$8000
L23:
	bmi	L24
	brl	L10011
L24:
	sec
	lda	#$b
	sbc	<L14+parmtype_1
	bvs	L25
	eor	#$8000
L25:
	bmi	L26
	brl	L10011
L26:
	jsl	~~pop_array
	sta	<L14+arrayparm_1
	stx	<L14+arrayparm_1+2
	brl	L10012
L10011:
	pea	#^L1
	pea	#<L1
	pea	#<$126
	pea	#<$82
	pea	#10
	jsl	~~error
L10012:
L10010:
L10008:
L10006:
	brl	L10013
L10004:
	pea	#0
	clc
	tdc
	adc	#<L14+retparm_1
	pha
	jsl	~~get_lvalue
	lda	<L14+retparm_1
	brl	L10014
L10016:
	lda	[<L14+retparm_1+2]
	sta	<L14+intparm_1
	lda	#$2
	sta	<L14+parmtype_1
	brl	L10015
L10017:
	lda	[<L14+retparm_1+2]
	sta	<L14+floatparm_1
	ldy	#$2
	lda	[<L14+retparm_1+2],Y
	sta	<L14+floatparm_1+2
	lda	#$3
	sta	<L14+parmtype_1
	brl	L10015
L10018:
	pei	<L14+retparm_1+4
	pei	<L14+retparm_1+2
	clc
	tdc
	adc	#<L14+stringparm_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	lda	#$4
	sta	<L14+parmtype_1
	brl	L10015
L10019:
	pea	#<$1
	pei	<L14+retparm_1+2
	jsl	~~check_write
	lda	|~~basicvars+6
	sta	<R0
	lda	|~~basicvars+6+2
	sta	<R0+2
	ldy	<L14+retparm_1+2
	lda	[<R0],Y
	and	#$ff
	sta	<L14+intparm_1
	lda	#$2
	sta	<L14+parmtype_1
	brl	L10015
L10020:
	pei	<L14+retparm_1+2
	jsl	~~get_integer
	sta	<L14+intparm_1
	lda	#$2
	sta	<L14+parmtype_1
	brl	L10015
L10021:
	phy
	phy
	pei	<L14+retparm_1+2
	jsl	~~get_float
	pla
	sta	<L14+floatparm_1
	pla
	sta	<L14+floatparm_1+2
	lda	#$3
	sta	<L14+parmtype_1
	brl	L10015
L10022:
	pea	#<$1
	pei	<L14+retparm_1+2
	jsl	~~check_write
	pei	<L14+retparm_1+2
	jsl	~~get_stringlen
	sta	<L14+stringparm_1
	ldy	#$0
	lda	<L14+retparm_1+2
	bpl	L27
	dey
L27:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars+6
	adc	<R0
	sta	<L14+stringparm_1+2
	lda	|~~basicvars+6+2
	adc	<R0+2
	sta	<L14+stringparm_1+4
	lda	#$4
	sta	<L14+parmtype_1
	brl	L10015
L10023:
	lda	[<L14+retparm_1+2]
	sta	<L14+arrayparm_1
	ldy	#$2
	lda	[<L14+retparm_1+2],Y
	sta	<L14+arrayparm_1+2
	lda	#$6
	sta	<L14+parmtype_1
	brl	L10015
L10024:
	lda	[<L14+retparm_1+2]
	sta	<L14+arrayparm_1
	ldy	#$2
	lda	[<L14+retparm_1+2],Y
	sta	<L14+arrayparm_1+2
	lda	#$8
	sta	<L14+parmtype_1
	brl	L10015
L10025:
	lda	[<L14+retparm_1+2]
	sta	<L14+arrayparm_1
	ldy	#$2
	lda	[<L14+retparm_1+2],Y
	sta	<L14+arrayparm_1+2
	lda	#$a
	sta	<L14+parmtype_1
	brl	L10015
L10026:
	pea	#^L1+9
	pea	#<L1+9
	pea	#<$158
	pea	#<$82
	pea	#10
	jsl	~~error
	brl	L10015
L10014:
	xref	~~~fsw
	jsl	~~~fsw
	dw	2
	dw	20
	dw	L10026-1
	dw	L10016-1
	dw	L10017-1
	dw	L10018-1
	dw	L10026-1
	dw	L10026-1
	dw	L10026-1
	dw	L10026-1
	dw	L10026-1
	dw	L10023-1
	dw	L10024-1
	dw	L10025-1
	dw	L10026-1
	dw	L10026-1
	dw	L10026-1
	dw	L10026-1
	dw	L10019-1
	dw	L10020-1
	dw	L10021-1
	dw	L10026-1
	dw	L10022-1
L10015:
L10013:
	lda	<L14+parmtype_1
	asl	A
	sta	<R0
	ldy	#$4
	lda	[<L13+fp_0],Y
	and	#<$f
	sta	<R1
	lda	<R1
	ldx	#<$1a
	xref	~~~mul
	jsl	~~~mul
	sta	<R1
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	ldx	<R2
	lda	|~~type_table,X
	sta	<L14+typerr_1
	lda	<L14+typerr_1
	bne	L28
	brl	L10027
L28:
	lda	<L14+typerr_1
	cmp	#<$82
	beq	L29
	brl	L10028
L29:
	pea	#^L1+18
	pea	#<L1+18
	pea	#<$160
	pea	#<$82
	pea	#10
	jsl	~~error
L10028:
	pei	<L13+parmno_0
	pei	<L14+typerr_1
	pea	#6
	jsl	~~error
L10027:
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
	beq	L30
	brl	L10029
L30:
	inc	|~~basicvars+62
	bne	L31
	inc	|~~basicvars+62+2
L31:
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
	beq	L32
	brl	L10030
L32:
	pea	#<$5
	pea	#4
	jsl	~~error
L10030:
	lda	[<L13+fp_0]
	ldy	#$2
	ora	[<L13+fp_0],Y
	beq	L33
	brl	L10031
L33:
	pei	<L13+procname_0+2
	pei	<L13+procname_0
	pea	#<$11
	pea	#8
	jsl	~~error
L10031:
	pei	<L13+procname_0+2
	pei	<L13+procname_0
	lda	<L13+parmno_0
	ina
	pha
	ldy	#$2
	lda	[<L13+fp_0],Y
	pha
	lda	[<L13+fp_0]
	pha
	jsl	~~push_oneparm
	brl	L10032
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
	beq	L34
	brl	L10033
L34:
	lda	[<L13+fp_0]
	ldy	#$2
	ora	[<L13+fp_0],Y
	bne	L35
	brl	L10034
L35:
	pei	<L13+procname_0+2
	pei	<L13+procname_0
	pea	#<$12
	pea	#8
	jsl	~~error
L10034:
	inc	|~~basicvars+62
	bne	L36
	inc	|~~basicvars+62+2
L36:
	brl	L10035
L10033:
	pea	#<$32
	pea	#4
	jsl	~~error
L10035:
L10032:
	ldy	#$4
	lda	[<L13+fp_0],Y
	and	#<$1f
	sta	<R0
	lda	<R0
	cmp	#<$2
	beq	L37
	brl	L10036
L37:
p_2	set	27
	ldy	#$6
	lda	[<L13+fp_0],Y
	sta	<L14+p_2
	ldy	#$8
	lda	[<L13+fp_0],Y
	sta	<L14+p_2+2
	lda	<L14+isreturn_1
	and	#$ff
	bne	L38
	brl	L10037
L38:
	lda	[<L14+p_2]
	pha
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	lda	#$4
	adc	<L13+fp_0
	sta	<R1
	lda	#$0
	adc	<L13+fp_0+2
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
	adc	#<L14+retparm_1
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
	jsl	~~save_retint
	brl	L10038
L10037:
	lda	[<L14+p_2]
	pha
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	lda	#$4
	adc	<L13+fp_0
	sta	<R1
	lda	#$0
	adc	<L13+fp_0+2
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~save_int
L10038:
	lda	<L14+parmtype_1
	cmp	#<$2
	beq	L40
	brl	L39
L40:
	lda	<L14+intparm_1
	bra	L41
L39:
	pei	<L14+floatparm_1+2
	pei	<L14+floatparm_1
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R0
	pla
	sta	<R0+2
	lda	<R0
L41:
	sta	[<L14+p_2]
L42:
	lda	<L13+2
	sta	<L13+2+10
	lda	<L13+1
	sta	<L13+1+10
	pld
	tsc
	clc
	adc	#L13+10
	tcs
	rtl
L10036:
	ldy	#$4
	lda	[<L13+fp_0],Y
	and	#<$1f
	brl	L10039
L10041:
p_3	set	27
	ldy	#$6
	lda	[<L13+fp_0],Y
	sta	<L14+p_3
	ldy	#$8
	lda	[<L13+fp_0],Y
	sta	<L14+p_3+2
	lda	<L14+isreturn_1
	and	#$ff
	bne	L43
	brl	L10042
L43:
	ldy	#$2
	lda	[<L14+p_3],Y
	pha
	lda	[<L14+p_3]
	pha
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	lda	#$4
	adc	<L13+fp_0
	sta	<R1
	lda	#$0
	adc	<L13+fp_0+2
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
	adc	#<L14+retparm_1
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
	jsl	~~save_retfloat
	brl	L10043
L10042:
	ldy	#$2
	lda	[<L14+p_3],Y
	pha
	lda	[<L14+p_3]
	pha
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	lda	#$4
	adc	<L13+fp_0
	sta	<R1
	lda	#$0
	adc	<L13+fp_0+2
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~save_float
L10043:
	lda	<L14+parmtype_1
	cmp	#<$2
	beq	L45
	brl	L44
L45:
	ldy	#$0
	lda	<L14+intparm_1
	bpl	L46
	dey
L46:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	bra	L47
L44:
	pei	<L14+floatparm_1+2
	pei	<L14+floatparm_1
L47:
	pla
	sta	[<L14+p_3]
	pla
	ldy	#$2
	sta	[<L14+p_3],Y
	brl	L10040
L10044:
p_4	set	27
	ldy	#$6
	lda	[<L13+fp_0],Y
	sta	<L14+p_4
	ldy	#$8
	lda	[<L13+fp_0],Y
	sta	<L14+p_4+2
	lda	<L14+isreturn_1
	and	#$ff
	bne	L48
	brl	L10045
L48:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	pei	<L14+p_4+2
	pei	<L14+p_4
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
	lda	#$4
	adc	<L13+fp_0
	sta	<R1
	lda	#$0
	adc	<L13+fp_0+2
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
	adc	#<L14+retparm_1
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
	jsl	~~save_retstring
	brl	L10046
L10045:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	pei	<L14+p_4+2
	pei	<L14+p_4
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
	lda	#$4
	adc	<L13+fp_0
	sta	<R1
	lda	#$0
	adc	<L13+fp_0+2
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~save_string
L10046:
	lda	<L14+parmtype_1
	cmp	#<$4
	beq	L49
	brl	L10047
L49:
	lda	<L14+stringparm_1
	sta	[<L14+p_4]
	pei	<L14+stringparm_1
	jsl	~~alloc_string
	sta	<R0
	stx	<R0+2
	lda	<R0
	ldy	#$2
	sta	[<L14+p_4],Y
	lda	<R0+2
	ldy	#$4
	sta	[<L14+p_4],Y
	sec
	lda	#$0
	sbc	<L14+stringparm_1
	bvs	L50
	eor	#$8000
L50:
	bpl	L51
	brl	L10048
L51:
	ldy	#$0
	lda	<L14+stringparm_1
	bpl	L52
	dey
L52:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L14+stringparm_1+4
	pei	<L14+stringparm_1+2
	ldy	#$4
	lda	[<L14+p_4],Y
	pha
	ldy	#$2
	lda	[<L14+p_4],Y
	pha
	jsl	~~memmove
L10048:
	brl	L10049
L10047:
	clc
	tdc
	adc	#<L14+stringparm_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L14+p_4+2
	pei	<L14+p_4
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
L10049:
	brl	L10040
L10050:
	pea	#<$1
	ldy	#$6
	lda	[<L13+fp_0],Y
	pha
	jsl	~~check_write
	lda	<L14+isreturn_1
	and	#$ff
	bne	L53
	brl	L10051
L53:
	ldy	#$6
	lda	[<L13+fp_0],Y
	sta	<R0
	lda	|~~basicvars+6
	sta	<R1
	lda	|~~basicvars+6+2
	sta	<R1+2
	ldy	<R0
	lda	[<R1],Y
	and	#$ff
	pha
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R1
	stz	<R1+2
	clc
	lda	#$4
	adc	<L13+fp_0
	sta	<R2
	lda	#$0
	adc	<L13+fp_0+2
	sta	<R2+2
	pei	<R2+2
	pei	<R2
	pei	<R1+2
	pei	<R1
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R1
	stz	<R1+2
	clc
	tdc
	adc	#<L14+retparm_1
	sta	<R2
	lda	#$0
	sta	<R2+2
	pei	<R2+2
	pei	<R2
	pei	<R1+2
	pei	<R1
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~save_retint
	brl	L10052
L10051:
	ldy	#$6
	lda	[<L13+fp_0],Y
	sta	<R0
	lda	|~~basicvars+6
	sta	<R1
	lda	|~~basicvars+6+2
	sta	<R1+2
	ldy	<R0
	lda	[<R1],Y
	and	#$ff
	pha
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R1
	stz	<R1+2
	clc
	lda	#$4
	adc	<L13+fp_0
	sta	<R2
	lda	#$0
	adc	<L13+fp_0+2
	sta	<R2+2
	pei	<R2+2
	pei	<R2
	pei	<R1+2
	pei	<R1
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~save_int
L10052:
	ldy	#$6
	lda	[<L13+fp_0],Y
	sta	<R0
	lda	|~~basicvars+6
	sta	<R1
	lda	|~~basicvars+6+2
	sta	<R1+2
	lda	<L14+parmtype_1
	cmp	#<$2
	beq	L55
	brl	L54
L55:
	lda	<L14+intparm_1
	bra	L56
L54:
	pei	<L14+floatparm_1+2
	pei	<L14+floatparm_1
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R2
	pla
	sta	<R2+2
	lda	<R2
L56:
	sep	#$20
	longa	off
	ldy	<R0
	sta	[<R1],Y
	rep	#$20
	longa	on
	brl	L10040
L10053:
	lda	<L14+isreturn_1
	and	#$ff
	bne	L57
	brl	L10054
L57:
	ldy	#$6
	lda	[<L13+fp_0],Y
	pha
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
	lda	#$4
	adc	<L13+fp_0
	sta	<R1
	lda	#$0
	adc	<L13+fp_0+2
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
	adc	#<L14+retparm_1
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
	jsl	~~save_retint
	brl	L10055
L10054:
	ldy	#$6
	lda	[<L13+fp_0],Y
	pha
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
	lda	#$4
	adc	<L13+fp_0
	sta	<R1
	lda	#$0
	adc	<L13+fp_0+2
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~save_int
L10055:
	lda	<L14+parmtype_1
	cmp	#<$2
	beq	L59
	brl	L58
L59:
	lda	<L14+intparm_1
	bra	L60
L58:
	pei	<L14+floatparm_1+2
	pei	<L14+floatparm_1
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R0
	pla
	sta	<R0+2
	lda	<R0
L60:
	pha
	ldy	#$6
	lda	[<L13+fp_0],Y
	pha
	jsl	~~store_integer
	brl	L10040
L10056:
	lda	<L14+isreturn_1
	and	#$ff
	bne	L61
	brl	L10057
L61:
	phy
	phy
	ldy	#$6
	lda	[<L13+fp_0],Y
	pha
	jsl	~~get_float
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	lda	#$4
	adc	<L13+fp_0
	sta	<R1
	lda	#$0
	adc	<L13+fp_0+2
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
	adc	#<L14+retparm_1
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
	jsl	~~save_retfloat
	brl	L10058
L10057:
	phy
	phy
	ldy	#$6
	lda	[<L13+fp_0],Y
	pha
	jsl	~~get_float
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	lda	#$4
	adc	<L13+fp_0
	sta	<R1
	lda	#$0
	adc	<L13+fp_0+2
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~save_float
L10058:
	lda	<L14+parmtype_1
	cmp	#<$2
	beq	L63
	brl	L62
L63:
	ldy	#$0
	lda	<L14+intparm_1
	bpl	L64
	dey
L64:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	bra	L65
L62:
	pei	<L14+floatparm_1+2
	pei	<L14+floatparm_1
L65:
	ldy	#$6
	lda	[<L13+fp_0],Y
	pha
	jsl	~~store_float
	brl	L10040
L10059:
descriptor_5	set	27
sp_5	set	33
	lda	<L14+stringparm_1
	ina
	pha
	ldy	#$6
	lda	[<L13+fp_0],Y
	pha
	jsl	~~check_write
	ldy	#$0
	phy
	ldy	#$6
	lda	[<L13+fp_0],Y
	ply
	rol	A
	ror	A
	bpl	L66
	dey
L66:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars+6
	adc	<R0
	sta	<L14+sp_5
	lda	|~~basicvars+6+2
	adc	<R0+2
	sta	<L14+sp_5+2
	ldy	#$6
	lda	[<L13+fp_0],Y
	pha
	jsl	~~get_stringlen
	sta	<R0
	lda	<R0
	ina
	sta	<L14+descriptor_5
	pei	<L14+descriptor_5
	jsl	~~alloc_string
	sta	<L14+descriptor_5+2
	stx	<L14+descriptor_5+4
	sec
	lda	#$0
	sbc	<L14+descriptor_5
	bvs	L67
	eor	#$8000
L67:
	bpl	L68
	brl	L10060
L68:
	ldy	#$0
	lda	<L14+descriptor_5
	bpl	L69
	dey
L69:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L14+sp_5+2
	pei	<L14+sp_5
	pei	<L14+descriptor_5+4
	pei	<L14+descriptor_5+2
	jsl	~~memmove
L10060:
	lda	<L14+isreturn_1
	and	#$ff
	bne	L70
	brl	L10061
L70:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L14+descriptor_5
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
	lda	#$4
	adc	<L13+fp_0
	sta	<R1
	lda	#$0
	adc	<L13+fp_0+2
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
	adc	#<L14+retparm_1
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
	jsl	~~save_retstring
	brl	L10062
L10061:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L14+descriptor_5
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
	lda	#$4
	adc	<L13+fp_0
	sta	<R1
	lda	#$0
	adc	<L13+fp_0+2
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~save_string
L10062:
	sec
	lda	#$0
	sbc	<L14+stringparm_1
	bvs	L71
	eor	#$8000
L71:
	bpl	L72
	brl	L10063
L72:
	ldy	#$0
	lda	<L14+stringparm_1
	bpl	L73
	dey
L73:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L14+stringparm_1+4
	pei	<L14+stringparm_1+2
	pei	<L14+sp_5+2
	pei	<L14+sp_5
	jsl	~~memmove
L10063:
	sep	#$20
	longa	off
	lda	#$d
	ldy	<L14+stringparm_1
	sta	[<L14+sp_5],Y
	rep	#$20
	longa	on
	lda	<L14+parmtype_1
	cmp	#<$5
	beq	L74
	brl	L10064
L74:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L14+stringparm_1
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
L10064:
	brl	L10040
L10065:
L10066:
L10067:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	lda	#$4
	adc	<L13+fp_0
	sta	<R1
	lda	#$0
	adc	<L13+fp_0+2
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~save_array
	ldy	#$6
	lda	[<L13+fp_0],Y
	sta	<R0
	ldy	#$8
	lda	[<L13+fp_0],Y
	sta	<R0+2
	lda	<L14+arrayparm_1
	sta	[<R0]
	lda	<L14+arrayparm_1+2
	ldy	#$2
	sta	[<R0],Y
	brl	L10040
L10068:
	pea	#^L1+27
	pea	#<L1+27
	pea	#<$1d4
	pea	#<$82
	pea	#10
	jsl	~~error
	brl	L10040
L10039:
	xref	~~~fsw
	jsl	~~~fsw
	dw	3
	dw	19
	dw	L10068-1
	dw	L10041-1
	dw	L10044-1
	dw	L10068-1
	dw	L10068-1
	dw	L10068-1
	dw	L10068-1
	dw	L10068-1
	dw	L10065-1
	dw	L10066-1
	dw	L10067-1
	dw	L10068-1
	dw	L10068-1
	dw	L10068-1
	dw	L10068-1
	dw	L10050-1
	dw	L10053-1
	dw	L10056-1
	dw	L10068-1
	dw	L10059-1
L10040:
	brl	L42
L13	equ	49
L14	equ	13
	ends
	efunc
	data
L1:
	db	$65,$76,$61,$6C,$75,$61,$74,$65,$00,$65,$76,$61,$6C,$75,$61
	db	$74,$65,$00,$65,$76,$61,$6C,$75,$61,$74,$65,$00,$65,$76,$61
	db	$6C,$75,$61,$74,$65,$00
	ends
	code
	func
~~push_singleparm:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L76
	tcs
	phd
	tcd
fp_0	set	4
procname_0	set	8
parmtype_1	set	0
intparm_1	set	2
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
	bne	L78
	brl	L10069
L78:
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
	beq	L79
	brl	L10070
L79:
	pei	<L76+procname_0+2
	pei	<L76+procname_0
	pea	#<$11
	pea	#8
	jsl	~~error
	brl	L10071
L10070:
	pea	#<$29
	pea	#4
	jsl	~~error
L10071:
L10069:
	inc	|~~basicvars+62
	bne	L80
	inc	|~~basicvars+62+2
L80:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L77+parmtype_1
	lda	<L77+parmtype_1
	cmp	#<$2
	bne	L81
	brl	L10072
L81:
	lda	<L77+parmtype_1
	cmp	#<$3
	bne	L82
	brl	L10072
L82:
	pea	#<$1
	pea	#<$41
	pea	#6
	jsl	~~error
L10072:
	lda	<L77+parmtype_1
	cmp	#<$2
	beq	L84
	brl	L83
L84:
	jsl	~~pop_int
	bra	L85
L83:
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
L85:
	sta	<L77+intparm_1
	ldy	#$6
	lda	[<L76+fp_0],Y
	sta	<R0
	ldy	#$8
	lda	[<L76+fp_0],Y
	sta	<R0+2
	lda	[<R0]
	pha
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	lda	#$4
	adc	<L76+fp_0
	sta	<R1
	lda	#$0
	adc	<L76+fp_0+2
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~save_int
	ldy	#$6
	lda	[<L76+fp_0],Y
	sta	<R0
	ldy	#$8
	lda	[<L76+fp_0],Y
	sta	<R0+2
	lda	<L77+intparm_1
	sta	[<R0]
L86:
	lda	<L76+2
	sta	<L76+2+8
	lda	<L76+1
	sta	<L76+1+8
	pld
	tsc
	clc
	adc	#L76+8
	tcs
	rtl
L76	equ	12
L77	equ	9
	ends
	efunc
	code
	xdef	~~push_parameters
	func
~~push_parameters:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L87
	tcs
	phd
	tcd
dp_0	set	4
base_0	set	8
	inc	|~~basicvars+62
	bne	L89
	inc	|~~basicvars+62+2
L89:
	ldy	#$6
	lda	[<L87+dp_0],Y
	and	#$ff
	bne	L90
	brl	L10073
L90:
	pei	<L87+base_0+2
	pei	<L87+base_0
	ldy	#$9
	lda	[<L87+dp_0],Y
	pha
	ldy	#$7
	lda	[<L87+dp_0],Y
	pha
	jsl	~~push_singleparm
	brl	L10074
L10073:
	pei	<L87+base_0+2
	pei	<L87+base_0
	pea	#<$1
	ldy	#$9
	lda	[<L87+dp_0],Y
	pha
	ldy	#$7
	lda	[<L87+dp_0],Y
	pha
	jsl	~~push_oneparm
L10074:
L91:
	lda	<L87+2
	sta	<L87+2+8
	lda	<L87+1
	sta	<L87+1+8
	pld
	tsc
	clc
	adc	#L87+8
	tcs
	rtl
L87	equ	0
L88	equ	1
	ends
	efunc
	code
	func
~~do_staticvar:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L92
	tcs
	phd
	tcd
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
	ldx	<R1
	lda	|~~basicvars+504+16,X
	ldy	#$2
	sta	[<R0],Y
	clc
	lda	#$2
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L94
	inc	|~~basicvars+62+2
L94:
L95:
	pld
	tsc
	clc
	adc	#L92
	tcs
	rtl
L92	equ	8
L93	equ	9
	ends
	efunc
	code
	func
~~do_statindvar:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L96
	tcs
	phd
	tcd
address_1	set	0
operator_1	set	2
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
	ldx	<R0
	lda	|~~basicvars+504+16,X
	sta	<L97+address_1
	clc
	lda	#$2
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
	sta	<L97+operator_1
	rep	#$20
	longa	on
	inc	|~~basicvars+62
	bne	L99
	inc	|~~basicvars+62+2
L99:
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
	beq	L100
	brl	L10075
L100:
	jsl	~~pop_int
	sta	<R0
	clc
	lda	<R0
	adc	<L97+address_1
	sta	<L97+address_1
	brl	L10076
L10075:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$3
	beq	L101
	brl	L10077
L101:
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
	adc	<L97+address_1
	sta	<L97+address_1
	brl	L10078
L10077:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10078:
L10076:
	sep	#$20
	longa	off
	lda	<L97+operator_1
	cmp	#<$3f
	rep	#$20
	longa	on
	beq	L102
	brl	L10079
L102:
	pea	#<$1
	pei	<L97+address_1
	jsl	~~check_read
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
	lda	|~~basicvars+6
	sta	<R1
	lda	|~~basicvars+6+2
	sta	<R1+2
	ldy	<L97+address_1
	lda	[<R1],Y
	and	#$ff
	ldy	#$2
	sta	[<R0],Y
	brl	L10080
L10079:
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
	pei	<L97+address_1
	jsl	~~get_integer
	ldy	#$2
	sta	[<R0],Y
L10080:
L103:
	pld
	tsc
	clc
	adc	#L96
	tcs
	rtl
L96	equ	11
L97	equ	9
	ends
	efunc
	code
	func
~~do_intzero:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L104
	tcs
	phd
	tcd
	inc	|~~basicvars+62
	bne	L106
	inc	|~~basicvars+62+2
L106:
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
L107:
	pld
	tsc
	clc
	adc	#L104
	tcs
	rtl
L104	equ	4
L105	equ	5
	ends
	efunc
	code
	func
~~do_intone:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L108
	tcs
	phd
	tcd
	inc	|~~basicvars+62
	bne	L110
	inc	|~~basicvars+62+2
L110:
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
L111:
	pld
	tsc
	clc
	adc	#L108
	tcs
	rtl
L108	equ	4
L109	equ	5
	ends
	efunc
	code
	func
~~do_smallconst:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L112
	tcs
	phd
	tcd
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
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	ldy	#$1
	lda	[<R1],Y
	and	#$ff
	sta	<R1
	lda	<R1
	ina
	ldy	#$2
	sta	[<R0],Y
	clc
	lda	#$2
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L114
	inc	|~~basicvars+62+2
L114:
L115:
	pld
	tsc
	clc
	adc	#L112
	tcs
	rtl
L112	equ	8
L113	equ	9
	ends
	efunc
	code
	func
~~do_intconst:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L116
	tcs
	phd
	tcd
	inc	|~~basicvars+62
	bne	L118
	inc	|~~basicvars+62+2
L118:
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
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	lda	[<R1]
	and	#$ff
	sta	<R1
	lda	|~~basicvars+62
	sta	<R3
	lda	|~~basicvars+62+2
	sta	<R3+2
	ldy	#$1
	lda	[<R3],Y
	and	#$ff
	sta	<R3
	lda	<R3
	xba
	and	#$ff00
	sta	<R2
	lda	<R2
	ora	<R1
	sta	<R3
	lda	|~~basicvars+62
	sta	<R2
	lda	|~~basicvars+62+2
	sta	<R2+2
	ldy	#$2
	lda	[<R2],Y
	and	#$ff
	ldx	#<$10
	xref	~~~asl
	jsl	~~~asl
	sta	<R1
	lda	<R1
	ora	<R3
	sta	<R2
	lda	|~~basicvars+62
	sta	<R3
	lda	|~~basicvars+62+2
	sta	<R3+2
	ldy	#$3
	lda	[<R3],Y
	and	#$ff
	ldx	#<$18
	xref	~~~asl
	jsl	~~~asl
	sta	<R1
	lda	<R1
	ora	<R2
	ldy	#$2
	sta	[<R0],Y
	clc
	lda	#$4
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L119
	inc	|~~basicvars+62+2
L119:
L120:
	pld
	tsc
	clc
	adc	#L116
	tcs
	rtl
L116	equ	16
L117	equ	17
	ends
	efunc
	code
	func
~~do_floatzero:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L121
	tcs
	phd
	tcd
	inc	|~~basicvars+62
	bne	L123
	inc	|~~basicvars+62+2
L123:
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
	lda	#$0
	ldy	#$2
	sta	[<R0],Y
	lda	#$0
	ldy	#$4
	sta	[<R0],Y
L124:
	pld
	tsc
	clc
	adc	#L121
	tcs
	rtl
L121	equ	4
L122	equ	5
	ends
	efunc
	code
	func
~~do_floatone:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L125
	tcs
	phd
	tcd
	inc	|~~basicvars+62
	bne	L127
	inc	|~~basicvars+62+2
L127:
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
	lda	#$0
	ldy	#$2
	sta	[<R0],Y
	lda	#$3f80
	ldy	#$4
	sta	[<R0],Y
L128:
	pld
	tsc
	clc
	adc	#L125
	tcs
	rtl
L125	equ	4
L126	equ	5
	ends
	efunc
	code
	func
~~do_floatconst:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L129
	tcs
	phd
	tcd
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
	phy
	phy
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~get_fpvalue
	pla
	ldy	#$2
	sta	[<R0],Y
	pla
	ldy	#$4
	sta	[<R0],Y
	clc
	lda	#$5
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L131
	inc	|~~basicvars+62+2
L131:
L132:
	pld
	tsc
	clc
	adc	#L129
	tcs
	rtl
L129	equ	4
L130	equ	5
	ends
	efunc
	code
	func
~~do_intvar:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L133
	tcs
	phd
	tcd
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
	bpl	L135
	dey
L135:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars
	adc	<R0
	sta	<L134+ip_1
	lda	|~~basicvars+2
	adc	<R0+2
	sta	<L134+ip_1+2
	clc
	lda	#$5
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L136
	inc	|~~basicvars+62+2
L136:
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
	lda	[<L134+ip_1]
	ldy	#$2
	sta	[<R0],Y
L137:
	pld
	tsc
	clc
	adc	#L133
	tcs
	rtl
L133	equ	16
L134	equ	13
	ends
	efunc
	code
	func
~~do_floatvar:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L138
	tcs
	phd
	tcd
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
	bpl	L140
	dey
L140:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars
	adc	<R0
	sta	<L139+fp_1
	lda	|~~basicvars+2
	adc	<R0+2
	sta	<L139+fp_1+2
	clc
	lda	#$5
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L141
	inc	|~~basicvars+62+2
L141:
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
	lda	[<L139+fp_1]
	ldy	#$2
	sta	[<R0],Y
	ldy	#$2
	lda	[<L139+fp_1],Y
	ldy	#$4
	sta	[<R0],Y
L142:
	pld
	tsc
	clc
	adc	#L138
	tcs
	rtl
L138	equ	16
L139	equ	13
	ends
	efunc
	code
	func
~~do_stringvar:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L143
	tcs
	phd
	tcd
sp_1	set	0
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
	bpl	L145
	dey
L145:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars
	adc	<R0
	sta	<L144+sp_1
	lda	|~~basicvars+2
	adc	<R0+2
	sta	<L144+sp_1+2
	clc
	lda	#$5
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L146
	inc	|~~basicvars+62+2
L146:
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
	pei	<L144+sp_1+2
	pei	<L144+sp_1
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
L147:
	pld
	tsc
	clc
	adc	#L143
	tcs
	rtl
L143	equ	16
L144	equ	13
	ends
	efunc
	code
	func
~~do_arrayvar:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L148
	tcs
	phd
	tcd
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
	bpl	L150
	dey
L150:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars
	adc	<R0
	sta	<L149+vp_1
	lda	|~~basicvars+2
	adc	<R0+2
	sta	<L149+vp_1+2
	clc
	lda	#$6
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L151
	inc	|~~basicvars+62+2
L151:
	ldy	#$4
	lda	[<L149+vp_1],Y
	pha
	ldy	#$12
	lda	[<L149+vp_1],Y
	pha
	ldy	#$10
	lda	[<L149+vp_1],Y
	pha
	jsl	~~push_array
L152:
	pld
	tsc
	clc
	adc	#L148
	tcs
	rtl
L148	equ	16
L149	equ	13
	ends
	efunc
	code
	func
~~do_arrayref:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L153
	tcs
	phd
	tcd
vp_1	set	0
operator_1	set	4
vartype_1	set	5
maxdims_1	set	7
index_1	set	9
dimcount_1	set	11
element_1	set	13
offset_1	set	15
descriptor_1	set	17
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
	bpl	L155
	dey
L155:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars
	adc	<R0
	sta	<L154+vp_1
	lda	|~~basicvars+2
	adc	<R0+2
	sta	<L154+vp_1+2
	clc
	lda	#$5
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L156
	inc	|~~basicvars+62+2
L156:
	ldy	#$10
	lda	[<L154+vp_1],Y
	sta	<L154+descriptor_1
	ldy	#$12
	lda	[<L154+vp_1],Y
	sta	<L154+descriptor_1+2
	ldy	#$4
	lda	[<L154+vp_1],Y
	sta	<L154+vartype_1
	lda	[<L154+descriptor_1]
	cmp	#<$1
	beq	L157
	brl	L10081
L157:
	jsl	~~expression
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$2
	beq	L158
	brl	L10082
L158:
	jsl	~~pop_int
	sta	<L154+element_1
	brl	L10083
L10082:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$3
	beq	L159
	brl	L10084
L159:
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
	sta	<L154+element_1
	brl	L10085
L10084:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10085:
L10083:
	lda	<L154+element_1
	bpl	L161
	brl	L160
L161:
	sec
	lda	<L154+element_1
	ldy	#$8
	sbc	[<L154+descriptor_1],Y
	bvs	L162
	eor	#$8000
L162:
	bmi	L163
	brl	L10086
L163:
L160:
	ldy	#$8
	lda	[<L154+vp_1],Y
	pha
	ldy	#$6
	lda	[<L154+vp_1],Y
	pha
	pei	<L154+element_1
	pea	#<$1c
	pea	#10
	jsl	~~error
L10086:
	brl	L10087
L10081:
	lda	[<L154+descriptor_1]
	sta	<L154+maxdims_1
	stz	<L154+dimcount_1
	stz	<L154+element_1
L10090:
	jsl	~~expression
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$2
	beq	L164
	brl	L10091
L164:
	jsl	~~pop_int
	sta	<L154+index_1
	brl	L10092
L10091:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$3
	beq	L165
	brl	L10093
L165:
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
	sta	<L154+index_1
	brl	L10094
L10093:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10094:
L10092:
	lda	<L154+index_1
	bpl	L167
	brl	L166
L167:
	ldy	#$0
	lda	<L154+dimcount_1
	bpl	L168
	dey
L168:
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
	adc	<L154+descriptor_1
	sta	<R2
	lda	#$0
	adc	<L154+descriptor_1+2
	sta	<R2+2
	clc
	lda	<R2
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	sec
	lda	<L154+index_1
	sbc	[<R3]
	bvs	L169
	eor	#$8000
L169:
	bmi	L170
	brl	L10095
L170:
L166:
	ldy	#$8
	lda	[<L154+vp_1],Y
	pha
	ldy	#$6
	lda	[<L154+vp_1],Y
	pha
	pei	<L154+index_1
	pea	#<$1c
	pea	#10
	jsl	~~error
L10095:
	inc	<L154+dimcount_1
	clc
	lda	<L154+element_1
	adc	<L154+index_1
	sta	<L154+element_1
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
	beq	L171
	brl	L10089
L171:
	inc	|~~basicvars+62
	bne	L172
	inc	|~~basicvars+62+2
L172:
	sec
	lda	<L154+maxdims_1
	sbc	<L154+dimcount_1
	bvs	L173
	eor	#$8000
L173:
	bpl	L174
	brl	L10096
L174:
	ldy	#$8
	lda	[<L154+vp_1],Y
	pha
	ldy	#$6
	lda	[<L154+vp_1],Y
	pha
	pea	#<$1d
	pea	#8
	jsl	~~error
L10096:
	lda	<L154+dimcount_1
	cmp	<L154+maxdims_1
	bne	L175
	brl	L10097
L175:
	ldy	#$0
	lda	<L154+dimcount_1
	bpl	L176
	dey
L176:
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
	adc	<L154+descriptor_1
	sta	<R2
	lda	#$0
	adc	<L154+descriptor_1+2
	sta	<R2+2
	clc
	lda	<R2
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	lda	[<R3]
	ldx	<L154+element_1
	xref	~~~mul
	jsl	~~~mul
	sta	<L154+element_1
L10097:
L10088:
	brl	L10090
L10089:
	lda	<L154+dimcount_1
	cmp	<L154+maxdims_1
	bne	L177
	brl	L10098
L177:
	ldy	#$8
	lda	[<L154+vp_1],Y
	pha
	ldy	#$6
	lda	[<L154+vp_1],Y
	pha
	pea	#<$1d
	pea	#8
	jsl	~~error
L10098:
L10087:
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
	bne	L178
	brl	L10099
L178:
	pea	#<$29
	pea	#4
	jsl	~~error
L10099:
	inc	|~~basicvars+62
	bne	L179
	inc	|~~basicvars+62+2
L179:
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
	bne	L180
	brl	L10100
L180:
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
	bne	L181
	brl	L10100
L181:
	lda	<L154+vartype_1
	cmp	#<$a
	beq	L182
	brl	L10101
L182:
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
	ldy	#$10
	lda	[<L154+vp_1],Y
	sta	<R1
	ldy	#$12
	lda	[<L154+vp_1],Y
	sta	<R1+2
	ldy	#$0
	lda	<L154+element_1
	bpl	L183
	dey
L183:
	sta	<R3
	sty	<R3+2
	pei	<R3+2
	pei	<R3
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R2
	stx	<R2+2
	clc
	ldy	#$4
	lda	[<R1],Y
	adc	<R2
	sta	<17
	ldy	#$6
	lda	[<R1],Y
	adc	<R2+2
	sta	<17+2
	lda	[<17]
	ldy	#$2
	sta	[<R0],Y
L184:
	pld
	tsc
	clc
	adc	#L153
	tcs
	rtl
L10101:
	lda	<L154+vartype_1
	cmp	#<$b
	beq	L185
	brl	L10102
L185:
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
	ldy	#$10
	lda	[<L154+vp_1],Y
	sta	<R1
	ldy	#$12
	lda	[<L154+vp_1],Y
	sta	<R1+2
	ldy	#$0
	lda	<L154+element_1
	bpl	L186
	dey
L186:
	sta	<R3
	sty	<R3+2
	pei	<R3+2
	pei	<R3
	lda	#$2
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R2
	stx	<R2+2
	clc
	ldy	#$4
	lda	[<R1],Y
	adc	<R2
	sta	<17
	ldy	#$6
	lda	[<R1],Y
	adc	<R2+2
	sta	<17+2
	lda	[<17]
	ldy	#$2
	sta	[<R0],Y
	ldy	#$2
	lda	[<17],Y
	ldy	#$4
	sta	[<R0],Y
	brl	L184
L10102:
	lda	<L154+vartype_1
	cmp	#<$c
	beq	L187
	brl	L10103
L187:
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
	ldy	#$0
	lda	<L154+element_1
	bpl	L188
	dey
L188:
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
	ldy	#$10
	lda	[<L154+vp_1],Y
	sta	<R1
	ldy	#$12
	lda	[<L154+vp_1],Y
	sta	<R1+2
	clc
	ldy	#$4
	lda	[<R1],Y
	adc	<R0
	sta	<R2
	ldy	#$6
	lda	[<R1],Y
	adc	<R0+2
	sta	<R2+2
	pei	<R2+2
	pei	<R2
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
	brl	L184
L10103:
	pea	#^L75
	pea	#<L75
	pea	#<$2ce
	pea	#<$82
	pea	#10
	jsl	~~error
	brl	L10104
L10100:
	lda	<L154+vartype_1
	cmp	#<$a
	beq	L189
	brl	L10105
L189:
	ldy	#$10
	lda	[<L154+vp_1],Y
	sta	<R0
	ldy	#$12
	lda	[<L154+vp_1],Y
	sta	<R0+2
	ldy	#$0
	lda	<L154+element_1
	bpl	L190
	dey
L190:
	sta	<R2
	sty	<R2+2
	pei	<R2+2
	pei	<R2
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R1
	stx	<R1+2
	clc
	ldy	#$4
	lda	[<R0],Y
	adc	<R1
	sta	<R3
	ldy	#$6
	lda	[<R0],Y
	adc	<R1+2
	sta	<R3+2
	lda	[<R3]
	sta	<L154+offset_1
	brl	L10106
L10105:
	lda	<L154+vartype_1
	cmp	#<$b
	beq	L191
	brl	L10107
L191:
	ldy	#$10
	lda	[<L154+vp_1],Y
	sta	<R0
	ldy	#$12
	lda	[<L154+vp_1],Y
	sta	<R0+2
	ldy	#$0
	lda	<L154+element_1
	bpl	L192
	dey
L192:
	sta	<R2
	sty	<R2+2
	pei	<R2+2
	pei	<R2
	lda	#$2
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R1
	stx	<R1+2
	clc
	ldy	#$4
	lda	[<R0],Y
	adc	<R1
	sta	<R3
	ldy	#$6
	lda	[<R0],Y
	adc	<R1+2
	sta	<R3+2
	ldy	#$2
	lda	[<R3],Y
	pha
	lda	[<R3]
	pha
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R0
	pla
	sta	<R0+2
	lda	<R0
	sta	<L154+offset_1
	brl	L10108
L10107:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10108:
L10106:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	sta	<L154+operator_1
	rep	#$20
	longa	on
	inc	|~~basicvars+62
	bne	L193
	inc	|~~basicvars+62+2
L193:
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
	beq	L194
	brl	L10109
L194:
	jsl	~~pop_int
	sta	<R0
	clc
	lda	<R0
	adc	<L154+offset_1
	sta	<L154+offset_1
	brl	L10110
L10109:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$3
	beq	L195
	brl	L10111
L195:
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
	adc	<L154+offset_1
	sta	<L154+offset_1
	brl	L10112
L10111:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10112:
L10110:
	sep	#$20
	longa	off
	lda	<L154+operator_1
	cmp	#<$3f
	rep	#$20
	longa	on
	beq	L196
	brl	L10113
L196:
	pea	#<$1
	pei	<L154+offset_1
	jsl	~~check_read
	lda	|~~basicvars+6
	sta	<R0
	lda	|~~basicvars+6+2
	sta	<R0+2
	ldy	<L154+offset_1
	lda	[<R0],Y
	and	#$ff
	pha
	jsl	~~push_int
	brl	L10114
L10113:
	pei	<L154+offset_1
	jsl	~~get_integer
	pha
	jsl	~~push_int
L10114:
L10104:
	brl	L184
L153	equ	41
L154	equ	21
	ends
	efunc
	data
L75:
	db	$65,$76,$61,$6C,$75,$61,$74,$65,$00
	ends
	code
	func
~~do_indrefvar:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L198
	tcs
	phd
	tcd
operator_1	set	0
offset_1	set	1
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$9
	rep	#$20
	longa	on
	beq	L200
	brl	L10115
L200:
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
	lda	|~~basicvars
	sta	<R0
	lda	|~~basicvars+2
	sta	<R0+2
	ldy	<R2
	lda	[<R0],Y
	sta	<L199+offset_1
	brl	L10116
L10115:
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
	clc
	lda	|~~basicvars
	adc	<R2
	sta	<R0
	lda	|~~basicvars+2
	adc	#0
	sta	<R0+2
	ldy	#$2
	lda	[<R0],Y
	pha
	lda	[<R0]
	pha
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R1
	pla
	sta	<R1+2
	lda	<R1
	sta	<L199+offset_1
L10116:
	clc
	lda	#$5
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L201
	inc	|~~basicvars+62+2
L201:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	sta	<L199+operator_1
	rep	#$20
	longa	on
	inc	|~~basicvars+62
	bne	L202
	inc	|~~basicvars+62+2
L202:
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
	beq	L203
	brl	L10117
L203:
	jsl	~~pop_int
	sta	<R0
	clc
	lda	<R0
	adc	<L199+offset_1
	sta	<L199+offset_1
	brl	L10118
L10117:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$3
	beq	L204
	brl	L10119
L204:
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
	adc	<L199+offset_1
	sta	<L199+offset_1
	brl	L10120
L10119:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10120:
L10118:
	sep	#$20
	longa	off
	lda	<L199+operator_1
	cmp	#<$3f
	rep	#$20
	longa	on
	beq	L205
	brl	L10121
L205:
	pea	#<$1
	pei	<L199+offset_1
	jsl	~~check_read
	lda	|~~basicvars+6
	sta	<R0
	lda	|~~basicvars+6+2
	sta	<R0+2
	ldy	<L199+offset_1
	lda	[<R0],Y
	and	#$ff
	pha
	jsl	~~push_int
	brl	L10122
L10121:
	pei	<L199+offset_1
	jsl	~~get_integer
	pha
	jsl	~~push_int
L10122:
L206:
	pld
	tsc
	clc
	adc	#L198
	tcs
	rtl
L198	equ	15
L199	equ	13
	ends
	efunc
	code
	func
~~do_xvar:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L207
	tcs
	phd
	tcd
np_1	set	0
base_1	set	4
vp_1	set	8
vartype_1	set	12
isarray_1	set	14
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~get_srcaddr
	sta	<L208+base_1
	stx	<L208+base_1+2
	pei	<L208+base_1+2
	pei	<L208+base_1
	jsl	~~skip_name
	sta	<L208+np_1
	stx	<L208+np_1+2
	sec
	lda	<L208+np_1
	sbc	<L208+base_1
	sta	<R0
	lda	<L208+np_1+2
	sbc	<L208+base_1+2
	sta	<R0+2
	pei	<R0
	pei	<L208+base_1+2
	pei	<L208+base_1
	jsl	~~find_variable
	sta	<L208+vp_1
	stx	<L208+vp_1+2
	lda	<L208+vp_1
	ora	<L208+vp_1+2
	beq	L209
	brl	L10123
L209:
	clc
	lda	#$ffff
	adc	<L208+np_1
	sta	<R0
	lda	#$ffff
	adc	<L208+np_1+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$28
	rep	#$20
	longa	on
	bne	L211
	brl	L210
L211:
	clc
	lda	#$ffff
	adc	<L208+np_1
	sta	<R0
	lda	#$ffff
	adc	<L208+np_1+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$5b
	rep	#$20
	longa	on
	beq	L212
	brl	L10124
L212:
L210:
	sec
	lda	<L208+np_1
	sbc	<L208+base_1
	sta	<R0
	lda	<L208+np_1+2
	sbc	<L208+base_1+2
	sta	<R0+2
	pei	<R0
	pei	<L208+base_1+2
	pei	<L208+base_1
	jsl	~~tocstring
	sta	<R1
	stx	<R1+2
	phx
	pha
	pea	#<$e
	pea	#8
	jsl	~~error
	brl	L10125
L10124:
	sec
	lda	<L208+np_1
	sbc	<L208+base_1
	sta	<R0
	lda	<L208+np_1+2
	sbc	<L208+base_1+2
	sta	<R0+2
	pei	<R0
	pei	<L208+base_1+2
	pei	<L208+base_1
	jsl	~~tocstring
	sta	<R1
	stx	<R1+2
	phx
	pha
	pea	#<$d
	pea	#8
	jsl	~~error
L10125:
L10123:
	ldy	#$4
	lda	[<L208+vp_1],Y
	sta	<L208+vartype_1
	stz	<R0
	lda	<L208+vartype_1
	and	#<$8
	bne	L214
	brl	L213
L214:
	inc	<R0
L213:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L208+isarray_1
	rep	#$20
	longa	on
	lda	<L208+isarray_1
	and	#$ff
	bne	L215
	brl	L10126
L215:
	ldy	#$10
	lda	[<L208+vp_1],Y
	ldy	#$12
	ora	[<L208+vp_1],Y
	beq	L216
	brl	L10126
L216:
	ldy	#$8
	lda	[<L208+vp_1],Y
	pha
	ldy	#$6
	lda	[<L208+vp_1],Y
	pha
	pea	#<$1f
	pea	#8
	jsl	~~error
L10126:
	clc
	lda	#$5
	adc	|~~basicvars+62
	sta	<L208+np_1
	lda	#$0
	adc	|~~basicvars+62+2
	sta	<L208+np_1+2
	lda	<L208+isarray_1
	and	#$ff
	beq	L217
	brl	L10127
L217:
	sep	#$20
	longa	off
	lda	[<L208+np_1]
	cmp	#<$3f
	rep	#$20
	longa	on
	bne	L219
	brl	L218
L219:
	sep	#$20
	longa	off
	lda	[<L208+np_1]
	cmp	#<$21
	rep	#$20
	longa	on
	beq	L220
	brl	L10127
L220:
L218:
	lda	<L208+vartype_1
	brl	L10128
L10130:
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
	adc	<L208+vp_1
	sta	<R0
	lda	#$0
	adc	<L208+vp_1+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~set_address
	brl	L10129
L10131:
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
	adc	<L208+vp_1
	sta	<R0
	lda	#$0
	adc	<L208+vp_1+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~set_address
	brl	L10129
L10132:
	pea	#<$43
	pea	#4
	jsl	~~error
	brl	L10129
L10128:
	xref	~~~swt
	jsl	~~~swt
	dw	2
	dw	2
	dw	L10130-1
	dw	3
	dw	L10131-1
	dw	L10132-1
L10129:
	jsl	~~do_indrefvar
	brl	L10133
L10127:
	lda	<L208+vartype_1
	cmp	#<$2
	beq	L221
	brl	L10134
L221:
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
	adc	<L208+vp_1
	sta	<R0
	lda	#$0
	adc	<L208+vp_1+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~set_address
	jsl	~~do_intvar
	brl	L10135
L10134:
	lda	<L208+vartype_1
	cmp	#<$3
	beq	L222
	brl	L10136
L222:
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
	adc	<L208+vp_1
	sta	<R0
	lda	#$0
	adc	<L208+vp_1+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~set_address
	jsl	~~do_floatvar
	brl	L10137
L10136:
	lda	<L208+vartype_1
	cmp	#<$4
	beq	L223
	brl	L10138
L223:
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
	adc	<L208+vp_1
	sta	<R0
	lda	#$0
	adc	<L208+vp_1+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~set_address
	jsl	~~do_stringvar
	brl	L10139
L10138:
	sep	#$20
	longa	off
	lda	[<L208+np_1]
	cmp	#<$29
	rep	#$20
	longa	on
	beq	L224
	brl	L10140
L224:
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
	jsl	~~do_arrayvar
	brl	L10141
L10140:
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
	pei	<L208+vp_1+2
	pei	<L208+vp_1
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~set_address
	jsl	~~do_arrayref
L10141:
L10139:
L10137:
L10135:
L10133:
L225:
	pld
	tsc
	clc
	adc	#L207
	tcs
	rtl
L207	equ	23
L208	equ	9
	ends
	efunc
	code
	func
~~do_stringcon:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L226
	tcs
	phd
	tcd
descriptor_1	set	0
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~get_srcaddr
	sta	<L227+descriptor_1+2
	stx	<L227+descriptor_1+4
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
	sta	<L227+descriptor_1
	clc
	lda	#$5
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L228
	inc	|~~basicvars+62+2
L228:
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
	adc	#<L227+descriptor_1
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
L229:
	pld
	tsc
	clc
	adc	#L226
	tcs
	rtl
L226	equ	18
L227	equ	13
	ends
	efunc
	code
	func
~~do_qstringcon:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L230
	tcs
	phd
	tcd
length_1	set	0
srce_1	set	2
dest_1	set	4
string_1	set	6
cp_1	set	10
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~get_srcaddr
	sta	<L231+string_1
	stx	<L231+string_1+2
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
	sta	<L231+length_1
	clc
	lda	#$5
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L232
	inc	|~~basicvars+62+2
L232:
	pei	<L231+length_1
	jsl	~~alloc_string
	sta	<L231+cp_1
	stx	<L231+cp_1+2
	sec
	lda	#$0
	sbc	<L231+length_1
	bvs	L233
	eor	#$8000
L233:
	bpl	L234
	brl	L10142
L234:
	stz	<L231+srce_1
	stz	<L231+dest_1
	brl	L10146
L10145:
	sep	#$20
	longa	off
	ldy	<L231+srce_1
	lda	[<L231+string_1],Y
	ldy	<L231+dest_1
	sta	[<L231+cp_1],Y
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	ldy	<L231+srce_1
	lda	[<L231+string_1],Y
	cmp	#<$22
	rep	#$20
	longa	on
	beq	L235
	brl	L10147
L235:
	inc	<L231+srce_1
L10147:
	inc	<L231+srce_1
L10143:
	inc	<L231+dest_1
L10146:
	sec
	lda	<L231+dest_1
	sbc	<L231+length_1
	bvs	L236
	eor	#$8000
L236:
	bmi	L237
	brl	L10145
L237:
L10144:
L10142:
	pei	<L231+cp_1+2
	pei	<L231+cp_1
	pei	<L231+length_1
	jsl	~~push_strtemp
L238:
	pld
	tsc
	clc
	adc	#L230
	tcs
	rtl
L230	equ	26
L231	equ	13
	ends
	efunc
	code
	func
~~do_brackets:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L239
	tcs
	phd
	tcd
	inc	|~~basicvars+62
	bne	L241
	inc	|~~basicvars+62+2
L241:
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
	bne	L242
	brl	L10148
L242:
	pea	#<$29
	pea	#4
	jsl	~~error
L10148:
	inc	|~~basicvars+62
	bne	L243
	inc	|~~basicvars+62+2
L243:
L244:
	pld
	tsc
	clc
	adc	#L239
	tcs
	rtl
L239	equ	4
L240	equ	5
	ends
	efunc
	code
	func
~~do_unaryplus:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L245
	tcs
	phd
	tcd
	inc	|~~basicvars+62
	bne	L247
	inc	|~~basicvars+62+2
L247:
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
	stz	<R0
	lda	|~~basicvars+42
	sta	<R1
	lda	|~~basicvars+42+2
	sta	<R1+2
	lda	[<R1]
	beq	L249
	brl	L248
L249:
	inc	<R0
L248:
	lda	<R0
	cmp	#<$2
	beq	L250
	brl	L10149
L250:
	stz	<R0
	lda	|~~basicvars+42
	sta	<R1
	lda	|~~basicvars+42+2
	sta	<R1+2
	lda	[<R1]
	beq	L252
	brl	L251
L252:
	inc	<R0
L251:
	lda	<R0
	cmp	#<$3
	beq	L253
	brl	L10149
L253:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10149:
L254:
	pld
	tsc
	clc
	adc	#L245
	tcs
	rtl
L245	equ	8
L246	equ	9
	ends
	efunc
	code
	func
~~do_unaryminus:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L255
	tcs
	phd
	tcd
	inc	|~~basicvars+62
	bne	L257
	inc	|~~basicvars+62+2
L257:
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
	beq	L258
	brl	L10150
L258:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	|~~basicvars+42
	sta	<R1
	lda	|~~basicvars+42+2
	sta	<R1+2
	sec
	lda	#$0
	ldy	#$2
	sbc	[<R1],Y
	ldy	#$2
	sta	[<R0],Y
	brl	L10151
L10150:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$3
	beq	L259
	brl	L10152
L259:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
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
	xref	~~~fneg
	jsl	~~~fneg
	pla
	ldy	#$2
	sta	[<R0],Y
	pla
	ldy	#$4
	sta	[<R0],Y
	brl	L10153
L10152:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10153:
L10151:
L260:
	pld
	tsc
	clc
	adc	#L255
	tcs
	rtl
L255	equ	8
L256	equ	9
	ends
	efunc
	code
	func
~~do_getbyte:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L261
	tcs
	phd
	tcd
offset_1	set	0
	inc	|~~basicvars+62
	bne	L263
	inc	|~~basicvars+62+2
L263:
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
	beq	L264
	brl	L10154
L264:
	jsl	~~pop_int
	sta	<L262+offset_1
	brl	L10155
L10154:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$3
	beq	L265
	brl	L10156
L265:
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
	sta	<L262+offset_1
	brl	L10157
L10156:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10157:
L10155:
	pea	#<$1
	pei	<L262+offset_1
	jsl	~~check_read
	lda	|~~basicvars+6
	sta	<R0
	lda	|~~basicvars+6+2
	sta	<R0+2
	ldy	<L262+offset_1
	lda	[<R0],Y
	and	#$ff
	pha
	jsl	~~push_int
L266:
	pld
	tsc
	clc
	adc	#L261
	tcs
	rtl
L261	equ	10
L262	equ	9
	ends
	efunc
	code
	func
~~do_getword:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L267
	tcs
	phd
	tcd
offset_1	set	0
	inc	|~~basicvars+62
	bne	L269
	inc	|~~basicvars+62+2
L269:
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
	beq	L270
	brl	L10158
L270:
	jsl	~~pop_int
	sta	<L268+offset_1
	brl	L10159
L10158:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$3
	beq	L271
	brl	L10160
L271:
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
	sta	<L268+offset_1
	brl	L10161
L10160:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10161:
L10159:
	pei	<L268+offset_1
	jsl	~~get_integer
	pha
	jsl	~~push_int
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
	func
~~do_getstring:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L273
	tcs
	phd
	tcd
offset_1	set	0
len_1	set	2
	inc	|~~basicvars+62
	bne	L275
	inc	|~~basicvars+62+2
L275:
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
	beq	L276
	brl	L10162
L276:
	jsl	~~pop_int
	sta	<L274+offset_1
	brl	L10163
L10162:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$3
	beq	L277
	brl	L10164
L277:
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
	sta	<L274+offset_1
	brl	L10165
L10164:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10165:
L10163:
	pei	<L274+offset_1
	jsl	~~get_stringlen
	sta	<L274+len_1
	pei	<L274+len_1
	pei	<L274+offset_1
	jsl	~~check_read
	ldy	#$0
	lda	<L274+offset_1
	bpl	L278
	dey
L278:
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
	pei	<L274+len_1
	jsl	~~push_dolstring
L279:
	pld
	tsc
	clc
	adc	#L273
	tcs
	rtl
L273	equ	12
L274	equ	9
	ends
	efunc
	code
	func
~~do_getfloat:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L280
	tcs
	phd
	tcd
offset_1	set	0
	inc	|~~basicvars+62
	bne	L282
	inc	|~~basicvars+62+2
L282:
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
	beq	L283
	brl	L10166
L283:
	jsl	~~pop_int
	sta	<L281+offset_1
	brl	L10167
L10166:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$3
	beq	L284
	brl	L10168
L284:
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
	sta	<L281+offset_1
	brl	L10169
L10168:
	pea	#<$3f
	pea	#4
	jsl	~~error
L10169:
L10167:
	phy
	phy
	pei	<L281+offset_1
	jsl	~~get_float
	jsl	~~push_float
L285:
	pld
	tsc
	clc
	adc	#L280
	tcs
	rtl
L280	equ	10
L281	equ	9
	ends
	efunc
	code
	func
~~do_function:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L286
	tcs
	phd
	tcd
tp_1	set	0
dp_1	set	4
vp_1	set	8
	lda	|~~basicvars+489
	and	#$ff
	bne	L288
	brl	L10170
L288:
	pea	#<$8
	pea	#4
	jsl	~~error
L10170:
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
	bpl	L289
	dey
L289:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars
	adc	<R0
	sta	<L287+vp_1
	lda	|~~basicvars+2
	adc	<R0+2
	sta	<L287+vp_1+2
	ldy	#$10
	lda	[<L287+vp_1],Y
	sta	<L287+dp_1
	ldy	#$12
	lda	[<L287+vp_1],Y
	sta	<L287+dp_1+2
	clc
	lda	#$5
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L290
	inc	|~~basicvars+62+2
L290:
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
	beq	L291
	brl	L10171
L291:
	ldy	#$8
	lda	[<L287+vp_1],Y
	pha
	ldy	#$6
	lda	[<L287+vp_1],Y
	pha
	pei	<L287+dp_1+2
	pei	<L287+dp_1
	jsl	~~push_parameters
L10171:
	ldy	#$4
	lda	[<L287+dp_1],Y
	pha
	ldy	#$8
	lda	[<L287+vp_1],Y
	pha
	ldy	#$6
	lda	[<L287+vp_1],Y
	pha
	jsl	~~push_fn
	lda	|~~basicvars+62
	sta	<L287+tp_1
	lda	|~~basicvars+62+2
	sta	<L287+tp_1+2
	jsl	~~make_opstack
	sta	|~~basicvars+10
	stx	|~~basicvars+10+2
	clc
	lda	#$28
	adc	|~~basicvars+10
	sta	|~~basicvars+14
	lda	#$0
	adc	|~~basicvars+10+2
	sta	|~~basicvars+14+2
	jsl	~~make_restart
	sta	|~~basicvars+395
	stx	|~~basicvars+395+2
	lda	|~~basicvars+425
	bit	#$1
	bne	L292
	brl	L10172
L292:
	lda	|~~basicvars+425
	bit	#$4
	bne	L293
	brl	L10173
L293:
	pea	#<$1
	ldy	#$8
	lda	[<L287+vp_1],Y
	pha
	ldy	#$6
	lda	[<L287+vp_1],Y
	pha
	jsl	~~trace_proc
L10173:
	lda	|~~basicvars+425
	bit	#$10
	bne	L294
	brl	L10174
L294:
	ldy	#$2
	lda	[<L287+dp_1],Y
	pha
	lda	[<L287+dp_1]
	pha
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~trace_branch
L10174:
L10172:
	pea	#<$0
	lda	|~~basicvars+395+2
	pha
	lda	|~~basicvars+395
	pha
	jsl	~~__sigsetjmp
	tax
	beq	L295
	brl	L10175
L295:
	ldy	#$2
	lda	[<L287+dp_1],Y
	pha
	lda	[<L287+dp_1]
	pha
	jsl	~~exec_fnstatements
	brl	L10176
L10175:
	jsl	~~reset_opstack
	lda	|~~basicvars+233+2
	pha
	lda	|~~basicvars+233
	pha
	jsl	~~exec_fnstatements
L10176:
	lda	<L287+tp_1
	sta	|~~basicvars+62
	lda	<L287+tp_1+2
	sta	|~~basicvars+62+2
L296:
	pld
	tsc
	clc
	adc	#L286
	tcs
	rtl
L286	equ	24
L287	equ	13
	ends
	efunc
	code
	func
~~do_xfunction:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L297
	tcs
	phd
	tcd
base_1	set	0
tp_1	set	4
dp_1	set	8
vp_1	set	12
gotparms_1	set	16
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~get_srcaddr
	sta	<L298+base_1
	stx	<L298+base_1+2
	sep	#$20
	longa	off
	lda	[<L298+base_1]
	cmp	#<$ad
	rep	#$20
	longa	on
	bne	L299
	brl	L10177
L299:
	pea	#<$54
	pea	#4
	jsl	~~error
L10177:
	pei	<L298+base_1+2
	pei	<L298+base_1
	jsl	~~skip_name
	sta	<L298+tp_1
	stx	<L298+tp_1+2
	stz	<R0
	clc
	lda	#$ffff
	adc	<L298+tp_1
	sta	<R1
	lda	#$ffff
	adc	<L298+tp_1+2
	sta	<R1+2
	sep	#$20
	longa	off
	lda	[<R1]
	cmp	#<$28
	rep	#$20
	longa	on
	beq	L301
	brl	L300
L301:
	inc	<R0
L300:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L298+gotparms_1
	rep	#$20
	longa	on
	lda	<L298+gotparms_1
	and	#$ff
	bne	L302
	brl	L10178
L302:
	lda	<L298+tp_1
	bne	L303
	dec	<L298+tp_1+2
L303:
	dec	<L298+tp_1
L10178:
	sec
	lda	<L298+tp_1
	sbc	<L298+base_1
	sta	<R0
	lda	<L298+tp_1+2
	sbc	<L298+base_1+2
	sta	<R0+2
	pei	<R0
	pei	<L298+base_1+2
	pei	<L298+base_1
	jsl	~~find_fnproc
	sta	<L298+vp_1
	stx	<L298+vp_1+2
	ldy	#$10
	lda	[<L298+vp_1],Y
	sta	<L298+dp_1
	ldy	#$12
	lda	[<L298+vp_1],Y
	sta	<L298+dp_1+2
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
	pei	<L298+vp_1+2
	pei	<L298+vp_1
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~set_address
	lda	<L298+gotparms_1
	and	#$ff
	bne	L304
	brl	L10179
L304:
	ldy	#$7
	lda	[<L298+dp_1],Y
	ldy	#$9
	ora	[<L298+dp_1],Y
	beq	L305
	brl	L10180
L305:
	ldy	#$8
	lda	[<L298+vp_1],Y
	pha
	ldy	#$6
	lda	[<L298+vp_1],Y
	pha
	pea	#<$11
	pea	#8
	jsl	~~error
L10180:
	brl	L10181
L10179:
	ldy	#$7
	lda	[<L298+dp_1],Y
	ldy	#$9
	ora	[<L298+dp_1],Y
	bne	L306
	brl	L10182
L306:
	ldy	#$8
	lda	[<L298+vp_1],Y
	pha
	ldy	#$6
	lda	[<L298+vp_1],Y
	pha
	pea	#<$12
	pea	#8
	jsl	~~error
L10182:
L10181:
	jsl	~~do_function
L307:
	pld
	tsc
	clc
	adc	#L297
	tcs
	rtl
L297	equ	25
L298	equ	9
	ends
	efunc
	code
	func
~~want_number:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L308
	tcs
	phd
	tcd
baditem_1	set	0
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L309+baditem_1
	lda	<L309+baditem_1
	cmp	#<$4
	bne	L311
	brl	L310
L311:
	lda	<L309+baditem_1
	cmp	#<$5
	beq	L312
	brl	L10183
L312:
L310:
	pea	#<$3f
	pea	#4
	jsl	~~error
	brl	L10184
L10183:
	sec
	lda	#$0
	sbc	<L309+baditem_1
	bvs	L313
	eor	#$8000
L313:
	bpl	L314
	brl	L10185
L314:
	sec
	lda	#$b
	sbc	<L309+baditem_1
	bvs	L315
	eor	#$8000
L315:
	bmi	L316
	brl	L10185
L316:
	pea	#<$50
	pea	#4
	jsl	~~error
	brl	L10186
L10185:
	lda	|~~basicvars+10+2
	pha
	lda	|~~basicvars+10
	pha
	lda	|~~basicvars+46+2
	pha
	lda	|~~basicvars+46
	pha
	lda	|~~basicvars+42+2
	pha
	lda	|~~basicvars+42
	pha
	pei	<L309+baditem_1
	pea	#^L197
	pea	#<L197
	lda	|~~stderr+2
	pha
	lda	|~~stderr
	pha
	pea	#24
	jsl	~~fprintf
	pea	#^L197+43
	pea	#<L197+43
	pea	#<$461
	pea	#<$82
	pea	#10
	jsl	~~error
L10186:
L10184:
L317:
	pld
	tsc
	clc
	adc	#L308
	tcs
	rtl
L308	equ	6
L309	equ	5
	ends
	efunc
	data
L197:
	db	$42,$61,$64,$69,$74,$65,$6D,$20,$3D,$20,$25,$64,$2C,$20,$73
	db	$70,$20,$3D,$20,$25,$70,$2C,$20,$73,$61,$66,$65,$3D,$25,$70
	db	$2C,$20,$6F,$70,$73,$74,$6F,$70,$3D,$25,$70,$0A,$00,$65,$76
	db	$61,$6C,$75,$61,$74,$65,$00
	ends
	code
	func
~~want_string:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L319
	tcs
	phd
	tcd
baditem_1	set	0
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L320+baditem_1
	lda	<L320+baditem_1
	cmp	#<$2
	bne	L322
	brl	L321
L322:
	lda	<L320+baditem_1
	cmp	#<$3
	beq	L323
	brl	L10187
L323:
L321:
	pea	#<$40
	pea	#4
	jsl	~~error
	brl	L10188
L10187:
	sec
	lda	#$0
	sbc	<L320+baditem_1
	bvs	L324
	eor	#$8000
L324:
	bpl	L325
	brl	L10189
L325:
	sec
	lda	#$b
	sbc	<L320+baditem_1
	bvs	L326
	eor	#$8000
L326:
	bmi	L327
	brl	L10189
L327:
	pea	#<$50
	pea	#4
	jsl	~~error
	brl	L10190
L10189:
	pea	#^L318
	pea	#<L318
	pea	#<$471
	pea	#<$82
	pea	#10
	jsl	~~error
L10190:
L10188:
L328:
	pld
	tsc
	clc
	adc	#L319
	tcs
	rtl
L319	equ	6
L320	equ	5
	ends
	efunc
	data
L318:
	db	$65,$76,$61,$6C,$75,$61,$74,$65,$00
	ends
	code
	func
~~want_array:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L330
	tcs
	phd
	tcd
	pea	#<$46
	pea	#4
	jsl	~~error
L332:
	pld
	tsc
	clc
	adc	#L330
	tcs
	rtl
L330	equ	0
L331	equ	1
	ends
	efunc
	code
	func
~~eval_badcall:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L333
	tcs
	phd
	tcd
	pea	#^L329
	pea	#<L329
	pea	#<$481
	pea	#<$82
	pea	#10
	jsl	~~error
L335:
	pld
	tsc
	clc
	adc	#L333
	tcs
	rtl
L333	equ	0
L334	equ	1
	ends
	efunc
	data
L329:
	db	$65,$76,$61,$6C,$75,$61,$74,$65,$00
	ends
	code
	func
~~make_array:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L337
	tcs
	phd
	tcd
arraytype_0	set	4
original_0	set	6
result_1	set	0
base_1	set	28
	pei	<L337+original_0+2
	pei	<L337+original_0
	clc
	tdc
	adc	#<L338+result_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$1c
	xref	~~~fmov
	jsl	~~~fmov
	lda	<L337+arraytype_0
	brl	L10191
L10193:
	ldy	#$0
	phy
	ldy	#$2
	lda	[<L337+original_0],Y
	ply
	rol	A
	ror	A
	bpl	L339
	dey
L339:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	pei	<R0
	jsl	~~alloc_stackmem
	sta	<L338+base_1
	stx	<L338+base_1+2
	lda	<L338+base_1
	sta	<L338+result_1+4
	lda	<L338+base_1+2
	sta	<L338+result_1+6
	brl	L10192
L10194:
	ldy	#$0
	phy
	ldy	#$2
	lda	[<L337+original_0],Y
	ply
	rol	A
	ror	A
	bpl	L340
	dey
L340:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$2
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	pei	<R0
	jsl	~~alloc_stackmem
	sta	<L338+base_1
	stx	<L338+base_1+2
	lda	<L338+base_1
	sta	<L338+result_1+4
	lda	<L338+base_1+2
	sta	<L338+result_1+6
	brl	L10192
L10195:
	ldy	#$0
	phy
	ldy	#$2
	lda	[<L337+original_0],Y
	ply
	rol	A
	ror	A
	bpl	L341
	dey
L341:
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
	pei	<R0
	jsl	~~alloc_stackmem
	sta	<L338+base_1
	stx	<L338+base_1+2
	lda	<L338+base_1
	sta	<L338+result_1+4
	lda	<L338+base_1+2
	sta	<L338+result_1+6
	brl	L10192
L10196:
	pea	#^L336
	pea	#<L336
	pea	#<$49d
	pea	#<$82
	pea	#10
	jsl	~~error
	brl	L10192
L10191:
	xref	~~~swt
	jsl	~~~swt
	dw	3
	dw	2
	dw	L10193-1
	dw	3
	dw	L10194-1
	dw	4
	dw	L10195-1
	dw	L10196-1
L10192:
	lda	<L338+base_1
	ora	<L338+base_1+2
	beq	L342
	brl	L10197
L342:
	pea	#<$59
	pea	#4
	jsl	~~error
L10197:
	pei	<L337+arraytype_0
	pea	#0
	clc
	tdc
	adc	#<L338+result_1
	pha
	jsl	~~push_arraytemp
	ldx	<L338+base_1+2
	lda	<L338+base_1
L343:
	tay
	lda	<L337+2
	sta	<L337+2+6
	lda	<L337+1
	sta	<L337+1+6
	pld
	tsc
	clc
	adc	#L337+6
	tcs
	tya
	rtl
L337	equ	40
L338	equ	9
	ends
	efunc
	data
L336:
	db	$65,$76,$61,$6C,$75,$61,$74,$65,$00
	ends
	code
	func
~~eval_ivplus:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L345
	tcs
	phd
	tcd
lhitem_1	set	0
rhint_1	set	2
	jsl	~~pop_int
	sta	<L346+rhint_1
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L346+lhitem_1
	lda	<L346+lhitem_1
	cmp	#<$2
	beq	L347
	brl	L10198
L347:
	clc
	lda	#$2
	adc	|~~basicvars+42
	sta	<R0
	lda	#$0
	adc	|~~basicvars+42+2
	sta	<R0+2
	clc
	lda	[<R0]
	adc	<L346+rhint_1
	sta	[<R0]
	brl	L10199
L10198:
	lda	<L346+lhitem_1
	cmp	#<$3
	beq	L348
	brl	L10200
L348:
	clc
	lda	#$2
	adc	|~~basicvars+42
	sta	<R0
	lda	#$0
	adc	|~~basicvars+42+2
	sta	<R0+2
	ldy	#$2
	lda	[<R0],Y
	pha
	lda	[<R0]
	pha
	ldy	#$0
	lda	<L346+rhint_1
	bpl	L349
	dey
L349:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~fadc
	jsl	~~~fadc
	pla
	sta	[<R0]
	pla
	ldy	#$2
	sta	[<R0],Y
	brl	L10201
L10200:
	lda	<L346+lhitem_1
	cmp	#<$6
	bne	L351
	brl	L350
L351:
	lda	<L346+lhitem_1
	cmp	#<$8
	beq	L352
	brl	L10202
L352:
L350:
lharray_2	set	4
n_2	set	8
count_2	set	10
	jsl	~~pop_array
	sta	<L346+lharray_2
	stx	<L346+lharray_2+2
	ldy	#$2
	lda	[<L346+lharray_2],Y
	sta	<L346+count_2
	lda	<L346+lhitem_1
	cmp	#<$6
	beq	L353
	brl	L10203
L353:
srce_3	set	12
base_3	set	16
	pei	<L346+lharray_2+2
	pei	<L346+lharray_2
	pea	#<$2
	jsl	~~make_array
	sta	<L346+base_3
	stx	<L346+base_3+2
	ldy	#$4
	lda	[<L346+lharray_2],Y
	sta	<L346+srce_3
	ldy	#$6
	lda	[<L346+lharray_2],Y
	sta	<L346+srce_3+2
	stz	<L346+n_2
	brl	L10207
L10206:
	ldy	#$0
	lda	<L346+n_2
	bpl	L354
	dey
L354:
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
	lda	<L346+base_3
	adc	<R0
	sta	<R2
	lda	<L346+base_3+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L346+n_2
	bpl	L355
	dey
L355:
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
	lda	<L346+srce_3
	adc	<R0
	sta	<17
	lda	<L346+srce_3+2
	adc	<R0+2
	sta	<17+2
	clc
	lda	[<17]
	adc	<L346+rhint_1
	sta	[<R2]
L10204:
	inc	<L346+n_2
L10207:
	sec
	lda	<L346+n_2
	sbc	<L346+count_2
	bvs	L356
	eor	#$8000
L356:
	bmi	L357
	brl	L10206
L357:
L10205:
	brl	L10208
L10203:
srce_4	set	12
base_4	set	16
	pei	<L346+lharray_2+2
	pei	<L346+lharray_2
	pea	#<$3
	jsl	~~make_array
	sta	<L346+base_4
	stx	<L346+base_4+2
	ldy	#$0
	lda	<L346+rhint_1
	bpl	L358
	dey
L358:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	pla
	sta	|~~floatvalue
	pla
	sta	|~~floatvalue+2
	ldy	#$4
	lda	[<L346+lharray_2],Y
	sta	<L346+srce_4
	ldy	#$6
	lda	[<L346+lharray_2],Y
	sta	<L346+srce_4+2
	stz	<L346+n_2
	brl	L10212
L10211:
	ldy	#$0
	lda	<L346+n_2
	bpl	L359
	dey
L359:
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
	lda	<L346+base_4
	adc	<R0
	sta	<R2
	lda	<L346+base_4+2
	adc	<R0+2
	sta	<R2+2
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	ldy	#$0
	lda	<L346+n_2
	bpl	L360
	dey
L360:
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
	lda	<L346+srce_4
	adc	<R0
	sta	<17
	lda	<L346+srce_4+2
	adc	<R0+2
	sta	<17+2
	ldy	#$2
	lda	[<17],Y
	pha
	lda	[<17]
	pha
	xref	~~~fadc
	jsl	~~~fadc
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10209:
	inc	<L346+n_2
L10212:
	sec
	lda	<L346+n_2
	sbc	<L346+count_2
	bvs	L361
	eor	#$8000
L361:
	bmi	L362
	brl	L10211
L362:
L10210:
L10208:
	brl	L10213
L10202:
	lda	<L346+lhitem_1
	cmp	#<$9
	beq	L363
	brl	L10214
L363:
lharray_5	set	4
base_5	set	32
n_5	set	36
count_5	set	38
	jsl	~~pop_arraytemp
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L346+lharray_5
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$1c
	xref	~~~fmov
	jsl	~~~fmov
	lda	<L346+lharray_5+4
	sta	<L346+base_5
	lda	<L346+lharray_5+6
	sta	<L346+base_5+2
	lda	<L346+lharray_5+2
	sta	<L346+count_5
	ldy	#$0
	lda	<L346+rhint_1
	bpl	L364
	dey
L364:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	pla
	sta	|~~floatvalue
	pla
	sta	|~~floatvalue+2
	stz	<L346+n_5
	brl	L10218
L10217:
	ldy	#$0
	lda	<L346+n_5
	bpl	L365
	dey
L365:
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
	lda	<L346+base_5
	adc	<R0
	sta	<R2
	lda	<L346+base_5+2
	adc	<R0+2
	sta	<R2+2
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
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
L10215:
	inc	<L346+n_5
L10218:
	sec
	lda	<L346+n_5
	sbc	<L346+count_5
	bvs	L366
	eor	#$8000
L366:
	bmi	L367
	brl	L10217
L367:
L10216:
	pea	#<$3
	pea	#0
	clc
	tdc
	adc	#<L346+lharray_5
	pha
	jsl	~~push_arraytemp
	brl	L10219
L10214:
	jsl	~~want_number
L10219:
L10213:
L10201:
L10199:
L368:
	pld
	tsc
	clc
	adc	#L345
	tcs
	rtl
L345	equ	60
L346	equ	21
	ends
	efunc
	code
	func
~~eval_fvplus:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L369
	tcs
	phd
	tcd
lhitem_1	set	0
	phy
	phy
	jsl	~~pop_float
	pla
	sta	|~~floatvalue
	pla
	sta	|~~floatvalue+2
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L370+lhitem_1
	lda	<L370+lhitem_1
	cmp	#<$2
	beq	L371
	brl	L10220
L371:
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L372
	dey
L372:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~fadc
	jsl	~~~fadc
	pla
	sta	|~~floatvalue
	pla
	sta	|~~floatvalue+2
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
	lda	|~~floatvalue
	ldy	#$2
	sta	[<R0],Y
	lda	|~~floatvalue+2
	ldy	#$4
	sta	[<R0],Y
	brl	L10221
L10220:
	lda	<L370+lhitem_1
	cmp	#<$3
	beq	L373
	brl	L10222
L373:
	clc
	lda	#$2
	adc	|~~basicvars+42
	sta	<R0
	lda	#$0
	adc	|~~basicvars+42+2
	sta	<R0+2
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	ldy	#$2
	lda	[<R0],Y
	pha
	lda	[<R0]
	pha
	xref	~~~fadc
	jsl	~~~fadc
	pla
	sta	[<R0]
	pla
	ldy	#$2
	sta	[<R0],Y
	brl	L10223
L10222:
	lda	<L370+lhitem_1
	cmp	#<$6
	bne	L375
	brl	L374
L375:
	lda	<L370+lhitem_1
	cmp	#<$8
	beq	L376
	brl	L10224
L376:
L374:
lharray_2	set	2
base_2	set	6
n_2	set	10
count_2	set	12
	jsl	~~pop_array
	sta	<L370+lharray_2
	stx	<L370+lharray_2+2
	ldy	#$2
	lda	[<L370+lharray_2],Y
	sta	<L370+count_2
	pei	<L370+lharray_2+2
	pei	<L370+lharray_2
	pea	#<$3
	jsl	~~make_array
	sta	<L370+base_2
	stx	<L370+base_2+2
	lda	<L370+lhitem_1
	cmp	#<$6
	beq	L377
	brl	L10225
L377:
srce_3	set	14
	ldy	#$4
	lda	[<L370+lharray_2],Y
	sta	<L370+srce_3
	ldy	#$6
	lda	[<L370+lharray_2],Y
	sta	<L370+srce_3+2
	stz	<L370+n_2
	brl	L10229
L10228:
	ldy	#$0
	lda	<L370+n_2
	bpl	L378
	dey
L378:
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
	lda	<L370+base_2
	adc	<R0
	sta	<R2
	lda	<L370+base_2+2
	adc	<R0+2
	sta	<R2+2
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	ldy	#$0
	lda	<L370+n_2
	bpl	L379
	dey
L379:
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
	lda	<L370+srce_3
	adc	<R0
	sta	<17
	lda	<L370+srce_3+2
	adc	<R0+2
	sta	<17+2
	ldy	#$0
	lda	[<17]
	bpl	L380
	dey
L380:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~fadc
	jsl	~~~fadc
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10226:
	inc	<L370+n_2
L10229:
	sec
	lda	<L370+n_2
	sbc	<L370+count_2
	bvs	L381
	eor	#$8000
L381:
	bmi	L382
	brl	L10228
L382:
L10227:
	brl	L10230
L10225:
srce_4	set	14
	ldy	#$4
	lda	[<L370+lharray_2],Y
	sta	<L370+srce_4
	ldy	#$6
	lda	[<L370+lharray_2],Y
	sta	<L370+srce_4+2
	stz	<L370+n_2
	brl	L10234
L10233:
	ldy	#$0
	lda	<L370+n_2
	bpl	L383
	dey
L383:
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
	lda	<L370+base_2
	adc	<R0
	sta	<R2
	lda	<L370+base_2+2
	adc	<R0+2
	sta	<R2+2
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	ldy	#$0
	lda	<L370+n_2
	bpl	L384
	dey
L384:
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
	lda	<L370+srce_4
	adc	<R0
	sta	<17
	lda	<L370+srce_4+2
	adc	<R0+2
	sta	<17+2
	ldy	#$2
	lda	[<17],Y
	pha
	lda	[<17]
	pha
	xref	~~~fadc
	jsl	~~~fadc
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10231:
	inc	<L370+n_2
L10234:
	sec
	lda	<L370+n_2
	sbc	<L370+count_2
	bvs	L385
	eor	#$8000
L385:
	bmi	L386
	brl	L10233
L386:
L10232:
L10230:
	brl	L10235
L10224:
	lda	<L370+lhitem_1
	cmp	#<$9
	beq	L387
	brl	L10236
L387:
lharray_5	set	2
base_5	set	30
n_5	set	34
count_5	set	36
	jsl	~~pop_arraytemp
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L370+lharray_5
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$1c
	xref	~~~fmov
	jsl	~~~fmov
	lda	<L370+lharray_5+4
	sta	<L370+base_5
	lda	<L370+lharray_5+6
	sta	<L370+base_5+2
	lda	<L370+lharray_5+2
	sta	<L370+count_5
	stz	<L370+n_5
	brl	L10240
L10239:
	ldy	#$0
	lda	<L370+n_5
	bpl	L388
	dey
L388:
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
	lda	<L370+base_5
	adc	<R0
	sta	<R2
	lda	<L370+base_5+2
	adc	<R0+2
	sta	<R2+2
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
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
L10237:
	inc	<L370+n_5
L10240:
	sec
	lda	<L370+n_5
	sbc	<L370+count_5
	bvs	L389
	eor	#$8000
L389:
	bmi	L390
	brl	L10239
L390:
L10238:
	pea	#<$3
	pea	#0
	clc
	tdc
	adc	#<L370+lharray_5
	pha
	jsl	~~push_arraytemp
	brl	L10241
L10236:
	jsl	~~want_number
L10241:
L10235:
L10223:
L10221:
L391:
	pld
	tsc
	clc
	adc	#L369
	tcs
	rtl
L369	equ	58
L370	equ	21
	ends
	efunc
	code
	func
~~eval_svplus:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L392
	tcs
	phd
	tcd
lhitem_1	set	0
rhitem_1	set	2
lhstring_1	set	4
rhstring_1	set	10
newlen_1	set	16
cp_1	set	18
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L393+rhitem_1
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L393+rhstring_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L393+lhitem_1
	lda	<L393+lhitem_1
	cmp	#<$4
	bne	L395
	brl	L394
L395:
	lda	<L393+lhitem_1
	cmp	#<$5
	beq	L396
	brl	L10242
L396:
L394:
	lda	<L393+rhstring_1
	beq	L397
	brl	L10243
L397:
L398:
	pld
	tsc
	clc
	adc	#L392
	tcs
	rtl
L10243:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L393+lhstring_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	clc
	lda	<L393+lhstring_1
	adc	<L393+rhstring_1
	sta	<L393+newlen_1
	sec
	lda	#$1000
	sbc	<L393+newlen_1
	bvs	L399
	eor	#$8000
L399:
	bpl	L400
	brl	L10244
L400:
	pea	#<$3d
	pea	#4
	jsl	~~error
L10244:
	lda	<L393+lhitem_1
	cmp	#<$5
	beq	L401
	brl	L10245
L401:
	pei	<L393+newlen_1
	pei	<L393+lhstring_1
	pei	<L393+lhstring_1+4
	pei	<L393+lhstring_1+2
	jsl	~~resize_string
	sta	<L393+cp_1
	stx	<L393+cp_1+2
	lda	<L393+cp_1
	sta	<L393+lhstring_1+2
	lda	<L393+cp_1+2
	sta	<L393+lhstring_1+4
	ldy	#$0
	lda	<L393+rhstring_1
	bpl	L402
	dey
L402:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L393+rhstring_1+4
	pei	<L393+rhstring_1+2
	ldy	#$0
	lda	<L393+lhstring_1
	bpl	L403
	dey
L403:
	sta	<R1
	sty	<R1+2
	clc
	lda	<L393+cp_1
	adc	<R1
	sta	<R2
	lda	<L393+cp_1+2
	adc	<R1+2
	sta	<R2+2
	pei	<R2+2
	pei	<R2
	jsl	~~memmove
	brl	L10246
L10245:
	pei	<L393+newlen_1
	jsl	~~alloc_string
	sta	<L393+cp_1
	stx	<L393+cp_1+2
	ldy	#$0
	lda	<L393+lhstring_1
	bpl	L404
	dey
L404:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L393+lhstring_1+4
	pei	<L393+lhstring_1+2
	pei	<L393+cp_1+2
	pei	<L393+cp_1
	jsl	~~memmove
	ldy	#$0
	lda	<L393+rhstring_1
	bpl	L405
	dey
L405:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L393+rhstring_1+4
	pei	<L393+rhstring_1+2
	ldy	#$0
	lda	<L393+lhstring_1
	bpl	L406
	dey
L406:
	sta	<R1
	sty	<R1+2
	clc
	lda	<L393+cp_1
	adc	<R1
	sta	<R2
	lda	<L393+cp_1+2
	adc	<R1+2
	sta	<R2+2
	pei	<R2+2
	pei	<R2
	jsl	~~memmove
L10246:
	lda	<L393+rhitem_1
	cmp	#<$5
	beq	L407
	brl	L10247
L407:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L393+rhstring_1
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
L10247:
	pei	<L393+cp_1+2
	pei	<L393+cp_1
	pei	<L393+newlen_1
	jsl	~~push_strtemp
	brl	L10248
L10242:
	lda	<L393+lhitem_1
	cmp	#<$a
	beq	L408
	brl	L10249
L408:
lharray_2	set	22
base_2	set	26
srce_2	set	30
n_2	set	34
count_2	set	36
	lda	<L393+rhstring_1
	beq	L409
	brl	L10250
L409:
	brl	L398
L10250:
	jsl	~~pop_array
	sta	<L393+lharray_2
	stx	<L393+lharray_2+2
	ldy	#$2
	lda	[<L393+lharray_2],Y
	sta	<L393+count_2
	ldy	#$4
	lda	[<L393+lharray_2],Y
	sta	<L393+srce_2
	ldy	#$6
	lda	[<L393+lharray_2],Y
	sta	<L393+srce_2+2
	pei	<L393+lharray_2+2
	pei	<L393+lharray_2
	pea	#<$4
	jsl	~~make_array
	sta	<L393+base_2
	stx	<L393+base_2+2
	stz	<L393+n_2
	brl	L10254
L10253:
	ldy	#$0
	lda	<L393+n_2
	bpl	L410
	dey
L410:
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
	lda	<L393+srce_2
	adc	<R0
	sta	<R1
	lda	<L393+srce_2+2
	adc	<R0+2
	sta	<R1+2
	clc
	lda	[<R1]
	adc	<L393+rhstring_1
	sta	<L393+newlen_1
	sec
	lda	#$1000
	sbc	<L393+newlen_1
	bvs	L411
	eor	#$8000
L411:
	bpl	L412
	brl	L10255
L412:
	pea	#<$3d
	pea	#4
	jsl	~~error
L10255:
	pei	<L393+newlen_1
	jsl	~~alloc_string
	sta	<L393+cp_1
	stx	<L393+cp_1+2
	ldy	#$0
	lda	<L393+n_2
	bpl	L413
	dey
L413:
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
	lda	<L393+srce_2
	adc	<R0
	sta	<R1
	lda	<L393+srce_2+2
	adc	<R0+2
	sta	<R1+2
	ldy	#$0
	lda	[<R1]
	bpl	L414
	dey
L414:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	ldy	#$0
	lda	<L393+n_2
	bpl	L415
	dey
L415:
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
	adc	<L393+srce_2
	sta	<R2
	lda	#$0
	adc	<L393+srce_2+2
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
	pei	<L393+cp_1+2
	pei	<L393+cp_1
	jsl	~~memmove
	ldy	#$0
	lda	<L393+rhstring_1
	bpl	L416
	dey
L416:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L393+rhstring_1+4
	pei	<L393+rhstring_1+2
	ldy	#$0
	lda	<L393+n_2
	bpl	L417
	dey
L417:
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
	lda	<L393+srce_2
	adc	<R1
	sta	<R2
	lda	<L393+srce_2+2
	adc	<R1+2
	sta	<R2+2
	ldy	#$0
	lda	[<R2]
	bpl	L418
	dey
L418:
	sta	<R1
	sty	<R1+2
	clc
	lda	<L393+cp_1
	adc	<R1
	sta	<R2
	lda	<L393+cp_1+2
	adc	<R1+2
	sta	<R2+2
	pei	<R2+2
	pei	<R2
	jsl	~~memmove
	ldy	#$0
	lda	<L393+n_2
	bpl	L419
	dey
L419:
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
	adc	<L393+base_2
	sta	<R1
	lda	#$0
	adc	<L393+base_2+2
	sta	<R1+2
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	lda	<R1+2
	adc	<R0+2
	sta	<R2+2
	lda	<L393+cp_1
	sta	[<R2]
	lda	<L393+cp_1+2
	ldy	#$2
	sta	[<R2],Y
	ldy	#$0
	lda	<L393+n_2
	bpl	L420
	dey
L420:
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
	lda	<L393+base_2
	adc	<R0
	sta	<R1
	lda	<L393+base_2+2
	adc	<R0+2
	sta	<R1+2
	lda	<L393+newlen_1
	sta	[<R1]
L10251:
	inc	<L393+n_2
L10254:
	sec
	lda	<L393+n_2
	sbc	<L393+count_2
	bvs	L421
	eor	#$8000
L421:
	bmi	L422
	brl	L10253
L422:
L10252:
	lda	<L393+rhitem_1
	cmp	#<$5
	beq	L423
	brl	L10256
L423:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L393+rhstring_1
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
L10256:
	brl	L10257
L10249:
	jsl	~~want_string
L10257:
L10248:
	brl	L398
L392	equ	54
L393	equ	17
	ends
	efunc
	code
	func
~~eval_iaplus:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L424
	tcs
	phd
	tcd
lhitem_1	set	0
rharray_1	set	2
n_1	set	6
count_1	set	8
rhsrce_1	set	10
	jsl	~~pop_array
	sta	<L425+rharray_1
	stx	<L425+rharray_1+2
	ldy	#$2
	lda	[<L425+rharray_1],Y
	sta	<L425+count_1
	ldy	#$4
	lda	[<L425+rharray_1],Y
	sta	<L425+rhsrce_1
	ldy	#$6
	lda	[<L425+rharray_1],Y
	sta	<L425+rhsrce_1+2
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L425+lhitem_1
	lda	<L425+lhitem_1
	cmp	#<$2
	beq	L426
	brl	L10258
L426:
lhint_2	set	14
base_2	set	16
	jsl	~~pop_int
	sta	<L425+lhint_2
	pei	<L425+rharray_1+2
	pei	<L425+rharray_1
	pea	#<$2
	jsl	~~make_array
	sta	<L425+base_2
	stx	<L425+base_2+2
	stz	<L425+n_1
	brl	L10262
L10261:
	ldy	#$0
	lda	<L425+n_1
	bpl	L427
	dey
L427:
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
	lda	<L425+base_2
	adc	<R0
	sta	<R2
	lda	<L425+base_2+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L425+n_1
	bpl	L428
	dey
L428:
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
	lda	<L425+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L425+rhsrce_1+2
	adc	<R0+2
	sta	<17+2
	clc
	lda	[<17]
	adc	<L425+lhint_2
	sta	[<R2]
L10259:
	inc	<L425+n_1
L10262:
	sec
	lda	<L425+n_1
	sbc	<L425+count_1
	bvs	L429
	eor	#$8000
L429:
	bmi	L430
	brl	L10261
L430:
L10260:
	brl	L10263
L10258:
	lda	<L425+lhitem_1
	cmp	#<$3
	beq	L431
	brl	L10264
L431:
base_3	set	14
	phy
	phy
	jsl	~~pop_float
	pla
	sta	|~~floatvalue
	pla
	sta	|~~floatvalue+2
	pei	<L425+rharray_1+2
	pei	<L425+rharray_1
	pea	#<$3
	jsl	~~make_array
	sta	<L425+base_3
	stx	<L425+base_3+2
	stz	<L425+n_1
	brl	L10268
L10267:
	ldy	#$0
	lda	<L425+n_1
	bpl	L432
	dey
L432:
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
	lda	<L425+base_3
	adc	<R0
	sta	<R2
	lda	<L425+base_3+2
	adc	<R0+2
	sta	<R2+2
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	ldy	#$0
	lda	<L425+n_1
	bpl	L433
	dey
L433:
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
	lda	<L425+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L425+rhsrce_1+2
	adc	<R0+2
	sta	<17+2
	ldy	#$0
	lda	[<17]
	bpl	L434
	dey
L434:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~fadc
	jsl	~~~fadc
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10265:
	inc	<L425+n_1
L10268:
	sec
	lda	<L425+n_1
	sbc	<L425+count_1
	bvs	L435
	eor	#$8000
L435:
	bmi	L436
	brl	L10267
L436:
L10266:
	brl	L10269
L10264:
	lda	<L425+lhitem_1
	cmp	#<$6
	beq	L437
	brl	L10270
L437:
base_4	set	14
lhsrce_4	set	18
lharray_4	set	22
	jsl	~~pop_array
	sta	<L425+lharray_4
	stx	<L425+lharray_4+2
	pei	<L425+rharray_1+2
	pei	<L425+rharray_1
	pei	<L425+lharray_4+2
	pei	<L425+lharray_4
	jsl	~~check_arrays
	and	#$ff
	beq	L438
	brl	L10271
L438:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10271:
	ldy	#$4
	lda	[<L425+lharray_4],Y
	sta	<L425+lhsrce_4
	ldy	#$6
	lda	[<L425+lharray_4],Y
	sta	<L425+lhsrce_4+2
	pei	<L425+rharray_1+2
	pei	<L425+rharray_1
	pea	#<$2
	jsl	~~make_array
	sta	<L425+base_4
	stx	<L425+base_4+2
	stz	<L425+n_1
	brl	L10275
L10274:
	ldy	#$0
	lda	<L425+n_1
	bpl	L439
	dey
L439:
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
	lda	<L425+base_4
	adc	<R0
	sta	<R2
	lda	<L425+base_4+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L425+n_1
	bpl	L440
	dey
L440:
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
	lda	<L425+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L425+rhsrce_1+2
	adc	<R0+2
	sta	<17+2
	ldy	#$0
	lda	<L425+n_1
	bpl	L441
	dey
L441:
	sta	<21
	sty	<21+2
	pei	<21+2
	pei	<21
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	lda	<L425+lhsrce_4
	adc	<R0
	sta	<25
	lda	<L425+lhsrce_4+2
	adc	<R0+2
	sta	<25+2
	clc
	lda	[<25]
	adc	[<17]
	sta	[<R2]
L10272:
	inc	<L425+n_1
L10275:
	sec
	lda	<L425+n_1
	sbc	<L425+count_1
	bvs	L442
	eor	#$8000
L442:
	bmi	L443
	brl	L10274
L443:
L10273:
	brl	L10276
L10270:
	lda	<L425+lhitem_1
	cmp	#<$8
	beq	L444
	brl	L10277
L444:
base_5	set	14
lhsrce_5	set	18
lharray_5	set	22
	jsl	~~pop_array
	sta	<L425+lharray_5
	stx	<L425+lharray_5+2
	pei	<L425+rharray_1+2
	pei	<L425+rharray_1
	pei	<L425+lharray_5+2
	pei	<L425+lharray_5
	jsl	~~check_arrays
	and	#$ff
	beq	L445
	brl	L10278
L445:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10278:
	pei	<L425+rharray_1+2
	pei	<L425+rharray_1
	pea	#<$3
	jsl	~~make_array
	sta	<L425+base_5
	stx	<L425+base_5+2
	ldy	#$4
	lda	[<L425+lharray_5],Y
	sta	<L425+lhsrce_5
	ldy	#$6
	lda	[<L425+lharray_5],Y
	sta	<L425+lhsrce_5+2
	stz	<L425+n_1
	brl	L10282
L10281:
	ldy	#$0
	lda	<L425+n_1
	bpl	L446
	dey
L446:
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
	lda	<L425+base_5
	adc	<R0
	sta	<R2
	lda	<L425+base_5+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L425+n_1
	bpl	L447
	dey
L447:
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
	lda	<L425+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L425+rhsrce_1+2
	adc	<R0+2
	sta	<17+2
	ldy	#$0
	lda	[<17]
	bpl	L448
	dey
L448:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	ldy	#$0
	lda	<L425+n_1
	bpl	L449
	dey
L449:
	sta	<17
	sty	<17+2
	pei	<17+2
	pei	<17
	lda	#$2
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	lda	<L425+lhsrce_5
	adc	<R0
	sta	<21
	lda	<L425+lhsrce_5+2
	adc	<R0+2
	sta	<21+2
	ldy	#$2
	lda	[<21],Y
	pha
	lda	[<21]
	pha
	xref	~~~fadc
	jsl	~~~fadc
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10279:
	inc	<L425+n_1
L10282:
	sec
	lda	<L425+n_1
	sbc	<L425+count_1
	bvs	L450
	eor	#$8000
L450:
	bmi	L451
	brl	L10281
L451:
L10280:
	brl	L10283
L10277:
	lda	<L425+lhitem_1
	cmp	#<$9
	beq	L452
	brl	L10284
L452:
lhsrce_6	set	14
lharray_6	set	18
	jsl	~~pop_arraytemp
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L425+lharray_6
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$1c
	xref	~~~fmov
	jsl	~~~fmov
	pei	<L425+rharray_1+2
	pei	<L425+rharray_1
	pea	#0
	clc
	tdc
	adc	#<L425+lharray_6
	pha
	jsl	~~check_arrays
	and	#$ff
	beq	L453
	brl	L10285
L453:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10285:
	lda	<L425+lharray_6+4
	sta	<L425+lhsrce_6
	lda	<L425+lharray_6+6
	sta	<L425+lhsrce_6+2
	stz	<L425+n_1
	brl	L10289
L10288:
	ldy	#$0
	lda	<L425+n_1
	bpl	L454
	dey
L454:
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
	lda	<L425+lhsrce_6
	adc	<R0
	sta	<R2
	lda	<L425+lhsrce_6+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L425+n_1
	bpl	L455
	dey
L455:
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
	lda	<L425+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L425+rhsrce_1+2
	adc	<R0+2
	sta	<17+2
	ldy	#$0
	lda	[<17]
	bpl	L456
	dey
L456:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
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
L10286:
	inc	<L425+n_1
L10289:
	sec
	lda	<L425+n_1
	sbc	<L425+count_1
	bvs	L457
	eor	#$8000
L457:
	bmi	L458
	brl	L10288
L458:
L10287:
	pea	#<$3
	pea	#0
	clc
	tdc
	adc	#<L425+lharray_6
	pha
	jsl	~~push_arraytemp
	brl	L10290
L10284:
	jsl	~~want_number
L10290:
L10283:
L10276:
L10269:
L10263:
L459:
	pld
	tsc
	clc
	adc	#L424
	tcs
	rtl
L424	equ	74
L425	equ	29
	ends
	efunc
	code
	func
~~eval_faplus:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L460
	tcs
	phd
	tcd
lhitem_1	set	0
rharray_1	set	2
n_1	set	6
count_1	set	8
base_1	set	10
rhsrce_1	set	14
	jsl	~~pop_array
	sta	<L461+rharray_1
	stx	<L461+rharray_1+2
	ldy	#$2
	lda	[<L461+rharray_1],Y
	sta	<L461+count_1
	ldy	#$4
	lda	[<L461+rharray_1],Y
	sta	<L461+rhsrce_1
	ldy	#$6
	lda	[<L461+rharray_1],Y
	sta	<L461+rhsrce_1+2
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L461+lhitem_1
	lda	<L461+lhitem_1
	cmp	#<$2
	bne	L463
	brl	L462
L463:
	lda	<L461+lhitem_1
	cmp	#<$3
	beq	L464
	brl	L10291
L464:
L462:
	lda	<L461+lhitem_1
	cmp	#<$2
	beq	L466
	brl	L465
L466:
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L467
	dey
L467:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	bra	L468
L465:
	phy
	phy
	jsl	~~pop_float
L468:
	pla
	sta	|~~floatvalue
	pla
	sta	|~~floatvalue+2
	pei	<L461+rharray_1+2
	pei	<L461+rharray_1
	pea	#<$3
	jsl	~~make_array
	sta	<L461+base_1
	stx	<L461+base_1+2
	stz	<L461+n_1
	brl	L10295
L10294:
	ldy	#$0
	lda	<L461+n_1
	bpl	L469
	dey
L469:
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
	lda	<L461+base_1
	adc	<R0
	sta	<R2
	lda	<L461+base_1+2
	adc	<R0+2
	sta	<R2+2
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	ldy	#$0
	lda	<L461+n_1
	bpl	L470
	dey
L470:
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
	lda	<L461+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L461+rhsrce_1+2
	adc	<R0+2
	sta	<17+2
	ldy	#$2
	lda	[<17],Y
	pha
	lda	[<17]
	pha
	xref	~~~fadc
	jsl	~~~fadc
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10292:
	inc	<L461+n_1
L10295:
	sec
	lda	<L461+n_1
	sbc	<L461+count_1
	bvs	L471
	eor	#$8000
L471:
	bmi	L472
	brl	L10294
L472:
L10293:
	brl	L10296
L10291:
	lda	<L461+lhitem_1
	cmp	#<$6
	beq	L473
	brl	L10297
L473:
lhsrce_2	set	18
lharray_2	set	22
	jsl	~~pop_array
	sta	<L461+lharray_2
	stx	<L461+lharray_2+2
	pei	<L461+rharray_1+2
	pei	<L461+rharray_1
	pei	<L461+lharray_2+2
	pei	<L461+lharray_2
	jsl	~~check_arrays
	and	#$ff
	beq	L474
	brl	L10298
L474:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10298:
	pei	<L461+rharray_1+2
	pei	<L461+rharray_1
	pea	#<$3
	jsl	~~make_array
	sta	<L461+base_1
	stx	<L461+base_1+2
	ldy	#$4
	lda	[<L461+lharray_2],Y
	sta	<L461+lhsrce_2
	ldy	#$6
	lda	[<L461+lharray_2],Y
	sta	<L461+lhsrce_2+2
	stz	<L461+n_1
	brl	L10302
L10301:
	ldy	#$0
	lda	<L461+n_1
	bpl	L475
	dey
L475:
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
	lda	<L461+base_1
	adc	<R0
	sta	<R2
	lda	<L461+base_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L461+n_1
	bpl	L476
	dey
L476:
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
	lda	<L461+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L461+rhsrce_1+2
	adc	<R0+2
	sta	<17+2
	ldy	#$2
	lda	[<17],Y
	pha
	lda	[<17]
	pha
	ldy	#$0
	lda	<L461+n_1
	bpl	L477
	dey
L477:
	sta	<21
	sty	<21+2
	pei	<21+2
	pei	<21
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	lda	<L461+lhsrce_2
	adc	<R0
	sta	<25
	lda	<L461+lhsrce_2+2
	adc	<R0+2
	sta	<25+2
	ldy	#$0
	lda	[<25]
	bpl	L478
	dey
L478:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~fadc
	jsl	~~~fadc
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10299:
	inc	<L461+n_1
L10302:
	sec
	lda	<L461+n_1
	sbc	<L461+count_1
	bvs	L479
	eor	#$8000
L479:
	bmi	L480
	brl	L10301
L480:
L10300:
	brl	L10303
L10297:
	lda	<L461+lhitem_1
	cmp	#<$8
	beq	L481
	brl	L10304
L481:
lhsrce_3	set	18
lharray_3	set	22
	jsl	~~pop_array
	sta	<L461+lharray_3
	stx	<L461+lharray_3+2
	pei	<L461+rharray_1+2
	pei	<L461+rharray_1
	pei	<L461+lharray_3+2
	pei	<L461+lharray_3
	jsl	~~check_arrays
	and	#$ff
	beq	L482
	brl	L10305
L482:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10305:
	pei	<L461+rharray_1+2
	pei	<L461+rharray_1
	pea	#<$3
	jsl	~~make_array
	sta	<L461+base_1
	stx	<L461+base_1+2
	ldy	#$4
	lda	[<L461+lharray_3],Y
	sta	<L461+lhsrce_3
	ldy	#$6
	lda	[<L461+lharray_3],Y
	sta	<L461+lhsrce_3+2
	stz	<L461+n_1
	brl	L10309
L10308:
	ldy	#$0
	lda	<L461+n_1
	bpl	L483
	dey
L483:
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
	lda	<L461+base_1
	adc	<R0
	sta	<R2
	lda	<L461+base_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L461+n_1
	bpl	L484
	dey
L484:
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
	lda	<L461+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L461+rhsrce_1+2
	adc	<R0+2
	sta	<17+2
	ldy	#$2
	lda	[<17],Y
	pha
	lda	[<17]
	pha
	ldy	#$0
	lda	<L461+n_1
	bpl	L485
	dey
L485:
	sta	<21
	sty	<21+2
	pei	<21+2
	pei	<21
	lda	#$2
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	lda	<L461+lhsrce_3
	adc	<R0
	sta	<25
	lda	<L461+lhsrce_3+2
	adc	<R0+2
	sta	<25+2
	ldy	#$2
	lda	[<25],Y
	pha
	lda	[<25]
	pha
	xref	~~~fadc
	jsl	~~~fadc
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10306:
	inc	<L461+n_1
L10309:
	sec
	lda	<L461+n_1
	sbc	<L461+count_1
	bvs	L486
	eor	#$8000
L486:
	bmi	L487
	brl	L10308
L487:
L10307:
	brl	L10310
L10304:
	lda	<L461+lhitem_1
	cmp	#<$9
	beq	L488
	brl	L10311
L488:
lhsrce_4	set	18
lharray_4	set	22
	jsl	~~pop_arraytemp
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L461+lharray_4
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$1c
	xref	~~~fmov
	jsl	~~~fmov
	pei	<L461+rharray_1+2
	pei	<L461+rharray_1
	pea	#0
	clc
	tdc
	adc	#<L461+lharray_4
	pha
	jsl	~~check_arrays
	and	#$ff
	beq	L489
	brl	L10312
L489:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10312:
	lda	<L461+lharray_4+4
	sta	<L461+lhsrce_4
	lda	<L461+lharray_4+6
	sta	<L461+lhsrce_4+2
	stz	<L461+n_1
	brl	L10316
L10315:
	ldy	#$0
	lda	<L461+n_1
	bpl	L490
	dey
L490:
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
	lda	<L461+lhsrce_4
	adc	<R0
	sta	<R2
	lda	<L461+lhsrce_4+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L461+n_1
	bpl	L491
	dey
L491:
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
	lda	<L461+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L461+rhsrce_1+2
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
L10313:
	inc	<L461+n_1
L10316:
	sec
	lda	<L461+n_1
	sbc	<L461+count_1
	bvs	L492
	eor	#$8000
L492:
	bmi	L493
	brl	L10315
L493:
L10314:
	pea	#<$3
	pea	#0
	clc
	tdc
	adc	#<L461+lharray_4
	pha
	jsl	~~push_arraytemp
	brl	L10317
L10311:
	jsl	~~want_number
L10317:
L10310:
L10303:
L10296:
L494:
	pld
	tsc
	clc
	adc	#L460
	tcs
	rtl
L460	equ	78
L461	equ	29
	ends
	efunc
	code
	func
~~eval_saplus:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L495
	tcs
	phd
	tcd
lhitem_1	set	0
rharray_1	set	2
n_1	set	6
count_1	set	8
base_1	set	10
rhsrce_1	set	14
	jsl	~~pop_array
	sta	<L496+rharray_1
	stx	<L496+rharray_1+2
	ldy	#$2
	lda	[<L496+rharray_1],Y
	sta	<L496+count_1
	ldy	#$4
	lda	[<L496+rharray_1],Y
	sta	<L496+rhsrce_1
	ldy	#$6
	lda	[<L496+rharray_1],Y
	sta	<L496+rhsrce_1+2
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L496+lhitem_1
	lda	<L496+lhitem_1
	cmp	#<$4
	bne	L498
	brl	L497
L498:
	lda	<L496+lhitem_1
	cmp	#<$5
	beq	L499
	brl	L10318
L499:
L497:
newlen_2	set	18
cp_2	set	20
lhstring_2	set	24
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L496+lhstring_2
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	lda	<L496+lhstring_2
	beq	L500
	brl	L10319
L500:
	pea	#<$4
	pei	<L496+rharray_1+2
	pei	<L496+rharray_1
	jsl	~~push_array
L501:
	pld
	tsc
	clc
	adc	#L495
	tcs
	rtl
L10319:
	pei	<L496+rharray_1+2
	pei	<L496+rharray_1
	pea	#<$4
	jsl	~~make_array
	sta	<L496+base_1
	stx	<L496+base_1+2
	stz	<L496+n_1
	brl	L10323
L10322:
	ldy	#$0
	lda	<L496+n_1
	bpl	L502
	dey
L502:
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
	lda	<L496+rhsrce_1
	adc	<R0
	sta	<R1
	lda	<L496+rhsrce_1+2
	adc	<R0+2
	sta	<R1+2
	clc
	lda	[<R1]
	adc	<L496+lhstring_2
	sta	<L496+newlen_2
	sec
	lda	#$1000
	sbc	<L496+newlen_2
	bvs	L503
	eor	#$8000
L503:
	bpl	L504
	brl	L10324
L504:
	pea	#<$3d
	pea	#4
	jsl	~~error
L10324:
	pei	<L496+newlen_2
	jsl	~~alloc_string
	sta	<L496+cp_2
	stx	<L496+cp_2+2
	ldy	#$0
	lda	<L496+lhstring_2
	bpl	L505
	dey
L505:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L496+lhstring_2+4
	pei	<L496+lhstring_2+2
	pei	<L496+cp_2+2
	pei	<L496+cp_2
	jsl	~~memmove
	ldy	#$0
	lda	<L496+n_1
	bpl	L506
	dey
L506:
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
	lda	<L496+rhsrce_1
	adc	<R0
	sta	<R1
	lda	<L496+rhsrce_1+2
	adc	<R0+2
	sta	<R1+2
	ldy	#$0
	lda	[<R1]
	bpl	L507
	dey
L507:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	ldy	#$0
	lda	<L496+n_1
	bpl	L508
	dey
L508:
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
	adc	<L496+rhsrce_1
	sta	<R2
	lda	#$0
	adc	<L496+rhsrce_1+2
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
	ldy	#$0
	lda	<L496+lhstring_2
	bpl	L509
	dey
L509:
	sta	<R1
	sty	<R1+2
	clc
	lda	<L496+cp_2
	adc	<R1
	sta	<R2
	lda	<L496+cp_2+2
	adc	<R1+2
	sta	<R2+2
	pei	<R2+2
	pei	<R2
	jsl	~~memmove
	ldy	#$0
	lda	<L496+n_1
	bpl	L510
	dey
L510:
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
	adc	<L496+base_1
	sta	<R1
	lda	#$0
	adc	<L496+base_1+2
	sta	<R1+2
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	lda	<R1+2
	adc	<R0+2
	sta	<R2+2
	lda	<L496+cp_2
	sta	[<R2]
	lda	<L496+cp_2+2
	ldy	#$2
	sta	[<R2],Y
	ldy	#$0
	lda	<L496+n_1
	bpl	L511
	dey
L511:
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
	lda	<L496+base_1
	adc	<R0
	sta	<R1
	lda	<L496+base_1+2
	adc	<R0+2
	sta	<R1+2
	lda	<L496+newlen_2
	sta	[<R1]
L10320:
	inc	<L496+n_1
L10323:
	sec
	lda	<L496+n_1
	sbc	<L496+count_1
	bvs	L512
	eor	#$8000
L512:
	bmi	L513
	brl	L10322
L513:
L10321:
	lda	<L496+lhitem_1
	cmp	#<$5
	beq	L514
	brl	L10325
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
	adc	#<L496+lhstring_2
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
L10325:
	brl	L10326
L10318:
	lda	<L496+lhitem_1
	cmp	#<$a
	beq	L515
	brl	L10327
L515:
cp_3	set	18
newlen_3	set	22
lhsrce_3	set	24
lharray_3	set	28
	jsl	~~pop_array
	sta	<L496+lharray_3
	stx	<L496+lharray_3+2
	pei	<L496+rharray_1+2
	pei	<L496+rharray_1
	pei	<L496+lharray_3+2
	pei	<L496+lharray_3
	jsl	~~check_arrays
	and	#$ff
	beq	L516
	brl	L10328
L516:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10328:
	pei	<L496+rharray_1+2
	pei	<L496+rharray_1
	pea	#<$4
	jsl	~~make_array
	sta	<L496+base_1
	stx	<L496+base_1+2
	ldy	#$4
	lda	[<L496+lharray_3],Y
	sta	<L496+lhsrce_3
	ldy	#$6
	lda	[<L496+lharray_3],Y
	sta	<L496+lhsrce_3+2
	stz	<L496+n_1
	brl	L10332
L10331:
	ldy	#$0
	lda	<L496+n_1
	bpl	L517
	dey
L517:
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
	lda	<L496+rhsrce_1
	adc	<R0
	sta	<R1
	lda	<L496+rhsrce_1+2
	adc	<R0+2
	sta	<R1+2
	ldy	#$0
	lda	<L496+n_1
	bpl	L518
	dey
L518:
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
	lda	<L496+lhsrce_3
	adc	<R0
	sta	<R2
	lda	<L496+lhsrce_3+2
	adc	<R0+2
	sta	<R2+2
	clc
	lda	[<R2]
	adc	[<R1]
	sta	<L496+newlen_3
	sec
	lda	#$1000
	sbc	<L496+newlen_3
	bvs	L519
	eor	#$8000
L519:
	bpl	L520
	brl	L10333
L520:
	pea	#<$3d
	pea	#4
	jsl	~~error
L10333:
	pei	<L496+newlen_3
	jsl	~~alloc_string
	sta	<L496+cp_3
	stx	<L496+cp_3+2
	ldy	#$0
	lda	<L496+n_1
	bpl	L521
	dey
L521:
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
	lda	<L496+lhsrce_3
	adc	<R0
	sta	<R1
	lda	<L496+lhsrce_3+2
	adc	<R0+2
	sta	<R1+2
	ldy	#$0
	lda	[<R1]
	bpl	L522
	dey
L522:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	ldy	#$0
	lda	<L496+n_1
	bpl	L523
	dey
L523:
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
	adc	<L496+lhsrce_3
	sta	<R2
	lda	#$0
	adc	<L496+lhsrce_3+2
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
	pei	<L496+cp_3+2
	pei	<L496+cp_3
	jsl	~~memmove
	ldy	#$0
	lda	<L496+n_1
	bpl	L524
	dey
L524:
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
	lda	<L496+rhsrce_1
	adc	<R0
	sta	<R1
	lda	<L496+rhsrce_1+2
	adc	<R0+2
	sta	<R1+2
	ldy	#$0
	lda	[<R1]
	bpl	L525
	dey
L525:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	ldy	#$0
	lda	<L496+n_1
	bpl	L526
	dey
L526:
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
	adc	<L496+rhsrce_1
	sta	<R2
	lda	#$0
	adc	<L496+rhsrce_1+2
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
	ldy	#$0
	lda	<L496+n_1
	bpl	L527
	dey
L527:
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
	lda	<L496+lhsrce_3
	adc	<R1
	sta	<R2
	lda	<L496+lhsrce_3+2
	adc	<R1+2
	sta	<R2+2
	ldy	#$0
	lda	[<R2]
	bpl	L528
	dey
L528:
	sta	<R1
	sty	<R1+2
	clc
	lda	<L496+cp_3
	adc	<R1
	sta	<R2
	lda	<L496+cp_3+2
	adc	<R1+2
	sta	<R2+2
	pei	<R2+2
	pei	<R2
	jsl	~~memmove
	ldy	#$0
	lda	<L496+n_1
	bpl	L529
	dey
L529:
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
	adc	<L496+base_1
	sta	<R1
	lda	#$0
	adc	<L496+base_1+2
	sta	<R1+2
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	lda	<R1+2
	adc	<R0+2
	sta	<R2+2
	lda	<L496+cp_3
	sta	[<R2]
	lda	<L496+cp_3+2
	ldy	#$2
	sta	[<R2],Y
	ldy	#$0
	lda	<L496+n_1
	bpl	L530
	dey
L530:
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
	lda	<L496+base_1
	adc	<R0
	sta	<R1
	lda	<L496+base_1+2
	adc	<R0+2
	sta	<R1+2
	lda	<L496+newlen_3
	sta	[<R1]
L10329:
	inc	<L496+n_1
L10332:
	sec
	lda	<L496+n_1
	sbc	<L496+count_1
	bvs	L531
	eor	#$8000
L531:
	bmi	L532
	brl	L10331
L532:
L10330:
	brl	L10334
L10327:
	lda	<L496+lhitem_1
	cmp	#<$b
	beq	L533
	brl	L10335
L533:
cp_4	set	18
newlen_4	set	22
lhsrce_4	set	24
lharray_4	set	28
	jsl	~~pop_arraytemp
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L496+lharray_4
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$1c
	xref	~~~fmov
	jsl	~~~fmov
	pei	<L496+rharray_1+2
	pei	<L496+rharray_1
	pea	#0
	clc
	tdc
	adc	#<L496+lharray_4
	pha
	jsl	~~check_arrays
	and	#$ff
	beq	L534
	brl	L10336
L534:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10336:
	lda	<L496+lharray_4+4
	sta	<L496+lhsrce_4
	lda	<L496+lharray_4+6
	sta	<L496+lhsrce_4+2
	stz	<L496+n_1
	brl	L10340
L10339:
	ldy	#$0
	lda	<L496+n_1
	bpl	L535
	dey
L535:
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
	lda	<L496+rhsrce_1
	adc	<R0
	sta	<R1
	lda	<L496+rhsrce_1+2
	adc	<R0+2
	sta	<R1+2
	ldy	#$0
	lda	<L496+n_1
	bpl	L536
	dey
L536:
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
	lda	<L496+lhsrce_4
	adc	<R0
	sta	<R2
	lda	<L496+lhsrce_4+2
	adc	<R0+2
	sta	<R2+2
	clc
	lda	[<R2]
	adc	[<R1]
	sta	<L496+newlen_4
	sec
	lda	#$1000
	sbc	<L496+newlen_4
	bvs	L537
	eor	#$8000
L537:
	bpl	L538
	brl	L10341
L538:
	pea	#<$3d
	pea	#4
	jsl	~~error
L10341:
	pei	<L496+newlen_4
	ldy	#$0
	lda	<L496+n_1
	bpl	L539
	dey
L539:
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
	lda	<L496+lhsrce_4
	adc	<R0
	sta	<R1
	lda	<L496+lhsrce_4+2
	adc	<R0+2
	sta	<R1+2
	lda	[<R1]
	pha
	ldy	#$0
	lda	<L496+n_1
	bpl	L540
	dey
L540:
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
	adc	<L496+lhsrce_4
	sta	<R1
	lda	#$0
	adc	<L496+lhsrce_4+2
	sta	<R1+2
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	lda	<R1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$2
	lda	[<R2],Y
	pha
	lda	[<R2]
	pha
	jsl	~~resize_string
	sta	<L496+cp_4
	stx	<L496+cp_4+2
	ldy	#$0
	lda	<L496+n_1
	bpl	L541
	dey
L541:
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
	lda	<L496+rhsrce_1
	adc	<R0
	sta	<R1
	lda	<L496+rhsrce_1+2
	adc	<R0+2
	sta	<R1+2
	ldy	#$0
	lda	[<R1]
	bpl	L542
	dey
L542:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	ldy	#$0
	lda	<L496+n_1
	bpl	L543
	dey
L543:
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
	adc	<L496+rhsrce_1
	sta	<R2
	lda	#$0
	adc	<L496+rhsrce_1+2
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
	ldy	#$0
	lda	<L496+n_1
	bpl	L544
	dey
L544:
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
	lda	<L496+lhsrce_4
	adc	<R1
	sta	<R2
	lda	<L496+lhsrce_4+2
	adc	<R1+2
	sta	<R2+2
	ldy	#$0
	lda	[<R2]
	bpl	L545
	dey
L545:
	sta	<R1
	sty	<R1+2
	clc
	lda	<L496+cp_4
	adc	<R1
	sta	<R2
	lda	<L496+cp_4+2
	adc	<R1+2
	sta	<R2+2
	pei	<R2+2
	pei	<R2
	jsl	~~memmove
	ldy	#$0
	lda	<L496+n_1
	bpl	L546
	dey
L546:
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
	adc	<L496+lhsrce_4
	sta	<R1
	lda	#$0
	adc	<L496+lhsrce_4+2
	sta	<R1+2
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	lda	<R1+2
	adc	<R0+2
	sta	<R2+2
	lda	<L496+cp_4
	sta	[<R2]
	lda	<L496+cp_4+2
	ldy	#$2
	sta	[<R2],Y
	ldy	#$0
	lda	<L496+n_1
	bpl	L547
	dey
L547:
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
	lda	<L496+lhsrce_4
	adc	<R0
	sta	<R1
	lda	<L496+lhsrce_4+2
	adc	<R0+2
	sta	<R1+2
	lda	<L496+newlen_4
	sta	[<R1]
L10337:
	inc	<L496+n_1
L10340:
	sec
	lda	<L496+n_1
	sbc	<L496+count_1
	bvs	L548
	eor	#$8000
L548:
	bmi	L549
	brl	L10339
L549:
L10338:
	pea	#<$4
	pea	#0
	clc
	tdc
	adc	#<L496+lharray_4
	pha
	jsl	~~push_arraytemp
	brl	L10342
L10335:
	jsl	~~want_string
L10342:
L10334:
L10326:
	brl	L501
L495	equ	72
L496	equ	17
	ends
	efunc
	code
	func
~~eval_ivminus:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L550
	tcs
	phd
	tcd
lhitem_1	set	0
rhint_1	set	2
	jsl	~~pop_int
	sta	<L551+rhint_1
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L551+lhitem_1
	lda	<L551+lhitem_1
	cmp	#<$2
	beq	L552
	brl	L10343
L552:
	clc
	lda	#$2
	adc	|~~basicvars+42
	sta	<R0
	lda	#$0
	adc	|~~basicvars+42+2
	sta	<R0+2
	sec
	lda	[<R0]
	sbc	<L551+rhint_1
	sta	[<R0]
	brl	L10344
L10343:
	lda	<L551+lhitem_1
	cmp	#<$3
	beq	L553
	brl	L10345
L553:
	clc
	lda	#$2
	adc	|~~basicvars+42
	sta	<R0
	lda	#$0
	adc	|~~basicvars+42+2
	sta	<R0+2
	ldy	#$0
	lda	<L551+rhint_1
	bpl	L554
	dey
L554:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	ldy	#$2
	lda	[<R0],Y
	pha
	lda	[<R0]
	pha
	xref	~~~fsbc
	jsl	~~~fsbc
	pla
	sta	[<R0]
	pla
	ldy	#$2
	sta	[<R0],Y
	brl	L10346
L10345:
	lda	<L551+lhitem_1
	cmp	#<$6
	bne	L556
	brl	L555
L556:
	lda	<L551+lhitem_1
	cmp	#<$8
	beq	L557
	brl	L10347
L557:
L555:
lharray_2	set	4
n_2	set	8
count_2	set	10
	jsl	~~pop_array
	sta	<L551+lharray_2
	stx	<L551+lharray_2+2
	ldy	#$2
	lda	[<L551+lharray_2],Y
	sta	<L551+count_2
	lda	<L551+lhitem_1
	cmp	#<$6
	beq	L558
	brl	L10348
L558:
srce_3	set	12
base_3	set	16
	pei	<L551+lharray_2+2
	pei	<L551+lharray_2
	pea	#<$2
	jsl	~~make_array
	sta	<L551+base_3
	stx	<L551+base_3+2
	ldy	#$4
	lda	[<L551+lharray_2],Y
	sta	<L551+srce_3
	ldy	#$6
	lda	[<L551+lharray_2],Y
	sta	<L551+srce_3+2
	stz	<L551+n_2
	brl	L10352
L10351:
	ldy	#$0
	lda	<L551+n_2
	bpl	L559
	dey
L559:
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
	lda	<L551+base_3
	adc	<R0
	sta	<R2
	lda	<L551+base_3+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L551+n_2
	bpl	L560
	dey
L560:
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
	lda	<L551+srce_3
	adc	<R0
	sta	<17
	lda	<L551+srce_3+2
	adc	<R0+2
	sta	<17+2
	sec
	lda	[<17]
	sbc	<L551+rhint_1
	sta	[<R2]
L10349:
	inc	<L551+n_2
L10352:
	sec
	lda	<L551+n_2
	sbc	<L551+count_2
	bvs	L561
	eor	#$8000
L561:
	bmi	L562
	brl	L10351
L562:
L10350:
	brl	L10353
L10348:
srce_4	set	12
base_4	set	16
	pei	<L551+lharray_2+2
	pei	<L551+lharray_2
	pea	#<$3
	jsl	~~make_array
	sta	<L551+base_4
	stx	<L551+base_4+2
	ldy	#$0
	lda	<L551+rhint_1
	bpl	L563
	dey
L563:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	pla
	sta	|~~floatvalue
	pla
	sta	|~~floatvalue+2
	ldy	#$4
	lda	[<L551+lharray_2],Y
	sta	<L551+srce_4
	ldy	#$6
	lda	[<L551+lharray_2],Y
	sta	<L551+srce_4+2
	stz	<L551+n_2
	brl	L10357
L10356:
	ldy	#$0
	lda	<L551+n_2
	bpl	L564
	dey
L564:
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
	lda	<L551+base_4
	adc	<R0
	sta	<R2
	lda	<L551+base_4+2
	adc	<R0+2
	sta	<R2+2
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	ldy	#$0
	lda	<L551+n_2
	bpl	L565
	dey
L565:
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
	lda	<L551+srce_4
	adc	<R0
	sta	<17
	lda	<L551+srce_4+2
	adc	<R0+2
	sta	<17+2
	ldy	#$2
	lda	[<17],Y
	pha
	lda	[<17]
	pha
	xref	~~~fsbc
	jsl	~~~fsbc
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10354:
	inc	<L551+n_2
L10357:
	sec
	lda	<L551+n_2
	sbc	<L551+count_2
	bvs	L566
	eor	#$8000
L566:
	bmi	L567
	brl	L10356
L567:
L10355:
L10353:
	brl	L10358
L10347:
	lda	<L551+lhitem_1
	cmp	#<$9
	beq	L568
	brl	L10359
L568:
lharray_5	set	4
base_5	set	32
n_5	set	36
count_5	set	38
	jsl	~~pop_arraytemp
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L551+lharray_5
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$1c
	xref	~~~fmov
	jsl	~~~fmov
	lda	<L551+lharray_5+4
	sta	<L551+base_5
	lda	<L551+lharray_5+6
	sta	<L551+base_5+2
	lda	<L551+lharray_5+2
	sta	<L551+count_5
	ldy	#$0
	lda	<L551+rhint_1
	bpl	L569
	dey
L569:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	pla
	sta	|~~floatvalue
	pla
	sta	|~~floatvalue+2
	stz	<L551+n_5
	brl	L10363
L10362:
	ldy	#$0
	lda	<L551+n_5
	bpl	L570
	dey
L570:
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
	lda	<L551+base_5
	adc	<R0
	sta	<R2
	lda	<L551+base_5+2
	adc	<R0+2
	sta	<R2+2
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
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
L10360:
	inc	<L551+n_5
L10363:
	sec
	lda	<L551+n_5
	sbc	<L551+count_5
	bvs	L571
	eor	#$8000
L571:
	bmi	L572
	brl	L10362
L572:
L10361:
	pea	#<$3
	pea	#0
	clc
	tdc
	adc	#<L551+lharray_5
	pha
	jsl	~~push_arraytemp
	brl	L10364
L10359:
	jsl	~~want_number
L10364:
L10358:
L10346:
L10344:
L573:
	pld
	tsc
	clc
	adc	#L550
	tcs
	rtl
L550	equ	60
L551	equ	21
	ends
	efunc
	code
	func
~~eval_fvminus:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L574
	tcs
	phd
	tcd
lhitem_1	set	0
	phy
	phy
	jsl	~~pop_float
	pla
	sta	|~~floatvalue
	pla
	sta	|~~floatvalue+2
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L575+lhitem_1
	lda	<L575+lhitem_1
	cmp	#<$2
	beq	L576
	brl	L10365
L576:
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L577
	dey
L577:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~fsbc
	jsl	~~~fsbc
	pla
	sta	|~~floatvalue
	pla
	sta	|~~floatvalue+2
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
	lda	|~~floatvalue
	ldy	#$2
	sta	[<R0],Y
	lda	|~~floatvalue+2
	ldy	#$4
	sta	[<R0],Y
	brl	L10366
L10365:
	lda	<L575+lhitem_1
	cmp	#<$3
	beq	L578
	brl	L10367
L578:
	clc
	lda	#$2
	adc	|~~basicvars+42
	sta	<R0
	lda	#$0
	adc	|~~basicvars+42+2
	sta	<R0+2
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	ldy	#$2
	lda	[<R0],Y
	pha
	lda	[<R0]
	pha
	xref	~~~fsbc
	jsl	~~~fsbc
	pla
	sta	[<R0]
	pla
	ldy	#$2
	sta	[<R0],Y
	brl	L10368
L10367:
	lda	<L575+lhitem_1
	cmp	#<$6
	bne	L580
	brl	L579
L580:
	lda	<L575+lhitem_1
	cmp	#<$8
	beq	L581
	brl	L10369
L581:
L579:
lharray_2	set	2
base_2	set	6
n_2	set	10
count_2	set	12
	jsl	~~pop_array
	sta	<L575+lharray_2
	stx	<L575+lharray_2+2
	ldy	#$2
	lda	[<L575+lharray_2],Y
	sta	<L575+count_2
	pei	<L575+lharray_2+2
	pei	<L575+lharray_2
	pea	#<$3
	jsl	~~make_array
	sta	<L575+base_2
	stx	<L575+base_2+2
	lda	<L575+lhitem_1
	cmp	#<$6
	beq	L582
	brl	L10370
L582:
srce_3	set	14
	ldy	#$4
	lda	[<L575+lharray_2],Y
	sta	<L575+srce_3
	ldy	#$6
	lda	[<L575+lharray_2],Y
	sta	<L575+srce_3+2
	stz	<L575+n_2
	brl	L10374
L10373:
	ldy	#$0
	lda	<L575+n_2
	bpl	L583
	dey
L583:
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
	lda	<L575+base_2
	adc	<R0
	sta	<R2
	lda	<L575+base_2+2
	adc	<R0+2
	sta	<R2+2
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	ldy	#$0
	lda	<L575+n_2
	bpl	L584
	dey
L584:
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
	lda	<L575+srce_3
	adc	<R0
	sta	<17
	lda	<L575+srce_3+2
	adc	<R0+2
	sta	<17+2
	ldy	#$0
	lda	[<17]
	bpl	L585
	dey
L585:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~fsbc
	jsl	~~~fsbc
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10371:
	inc	<L575+n_2
L10374:
	sec
	lda	<L575+n_2
	sbc	<L575+count_2
	bvs	L586
	eor	#$8000
L586:
	bmi	L587
	brl	L10373
L587:
L10372:
	brl	L10375
L10370:
srce_4	set	14
	ldy	#$4
	lda	[<L575+lharray_2],Y
	sta	<L575+srce_4
	ldy	#$6
	lda	[<L575+lharray_2],Y
	sta	<L575+srce_4+2
	stz	<L575+n_2
	brl	L10379
L10378:
	ldy	#$0
	lda	<L575+n_2
	bpl	L588
	dey
L588:
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
	lda	<L575+base_2
	adc	<R0
	sta	<R2
	lda	<L575+base_2+2
	adc	<R0+2
	sta	<R2+2
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	ldy	#$0
	lda	<L575+n_2
	bpl	L589
	dey
L589:
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
	lda	<L575+srce_4
	adc	<R0
	sta	<17
	lda	<L575+srce_4+2
	adc	<R0+2
	sta	<17+2
	ldy	#$2
	lda	[<17],Y
	pha
	lda	[<17]
	pha
	xref	~~~fsbc
	jsl	~~~fsbc
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10376:
	inc	<L575+n_2
L10379:
	sec
	lda	<L575+n_2
	sbc	<L575+count_2
	bvs	L590
	eor	#$8000
L590:
	bmi	L591
	brl	L10378
L591:
L10377:
L10375:
	brl	L10380
L10369:
	lda	<L575+lhitem_1
	cmp	#<$9
	beq	L592
	brl	L10381
L592:
lharray_5	set	2
base_5	set	30
n_5	set	34
count_5	set	36
	jsl	~~pop_arraytemp
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L575+lharray_5
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$1c
	xref	~~~fmov
	jsl	~~~fmov
	lda	<L575+lharray_5+4
	sta	<L575+base_5
	lda	<L575+lharray_5+6
	sta	<L575+base_5+2
	lda	<L575+lharray_5+2
	sta	<L575+count_5
	stz	<L575+n_5
	brl	L10385
L10384:
	ldy	#$0
	lda	<L575+n_5
	bpl	L593
	dey
L593:
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
	lda	<L575+base_5
	adc	<R0
	sta	<R2
	lda	<L575+base_5+2
	adc	<R0+2
	sta	<R2+2
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
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
L10382:
	inc	<L575+n_5
L10385:
	sec
	lda	<L575+n_5
	sbc	<L575+count_5
	bvs	L594
	eor	#$8000
L594:
	bmi	L595
	brl	L10384
L595:
L10383:
	pea	#<$3
	pea	#0
	clc
	tdc
	adc	#<L575+lharray_5
	pha
	jsl	~~push_arraytemp
	brl	L10386
L10381:
	jsl	~~want_number
L10386:
L10380:
L10368:
L10366:
L596:
	pld
	tsc
	clc
	adc	#L574
	tcs
	rtl
L574	equ	58
L575	equ	21
	ends
	efunc
	code
	func
~~eval_iaminus:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L597
	tcs
	phd
	tcd
lhitem_1	set	0
rharray_1	set	2
n_1	set	6
count_1	set	8
rhsrce_1	set	10
	jsl	~~pop_array
	sta	<L598+rharray_1
	stx	<L598+rharray_1+2
	ldy	#$2
	lda	[<L598+rharray_1],Y
	sta	<L598+count_1
	ldy	#$4
	lda	[<L598+rharray_1],Y
	sta	<L598+rhsrce_1
	ldy	#$6
	lda	[<L598+rharray_1],Y
	sta	<L598+rhsrce_1+2
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L598+lhitem_1
	lda	<L598+lhitem_1
	cmp	#<$2
	beq	L599
	brl	L10387
L599:
lhint_2	set	14
base_2	set	16
	jsl	~~pop_int
	sta	<L598+lhint_2
	pei	<L598+rharray_1+2
	pei	<L598+rharray_1
	pea	#<$2
	jsl	~~make_array
	sta	<L598+base_2
	stx	<L598+base_2+2
	stz	<L598+n_1
	brl	L10391
L10390:
	ldy	#$0
	lda	<L598+n_1
	bpl	L600
	dey
L600:
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
	lda	<L598+base_2
	adc	<R0
	sta	<R2
	lda	<L598+base_2+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L598+n_1
	bpl	L601
	dey
L601:
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
	lda	<L598+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L598+rhsrce_1+2
	adc	<R0+2
	sta	<17+2
	sec
	lda	<L598+lhint_2
	sbc	[<17]
	sta	[<R2]
L10388:
	inc	<L598+n_1
L10391:
	sec
	lda	<L598+n_1
	sbc	<L598+count_1
	bvs	L602
	eor	#$8000
L602:
	bmi	L603
	brl	L10390
L603:
L10389:
	brl	L10392
L10387:
	lda	<L598+lhitem_1
	cmp	#<$3
	beq	L604
	brl	L10393
L604:
base_3	set	14
	phy
	phy
	jsl	~~pop_float
	pla
	sta	|~~floatvalue
	pla
	sta	|~~floatvalue+2
	pei	<L598+rharray_1+2
	pei	<L598+rharray_1
	pea	#<$3
	jsl	~~make_array
	sta	<L598+base_3
	stx	<L598+base_3+2
	stz	<L598+n_1
	brl	L10397
L10396:
	ldy	#$0
	lda	<L598+n_1
	bpl	L605
	dey
L605:
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
	lda	<L598+base_3
	adc	<R0
	sta	<R2
	lda	<L598+base_3+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L598+n_1
	bpl	L606
	dey
L606:
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
	lda	<L598+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L598+rhsrce_1+2
	adc	<R0+2
	sta	<17+2
	ldy	#$0
	lda	[<17]
	bpl	L607
	dey
L607:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	xref	~~~fsbc
	jsl	~~~fsbc
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10394:
	inc	<L598+n_1
L10397:
	sec
	lda	<L598+n_1
	sbc	<L598+count_1
	bvs	L608
	eor	#$8000
L608:
	bmi	L609
	brl	L10396
L609:
L10395:
	brl	L10398
L10393:
	lda	<L598+lhitem_1
	cmp	#<$6
	beq	L610
	brl	L10399
L610:
base_4	set	14
lhsrce_4	set	18
lharray_4	set	22
	jsl	~~pop_array
	sta	<L598+lharray_4
	stx	<L598+lharray_4+2
	pei	<L598+rharray_1+2
	pei	<L598+rharray_1
	pei	<L598+lharray_4+2
	pei	<L598+lharray_4
	jsl	~~check_arrays
	and	#$ff
	beq	L611
	brl	L10400
L611:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10400:
	ldy	#$4
	lda	[<L598+lharray_4],Y
	sta	<L598+lhsrce_4
	ldy	#$6
	lda	[<L598+lharray_4],Y
	sta	<L598+lhsrce_4+2
	pei	<L598+rharray_1+2
	pei	<L598+rharray_1
	pea	#<$2
	jsl	~~make_array
	sta	<L598+base_4
	stx	<L598+base_4+2
	stz	<L598+n_1
	brl	L10404
L10403:
	ldy	#$0
	lda	<L598+n_1
	bpl	L612
	dey
L612:
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
	lda	<L598+base_4
	adc	<R0
	sta	<R2
	lda	<L598+base_4+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L598+n_1
	bpl	L613
	dey
L613:
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
	lda	<L598+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L598+rhsrce_1+2
	adc	<R0+2
	sta	<17+2
	ldy	#$0
	lda	<L598+n_1
	bpl	L614
	dey
L614:
	sta	<21
	sty	<21+2
	pei	<21+2
	pei	<21
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	lda	<L598+lhsrce_4
	adc	<R0
	sta	<25
	lda	<L598+lhsrce_4+2
	adc	<R0+2
	sta	<25+2
	sec
	lda	[<25]
	sbc	[<17]
	sta	[<R2]
L10401:
	inc	<L598+n_1
L10404:
	sec
	lda	<L598+n_1
	sbc	<L598+count_1
	bvs	L615
	eor	#$8000
L615:
	bmi	L616
	brl	L10403
L616:
L10402:
	brl	L10405
L10399:
	lda	<L598+lhitem_1
	cmp	#<$8
	beq	L617
	brl	L10406
L617:
base_5	set	14
lhsrce_5	set	18
lharray_5	set	22
	jsl	~~pop_array
	sta	<L598+lharray_5
	stx	<L598+lharray_5+2
	pei	<L598+rharray_1+2
	pei	<L598+rharray_1
	pei	<L598+lharray_5+2
	pei	<L598+lharray_5
	jsl	~~check_arrays
	and	#$ff
	beq	L618
	brl	L10407
L618:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10407:
	pei	<L598+rharray_1+2
	pei	<L598+rharray_1
	pea	#<$3
	jsl	~~make_array
	sta	<L598+base_5
	stx	<L598+base_5+2
	ldy	#$4
	lda	[<L598+lharray_5],Y
	sta	<L598+lhsrce_5
	ldy	#$6
	lda	[<L598+lharray_5],Y
	sta	<L598+lhsrce_5+2
	stz	<L598+n_1
	brl	L10411
L10410:
	ldy	#$0
	lda	<L598+n_1
	bpl	L619
	dey
L619:
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
	lda	<L598+base_5
	adc	<R0
	sta	<R2
	lda	<L598+base_5+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L598+n_1
	bpl	L620
	dey
L620:
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
	lda	<L598+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L598+rhsrce_1+2
	adc	<R0+2
	sta	<17+2
	ldy	#$0
	lda	[<17]
	bpl	L621
	dey
L621:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	ldy	#$0
	lda	<L598+n_1
	bpl	L622
	dey
L622:
	sta	<17
	sty	<17+2
	pei	<17+2
	pei	<17
	lda	#$2
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	lda	<L598+lhsrce_5
	adc	<R0
	sta	<21
	lda	<L598+lhsrce_5+2
	adc	<R0+2
	sta	<21+2
	ldy	#$2
	lda	[<21],Y
	pha
	lda	[<21]
	pha
	xref	~~~fsbc
	jsl	~~~fsbc
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10408:
	inc	<L598+n_1
L10411:
	sec
	lda	<L598+n_1
	sbc	<L598+count_1
	bvs	L623
	eor	#$8000
L623:
	bmi	L624
	brl	L10410
L624:
L10409:
	brl	L10412
L10406:
	lda	<L598+lhitem_1
	cmp	#<$9
	beq	L625
	brl	L10413
L625:
lhsrce_6	set	14
lharray_6	set	18
	jsl	~~pop_arraytemp
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L598+lharray_6
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$1c
	xref	~~~fmov
	jsl	~~~fmov
	pei	<L598+rharray_1+2
	pei	<L598+rharray_1
	pea	#0
	clc
	tdc
	adc	#<L598+lharray_6
	pha
	jsl	~~check_arrays
	and	#$ff
	beq	L626
	brl	L10414
L626:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10414:
	lda	<L598+lharray_6+4
	sta	<L598+lhsrce_6
	lda	<L598+lharray_6+6
	sta	<L598+lhsrce_6+2
	stz	<L598+n_1
	brl	L10418
L10417:
	ldy	#$0
	lda	<L598+n_1
	bpl	L627
	dey
L627:
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
	lda	<L598+lhsrce_6
	adc	<R0
	sta	<R2
	lda	<L598+lhsrce_6+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L598+n_1
	bpl	L628
	dey
L628:
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
	lda	<L598+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L598+rhsrce_1+2
	adc	<R0+2
	sta	<17+2
	ldy	#$0
	lda	[<17]
	bpl	L629
	dey
L629:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
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
L10415:
	inc	<L598+n_1
L10418:
	sec
	lda	<L598+n_1
	sbc	<L598+count_1
	bvs	L630
	eor	#$8000
L630:
	bmi	L631
	brl	L10417
L631:
L10416:
	pea	#<$3
	pea	#0
	clc
	tdc
	adc	#<L598+lharray_6
	pha
	jsl	~~push_arraytemp
	brl	L10419
L10413:
	jsl	~~want_number
L10419:
L10412:
L10405:
L10398:
L10392:
L632:
	pld
	tsc
	clc
	adc	#L597
	tcs
	rtl
L597	equ	74
L598	equ	29
	ends
	efunc
	code
	func
~~eval_faminus:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L633
	tcs
	phd
	tcd
lhitem_1	set	0
rharray_1	set	2
n_1	set	6
count_1	set	8
base_1	set	10
rhsrce_1	set	14
	jsl	~~pop_array
	sta	<L634+rharray_1
	stx	<L634+rharray_1+2
	ldy	#$2
	lda	[<L634+rharray_1],Y
	sta	<L634+count_1
	ldy	#$4
	lda	[<L634+rharray_1],Y
	sta	<L634+rhsrce_1
	ldy	#$6
	lda	[<L634+rharray_1],Y
	sta	<L634+rhsrce_1+2
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L634+lhitem_1
	lda	<L634+lhitem_1
	cmp	#<$2
	bne	L636
	brl	L635
L636:
	lda	<L634+lhitem_1
	cmp	#<$3
	beq	L637
	brl	L10420
L637:
L635:
	lda	<L634+lhitem_1
	cmp	#<$2
	beq	L639
	brl	L638
L639:
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L640
	dey
L640:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	bra	L641
L638:
	phy
	phy
	jsl	~~pop_float
L641:
	pla
	sta	|~~floatvalue
	pla
	sta	|~~floatvalue+2
	pei	<L634+rharray_1+2
	pei	<L634+rharray_1
	pea	#<$3
	jsl	~~make_array
	sta	<L634+base_1
	stx	<L634+base_1+2
	stz	<L634+n_1
	brl	L10424
L10423:
	ldy	#$0
	lda	<L634+n_1
	bpl	L642
	dey
L642:
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
	lda	<L634+base_1
	adc	<R0
	sta	<R2
	lda	<L634+base_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L634+n_1
	bpl	L643
	dey
L643:
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
	lda	<L634+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L634+rhsrce_1+2
	adc	<R0+2
	sta	<17+2
	ldy	#$2
	lda	[<17],Y
	pha
	lda	[<17]
	pha
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	xref	~~~fsbc
	jsl	~~~fsbc
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10421:
	inc	<L634+n_1
L10424:
	sec
	lda	<L634+n_1
	sbc	<L634+count_1
	bvs	L644
	eor	#$8000
L644:
	bmi	L645
	brl	L10423
L645:
L10422:
	brl	L10425
L10420:
	lda	<L634+lhitem_1
	cmp	#<$6
	beq	L646
	brl	L10426
L646:
lhsrce_2	set	18
lharray_2	set	22
	jsl	~~pop_array
	sta	<L634+lharray_2
	stx	<L634+lharray_2+2
	pei	<L634+rharray_1+2
	pei	<L634+rharray_1
	pei	<L634+lharray_2+2
	pei	<L634+lharray_2
	jsl	~~check_arrays
	and	#$ff
	beq	L647
	brl	L10427
L647:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10427:
	pei	<L634+rharray_1+2
	pei	<L634+rharray_1
	pea	#<$3
	jsl	~~make_array
	sta	<L634+base_1
	stx	<L634+base_1+2
	ldy	#$4
	lda	[<L634+lharray_2],Y
	sta	<L634+lhsrce_2
	ldy	#$6
	lda	[<L634+lharray_2],Y
	sta	<L634+lhsrce_2+2
	stz	<L634+n_1
	brl	L10431
L10430:
	ldy	#$0
	lda	<L634+n_1
	bpl	L648
	dey
L648:
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
	lda	<L634+base_1
	adc	<R0
	sta	<R2
	lda	<L634+base_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L634+n_1
	bpl	L649
	dey
L649:
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
	lda	<L634+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L634+rhsrce_1+2
	adc	<R0+2
	sta	<17+2
	ldy	#$2
	lda	[<17],Y
	pha
	lda	[<17]
	pha
	ldy	#$0
	lda	<L634+n_1
	bpl	L650
	dey
L650:
	sta	<21
	sty	<21+2
	pei	<21+2
	pei	<21
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	lda	<L634+lhsrce_2
	adc	<R0
	sta	<25
	lda	<L634+lhsrce_2+2
	adc	<R0+2
	sta	<25+2
	ldy	#$0
	lda	[<25]
	bpl	L651
	dey
L651:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~fsbc
	jsl	~~~fsbc
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10428:
	inc	<L634+n_1
L10431:
	sec
	lda	<L634+n_1
	sbc	<L634+count_1
	bvs	L652
	eor	#$8000
L652:
	bmi	L653
	brl	L10430
L653:
L10429:
	brl	L10432
L10426:
	lda	<L634+lhitem_1
	cmp	#<$8
	beq	L654
	brl	L10433
L654:
lhsrce_3	set	18
lharray_3	set	22
	jsl	~~pop_array
	sta	<L634+lharray_3
	stx	<L634+lharray_3+2
	pei	<L634+rharray_1+2
	pei	<L634+rharray_1
	pei	<L634+lharray_3+2
	pei	<L634+lharray_3
	jsl	~~check_arrays
	and	#$ff
	beq	L655
	brl	L10434
L655:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10434:
	pei	<L634+rharray_1+2
	pei	<L634+rharray_1
	pea	#<$3
	jsl	~~make_array
	sta	<L634+base_1
	stx	<L634+base_1+2
	ldy	#$4
	lda	[<L634+lharray_3],Y
	sta	<L634+lhsrce_3
	ldy	#$6
	lda	[<L634+lharray_3],Y
	sta	<L634+lhsrce_3+2
	stz	<L634+n_1
	brl	L10438
L10437:
	ldy	#$0
	lda	<L634+n_1
	bpl	L656
	dey
L656:
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
	lda	<L634+base_1
	adc	<R0
	sta	<R2
	lda	<L634+base_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L634+n_1
	bpl	L657
	dey
L657:
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
	lda	<L634+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L634+rhsrce_1+2
	adc	<R0+2
	sta	<17+2
	ldy	#$2
	lda	[<17],Y
	pha
	lda	[<17]
	pha
	ldy	#$0
	lda	<L634+n_1
	bpl	L658
	dey
L658:
	sta	<21
	sty	<21+2
	pei	<21+2
	pei	<21
	lda	#$2
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	lda	<L634+lhsrce_3
	adc	<R0
	sta	<25
	lda	<L634+lhsrce_3+2
	adc	<R0+2
	sta	<25+2
	ldy	#$2
	lda	[<25],Y
	pha
	lda	[<25]
	pha
	xref	~~~fsbc
	jsl	~~~fsbc
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10435:
	inc	<L634+n_1
L10438:
	sec
	lda	<L634+n_1
	sbc	<L634+count_1
	bvs	L659
	eor	#$8000
L659:
	bmi	L660
	brl	L10437
L660:
L10436:
	brl	L10439
L10433:
	lda	<L634+lhitem_1
	cmp	#<$9
	beq	L661
	brl	L10440
L661:
lhsrce_4	set	18
lharray_4	set	22
	jsl	~~pop_arraytemp
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L634+lharray_4
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$1c
	xref	~~~fmov
	jsl	~~~fmov
	pei	<L634+rharray_1+2
	pei	<L634+rharray_1
	pea	#0
	clc
	tdc
	adc	#<L634+lharray_4
	pha
	jsl	~~check_arrays
	and	#$ff
	beq	L662
	brl	L10441
L662:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10441:
	lda	<L634+lharray_4+4
	sta	<L634+lhsrce_4
	lda	<L634+lharray_4+6
	sta	<L634+lhsrce_4+2
	stz	<L634+n_1
	brl	L10445
L10444:
	ldy	#$0
	lda	<L634+n_1
	bpl	L663
	dey
L663:
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
	lda	<L634+lhsrce_4
	adc	<R0
	sta	<R2
	lda	<L634+lhsrce_4+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L634+n_1
	bpl	L664
	dey
L664:
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
	lda	<L634+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L634+rhsrce_1+2
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
L10442:
	inc	<L634+n_1
L10445:
	sec
	lda	<L634+n_1
	sbc	<L634+count_1
	bvs	L665
	eor	#$8000
L665:
	bmi	L666
	brl	L10444
L666:
L10443:
	pea	#<$3
	pea	#0
	clc
	tdc
	adc	#<L634+lharray_4
	pha
	jsl	~~push_arraytemp
	brl	L10446
L10440:
	jsl	~~want_number
L10446:
L10439:
L10432:
L10425:
L667:
	pld
	tsc
	clc
	adc	#L633
	tcs
	rtl
L633	equ	78
L634	equ	29
	ends
	efunc
	code
	func
~~eval_ivmul:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L668
	tcs
	phd
	tcd
lhitem_1	set	0
rhint_1	set	2
	jsl	~~pop_int
	sta	<L669+rhint_1
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L669+lhitem_1
	lda	<L669+lhitem_1
	cmp	#<$2
	beq	L670
	brl	L10447
L670:
lhint_2	set	4
	jsl	~~pop_int
	sta	<L669+lhint_2
	lda	<L669+rhint_1
	ora	<L669+lhint_2
	sta	<R0
	lda	<R0
	cmp	#<$8000
	bcc	L671
	brl	L10448
L671:
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
	lda	<L669+lhint_2
	ldx	<L669+rhint_1
	xref	~~~mul
	jsl	~~~mul
	ldy	#$2
	sta	[<R0],Y
	brl	L10449
L10448:
	ldy	#$0
	lda	<L669+rhint_1
	bpl	L672
	dey
L672:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	ldy	#$0
	lda	<L669+lhint_2
	bpl	L673
	dey
L673:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~fmul
	jsl	~~~fmul
	pla
	sta	|~~floatvalue
	pla
	sta	|~~floatvalue+2
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
	jsl	~~fabs
	pea	#$41DF
	pea	#$FFFF
	pea	#$FFC0
	pea	#$0000
	xref	~~~dcmp
	jsl	~~~dcmp
	bpl	L674
	brl	L10450
L674:
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
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R1
	pla
	sta	<R1+2
	lda	<R1
	ldy	#$2
	sta	[<R0],Y
	brl	L10451
L10450:
	pea	#<$3a
	pea	#4
	jsl	~~error
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
	lda	|~~floatvalue
	ldy	#$2
	sta	[<R0],Y
	lda	|~~floatvalue+2
	ldy	#$4
	sta	[<R0],Y
L10451:
L10449:
	brl	L10452
L10447:
	lda	<L669+lhitem_1
	cmp	#<$3
	beq	L675
	brl	L10453
L675:
	ldy	#$0
	lda	<L669+rhint_1
	bpl	L676
	dey
L676:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	phy
	phy
	jsl	~~pop_float
	xref	~~~fmul
	jsl	~~~fmul
	jsl	~~push_float
	brl	L10454
L10453:
	lda	<L669+lhitem_1
	cmp	#<$6
	bne	L678
	brl	L677
L678:
	lda	<L669+lhitem_1
	cmp	#<$8
	beq	L679
	brl	L10455
L679:
L677:
lharray_3	set	4
n_3	set	8
count_3	set	10
	jsl	~~pop_array
	sta	<L669+lharray_3
	stx	<L669+lharray_3+2
	ldy	#$2
	lda	[<L669+lharray_3],Y
	sta	<L669+count_3
	lda	<L669+lhitem_1
	cmp	#<$6
	beq	L680
	brl	L10456
L680:
srce_4	set	12
base_4	set	16
	pei	<L669+lharray_3+2
	pei	<L669+lharray_3
	pea	#<$2
	jsl	~~make_array
	sta	<L669+base_4
	stx	<L669+base_4+2
	ldy	#$4
	lda	[<L669+lharray_3],Y
	sta	<L669+srce_4
	ldy	#$6
	lda	[<L669+lharray_3],Y
	sta	<L669+srce_4+2
	stz	<L669+n_3
	brl	L10460
L10459:
	ldy	#$0
	lda	<L669+rhint_1
	bpl	L681
	dey
L681:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	ldy	#$0
	lda	<L669+n_3
	bpl	L682
	dey
L682:
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
	lda	<L669+srce_4
	adc	<R0
	sta	<R2
	lda	<L669+srce_4+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	[<R2]
	bpl	L683
	dey
L683:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~fmul
	jsl	~~~fmul
	pla
	sta	|~~floatvalue
	pla
	sta	|~~floatvalue+2
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
	jsl	~~fabs
	pea	#$41DF
	pea	#$FFFF
	pea	#$FFC0
	pea	#$0000
	xref	~~~dcmp
	jsl	~~~dcmp
	bpl	L684
	brl	L10461
L684:
	ldy	#$0
	lda	<L669+n_3
	bpl	L685
	dey
L685:
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
	lda	<L669+base_4
	adc	<R0
	sta	<R2
	lda	<L669+base_4+2
	adc	<R0+2
	sta	<R2+2
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R0
	pla
	sta	<R0+2
	lda	<R0
	sta	[<R2]
	brl	L10462
L10461:
	pea	#<$3a
	pea	#4
	jsl	~~error
L10462:
L10457:
	inc	<L669+n_3
L10460:
	sec
	lda	<L669+n_3
	sbc	<L669+count_3
	bvs	L686
	eor	#$8000
L686:
	bmi	L687
	brl	L10459
L687:
L10458:
	brl	L10463
L10456:
srce_5	set	12
base_5	set	16
	pei	<L669+lharray_3+2
	pei	<L669+lharray_3
	pea	#<$3
	jsl	~~make_array
	sta	<L669+base_5
	stx	<L669+base_5+2
	ldy	#$0
	lda	<L669+rhint_1
	bpl	L688
	dey
L688:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	pla
	sta	|~~floatvalue
	pla
	sta	|~~floatvalue+2
	ldy	#$4
	lda	[<L669+lharray_3],Y
	sta	<L669+srce_5
	ldy	#$6
	lda	[<L669+lharray_3],Y
	sta	<L669+srce_5+2
	stz	<L669+n_3
	brl	L10467
L10466:
	ldy	#$0
	lda	<L669+n_3
	bpl	L689
	dey
L689:
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
	lda	<L669+base_5
	adc	<R0
	sta	<R2
	lda	<L669+base_5+2
	adc	<R0+2
	sta	<R2+2
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	ldy	#$0
	lda	<L669+n_3
	bpl	L690
	dey
L690:
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
	lda	<L669+srce_5
	adc	<R0
	sta	<17
	lda	<L669+srce_5+2
	adc	<R0+2
	sta	<17+2
	ldy	#$2
	lda	[<17],Y
	pha
	lda	[<17]
	pha
	xref	~~~fmul
	jsl	~~~fmul
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10464:
	inc	<L669+n_3
L10467:
	sec
	lda	<L669+n_3
	sbc	<L669+count_3
	bvs	L691
	eor	#$8000
L691:
	bmi	L692
	brl	L10466
L692:
L10465:
L10463:
	brl	L10468
L10455:
	lda	<L669+lhitem_1
	cmp	#<$9
	beq	L693
	brl	L10469
L693:
lharray_6	set	4
base_6	set	32
n_6	set	36
count_6	set	38
	jsl	~~pop_arraytemp
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L669+lharray_6
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$1c
	xref	~~~fmov
	jsl	~~~fmov
	lda	<L669+lharray_6+4
	sta	<L669+base_6
	lda	<L669+lharray_6+6
	sta	<L669+base_6+2
	lda	<L669+lharray_6+2
	sta	<L669+count_6
	ldy	#$0
	lda	<L669+rhint_1
	bpl	L694
	dey
L694:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	pla
	sta	|~~floatvalue
	pla
	sta	|~~floatvalue+2
	stz	<L669+n_6
	brl	L10473
L10472:
	ldy	#$0
	lda	<L669+n_6
	bpl	L695
	dey
L695:
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
	lda	<L669+base_6
	adc	<R0
	sta	<R2
	lda	<L669+base_6+2
	adc	<R0+2
	sta	<R2+2
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	ldy	#$2
	lda	[<R2],Y
	pha
	lda	[<R2]
	pha
	xref	~~~fmul
	jsl	~~~fmul
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10470:
	inc	<L669+n_6
L10473:
	sec
	lda	<L669+n_6
	sbc	<L669+count_6
	bvs	L696
	eor	#$8000
L696:
	bmi	L697
	brl	L10472
L697:
L10471:
	pea	#<$3
	pea	#0
	clc
	tdc
	adc	#<L669+lharray_6
	pha
	jsl	~~push_arraytemp
	brl	L10474
L10469:
	jsl	~~want_number
L10474:
L10468:
L10454:
L10452:
L698:
	pld
	tsc
	clc
	adc	#L668
	tcs
	rtl
L668	equ	60
L669	equ	21
	ends
	efunc
	code
	func
~~eval_fvmul:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L699
	tcs
	phd
	tcd
lhitem_1	set	0
	phy
	phy
	jsl	~~pop_float
	pla
	sta	|~~floatvalue
	pla
	sta	|~~floatvalue+2
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L700+lhitem_1
	lda	<L700+lhitem_1
	cmp	#<$2
	beq	L701
	brl	L10475
L701:
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L702
	dey
L702:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~fmul
	jsl	~~~fmul
	jsl	~~push_float
	brl	L10476
L10475:
	lda	<L700+lhitem_1
	cmp	#<$3
	beq	L703
	brl	L10477
L703:
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	phy
	phy
	jsl	~~pop_float
	xref	~~~fmul
	jsl	~~~fmul
	jsl	~~push_float
	brl	L10478
L10477:
	lda	<L700+lhitem_1
	cmp	#<$6
	bne	L705
	brl	L704
L705:
	lda	<L700+lhitem_1
	cmp	#<$8
	beq	L706
	brl	L10479
L706:
L704:
lharray_2	set	2
base_2	set	6
n_2	set	10
count_2	set	12
	jsl	~~pop_array
	sta	<L700+lharray_2
	stx	<L700+lharray_2+2
	ldy	#$2
	lda	[<L700+lharray_2],Y
	sta	<L700+count_2
	pei	<L700+lharray_2+2
	pei	<L700+lharray_2
	pea	#<$3
	jsl	~~make_array
	sta	<L700+base_2
	stx	<L700+base_2+2
	lda	<L700+lhitem_1
	cmp	#<$6
	beq	L707
	brl	L10480
L707:
srce_3	set	14
	ldy	#$4
	lda	[<L700+lharray_2],Y
	sta	<L700+srce_3
	ldy	#$6
	lda	[<L700+lharray_2],Y
	sta	<L700+srce_3+2
	stz	<L700+n_2
	brl	L10484
L10483:
	ldy	#$0
	lda	<L700+n_2
	bpl	L708
	dey
L708:
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
	lda	<L700+base_2
	adc	<R0
	sta	<R2
	lda	<L700+base_2+2
	adc	<R0+2
	sta	<R2+2
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	ldy	#$0
	lda	<L700+n_2
	bpl	L709
	dey
L709:
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
	lda	<L700+srce_3
	adc	<R0
	sta	<17
	lda	<L700+srce_3+2
	adc	<R0+2
	sta	<17+2
	ldy	#$0
	lda	[<17]
	bpl	L710
	dey
L710:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~fmul
	jsl	~~~fmul
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10481:
	inc	<L700+n_2
L10484:
	sec
	lda	<L700+n_2
	sbc	<L700+count_2
	bvs	L711
	eor	#$8000
L711:
	bmi	L712
	brl	L10483
L712:
L10482:
	brl	L10485
L10480:
srce_4	set	14
	ldy	#$4
	lda	[<L700+lharray_2],Y
	sta	<L700+srce_4
	ldy	#$6
	lda	[<L700+lharray_2],Y
	sta	<L700+srce_4+2
	stz	<L700+n_2
	brl	L10489
L10488:
	ldy	#$0
	lda	<L700+n_2
	bpl	L713
	dey
L713:
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
	lda	<L700+base_2
	adc	<R0
	sta	<R2
	lda	<L700+base_2+2
	adc	<R0+2
	sta	<R2+2
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	ldy	#$0
	lda	<L700+n_2
	bpl	L714
	dey
L714:
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
	lda	<L700+srce_4
	adc	<R0
	sta	<17
	lda	<L700+srce_4+2
	adc	<R0+2
	sta	<17+2
	ldy	#$2
	lda	[<17],Y
	pha
	lda	[<17]
	pha
	xref	~~~fmul
	jsl	~~~fmul
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10486:
	inc	<L700+n_2
L10489:
	sec
	lda	<L700+n_2
	sbc	<L700+count_2
	bvs	L715
	eor	#$8000
L715:
	bmi	L716
	brl	L10488
L716:
L10487:
L10485:
	brl	L10490
L10479:
	lda	<L700+lhitem_1
	cmp	#<$9
	beq	L717
	brl	L10491
L717:
lharray_5	set	2
base_5	set	30
n_5	set	34
count_5	set	36
	jsl	~~pop_arraytemp
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L700+lharray_5
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$1c
	xref	~~~fmov
	jsl	~~~fmov
	lda	<L700+lharray_5+4
	sta	<L700+base_5
	lda	<L700+lharray_5+6
	sta	<L700+base_5+2
	lda	<L700+lharray_5+2
	sta	<L700+count_5
	stz	<L700+n_5
	brl	L10495
L10494:
	ldy	#$0
	lda	<L700+n_5
	bpl	L718
	dey
L718:
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
	lda	<L700+base_5
	adc	<R0
	sta	<R2
	lda	<L700+base_5+2
	adc	<R0+2
	sta	<R2+2
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	ldy	#$2
	lda	[<R2],Y
	pha
	lda	[<R2]
	pha
	xref	~~~fmul
	jsl	~~~fmul
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10492:
	inc	<L700+n_5
L10495:
	sec
	lda	<L700+n_5
	sbc	<L700+count_5
	bvs	L719
	eor	#$8000
L719:
	bmi	L720
	brl	L10494
L720:
L10493:
	pea	#<$3
	pea	#0
	clc
	tdc
	adc	#<L700+lharray_5
	pha
	jsl	~~push_arraytemp
	brl	L10496
L10491:
	jsl	~~want_number
L10496:
L10490:
L10478:
L10476:
L721:
	pld
	tsc
	clc
	adc	#L699
	tcs
	rtl
L699	equ	58
L700	equ	21
	ends
	efunc
	code
	func
~~eval_iamul:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L722
	tcs
	phd
	tcd
lhitem_1	set	0
rharray_1	set	2
n_1	set	6
count_1	set	8
rhsrce_1	set	10
	jsl	~~pop_array
	sta	<L723+rharray_1
	stx	<L723+rharray_1+2
	ldy	#$2
	lda	[<L723+rharray_1],Y
	sta	<L723+count_1
	ldy	#$4
	lda	[<L723+rharray_1],Y
	sta	<L723+rhsrce_1
	ldy	#$6
	lda	[<L723+rharray_1],Y
	sta	<L723+rhsrce_1+2
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L723+lhitem_1
	lda	<L723+lhitem_1
	cmp	#<$2
	beq	L724
	brl	L10497
L724:
	udata
L10498:
	ds	4
	ends
base_2	set	14
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L725
	dey
L725:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	pla
	sta	|L10498
	pla
	sta	|L10498+2
	pei	<L723+rharray_1+2
	pei	<L723+rharray_1
	pea	#<$2
	jsl	~~make_array
	sta	<L723+base_2
	stx	<L723+base_2+2
	stz	<L723+n_1
	brl	L10502
L10501:
	lda	|L10498+2
	pha
	lda	|L10498
	pha
	ldy	#$0
	lda	<L723+n_1
	bpl	L726
	dey
L726:
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
	lda	<L723+rhsrce_1
	adc	<R0
	sta	<R2
	lda	<L723+rhsrce_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	[<R2]
	bpl	L727
	dey
L727:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~fmul
	jsl	~~~fmul
	pla
	sta	|~~floatvalue
	pla
	sta	|~~floatvalue+2
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
	jsl	~~fabs
	pea	#$41DF
	pea	#$FFFF
	pea	#$FFC0
	pea	#$0000
	xref	~~~dcmp
	jsl	~~~dcmp
	bpl	L728
	brl	L10503
L728:
	ldy	#$0
	lda	<L723+n_1
	bpl	L729
	dey
L729:
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
	lda	<L723+base_2
	adc	<R0
	sta	<R2
	lda	<L723+base_2+2
	adc	<R0+2
	sta	<R2+2
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R0
	pla
	sta	<R0+2
	lda	<R0
	sta	[<R2]
	brl	L10504
L10503:
	pea	#<$3a
	pea	#4
	jsl	~~error
L10504:
L10499:
	inc	<L723+n_1
L10502:
	sec
	lda	<L723+n_1
	sbc	<L723+count_1
	bvs	L730
	eor	#$8000
L730:
	bmi	L731
	brl	L10501
L731:
L10500:
	brl	L10505
L10497:
	lda	<L723+lhitem_1
	cmp	#<$3
	beq	L732
	brl	L10506
L732:
base_3	set	14
	phy
	phy
	jsl	~~pop_float
	pla
	sta	|~~floatvalue
	pla
	sta	|~~floatvalue+2
	pei	<L723+rharray_1+2
	pei	<L723+rharray_1
	pea	#<$3
	jsl	~~make_array
	sta	<L723+base_3
	stx	<L723+base_3+2
	stz	<L723+n_1
	brl	L10510
L10509:
	ldy	#$0
	lda	<L723+n_1
	bpl	L733
	dey
L733:
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
	lda	<L723+base_3
	adc	<R0
	sta	<R2
	lda	<L723+base_3+2
	adc	<R0+2
	sta	<R2+2
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	ldy	#$0
	lda	<L723+n_1
	bpl	L734
	dey
L734:
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
	lda	<L723+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L723+rhsrce_1+2
	adc	<R0+2
	sta	<17+2
	ldy	#$0
	lda	[<17]
	bpl	L735
	dey
L735:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~fmul
	jsl	~~~fmul
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10507:
	inc	<L723+n_1
L10510:
	sec
	lda	<L723+n_1
	sbc	<L723+count_1
	bvs	L736
	eor	#$8000
L736:
	bmi	L737
	brl	L10509
L737:
L10508:
	brl	L10511
L10506:
	lda	<L723+lhitem_1
	cmp	#<$6
	beq	L738
	brl	L10512
L738:
base_4	set	14
lhsrce_4	set	18
lharray_4	set	22
	jsl	~~pop_array
	sta	<L723+lharray_4
	stx	<L723+lharray_4+2
	pei	<L723+rharray_1+2
	pei	<L723+rharray_1
	pei	<L723+lharray_4+2
	pei	<L723+lharray_4
	jsl	~~check_arrays
	and	#$ff
	beq	L739
	brl	L10513
L739:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10513:
	ldy	#$4
	lda	[<L723+lharray_4],Y
	sta	<L723+lhsrce_4
	ldy	#$6
	lda	[<L723+lharray_4],Y
	sta	<L723+lhsrce_4+2
	pei	<L723+rharray_1+2
	pei	<L723+rharray_1
	pea	#<$2
	jsl	~~make_array
	sta	<L723+base_4
	stx	<L723+base_4+2
	stz	<L723+n_1
	brl	L10517
L10516:
	ldy	#$0
	lda	<L723+n_1
	bpl	L740
	dey
L740:
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
	lda	<L723+rhsrce_1
	adc	<R0
	sta	<R2
	lda	<L723+rhsrce_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	[<R2]
	bpl	L741
	dey
L741:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	ldy	#$0
	lda	<L723+n_1
	bpl	L742
	dey
L742:
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
	lda	<L723+lhsrce_4
	adc	<R0
	sta	<R3
	lda	<L723+lhsrce_4+2
	adc	<R0+2
	sta	<R3+2
	ldy	#$0
	lda	[<R3]
	bpl	L743
	dey
L743:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~fmul
	jsl	~~~fmul
	pla
	sta	|~~floatvalue
	pla
	sta	|~~floatvalue+2
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
	jsl	~~fabs
	pea	#$41DF
	pea	#$FFFF
	pea	#$FFC0
	pea	#$0000
	xref	~~~dcmp
	jsl	~~~dcmp
	bpl	L744
	brl	L10518
L744:
	ldy	#$0
	lda	<L723+n_1
	bpl	L745
	dey
L745:
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
	lda	<L723+base_4
	adc	<R0
	sta	<R2
	lda	<L723+base_4+2
	adc	<R0+2
	sta	<R2+2
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R0
	pla
	sta	<R0+2
	lda	<R0
	sta	[<R2]
	brl	L10519
L10518:
	pea	#<$3a
	pea	#4
	jsl	~~error
L10519:
L10514:
	inc	<L723+n_1
L10517:
	sec
	lda	<L723+n_1
	sbc	<L723+count_1
	bvs	L746
	eor	#$8000
L746:
	bmi	L747
	brl	L10516
L747:
L10515:
	brl	L10520
L10512:
	lda	<L723+lhitem_1
	cmp	#<$8
	beq	L748
	brl	L10521
L748:
base_5	set	14
lhsrce_5	set	18
lharray_5	set	22
	jsl	~~pop_array
	sta	<L723+lharray_5
	stx	<L723+lharray_5+2
	pei	<L723+rharray_1+2
	pei	<L723+rharray_1
	pei	<L723+lharray_5+2
	pei	<L723+lharray_5
	jsl	~~check_arrays
	and	#$ff
	beq	L749
	brl	L10522
L749:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10522:
	pei	<L723+rharray_1+2
	pei	<L723+rharray_1
	pea	#<$3
	jsl	~~make_array
	sta	<L723+base_5
	stx	<L723+base_5+2
	ldy	#$4
	lda	[<L723+lharray_5],Y
	sta	<L723+lhsrce_5
	ldy	#$6
	lda	[<L723+lharray_5],Y
	sta	<L723+lhsrce_5+2
	stz	<L723+n_1
	brl	L10526
L10525:
	ldy	#$0
	lda	<L723+n_1
	bpl	L750
	dey
L750:
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
	lda	<L723+base_5
	adc	<R0
	sta	<R2
	lda	<L723+base_5+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L723+n_1
	bpl	L751
	dey
L751:
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
	lda	<L723+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L723+rhsrce_1+2
	adc	<R0+2
	sta	<17+2
	ldy	#$0
	lda	[<17]
	bpl	L752
	dey
L752:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	ldy	#$0
	lda	<L723+n_1
	bpl	L753
	dey
L753:
	sta	<17
	sty	<17+2
	pei	<17+2
	pei	<17
	lda	#$2
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	lda	<L723+lhsrce_5
	adc	<R0
	sta	<21
	lda	<L723+lhsrce_5+2
	adc	<R0+2
	sta	<21+2
	ldy	#$2
	lda	[<21],Y
	pha
	lda	[<21]
	pha
	xref	~~~fmul
	jsl	~~~fmul
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10523:
	inc	<L723+n_1
L10526:
	sec
	lda	<L723+n_1
	sbc	<L723+count_1
	bvs	L754
	eor	#$8000
L754:
	bmi	L755
	brl	L10525
L755:
L10524:
	brl	L10527
L10521:
	lda	<L723+lhitem_1
	cmp	#<$9
	beq	L756
	brl	L10528
L756:
lhsrce_6	set	14
lharray_6	set	18
	jsl	~~pop_arraytemp
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L723+lharray_6
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$1c
	xref	~~~fmov
	jsl	~~~fmov
	pei	<L723+rharray_1+2
	pei	<L723+rharray_1
	pea	#0
	clc
	tdc
	adc	#<L723+lharray_6
	pha
	jsl	~~check_arrays
	and	#$ff
	beq	L757
	brl	L10529
L757:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10529:
	lda	<L723+lharray_6+4
	sta	<L723+lhsrce_6
	lda	<L723+lharray_6+6
	sta	<L723+lhsrce_6+2
	stz	<L723+n_1
	brl	L10533
L10532:
	ldy	#$0
	lda	<L723+n_1
	bpl	L758
	dey
L758:
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
	lda	<L723+lhsrce_6
	adc	<R0
	sta	<R2
	lda	<L723+lhsrce_6+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L723+n_1
	bpl	L759
	dey
L759:
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
	lda	<L723+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L723+rhsrce_1+2
	adc	<R0+2
	sta	<17+2
	ldy	#$0
	lda	[<17]
	bpl	L760
	dey
L760:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	ldy	#$2
	lda	[<R2],Y
	pha
	lda	[<R2]
	pha
	xref	~~~fmul
	jsl	~~~fmul
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10530:
	inc	<L723+n_1
L10533:
	sec
	lda	<L723+n_1
	sbc	<L723+count_1
	bvs	L761
	eor	#$8000
L761:
	bmi	L762
	brl	L10532
L762:
L10531:
	pea	#<$3
	pea	#0
	clc
	tdc
	adc	#<L723+lharray_6
	pha
	jsl	~~push_arraytemp
	brl	L10534
L10528:
	jsl	~~want_number
L10534:
L10527:
L10520:
L10511:
L10505:
L763:
	pld
	tsc
	clc
	adc	#L722
	tcs
	rtl
L722	equ	70
L723	equ	25
	ends
	efunc
	code
	func
~~eval_famul:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L764
	tcs
	phd
	tcd
lhitem_1	set	0
rharray_1	set	2
n_1	set	6
count_1	set	8
base_1	set	10
rhsrce_1	set	14
	jsl	~~pop_array
	sta	<L765+rharray_1
	stx	<L765+rharray_1+2
	ldy	#$2
	lda	[<L765+rharray_1],Y
	sta	<L765+count_1
	ldy	#$4
	lda	[<L765+rharray_1],Y
	sta	<L765+rhsrce_1
	ldy	#$6
	lda	[<L765+rharray_1],Y
	sta	<L765+rhsrce_1+2
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L765+lhitem_1
	lda	<L765+lhitem_1
	cmp	#<$2
	bne	L767
	brl	L766
L767:
	lda	<L765+lhitem_1
	cmp	#<$3
	beq	L768
	brl	L10535
L768:
L766:
	lda	<L765+lhitem_1
	cmp	#<$2
	beq	L770
	brl	L769
L770:
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L771
	dey
L771:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	bra	L772
L769:
	phy
	phy
	jsl	~~pop_float
L772:
	pla
	sta	|~~floatvalue
	pla
	sta	|~~floatvalue+2
	pei	<L765+rharray_1+2
	pei	<L765+rharray_1
	pea	#<$3
	jsl	~~make_array
	sta	<L765+base_1
	stx	<L765+base_1+2
	stz	<L765+n_1
	brl	L10539
L10538:
	ldy	#$0
	lda	<L765+n_1
	bpl	L773
	dey
L773:
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
	lda	<L765+base_1
	adc	<R0
	sta	<R2
	lda	<L765+base_1+2
	adc	<R0+2
	sta	<R2+2
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	ldy	#$0
	lda	<L765+n_1
	bpl	L774
	dey
L774:
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
	lda	<L765+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L765+rhsrce_1+2
	adc	<R0+2
	sta	<17+2
	ldy	#$2
	lda	[<17],Y
	pha
	lda	[<17]
	pha
	xref	~~~fmul
	jsl	~~~fmul
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10536:
	inc	<L765+n_1
L10539:
	sec
	lda	<L765+n_1
	sbc	<L765+count_1
	bvs	L775
	eor	#$8000
L775:
	bmi	L776
	brl	L10538
L776:
L10537:
	brl	L10540
L10535:
	lda	<L765+lhitem_1
	cmp	#<$6
	beq	L777
	brl	L10541
L777:
lhsrce_2	set	18
lharray_2	set	22
	jsl	~~pop_array
	sta	<L765+lharray_2
	stx	<L765+lharray_2+2
	pei	<L765+rharray_1+2
	pei	<L765+rharray_1
	pei	<L765+lharray_2+2
	pei	<L765+lharray_2
	jsl	~~check_arrays
	and	#$ff
	beq	L778
	brl	L10542
L778:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10542:
	pei	<L765+rharray_1+2
	pei	<L765+rharray_1
	pea	#<$3
	jsl	~~make_array
	sta	<L765+base_1
	stx	<L765+base_1+2
	ldy	#$4
	lda	[<L765+lharray_2],Y
	sta	<L765+lhsrce_2
	ldy	#$6
	lda	[<L765+lharray_2],Y
	sta	<L765+lhsrce_2+2
	stz	<L765+n_1
	brl	L10546
L10545:
	ldy	#$0
	lda	<L765+n_1
	bpl	L779
	dey
L779:
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
	lda	<L765+base_1
	adc	<R0
	sta	<R2
	lda	<L765+base_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L765+n_1
	bpl	L780
	dey
L780:
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
	lda	<L765+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L765+rhsrce_1+2
	adc	<R0+2
	sta	<17+2
	ldy	#$2
	lda	[<17],Y
	pha
	lda	[<17]
	pha
	ldy	#$0
	lda	<L765+n_1
	bpl	L781
	dey
L781:
	sta	<21
	sty	<21+2
	pei	<21+2
	pei	<21
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	lda	<L765+lhsrce_2
	adc	<R0
	sta	<25
	lda	<L765+lhsrce_2+2
	adc	<R0+2
	sta	<25+2
	ldy	#$0
	lda	[<25]
	bpl	L782
	dey
L782:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~fmul
	jsl	~~~fmul
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10543:
	inc	<L765+n_1
L10546:
	sec
	lda	<L765+n_1
	sbc	<L765+count_1
	bvs	L783
	eor	#$8000
L783:
	bmi	L784
	brl	L10545
L784:
L10544:
	brl	L10547
L10541:
	lda	<L765+lhitem_1
	cmp	#<$8
	beq	L785
	brl	L10548
L785:
lhsrce_3	set	18
lharray_3	set	22
	jsl	~~pop_array
	sta	<L765+lharray_3
	stx	<L765+lharray_3+2
	pei	<L765+rharray_1+2
	pei	<L765+rharray_1
	pei	<L765+lharray_3+2
	pei	<L765+lharray_3
	jsl	~~check_arrays
	and	#$ff
	beq	L786
	brl	L10549
L786:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10549:
	pei	<L765+rharray_1+2
	pei	<L765+rharray_1
	pea	#<$3
	jsl	~~make_array
	sta	<L765+base_1
	stx	<L765+base_1+2
	ldy	#$4
	lda	[<L765+lharray_3],Y
	sta	<L765+lhsrce_3
	ldy	#$6
	lda	[<L765+lharray_3],Y
	sta	<L765+lhsrce_3+2
	stz	<L765+n_1
	brl	L10553
L10552:
	ldy	#$0
	lda	<L765+n_1
	bpl	L787
	dey
L787:
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
	lda	<L765+base_1
	adc	<R0
	sta	<R2
	lda	<L765+base_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L765+n_1
	bpl	L788
	dey
L788:
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
	lda	<L765+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L765+rhsrce_1+2
	adc	<R0+2
	sta	<17+2
	ldy	#$2
	lda	[<17],Y
	pha
	lda	[<17]
	pha
	ldy	#$0
	lda	<L765+n_1
	bpl	L789
	dey
L789:
	sta	<21
	sty	<21+2
	pei	<21+2
	pei	<21
	lda	#$2
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	lda	<L765+lhsrce_3
	adc	<R0
	sta	<25
	lda	<L765+lhsrce_3+2
	adc	<R0+2
	sta	<25+2
	ldy	#$2
	lda	[<25],Y
	pha
	lda	[<25]
	pha
	xref	~~~fmul
	jsl	~~~fmul
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10550:
	inc	<L765+n_1
L10553:
	sec
	lda	<L765+n_1
	sbc	<L765+count_1
	bvs	L790
	eor	#$8000
L790:
	bmi	L791
	brl	L10552
L791:
L10551:
	brl	L10554
L10548:
	lda	<L765+lhitem_1
	cmp	#<$9
	beq	L792
	brl	L10555
L792:
lhsrce_4	set	18
lharray_4	set	22
	jsl	~~pop_arraytemp
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L765+lharray_4
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$1c
	xref	~~~fmov
	jsl	~~~fmov
	pei	<L765+rharray_1+2
	pei	<L765+rharray_1
	pea	#0
	clc
	tdc
	adc	#<L765+lharray_4
	pha
	jsl	~~check_arrays
	and	#$ff
	beq	L793
	brl	L10556
L793:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10556:
	lda	<L765+lharray_4+4
	sta	<L765+lhsrce_4
	lda	<L765+lharray_4+6
	sta	<L765+lhsrce_4+2
	stz	<L765+n_1
	brl	L10560
L10559:
	ldy	#$0
	lda	<L765+n_1
	bpl	L794
	dey
L794:
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
	lda	<L765+lhsrce_4
	adc	<R0
	sta	<R2
	lda	<L765+lhsrce_4+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L765+n_1
	bpl	L795
	dey
L795:
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
	lda	<L765+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L765+rhsrce_1+2
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
	xref	~~~fmul
	jsl	~~~fmul
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10557:
	inc	<L765+n_1
L10560:
	sec
	lda	<L765+n_1
	sbc	<L765+count_1
	bvs	L796
	eor	#$8000
L796:
	bmi	L797
	brl	L10559
L797:
L10558:
	pea	#<$3
	pea	#0
	clc
	tdc
	adc	#<L765+lharray_4
	pha
	jsl	~~push_arraytemp
	brl	L10561
L10555:
	jsl	~~want_number
L10561:
L10554:
L10547:
L10540:
L798:
	pld
	tsc
	clc
	adc	#L764
	tcs
	rtl
L764	equ	78
L765	equ	29
	ends
	efunc
	code
	func
~~check_arraytype:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L799
	tcs
	phd
	tcd
result_0	set	4
lharray_0	set	8
rharray_0	set	12
lhrows_1	set	0
lhcols_1	set	2
rhrows_1	set	4
rhcols_1	set	6
	sec
	lda	#$2
	sbc	[<L799+lharray_0]
	bvs	L802
	eor	#$8000
L802:
	bmi	L803
	brl	L801
L803:
	sec
	lda	#$2
	sbc	[<L799+rharray_0]
	bvs	L804
	eor	#$8000
L804:
	bpl	L805
	brl	L10562
L805:
L801:
	pea	#<$4d
	pea	#4
	jsl	~~error
L10562:
	ldy	#$8
	lda	[<L799+lharray_0],Y
	sta	<L800+lhrows_1
	ldy	#$a
	lda	[<L799+lharray_0],Y
	sta	<L800+lhcols_1
	ldy	#$8
	lda	[<L799+rharray_0],Y
	sta	<L800+rhrows_1
	ldy	#$a
	lda	[<L799+rharray_0],Y
	sta	<L800+rhcols_1
	lda	[<L799+lharray_0]
	cmp	#<$1
	beq	L806
	brl	L10563
L806:
	lda	<L800+lhrows_1
	cmp	<L800+rhrows_1
	bne	L807
	brl	L10564
L807:
	pea	#<$4d
	pea	#4
	jsl	~~error
L10564:
	lda	#$1
	sta	[<L799+result_0]
	lda	[<L799+rharray_0]
	cmp	#<$1
	beq	L808
	brl	L10565
L808:
	lda	#$1
	ldy	#$2
	sta	[<L799+result_0],Y
	lda	#$1
	ldy	#$8
	sta	[<L799+result_0],Y
	brl	L10566
L10565:
	lda	<L800+rhcols_1
	ldy	#$2
	sta	[<L799+result_0],Y
	lda	<L800+rhcols_1
	ldy	#$8
	sta	[<L799+result_0],Y
L10566:
	brl	L10567
L10563:
	lda	[<L799+rharray_0]
	cmp	#<$1
	beq	L809
	brl	L10568
L809:
	lda	<L800+rhrows_1
	cmp	<L800+lhcols_1
	bne	L810
	brl	L10569
L810:
	pea	#<$4d
	pea	#4
	jsl	~~error
L10569:
	lda	#$1
	sta	[<L799+result_0]
	lda	<L800+rhrows_1
	ldy	#$2
	sta	[<L799+result_0],Y
	lda	<L800+rhrows_1
	ldy	#$8
	sta	[<L799+result_0],Y
	brl	L10570
L10568:
	lda	<L800+lhcols_1
	cmp	<L800+rhrows_1
	bne	L811
	brl	L10571
L811:
	pea	#<$4d
	pea	#4
	jsl	~~error
L10571:
	lda	#$2
	sta	[<L799+result_0]
	lda	<L800+lhrows_1
	ldx	<L800+rhcols_1
	xref	~~~mul
	jsl	~~~mul
	ldy	#$2
	sta	[<L799+result_0],Y
	lda	<L800+lhrows_1
	ldy	#$8
	sta	[<L799+result_0],Y
	lda	<L800+rhcols_1
	ldy	#$a
	sta	[<L799+result_0],Y
L10570:
L10567:
L812:
	lda	<L799+2
	sta	<L799+2+12
	lda	<L799+1
	sta	<L799+1+12
	pld
	tsc
	clc
	adc	#L799+12
	tcs
	rtl
L799	equ	8
L800	equ	1
	ends
	efunc
	code
	func
~~eval_immul:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L813
	tcs
	phd
	tcd
base_1	set	0
lhbase_1	set	4
rhbase_1	set	8
resindex_1	set	12
row_1	set	14
col_1	set	16
sum_1	set	18
lhrowsize_1	set	20
rhrowsize_1	set	22
lharray_1	set	24
rharray_1	set	28
result_1	set	32
lhitem_1	set	60
	jsl	~~pop_array
	sta	<L814+rharray_1
	stx	<L814+rharray_1+2
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L814+lhitem_1
	lda	<L814+lhitem_1
	cmp	#<$6
	bne	L815
	brl	L10572
L815:
	pea	#<$47
	pea	#4
	jsl	~~error
L10572:
	jsl	~~pop_array
	sta	<L814+lharray_1
	stx	<L814+lharray_1+2
	pei	<L814+rharray_1+2
	pei	<L814+rharray_1
	pei	<L814+lharray_1+2
	pei	<L814+lharray_1
	pea	#0
	clc
	tdc
	adc	#<L814+result_1
	pha
	jsl	~~check_arraytype
	pea	#0
	clc
	tdc
	adc	#<L814+result_1
	pha
	pea	#<$2
	jsl	~~make_array
	sta	<L814+base_1
	stx	<L814+base_1+2
	stz	<L814+rhrowsize_1
	stz	<L814+lhrowsize_1
	lda	[<L814+lharray_1]
	cmp	#<$1
	bne	L816
	brl	L10573
L816:
	ldy	#$a
	lda	[<L814+lharray_1],Y
	sta	<L814+lhrowsize_1
L10573:
	lda	[<L814+rharray_1]
	cmp	#<$1
	bne	L817
	brl	L10574
L817:
	ldy	#$a
	lda	[<L814+rharray_1],Y
	sta	<L814+rhrowsize_1
L10574:
	ldy	#$4
	lda	[<L814+lharray_1],Y
	sta	<L814+lhbase_1
	ldy	#$6
	lda	[<L814+lharray_1],Y
	sta	<L814+lhbase_1+2
	ldy	#$4
	lda	[<L814+rharray_1],Y
	sta	<L814+rhbase_1
	ldy	#$6
	lda	[<L814+rharray_1],Y
	sta	<L814+rhbase_1+2
	lda	[<L814+lharray_1]
	cmp	#<$1
	beq	L818
	brl	L10575
L818:
	stz	<L814+resindex_1
	brl	L10579
L10578:
	stz	<L814+sum_1
	stz	<L814+col_1
	brl	L10583
L10582:
	ldy	#$0
	lda	<L814+col_1
	bpl	L819
	dey
L819:
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
	lda	<L814+lhbase_1
	adc	<R0
	sta	<R2
	lda	<L814+lhbase_1+2
	adc	<R0+2
	sta	<R2+2
	lda	<L814+col_1
	ldx	<L814+rhrowsize_1
	xref	~~~mul
	jsl	~~~mul
	sta	<R3
	clc
	lda	<R3
	adc	<L814+resindex_1
	sta	<17
	ldy	#$0
	lda	<17
	bpl	L820
	dey
L820:
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
	lda	<L814+rhbase_1
	adc	<R0
	sta	<17
	lda	<L814+rhbase_1+2
	adc	<R0+2
	sta	<17+2
	lda	[<R2]
	tax
	lda	[<17]
	xref	~~~mul
	jsl	~~~mul
	sta	<R0
	clc
	lda	<R0
	adc	<L814+sum_1
	sta	<L814+sum_1
L10580:
	inc	<L814+col_1
L10583:
	sec
	lda	<L814+col_1
	ldy	#$8
	sbc	[<L814+lharray_1],Y
	bvs	L821
	eor	#$8000
L821:
	bmi	L822
	brl	L10582
L822:
L10581:
	ldy	#$0
	lda	<L814+resindex_1
	bpl	L823
	dey
L823:
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
	lda	<L814+base_1
	adc	<R0
	sta	<R2
	lda	<L814+base_1+2
	adc	<R0+2
	sta	<R2+2
	lda	<L814+sum_1
	sta	[<R2]
L10576:
	inc	<L814+resindex_1
L10579:
	sec
	lda	<L814+resindex_1
	sbc	<L814+result_1+8
	bvs	L824
	eor	#$8000
L824:
	bmi	L825
	brl	L10578
L825:
L10577:
	brl	L10584
L10575:
	lda	[<L814+rharray_1]
	cmp	#<$1
	beq	L826
	brl	L10585
L826:
	stz	<L814+resindex_1
	brl	L10589
L10588:
lhcol_2	set	62
	stz	<L814+lhcol_2
	stz	<L814+sum_1
	stz	<L814+col_1
	brl	L10593
L10592:
	ldy	#$0
	lda	<L814+col_1
	bpl	L827
	dey
L827:
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
	lda	<L814+rhbase_1
	adc	<R0
	sta	<R2
	lda	<L814+rhbase_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L814+lhcol_2
	bpl	L828
	dey
L828:
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
	lda	<L814+lhbase_1
	adc	<R0
	sta	<17
	lda	<L814+lhbase_1+2
	adc	<R0+2
	sta	<17+2
	lda	[<R2]
	tax
	lda	[<17]
	xref	~~~mul
	jsl	~~~mul
	sta	<R0
	clc
	lda	<R0
	adc	<L814+sum_1
	sta	<L814+sum_1
	inc	<L814+lhcol_2
L10590:
	inc	<L814+col_1
L10593:
	sec
	lda	<L814+col_1
	ldy	#$8
	sbc	[<L814+rharray_1],Y
	bvs	L829
	eor	#$8000
L829:
	bmi	L830
	brl	L10592
L830:
L10591:
	ldy	#$0
	lda	<L814+resindex_1
	bpl	L831
	dey
L831:
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
	lda	<L814+base_1
	adc	<R0
	sta	<R2
	lda	<L814+base_1+2
	adc	<R0+2
	sta	<R2+2
	lda	<L814+sum_1
	sta	[<R2]
L10586:
	inc	<L814+resindex_1
L10589:
	sec
	lda	<L814+resindex_1
	sbc	<L814+result_1+8
	bvs	L832
	eor	#$8000
L832:
	bmi	L833
	brl	L10588
L833:
L10587:
	brl	L10594
L10585:
	stz	<L814+resindex_1
	stz	<L814+row_1
	brl	L10598
L10597:
	stz	<L814+col_1
	brl	L10602
L10601:
lhcol_3	set	62
	stz	<L814+sum_1
	stz	<L814+lhcol_3
	brl	L10606
L10605:
	lda	<L814+rhrowsize_1
	ldx	<L814+lhcol_3
	xref	~~~mul
	jsl	~~~mul
	sta	<R1
	clc
	lda	<R1
	adc	<L814+col_1
	sta	<R2
	ldy	#$0
	lda	<R2
	bpl	L834
	dey
L834:
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
	lda	<L814+rhbase_1
	adc	<R0
	sta	<R2
	lda	<L814+rhbase_1+2
	adc	<R0+2
	sta	<R2+2
	lda	<L814+lhrowsize_1
	ldx	<L814+row_1
	xref	~~~mul
	jsl	~~~mul
	sta	<R3
	clc
	lda	<R3
	adc	<L814+lhcol_3
	sta	<17
	ldy	#$0
	lda	<17
	bpl	L835
	dey
L835:
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
	lda	<L814+lhbase_1
	adc	<R0
	sta	<17
	lda	<L814+lhbase_1+2
	adc	<R0+2
	sta	<17+2
	lda	[<R2]
	tax
	lda	[<17]
	xref	~~~mul
	jsl	~~~mul
	sta	<R0
	clc
	lda	<R0
	adc	<L814+sum_1
	sta	<L814+sum_1
L10603:
	inc	<L814+lhcol_3
L10606:
	sec
	lda	<L814+lhcol_3
	ldy	#$a
	sbc	[<L814+lharray_1],Y
	bvs	L836
	eor	#$8000
L836:
	bmi	L837
	brl	L10605
L837:
L10604:
	ldy	#$0
	lda	<L814+resindex_1
	bpl	L838
	dey
L838:
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
	lda	<L814+base_1
	adc	<R0
	sta	<R2
	lda	<L814+base_1+2
	adc	<R0+2
	sta	<R2+2
	lda	<L814+sum_1
	sta	[<R2]
	inc	<L814+resindex_1
L10599:
	inc	<L814+col_1
L10602:
	sec
	lda	<L814+col_1
	sbc	<L814+result_1+10
	bvs	L839
	eor	#$8000
L839:
	bmi	L840
	brl	L10601
L840:
L10600:
L10595:
	inc	<L814+row_1
L10598:
	sec
	lda	<L814+row_1
	sbc	<L814+result_1+8
	bvs	L841
	eor	#$8000
L841:
	bmi	L842
	brl	L10597
L842:
L10596:
L10594:
L10584:
L843:
	pld
	tsc
	clc
	adc	#L813
	tcs
	rtl
L813	equ	84
L814	equ	21
	ends
	efunc
	code
	func
~~eval_fmmul:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L844
	tcs
	phd
	tcd
	udata
L10607:
	ds	4
	ends
resindex_1	set	0
row_1	set	2
col_1	set	4
lhrowsize_1	set	6
rhrowsize_1	set	8
base_1	set	10
lhbase_1	set	14
rhbase_1	set	18
lharray_1	set	22
rharray_1	set	26
result_1	set	30
lhitem_1	set	58
	jsl	~~pop_array
	sta	<L845+rharray_1
	stx	<L845+rharray_1+2
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L845+lhitem_1
	lda	<L845+lhitem_1
	cmp	#<$8
	bne	L846
	brl	L10608
L846:
	pea	#<$48
	pea	#4
	jsl	~~error
L10608:
	jsl	~~pop_array
	sta	<L845+lharray_1
	stx	<L845+lharray_1+2
	pei	<L845+rharray_1+2
	pei	<L845+rharray_1
	pei	<L845+lharray_1+2
	pei	<L845+lharray_1
	pea	#0
	clc
	tdc
	adc	#<L845+result_1
	pha
	jsl	~~check_arraytype
	pea	#0
	clc
	tdc
	adc	#<L845+result_1
	pha
	pea	#<$3
	jsl	~~make_array
	sta	<L845+base_1
	stx	<L845+base_1+2
	stz	<L845+rhrowsize_1
	stz	<L845+lhrowsize_1
	lda	[<L845+lharray_1]
	cmp	#<$1
	bne	L847
	brl	L10609
L847:
	ldy	#$a
	lda	[<L845+lharray_1],Y
	sta	<L845+lhrowsize_1
L10609:
	lda	[<L845+rharray_1]
	cmp	#<$1
	bne	L848
	brl	L10610
L848:
	ldy	#$a
	lda	[<L845+rharray_1],Y
	sta	<L845+rhrowsize_1
L10610:
	ldy	#$4
	lda	[<L845+lharray_1],Y
	sta	<L845+lhbase_1
	ldy	#$6
	lda	[<L845+lharray_1],Y
	sta	<L845+lhbase_1+2
	ldy	#$4
	lda	[<L845+rharray_1],Y
	sta	<L845+rhbase_1
	ldy	#$6
	lda	[<L845+rharray_1],Y
	sta	<L845+rhbase_1+2
	lda	[<L845+lharray_1]
	cmp	#<$1
	beq	L849
	brl	L10611
L849:
	stz	<L845+resindex_1
	brl	L10615
L10614:
	lda	#$0
	sta	|L10607
	lda	#$0
	sta	|L10607+2
	stz	<L845+col_1
	brl	L10619
L10618:
	lda	|L10607+2
	pha
	lda	|L10607
	pha
	ldy	#$0
	lda	<L845+col_1
	bpl	L850
	dey
L850:
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
	lda	<L845+lhbase_1
	adc	<R0
	sta	<R2
	lda	<L845+lhbase_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$2
	lda	[<R2],Y
	pha
	lda	[<R2]
	pha
	lda	<L845+col_1
	ldx	<L845+rhrowsize_1
	xref	~~~mul
	jsl	~~~mul
	sta	<R3
	clc
	lda	<R3
	adc	<L845+resindex_1
	sta	<17
	ldy	#$0
	lda	<17
	bpl	L851
	dey
L851:
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
	lda	<L845+rhbase_1
	adc	<R0
	sta	<17
	lda	<L845+rhbase_1+2
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
	sta	|L10607
	pla
	sta	|L10607+2
L10616:
	inc	<L845+col_1
L10619:
	sec
	lda	<L845+col_1
	ldy	#$8
	sbc	[<L845+lharray_1],Y
	bvs	L852
	eor	#$8000
L852:
	bmi	L853
	brl	L10618
L853:
L10617:
	ldy	#$0
	lda	<L845+resindex_1
	bpl	L854
	dey
L854:
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
	lda	<L845+base_1
	adc	<R0
	sta	<R2
	lda	<L845+base_1+2
	adc	<R0+2
	sta	<R2+2
	lda	|L10607
	sta	[<R2]
	lda	|L10607+2
	ldy	#$2
	sta	[<R2],Y
L10612:
	inc	<L845+resindex_1
L10615:
	sec
	lda	<L845+resindex_1
	sbc	<L845+result_1+8
	bvs	L855
	eor	#$8000
L855:
	bmi	L856
	brl	L10614
L856:
L10613:
	brl	L10620
L10611:
	lda	[<L845+rharray_1]
	cmp	#<$1
	beq	L857
	brl	L10621
L857:
	stz	<L845+resindex_1
	brl	L10625
L10624:
lhcol_2	set	60
	stz	<L845+lhcol_2
	lda	#$0
	sta	|L10607
	lda	#$0
	sta	|L10607+2
	stz	<L845+col_1
	brl	L10629
L10628:
	lda	|L10607+2
	pha
	lda	|L10607
	pha
	ldy	#$0
	lda	<L845+col_1
	bpl	L858
	dey
L858:
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
	lda	<L845+rhbase_1
	adc	<R0
	sta	<R2
	lda	<L845+rhbase_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$2
	lda	[<R2],Y
	pha
	lda	[<R2]
	pha
	ldy	#$0
	lda	<L845+lhcol_2
	bpl	L859
	dey
L859:
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
	lda	<L845+lhbase_1
	adc	<R0
	sta	<17
	lda	<L845+lhbase_1+2
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
	sta	|L10607
	pla
	sta	|L10607+2
	inc	<L845+lhcol_2
L10626:
	inc	<L845+col_1
L10629:
	sec
	lda	<L845+col_1
	ldy	#$8
	sbc	[<L845+rharray_1],Y
	bvs	L860
	eor	#$8000
L860:
	bmi	L861
	brl	L10628
L861:
L10627:
	ldy	#$0
	lda	<L845+resindex_1
	bpl	L862
	dey
L862:
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
	lda	<L845+base_1
	adc	<R0
	sta	<R2
	lda	<L845+base_1+2
	adc	<R0+2
	sta	<R2+2
	lda	|L10607
	sta	[<R2]
	lda	|L10607+2
	ldy	#$2
	sta	[<R2],Y
L10622:
	inc	<L845+resindex_1
L10625:
	sec
	lda	<L845+resindex_1
	sbc	<L845+result_1+8
	bvs	L863
	eor	#$8000
L863:
	bmi	L864
	brl	L10624
L864:
L10623:
	brl	L10630
L10621:
	stz	<L845+resindex_1
	stz	<L845+row_1
	brl	L10634
L10633:
	stz	<L845+col_1
	brl	L10638
L10637:
lhcol_3	set	60
	lda	#$0
	sta	|L10607
	lda	#$0
	sta	|L10607+2
	stz	<L845+lhcol_3
	brl	L10642
L10641:
	lda	|L10607+2
	pha
	lda	|L10607
	pha
	lda	<L845+rhrowsize_1
	ldx	<L845+lhcol_3
	xref	~~~mul
	jsl	~~~mul
	sta	<R1
	clc
	lda	<R1
	adc	<L845+col_1
	sta	<R2
	ldy	#$0
	lda	<R2
	bpl	L865
	dey
L865:
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
	lda	<L845+rhbase_1
	adc	<R0
	sta	<R2
	lda	<L845+rhbase_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$2
	lda	[<R2],Y
	pha
	lda	[<R2]
	pha
	lda	<L845+lhrowsize_1
	ldx	<L845+row_1
	xref	~~~mul
	jsl	~~~mul
	sta	<R3
	clc
	lda	<R3
	adc	<L845+lhcol_3
	sta	<17
	ldy	#$0
	lda	<17
	bpl	L866
	dey
L866:
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
	lda	<L845+lhbase_1
	adc	<R0
	sta	<17
	lda	<L845+lhbase_1+2
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
	sta	|L10607
	pla
	sta	|L10607+2
L10639:
	inc	<L845+lhcol_3
L10642:
	sec
	lda	<L845+lhcol_3
	ldy	#$a
	sbc	[<L845+lharray_1],Y
	bvs	L867
	eor	#$8000
L867:
	bmi	L868
	brl	L10641
L868:
L10640:
	ldy	#$0
	lda	<L845+resindex_1
	bpl	L869
	dey
L869:
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
	lda	<L845+base_1
	adc	<R0
	sta	<R2
	lda	<L845+base_1+2
	adc	<R0+2
	sta	<R2+2
	lda	|L10607
	sta	[<R2]
	lda	|L10607+2
	ldy	#$2
	sta	[<R2],Y
	inc	<L845+resindex_1
L10635:
	inc	<L845+col_1
L10638:
	sec
	lda	<L845+col_1
	sbc	<L845+result_1+10
	bvs	L870
	eor	#$8000
L870:
	bmi	L871
	brl	L10637
L871:
L10636:
L10631:
	inc	<L845+row_1
L10634:
	sec
	lda	<L845+row_1
	sbc	<L845+result_1+8
	bvs	L872
	eor	#$8000
L872:
	bmi	L873
	brl	L10633
L873:
L10632:
L10630:
L10620:
L874:
	pld
	tsc
	clc
	adc	#L844
	tcs
	rtl
L844	equ	82
L845	equ	21
	ends
	efunc
	code
	func
~~eval_ivdiv:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L875
	tcs
	phd
	tcd
lhitem_1	set	0
rhint_1	set	2
	jsl	~~pop_int
	sta	<L876+rhint_1
	lda	<L876+rhint_1
	beq	L877
	brl	L10643
L877:
	pea	#<$37
	pea	#4
	jsl	~~error
L10643:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L876+lhitem_1
	lda	<L876+lhitem_1
	cmp	#<$2
	beq	L878
	brl	L10644
L878:
	ldy	#$0
	lda	<L876+rhint_1
	bpl	L879
	dey
L879:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L880
	dey
L880:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~fdiv
	jsl	~~~fdiv
	jsl	~~push_float
	brl	L10645
L10644:
	lda	<L876+lhitem_1
	cmp	#<$3
	beq	L881
	brl	L10646
L881:
	ldy	#$0
	lda	<L876+rhint_1
	bpl	L882
	dey
L882:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	phy
	phy
	jsl	~~pop_float
	xref	~~~fdiv
	jsl	~~~fdiv
	jsl	~~push_float
	brl	L10647
L10646:
	lda	<L876+lhitem_1
	cmp	#<$6
	bne	L884
	brl	L883
L884:
	lda	<L876+lhitem_1
	cmp	#<$8
	beq	L885
	brl	L10648
L885:
L883:
lharray_2	set	4
n_2	set	8
count_2	set	10
base_2	set	12
	jsl	~~pop_array
	sta	<L876+lharray_2
	stx	<L876+lharray_2+2
	ldy	#$2
	lda	[<L876+lharray_2],Y
	sta	<L876+count_2
	pei	<L876+lharray_2+2
	pei	<L876+lharray_2
	pea	#<$3
	jsl	~~make_array
	sta	<L876+base_2
	stx	<L876+base_2+2
	ldy	#$0
	lda	<L876+rhint_1
	bpl	L886
	dey
L886:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	pla
	sta	|~~floatvalue
	pla
	sta	|~~floatvalue+2
	lda	<L876+lhitem_1
	cmp	#<$6
	beq	L887
	brl	L10649
L887:
srce_3	set	16
	ldy	#$4
	lda	[<L876+lharray_2],Y
	sta	<L876+srce_3
	ldy	#$6
	lda	[<L876+lharray_2],Y
	sta	<L876+srce_3+2
	stz	<L876+n_2
	brl	L10653
L10652:
	ldy	#$0
	lda	<L876+n_2
	bpl	L888
	dey
L888:
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
	lda	<L876+base_2
	adc	<R0
	sta	<R2
	lda	<L876+base_2+2
	adc	<R0+2
	sta	<R2+2
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	ldy	#$0
	lda	<L876+n_2
	bpl	L889
	dey
L889:
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
	lda	<L876+srce_3
	adc	<R0
	sta	<17
	lda	<L876+srce_3+2
	adc	<R0+2
	sta	<17+2
	ldy	#$0
	lda	[<17]
	bpl	L890
	dey
L890:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~fdiv
	jsl	~~~fdiv
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10650:
	inc	<L876+n_2
L10653:
	sec
	lda	<L876+n_2
	sbc	<L876+count_2
	bvs	L891
	eor	#$8000
L891:
	bmi	L892
	brl	L10652
L892:
L10651:
	brl	L10654
L10649:
srce_4	set	16
	ldy	#$4
	lda	[<L876+lharray_2],Y
	sta	<L876+srce_4
	ldy	#$6
	lda	[<L876+lharray_2],Y
	sta	<L876+srce_4+2
	stz	<L876+n_2
	brl	L10658
L10657:
	ldy	#$0
	lda	<L876+n_2
	bpl	L893
	dey
L893:
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
	lda	<L876+base_2
	adc	<R0
	sta	<R2
	lda	<L876+base_2+2
	adc	<R0+2
	sta	<R2+2
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	ldy	#$0
	lda	<L876+n_2
	bpl	L894
	dey
L894:
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
	lda	<L876+srce_4
	adc	<R0
	sta	<17
	lda	<L876+srce_4+2
	adc	<R0+2
	sta	<17+2
	ldy	#$2
	lda	[<17],Y
	pha
	lda	[<17]
	pha
	xref	~~~fdiv
	jsl	~~~fdiv
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10655:
	inc	<L876+n_2
L10658:
	sec
	lda	<L876+n_2
	sbc	<L876+count_2
	bvs	L895
	eor	#$8000
L895:
	bmi	L896
	brl	L10657
L896:
L10656:
L10654:
	brl	L10659
L10648:
	lda	<L876+lhitem_1
	cmp	#<$9
	beq	L897
	brl	L10660
L897:
lharray_5	set	4
base_5	set	32
n_5	set	36
count_5	set	38
	jsl	~~pop_arraytemp
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L876+lharray_5
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$1c
	xref	~~~fmov
	jsl	~~~fmov
	lda	<L876+lharray_5+4
	sta	<L876+base_5
	lda	<L876+lharray_5+6
	sta	<L876+base_5+2
	lda	<L876+lharray_5+2
	sta	<L876+count_5
	ldy	#$0
	lda	<L876+rhint_1
	bpl	L898
	dey
L898:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	pla
	sta	|~~floatvalue
	pla
	sta	|~~floatvalue+2
	stz	<L876+n_5
	brl	L10664
L10663:
	ldy	#$0
	lda	<L876+n_5
	bpl	L899
	dey
L899:
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
	lda	<L876+base_5
	adc	<R0
	sta	<R2
	lda	<L876+base_5+2
	adc	<R0+2
	sta	<R2+2
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	ldy	#$2
	lda	[<R2],Y
	pha
	lda	[<R2]
	pha
	xref	~~~fdiv
	jsl	~~~fdiv
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10661:
	inc	<L876+n_5
L10664:
	sec
	lda	<L876+n_5
	sbc	<L876+count_5
	bvs	L900
	eor	#$8000
L900:
	bmi	L901
	brl	L10663
L901:
L10662:
	pea	#<$3
	pea	#0
	clc
	tdc
	adc	#<L876+lharray_5
	pha
	jsl	~~push_arraytemp
	brl	L10665
L10660:
	jsl	~~want_number
L10665:
L10659:
L10647:
L10645:
L902:
	pld
	tsc
	clc
	adc	#L875
	tcs
	rtl
L875	equ	60
L876	equ	21
	ends
	efunc
	code
	func
~~eval_fvdiv:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L903
	tcs
	phd
	tcd
lhitem_1	set	0
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
	xref	~~~dtst
	jsl	~~~dtst
	beq	L905
	brl	L10666
L905:
	pea	#<$37
	pea	#4
	jsl	~~error
L10666:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L904+lhitem_1
	lda	<L904+lhitem_1
	cmp	#<$2
	beq	L906
	brl	L10667
L906:
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L907
	dey
L907:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~fdiv
	jsl	~~~fdiv
	jsl	~~push_float
	brl	L10668
L10667:
	lda	<L904+lhitem_1
	cmp	#<$3
	beq	L908
	brl	L10669
L908:
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	phy
	phy
	jsl	~~pop_float
	xref	~~~fdiv
	jsl	~~~fdiv
	jsl	~~push_float
	brl	L10670
L10669:
	lda	<L904+lhitem_1
	cmp	#<$6
	bne	L910
	brl	L909
L910:
	lda	<L904+lhitem_1
	cmp	#<$8
	beq	L911
	brl	L10671
L911:
L909:
lharray_2	set	2
n_2	set	6
count_2	set	8
base_2	set	10
	jsl	~~pop_array
	sta	<L904+lharray_2
	stx	<L904+lharray_2+2
	ldy	#$2
	lda	[<L904+lharray_2],Y
	sta	<L904+count_2
	pei	<L904+lharray_2+2
	pei	<L904+lharray_2
	pea	#<$3
	jsl	~~make_array
	sta	<L904+base_2
	stx	<L904+base_2+2
	lda	<L904+lhitem_1
	cmp	#<$6
	beq	L912
	brl	L10672
L912:
srce_3	set	14
	ldy	#$4
	lda	[<L904+lharray_2],Y
	sta	<L904+srce_3
	ldy	#$6
	lda	[<L904+lharray_2],Y
	sta	<L904+srce_3+2
	stz	<L904+n_2
	brl	L10676
L10675:
	ldy	#$0
	lda	<L904+n_2
	bpl	L913
	dey
L913:
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
	lda	<L904+base_2
	adc	<R0
	sta	<R2
	lda	<L904+base_2+2
	adc	<R0+2
	sta	<R2+2
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	ldy	#$0
	lda	<L904+n_2
	bpl	L914
	dey
L914:
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
	lda	<L904+srce_3
	adc	<R0
	sta	<17
	lda	<L904+srce_3+2
	adc	<R0+2
	sta	<17+2
	ldy	#$0
	lda	[<17]
	bpl	L915
	dey
L915:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~fdiv
	jsl	~~~fdiv
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10673:
	inc	<L904+n_2
L10676:
	sec
	lda	<L904+n_2
	sbc	<L904+count_2
	bvs	L916
	eor	#$8000
L916:
	bmi	L917
	brl	L10675
L917:
L10674:
	brl	L10677
L10672:
srce_4	set	14
	ldy	#$4
	lda	[<L904+lharray_2],Y
	sta	<L904+srce_4
	ldy	#$6
	lda	[<L904+lharray_2],Y
	sta	<L904+srce_4+2
	stz	<L904+n_2
	brl	L10681
L10680:
	ldy	#$0
	lda	<L904+n_2
	bpl	L918
	dey
L918:
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
	lda	<L904+base_2
	adc	<R0
	sta	<R2
	lda	<L904+base_2+2
	adc	<R0+2
	sta	<R2+2
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	ldy	#$0
	lda	<L904+n_2
	bpl	L919
	dey
L919:
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
	lda	<L904+srce_4
	adc	<R0
	sta	<17
	lda	<L904+srce_4+2
	adc	<R0+2
	sta	<17+2
	ldy	#$2
	lda	[<17],Y
	pha
	lda	[<17]
	pha
	xref	~~~fdiv
	jsl	~~~fdiv
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10678:
	inc	<L904+n_2
L10681:
	sec
	lda	<L904+n_2
	sbc	<L904+count_2
	bvs	L920
	eor	#$8000
L920:
	bmi	L921
	brl	L10680
L921:
L10679:
L10677:
	brl	L10682
L10671:
	lda	<L904+lhitem_1
	cmp	#<$9
	beq	L922
	brl	L10683
L922:
lharray_5	set	2
base_5	set	30
n_5	set	34
count_5	set	36
	jsl	~~pop_arraytemp
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L904+lharray_5
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$1c
	xref	~~~fmov
	jsl	~~~fmov
	lda	<L904+lharray_5+4
	sta	<L904+base_5
	lda	<L904+lharray_5+6
	sta	<L904+base_5+2
	lda	<L904+lharray_5+2
	sta	<L904+count_5
	stz	<L904+n_5
	brl	L10687
L10686:
	ldy	#$0
	lda	<L904+n_5
	bpl	L923
	dey
L923:
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
	lda	<L904+base_5
	adc	<R0
	sta	<R2
	lda	<L904+base_5+2
	adc	<R0+2
	sta	<R2+2
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	ldy	#$2
	lda	[<R2],Y
	pha
	lda	[<R2]
	pha
	xref	~~~fdiv
	jsl	~~~fdiv
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10684:
	inc	<L904+n_5
L10687:
	sec
	lda	<L904+n_5
	sbc	<L904+count_5
	bvs	L924
	eor	#$8000
L924:
	bmi	L925
	brl	L10686
L925:
L10685:
	pea	#<$3
	pea	#0
	clc
	tdc
	adc	#<L904+lharray_5
	pha
	jsl	~~push_arraytemp
	brl	L10688
L10683:
	jsl	~~want_number
L10688:
L10682:
L10670:
L10668:
L926:
	pld
	tsc
	clc
	adc	#L903
	tcs
	rtl
L903	equ	58
L904	equ	21
	ends
	efunc
	code
	func
~~eval_iadiv:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L927
	tcs
	phd
	tcd
lhitem_1	set	0
rharray_1	set	2
n_1	set	6
count_1	set	8
rhsrce_1	set	10
base_1	set	14
	jsl	~~pop_array
	sta	<L928+rharray_1
	stx	<L928+rharray_1+2
	ldy	#$2
	lda	[<L928+rharray_1],Y
	sta	<L928+count_1
	ldy	#$4
	lda	[<L928+rharray_1],Y
	sta	<L928+rhsrce_1
	ldy	#$6
	lda	[<L928+rharray_1],Y
	sta	<L928+rhsrce_1+2
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L928+lhitem_1
	lda	<L928+lhitem_1
	cmp	#<$2
	beq	L929
	brl	L10689
L929:
base_2	set	18
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L930
	dey
L930:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	pla
	sta	|~~floatvalue
	pla
	sta	|~~floatvalue+2
	pei	<L928+rharray_1+2
	pei	<L928+rharray_1
	pea	#<$3
	jsl	~~make_array
	sta	<L928+base_2
	stx	<L928+base_2+2
	stz	<L928+n_1
	brl	L10693
L10692:
	ldy	#$0
	lda	<L928+n_1
	bpl	L931
	dey
L931:
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
	lda	<L928+rhsrce_1
	adc	<R0
	sta	<R2
	lda	<L928+rhsrce_1+2
	adc	<R0+2
	sta	<R2+2
	lda	[<R2]
	beq	L932
	brl	L10694
L932:
	pea	#<$37
	pea	#4
	jsl	~~error
L10694:
	ldy	#$0
	lda	<L928+n_1
	bpl	L933
	dey
L933:
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
	lda	<L928+base_2
	adc	<R0
	sta	<R2
	lda	<L928+base_2+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L928+n_1
	bpl	L934
	dey
L934:
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
	lda	<L928+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L928+rhsrce_1+2
	adc	<R0+2
	sta	<17+2
	ldy	#$0
	lda	[<17]
	bpl	L935
	dey
L935:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	xref	~~~fdiv
	jsl	~~~fdiv
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10690:
	inc	<L928+n_1
L10693:
	sec
	lda	<L928+n_1
	sbc	<L928+count_1
	bvs	L936
	eor	#$8000
L936:
	bmi	L937
	brl	L10692
L937:
L10691:
	brl	L10695
L10689:
	lda	<L928+lhitem_1
	cmp	#<$3
	beq	L938
	brl	L10696
L938:
	phy
	phy
	jsl	~~pop_float
	pla
	sta	|~~floatvalue
	pla
	sta	|~~floatvalue+2
	pei	<L928+rharray_1+2
	pei	<L928+rharray_1
	pea	#<$3
	jsl	~~make_array
	sta	<L928+base_1
	stx	<L928+base_1+2
	stz	<L928+n_1
	brl	L10700
L10699:
	ldy	#$0
	lda	<L928+n_1
	bpl	L939
	dey
L939:
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
	lda	<L928+rhsrce_1
	adc	<R0
	sta	<R2
	lda	<L928+rhsrce_1+2
	adc	<R0+2
	sta	<R2+2
	lda	[<R2]
	beq	L940
	brl	L10701
L940:
	pea	#<$37
	pea	#4
	jsl	~~error
L10701:
	ldy	#$0
	lda	<L928+n_1
	bpl	L941
	dey
L941:
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
	lda	<L928+base_1
	adc	<R0
	sta	<R2
	lda	<L928+base_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L928+n_1
	bpl	L942
	dey
L942:
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
	lda	<L928+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L928+rhsrce_1+2
	adc	<R0+2
	sta	<17+2
	ldy	#$0
	lda	[<17]
	bpl	L943
	dey
L943:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	xref	~~~fdiv
	jsl	~~~fdiv
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10697:
	inc	<L928+n_1
L10700:
	sec
	lda	<L928+n_1
	sbc	<L928+count_1
	bvs	L944
	eor	#$8000
L944:
	bmi	L945
	brl	L10699
L945:
L10698:
	brl	L10702
L10696:
	lda	<L928+lhitem_1
	cmp	#<$6
	beq	L946
	brl	L10703
L946:
lhsrce_3	set	18
lharray_3	set	22
	jsl	~~pop_array
	sta	<L928+lharray_3
	stx	<L928+lharray_3+2
	pei	<L928+rharray_1+2
	pei	<L928+rharray_1
	pei	<L928+lharray_3+2
	pei	<L928+lharray_3
	jsl	~~check_arrays
	and	#$ff
	beq	L947
	brl	L10704
L947:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10704:
	ldy	#$4
	lda	[<L928+lharray_3],Y
	sta	<L928+lhsrce_3
	ldy	#$6
	lda	[<L928+lharray_3],Y
	sta	<L928+lhsrce_3+2
	pei	<L928+rharray_1+2
	pei	<L928+rharray_1
	pea	#<$3
	jsl	~~make_array
	sta	<L928+base_1
	stx	<L928+base_1+2
	stz	<L928+n_1
	brl	L10708
L10707:
	ldy	#$0
	lda	<L928+n_1
	bpl	L948
	dey
L948:
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
	lda	<L928+rhsrce_1
	adc	<R0
	sta	<R2
	lda	<L928+rhsrce_1+2
	adc	<R0+2
	sta	<R2+2
	lda	[<R2]
	beq	L949
	brl	L10709
L949:
	pea	#<$37
	pea	#4
	jsl	~~error
L10709:
	ldy	#$0
	lda	<L928+n_1
	bpl	L950
	dey
L950:
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
	lda	<L928+base_1
	adc	<R0
	sta	<R2
	lda	<L928+base_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L928+n_1
	bpl	L951
	dey
L951:
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
	lda	<L928+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L928+rhsrce_1+2
	adc	<R0+2
	sta	<17+2
	ldy	#$0
	lda	[<17]
	bpl	L952
	dey
L952:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	ldy	#$0
	lda	<L928+n_1
	bpl	L953
	dey
L953:
	sta	<17
	sty	<17+2
	pei	<17+2
	pei	<17
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	lda	<L928+lhsrce_3
	adc	<R0
	sta	<21
	lda	<L928+lhsrce_3+2
	adc	<R0+2
	sta	<21+2
	ldy	#$0
	lda	[<21]
	bpl	L954
	dey
L954:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~fdiv
	jsl	~~~fdiv
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10705:
	inc	<L928+n_1
L10708:
	sec
	lda	<L928+n_1
	sbc	<L928+count_1
	bvs	L955
	eor	#$8000
L955:
	bmi	L956
	brl	L10707
L956:
L10706:
	brl	L10710
L10703:
	lda	<L928+lhitem_1
	cmp	#<$8
	beq	L957
	brl	L10711
L957:
lhsrce_4	set	18
lharray_4	set	22
	jsl	~~pop_array
	sta	<L928+lharray_4
	stx	<L928+lharray_4+2
	pei	<L928+rharray_1+2
	pei	<L928+rharray_1
	pei	<L928+lharray_4+2
	pei	<L928+lharray_4
	jsl	~~check_arrays
	and	#$ff
	beq	L958
	brl	L10712
L958:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10712:
	pei	<L928+rharray_1+2
	pei	<L928+rharray_1
	pea	#<$3
	jsl	~~make_array
	sta	<L928+base_1
	stx	<L928+base_1+2
	ldy	#$4
	lda	[<L928+lharray_4],Y
	sta	<L928+lhsrce_4
	ldy	#$6
	lda	[<L928+lharray_4],Y
	sta	<L928+lhsrce_4+2
	stz	<L928+n_1
	brl	L10716
L10715:
	ldy	#$0
	lda	<L928+n_1
	bpl	L959
	dey
L959:
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
	lda	<L928+rhsrce_1
	adc	<R0
	sta	<R2
	lda	<L928+rhsrce_1+2
	adc	<R0+2
	sta	<R2+2
	lda	[<R2]
	beq	L960
	brl	L10717
L960:
	pea	#<$37
	pea	#4
	jsl	~~error
L10717:
	ldy	#$0
	lda	<L928+n_1
	bpl	L961
	dey
L961:
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
	lda	<L928+base_1
	adc	<R0
	sta	<R2
	lda	<L928+base_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L928+n_1
	bpl	L962
	dey
L962:
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
	lda	<L928+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L928+rhsrce_1+2
	adc	<R0+2
	sta	<17+2
	ldy	#$0
	lda	[<17]
	bpl	L963
	dey
L963:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	ldy	#$0
	lda	<L928+n_1
	bpl	L964
	dey
L964:
	sta	<17
	sty	<17+2
	pei	<17+2
	pei	<17
	lda	#$2
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	lda	<L928+lhsrce_4
	adc	<R0
	sta	<21
	lda	<L928+lhsrce_4+2
	adc	<R0+2
	sta	<21+2
	ldy	#$2
	lda	[<21],Y
	pha
	lda	[<21]
	pha
	xref	~~~fdiv
	jsl	~~~fdiv
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10713:
	inc	<L928+n_1
L10716:
	sec
	lda	<L928+n_1
	sbc	<L928+count_1
	bvs	L965
	eor	#$8000
L965:
	bmi	L966
	brl	L10715
L966:
L10714:
	brl	L10718
L10711:
	lda	<L928+lhitem_1
	cmp	#<$9
	beq	L967
	brl	L10719
L967:
lhsrce_5	set	18
lharray_5	set	22
	jsl	~~pop_arraytemp
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L928+lharray_5
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$1c
	xref	~~~fmov
	jsl	~~~fmov
	pei	<L928+rharray_1+2
	pei	<L928+rharray_1
	pea	#0
	clc
	tdc
	adc	#<L928+lharray_5
	pha
	jsl	~~check_arrays
	and	#$ff
	beq	L968
	brl	L10720
L968:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10720:
	lda	<L928+lharray_5+4
	sta	<L928+lhsrce_5
	lda	<L928+lharray_5+6
	sta	<L928+lhsrce_5+2
	stz	<L928+n_1
	brl	L10724
L10723:
	ldy	#$0
	lda	<L928+n_1
	bpl	L969
	dey
L969:
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
	lda	<L928+rhsrce_1
	adc	<R0
	sta	<R2
	lda	<L928+rhsrce_1+2
	adc	<R0+2
	sta	<R2+2
	lda	[<R2]
	beq	L970
	brl	L10725
L970:
	pea	#<$37
	pea	#4
	jsl	~~error
L10725:
	ldy	#$0
	lda	<L928+n_1
	bpl	L971
	dey
L971:
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
	lda	<L928+lhsrce_5
	adc	<R0
	sta	<R2
	lda	<L928+lhsrce_5+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L928+n_1
	bpl	L972
	dey
L972:
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
	lda	<L928+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L928+rhsrce_1+2
	adc	<R0+2
	sta	<17+2
	ldy	#$0
	lda	[<17]
	bpl	L973
	dey
L973:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	ldy	#$2
	lda	[<R2],Y
	pha
	lda	[<R2]
	pha
	xref	~~~fdiv
	jsl	~~~fdiv
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10721:
	inc	<L928+n_1
L10724:
	sec
	lda	<L928+n_1
	sbc	<L928+count_1
	bvs	L974
	eor	#$8000
L974:
	bmi	L975
	brl	L10723
L975:
L10722:
	pea	#<$3
	pea	#0
	clc
	tdc
	adc	#<L928+lharray_5
	pha
	jsl	~~push_arraytemp
	brl	L10726
L10719:
	jsl	~~want_number
L10726:
L10718:
L10710:
L10702:
L10695:
L976:
	pld
	tsc
	clc
	adc	#L927
	tcs
	rtl
L927	equ	74
L928	equ	25
	ends
	efunc
	code
	func
~~eval_fadiv:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L977
	tcs
	phd
	tcd
lhitem_1	set	0
rharray_1	set	2
n_1	set	6
count_1	set	8
base_1	set	10
rhsrce_1	set	14
	jsl	~~pop_array
	sta	<L978+rharray_1
	stx	<L978+rharray_1+2
	ldy	#$2
	lda	[<L978+rharray_1],Y
	sta	<L978+count_1
	ldy	#$4
	lda	[<L978+rharray_1],Y
	sta	<L978+rhsrce_1
	ldy	#$6
	lda	[<L978+rharray_1],Y
	sta	<L978+rhsrce_1+2
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L978+lhitem_1
	lda	<L978+lhitem_1
	cmp	#<$2
	bne	L980
	brl	L979
L980:
	lda	<L978+lhitem_1
	cmp	#<$3
	beq	L981
	brl	L10727
L981:
L979:
	lda	<L978+lhitem_1
	cmp	#<$2
	beq	L983
	brl	L982
L983:
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L984
	dey
L984:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	bra	L985
L982:
	phy
	phy
	jsl	~~pop_float
L985:
	pla
	sta	|~~floatvalue
	pla
	sta	|~~floatvalue+2
	pei	<L978+rharray_1+2
	pei	<L978+rharray_1
	pea	#<$3
	jsl	~~make_array
	sta	<L978+base_1
	stx	<L978+base_1+2
	stz	<L978+n_1
	brl	L10731
L10730:
	ldy	#$0
	lda	<L978+n_1
	bpl	L986
	dey
L986:
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
	lda	<L978+rhsrce_1
	adc	<R0
	sta	<R2
	lda	<L978+rhsrce_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$2
	lda	[<R2],Y
	pha
	lda	[<R2]
	pha
	xref	~~~ftod
	jsl	~~~ftod
	xref	~~~dtst
	jsl	~~~dtst
	beq	L987
	brl	L10732
L987:
	pea	#<$37
	pea	#4
	jsl	~~error
L10732:
	ldy	#$0
	lda	<L978+n_1
	bpl	L988
	dey
L988:
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
	lda	<L978+base_1
	adc	<R0
	sta	<R2
	lda	<L978+base_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L978+n_1
	bpl	L989
	dey
L989:
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
	lda	<L978+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L978+rhsrce_1+2
	adc	<R0+2
	sta	<17+2
	ldy	#$2
	lda	[<17],Y
	pha
	lda	[<17]
	pha
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	xref	~~~fdiv
	jsl	~~~fdiv
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10728:
	inc	<L978+n_1
L10731:
	sec
	lda	<L978+n_1
	sbc	<L978+count_1
	bvs	L990
	eor	#$8000
L990:
	bmi	L991
	brl	L10730
L991:
L10729:
	brl	L10733
L10727:
	lda	<L978+lhitem_1
	cmp	#<$6
	beq	L992
	brl	L10734
L992:
lhsrce_2	set	18
lharray_2	set	22
	jsl	~~pop_array
	sta	<L978+lharray_2
	stx	<L978+lharray_2+2
	pei	<L978+rharray_1+2
	pei	<L978+rharray_1
	pei	<L978+lharray_2+2
	pei	<L978+lharray_2
	jsl	~~check_arrays
	and	#$ff
	beq	L993
	brl	L10735
L993:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10735:
	pei	<L978+rharray_1+2
	pei	<L978+rharray_1
	pea	#<$3
	jsl	~~make_array
	sta	<L978+base_1
	stx	<L978+base_1+2
	ldy	#$4
	lda	[<L978+lharray_2],Y
	sta	<L978+lhsrce_2
	ldy	#$6
	lda	[<L978+lharray_2],Y
	sta	<L978+lhsrce_2+2
	stz	<L978+n_1
	brl	L10739
L10738:
	ldy	#$0
	lda	<L978+n_1
	bpl	L994
	dey
L994:
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
	lda	<L978+rhsrce_1
	adc	<R0
	sta	<R2
	lda	<L978+rhsrce_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$2
	lda	[<R2],Y
	pha
	lda	[<R2]
	pha
	xref	~~~ftod
	jsl	~~~ftod
	xref	~~~dtst
	jsl	~~~dtst
	beq	L995
	brl	L10740
L995:
	pea	#<$37
	pea	#4
	jsl	~~error
L10740:
	ldy	#$0
	lda	<L978+n_1
	bpl	L996
	dey
L996:
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
	lda	<L978+base_1
	adc	<R0
	sta	<R2
	lda	<L978+base_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L978+n_1
	bpl	L997
	dey
L997:
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
	lda	<L978+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L978+rhsrce_1+2
	adc	<R0+2
	sta	<17+2
	ldy	#$2
	lda	[<17],Y
	pha
	lda	[<17]
	pha
	ldy	#$0
	lda	<L978+n_1
	bpl	L998
	dey
L998:
	sta	<21
	sty	<21+2
	pei	<21+2
	pei	<21
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	lda	<L978+lhsrce_2
	adc	<R0
	sta	<25
	lda	<L978+lhsrce_2+2
	adc	<R0+2
	sta	<25+2
	ldy	#$0
	lda	[<25]
	bpl	L999
	dey
L999:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~fdiv
	jsl	~~~fdiv
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10736:
	inc	<L978+n_1
L10739:
	sec
	lda	<L978+n_1
	sbc	<L978+count_1
	bvs	L1000
	eor	#$8000
L1000:
	bmi	L1001
	brl	L10738
L1001:
L10737:
	brl	L10741
L10734:
	lda	<L978+lhitem_1
	cmp	#<$8
	beq	L1002
	brl	L10742
L1002:
lhsrce_3	set	18
lharray_3	set	22
	jsl	~~pop_array
	sta	<L978+lharray_3
	stx	<L978+lharray_3+2
	pei	<L978+rharray_1+2
	pei	<L978+rharray_1
	pei	<L978+lharray_3+2
	pei	<L978+lharray_3
	jsl	~~check_arrays
	and	#$ff
	beq	L1003
	brl	L10743
L1003:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10743:
	pei	<L978+rharray_1+2
	pei	<L978+rharray_1
	pea	#<$3
	jsl	~~make_array
	sta	<L978+base_1
	stx	<L978+base_1+2
	ldy	#$4
	lda	[<L978+lharray_3],Y
	sta	<L978+lhsrce_3
	ldy	#$6
	lda	[<L978+lharray_3],Y
	sta	<L978+lhsrce_3+2
	stz	<L978+n_1
	brl	L10747
L10746:
	ldy	#$0
	lda	<L978+n_1
	bpl	L1004
	dey
L1004:
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
	lda	<L978+rhsrce_1
	adc	<R0
	sta	<R2
	lda	<L978+rhsrce_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$2
	lda	[<R2],Y
	pha
	lda	[<R2]
	pha
	xref	~~~ftod
	jsl	~~~ftod
	xref	~~~dtst
	jsl	~~~dtst
	beq	L1005
	brl	L10748
L1005:
	pea	#<$37
	pea	#4
	jsl	~~error
L10748:
	ldy	#$0
	lda	<L978+n_1
	bpl	L1006
	dey
L1006:
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
	lda	<L978+base_1
	adc	<R0
	sta	<R2
	lda	<L978+base_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L978+n_1
	bpl	L1007
	dey
L1007:
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
	lda	<L978+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L978+rhsrce_1+2
	adc	<R0+2
	sta	<17+2
	ldy	#$2
	lda	[<17],Y
	pha
	lda	[<17]
	pha
	ldy	#$0
	lda	<L978+n_1
	bpl	L1008
	dey
L1008:
	sta	<21
	sty	<21+2
	pei	<21+2
	pei	<21
	lda	#$2
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	lda	<L978+lhsrce_3
	adc	<R0
	sta	<25
	lda	<L978+lhsrce_3+2
	adc	<R0+2
	sta	<25+2
	ldy	#$2
	lda	[<25],Y
	pha
	lda	[<25]
	pha
	xref	~~~fdiv
	jsl	~~~fdiv
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10744:
	inc	<L978+n_1
L10747:
	sec
	lda	<L978+n_1
	sbc	<L978+count_1
	bvs	L1009
	eor	#$8000
L1009:
	bmi	L1010
	brl	L10746
L1010:
L10745:
	brl	L10749
L10742:
	lda	<L978+lhitem_1
	cmp	#<$9
	beq	L1011
	brl	L10750
L1011:
lhsrce_4	set	18
lharray_4	set	22
	jsl	~~pop_arraytemp
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L978+lharray_4
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$1c
	xref	~~~fmov
	jsl	~~~fmov
	pei	<L978+rharray_1+2
	pei	<L978+rharray_1
	pea	#0
	clc
	tdc
	adc	#<L978+lharray_4
	pha
	jsl	~~check_arrays
	and	#$ff
	beq	L1012
	brl	L10751
L1012:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10751:
	lda	<L978+lharray_4+4
	sta	<L978+lhsrce_4
	lda	<L978+lharray_4+6
	sta	<L978+lhsrce_4+2
	stz	<L978+n_1
	brl	L10755
L10754:
	ldy	#$0
	lda	<L978+n_1
	bpl	L1013
	dey
L1013:
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
	lda	<L978+rhsrce_1
	adc	<R0
	sta	<R2
	lda	<L978+rhsrce_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$2
	lda	[<R2],Y
	pha
	lda	[<R2]
	pha
	xref	~~~ftod
	jsl	~~~ftod
	xref	~~~dtst
	jsl	~~~dtst
	beq	L1014
	brl	L10756
L1014:
	pea	#<$37
	pea	#4
	jsl	~~error
L10756:
	ldy	#$0
	lda	<L978+n_1
	bpl	L1015
	dey
L1015:
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
	lda	<L978+lhsrce_4
	adc	<R0
	sta	<R2
	lda	<L978+lhsrce_4+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L978+n_1
	bpl	L1016
	dey
L1016:
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
	lda	<L978+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L978+rhsrce_1+2
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
	xref	~~~fdiv
	jsl	~~~fdiv
	pla
	sta	[<R2]
	pla
	ldy	#$2
	sta	[<R2],Y
L10752:
	inc	<L978+n_1
L10755:
	sec
	lda	<L978+n_1
	sbc	<L978+count_1
	bvs	L1017
	eor	#$8000
L1017:
	bmi	L1018
	brl	L10754
L1018:
L10753:
	pea	#<$3
	pea	#0
	clc
	tdc
	adc	#<L978+lharray_4
	pha
	jsl	~~push_arraytemp
	brl	L10757
L10750:
	jsl	~~want_number
L10757:
L10749:
L10741:
L10733:
L1019:
	pld
	tsc
	clc
	adc	#L977
	tcs
	rtl
L977	equ	78
L978	equ	29
	ends
	efunc
	code
	func
~~eval_ivintdiv:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1020
	tcs
	phd
	tcd
lhitem_1	set	0
rhint_1	set	2
	jsl	~~pop_int
	sta	<L1021+rhint_1
	lda	<L1021+rhint_1
	beq	L1022
	brl	L10758
L1022:
	pea	#<$37
	pea	#4
	jsl	~~error
L10758:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1021+lhitem_1
	lda	<L1021+lhitem_1
	cmp	#<$2
	beq	L1023
	brl	L10759
L1023:
	clc
	lda	#$2
	adc	|~~basicvars+42
	sta	<R0
	lda	#$0
	adc	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	ldx	<L1021+rhint_1
	xref	~~~div
	jsl	~~~div
	sta	[<R0]
	brl	L10760
L10759:
	lda	<L1021+lhitem_1
	cmp	#<$3
	beq	L1024
	brl	L10761
L1024:
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
	ldx	<L1021+rhint_1
	xref	~~~div
	jsl	~~~div
	pha
	jsl	~~push_int
	brl	L10762
L10761:
	lda	<L1021+lhitem_1
	cmp	#<$6
	bne	L1026
	brl	L1025
L1026:
	lda	<L1021+lhitem_1
	cmp	#<$8
	beq	L1027
	brl	L10763
L1027:
L1025:
lharray_2	set	4
n_2	set	8
count_2	set	10
	jsl	~~pop_array
	sta	<L1021+lharray_2
	stx	<L1021+lharray_2+2
	ldy	#$2
	lda	[<L1021+lharray_2],Y
	sta	<L1021+count_2
	lda	<L1021+lhitem_1
	cmp	#<$6
	beq	L1028
	brl	L10764
L1028:
srce_3	set	12
base_3	set	16
	pei	<L1021+lharray_2+2
	pei	<L1021+lharray_2
	pea	#<$2
	jsl	~~make_array
	sta	<L1021+base_3
	stx	<L1021+base_3+2
	ldy	#$4
	lda	[<L1021+lharray_2],Y
	sta	<L1021+srce_3
	ldy	#$6
	lda	[<L1021+lharray_2],Y
	sta	<L1021+srce_3+2
	stz	<L1021+n_2
	brl	L10768
L10767:
	ldy	#$0
	lda	<L1021+n_2
	bpl	L1029
	dey
L1029:
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
	lda	<L1021+base_3
	adc	<R0
	sta	<R2
	lda	<L1021+base_3+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L1021+n_2
	bpl	L1030
	dey
L1030:
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
	lda	<L1021+srce_3
	adc	<R0
	sta	<17
	lda	<L1021+srce_3+2
	adc	<R0+2
	sta	<17+2
	lda	[<17]
	ldx	<L1021+rhint_1
	xref	~~~div
	jsl	~~~div
	sta	[<R2]
L10765:
	inc	<L1021+n_2
L10768:
	sec
	lda	<L1021+n_2
	sbc	<L1021+count_2
	bvs	L1031
	eor	#$8000
L1031:
	bmi	L1032
	brl	L10767
L1032:
L10766:
	brl	L10769
L10764:
srce_4	set	12
base_4	set	16
	pei	<L1021+lharray_2+2
	pei	<L1021+lharray_2
	pea	#<$2
	jsl	~~make_array
	sta	<L1021+base_4
	stx	<L1021+base_4+2
	ldy	#$4
	lda	[<L1021+lharray_2],Y
	sta	<L1021+srce_4
	ldy	#$6
	lda	[<L1021+lharray_2],Y
	sta	<L1021+srce_4+2
	stz	<L1021+n_2
	brl	L10773
L10772:
	ldy	#$0
	lda	<L1021+n_2
	bpl	L1033
	dey
L1033:
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
	lda	<L1021+base_4
	adc	<R0
	sta	<R2
	lda	<L1021+base_4+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L1021+n_2
	bpl	L1034
	dey
L1034:
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
	lda	<L1021+srce_4
	adc	<R0
	sta	<17
	lda	<L1021+srce_4+2
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
	ldx	<L1021+rhint_1
	xref	~~~div
	jsl	~~~div
	sta	[<R2]
L10770:
	inc	<L1021+n_2
L10773:
	sec
	lda	<L1021+n_2
	sbc	<L1021+count_2
	bvs	L1035
	eor	#$8000
L1035:
	bmi	L1036
	brl	L10772
L1036:
L10771:
L10769:
	brl	L10774
L10763:
	jsl	~~want_number
L10774:
L10762:
L10760:
L1037:
	pld
	tsc
	clc
	adc	#L1020
	tcs
	rtl
L1020	equ	40
L1021	equ	21
	ends
	efunc
	code
	func
~~eval_fvintdiv:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1038
	tcs
	phd
	tcd
lhitem_1	set	0
rhint_1	set	2
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
	sta	<L1039+rhint_1
	lda	<L1039+rhint_1
	beq	L1040
	brl	L10775
L1040:
	pea	#<$37
	pea	#4
	jsl	~~error
L10775:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1039+lhitem_1
	lda	<L1039+lhitem_1
	cmp	#<$2
	beq	L1041
	brl	L10776
L1041:
	clc
	lda	#$2
	adc	|~~basicvars+42
	sta	<R0
	lda	#$0
	adc	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	ldx	<L1039+rhint_1
	xref	~~~div
	jsl	~~~div
	sta	[<R0]
	brl	L10777
L10776:
	lda	<L1039+lhitem_1
	cmp	#<$3
	beq	L1042
	brl	L10778
L1042:
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
	ldx	<L1039+rhint_1
	xref	~~~div
	jsl	~~~div
	pha
	jsl	~~push_int
	brl	L10779
L10778:
	lda	<L1039+lhitem_1
	cmp	#<$6
	bne	L1044
	brl	L1043
L1044:
	lda	<L1039+lhitem_1
	cmp	#<$8
	beq	L1045
	brl	L10780
L1045:
L1043:
lharray_2	set	4
base_2	set	8
n_2	set	12
count_2	set	14
	jsl	~~pop_array
	sta	<L1039+lharray_2
	stx	<L1039+lharray_2+2
	ldy	#$2
	lda	[<L1039+lharray_2],Y
	sta	<L1039+count_2
	pei	<L1039+lharray_2+2
	pei	<L1039+lharray_2
	pea	#<$2
	jsl	~~make_array
	sta	<L1039+base_2
	stx	<L1039+base_2+2
	lda	<L1039+lhitem_1
	cmp	#<$6
	beq	L1046
	brl	L10781
L1046:
srce_3	set	16
	ldy	#$4
	lda	[<L1039+lharray_2],Y
	sta	<L1039+srce_3
	ldy	#$6
	lda	[<L1039+lharray_2],Y
	sta	<L1039+srce_3+2
	stz	<L1039+n_2
	brl	L10785
L10784:
	ldy	#$0
	lda	<L1039+n_2
	bpl	L1047
	dey
L1047:
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
	lda	<L1039+base_2
	adc	<R0
	sta	<R2
	lda	<L1039+base_2+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L1039+n_2
	bpl	L1048
	dey
L1048:
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
	lda	<L1039+srce_3
	adc	<R0
	sta	<17
	lda	<L1039+srce_3+2
	adc	<R0+2
	sta	<17+2
	lda	[<17]
	ldx	<L1039+rhint_1
	xref	~~~div
	jsl	~~~div
	sta	[<R2]
L10782:
	inc	<L1039+n_2
L10785:
	sec
	lda	<L1039+n_2
	sbc	<L1039+count_2
	bvs	L1049
	eor	#$8000
L1049:
	bmi	L1050
	brl	L10784
L1050:
L10783:
	brl	L10786
L10781:
srce_4	set	16
	ldy	#$4
	lda	[<L1039+lharray_2],Y
	sta	<L1039+srce_4
	ldy	#$6
	lda	[<L1039+lharray_2],Y
	sta	<L1039+srce_4+2
	stz	<L1039+n_2
	brl	L10790
L10789:
	ldy	#$0
	lda	<L1039+n_2
	bpl	L1051
	dey
L1051:
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
	lda	<L1039+base_2
	adc	<R0
	sta	<R2
	lda	<L1039+base_2+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L1039+n_2
	bpl	L1052
	dey
L1052:
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
	lda	<L1039+srce_4
	adc	<R0
	sta	<17
	lda	<L1039+srce_4+2
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
	ldx	<L1039+rhint_1
	xref	~~~div
	jsl	~~~div
	sta	[<R2]
L10787:
	inc	<L1039+n_2
L10790:
	sec
	lda	<L1039+n_2
	sbc	<L1039+count_2
	bvs	L1053
	eor	#$8000
L1053:
	bmi	L1054
	brl	L10789
L1054:
L10788:
L10786:
	brl	L10791
L10780:
	jsl	~~want_number
L10791:
L10779:
L10777:
L1055:
	pld
	tsc
	clc
	adc	#L1038
	tcs
	rtl
L1038	equ	40
L1039	equ	21
	ends
	efunc
	code
	func
~~eval_iaintdiv:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1056
	tcs
	phd
	tcd
lhitem_1	set	0
rharray_1	set	2
n_1	set	6
count_1	set	8
base_1	set	10
rhsrce_1	set	14
	jsl	~~pop_array
	sta	<L1057+rharray_1
	stx	<L1057+rharray_1+2
	ldy	#$2
	lda	[<L1057+rharray_1],Y
	sta	<L1057+count_1
	ldy	#$4
	lda	[<L1057+rharray_1],Y
	sta	<L1057+rhsrce_1
	ldy	#$6
	lda	[<L1057+rharray_1],Y
	sta	<L1057+rhsrce_1+2
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1057+lhitem_1
	lda	<L1057+lhitem_1
	cmp	#<$2
	bne	L1059
	brl	L1058
L1059:
	lda	<L1057+lhitem_1
	cmp	#<$3
	beq	L1060
	brl	L10792
L1060:
L1058:
lhint_2	set	18
	lda	<L1057+lhitem_1
	cmp	#<$2
	beq	L1062
	brl	L1061
L1062:
	jsl	~~pop_int
	bra	L1063
L1061:
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
L1063:
	sta	<L1057+lhint_2
	pei	<L1057+rharray_1+2
	pei	<L1057+rharray_1
	pea	#<$2
	jsl	~~make_array
	sta	<L1057+base_1
	stx	<L1057+base_1+2
	stz	<L1057+n_1
	brl	L10796
L10795:
	ldy	#$0
	lda	<L1057+n_1
	bpl	L1064
	dey
L1064:
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
	lda	<L1057+rhsrce_1
	adc	<R0
	sta	<R2
	lda	<L1057+rhsrce_1+2
	adc	<R0+2
	sta	<R2+2
	lda	[<R2]
	beq	L1065
	brl	L10797
L1065:
	pea	#<$37
	pea	#4
	jsl	~~error
L10797:
	ldy	#$0
	lda	<L1057+n_1
	bpl	L1066
	dey
L1066:
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
	lda	<L1057+base_1
	adc	<R0
	sta	<R2
	lda	<L1057+base_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L1057+n_1
	bpl	L1067
	dey
L1067:
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
	lda	<L1057+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L1057+rhsrce_1+2
	adc	<R0+2
	sta	<17+2
	lda	[<17]
	tax
	lda	<L1057+lhint_2
	xref	~~~div
	jsl	~~~div
	sta	[<R2]
L10793:
	inc	<L1057+n_1
L10796:
	sec
	lda	<L1057+n_1
	sbc	<L1057+count_1
	bvs	L1068
	eor	#$8000
L1068:
	bmi	L1069
	brl	L10795
L1069:
L10794:
	brl	L10798
L10792:
	lda	<L1057+lhitem_1
	cmp	#<$6
	beq	L1070
	brl	L10799
L1070:
lhsrce_3	set	18
lharray_3	set	22
	jsl	~~pop_array
	sta	<L1057+lharray_3
	stx	<L1057+lharray_3+2
	pei	<L1057+rharray_1+2
	pei	<L1057+rharray_1
	pei	<L1057+lharray_3+2
	pei	<L1057+lharray_3
	jsl	~~check_arrays
	and	#$ff
	beq	L1071
	brl	L10800
L1071:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10800:
	ldy	#$4
	lda	[<L1057+lharray_3],Y
	sta	<L1057+lhsrce_3
	ldy	#$6
	lda	[<L1057+lharray_3],Y
	sta	<L1057+lhsrce_3+2
	pei	<L1057+rharray_1+2
	pei	<L1057+rharray_1
	pea	#<$2
	jsl	~~make_array
	sta	<L1057+base_1
	stx	<L1057+base_1+2
	stz	<L1057+n_1
	brl	L10804
L10803:
	ldy	#$0
	lda	<L1057+n_1
	bpl	L1072
	dey
L1072:
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
	lda	<L1057+rhsrce_1
	adc	<R0
	sta	<R2
	lda	<L1057+rhsrce_1+2
	adc	<R0+2
	sta	<R2+2
	lda	[<R2]
	beq	L1073
	brl	L10805
L1073:
	pea	#<$37
	pea	#4
	jsl	~~error
L10805:
	ldy	#$0
	lda	<L1057+n_1
	bpl	L1074
	dey
L1074:
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
	lda	<L1057+base_1
	adc	<R0
	sta	<R2
	lda	<L1057+base_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L1057+n_1
	bpl	L1075
	dey
L1075:
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
	lda	<L1057+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L1057+rhsrce_1+2
	adc	<R0+2
	sta	<17+2
	ldy	#$0
	lda	<L1057+n_1
	bpl	L1076
	dey
L1076:
	sta	<21
	sty	<21+2
	pei	<21+2
	pei	<21
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	lda	<L1057+lhsrce_3
	adc	<R0
	sta	<25
	lda	<L1057+lhsrce_3+2
	adc	<R0+2
	sta	<25+2
	lda	[<17]
	tax
	lda	[<25]
	xref	~~~div
	jsl	~~~div
	sta	[<R2]
L10801:
	inc	<L1057+n_1
L10804:
	sec
	lda	<L1057+n_1
	sbc	<L1057+count_1
	bvs	L1077
	eor	#$8000
L1077:
	bmi	L1078
	brl	L10803
L1078:
L10802:
	brl	L10806
L10799:
	lda	<L1057+lhitem_1
	cmp	#<$8
	beq	L1079
	brl	L10807
L1079:
lhsrce_4	set	18
lharray_4	set	22
	jsl	~~pop_array
	sta	<L1057+lharray_4
	stx	<L1057+lharray_4+2
	pei	<L1057+rharray_1+2
	pei	<L1057+rharray_1
	pei	<L1057+lharray_4+2
	pei	<L1057+lharray_4
	jsl	~~check_arrays
	and	#$ff
	beq	L1080
	brl	L10808
L1080:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10808:
	pei	<L1057+rharray_1+2
	pei	<L1057+rharray_1
	pea	#<$2
	jsl	~~make_array
	sta	<L1057+base_1
	stx	<L1057+base_1+2
	ldy	#$4
	lda	[<L1057+lharray_4],Y
	sta	<L1057+lhsrce_4
	ldy	#$6
	lda	[<L1057+lharray_4],Y
	sta	<L1057+lhsrce_4+2
	stz	<L1057+n_1
	brl	L10812
L10811:
	ldy	#$0
	lda	<L1057+n_1
	bpl	L1081
	dey
L1081:
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
	lda	<L1057+rhsrce_1
	adc	<R0
	sta	<R2
	lda	<L1057+rhsrce_1+2
	adc	<R0+2
	sta	<R2+2
	lda	[<R2]
	beq	L1082
	brl	L10813
L1082:
	pea	#<$37
	pea	#4
	jsl	~~error
L10813:
	ldy	#$0
	lda	<L1057+n_1
	bpl	L1083
	dey
L1083:
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
	lda	<L1057+base_1
	adc	<R0
	sta	<R2
	lda	<L1057+base_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L1057+n_1
	bpl	L1084
	dey
L1084:
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
	lda	<L1057+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L1057+rhsrce_1+2
	adc	<R0+2
	sta	<17+2
	ldy	#$0
	lda	<L1057+n_1
	bpl	L1085
	dey
L1085:
	sta	<21
	sty	<21+2
	pei	<21+2
	pei	<21
	lda	#$2
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	lda	<L1057+lhsrce_4
	adc	<R0
	sta	<25
	lda	<L1057+lhsrce_4+2
	adc	<R0+2
	sta	<25+2
	ldy	#$2
	lda	[<25],Y
	pha
	lda	[<25]
	pha
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R0
	pla
	sta	<R0+2
	lda	[<17]
	tax
	lda	<R0
	xref	~~~div
	jsl	~~~div
	sta	[<R2]
L10809:
	inc	<L1057+n_1
L10812:
	sec
	lda	<L1057+n_1
	sbc	<L1057+count_1
	bvs	L1086
	eor	#$8000
L1086:
	bmi	L1087
	brl	L10811
L1087:
L10810:
	brl	L10814
L10807:
	jsl	~~want_number
L10814:
L10806:
L10798:
L1088:
	pld
	tsc
	clc
	adc	#L1056
	tcs
	rtl
L1056	equ	54
L1057	equ	29
	ends
	efunc
	code
	func
~~eval_faintdiv:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1089
	tcs
	phd
	tcd
lhitem_1	set	0
rharray_1	set	2
base_1	set	6
n_1	set	10
count_1	set	12
rhsrce_1	set	14
	jsl	~~pop_array
	sta	<L1090+rharray_1
	stx	<L1090+rharray_1+2
	ldy	#$2
	lda	[<L1090+rharray_1],Y
	sta	<L1090+count_1
	ldy	#$4
	lda	[<L1090+rharray_1],Y
	sta	<L1090+rhsrce_1
	ldy	#$6
	lda	[<L1090+rharray_1],Y
	sta	<L1090+rhsrce_1+2
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1090+lhitem_1
	lda	<L1090+lhitem_1
	cmp	#<$2
	bne	L1092
	brl	L1091
L1092:
	lda	<L1090+lhitem_1
	cmp	#<$3
	beq	L1093
	brl	L10815
L1093:
L1091:
lhint_2	set	18
	lda	<L1090+lhitem_1
	cmp	#<$2
	beq	L1095
	brl	L1094
L1095:
	jsl	~~pop_int
	bra	L1096
L1094:
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
L1096:
	sta	<L1090+lhint_2
	pei	<L1090+rharray_1+2
	pei	<L1090+rharray_1
	pea	#<$2
	jsl	~~make_array
	sta	<L1090+base_1
	stx	<L1090+base_1+2
	stz	<L1090+n_1
	brl	L10819
L10818:
	ldy	#$0
	lda	<L1090+n_1
	bpl	L1097
	dey
L1097:
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
	lda	<L1090+rhsrce_1
	adc	<R0
	sta	<R2
	lda	<L1090+rhsrce_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$2
	lda	[<R2],Y
	pha
	lda	[<R2]
	pha
	xref	~~~ftod
	jsl	~~~ftod
	xref	~~~dtst
	jsl	~~~dtst
	beq	L1098
	brl	L10820
L1098:
	pea	#<$37
	pea	#4
	jsl	~~error
L10820:
	ldy	#$0
	lda	<L1090+n_1
	bpl	L1099
	dey
L1099:
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
	lda	<L1090+base_1
	adc	<R0
	sta	<R2
	lda	<L1090+base_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L1090+n_1
	bpl	L1100
	dey
L1100:
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
	lda	<L1090+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L1090+rhsrce_1+2
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
	lda	<L1090+lhint_2
	ldx	<R0
	xref	~~~div
	jsl	~~~div
	sta	[<R2]
L10816:
	inc	<L1090+n_1
L10819:
	sec
	lda	<L1090+n_1
	sbc	<L1090+count_1
	bvs	L1101
	eor	#$8000
L1101:
	bmi	L1102
	brl	L10818
L1102:
L10817:
	brl	L10821
L10815:
	lda	<L1090+lhitem_1
	cmp	#<$6
	beq	L1103
	brl	L10822
L1103:
lhsrce_3	set	18
lharray_3	set	22
	jsl	~~pop_array
	sta	<L1090+lharray_3
	stx	<L1090+lharray_3+2
	pei	<L1090+rharray_1+2
	pei	<L1090+rharray_1
	pei	<L1090+lharray_3+2
	pei	<L1090+lharray_3
	jsl	~~check_arrays
	and	#$ff
	beq	L1104
	brl	L10823
L1104:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10823:
	pei	<L1090+rharray_1+2
	pei	<L1090+rharray_1
	pea	#<$2
	jsl	~~make_array
	sta	<L1090+base_1
	stx	<L1090+base_1+2
	ldy	#$4
	lda	[<L1090+lharray_3],Y
	sta	<L1090+lhsrce_3
	ldy	#$6
	lda	[<L1090+lharray_3],Y
	sta	<L1090+lhsrce_3+2
	stz	<L1090+n_1
	brl	L10827
L10826:
	ldy	#$0
	lda	<L1090+n_1
	bpl	L1105
	dey
L1105:
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
	lda	<L1090+rhsrce_1
	adc	<R0
	sta	<R2
	lda	<L1090+rhsrce_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$2
	lda	[<R2],Y
	pha
	lda	[<R2]
	pha
	xref	~~~ftod
	jsl	~~~ftod
	xref	~~~dtst
	jsl	~~~dtst
	beq	L1106
	brl	L10828
L1106:
	pea	#<$37
	pea	#4
	jsl	~~error
L10828:
	ldy	#$0
	lda	<L1090+n_1
	bpl	L1107
	dey
L1107:
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
	lda	<L1090+base_1
	adc	<R0
	sta	<R2
	lda	<L1090+base_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L1090+n_1
	bpl	L1108
	dey
L1108:
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
	lda	<L1090+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L1090+rhsrce_1+2
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
	ldy	#$0
	lda	<L1090+n_1
	bpl	L1109
	dey
L1109:
	sta	<25
	sty	<25+2
	pei	<25+2
	pei	<25
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<21
	stx	<21+2
	clc
	lda	<L1090+lhsrce_3
	adc	<21
	sta	<29
	lda	<L1090+lhsrce_3+2
	adc	<21+2
	sta	<29+2
	lda	[<29]
	ldx	<R0
	xref	~~~div
	jsl	~~~div
	sta	[<R2]
L10824:
	inc	<L1090+n_1
L10827:
	sec
	lda	<L1090+n_1
	sbc	<L1090+count_1
	bvs	L1110
	eor	#$8000
L1110:
	bmi	L1111
	brl	L10826
L1111:
L10825:
	brl	L10829
L10822:
	lda	<L1090+lhitem_1
	cmp	#<$8
	beq	L1112
	brl	L10830
L1112:
lhsrce_4	set	18
lharray_4	set	22
	jsl	~~pop_array
	sta	<L1090+lharray_4
	stx	<L1090+lharray_4+2
	pei	<L1090+rharray_1+2
	pei	<L1090+rharray_1
	pei	<L1090+lharray_4+2
	pei	<L1090+lharray_4
	jsl	~~check_arrays
	and	#$ff
	beq	L1113
	brl	L10831
L1113:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10831:
	pei	<L1090+rharray_1+2
	pei	<L1090+rharray_1
	pea	#<$2
	jsl	~~make_array
	sta	<L1090+base_1
	stx	<L1090+base_1+2
	ldy	#$4
	lda	[<L1090+lharray_4],Y
	sta	<L1090+lhsrce_4
	ldy	#$6
	lda	[<L1090+lharray_4],Y
	sta	<L1090+lhsrce_4+2
	stz	<L1090+n_1
	brl	L10835
L10834:
	ldy	#$0
	lda	<L1090+n_1
	bpl	L1114
	dey
L1114:
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
	lda	<L1090+rhsrce_1
	adc	<R0
	sta	<R2
	lda	<L1090+rhsrce_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$2
	lda	[<R2],Y
	pha
	lda	[<R2]
	pha
	xref	~~~ftod
	jsl	~~~ftod
	xref	~~~dtst
	jsl	~~~dtst
	beq	L1115
	brl	L10836
L1115:
	pea	#<$37
	pea	#4
	jsl	~~error
L10836:
	ldy	#$0
	lda	<L1090+n_1
	bpl	L1116
	dey
L1116:
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
	lda	<L1090+base_1
	adc	<R0
	sta	<R2
	lda	<L1090+base_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L1090+n_1
	bpl	L1117
	dey
L1117:
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
	lda	<L1090+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L1090+rhsrce_1+2
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
	ldy	#$0
	lda	<L1090+n_1
	bpl	L1118
	dey
L1118:
	sta	<25
	sty	<25+2
	pei	<25+2
	pei	<25
	lda	#$2
	xref	~~~lasl
	jsl	~~~lasl
	sta	<21
	stx	<21+2
	clc
	lda	<L1090+lhsrce_4
	adc	<21
	sta	<29
	lda	<L1090+lhsrce_4+2
	adc	<21+2
	sta	<29+2
	ldy	#$2
	lda	[<29],Y
	pha
	lda	[<29]
	pha
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<21
	pla
	sta	<21+2
	lda	<21
	ldx	<R0
	xref	~~~div
	jsl	~~~div
	sta	[<R2]
L10832:
	inc	<L1090+n_1
L10835:
	sec
	lda	<L1090+n_1
	sbc	<L1090+count_1
	bvs	L1119
	eor	#$8000
L1119:
	bmi	L1120
	brl	L10834
L1120:
L10833:
	brl	L10837
L10830:
	jsl	~~want_number
L10837:
L10829:
L10821:
L1121:
	pld
	tsc
	clc
	adc	#L1089
	tcs
	rtl
L1089	equ	58
L1090	equ	33
	ends
	efunc
	code
	func
~~eval_ivmod:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1122
	tcs
	phd
	tcd
lhitem_1	set	0
rhint_1	set	2
	jsl	~~pop_int
	sta	<L1123+rhint_1
	lda	<L1123+rhint_1
	beq	L1124
	brl	L10838
L1124:
	pea	#<$37
	pea	#4
	jsl	~~error
L10838:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1123+lhitem_1
	lda	<L1123+lhitem_1
	cmp	#<$2
	beq	L1125
	brl	L10839
L1125:
	clc
	lda	#$2
	adc	|~~basicvars+42
	sta	<R0
	lda	#$0
	adc	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	ldx	<L1123+rhint_1
	xref	~~~mod
	jsl	~~~mod
	sta	[<R0]
	brl	L10840
L10839:
	lda	<L1123+lhitem_1
	cmp	#<$3
	beq	L1126
	brl	L10841
L1126:
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
	ldx	<L1123+rhint_1
	xref	~~~mod
	jsl	~~~mod
	pha
	jsl	~~push_int
	brl	L10842
L10841:
	lda	<L1123+lhitem_1
	cmp	#<$6
	bne	L1128
	brl	L1127
L1128:
	lda	<L1123+lhitem_1
	cmp	#<$8
	beq	L1129
	brl	L10843
L1129:
L1127:
lharray_2	set	4
n_2	set	8
count_2	set	10
	jsl	~~pop_array
	sta	<L1123+lharray_2
	stx	<L1123+lharray_2+2
	ldy	#$2
	lda	[<L1123+lharray_2],Y
	sta	<L1123+count_2
	lda	<L1123+lhitem_1
	cmp	#<$6
	beq	L1130
	brl	L10844
L1130:
srce_3	set	12
base_3	set	16
	pei	<L1123+lharray_2+2
	pei	<L1123+lharray_2
	pea	#<$2
	jsl	~~make_array
	sta	<L1123+base_3
	stx	<L1123+base_3+2
	ldy	#$4
	lda	[<L1123+lharray_2],Y
	sta	<L1123+srce_3
	ldy	#$6
	lda	[<L1123+lharray_2],Y
	sta	<L1123+srce_3+2
	stz	<L1123+n_2
	brl	L10848
L10847:
	ldy	#$0
	lda	<L1123+n_2
	bpl	L1131
	dey
L1131:
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
	lda	<L1123+base_3
	adc	<R0
	sta	<R2
	lda	<L1123+base_3+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L1123+n_2
	bpl	L1132
	dey
L1132:
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
	lda	<L1123+srce_3
	adc	<R0
	sta	<17
	lda	<L1123+srce_3+2
	adc	<R0+2
	sta	<17+2
	lda	[<17]
	ldx	<L1123+rhint_1
	xref	~~~mod
	jsl	~~~mod
	sta	[<R2]
L10845:
	inc	<L1123+n_2
L10848:
	sec
	lda	<L1123+n_2
	sbc	<L1123+count_2
	bvs	L1133
	eor	#$8000
L1133:
	bmi	L1134
	brl	L10847
L1134:
L10846:
	brl	L10849
L10844:
srce_4	set	12
base_4	set	16
	pei	<L1123+lharray_2+2
	pei	<L1123+lharray_2
	pea	#<$2
	jsl	~~make_array
	sta	<L1123+base_4
	stx	<L1123+base_4+2
	ldy	#$4
	lda	[<L1123+lharray_2],Y
	sta	<L1123+srce_4
	ldy	#$6
	lda	[<L1123+lharray_2],Y
	sta	<L1123+srce_4+2
	stz	<L1123+n_2
	brl	L10853
L10852:
	ldy	#$0
	lda	<L1123+n_2
	bpl	L1135
	dey
L1135:
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
	lda	<L1123+base_4
	adc	<R0
	sta	<R2
	lda	<L1123+base_4+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L1123+n_2
	bpl	L1136
	dey
L1136:
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
	lda	<L1123+srce_4
	adc	<R0
	sta	<17
	lda	<L1123+srce_4+2
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
	ldx	<L1123+rhint_1
	xref	~~~mod
	jsl	~~~mod
	sta	[<R2]
L10850:
	inc	<L1123+n_2
L10853:
	sec
	lda	<L1123+n_2
	sbc	<L1123+count_2
	bvs	L1137
	eor	#$8000
L1137:
	bmi	L1138
	brl	L10852
L1138:
L10851:
L10849:
	brl	L10854
L10843:
	jsl	~~want_number
L10854:
L10842:
L10840:
L1139:
	pld
	tsc
	clc
	adc	#L1122
	tcs
	rtl
L1122	equ	40
L1123	equ	21
	ends
	efunc
	code
	func
~~eval_fvmod:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1140
	tcs
	phd
	tcd
lhitem_1	set	0
rhint_1	set	2
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
	sta	<L1141+rhint_1
	lda	<L1141+rhint_1
	beq	L1142
	brl	L10855
L1142:
	pea	#<$37
	pea	#4
	jsl	~~error
L10855:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1141+lhitem_1
	lda	<L1141+lhitem_1
	cmp	#<$2
	beq	L1143
	brl	L10856
L1143:
	clc
	lda	#$2
	adc	|~~basicvars+42
	sta	<R0
	lda	#$0
	adc	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	ldx	<L1141+rhint_1
	xref	~~~mod
	jsl	~~~mod
	sta	[<R0]
	brl	L10857
L10856:
	lda	<L1141+lhitem_1
	cmp	#<$3
	beq	L1144
	brl	L10858
L1144:
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
	ldx	<L1141+rhint_1
	xref	~~~mod
	jsl	~~~mod
	pha
	jsl	~~push_int
	brl	L10859
L10858:
	lda	<L1141+lhitem_1
	cmp	#<$6
	bne	L1146
	brl	L1145
L1146:
	lda	<L1141+lhitem_1
	cmp	#<$8
	beq	L1147
	brl	L10860
L1147:
L1145:
lharray_2	set	4
base_2	set	8
n_2	set	12
count_2	set	14
	jsl	~~pop_array
	sta	<L1141+lharray_2
	stx	<L1141+lharray_2+2
	ldy	#$2
	lda	[<L1141+lharray_2],Y
	sta	<L1141+count_2
	pei	<L1141+lharray_2+2
	pei	<L1141+lharray_2
	pea	#<$2
	jsl	~~make_array
	sta	<L1141+base_2
	stx	<L1141+base_2+2
	lda	<L1141+lhitem_1
	cmp	#<$6
	beq	L1148
	brl	L10861
L1148:
srce_3	set	16
	ldy	#$4
	lda	[<L1141+lharray_2],Y
	sta	<L1141+srce_3
	ldy	#$6
	lda	[<L1141+lharray_2],Y
	sta	<L1141+srce_3+2
	stz	<L1141+n_2
	brl	L10865
L10864:
	ldy	#$0
	lda	<L1141+n_2
	bpl	L1149
	dey
L1149:
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
	lda	<L1141+base_2
	adc	<R0
	sta	<R2
	lda	<L1141+base_2+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L1141+n_2
	bpl	L1150
	dey
L1150:
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
	lda	<L1141+srce_3
	adc	<R0
	sta	<17
	lda	<L1141+srce_3+2
	adc	<R0+2
	sta	<17+2
	lda	[<17]
	ldx	<L1141+rhint_1
	xref	~~~mod
	jsl	~~~mod
	sta	[<R2]
L10862:
	inc	<L1141+n_2
L10865:
	sec
	lda	<L1141+n_2
	sbc	<L1141+count_2
	bvs	L1151
	eor	#$8000
L1151:
	bmi	L1152
	brl	L10864
L1152:
L10863:
	brl	L10866
L10861:
srce_4	set	16
	ldy	#$4
	lda	[<L1141+lharray_2],Y
	sta	<L1141+srce_4
	ldy	#$6
	lda	[<L1141+lharray_2],Y
	sta	<L1141+srce_4+2
	stz	<L1141+n_2
	brl	L10870
L10869:
	ldy	#$0
	lda	<L1141+n_2
	bpl	L1153
	dey
L1153:
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
	lda	<L1141+base_2
	adc	<R0
	sta	<R2
	lda	<L1141+base_2+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L1141+n_2
	bpl	L1154
	dey
L1154:
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
	lda	<L1141+srce_4
	adc	<R0
	sta	<17
	lda	<L1141+srce_4+2
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
	ldx	<L1141+rhint_1
	xref	~~~mod
	jsl	~~~mod
	sta	[<R2]
L10867:
	inc	<L1141+n_2
L10870:
	sec
	lda	<L1141+n_2
	sbc	<L1141+count_2
	bvs	L1155
	eor	#$8000
L1155:
	bmi	L1156
	brl	L10869
L1156:
L10868:
L10866:
	brl	L10871
L10860:
	jsl	~~want_number
L10871:
L10859:
L10857:
L1157:
	pld
	tsc
	clc
	adc	#L1140
	tcs
	rtl
L1140	equ	40
L1141	equ	21
	ends
	efunc
	code
	func
~~eval_iamod:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1158
	tcs
	phd
	tcd
lhitem_1	set	0
rharray_1	set	2
n_1	set	6
count_1	set	8
base_1	set	10
rhsrce_1	set	14
	jsl	~~pop_array
	sta	<L1159+rharray_1
	stx	<L1159+rharray_1+2
	ldy	#$2
	lda	[<L1159+rharray_1],Y
	sta	<L1159+count_1
	ldy	#$4
	lda	[<L1159+rharray_1],Y
	sta	<L1159+rhsrce_1
	ldy	#$6
	lda	[<L1159+rharray_1],Y
	sta	<L1159+rhsrce_1+2
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1159+lhitem_1
	lda	<L1159+lhitem_1
	cmp	#<$2
	bne	L1161
	brl	L1160
L1161:
	lda	<L1159+lhitem_1
	cmp	#<$3
	beq	L1162
	brl	L10872
L1162:
L1160:
lhint_2	set	18
	lda	<L1159+lhitem_1
	cmp	#<$2
	beq	L1164
	brl	L1163
L1164:
	jsl	~~pop_int
	bra	L1165
L1163:
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
L1165:
	sta	<L1159+lhint_2
	pei	<L1159+rharray_1+2
	pei	<L1159+rharray_1
	pea	#<$2
	jsl	~~make_array
	sta	<L1159+base_1
	stx	<L1159+base_1+2
	stz	<L1159+n_1
	brl	L10876
L10875:
	ldy	#$0
	lda	<L1159+n_1
	bpl	L1166
	dey
L1166:
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
	lda	<L1159+rhsrce_1
	adc	<R0
	sta	<R2
	lda	<L1159+rhsrce_1+2
	adc	<R0+2
	sta	<R2+2
	lda	[<R2]
	beq	L1167
	brl	L10877
L1167:
	pea	#<$37
	pea	#4
	jsl	~~error
L10877:
	ldy	#$0
	lda	<L1159+n_1
	bpl	L1168
	dey
L1168:
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
	lda	<L1159+base_1
	adc	<R0
	sta	<R2
	lda	<L1159+base_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L1159+n_1
	bpl	L1169
	dey
L1169:
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
	lda	<L1159+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L1159+rhsrce_1+2
	adc	<R0+2
	sta	<17+2
	lda	[<17]
	tax
	lda	<L1159+lhint_2
	xref	~~~mod
	jsl	~~~mod
	sta	[<R2]
L10873:
	inc	<L1159+n_1
L10876:
	sec
	lda	<L1159+n_1
	sbc	<L1159+count_1
	bvs	L1170
	eor	#$8000
L1170:
	bmi	L1171
	brl	L10875
L1171:
L10874:
	brl	L10878
L10872:
	lda	<L1159+lhitem_1
	cmp	#<$6
	beq	L1172
	brl	L10879
L1172:
lhsrce_3	set	18
lharray_3	set	22
	jsl	~~pop_array
	sta	<L1159+lharray_3
	stx	<L1159+lharray_3+2
	pei	<L1159+rharray_1+2
	pei	<L1159+rharray_1
	pei	<L1159+lharray_3+2
	pei	<L1159+lharray_3
	jsl	~~check_arrays
	and	#$ff
	beq	L1173
	brl	L10880
L1173:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10880:
	ldy	#$4
	lda	[<L1159+lharray_3],Y
	sta	<L1159+lhsrce_3
	ldy	#$6
	lda	[<L1159+lharray_3],Y
	sta	<L1159+lhsrce_3+2
	pei	<L1159+rharray_1+2
	pei	<L1159+rharray_1
	pea	#<$2
	jsl	~~make_array
	sta	<L1159+base_1
	stx	<L1159+base_1+2
	stz	<L1159+n_1
	brl	L10884
L10883:
	ldy	#$0
	lda	<L1159+n_1
	bpl	L1174
	dey
L1174:
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
	lda	<L1159+rhsrce_1
	adc	<R0
	sta	<R2
	lda	<L1159+rhsrce_1+2
	adc	<R0+2
	sta	<R2+2
	lda	[<R2]
	beq	L1175
	brl	L10885
L1175:
	pea	#<$37
	pea	#4
	jsl	~~error
L10885:
	ldy	#$0
	lda	<L1159+n_1
	bpl	L1176
	dey
L1176:
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
	lda	<L1159+base_1
	adc	<R0
	sta	<R2
	lda	<L1159+base_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L1159+n_1
	bpl	L1177
	dey
L1177:
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
	lda	<L1159+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L1159+rhsrce_1+2
	adc	<R0+2
	sta	<17+2
	ldy	#$0
	lda	<L1159+n_1
	bpl	L1178
	dey
L1178:
	sta	<21
	sty	<21+2
	pei	<21+2
	pei	<21
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	lda	<L1159+lhsrce_3
	adc	<R0
	sta	<25
	lda	<L1159+lhsrce_3+2
	adc	<R0+2
	sta	<25+2
	lda	[<17]
	tax
	lda	[<25]
	xref	~~~mod
	jsl	~~~mod
	sta	[<R2]
L10881:
	inc	<L1159+n_1
L10884:
	sec
	lda	<L1159+n_1
	sbc	<L1159+count_1
	bvs	L1179
	eor	#$8000
L1179:
	bmi	L1180
	brl	L10883
L1180:
L10882:
	brl	L10886
L10879:
	lda	<L1159+lhitem_1
	cmp	#<$8
	beq	L1181
	brl	L10887
L1181:
lhsrce_4	set	18
lharray_4	set	22
	jsl	~~pop_array
	sta	<L1159+lharray_4
	stx	<L1159+lharray_4+2
	pei	<L1159+rharray_1+2
	pei	<L1159+rharray_1
	pei	<L1159+lharray_4+2
	pei	<L1159+lharray_4
	jsl	~~check_arrays
	and	#$ff
	beq	L1182
	brl	L10888
L1182:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10888:
	pei	<L1159+rharray_1+2
	pei	<L1159+rharray_1
	pea	#<$2
	jsl	~~make_array
	sta	<L1159+base_1
	stx	<L1159+base_1+2
	ldy	#$4
	lda	[<L1159+lharray_4],Y
	sta	<L1159+lhsrce_4
	ldy	#$6
	lda	[<L1159+lharray_4],Y
	sta	<L1159+lhsrce_4+2
	stz	<L1159+n_1
	brl	L10892
L10891:
	ldy	#$0
	lda	<L1159+n_1
	bpl	L1183
	dey
L1183:
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
	lda	<L1159+rhsrce_1
	adc	<R0
	sta	<R2
	lda	<L1159+rhsrce_1+2
	adc	<R0+2
	sta	<R2+2
	lda	[<R2]
	beq	L1184
	brl	L10893
L1184:
	pea	#<$37
	pea	#4
	jsl	~~error
L10893:
	ldy	#$0
	lda	<L1159+n_1
	bpl	L1185
	dey
L1185:
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
	lda	<L1159+base_1
	adc	<R0
	sta	<R2
	lda	<L1159+base_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L1159+n_1
	bpl	L1186
	dey
L1186:
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
	lda	<L1159+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L1159+rhsrce_1+2
	adc	<R0+2
	sta	<17+2
	ldy	#$0
	lda	<L1159+n_1
	bpl	L1187
	dey
L1187:
	sta	<21
	sty	<21+2
	pei	<21+2
	pei	<21
	lda	#$2
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	lda	<L1159+lhsrce_4
	adc	<R0
	sta	<25
	lda	<L1159+lhsrce_4+2
	adc	<R0+2
	sta	<25+2
	ldy	#$2
	lda	[<25],Y
	pha
	lda	[<25]
	pha
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R0
	pla
	sta	<R0+2
	lda	[<17]
	tax
	lda	<R0
	xref	~~~mod
	jsl	~~~mod
	sta	[<R2]
L10889:
	inc	<L1159+n_1
L10892:
	sec
	lda	<L1159+n_1
	sbc	<L1159+count_1
	bvs	L1188
	eor	#$8000
L1188:
	bmi	L1189
	brl	L10891
L1189:
L10890:
	brl	L10894
L10887:
	jsl	~~want_number
L10894:
L10886:
L10878:
L1190:
	pld
	tsc
	clc
	adc	#L1158
	tcs
	rtl
L1158	equ	54
L1159	equ	29
	ends
	efunc
	code
	func
~~eval_famod:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1191
	tcs
	phd
	tcd
lhitem_1	set	0
rharray_1	set	2
base_1	set	6
n_1	set	10
count_1	set	12
rhsrce_1	set	14
	jsl	~~pop_array
	sta	<L1192+rharray_1
	stx	<L1192+rharray_1+2
	ldy	#$2
	lda	[<L1192+rharray_1],Y
	sta	<L1192+count_1
	ldy	#$4
	lda	[<L1192+rharray_1],Y
	sta	<L1192+rhsrce_1
	ldy	#$6
	lda	[<L1192+rharray_1],Y
	sta	<L1192+rhsrce_1+2
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1192+lhitem_1
	lda	<L1192+lhitem_1
	cmp	#<$2
	bne	L1194
	brl	L1193
L1194:
	lda	<L1192+lhitem_1
	cmp	#<$3
	beq	L1195
	brl	L10895
L1195:
L1193:
lhint_2	set	18
	lda	<L1192+lhitem_1
	cmp	#<$2
	beq	L1197
	brl	L1196
L1197:
	jsl	~~pop_int
	bra	L1198
L1196:
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
L1198:
	sta	<L1192+lhint_2
	pei	<L1192+rharray_1+2
	pei	<L1192+rharray_1
	pea	#<$2
	jsl	~~make_array
	sta	<L1192+base_1
	stx	<L1192+base_1+2
	stz	<L1192+n_1
	brl	L10899
L10898:
	ldy	#$0
	lda	<L1192+n_1
	bpl	L1199
	dey
L1199:
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
	lda	<L1192+rhsrce_1
	adc	<R0
	sta	<R2
	lda	<L1192+rhsrce_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$2
	lda	[<R2],Y
	pha
	lda	[<R2]
	pha
	xref	~~~ftod
	jsl	~~~ftod
	xref	~~~dtst
	jsl	~~~dtst
	beq	L1200
	brl	L10900
L1200:
	pea	#<$37
	pea	#4
	jsl	~~error
L10900:
	ldy	#$0
	lda	<L1192+n_1
	bpl	L1201
	dey
L1201:
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
	lda	<L1192+base_1
	adc	<R0
	sta	<R2
	lda	<L1192+base_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L1192+n_1
	bpl	L1202
	dey
L1202:
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
	lda	<L1192+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L1192+rhsrce_1+2
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
	lda	<L1192+lhint_2
	ldx	<R0
	xref	~~~mod
	jsl	~~~mod
	sta	[<R2]
L10896:
	inc	<L1192+n_1
L10899:
	sec
	lda	<L1192+n_1
	sbc	<L1192+count_1
	bvs	L1203
	eor	#$8000
L1203:
	bmi	L1204
	brl	L10898
L1204:
L10897:
	brl	L10901
L10895:
	lda	<L1192+lhitem_1
	cmp	#<$6
	beq	L1205
	brl	L10902
L1205:
lhsrce_3	set	18
lharray_3	set	22
	jsl	~~pop_array
	sta	<L1192+lharray_3
	stx	<L1192+lharray_3+2
	pei	<L1192+rharray_1+2
	pei	<L1192+rharray_1
	pei	<L1192+lharray_3+2
	pei	<L1192+lharray_3
	jsl	~~check_arrays
	and	#$ff
	beq	L1206
	brl	L10903
L1206:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10903:
	pei	<L1192+rharray_1+2
	pei	<L1192+rharray_1
	pea	#<$2
	jsl	~~make_array
	sta	<L1192+base_1
	stx	<L1192+base_1+2
	ldy	#$4
	lda	[<L1192+lharray_3],Y
	sta	<L1192+lhsrce_3
	ldy	#$6
	lda	[<L1192+lharray_3],Y
	sta	<L1192+lhsrce_3+2
	stz	<L1192+n_1
	brl	L10907
L10906:
	ldy	#$0
	lda	<L1192+n_1
	bpl	L1207
	dey
L1207:
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
	lda	<L1192+rhsrce_1
	adc	<R0
	sta	<R2
	lda	<L1192+rhsrce_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$2
	lda	[<R2],Y
	pha
	lda	[<R2]
	pha
	xref	~~~ftod
	jsl	~~~ftod
	xref	~~~dtst
	jsl	~~~dtst
	beq	L1208
	brl	L10908
L1208:
	pea	#<$37
	pea	#4
	jsl	~~error
L10908:
	ldy	#$0
	lda	<L1192+n_1
	bpl	L1209
	dey
L1209:
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
	lda	<L1192+base_1
	adc	<R0
	sta	<R2
	lda	<L1192+base_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L1192+n_1
	bpl	L1210
	dey
L1210:
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
	lda	<L1192+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L1192+rhsrce_1+2
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
	ldy	#$0
	lda	<L1192+n_1
	bpl	L1211
	dey
L1211:
	sta	<25
	sty	<25+2
	pei	<25+2
	pei	<25
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<21
	stx	<21+2
	clc
	lda	<L1192+lhsrce_3
	adc	<21
	sta	<29
	lda	<L1192+lhsrce_3+2
	adc	<21+2
	sta	<29+2
	lda	[<29]
	ldx	<R0
	xref	~~~mod
	jsl	~~~mod
	sta	[<R2]
L10904:
	inc	<L1192+n_1
L10907:
	sec
	lda	<L1192+n_1
	sbc	<L1192+count_1
	bvs	L1212
	eor	#$8000
L1212:
	bmi	L1213
	brl	L10906
L1213:
L10905:
	brl	L10909
L10902:
	lda	<L1192+lhitem_1
	cmp	#<$8
	beq	L1214
	brl	L10910
L1214:
lhsrce_4	set	18
lharray_4	set	22
	jsl	~~pop_array
	sta	<L1192+lharray_4
	stx	<L1192+lharray_4+2
	pei	<L1192+rharray_1+2
	pei	<L1192+rharray_1
	pei	<L1192+lharray_4+2
	pei	<L1192+lharray_4
	jsl	~~check_arrays
	and	#$ff
	beq	L1215
	brl	L10911
L1215:
	pea	#<$4c
	pea	#4
	jsl	~~error
L10911:
	pei	<L1192+rharray_1+2
	pei	<L1192+rharray_1
	pea	#<$2
	jsl	~~make_array
	sta	<L1192+base_1
	stx	<L1192+base_1+2
	ldy	#$4
	lda	[<L1192+lharray_4],Y
	sta	<L1192+lhsrce_4
	ldy	#$6
	lda	[<L1192+lharray_4],Y
	sta	<L1192+lhsrce_4+2
	stz	<L1192+n_1
	brl	L10915
L10914:
	ldy	#$0
	lda	<L1192+n_1
	bpl	L1216
	dey
L1216:
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
	lda	<L1192+rhsrce_1
	adc	<R0
	sta	<R2
	lda	<L1192+rhsrce_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$2
	lda	[<R2],Y
	pha
	lda	[<R2]
	pha
	xref	~~~ftod
	jsl	~~~ftod
	xref	~~~dtst
	jsl	~~~dtst
	beq	L1217
	brl	L10916
L1217:
	pea	#<$37
	pea	#4
	jsl	~~error
L10916:
	ldy	#$0
	lda	<L1192+n_1
	bpl	L1218
	dey
L1218:
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
	lda	<L1192+base_1
	adc	<R0
	sta	<R2
	lda	<L1192+base_1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L1192+n_1
	bpl	L1219
	dey
L1219:
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
	lda	<L1192+rhsrce_1
	adc	<R0
	sta	<17
	lda	<L1192+rhsrce_1+2
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
	ldy	#$0
	lda	<L1192+n_1
	bpl	L1220
	dey
L1220:
	sta	<25
	sty	<25+2
	pei	<25+2
	pei	<25
	lda	#$2
	xref	~~~lasl
	jsl	~~~lasl
	sta	<21
	stx	<21+2
	clc
	lda	<L1192+lhsrce_4
	adc	<21
	sta	<29
	lda	<L1192+lhsrce_4+2
	adc	<21+2
	sta	<29+2
	ldy	#$2
	lda	[<29],Y
	pha
	lda	[<29]
	pha
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<21
	pla
	sta	<21+2
	lda	<21
	ldx	<R0
	xref	~~~mod
	jsl	~~~mod
	sta	[<R2]
L10912:
	inc	<L1192+n_1
L10915:
	sec
	lda	<L1192+n_1
	sbc	<L1192+count_1
	bvs	L1221
	eor	#$8000
L1221:
	bmi	L1222
	brl	L10914
L1222:
L10913:
	brl	L10917
L10910:
	jsl	~~want_number
L10917:
L10909:
L10901:
L1223:
	pld
	tsc
	clc
	adc	#L1191
	tcs
	rtl
L1191	equ	58
L1192	equ	33
	ends
	efunc
	code
	func
~~eval_ivpow:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1224
	tcs
	phd
	tcd
lhitem_1	set	0
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L1226
	dey
L1226:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	pla
	sta	|~~floatvalue
	pla
	sta	|~~floatvalue+2
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1225+lhitem_1
	lda	<L1225+lhitem_1
	cmp	#<$2
	beq	L1227
	brl	L10918
L1227:
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
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L1228
	dey
L1228:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~ftod
	jsl	~~~ftod
	jsl	~~pow
	xref	~~~dtof
	jsl	~~~dtof
	jsl	~~push_float
	brl	L10919
L10918:
	lda	<L1225+lhitem_1
	cmp	#<$3
	beq	L1229
	brl	L10920
L1229:
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
	phy
	phy
	jsl	~~pop_float
	xref	~~~ftod
	jsl	~~~ftod
	jsl	~~pow
	xref	~~~dtof
	jsl	~~~dtof
	jsl	~~push_float
	brl	L10921
L10920:
	jsl	~~want_number
L10921:
L10919:
L1230:
	pld
	tsc
	clc
	adc	#L1224
	tcs
	rtl
L1224	equ	6
L1225	equ	5
	ends
	efunc
	code
	func
~~eval_fvpow:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1231
	tcs
	phd
	tcd
lhitem_1	set	0
	phy
	phy
	jsl	~~pop_float
	pla
	sta	|~~floatvalue
	pla
	sta	|~~floatvalue+2
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1232+lhitem_1
	lda	<L1232+lhitem_1
	cmp	#<$2
	beq	L1233
	brl	L10922
L1233:
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
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L1234
	dey
L1234:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~ftod
	jsl	~~~ftod
	jsl	~~pow
	xref	~~~dtof
	jsl	~~~dtof
	jsl	~~push_float
	brl	L10923
L10922:
	lda	<L1232+lhitem_1
	cmp	#<$3
	beq	L1235
	brl	L10924
L1235:
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
	phy
	phy
	jsl	~~pop_float
	xref	~~~ftod
	jsl	~~~ftod
	jsl	~~pow
	xref	~~~dtof
	jsl	~~~dtof
	jsl	~~push_float
	brl	L10925
L10924:
	jsl	~~want_number
L10925:
L10923:
L1236:
	pld
	tsc
	clc
	adc	#L1231
	tcs
	rtl
L1231	equ	6
L1232	equ	5
	ends
	efunc
	code
	func
~~eval_ivlsl:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1237
	tcs
	phd
	tcd
lhitem_1	set	0
rhint_1	set	2
	jsl	~~pop_int
	sta	<L1238+rhint_1
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1238+lhitem_1
	lda	<L1238+lhitem_1
	cmp	#<$2
	beq	L1239
	brl	L10926
L1239:
	clc
	lda	#$2
	adc	|~~basicvars+42
	sta	<R0
	lda	#$0
	adc	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	ldx	<L1238+rhint_1
	xref	~~~asl
	jsl	~~~asl
	sta	[<R0]
	brl	L10927
L10926:
	lda	<L1238+lhitem_1
	cmp	#<$3
	beq	L1240
	brl	L10928
L1240:
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
	ldx	<L1238+rhint_1
	xref	~~~asl
	jsl	~~~asl
	pha
	jsl	~~push_int
	brl	L10929
L10928:
	jsl	~~want_number
L10929:
L10927:
L1241:
	pld
	tsc
	clc
	adc	#L1237
	tcs
	rtl
L1237	equ	8
L1238	equ	5
	ends
	efunc
	code
	func
~~eval_fvlsl:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1242
	tcs
	phd
	tcd
lhitem_1	set	0
rhint_1	set	2
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
	sta	<L1243+rhint_1
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1243+lhitem_1
	lda	<L1243+lhitem_1
	cmp	#<$2
	beq	L1244
	brl	L10930
L1244:
	clc
	lda	#$2
	adc	|~~basicvars+42
	sta	<R0
	lda	#$0
	adc	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	ldx	<L1243+rhint_1
	xref	~~~asl
	jsl	~~~asl
	sta	[<R0]
	brl	L10931
L10930:
	lda	<L1243+lhitem_1
	cmp	#<$3
	beq	L1245
	brl	L10932
L1245:
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
	ldx	<L1243+rhint_1
	xref	~~~asl
	jsl	~~~asl
	pha
	jsl	~~push_int
	brl	L10933
L10932:
	jsl	~~want_number
L10933:
L10931:
L1246:
	pld
	tsc
	clc
	adc	#L1242
	tcs
	rtl
L1242	equ	8
L1243	equ	5
	ends
	efunc
	code
	func
~~eval_ivlsr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1247
	tcs
	phd
	tcd
lhitem_1	set	0
lhuint_1	set	2
rhuint_1	set	4
	jsl	~~pop_int
	sta	<L1248+rhuint_1
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1248+lhitem_1
	lda	<L1248+lhitem_1
	cmp	#<$2
	beq	L1249
	brl	L10934
L1249:
	jsl	~~pop_int
	sta	<L1248+lhuint_1
	lda	<L1248+lhuint_1
	ldx	<L1248+rhuint_1
	xref	~~~lsr
	jsl	~~~lsr
	pha
	jsl	~~push_int
	brl	L10935
L10934:
	lda	<L1248+lhitem_1
	cmp	#<$3
	beq	L1250
	brl	L10936
L1250:
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
	sta	<L1248+lhuint_1
	lda	<L1248+lhuint_1
	ldx	<L1248+rhuint_1
	xref	~~~lsr
	jsl	~~~lsr
	pha
	jsl	~~push_int
	brl	L10937
L10936:
	jsl	~~want_number
L10937:
L10935:
L1251:
	pld
	tsc
	clc
	adc	#L1247
	tcs
	rtl
L1247	equ	10
L1248	equ	5
	ends
	efunc
	code
	func
~~eval_fvlsr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1252
	tcs
	phd
	tcd
lhitem_1	set	0
lhuint_1	set	2
rhuint_1	set	4
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
	sta	<L1253+rhuint_1
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1253+lhitem_1
	lda	<L1253+lhitem_1
	cmp	#<$2
	beq	L1254
	brl	L10938
L1254:
	jsl	~~pop_int
	sta	<L1253+lhuint_1
	lda	<L1253+lhuint_1
	ldx	<L1253+rhuint_1
	xref	~~~lsr
	jsl	~~~lsr
	pha
	jsl	~~push_int
	brl	L10939
L10938:
	lda	<L1253+lhitem_1
	cmp	#<$3
	beq	L1255
	brl	L10940
L1255:
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
	sta	<L1253+lhuint_1
	lda	<L1253+lhuint_1
	ldx	<L1253+rhuint_1
	xref	~~~lsr
	jsl	~~~lsr
	pha
	jsl	~~push_int
	brl	L10941
L10940:
	jsl	~~want_number
L10941:
L10939:
L1256:
	pld
	tsc
	clc
	adc	#L1252
	tcs
	rtl
L1252	equ	10
L1253	equ	5
	ends
	efunc
	code
	func
~~eval_ivasr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1257
	tcs
	phd
	tcd
lhitem_1	set	0
rhint_1	set	2
	jsl	~~pop_int
	sta	<L1258+rhint_1
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1258+lhitem_1
	lda	<L1258+lhitem_1
	cmp	#<$2
	beq	L1259
	brl	L10942
L1259:
	clc
	lda	#$2
	adc	|~~basicvars+42
	sta	<R0
	lda	#$0
	adc	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	ldx	<L1258+rhint_1
	xref	~~~asr
	jsl	~~~asr
	sta	[<R0]
	brl	L10943
L10942:
	lda	<L1258+lhitem_1
	cmp	#<$3
	beq	L1260
	brl	L10944
L1260:
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
	ldx	<L1258+rhint_1
	xref	~~~asr
	jsl	~~~asr
	pha
	jsl	~~push_int
	brl	L10945
L10944:
	jsl	~~want_number
L10945:
L10943:
L1261:
	pld
	tsc
	clc
	adc	#L1257
	tcs
	rtl
L1257	equ	8
L1258	equ	5
	ends
	efunc
	code
	func
~~eval_fvasr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1262
	tcs
	phd
	tcd
lhitem_1	set	0
rhint_1	set	2
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
	sta	<L1263+rhint_1
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1263+lhitem_1
	lda	<L1263+lhitem_1
	cmp	#<$2
	beq	L1264
	brl	L10946
L1264:
	clc
	lda	#$2
	adc	|~~basicvars+42
	sta	<R0
	lda	#$0
	adc	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	ldx	<L1263+rhint_1
	xref	~~~asr
	jsl	~~~asr
	sta	[<R0]
	brl	L10947
L10946:
	lda	<L1263+lhitem_1
	cmp	#<$3
	beq	L1265
	brl	L10948
L1265:
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
	ldx	<L1263+rhint_1
	xref	~~~asr
	jsl	~~~asr
	pha
	jsl	~~push_int
	brl	L10949
L10948:
	jsl	~~want_number
L10949:
L10947:
L1266:
	pld
	tsc
	clc
	adc	#L1262
	tcs
	rtl
L1262	equ	8
L1263	equ	5
	ends
	efunc
	code
	func
~~eval_iveq:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1267
	tcs
	phd
	tcd
lhitem_1	set	0
result_1	set	2
rhint_1	set	4
	jsl	~~pop_int
	sta	<L1268+rhint_1
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1268+lhitem_1
	lda	<L1268+lhitem_1
	cmp	#<$2
	beq	L1269
	brl	L10950
L1269:
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
	cmp	<L1268+rhint_1
	beq	L1271
	brl	L1270
L1271:
	lda	#$ffff
	bra	L1272
L1270:
	lda	#$0
L1272:
	ldy	#$2
	sta	[<R0],Y
	brl	L10951
L10950:
	lda	<L1268+lhitem_1
	cmp	#<$3
	beq	L1273
	brl	L10952
L1273:
	ldy	#$0
	lda	<L1268+rhint_1
	bpl	L1275
	dey
L1275:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	phy
	phy
	jsl	~~pop_float
	xref	~~~fcmp
	jsl	~~~fcmp
	beq	L1276
	brl	L1274
L1276:
	lda	#$ffff
	bra	L1277
L1274:
	lda	#$0
L1277:
	sta	<L1268+result_1
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
	lda	<L1268+result_1
	ldy	#$2
	sta	[<R0],Y
	brl	L10953
L10952:
	jsl	~~want_number
L10953:
L10951:
L1278:
	pld
	tsc
	clc
	adc	#L1267
	tcs
	rtl
L1267	equ	14
L1268	equ	9
	ends
	efunc
	code
	func
~~eval_fveq:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1279
	tcs
	phd
	tcd
lhitem_1	set	0
result_1	set	2
	phy
	phy
	jsl	~~pop_float
	pla
	sta	|~~floatvalue
	pla
	sta	|~~floatvalue+2
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1280+lhitem_1
	lda	<L1280+lhitem_1
	cmp	#<$2
	beq	L1281
	brl	L10954
L1281:
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L1283
	dey
L1283:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~fcmp
	jsl	~~~fcmp
	beq	L1284
	brl	L1282
L1284:
	lda	#$ffff
	bra	L1285
L1282:
	lda	#$0
L1285:
	sta	<L1280+result_1
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
	lda	<L1280+result_1
	ldy	#$2
	sta	[<R0],Y
	brl	L10955
L10954:
	lda	<L1280+lhitem_1
	cmp	#<$3
	beq	L1286
	brl	L10956
L1286:
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	phy
	phy
	jsl	~~pop_float
	xref	~~~fcmp
	jsl	~~~fcmp
	beq	L1288
	brl	L1287
L1288:
	lda	#$ffff
	bra	L1289
L1287:
	lda	#$0
L1289:
	sta	<L1280+result_1
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
	lda	<L1280+result_1
	ldy	#$2
	sta	[<R0],Y
	brl	L10957
L10956:
	jsl	~~want_number
L10957:
L10955:
L1290:
	pld
	tsc
	clc
	adc	#L1279
	tcs
	rtl
L1279	equ	8
L1280	equ	5
	ends
	efunc
	code
	func
~~eval_sveq:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1291
	tcs
	phd
	tcd
lhitem_1	set	0
rhitem_1	set	2
result_1	set	4
lhstring_1	set	6
rhstring_1	set	12
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1292+rhitem_1
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L1292+rhstring_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1292+lhitem_1
	lda	<L1292+lhitem_1
	cmp	#<$4
	bne	L1293
	brl	L10958
L1293:
	lda	<L1292+lhitem_1
	cmp	#<$5
	bne	L1294
	brl	L10958
L1294:
	jsl	~~want_string
L10958:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L1292+lhstring_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	lda	<L1292+lhstring_1
	cmp	<L1292+rhstring_1
	bne	L1295
	brl	L10959
L1295:
	stz	<L1292+result_1
	brl	L10960
L10959:
	ldy	#$0
	lda	<L1292+lhstring_1
	bpl	L1297
	dey
L1297:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L1292+rhstring_1+4
	pei	<L1292+rhstring_1+2
	pei	<L1292+lhstring_1+4
	pei	<L1292+lhstring_1+2
	jsl	~~memcmp
	tax
	beq	L1298
	brl	L1296
L1298:
	lda	#$ffff
	bra	L1299
L1296:
	lda	#$0
L1299:
	sta	<L1292+result_1
L10960:
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
	lda	<L1292+result_1
	ldy	#$2
	sta	[<R0],Y
	lda	<L1292+lhitem_1
	cmp	#<$5
	beq	L1300
	brl	L10961
L1300:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L1292+lhstring_1
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
L10961:
	lda	<L1292+rhitem_1
	cmp	#<$5
	beq	L1301
	brl	L10962
L1301:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L1292+rhstring_1
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
L10962:
L1302:
	pld
	tsc
	clc
	adc	#L1291
	tcs
	rtl
L1291	equ	26
L1292	equ	9
	ends
	efunc
	code
	func
~~eval_ivne:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1303
	tcs
	phd
	tcd
lhitem_1	set	0
rhint_1	set	2
	jsl	~~pop_int
	sta	<L1304+rhint_1
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1304+lhitem_1
	lda	<L1304+lhitem_1
	cmp	#<$2
	beq	L1305
	brl	L10963
L1305:
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
	cmp	<L1304+rhint_1
	bne	L1307
	brl	L1306
L1307:
	lda	#$ffff
	bra	L1308
L1306:
	lda	#$0
L1308:
	ldy	#$2
	sta	[<R0],Y
	brl	L10964
L10963:
	lda	<L1304+lhitem_1
	cmp	#<$3
	beq	L1309
	brl	L10965
L1309:
	ldy	#$0
	lda	<L1304+rhint_1
	bpl	L1311
	dey
L1311:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	phy
	phy
	jsl	~~pop_float
	xref	~~~fcmp
	jsl	~~~fcmp
	bne	L1312
	brl	L1310
L1312:
	lda	#$ffff
	bra	L1313
L1310:
	lda	#$0
L1313:
	pha
	jsl	~~push_int
	brl	L10966
L10965:
	jsl	~~want_number
L10966:
L10964:
L1314:
	pld
	tsc
	clc
	adc	#L1303
	tcs
	rtl
L1303	equ	12
L1304	equ	9
	ends
	efunc
	code
	func
~~eval_fvne:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1315
	tcs
	phd
	tcd
lhitem_1	set	0
	phy
	phy
	jsl	~~pop_float
	pla
	sta	|~~floatvalue
	pla
	sta	|~~floatvalue+2
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1316+lhitem_1
	lda	<L1316+lhitem_1
	cmp	#<$2
	beq	L1317
	brl	L10967
L1317:
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L1319
	dey
L1319:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~fcmp
	jsl	~~~fcmp
	bne	L1320
	brl	L1318
L1320:
	lda	#$ffff
	bra	L1321
L1318:
	lda	#$0
L1321:
	pha
	jsl	~~push_int
	brl	L10968
L10967:
	lda	<L1316+lhitem_1
	cmp	#<$3
	beq	L1322
	brl	L10969
L1322:
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	phy
	phy
	jsl	~~pop_float
	xref	~~~fcmp
	jsl	~~~fcmp
	bne	L1324
	brl	L1323
L1324:
	lda	#$ffff
	bra	L1325
L1323:
	lda	#$0
L1325:
	pha
	jsl	~~push_int
	brl	L10970
L10969:
	jsl	~~want_number
L10970:
L10968:
L1326:
	pld
	tsc
	clc
	adc	#L1315
	tcs
	rtl
L1315	equ	6
L1316	equ	5
	ends
	efunc
	code
	func
~~eval_svne:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1327
	tcs
	phd
	tcd
lhitem_1	set	0
rhitem_1	set	2
lhstring_1	set	4
rhstring_1	set	10
result_1	set	16
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1328+rhitem_1
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L1328+rhstring_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1328+lhitem_1
	lda	<L1328+lhitem_1
	cmp	#<$4
	bne	L1329
	brl	L10971
L1329:
	lda	<L1328+lhitem_1
	cmp	#<$5
	bne	L1330
	brl	L10971
L1330:
	jsl	~~want_string
L10971:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L1328+lhstring_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	lda	<L1328+lhstring_1
	cmp	<L1328+rhstring_1
	bne	L1331
	brl	L10972
L1331:
	lda	#$ffff
	sta	<L1328+result_1
	brl	L10973
L10972:
	ldy	#$0
	lda	<L1328+lhstring_1
	bpl	L1333
	dey
L1333:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L1328+rhstring_1+4
	pei	<L1328+rhstring_1+2
	pei	<L1328+lhstring_1+4
	pei	<L1328+lhstring_1+2
	jsl	~~memcmp
	tax
	bne	L1334
	brl	L1332
L1334:
	lda	#$ffff
	bra	L1335
L1332:
	lda	#$0
L1335:
	sta	<L1328+result_1
L10973:
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
	lda	<L1328+result_1
	ldy	#$2
	sta	[<R0],Y
	lda	<L1328+lhitem_1
	cmp	#<$5
	beq	L1336
	brl	L10974
L1336:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L1328+lhstring_1
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
L10974:
	lda	<L1328+rhitem_1
	cmp	#<$5
	beq	L1337
	brl	L10975
L1337:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L1328+rhstring_1
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
L10975:
L1338:
	pld
	tsc
	clc
	adc	#L1327
	tcs
	rtl
L1327	equ	26
L1328	equ	9
	ends
	efunc
	code
	func
~~eval_ivgt:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1339
	tcs
	phd
	tcd
lhitem_1	set	0
rhint_1	set	2
	jsl	~~pop_int
	sta	<L1340+rhint_1
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1340+lhitem_1
	lda	<L1340+lhitem_1
	cmp	#<$2
	beq	L1341
	brl	L10976
L1341:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	|~~basicvars+42
	sta	<R1
	lda	|~~basicvars+42+2
	sta	<R1+2
	sec
	lda	<L1340+rhint_1
	ldy	#$2
	sbc	[<R1],Y
	bvs	L1343
	eor	#$8000
L1343:
	bpl	L1344
	brl	L1342
L1344:
	lda	#$ffff
	bra	L1345
L1342:
	lda	#$0
L1345:
	ldy	#$2
	sta	[<R0],Y
	brl	L10977
L10976:
	lda	<L1340+lhitem_1
	cmp	#<$3
	beq	L1346
	brl	L10978
L1346:
	phy
	phy
	jsl	~~pop_float
	ldy	#$0
	lda	<L1340+rhint_1
	bpl	L1348
	dey
L1348:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~fcmp
	jsl	~~~fcmp
	bmi	L1349
	brl	L1347
L1349:
	lda	#$ffff
	bra	L1350
L1347:
	lda	#$0
L1350:
	pha
	jsl	~~push_int
	brl	L10979
L10978:
	jsl	~~want_number
L10979:
L10977:
L1351:
	pld
	tsc
	clc
	adc	#L1339
	tcs
	rtl
L1339	equ	12
L1340	equ	9
	ends
	efunc
	code
	func
~~eval_fvgt:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1352
	tcs
	phd
	tcd
lhitem_1	set	0
	phy
	phy
	jsl	~~pop_float
	pla
	sta	|~~floatvalue
	pla
	sta	|~~floatvalue+2
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1353+lhitem_1
	lda	<L1353+lhitem_1
	cmp	#<$2
	beq	L1354
	brl	L10980
L1354:
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L1356
	dey
L1356:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	xref	~~~fcmp
	jsl	~~~fcmp
	bmi	L1357
	brl	L1355
L1357:
	lda	#$ffff
	bra	L1358
L1355:
	lda	#$0
L1358:
	pha
	jsl	~~push_int
	brl	L10981
L10980:
	lda	<L1353+lhitem_1
	cmp	#<$3
	beq	L1359
	brl	L10982
L1359:
	phy
	phy
	jsl	~~pop_float
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	xref	~~~fcmp
	jsl	~~~fcmp
	bmi	L1361
	brl	L1360
L1361:
	lda	#$ffff
	bra	L1362
L1360:
	lda	#$0
L1362:
	pha
	jsl	~~push_int
	brl	L10983
L10982:
	jsl	~~want_number
L10983:
L10981:
L1363:
	pld
	tsc
	clc
	adc	#L1352
	tcs
	rtl
L1352	equ	6
L1353	equ	5
	ends
	efunc
	code
	func
~~eval_svgt:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1364
	tcs
	phd
	tcd
lhitem_1	set	0
rhitem_1	set	2
lhstring_1	set	4
rhstring_1	set	10
result_1	set	16
complen_1	set	18
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1365+rhitem_1
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L1365+rhstring_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1365+lhitem_1
	lda	<L1365+lhitem_1
	cmp	#<$4
	bne	L1366
	brl	L10984
L1366:
	lda	<L1365+lhitem_1
	cmp	#<$5
	bne	L1367
	brl	L10984
L1367:
	jsl	~~want_string
L10984:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L1365+lhstring_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	sec
	lda	<L1365+lhstring_1
	sbc	<L1365+rhstring_1
	bvs	L1368
	eor	#$8000
L1368:
	bpl	L1369
	brl	L10985
L1369:
	lda	<L1365+lhstring_1
	sta	<L1365+complen_1
	brl	L10986
L10985:
	lda	<L1365+rhstring_1
	sta	<L1365+complen_1
L10986:
	ldy	#$0
	lda	<L1365+complen_1
	bpl	L1370
	dey
L1370:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L1365+rhstring_1+4
	pei	<L1365+rhstring_1+2
	pei	<L1365+lhstring_1+4
	pei	<L1365+lhstring_1+2
	jsl	~~memcmp
	sta	<L1365+result_1
	sec
	lda	#$0
	sbc	<L1365+result_1
	bvs	L1372
	eor	#$8000
L1372:
	bmi	L1373
	brl	L1371
L1373:
	lda	<L1365+result_1
	beq	L1374
	brl	L10987
L1374:
	sec
	lda	<L1365+rhstring_1
	sbc	<L1365+lhstring_1
	bvs	L1375
	eor	#$8000
L1375:
	bpl	L1376
	brl	L10987
L1376:
L1371:
	lda	#$ffff
	sta	<L1365+result_1
	brl	L10988
L10987:
	stz	<L1365+result_1
L10988:
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
	lda	<L1365+result_1
	ldy	#$2
	sta	[<R0],Y
	lda	<L1365+lhitem_1
	cmp	#<$5
	beq	L1377
	brl	L10989
L1377:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L1365+lhstring_1
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
L10989:
	lda	<L1365+rhitem_1
	cmp	#<$5
	beq	L1378
	brl	L10990
L1378:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L1365+rhstring_1
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
L10990:
L1379:
	pld
	tsc
	clc
	adc	#L1364
	tcs
	rtl
L1364	equ	28
L1365	equ	9
	ends
	efunc
	code
	func
~~eval_ivlt:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1380
	tcs
	phd
	tcd
lhitem_1	set	0
rhint_1	set	2
	jsl	~~pop_int
	sta	<L1381+rhint_1
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1381+lhitem_1
	lda	<L1381+lhitem_1
	cmp	#<$2
	beq	L1382
	brl	L10991
L1382:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	|~~basicvars+42
	sta	<R1
	lda	|~~basicvars+42+2
	sta	<R1+2
	sec
	ldy	#$2
	lda	[<R1],Y
	sbc	<L1381+rhint_1
	bvs	L1384
	eor	#$8000
L1384:
	bpl	L1385
	brl	L1383
L1385:
	lda	#$ffff
	bra	L1386
L1383:
	lda	#$0
L1386:
	ldy	#$2
	sta	[<R0],Y
	brl	L10992
L10991:
	lda	<L1381+lhitem_1
	cmp	#<$3
	beq	L1387
	brl	L10993
L1387:
	ldy	#$0
	lda	<L1381+rhint_1
	bpl	L1389
	dey
L1389:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	phy
	phy
	jsl	~~pop_float
	xref	~~~fcmp
	jsl	~~~fcmp
	bmi	L1390
	brl	L1388
L1390:
	lda	#$ffff
	bra	L1391
L1388:
	lda	#$0
L1391:
	pha
	jsl	~~push_int
	brl	L10994
L10993:
	jsl	~~want_number
L10994:
L10992:
L1392:
	pld
	tsc
	clc
	adc	#L1380
	tcs
	rtl
L1380	equ	12
L1381	equ	9
	ends
	efunc
	code
	func
~~eval_fvlt:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1393
	tcs
	phd
	tcd
lhitem_1	set	0
	phy
	phy
	jsl	~~pop_float
	pla
	sta	|~~floatvalue
	pla
	sta	|~~floatvalue+2
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1394+lhitem_1
	lda	<L1394+lhitem_1
	cmp	#<$2
	beq	L1395
	brl	L10995
L1395:
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L1397
	dey
L1397:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~fcmp
	jsl	~~~fcmp
	bmi	L1398
	brl	L1396
L1398:
	lda	#$ffff
	bra	L1399
L1396:
	lda	#$0
L1399:
	pha
	jsl	~~push_int
	brl	L10996
L10995:
	lda	<L1394+lhitem_1
	cmp	#<$3
	beq	L1400
	brl	L10997
L1400:
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	phy
	phy
	jsl	~~pop_float
	xref	~~~fcmp
	jsl	~~~fcmp
	bmi	L1402
	brl	L1401
L1402:
	lda	#$ffff
	bra	L1403
L1401:
	lda	#$0
L1403:
	pha
	jsl	~~push_int
	brl	L10998
L10997:
	jsl	~~want_number
L10998:
L10996:
L1404:
	pld
	tsc
	clc
	adc	#L1393
	tcs
	rtl
L1393	equ	6
L1394	equ	5
	ends
	efunc
	code
	func
~~eval_svlt:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1405
	tcs
	phd
	tcd
lhitem_1	set	0
rhitem_1	set	2
lhstring_1	set	4
rhstring_1	set	10
result_1	set	16
complen_1	set	18
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1406+rhitem_1
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L1406+rhstring_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1406+lhitem_1
	lda	<L1406+lhitem_1
	cmp	#<$4
	bne	L1407
	brl	L10999
L1407:
	lda	<L1406+lhitem_1
	cmp	#<$5
	bne	L1408
	brl	L10999
L1408:
	jsl	~~want_string
L10999:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L1406+lhstring_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	sec
	lda	<L1406+lhstring_1
	sbc	<L1406+rhstring_1
	bvs	L1409
	eor	#$8000
L1409:
	bpl	L1410
	brl	L11000
L1410:
	lda	<L1406+lhstring_1
	sta	<L1406+complen_1
	brl	L11001
L11000:
	lda	<L1406+rhstring_1
	sta	<L1406+complen_1
L11001:
	ldy	#$0
	lda	<L1406+complen_1
	bpl	L1411
	dey
L1411:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L1406+rhstring_1+4
	pei	<L1406+rhstring_1+2
	pei	<L1406+lhstring_1+4
	pei	<L1406+lhstring_1+2
	jsl	~~memcmp
	sta	<L1406+result_1
	lda	<L1406+result_1
	bpl	L1413
	brl	L1412
L1413:
	lda	<L1406+result_1
	beq	L1414
	brl	L11002
L1414:
	sec
	lda	<L1406+lhstring_1
	sbc	<L1406+rhstring_1
	bvs	L1415
	eor	#$8000
L1415:
	bpl	L1416
	brl	L11002
L1416:
L1412:
	lda	#$ffff
	sta	<L1406+result_1
	brl	L11003
L11002:
	stz	<L1406+result_1
L11003:
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
	lda	<L1406+result_1
	ldy	#$2
	sta	[<R0],Y
	lda	<L1406+lhitem_1
	cmp	#<$5
	beq	L1417
	brl	L11004
L1417:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L1406+lhstring_1
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
L11004:
	lda	<L1406+rhitem_1
	cmp	#<$5
	beq	L1418
	brl	L11005
L1418:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L1406+rhstring_1
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
L11005:
L1419:
	pld
	tsc
	clc
	adc	#L1405
	tcs
	rtl
L1405	equ	28
L1406	equ	9
	ends
	efunc
	code
	func
~~eval_ivge:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1420
	tcs
	phd
	tcd
lhitem_1	set	0
rhint_1	set	2
	jsl	~~pop_int
	sta	<L1421+rhint_1
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1421+lhitem_1
	lda	<L1421+lhitem_1
	cmp	#<$2
	beq	L1422
	brl	L11006
L1422:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	|~~basicvars+42
	sta	<R1
	lda	|~~basicvars+42+2
	sta	<R1+2
	sec
	ldy	#$2
	lda	[<R1],Y
	sbc	<L1421+rhint_1
	bvs	L1424
	eor	#$8000
L1424:
	bmi	L1425
	brl	L1423
L1425:
	lda	#$ffff
	bra	L1426
L1423:
	lda	#$0
L1426:
	ldy	#$2
	sta	[<R0],Y
	brl	L11007
L11006:
	lda	<L1421+lhitem_1
	cmp	#<$3
	beq	L1427
	brl	L11008
L1427:
	ldy	#$0
	lda	<L1421+rhint_1
	bpl	L1429
	dey
L1429:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	phy
	phy
	jsl	~~pop_float
	xref	~~~fcmp
	jsl	~~~fcmp
	bpl	L1430
	brl	L1428
L1430:
	lda	#$ffff
	bra	L1431
L1428:
	lda	#$0
L1431:
	pha
	jsl	~~push_int
	brl	L11009
L11008:
	jsl	~~want_number
L11009:
L11007:
L1432:
	pld
	tsc
	clc
	adc	#L1420
	tcs
	rtl
L1420	equ	12
L1421	equ	9
	ends
	efunc
	code
	func
~~eval_fvge:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1433
	tcs
	phd
	tcd
lhitem_1	set	0
	phy
	phy
	jsl	~~pop_float
	pla
	sta	|~~floatvalue
	pla
	sta	|~~floatvalue+2
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1434+lhitem_1
	lda	<L1434+lhitem_1
	cmp	#<$2
	beq	L1435
	brl	L11010
L1435:
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L1437
	dey
L1437:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~fcmp
	jsl	~~~fcmp
	bpl	L1438
	brl	L1436
L1438:
	lda	#$ffff
	bra	L1439
L1436:
	lda	#$0
L1439:
	pha
	jsl	~~push_int
	brl	L11011
L11010:
	lda	<L1434+lhitem_1
	cmp	#<$3
	beq	L1440
	brl	L11012
L1440:
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	phy
	phy
	jsl	~~pop_float
	xref	~~~fcmp
	jsl	~~~fcmp
	bpl	L1442
	brl	L1441
L1442:
	lda	#$ffff
	bra	L1443
L1441:
	lda	#$0
L1443:
	pha
	jsl	~~push_int
	brl	L11013
L11012:
	jsl	~~want_number
L11013:
L11011:
L1444:
	pld
	tsc
	clc
	adc	#L1433
	tcs
	rtl
L1433	equ	6
L1434	equ	5
	ends
	efunc
	code
	func
~~eval_svge:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1445
	tcs
	phd
	tcd
lhitem_1	set	0
rhitem_1	set	2
lhstring_1	set	4
rhstring_1	set	10
result_1	set	16
complen_1	set	18
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1446+rhitem_1
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L1446+rhstring_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1446+lhitem_1
	lda	<L1446+lhitem_1
	cmp	#<$4
	bne	L1447
	brl	L11014
L1447:
	lda	<L1446+lhitem_1
	cmp	#<$5
	bne	L1448
	brl	L11014
L1448:
	jsl	~~want_string
L11014:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L1446+lhstring_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	sec
	lda	<L1446+lhstring_1
	sbc	<L1446+rhstring_1
	bvs	L1449
	eor	#$8000
L1449:
	bpl	L1450
	brl	L11015
L1450:
	lda	<L1446+lhstring_1
	sta	<L1446+complen_1
	brl	L11016
L11015:
	lda	<L1446+rhstring_1
	sta	<L1446+complen_1
L11016:
	ldy	#$0
	lda	<L1446+complen_1
	bpl	L1451
	dey
L1451:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L1446+rhstring_1+4
	pei	<L1446+rhstring_1+2
	pei	<L1446+lhstring_1+4
	pei	<L1446+lhstring_1+2
	jsl	~~memcmp
	sta	<L1446+result_1
	sec
	lda	#$0
	sbc	<L1446+result_1
	bvs	L1453
	eor	#$8000
L1453:
	bmi	L1454
	brl	L1452
L1454:
	lda	<L1446+result_1
	beq	L1455
	brl	L11017
L1455:
	sec
	lda	<L1446+lhstring_1
	sbc	<L1446+rhstring_1
	bvs	L1456
	eor	#$8000
L1456:
	bmi	L1457
	brl	L11017
L1457:
L1452:
	lda	#$ffff
	sta	<L1446+result_1
	brl	L11018
L11017:
	stz	<L1446+result_1
L11018:
	pei	<L1446+result_1
	jsl	~~push_int
	lda	<L1446+lhitem_1
	cmp	#<$5
	beq	L1458
	brl	L11019
L1458:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L1446+lhstring_1
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
L11019:
	lda	<L1446+rhitem_1
	cmp	#<$5
	beq	L1459
	brl	L11020
L1459:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L1446+rhstring_1
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
L11020:
L1460:
	pld
	tsc
	clc
	adc	#L1445
	tcs
	rtl
L1445	equ	28
L1446	equ	9
	ends
	efunc
	code
	func
~~eval_ivle:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1461
	tcs
	phd
	tcd
lhitem_1	set	0
rhint_1	set	2
	jsl	~~pop_int
	sta	<L1462+rhint_1
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1462+lhitem_1
	lda	<L1462+lhitem_1
	cmp	#<$2
	beq	L1463
	brl	L11021
L1463:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	|~~basicvars+42
	sta	<R1
	lda	|~~basicvars+42+2
	sta	<R1+2
	sec
	lda	<L1462+rhint_1
	ldy	#$2
	sbc	[<R1],Y
	bvs	L1465
	eor	#$8000
L1465:
	bmi	L1466
	brl	L1464
L1466:
	lda	#$ffff
	bra	L1467
L1464:
	lda	#$0
L1467:
	ldy	#$2
	sta	[<R0],Y
	brl	L11022
L11021:
	lda	<L1462+lhitem_1
	cmp	#<$3
	beq	L1468
	brl	L11023
L1468:
	phy
	phy
	jsl	~~pop_float
	ldy	#$0
	lda	<L1462+rhint_1
	bpl	L1470
	dey
L1470:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	xref	~~~fcmp
	jsl	~~~fcmp
	bpl	L1471
	brl	L1469
L1471:
	lda	#$ffff
	bra	L1472
L1469:
	lda	#$0
L1472:
	pha
	jsl	~~push_int
	brl	L11024
L11023:
	jsl	~~want_number
L11024:
L11022:
L1473:
	pld
	tsc
	clc
	adc	#L1461
	tcs
	rtl
L1461	equ	12
L1462	equ	9
	ends
	efunc
	code
	func
~~eval_fvle:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1474
	tcs
	phd
	tcd
lhitem_1	set	0
	phy
	phy
	jsl	~~pop_float
	pla
	sta	|~~floatvalue
	pla
	sta	|~~floatvalue+2
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1475+lhitem_1
	lda	<L1475+lhitem_1
	cmp	#<$2
	beq	L1476
	brl	L11025
L1476:
	jsl	~~pop_int
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L1478
	dey
L1478:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	xref	~~~fcmp
	jsl	~~~fcmp
	bpl	L1479
	brl	L1477
L1479:
	lda	#$ffff
	bra	L1480
L1477:
	lda	#$0
L1480:
	pha
	jsl	~~push_int
	brl	L11026
L11025:
	lda	<L1475+lhitem_1
	cmp	#<$3
	beq	L1481
	brl	L11027
L1481:
	phy
	phy
	jsl	~~pop_float
	lda	|~~floatvalue+2
	pha
	lda	|~~floatvalue
	pha
	xref	~~~fcmp
	jsl	~~~fcmp
	bpl	L1483
	brl	L1482
L1483:
	lda	#$ffff
	bra	L1484
L1482:
	lda	#$0
L1484:
	pha
	jsl	~~push_int
	brl	L11028
L11027:
	jsl	~~want_number
L11028:
L11026:
L1485:
	pld
	tsc
	clc
	adc	#L1474
	tcs
	rtl
L1474	equ	6
L1475	equ	5
	ends
	efunc
	code
	func
~~eval_svle:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1486
	tcs
	phd
	tcd
lhitem_1	set	0
rhitem_1	set	2
lhstring_1	set	4
rhstring_1	set	10
result_1	set	16
complen_1	set	18
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1487+rhitem_1
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L1487+rhstring_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1487+lhitem_1
	lda	<L1487+lhitem_1
	cmp	#<$4
	bne	L1488
	brl	L11029
L1488:
	lda	<L1487+lhitem_1
	cmp	#<$5
	bne	L1489
	brl	L11029
L1489:
	jsl	~~want_string
L11029:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L1487+lhstring_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	sec
	lda	<L1487+lhstring_1
	sbc	<L1487+rhstring_1
	bvs	L1490
	eor	#$8000
L1490:
	bpl	L1491
	brl	L11030
L1491:
	lda	<L1487+lhstring_1
	sta	<L1487+complen_1
	brl	L11031
L11030:
	lda	<L1487+rhstring_1
	sta	<L1487+complen_1
L11031:
	ldy	#$0
	lda	<L1487+complen_1
	bpl	L1492
	dey
L1492:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L1487+rhstring_1+4
	pei	<L1487+rhstring_1+2
	pei	<L1487+lhstring_1+4
	pei	<L1487+lhstring_1+2
	jsl	~~memcmp
	sta	<L1487+result_1
	lda	<L1487+result_1
	bpl	L1494
	brl	L1493
L1494:
	lda	<L1487+result_1
	beq	L1495
	brl	L11032
L1495:
	sec
	lda	<L1487+rhstring_1
	sbc	<L1487+lhstring_1
	bvs	L1496
	eor	#$8000
L1496:
	bmi	L1497
	brl	L11032
L1497:
L1493:
	lda	#$ffff
	sta	<L1487+result_1
	brl	L11033
L11032:
	stz	<L1487+result_1
L11033:
	pei	<L1487+result_1
	jsl	~~push_int
	lda	<L1487+lhitem_1
	cmp	#<$5
	beq	L1498
	brl	L11034
L1498:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L1487+lhstring_1
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
L11034:
	lda	<L1487+rhitem_1
	cmp	#<$5
	beq	L1499
	brl	L11035
L1499:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L1487+rhstring_1
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
L11035:
L1500:
	pld
	tsc
	clc
	adc	#L1486
	tcs
	rtl
L1486	equ	28
L1487	equ	9
	ends
	efunc
	code
	func
~~eval_ivand:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1501
	tcs
	phd
	tcd
lhitem_1	set	0
rhint_1	set	2
	jsl	~~pop_int
	sta	<L1502+rhint_1
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1502+lhitem_1
	lda	<L1502+lhitem_1
	cmp	#<$2
	beq	L1503
	brl	L11036
L1503:
	clc
	lda	#$2
	adc	|~~basicvars+42
	sta	<R0
	lda	#$0
	adc	|~~basicvars+42+2
	sta	<R0+2
	lda	<L1502+rhint_1
	and	[<R0]
	sta	[<R0]
	brl	L11037
L11036:
	lda	<L1502+lhitem_1
	cmp	#<$3
	beq	L1504
	brl	L11038
L1504:
	phy
	phy
	jsl	~~pop_float
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R0
	pla
	sta	<R0+2
	lda	<L1502+rhint_1
	and	<R0
	pha
	jsl	~~push_int
	brl	L11039
L11038:
	jsl	~~want_number
L11039:
L11037:
L1505:
	pld
	tsc
	clc
	adc	#L1501
	tcs
	rtl
L1501	equ	8
L1502	equ	5
	ends
	efunc
	code
	func
~~eval_fvand:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1506
	tcs
	phd
	tcd
lhitem_1	set	0
rhint_1	set	2
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
	sta	<L1507+rhint_1
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1507+lhitem_1
	lda	<L1507+lhitem_1
	cmp	#<$2
	beq	L1508
	brl	L11040
L1508:
	clc
	lda	#$2
	adc	|~~basicvars+42
	sta	<R0
	lda	#$0
	adc	|~~basicvars+42+2
	sta	<R0+2
	lda	<L1507+rhint_1
	and	[<R0]
	sta	[<R0]
	brl	L11041
L11040:
	lda	<L1507+lhitem_1
	cmp	#<$3
	beq	L1509
	brl	L11042
L1509:
	phy
	phy
	jsl	~~pop_float
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R0
	pla
	sta	<R0+2
	lda	<L1507+rhint_1
	and	<R0
	pha
	jsl	~~push_int
	brl	L11043
L11042:
	jsl	~~want_number
L11043:
L11041:
L1510:
	pld
	tsc
	clc
	adc	#L1506
	tcs
	rtl
L1506	equ	8
L1507	equ	5
	ends
	efunc
	code
	func
~~eval_ivor:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1511
	tcs
	phd
	tcd
lhitem_1	set	0
rhint_1	set	2
	jsl	~~pop_int
	sta	<L1512+rhint_1
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1512+lhitem_1
	lda	<L1512+lhitem_1
	cmp	#<$2
	beq	L1513
	brl	L11044
L1513:
	clc
	lda	#$2
	adc	|~~basicvars+42
	sta	<R0
	lda	#$0
	adc	|~~basicvars+42+2
	sta	<R0+2
	lda	<L1512+rhint_1
	ora	[<R0]
	sta	[<R0]
	brl	L11045
L11044:
	lda	<L1512+lhitem_1
	cmp	#<$3
	beq	L1514
	brl	L11046
L1514:
	phy
	phy
	jsl	~~pop_float
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R0
	pla
	sta	<R0+2
	lda	<L1512+rhint_1
	ora	<R0
	pha
	jsl	~~push_int
	brl	L11047
L11046:
	jsl	~~want_number
L11047:
L11045:
L1515:
	pld
	tsc
	clc
	adc	#L1511
	tcs
	rtl
L1511	equ	8
L1512	equ	5
	ends
	efunc
	code
	func
~~eval_fvor:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1516
	tcs
	phd
	tcd
lhitem_1	set	0
rhint_1	set	2
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
	sta	<L1517+rhint_1
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1517+lhitem_1
	lda	<L1517+lhitem_1
	cmp	#<$2
	beq	L1518
	brl	L11048
L1518:
	clc
	lda	#$2
	adc	|~~basicvars+42
	sta	<R0
	lda	#$0
	adc	|~~basicvars+42+2
	sta	<R0+2
	lda	<L1517+rhint_1
	ora	[<R0]
	sta	[<R0]
	brl	L11049
L11048:
	lda	<L1517+lhitem_1
	cmp	#<$3
	beq	L1519
	brl	L11050
L1519:
	phy
	phy
	jsl	~~pop_float
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R0
	pla
	sta	<R0+2
	lda	<L1517+rhint_1
	ora	<R0
	pha
	jsl	~~push_int
	brl	L11051
L11050:
	jsl	~~want_number
L11051:
L11049:
L1520:
	pld
	tsc
	clc
	adc	#L1516
	tcs
	rtl
L1516	equ	8
L1517	equ	5
	ends
	efunc
	code
	func
~~eval_iveor:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1521
	tcs
	phd
	tcd
lhitem_1	set	0
rhint_1	set	2
	jsl	~~pop_int
	sta	<L1522+rhint_1
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1522+lhitem_1
	lda	<L1522+lhitem_1
	cmp	#<$2
	beq	L1523
	brl	L11052
L1523:
	clc
	lda	#$2
	adc	|~~basicvars+42
	sta	<R0
	lda	#$0
	adc	|~~basicvars+42+2
	sta	<R0+2
	lda	<L1522+rhint_1
	eor	[<R0]
	sta	[<R0]
	brl	L11053
L11052:
	lda	<L1522+lhitem_1
	cmp	#<$3
	beq	L1524
	brl	L11054
L1524:
	phy
	phy
	jsl	~~pop_float
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R0
	pla
	sta	<R0+2
	lda	<L1522+rhint_1
	eor	<R0
	pha
	jsl	~~push_int
	brl	L11055
L11054:
	jsl	~~want_number
L11055:
L11053:
L1525:
	pld
	tsc
	clc
	adc	#L1521
	tcs
	rtl
L1521	equ	8
L1522	equ	5
	ends
	efunc
	code
	func
~~eval_fveor:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1526
	tcs
	phd
	tcd
lhitem_1	set	0
rhint_1	set	2
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
	sta	<L1527+rhint_1
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1527+lhitem_1
	lda	<L1527+lhitem_1
	cmp	#<$2
	beq	L1528
	brl	L11056
L1528:
	clc
	lda	#$2
	adc	|~~basicvars+42
	sta	<R0
	lda	#$0
	adc	|~~basicvars+42+2
	sta	<R0+2
	lda	<L1527+rhint_1
	eor	[<R0]
	sta	[<R0]
	brl	L11057
L11056:
	lda	<L1527+lhitem_1
	cmp	#<$3
	beq	L1529
	brl	L11058
L1529:
	phy
	phy
	jsl	~~pop_float
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R0
	pla
	sta	<R0+2
	lda	<L1527+rhint_1
	eor	<R0
	pha
	jsl	~~push_int
	brl	L11059
L11058:
	jsl	~~want_number
L11059:
L11057:
L1530:
	pld
	tsc
	clc
	adc	#L1526
	tcs
	rtl
L1526	equ	8
L1527	equ	5
	ends
	efunc
	data
	xdef	~~factor_table
~~factor_table:
	dl	~~bad_syntax
	dl	~~do_xvar
	dl	~~do_staticvar
	dl	~~do_intvar
	dl	~~do_floatvar
	dl	~~do_stringvar
	dl	~~do_arrayvar
	dl	~~do_arrayref
	dl	~~do_arrayref
	dl	~~do_indrefvar
	dl	~~do_indrefvar
	dl	~~do_statindvar
	dl	~~do_xfunction
	dl	~~do_function
	dl	~~bad_token
	dl	~~bad_token
	dl	~~do_intzero
	dl	~~do_intone
	dl	~~do_smallconst
	dl	~~do_intconst
	dl	~~do_floatzero
	dl	~~do_floatone
	dl	~~do_floatconst
	dl	~~do_stringcon
	dl	~~do_qstringcon
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~bad_token
	dl	~~do_getword
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~do_getstring
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~do_brackets
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~do_unaryplus
	dl	~~bad_syntax
	dl	~~do_unaryminus
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
	dl	~~do_getbyte
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
	dl	~~do_getfloat
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
	dl	~~fn_mod
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~fn_beat
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
	dl	~~fn_colour
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~fn_dim
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~fn_end
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_token
	dl	~~fn_false
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
	dl	~~fn_mode
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~fn_not
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
	dl	~~fn_quit
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
	dl	~~fn_tint
	dl	~~fn_top
	dl	~~fn_trace
	dl	~~fn_true
	dl	~~bad_syntax
	dl	~~fn_vdu
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~bad_syntax
	dl	~~fn_width
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
	dl	~~bad_token
	dl	~~bad_syntax
	dl	~~exec_function
	ends
	data
~~optable:
	dw	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	dw	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	dw	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	dw	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	dw	$0,$0,$603,$501,$0,$502,$604,$605,$0,$0
	dw	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	dw	$40F,$40C,$40E,$0,$0,$0,$0,$0,$0,$0
	dw	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	dw	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	dw	$0,$0,$0,$0,$708,$0,$0,$0,$0,$0
	dw	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	dw	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	dw	$0,$0,$0,$0,$0,$0,$0,$0,$312,$40B
	dw	$606,$214,$410,$411,$409,$40A,$0,$607,$40D,$213
	dw	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	dw	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	dw	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	dw	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	dw	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	dw	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	dw	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	dw	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	dw	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	dw	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	dw	$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	dw	$0,$0,$0,$0,$0,$0
	ends
	data
~~opfunctions:
	dl	~~eval_badcall
	dl	~~eval_badcall
	dl	~~eval_badcall
	dl	~~eval_badcall
	dl	~~eval_badcall
	dl	~~eval_badcall
	dl	~~eval_badcall
	dl	~~eval_badcall
	dl	~~eval_badcall
	dl	~~eval_badcall
	dl	~~eval_badcall
	dl	~~eval_badcall
	dl	~~eval_badcall
	dl	~~eval_badcall
	dl	~~eval_ivplus
	dl	~~eval_fvplus
	dl	~~eval_svplus
	dl	~~eval_svplus
	dl	~~eval_iaplus
	dl	~~eval_iaplus
	dl	~~eval_faplus
	dl	~~eval_faplus
	dl	~~eval_saplus
	dl	~~eval_saplus
	dl	~~eval_badcall
	dl	~~eval_badcall
	dl	~~eval_ivminus
	dl	~~eval_fvminus
	dl	~~want_number
	dl	~~want_number
	dl	~~eval_iaminus
	dl	~~eval_iaminus
	dl	~~eval_faminus
	dl	~~eval_faminus
	dl	~~want_number
	dl	~~want_number
	dl	~~eval_badcall
	dl	~~eval_badcall
	dl	~~eval_ivmul
	dl	~~eval_fvmul
	dl	~~want_number
	dl	~~want_number
	dl	~~eval_iamul
	dl	~~eval_iamul
	dl	~~eval_famul
	dl	~~eval_famul
	dl	~~want_number
	dl	~~want_number
	dl	~~want_array
	dl	~~eval_badcall
	dl	~~want_array
	dl	~~want_array
	dl	~~want_array
	dl	~~want_array
	dl	~~eval_immul
	dl	~~want_array
	dl	~~eval_fmmul
	dl	~~want_array
	dl	~~want_array
	dl	~~want_array
	dl	~~eval_badcall
	dl	~~eval_badcall
	dl	~~eval_ivdiv
	dl	~~eval_fvdiv
	dl	~~want_number
	dl	~~want_number
	dl	~~eval_iadiv
	dl	~~eval_iadiv
	dl	~~eval_fadiv
	dl	~~eval_fadiv
	dl	~~want_number
	dl	~~want_number
	dl	~~eval_badcall
	dl	~~eval_badcall
	dl	~~eval_ivintdiv
	dl	~~eval_fvintdiv
	dl	~~want_number
	dl	~~want_number
	dl	~~eval_iaintdiv
	dl	~~eval_iaintdiv
	dl	~~eval_faintdiv
	dl	~~eval_faintdiv
	dl	~~want_number
	dl	~~want_number
	dl	~~eval_badcall
	dl	~~eval_badcall
	dl	~~eval_ivmod
	dl	~~eval_fvmod
	dl	~~want_number
	dl	~~want_number
	dl	~~eval_iamod
	dl	~~eval_iamod
	dl	~~eval_famod
	dl	~~eval_famod
	dl	~~want_number
	dl	~~want_number
	dl	~~eval_badcall
	dl	~~eval_badcall
	dl	~~eval_ivpow
	dl	~~eval_fvpow
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~eval_badcall
	dl	~~eval_badcall
	dl	~~eval_ivlsl
	dl	~~eval_fvlsl
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~eval_badcall
	dl	~~eval_badcall
	dl	~~eval_ivlsr
	dl	~~eval_fvlsr
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~eval_badcall
	dl	~~eval_badcall
	dl	~~eval_ivasr
	dl	~~eval_fvasr
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~eval_badcall
	dl	~~eval_badcall
	dl	~~eval_iveq
	dl	~~eval_fveq
	dl	~~eval_sveq
	dl	~~eval_sveq
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~eval_badcall
	dl	~~eval_badcall
	dl	~~eval_ivne
	dl	~~eval_fvne
	dl	~~eval_svne
	dl	~~eval_svne
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~eval_badcall
	dl	~~eval_badcall
	dl	~~eval_ivgt
	dl	~~eval_fvgt
	dl	~~eval_svgt
	dl	~~eval_svgt
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~eval_badcall
	dl	~~eval_badcall
	dl	~~eval_ivlt
	dl	~~eval_fvlt
	dl	~~eval_svlt
	dl	~~eval_svlt
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~eval_badcall
	dl	~~eval_badcall
	dl	~~eval_ivge
	dl	~~eval_fvge
	dl	~~eval_svge
	dl	~~eval_svge
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~eval_badcall
	dl	~~eval_badcall
	dl	~~eval_ivle
	dl	~~eval_fvle
	dl	~~eval_svle
	dl	~~eval_svle
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~eval_badcall
	dl	~~eval_badcall
	dl	~~eval_ivand
	dl	~~eval_fvand
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~eval_badcall
	dl	~~eval_badcall
	dl	~~eval_ivor
	dl	~~eval_fvor
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~eval_badcall
	dl	~~eval_badcall
	dl	~~eval_iveor
	dl	~~eval_fveor
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	dl	~~want_number
	ends
	code
	xdef	~~expression
	func
~~expression:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1531
	tcs
	phd
	tcd
thisop_1	set	0
lastop_1	set	2
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
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	lda	[<R1]
	and	#$ff
	sta	<R1
	lda	<R1
	asl	A
	sta	<R0
	ldx	<R0
	lda	|~~optable,X
	sta	<L1532+lastop_1
	lda	<L1532+lastop_1
	beq	L1533
	brl	L11060
L1533:
L1534:
	pld
	tsc
	clc
	adc	#L1531
	tcs
	rtl
L11060:
	inc	|~~basicvars+62
	bne	L1535
	inc	|~~basicvars+62+2
L1535:
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
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	lda	[<R1]
	and	#$ff
	sta	<R1
	lda	<R1
	asl	A
	sta	<R0
	ldx	<R0
	lda	|~~optable,X
	sta	<L1532+thisop_1
	lda	<L1532+thisop_1
	beq	L1536
	brl	L11061
L1536:
	lda	|~~basicvars+42
	sta	<R1
	lda	|~~basicvars+42+2
	sta	<R1+2
	lda	[<R1]
	asl	A
	asl	A
	sta	<R0
	lda	<L1532+lastop_1
	and	#<$ff
	sta	<R1
	lda	<R1
	ldx	#<$30
	xref	~~~mul
	jsl	~~~mul
	sta	<R1
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	clc
	lda	#<~~opfunctions
	adc	<R2
	sta	<R0
	ldy	#$2
	lda	(<R0),Y
	tax
	lda	(<R0)
	xref	~~~lcal
	jsl	~~~lcal
	brl	L1534
L11061:
	lda	|~~basicvars+10
	cmp	|~~basicvars+14
	bne	L1537
	lda	|~~basicvars+10+2
	cmp	|~~basicvars+14+2
L1537:
	beq	L1538
	brl	L11062
L1538:
	pea	#<$5d
	pea	#4
	jsl	~~error
L11062:
	clc
	lda	#$2
	adc	|~~basicvars+10
	sta	|~~basicvars+10
	bcc	L1539
	inc	|~~basicvars+10+2
L1539:
	lda	|~~basicvars+10
	sta	<R0
	lda	|~~basicvars+10+2
	sta	<R0+2
	lda	#$0
	sta	[<R0]
L11065:
	lda	<L1532+lastop_1
	and	#<$ff00
	sta	<R0
	lda	<L1532+thisop_1
	and	#<$ff00
	sta	<R1
	lda	<R0
	cmp	<R1
	bcc	L1540
	brl	L11066
L1540:
	lda	|~~basicvars+10
	cmp	|~~basicvars+14
	bne	L1541
	lda	|~~basicvars+10+2
	cmp	|~~basicvars+14+2
L1541:
	beq	L1542
	brl	L11067
L1542:
	pea	#<$5d
	pea	#4
	jsl	~~error
L11067:
	brl	L11068
L11066:
	lda	<L1532+thisop_1
	and	#<$ff00
	sta	<R0
	lda	<R0
	cmp	#<$400
	beq	L1543
	brl	L11069
L1543:
L11070:
	lda	<L1532+thisop_1
	and	#<$ff00
	sta	<R0
	lda	<L1532+lastop_1
	and	#<$ff00
	sta	<R1
	lda	<R1
	cmp	<R0
	bcs	L1544
	brl	L11071
L1544:
	lda	<L1532+lastop_1
	and	#<$ff00
	sta	<R0
	lda	<R0
	cmp	#<$400
	bne	L1545
	brl	L11071
L1545:
	lda	|~~basicvars+42
	sta	<R1
	lda	|~~basicvars+42+2
	sta	<R1+2
	lda	[<R1]
	asl	A
	asl	A
	sta	<R0
	lda	<L1532+lastop_1
	and	#<$ff
	sta	<R1
	lda	<R1
	ldx	#<$30
	xref	~~~mul
	jsl	~~~mul
	sta	<R1
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	clc
	lda	#<~~opfunctions
	adc	<R2
	sta	<R0
	ldy	#$2
	lda	(<R0),Y
	tax
	lda	(<R0)
	xref	~~~lcal
	jsl	~~~lcal
	lda	|~~basicvars+10
	sta	<R0
	lda	|~~basicvars+10+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1532+lastop_1
	clc
	lda	#$fffe
	adc	|~~basicvars+10
	sta	|~~basicvars+10
	lda	#$ffff
	adc	|~~basicvars+10+2
	sta	|~~basicvars+10+2
	brl	L11070
L11071:
	lda	<L1532+lastop_1
	and	#<$ff00
	sta	<R0
	lda	<R0
	cmp	#<$400
	bne	L1546
	brl	L11064
L1546:
	brl	L11072
L11069:
L11075:
	lda	|~~basicvars+42
	sta	<R1
	lda	|~~basicvars+42+2
	sta	<R1+2
	lda	[<R1]
	asl	A
	asl	A
	sta	<R0
	lda	<L1532+lastop_1
	and	#<$ff
	sta	<R1
	lda	<R1
	ldx	#<$30
	xref	~~~mul
	jsl	~~~mul
	sta	<R1
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	clc
	lda	#<~~opfunctions
	adc	<R2
	sta	<R0
	ldy	#$2
	lda	(<R0),Y
	tax
	lda	(<R0)
	xref	~~~lcal
	jsl	~~~lcal
	lda	|~~basicvars+10
	sta	<R0
	lda	|~~basicvars+10+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1532+lastop_1
	clc
	lda	#$fffe
	adc	|~~basicvars+10
	sta	|~~basicvars+10
	lda	#$ffff
	adc	|~~basicvars+10+2
	sta	|~~basicvars+10+2
L11073:
	lda	<L1532+thisop_1
	and	#<$ff00
	sta	<R0
	lda	<L1532+lastop_1
	and	#<$ff00
	sta	<R1
	lda	<R1
	cmp	<R0
	bcc	L1547
	brl	L11075
L1547:
L11074:
L11072:
L11068:
	clc
	lda	#$2
	adc	|~~basicvars+10
	sta	|~~basicvars+10
	bcc	L1548
	inc	|~~basicvars+10+2
L1548:
	lda	|~~basicvars+10
	sta	<R0
	lda	|~~basicvars+10+2
	sta	<R0+2
	lda	<L1532+lastop_1
	sta	[<R0]
	lda	<L1532+thisop_1
	sta	<L1532+lastop_1
	inc	|~~basicvars+62
	bne	L1549
	inc	|~~basicvars+62+2
L1549:
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
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	lda	[<R1]
	and	#$ff
	sta	<R1
	lda	<R1
	asl	A
	sta	<R0
	ldx	<R0
	lda	|~~optable,X
	sta	<L1532+thisop_1
L11063:
	lda	<L1532+thisop_1
	beq	L1550
	brl	L11065
L1550:
L11064:
L11076:
	lda	<L1532+lastop_1
	bne	L1551
	brl	L11077
L1551:
	lda	|~~basicvars+42
	sta	<R1
	lda	|~~basicvars+42+2
	sta	<R1+2
	lda	[<R1]
	asl	A
	asl	A
	sta	<R0
	lda	<L1532+lastop_1
	and	#<$ff
	sta	<R1
	lda	<R1
	ldx	#<$30
	xref	~~~mul
	jsl	~~~mul
	sta	<R1
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	clc
	lda	#<~~opfunctions
	adc	<R2
	sta	<R0
	ldy	#$2
	lda	(<R0),Y
	tax
	lda	(<R0)
	xref	~~~lcal
	jsl	~~~lcal
	lda	|~~basicvars+10
	sta	<R0
	lda	|~~basicvars+10+2
	sta	<R0+2
	lda	[<R0]
	sta	<L1532+lastop_1
	clc
	lda	#$fffe
	adc	|~~basicvars+10
	sta	|~~basicvars+10
	lda	#$ffff
	adc	|~~basicvars+10+2
	sta	|~~basicvars+10+2
	brl	L11076
L11077:
	brl	L1534
L1531	equ	16
L1532	equ	13
	ends
	efunc
	code
	xdef	~~factor
	func
~~factor:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1552
	tcs
	phd
	tcd
	lda	|~~basicvars+10
	sta	<R0
	lda	|~~basicvars+10+2
	sta	<R0+2
	lda	#$0
	sta	[<R0]
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
	lda	|~~basicvars+10
	sta	<R0
	lda	|~~basicvars+10+2
	sta	<R0+2
	lda	[<R0]
	bne	L1554
	brl	L11078
L1554:
	pea	#<$51
	pea	#4
	jsl	~~error
L11078:
L1555:
	pld
	tsc
	clc
	adc	#L1552
	tcs
	rtl
L1552	equ	8
L1553	equ	9
	ends
	efunc
	code
	xdef	~~init_expressions
	func
~~init_expressions:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1556
	tcs
	phd
	tcd
	jsl	~~make_opstack
	sta	|~~basicvars+10
	stx	|~~basicvars+10+2
	clc
	lda	#$28
	adc	|~~basicvars+10
	sta	|~~basicvars+14
	lda	#$0
	adc	|~~basicvars+10+2
	sta	|~~basicvars+14+2
	lda	|~~basicvars+10
	sta	<R0
	lda	|~~basicvars+10+2
	sta	<R0+2
	lda	#$0
	sta	[<R0]
	jsl	~~init_functions
L1558:
	pld
	tsc
	clc
	adc	#L1556
	tcs
	rtl
L1556	equ	4
L1557	equ	5
	ends
	efunc
	code
	xdef	~~reset_opstack
	func
~~reset_opstack:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L1559
	tcs
	phd
	tcd
	clc
	lda	#$ffd8
	adc	|~~basicvars+14
	sta	|~~basicvars+10
	lda	#$ffff
	adc	|~~basicvars+14+2
	sta	|~~basicvars+10+2
	lda	|~~basicvars+10
	sta	<R0
	lda	|~~basicvars+10+2
	sta	<R0+2
	lda	#$0
	sta	[<R0]
L1561:
	pld
	tsc
	clc
	adc	#L1559
	tcs
	rtl
L1559	equ	4
L1560	equ	5
	ends
	efunc
	xref	~~fn_beat
	xref	~~fn_colour
	xref	~~fn_dim
	xref	~~fn_end
	xref	~~fn_false
	xref	~~fn_mod
	xref	~~fn_mode
	xref	~~fn_not
	xref	~~fn_quit
	xref	~~fn_tint
	xref	~~fn_top
	xref	~~fn_trace
	xref	~~fn_true
	xref	~~fn_vdu
	xref	~~fn_width
	xref	~~init_functions
	xref	~~exec_function
	xref	~~tocstring
	xref	~~store_float
	xref	~~store_integer
	xref	~~check_write
	xref	~~check_read
	xref	~~bad_syntax
	xref	~~bad_token
	xref	~~trace_branch
	xref	~~trace_proc
	xref	~~exec_fnstatements
	xref	~~get_float
	xref	~~get_integer
	xref	~~error
	xref	~~save_retstring
	xref	~~save_retfloat
	xref	~~save_retint
	xref	~~save_array
	xref	~~save_string
	xref	~~save_float
	xref	~~save_int
	xref	~~pop_arraytemp
	xref	~~pop_array
	xref	~~pop_string
	xref	~~pop_float
	xref	~~pop_int
	xref	~~make_restart
	xref	~~make_opstack
	xref	~~push_fn
	xref	~~push_arraytemp
	xref	~~push_array
	xref	~~push_dolstring
	xref	~~push_strtemp
	xref	~~push_float
	xref	~~push_int
	xref	~~alloc_stackmem
	xref	~~get_stringlen
	xref	~~resize_string
	xref	~~free_string
	xref	~~alloc_string
	xref	~~get_lvalue
	xref	~~find_fnproc
	xref	~~find_variable
	xref	~~get_fpvalue
	xref	~~get_srcaddr
	xref	~~set_address
	xref	~~skip_name
	xref	~~__sigsetjmp
	xref	~~fabs
	xref	~~pow
	xref	~~memcmp
	xref	~~memmove
	xref	~~fprintf
	udata
~~floatvalue
	ds	4
	ends
	xref	~~basicvars
	xref	~~stderr
	end
