;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
	data
~~entrysize:
	dw	$0,$0,$4,$6,$8,$8,$6,$1E,$6,$1E
	dw	$6,$1E,$4,$4,$A,$10,$1C,$E,$14,$A
	dw	$6,$16,$16,$C,$6,$2A,$9C
	ends
	data
~~disposible:
	db	$0,$1,$1,$1,$1,$1,$1,$1,$1,$1
	db	$1,$1,$1,$1,$1,$1,$1,$1,$1,$0
	db	$0,$0,$0,$1,$1,$1,$1,$1,$1
	ends
	code
	xdef	~~check_stack
	func
~~check_stack:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
count_0	set	4
	ldy	#$0
	lda	<L2+count_0
	bpl	L4
	dey
L4:
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
	sec
	lda	|~~basicvars+42
	sbc	<R0
	sta	<R1
	lda	|~~basicvars+42+2
	sbc	<R0+2
	sta	<R1+2
	lda	<R1
	cmp	|~~basicvars+38
	lda	<R1+2
	sbc	|~~basicvars+38+2
	bcc	L5
	brl	L10001
L5:
	pea	#<$5c
	pea	#4
	jsl	~~error
L10001:
L6:
	lda	<L2+2
	sta	<L2+2+2
	lda	<L2+1
	sta	<L2+1+2
	pld
	tsc
	clc
	adc	#L2+2
	tcs
	rtl
L2	equ	8
L3	equ	9
	ends
	efunc
	code
	xdef	~~safestack
	func
~~safestack:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L7
	tcs
	phd
	tcd
	stz	<R0
	lda	|~~basicvars+399
	ora	|~~basicvars+399+2
	beq	L10
	brl	L9
L10:
	lda	|~~basicvars+42
	sta	<R1
	lda	|~~basicvars+42+2
	sta	<R1+2
	lda	[<R1]
	cmp	#<$19
	beq	L11
	brl	L9
L11:
	inc	<R0
L9:
	lda	<R0
	and	#$ff
L12:
	tay
	pld
	tsc
	clc
	adc	#L7
	tcs
	tya
	rtl
L7	equ	8
L8	equ	9
	ends
	efunc
	code
	xdef	~~make_opstack
	func
~~make_opstack:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L13
	tcs
	phd
	tcd
	clc
	lda	#$ffd6
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	lda	#$ffff
	adc	|~~basicvars+42+2
	sta	|~~basicvars+42+2
	clc
	lda	#$ff88
	adc	|~~basicvars+42
	sta	<R0
	lda	#$ffff
	adc	|~~basicvars+42+2
	sta	<R0+2
	lda	<R0
	cmp	|~~basicvars+38
	lda	<R0+2
	sbc	|~~basicvars+38+2
	bcc	L15
	brl	L10002
L15:
	pea	#<$5c
	pea	#4
	jsl	~~error
L10002:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	#$19
	sta	[<R0]
	clc
	lda	#$2
	adc	|~~basicvars+42
	sta	<R0
	lda	#$0
	adc	|~~basicvars+42+2
	sta	<R0+2
	ldx	<R0+2
	lda	<R0
L16:
	tay
	pld
	tsc
	clc
	adc	#L13
	tcs
	tya
	rtl
L13	equ	4
L14	equ	5
	ends
	efunc
	code
	xdef	~~make_restart
	func
~~make_restart:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L17
	tcs
	phd
	tcd
	clc
	lda	#$ff64
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	lda	#$ffff
	adc	|~~basicvars+42+2
	sta	|~~basicvars+42+2
	lda	|~~basicvars+42
	cmp	|~~basicvars+38
	lda	|~~basicvars+42+2
	sbc	|~~basicvars+38+2
	bcc	L19
	brl	L10003
L19:
	pea	#<$5c
	pea	#4
	jsl	~~error
L10003:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	#$1a
	sta	[<R0]
	clc
	lda	#$2
	adc	|~~basicvars+42
	sta	<R0
	lda	#$0
	adc	|~~basicvars+42+2
	sta	<R0+2
	ldx	<R0+2
	lda	<R0
L20:
	tay
	pld
	tsc
	clc
	adc	#L17
	tcs
	tya
	rtl
L17	equ	4
L18	equ	5
	ends
	efunc
	code
	xdef	~~get_topitem
	func
~~get_topitem:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L21
	tcs
	phd
	tcd
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
L23:
	tay
	pld
	tsc
	clc
	adc	#L21
	tcs
	tya
	rtl
L21	equ	4
L22	equ	5
	ends
	efunc
	code
	xdef	~~get_stacktop
	func
~~get_stacktop:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L24
	tcs
	phd
	tcd
	ldx	|~~basicvars+42+2
	lda	|~~basicvars+42
L26:
	tay
	pld
	tsc
	clc
	adc	#L24
	tcs
	tya
	rtl
L24	equ	0
L25	equ	1
	ends
	efunc
	code
	xdef	~~get_safestack
	func
~~get_safestack:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L27
	tcs
	phd
	tcd
	ldx	|~~basicvars+46+2
	lda	|~~basicvars+46
L29:
	tay
	pld
	tsc
	clc
	adc	#L27
	tcs
	tya
	rtl
L27	equ	0
L28	equ	1
	ends
	efunc
	code
	xdef	~~push_int
	func
~~push_int:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L30
	tcs
	phd
	tcd
x_0	set	4
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
	lda	<L30+x_0
	ldy	#$2
	sta	[<R0],Y
L32:
	lda	<L30+2
	sta	<L30+2+2
	lda	<L30+1
	sta	<L30+1+2
	pld
	tsc
	clc
	adc	#L30+2
	tcs
	rtl
L30	equ	4
L31	equ	5
	ends
	efunc
	code
	xdef	~~push_float
	func
~~push_float:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L33
	tcs
	phd
	tcd
x_0	set	4
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
	lda	<L33+x_0
	ldy	#$2
	sta	[<R0],Y
	lda	<L33+x_0+2
	ldy	#$4
	sta	[<R0],Y
L35:
	lda	<L33+2
	sta	<L33+2+4
	lda	<L33+1
	sta	<L33+1+4
	pld
	tsc
	clc
	adc	#L33+4
	tcs
	rtl
L33	equ	4
L34	equ	5
	ends
	efunc
	code
	xdef	~~push_string
	func
~~push_string:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L36
	tcs
	phd
	tcd
x_0	set	4
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
	adc	#<L36+x_0
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
L38:
	lda	<L36+2
	sta	<L36+2+6
	lda	<L36+1
	sta	<L36+1+6
	pld
	tsc
	clc
	adc	#L36+6
	tcs
	rtl
L36	equ	4
L37	equ	5
	ends
	efunc
	code
	xdef	~~push_strtemp
	func
~~push_strtemp:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L39
	tcs
	phd
	tcd
stringlen_0	set	4
stringaddr_0	set	6
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
	lda	#$5
	sta	[<R0]
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	<L39+stringlen_0
	ldy	#$2
	sta	[<R0],Y
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	<L39+stringaddr_0
	ldy	#$4
	sta	[<R0],Y
	lda	<L39+stringaddr_0+2
	ldy	#$6
	sta	[<R0],Y
L41:
	lda	<L39+2
	sta	<L39+2+6
	lda	<L39+1
	sta	<L39+1+6
	pld
	tsc
	clc
	adc	#L39+6
	tcs
	rtl
L39	equ	4
L40	equ	5
	ends
	efunc
	code
	xdef	~~push_dolstring
	func
~~push_dolstring:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L42
	tcs
	phd
	tcd
strlength_0	set	4
strtext_0	set	6
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
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	<L42+strlength_0
	ldy	#$2
	sta	[<R0],Y
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	<L42+strtext_0
	ldy	#$4
	sta	[<R0],Y
	lda	<L42+strtext_0+2
	ldy	#$6
	sta	[<R0],Y
L44:
	lda	<L42+2
	sta	<L42+2+6
	lda	<L42+1
	sta	<L42+1+6
	pld
	tsc
	clc
	adc	#L42+6
	tcs
	rtl
L42	equ	4
L43	equ	5
	ends
	efunc
	data
~~arraytype:
	dw	$0,$0,$6,$8,$A,$0,$0,$0
	ends
	data
~~arraytemptype:
	dw	$0,$0,$7,$9,$B,$0,$0,$0
	ends
	code
	xdef	~~push_array
	func
~~push_array:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L45
	tcs
	phd
	tcd
descriptor_0	set	4
type_0	set	8
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
	lda	<L45+type_0
	and	#<$7
	sta	<R2
	lda	<R2
	asl	A
	sta	<R1
	ldx	<R1
	lda	|~~arraytype,X
	sta	[<R0]
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	<L45+descriptor_0
	ldy	#$2
	sta	[<R0],Y
	lda	<L45+descriptor_0+2
	ldy	#$4
	sta	[<R0],Y
L47:
	lda	<L45+2
	sta	<L45+2+6
	lda	<L45+1
	sta	<L45+1+6
	pld
	tsc
	clc
	adc	#L45+6
	tcs
	rtl
L45	equ	12
L46	equ	13
	ends
	efunc
	code
	xdef	~~push_arraytemp
	func
~~push_arraytemp:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L48
	tcs
	phd
	tcd
descriptor_0	set	4
type_0	set	8
	clc
	lda	#$ffe2
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	lda	#$ffff
	adc	|~~basicvars+42+2
	sta	|~~basicvars+42+2
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	<L48+type_0
	and	#<$7
	sta	<R2
	lda	<R2
	asl	A
	sta	<R1
	ldx	<R1
	lda	|~~arraytemptype,X
	sta	[<R0]
	pei	<L48+descriptor_0+2
	pei	<L48+descriptor_0
	clc
	lda	#$2
	adc	|~~basicvars+42
	sta	<R0
	lda	#$0
	adc	|~~basicvars+42+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$1c
	xref	~~~fmov
	jsl	~~~fmov
L50:
	lda	<L48+2
	sta	<L48+2+6
	lda	<L48+1
	sta	<L48+1+6
	pld
	tsc
	clc
	adc	#L48+6
	tcs
	rtl
L48	equ	12
L49	equ	13
	ends
	efunc
	code
	xdef	~~push_proc
	func
~~push_proc:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L51
	tcs
	phd
	tcd
name_0	set	4
count_0	set	8
	clc
	lda	#$fff0
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	lda	#$ffff
	adc	|~~basicvars+42+2
	sta	|~~basicvars+42+2
	lda	|~~basicvars+42
	cmp	|~~basicvars+38
	lda	|~~basicvars+42+2
	sbc	|~~basicvars+38+2
	bcc	L53
	brl	L10004
L53:
	pea	#<$5c
	pea	#4
	jsl	~~error
L10004:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	#$f
	sta	[<R0]
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	|~~basicvars+399
	ldy	#$2
	sta	[<R0],Y
	lda	|~~basicvars+399+2
	ldy	#$4
	sta	[<R0],Y
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	|~~basicvars+62
	ldy	#$6
	sta	[<R0],Y
	lda	|~~basicvars+62+2
	ldy	#$8
	sta	[<R0],Y
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	<L51+count_0
	ldy	#$a
	sta	[<R0],Y
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	<L51+name_0
	ldy	#$c
	sta	[<R0],Y
	lda	<L51+name_0+2
	ldy	#$e
	sta	[<R0],Y
	clc
	lda	#$2
	adc	|~~basicvars+42
	sta	|~~basicvars+399
	lda	#$0
	adc	|~~basicvars+42+2
	sta	|~~basicvars+399+2
L54:
	lda	<L51+2
	sta	<L51+2+6
	lda	<L51+1
	sta	<L51+1+6
	pld
	tsc
	clc
	adc	#L51+6
	tcs
	rtl
L51	equ	4
L52	equ	5
	ends
	efunc
	code
	xdef	~~push_fn
	func
~~push_fn:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L55
	tcs
	phd
	tcd
name_0	set	4
count_0	set	8
	clc
	lda	#$ffe4
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	lda	#$ffff
	adc	|~~basicvars+42+2
	sta	|~~basicvars+42+2
	lda	|~~basicvars+42
	cmp	|~~basicvars+38
	lda	|~~basicvars+42+2
	sbc	|~~basicvars+38+2
	bcc	L57
	brl	L10005
L57:
	pea	#<$5c
	pea	#4
	jsl	~~error
L10005:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	#$10
	sta	[<R0]
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	|~~basicvars+10
	ldy	#$10
	sta	[<R0],Y
	lda	|~~basicvars+10+2
	ldy	#$12
	sta	[<R0],Y
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	|~~basicvars+14
	ldy	#$14
	sta	[<R0],Y
	lda	|~~basicvars+14+2
	ldy	#$16
	sta	[<R0],Y
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	|~~basicvars+395
	ldy	#$18
	sta	[<R0],Y
	lda	|~~basicvars+395+2
	ldy	#$1a
	sta	[<R0],Y
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	|~~basicvars+399
	ldy	#$2
	sta	[<R0],Y
	lda	|~~basicvars+399+2
	ldy	#$4
	sta	[<R0],Y
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	|~~basicvars+62
	ldy	#$6
	sta	[<R0],Y
	lda	|~~basicvars+62+2
	ldy	#$8
	sta	[<R0],Y
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	<L55+count_0
	ldy	#$a
	sta	[<R0],Y
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	<L55+name_0
	ldy	#$c
	sta	[<R0],Y
	lda	<L55+name_0+2
	ldy	#$e
	sta	[<R0],Y
	clc
	lda	#$2
	adc	|~~basicvars+42
	sta	|~~basicvars+399
	lda	#$0
	adc	|~~basicvars+42+2
	sta	|~~basicvars+399+2
L58:
	lda	<L55+2
	sta	<L55+2+6
	lda	<L55+1
	sta	<L55+1+6
	pld
	tsc
	clc
	adc	#L55+6
	tcs
	rtl
L55	equ	4
L56	equ	5
	ends
	efunc
	code
	xdef	~~push_gosub
	func
~~push_gosub:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L59
	tcs
	phd
	tcd
	clc
	lda	#$fff6
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	lda	#$ffff
	adc	|~~basicvars+42+2
	sta	|~~basicvars+42+2
	lda	|~~basicvars+42
	cmp	|~~basicvars+38
	lda	|~~basicvars+42+2
	sbc	|~~basicvars+38+2
	bcc	L61
	brl	L10006
L61:
	pea	#<$5c
	pea	#4
	jsl	~~error
L10006:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	#$e
	sta	[<R0]
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	|~~basicvars+403
	ldy	#$2
	sta	[<R0],Y
	lda	|~~basicvars+403+2
	ldy	#$4
	sta	[<R0],Y
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	|~~basicvars+62
	ldy	#$6
	sta	[<R0],Y
	lda	|~~basicvars+62+2
	ldy	#$8
	sta	[<R0],Y
	clc
	lda	#$2
	adc	|~~basicvars+42
	sta	|~~basicvars+403
	lda	#$0
	adc	|~~basicvars+42+2
	sta	|~~basicvars+403+2
L62:
	pld
	tsc
	clc
	adc	#L59
	tcs
	rtl
L59	equ	4
L60	equ	5
	ends
	efunc
	code
	xdef	~~alloc_stackmem
	func
~~alloc_stackmem:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L63
	tcs
	phd
	tcd
size_0	set	4
p_1	set	0
base_1	set	4
	lda	<L63+size_0
	ina
	and	#<$fffffffe
	sta	<L63+size_0
	ldy	#$0
	lda	<L63+size_0
	bpl	L65
	dey
L65:
	sta	<R0
	sty	<R0+2
	sec
	lda	|~~basicvars+42
	sbc	<R0
	sta	<L64+base_1
	lda	|~~basicvars+42+2
	sbc	<R0+2
	sta	<L64+base_1+2
	clc
	lda	#$fffc
	adc	<L64+base_1
	sta	<L64+p_1
	lda	#$ffff
	adc	<L64+base_1+2
	sta	<L64+p_1+2
	lda	<L64+p_1
	cmp	|~~basicvars+38
	lda	<L64+p_1+2
	sbc	|~~basicvars+38+2
	bcc	L66
	brl	L10007
L66:
	lda	#$0
	tax
	lda	#$0
L67:
	tay
	lda	<L63+2
	sta	<L63+2+2
	lda	<L63+1
	sta	<L63+1+2
	pld
	tsc
	clc
	adc	#L63+2
	tcs
	tya
	rtl
L10007:
	lda	<L64+p_1
	sta	|~~basicvars+42
	lda	<L64+p_1+2
	sta	|~~basicvars+42+2
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	#$c
	sta	[<R0]
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	<L63+size_0
	ldy	#$2
	sta	[<R0],Y
	ldx	<L64+base_1+2
	lda	<L64+base_1
	brl	L67
L63	equ	12
L64	equ	5
	ends
	efunc
	code
	xdef	~~alloc_stackstrmem
	func
~~alloc_stackstrmem:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L68
	tcs
	phd
	tcd
size_0	set	4
p_1	set	0
	pei	<L68+size_0
	jsl	~~alloc_stackmem
	sta	<L69+p_1
	stx	<L69+p_1+2
	lda	<L69+p_1
	ora	<L69+p_1+2
	beq	L70
	brl	L10008
L70:
	lda	#$0
	tax
	lda	#$0
L71:
	tay
	lda	<L68+2
	sta	<L68+2+2
	lda	<L68+1
	sta	<L68+1+2
	pld
	tsc
	clc
	adc	#L68+2
	tcs
	tya
	rtl
L10008:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	#$d
	sta	[<R0]
	ldx	<L69+p_1+2
	lda	<L69+p_1
	brl	L71
L68	equ	8
L69	equ	5
	ends
	efunc
	code
	xdef	~~free_stackmem
	func
~~free_stackmem:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L72
	tcs
	phd
	tcd
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	ldy	#$0
	phy
	ldy	#$2
	lda	[<R0],Y
	ply
	rol	A
	ror	A
	bpl	L74
	dey
L74:
	sta	<R0
	sty	<R0+2
	clc
	lda	#$4
	adc	<R0
	sta	<R1
	lda	#$0
	adc	<R0+2
	sta	<R1+2
	clc
	lda	|~~basicvars+42
	adc	<R1
	sta	|~~basicvars+42
	lda	|~~basicvars+42+2
	adc	<R1+2
	sta	|~~basicvars+42+2
L75:
	pld
	tsc
	clc
	adc	#L72
	tcs
	rtl
L72	equ	8
L73	equ	9
	ends
	efunc
	code
	xdef	~~free_stackstrmem
	func
~~free_stackstrmem:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L76
	tcs
	phd
	tcd
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	ldy	#$2
	lda	[<R0],Y
	pha
	clc
	lda	#$4
	adc	|~~basicvars+42
	sta	<R0
	lda	#$0
	adc	|~~basicvars+42+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~discard_strings
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	ldy	#$0
	phy
	ldy	#$2
	lda	[<R0],Y
	ply
	rol	A
	ror	A
	bpl	L78
	dey
L78:
	sta	<R0
	sty	<R0+2
	clc
	lda	#$4
	adc	<R0
	sta	<R1
	lda	#$0
	adc	<R0+2
	sta	<R1+2
	clc
	lda	|~~basicvars+42
	adc	<R1
	sta	|~~basicvars+42
	lda	|~~basicvars+42+2
	adc	<R1+2
	sta	|~~basicvars+42+2
L79:
	pld
	tsc
	clc
	adc	#L76
	tcs
	rtl
L76	equ	8
L77	equ	9
	ends
	efunc
	code
	xdef	~~push_while
	func
~~push_while:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L80
	tcs
	phd
	tcd
expr_0	set	4
	clc
	lda	#$fff6
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	lda	#$ffff
	adc	|~~basicvars+42+2
	sta	|~~basicvars+42+2
	lda	|~~basicvars+42
	cmp	|~~basicvars+38
	lda	|~~basicvars+42+2
	sbc	|~~basicvars+38+2
	bcc	L82
	brl	L10009
L82:
	pea	#<$5c
	pea	#4
	jsl	~~error
L10009:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	#$13
	sta	[<R0]
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	<L80+expr_0
	ldy	#$2
	sta	[<R0],Y
	lda	<L80+expr_0+2
	ldy	#$4
	sta	[<R0],Y
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	|~~basicvars+62
	ldy	#$6
	sta	[<R0],Y
	lda	|~~basicvars+62+2
	ldy	#$8
	sta	[<R0],Y
L83:
	lda	<L80+2
	sta	<L80+2+4
	lda	<L80+1
	sta	<L80+1+4
	pld
	tsc
	clc
	adc	#L80+4
	tcs
	rtl
L80	equ	4
L81	equ	5
	ends
	efunc
	code
	xdef	~~push_repeat
	func
~~push_repeat:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L84
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
	cmp	|~~basicvars+38
	lda	|~~basicvars+42+2
	sbc	|~~basicvars+38+2
	bcc	L86
	brl	L10010
L86:
	pea	#<$5c
	pea	#4
	jsl	~~error
L10010:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	#$14
	sta	[<R0]
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	|~~basicvars+62
	ldy	#$2
	sta	[<R0],Y
	lda	|~~basicvars+62+2
	ldy	#$4
	sta	[<R0],Y
L87:
	pld
	tsc
	clc
	adc	#L84
	tcs
	rtl
L84	equ	4
L85	equ	5
	ends
	efunc
	code
	xdef	~~push_intfor
	func
~~push_intfor:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L88
	tcs
	phd
	tcd
forvar_0	set	4
foraddr_0	set	10
limit_0	set	14
step_0	set	16
simple_0	set	18
	clc
	lda	#$ffea
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	lda	#$ffff
	adc	|~~basicvars+42+2
	sta	|~~basicvars+42+2
	lda	|~~basicvars+42
	cmp	|~~basicvars+38
	lda	|~~basicvars+42+2
	sbc	|~~basicvars+38+2
	bcc	L90
	brl	L10011
L90:
	pea	#<$5c
	pea	#4
	jsl	~~error
L10011:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	#$15
	sta	[<R0]
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	<L88+simple_0
	ldy	#$2
	sta	[<R0],Y
	rep	#$20
	longa	on
	clc
	tdc
	adc	#<L88+forvar_0
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	lda	#$3
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
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	<L88+foraddr_0
	ldy	#$9
	sta	[<R0],Y
	lda	<L88+foraddr_0+2
	ldy	#$b
	sta	[<R0],Y
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	<L88+limit_0
	ldy	#$d
	sta	[<R0],Y
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	<L88+step_0
	ldy	#$f
	sta	[<R0],Y
L91:
	lda	<L88+2
	sta	<L88+2+16
	lda	<L88+1
	sta	<L88+1+16
	pld
	tsc
	clc
	adc	#L88+16
	tcs
	rtl
L88	equ	4
L89	equ	5
	ends
	efunc
	code
	xdef	~~push_floatfor
	func
~~push_floatfor:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L92
	tcs
	phd
	tcd
forvar_0	set	4
foraddr_0	set	10
limit_0	set	14
step_0	set	18
simple_0	set	22
	clc
	lda	#$ffea
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	lda	#$ffff
	adc	|~~basicvars+42+2
	sta	|~~basicvars+42+2
	lda	|~~basicvars+42
	cmp	|~~basicvars+38
	lda	|~~basicvars+42+2
	sbc	|~~basicvars+38+2
	bcc	L94
	brl	L10012
L94:
	pea	#<$5c
	pea	#4
	jsl	~~error
L10012:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	#$16
	sta	[<R0]
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	<L92+simple_0
	ldy	#$2
	sta	[<R0],Y
	rep	#$20
	longa	on
	clc
	tdc
	adc	#<L92+forvar_0
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	lda	#$3
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
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	<L92+foraddr_0
	ldy	#$9
	sta	[<R0],Y
	lda	<L92+foraddr_0+2
	ldy	#$b
	sta	[<R0],Y
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	<L92+limit_0
	ldy	#$d
	sta	[<R0],Y
	lda	<L92+limit_0+2
	ldy	#$f
	sta	[<R0],Y
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	<L92+step_0
	ldy	#$11
	sta	[<R0],Y
	lda	<L92+step_0+2
	ldy	#$13
	sta	[<R0],Y
L95:
	lda	<L92+2
	sta	<L92+2+20
	lda	<L92+1
	sta	<L92+1+20
	pld
	tsc
	clc
	adc	#L92+20
	tcs
	rtl
L92	equ	4
L93	equ	5
	ends
	efunc
	code
	xdef	~~push_data
	func
~~push_data:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L96
	tcs
	phd
	tcd
address_0	set	4
	clc
	lda	#$fffa
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	lda	#$ffff
	adc	|~~basicvars+42+2
	sta	|~~basicvars+42+2
	lda	|~~basicvars+42
	cmp	|~~basicvars+38
	lda	|~~basicvars+42+2
	sbc	|~~basicvars+38+2
	bcc	L98
	brl	L10013
L98:
	pea	#<$5c
	pea	#4
	jsl	~~error
L10013:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	#$18
	sta	[<R0]
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	<L96+address_0
	ldy	#$2
	sta	[<R0],Y
	lda	<L96+address_0+2
	ldy	#$4
	sta	[<R0],Y
L99:
	lda	<L96+2
	sta	<L96+2+4
	lda	<L96+1
	sta	<L96+1+4
	pld
	tsc
	clc
	adc	#L96+4
	tcs
	rtl
L96	equ	4
L97	equ	5
	ends
	efunc
	code
	xdef	~~push_error
	func
~~push_error:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L100
	tcs
	phd
	tcd
handler_0	set	4
	clc
	lda	#$fff4
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	lda	#$ffff
	adc	|~~basicvars+42+2
	sta	|~~basicvars+42+2
	lda	|~~basicvars+42
	cmp	|~~basicvars+38
	lda	|~~basicvars+42+2
	sbc	|~~basicvars+38+2
	bcc	L102
	brl	L10014
L102:
	pea	#<$5c
	pea	#4
	jsl	~~error
L10014:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	#$17
	sta	[<R0]
	clc
	tdc
	adc	#<L100+handler_0
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
	lda	#$9
	xref	~~~fmov
	jsl	~~~fmov
L103:
	lda	<L100+2
	sta	<L100+2+9
	lda	<L100+1
	sta	<L100+1+9
	pld
	tsc
	clc
	adc	#L100+9
	tcs
	rtl
L100	equ	4
L101	equ	5
	ends
	efunc
	code
	xdef	~~save_int
	func
~~save_int:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L104
	tcs
	phd
	tcd
details_0	set	4
value_0	set	10
	clc
	lda	#$fff2
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	lda	#$ffff
	adc	|~~basicvars+42+2
	sta	|~~basicvars+42+2
	lda	|~~basicvars+42
	cmp	|~~basicvars+38
	lda	|~~basicvars+42+2
	sbc	|~~basicvars+38+2
	bcc	L106
	brl	L10015
L106:
	pea	#<$5c
	pea	#4
	jsl	~~error
L10015:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	#$11
	sta	[<R0]
	clc
	tdc
	adc	#<L104+details_0
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
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	<L104+value_0
	ldy	#$8
	sta	[<R0],Y
L107:
	lda	<L104+2
	sta	<L104+2+8
	lda	<L104+1
	sta	<L104+1+8
	pld
	tsc
	clc
	adc	#L104+8
	tcs
	rtl
L104	equ	4
L105	equ	5
	ends
	efunc
	code
	xdef	~~save_float
	func
~~save_float:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L108
	tcs
	phd
	tcd
details_0	set	4
floatvalue_0	set	10
	clc
	lda	#$fff2
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	lda	#$ffff
	adc	|~~basicvars+42+2
	sta	|~~basicvars+42+2
	lda	|~~basicvars+42
	cmp	|~~basicvars+38
	lda	|~~basicvars+42+2
	sbc	|~~basicvars+38+2
	bcc	L110
	brl	L10016
L110:
	pea	#<$5c
	pea	#4
	jsl	~~error
L10016:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	#$11
	sta	[<R0]
	clc
	tdc
	adc	#<L108+details_0
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
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	<L108+floatvalue_0
	ldy	#$8
	sta	[<R0],Y
	lda	<L108+floatvalue_0+2
	ldy	#$a
	sta	[<R0],Y
L111:
	lda	<L108+2
	sta	<L108+2+10
	lda	<L108+1
	sta	<L108+1+10
	pld
	tsc
	clc
	adc	#L108+10
	tcs
	rtl
L108	equ	4
L109	equ	5
	ends
	efunc
	code
	xdef	~~save_string
	func
~~save_string:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L112
	tcs
	phd
	tcd
details_0	set	4
thestring_0	set	10
	clc
	lda	#$fff2
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	lda	#$ffff
	adc	|~~basicvars+42+2
	sta	|~~basicvars+42+2
	lda	|~~basicvars+42
	cmp	|~~basicvars+38
	lda	|~~basicvars+42+2
	sbc	|~~basicvars+38+2
	bcc	L114
	brl	L10017
L114:
	pea	#<$5c
	pea	#4
	jsl	~~error
L10017:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	#$11
	sta	[<R0]
	clc
	tdc
	adc	#<L112+details_0
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
	clc
	tdc
	adc	#<L112+thestring_0
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	lda	#$8
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
L115:
	lda	<L112+2
	sta	<L112+2+12
	lda	<L112+1
	sta	<L112+1+12
	pld
	tsc
	clc
	adc	#L112+12
	tcs
	rtl
L112	equ	4
L113	equ	5
	ends
	efunc
	code
	xdef	~~save_array
	func
~~save_array:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L116
	tcs
	phd
	tcd
details_0	set	4
	clc
	lda	#$fff2
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	lda	#$ffff
	adc	|~~basicvars+42+2
	sta	|~~basicvars+42+2
	lda	|~~basicvars+42
	cmp	|~~basicvars+38
	lda	|~~basicvars+42+2
	sbc	|~~basicvars+38+2
	bcc	L118
	brl	L10018
L118:
	pea	#<$5c
	pea	#4
	jsl	~~error
L10018:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	#$11
	sta	[<R0]
	clc
	tdc
	adc	#<L116+details_0
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
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<L116+details_0+2]
	ldy	#$8
	sta	[<R0],Y
	ldy	#$2
	lda	[<L116+details_0+2],Y
	ldy	#$a
	sta	[<R0],Y
L119:
	lda	<L116+2
	sta	<L116+2+6
	lda	<L116+1
	sta	<L116+1+6
	pld
	tsc
	clc
	adc	#L116+6
	tcs
	rtl
L116	equ	4
L117	equ	5
	ends
	efunc
	code
	xdef	~~save_retint
	func
~~save_retint:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L120
	tcs
	phd
	tcd
retdetails_0	set	4
details_0	set	10
value_0	set	16
	clc
	lda	#$ffec
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	lda	#$ffff
	adc	|~~basicvars+42+2
	sta	|~~basicvars+42+2
	lda	|~~basicvars+42
	cmp	|~~basicvars+38
	lda	|~~basicvars+42+2
	sbc	|~~basicvars+38+2
	bcc	L122
	brl	L10019
L122:
	pea	#<$5c
	pea	#4
	jsl	~~error
L10019:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	#$12
	sta	[<R0]
	clc
	tdc
	adc	#<L120+retdetails_0
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	lda	#$8
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
	clc
	tdc
	adc	#<L120+details_0
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
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	<L120+value_0
	ldy	#$e
	sta	[<R0],Y
L123:
	lda	<L120+2
	sta	<L120+2+14
	lda	<L120+1
	sta	<L120+1+14
	pld
	tsc
	clc
	adc	#L120+14
	tcs
	rtl
L120	equ	4
L121	equ	5
	ends
	efunc
	code
	xdef	~~save_retfloat
	func
~~save_retfloat:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L124
	tcs
	phd
	tcd
retdetails_0	set	4
details_0	set	10
floatvalue_0	set	16
	clc
	lda	#$ffec
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	lda	#$ffff
	adc	|~~basicvars+42+2
	sta	|~~basicvars+42+2
	lda	|~~basicvars+42
	cmp	|~~basicvars+38
	lda	|~~basicvars+42+2
	sbc	|~~basicvars+38+2
	bcc	L126
	brl	L10020
L126:
	pea	#<$5c
	pea	#4
	jsl	~~error
L10020:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	#$12
	sta	[<R0]
	clc
	tdc
	adc	#<L124+retdetails_0
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	lda	#$8
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
	clc
	tdc
	adc	#<L124+details_0
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
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	<L124+floatvalue_0
	ldy	#$e
	sta	[<R0],Y
	lda	<L124+floatvalue_0+2
	ldy	#$10
	sta	[<R0],Y
L127:
	lda	<L124+2
	sta	<L124+2+16
	lda	<L124+1
	sta	<L124+1+16
	pld
	tsc
	clc
	adc	#L124+16
	tcs
	rtl
L124	equ	4
L125	equ	5
	ends
	efunc
	code
	xdef	~~save_retstring
	func
~~save_retstring:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L128
	tcs
	phd
	tcd
retdetails_0	set	4
details_0	set	10
thestring_0	set	16
	clc
	lda	#$ffec
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	lda	#$ffff
	adc	|~~basicvars+42+2
	sta	|~~basicvars+42+2
	lda	|~~basicvars+42
	cmp	|~~basicvars+38
	lda	|~~basicvars+42+2
	sbc	|~~basicvars+38+2
	bcc	L130
	brl	L10021
L130:
	pea	#<$5c
	pea	#4
	jsl	~~error
L10021:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	#$12
	sta	[<R0]
	clc
	tdc
	adc	#<L128+retdetails_0
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	lda	#$8
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
	clc
	tdc
	adc	#<L128+details_0
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
	clc
	tdc
	adc	#<L128+thestring_0
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	lda	#$e
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
L131:
	lda	<L128+2
	sta	<L128+2+18
	lda	<L128+1
	sta	<L128+1+18
	pld
	tsc
	clc
	adc	#L128+18
	tcs
	rtl
L128	equ	4
L129	equ	5
	ends
	efunc
	code
	xdef	~~save_retarray
	func
~~save_retarray:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L132
	tcs
	phd
	tcd
retdetails_0	set	4
details_0	set	10
	clc
	lda	#$ffec
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	lda	#$ffff
	adc	|~~basicvars+42+2
	sta	|~~basicvars+42+2
	lda	|~~basicvars+42
	cmp	|~~basicvars+38
	lda	|~~basicvars+42+2
	sbc	|~~basicvars+38+2
	bcc	L134
	brl	L10022
L134:
	pea	#<$5c
	pea	#4
	jsl	~~error
L10022:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	#$12
	sta	[<R0]
	clc
	tdc
	adc	#<L132+retdetails_0
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	lda	#$8
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
	clc
	tdc
	adc	#<L132+details_0
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
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<L132+details_0+2]
	ldy	#$e
	sta	[<R0],Y
	ldy	#$2
	lda	[<L132+details_0+2],Y
	ldy	#$10
	sta	[<R0],Y
L135:
	lda	<L132+2
	sta	<L132+2+12
	lda	<L132+1
	sta	<L132+1+12
	pld
	tsc
	clc
	adc	#L132+12
	tcs
	rtl
L132	equ	4
L133	equ	5
	ends
	efunc
	code
	xdef	~~restore_retparm
	func
~~restore_retparm:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L136
	tcs
	phd
	tcd
parmcount_0	set	4
p_1	set	0
vartype_1	set	4
intvalue_1	set	6
floatvalue_1	set	8
stringvalue_1	set	12
	lda	|~~basicvars+42
	sta	<L137+p_1
	lda	|~~basicvars+42+2
	sta	<L137+p_1+2
	clc
	lda	#$14
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	bcc	L138
	inc	|~~basicvars+42+2
L138:
	ldy	#$2
	lda	[<L137+p_1],Y
	and	#<$1f
	brl	L10023
L10025:
	ldy	#$4
	lda	[<L137+p_1],Y
	sta	<R0
	ldy	#$6
	lda	[<L137+p_1],Y
	sta	<R0+2
	lda	[<R0]
	sta	<L137+intvalue_1
	ldy	#$4
	lda	[<L137+p_1],Y
	sta	<R0
	ldy	#$6
	lda	[<L137+p_1],Y
	sta	<R0+2
	ldy	#$e
	lda	[<L137+p_1],Y
	sta	[<R0]
	lda	#$2
	sta	<L137+vartype_1
	brl	L10024
L10026:
	ldy	#$4
	lda	[<L137+p_1],Y
	sta	<R0
	ldy	#$6
	lda	[<L137+p_1],Y
	sta	<R0+2
	lda	[<R0]
	sta	<L137+floatvalue_1
	ldy	#$2
	lda	[<R0],Y
	sta	<L137+floatvalue_1+2
	ldy	#$4
	lda	[<L137+p_1],Y
	sta	<R0
	ldy	#$6
	lda	[<L137+p_1],Y
	sta	<R0+2
	ldy	#$e
	lda	[<L137+p_1],Y
	sta	[<R0]
	ldy	#$10
	lda	[<L137+p_1],Y
	ldy	#$2
	sta	[<R0],Y
	lda	#$3
	sta	<L137+vartype_1
	brl	L10024
L10027:
	ldy	#$6
	lda	[<L137+p_1],Y
	pha
	ldy	#$4
	lda	[<L137+p_1],Y
	pha
	clc
	tdc
	adc	#<L137+stringvalue_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	clc
	lda	#$e
	adc	<L137+p_1
	sta	<R0
	lda	#$0
	adc	<L137+p_1+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	ldy	#$6
	lda	[<L137+p_1],Y
	pha
	ldy	#$4
	lda	[<L137+p_1],Y
	pha
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	lda	#$4
	sta	<L137+vartype_1
	brl	L10024
L10028:
	ldy	#$4
	lda	[<L137+p_1],Y
	sta	<R0
	lda	|~~basicvars+6
	sta	<R1
	lda	|~~basicvars+6+2
	sta	<R1+2
	ldy	<R0
	lda	[<R1],Y
	and	#$ff
	sta	<L137+intvalue_1
	ldy	#$4
	lda	[<L137+p_1],Y
	sta	<R0
	lda	|~~basicvars+6
	sta	<R1
	lda	|~~basicvars+6+2
	sta	<R1+2
	sep	#$20
	longa	off
	ldy	#$e
	lda	[<L137+p_1],Y
	ldy	<R0
	sta	[<R1],Y
	rep	#$20
	longa	on
	lda	#$2
	sta	<L137+vartype_1
	brl	L10024
L10029:
	ldy	#$4
	lda	[<L137+p_1],Y
	pha
	jsl	~~get_integer
	sta	<L137+intvalue_1
	ldy	#$e
	lda	[<L137+p_1],Y
	pha
	ldy	#$4
	lda	[<L137+p_1],Y
	pha
	jsl	~~store_integer
	lda	#$2
	sta	<L137+vartype_1
	brl	L10024
L10030:
	phy
	phy
	ldy	#$4
	lda	[<L137+p_1],Y
	pha
	jsl	~~get_float
	pla
	sta	<L137+floatvalue_1
	pla
	sta	<L137+floatvalue_1+2
	ldy	#$10
	lda	[<L137+p_1],Y
	pha
	ldy	#$e
	lda	[<L137+p_1],Y
	pha
	ldy	#$4
	lda	[<L137+p_1],Y
	pha
	jsl	~~store_float
	lda	#$3
	sta	<L137+vartype_1
	brl	L10024
L10031:
	ldy	#$4
	lda	[<L137+p_1],Y
	pha
	jsl	~~get_stringlen
	sta	<L137+stringvalue_1
	lda	<L137+stringvalue_1
	sta	<L137+intvalue_1
	pei	<L137+intvalue_1
	jsl	~~alloc_string
	sta	<L137+stringvalue_1+2
	stx	<L137+stringvalue_1+4
	sec
	lda	#$0
	sbc	<L137+intvalue_1
	bvs	L139
	eor	#$8000
L139:
	bpl	L140
	brl	L10032
L140:
	ldy	#$0
	lda	<L137+intvalue_1
	bpl	L141
	dey
L141:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	ldy	#$0
	phy
	ldy	#$4
	lda	[<L137+p_1],Y
	ply
	rol	A
	ror	A
	bpl	L142
	dey
L142:
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
	pei	<L137+stringvalue_1+4
	pei	<L137+stringvalue_1+2
	jsl	~~memmove
L10032:
	ldy	#$0
	phy
	ldy	#$e
	lda	[<L137+p_1],Y
	ply
	rol	A
	ror	A
	bpl	L143
	dey
L143:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	ldy	#$12
	lda	[<L137+p_1],Y
	pha
	ldy	#$10
	lda	[<L137+p_1],Y
	pha
	ldy	#$0
	phy
	ldy	#$4
	lda	[<L137+p_1],Y
	ply
	rol	A
	ror	A
	bpl	L144
	dey
L144:
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
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	lda	#$e
	adc	<L137+p_1
	sta	<R1
	lda	#$0
	adc	<L137+p_1+2
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
	lda	#$15
	sta	<L137+vartype_1
	brl	L10024
L10033:
L10034:
L10035:
	brl	L10024
L10036:
	pea	#^L1
	pea	#<L1
	pea	#<$2ba
	pea	#<$82
	pea	#10
	jsl	~~error
	brl	L10024
L10023:
	xref	~~~fsw
	jsl	~~~fsw
	dw	2
	dw	20
	dw	L10036-1
	dw	L10025-1
	dw	L10026-1
	dw	L10027-1
	dw	L10036-1
	dw	L10036-1
	dw	L10036-1
	dw	L10036-1
	dw	L10036-1
	dw	L10033-1
	dw	L10034-1
	dw	L10035-1
	dw	L10036-1
	dw	L10036-1
	dw	L10036-1
	dw	L10036-1
	dw	L10028-1
	dw	L10029-1
	dw	L10030-1
	dw	L10036-1
	dw	L10031-1
L10024:
	dec	<L136+parmcount_0
	sec
	lda	#$0
	sbc	<L136+parmcount_0
	bvs	L145
	eor	#$8000
L145:
	bpl	L146
	brl	L10037
L146:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$11
	beq	L147
	brl	L10038
L147:
	pei	<L136+parmcount_0
	jsl	~~restore
	brl	L10039
L10038:
	pei	<L136+parmcount_0
	jsl	~~restore_retparm
L10039:
L10037:
	ldy	#$8
	lda	[<L137+p_1],Y
	brl	L10040
L10042:
	ldy	#$a
	lda	[<L137+p_1],Y
	sta	<R0
	ldy	#$c
	lda	[<L137+p_1],Y
	sta	<R0+2
	lda	<L137+vartype_1
	cmp	#<$2
	beq	L149
	brl	L148
L149:
	lda	<L137+intvalue_1
	bra	L150
L148:
	pei	<L137+floatvalue_1+2
	pei	<L137+floatvalue_1
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R1
	pla
	sta	<R1+2
	lda	<R1
L150:
	sta	[<R0]
	brl	L10041
L10043:
	ldy	#$a
	lda	[<L137+p_1],Y
	sta	<R0
	ldy	#$c
	lda	[<L137+p_1],Y
	sta	<R0+2
	lda	<L137+vartype_1
	cmp	#<$2
	beq	L152
	brl	L151
L152:
	ldy	#$0
	lda	<L137+intvalue_1
	bpl	L153
	dey
L153:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	bra	L154
L151:
	pei	<L137+floatvalue_1+2
	pei	<L137+floatvalue_1
L154:
	pla
	sta	[<R0]
	pla
	ldy	#$2
	sta	[<R0],Y
	brl	L10041
L10044:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	ldy	#$c
	lda	[<L137+p_1],Y
	pha
	ldy	#$a
	lda	[<L137+p_1],Y
	pha
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
	clc
	tdc
	adc	#<L137+stringvalue_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	ldy	#$c
	lda	[<L137+p_1],Y
	pha
	ldy	#$a
	lda	[<L137+p_1],Y
	pha
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	brl	L10041
L10045:
	ldy	#$a
	lda	[<L137+p_1],Y
	sta	<R0
	lda	|~~basicvars+6
	sta	<R1
	lda	|~~basicvars+6+2
	sta	<R1+2
	lda	<L137+vartype_1
	cmp	#<$2
	beq	L156
	brl	L155
L156:
	lda	<L137+intvalue_1
	bra	L157
L155:
	pei	<L137+floatvalue_1+2
	pei	<L137+floatvalue_1
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R2
	pla
	sta	<R2+2
	lda	<R2
L157:
	sep	#$20
	longa	off
	ldy	<R0
	sta	[<R1],Y
	rep	#$20
	longa	on
	brl	L10041
L10046:
	lda	<L137+vartype_1
	cmp	#<$2
	beq	L159
	brl	L158
L159:
	lda	<L137+intvalue_1
	bra	L160
L158:
	pei	<L137+floatvalue_1+2
	pei	<L137+floatvalue_1
	xref	~~~ffix
	jsl	~~~ffix
	pla
	sta	<R0
	pla
	sta	<R0+2
	lda	<R0
L160:
	pha
	ldy	#$a
	lda	[<L137+p_1],Y
	pha
	jsl	~~store_integer
	brl	L10041
L10047:
	lda	<L137+vartype_1
	cmp	#<$2
	beq	L162
	brl	L161
L162:
	ldy	#$0
	lda	<L137+intvalue_1
	bpl	L163
	dey
L163:
	phy
	pha
	xref	~~~fflt
	jsl	~~~fflt
	bra	L164
L161:
	pei	<L137+floatvalue_1+2
	pei	<L137+floatvalue_1
L164:
	ldy	#$a
	lda	[<L137+p_1],Y
	pha
	jsl	~~store_float
	brl	L10041
L10048:
	sec
	lda	#$0
	sbc	<L137+stringvalue_1
	bvs	L165
	eor	#$8000
L165:
	bpl	L166
	brl	L10049
L166:
	ldy	#$0
	lda	<L137+stringvalue_1
	bpl	L167
	dey
L167:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L137+stringvalue_1+4
	pei	<L137+stringvalue_1+2
	ldy	#$0
	phy
	ldy	#$a
	lda	[<L137+p_1],Y
	ply
	rol	A
	ror	A
	bpl	L168
	dey
L168:
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
L10049:
	lda	<L137+vartype_1
	cmp	#<$4
	beq	L169
	brl	L10050
L169:
	clc
	ldy	#$a
	lda	[<L137+p_1],Y
	adc	<L137+stringvalue_1
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
L10050:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L137+stringvalue_1
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
	brl	L10041
L10051:
L10052:
L10053:
	brl	L10041
L10054:
	pea	#^L1+6
	pea	#<L1+6
	pea	#<$2e8
	pea	#<$82
	pea	#10
	jsl	~~error
	brl	L10041
L10040:
	xref	~~~fsw
	jsl	~~~fsw
	dw	2
	dw	20
	dw	L10054-1
	dw	L10042-1
	dw	L10043-1
	dw	L10044-1
	dw	L10054-1
	dw	L10054-1
	dw	L10054-1
	dw	L10054-1
	dw	L10054-1
	dw	L10051-1
	dw	L10052-1
	dw	L10053-1
	dw	L10054-1
	dw	L10054-1
	dw	L10054-1
	dw	L10054-1
	dw	L10045-1
	dw	L10046-1
	dw	L10047-1
	dw	L10054-1
	dw	L10048-1
L10041:
L170:
	lda	<L136+2
	sta	<L136+2+2
	lda	<L136+1
	sta	<L136+1+2
	pld
	tsc
	clc
	adc	#L136+2
	tcs
	rtl
L136	equ	30
L137	equ	13
	ends
	efunc
	data
L1:
	db	$73,$74,$61,$63,$6B,$00,$73,$74,$61,$63,$6B,$00
	ends
	code
	xdef	~~restore
	func
~~restore:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L172
	tcs
	phd
	tcd
parmcount_0	set	4
p_1	set	0
localitem_1	set	4
L10057:
	lda	|~~basicvars+42
	sta	<L173+p_1
	lda	|~~basicvars+42+2
	sta	<L173+p_1+2
	clc
	lda	#$e
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	bcc	L174
	inc	|~~basicvars+42+2
L174:
	ldy	#$2
	lda	[<L173+p_1],Y
	cmp	#<$2
	beq	L175
	brl	L10058
L175:
	ldy	#$4
	lda	[<L173+p_1],Y
	sta	<R0
	ldy	#$6
	lda	[<L173+p_1],Y
	sta	<R0+2
	ldy	#$8
	lda	[<L173+p_1],Y
	sta	[<R0]
	brl	L10059
L10058:
	ldy	#$2
	lda	[<L173+p_1],Y
	and	#<$1f
	brl	L10060
L10062:
	ldy	#$4
	lda	[<L173+p_1],Y
	sta	<R0
	ldy	#$6
	lda	[<L173+p_1],Y
	sta	<R0+2
	ldy	#$8
	lda	[<L173+p_1],Y
	sta	[<R0]
	ldy	#$a
	lda	[<L173+p_1],Y
	ldy	#$2
	sta	[<R0],Y
	brl	L10061
L10063:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	ldy	#$6
	lda	[<L173+p_1],Y
	pha
	ldy	#$4
	lda	[<L173+p_1],Y
	pha
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
	clc
	lda	#$8
	adc	<L173+p_1
	sta	<R0
	lda	#$0
	adc	<L173+p_1+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	ldy	#$6
	lda	[<L173+p_1],Y
	pha
	ldy	#$4
	lda	[<L173+p_1],Y
	pha
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	brl	L10061
L10064:
	ldy	#$4
	lda	[<L173+p_1],Y
	sta	<R0
	lda	|~~basicvars+6
	sta	<R1
	lda	|~~basicvars+6+2
	sta	<R1+2
	sep	#$20
	longa	off
	ldy	#$8
	lda	[<L173+p_1],Y
	ldy	<R0
	sta	[<R1],Y
	rep	#$20
	longa	on
	brl	L10061
L10065:
	ldy	#$8
	lda	[<L173+p_1],Y
	pha
	ldy	#$4
	lda	[<L173+p_1],Y
	pha
	jsl	~~store_integer
	brl	L10061
L10066:
	ldy	#$a
	lda	[<L173+p_1],Y
	pha
	ldy	#$8
	lda	[<L173+p_1],Y
	pha
	ldy	#$4
	lda	[<L173+p_1],Y
	pha
	jsl	~~store_float
	brl	L10061
L10067:
	ldy	#$0
	phy
	ldy	#$8
	lda	[<L173+p_1],Y
	ply
	rol	A
	ror	A
	bpl	L176
	dey
L176:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	ldy	#$c
	lda	[<L173+p_1],Y
	pha
	ldy	#$a
	lda	[<L173+p_1],Y
	pha
	ldy	#$0
	phy
	ldy	#$4
	lda	[<L173+p_1],Y
	ply
	rol	A
	ror	A
	bpl	L177
	dey
L177:
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
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	lda	#$8
	adc	<L173+p_1
	sta	<R1
	lda	#$0
	adc	<L173+p_1+2
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
	brl	L10061
L10068:
L10069:
L10070:
	ldy	#$4
	lda	[<L173+p_1],Y
	sta	<R0
	ldy	#$6
	lda	[<L173+p_1],Y
	sta	<R0+2
	ldy	#$8
	lda	[<L173+p_1],Y
	sta	[<R0]
	ldy	#$a
	lda	[<L173+p_1],Y
	ldy	#$2
	sta	[<R0],Y
	brl	L10061
L10071:
	pea	#^L171
	pea	#<L171
	pea	#<$314
	pea	#<$82
	pea	#10
	jsl	~~error
	brl	L10061
L10060:
	xref	~~~fsw
	jsl	~~~fsw
	dw	3
	dw	19
	dw	L10071-1
	dw	L10062-1
	dw	L10063-1
	dw	L10071-1
	dw	L10071-1
	dw	L10071-1
	dw	L10071-1
	dw	L10071-1
	dw	L10068-1
	dw	L10069-1
	dw	L10070-1
	dw	L10071-1
	dw	L10071-1
	dw	L10071-1
	dw	L10071-1
	dw	L10064-1
	dw	L10065-1
	dw	L10066-1
	dw	L10071-1
	dw	L10067-1
L10061:
L10059:
	dec	<L172+parmcount_0
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L173+localitem_1
L10055:
	sec
	lda	#$0
	sbc	<L172+parmcount_0
	bvs	L179
	eor	#$8000
L179:
	bpl	L180
	brl	L178
L180:
	lda	<L173+localitem_1
	cmp	#<$11
	bne	L181
	brl	L10057
L181:
L178:
L10056:
	sec
	lda	#$0
	sbc	<L172+parmcount_0
	bvs	L182
	eor	#$8000
L182:
	bpl	L183
	brl	L10072
L183:
	lda	<L173+localitem_1
	cmp	#<$12
	beq	L184
	brl	L10072
L184:
	pei	<L172+parmcount_0
	jsl	~~restore_retparm
L10072:
L185:
	lda	<L172+2
	sta	<L172+2+2
	lda	<L172+1
	sta	<L172+1+2
	pld
	tsc
	clc
	adc	#L172+2
	tcs
	rtl
L172	equ	18
L173	equ	13
	ends
	efunc
	data
L171:
	db	$73,$74,$61,$63,$6B,$00
	ends
	code
	xdef	~~restore_parameters
	func
~~restore_parameters:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L187
	tcs
	phd
	tcd
parmcount_0	set	4
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	#<$11
	beq	L189
	brl	L10073
L189:
	pei	<L187+parmcount_0
	jsl	~~restore
	brl	L10074
L10073:
	pei	<L187+parmcount_0
	jsl	~~restore_retparm
L10074:
L190:
	lda	<L187+2
	sta	<L187+2+2
	lda	<L187+1
	sta	<L187+1+2
	pld
	tsc
	clc
	adc	#L187+2
	tcs
	rtl
L187	equ	4
L188	equ	5
	ends
	efunc
	code
	xdef	~~pop_int
	func
~~pop_int:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L191
	tcs
	phd
	tcd
p_1	set	0
	lda	|~~basicvars+42
	sta	<L192+p_1
	lda	|~~basicvars+42+2
	sta	<L192+p_1+2
	clc
	lda	#$4
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	bcc	L193
	inc	|~~basicvars+42+2
L193:
	ldy	#$2
	lda	[<L192+p_1],Y
L194:
	tay
	pld
	tsc
	clc
	adc	#L191
	tcs
	tya
	rtl
L191	equ	4
L192	equ	1
	ends
	efunc
	code
	xdef	~~pop_float
	func
~~pop_float:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L195
	tcs
	phd
	tcd
p_1	set	0
	lda	|~~basicvars+42
	sta	<L196+p_1
	lda	|~~basicvars+42+2
	sta	<L196+p_1+2
	clc
	lda	#$6
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	bcc	L197
	inc	|~~basicvars+42+2
L197:
	ldy	#$2
	lda	[<L196+p_1],Y
	sta	<L195+4
	ldy	#$4
	lda	[<L196+p_1],Y
	sta	<L195+6
L198:
	pld
	tsc
	clc
	adc	#L195+0
	tcs
	rtl
L195	equ	4
L196	equ	1
	ends
	efunc
	code
	xdef	~~pop_string
	func
~~pop_string:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L199
	tcs
	phd
	tcd
	udata
L10075:
	ds	6
	ends
p_1	set	0
	lda	|~~basicvars+42
	sta	<L200+p_1
	lda	|~~basicvars+42+2
	sta	<L200+p_1+2
	clc
	lda	#$8
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	bcc	L201
	inc	|~~basicvars+42+2
L201:
	clc
	lda	#$2
	adc	<L200+p_1
	sta	<R0
	lda	#$0
	adc	<L200+p_1+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	pea	#^L10075
	pea	#<L10075
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	lda	#^L10075
	tax
	lda	#<L10075
L202:
	tay
	pld
	tsc
	clc
	adc	#L199
	tcs
	tya
	rtl
L199	equ	8
L200	equ	5
	ends
	efunc
	code
	xdef	~~pop_array
	func
~~pop_array:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L203
	tcs
	phd
	tcd
p_1	set	0
	lda	|~~basicvars+42
	sta	<L204+p_1
	lda	|~~basicvars+42+2
	sta	<L204+p_1+2
	clc
	lda	#$6
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	bcc	L205
	inc	|~~basicvars+42+2
L205:
	ldy	#$4
	lda	[<L204+p_1],Y
	tax
	ldy	#$2
	lda	[<L204+p_1],Y
L206:
	tay
	pld
	tsc
	clc
	adc	#L203
	tcs
	tya
	rtl
L203	equ	4
L204	equ	1
	ends
	efunc
	code
	xdef	~~pop_arraytemp
	func
~~pop_arraytemp:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L207
	tcs
	phd
	tcd
	udata
L10076:
	ds	28
	ends
p_1	set	0
	lda	|~~basicvars+42
	sta	<L208+p_1
	lda	|~~basicvars+42+2
	sta	<L208+p_1+2
	clc
	lda	#$1e
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	bcc	L209
	inc	|~~basicvars+42+2
L209:
	clc
	lda	#$2
	adc	<L208+p_1
	sta	<R0
	lda	#$0
	adc	<L208+p_1+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	pea	#^L10076
	pea	#<L10076
	lda	#$1c
	xref	~~~fmov
	jsl	~~~fmov
	lda	#^L10076
	tax
	lda	#<L10076
L210:
	tay
	pld
	tsc
	clc
	adc	#L207
	tcs
	tya
	rtl
L207	equ	8
L208	equ	5
	ends
	efunc
	code
	xdef	~~pop_proc
	func
~~pop_proc:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L211
	tcs
	phd
	tcd
	udata
L10077:
	ds	14
	ends
p_1	set	0
	lda	|~~basicvars+42
	sta	<L212+p_1
	lda	|~~basicvars+42+2
	sta	<L212+p_1+2
	ldy	#$2
	lda	[<L212+p_1],Y
	sta	|~~basicvars+399
	ldy	#$4
	lda	[<L212+p_1],Y
	sta	|~~basicvars+399+2
	clc
	lda	#$10
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	bcc	L213
	inc	|~~basicvars+42+2
L213:
	clc
	lda	#$2
	adc	<L212+p_1
	sta	<R0
	lda	#$0
	adc	<L212+p_1+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	pea	#^L10077
	pea	#<L10077
	lda	#$e
	xref	~~~fmov
	jsl	~~~fmov
	lda	#^L10077
	tax
	lda	#<L10077
L214:
	tay
	pld
	tsc
	clc
	adc	#L211
	tcs
	tya
	rtl
L211	equ	8
L212	equ	5
	ends
	efunc
	code
	xdef	~~pop_fn
	func
~~pop_fn:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L215
	tcs
	phd
	tcd
	udata
L10078:
	ds	14
	ends
p_1	set	0
	lda	|~~basicvars+42
	sta	<L216+p_1
	lda	|~~basicvars+42+2
	sta	<L216+p_1+2
	ldy	#$10
	lda	[<L216+p_1],Y
	sta	|~~basicvars+10
	ldy	#$12
	lda	[<L216+p_1],Y
	sta	|~~basicvars+10+2
	ldy	#$14
	lda	[<L216+p_1],Y
	sta	|~~basicvars+14
	ldy	#$16
	lda	[<L216+p_1],Y
	sta	|~~basicvars+14+2
	ldy	#$18
	lda	[<L216+p_1],Y
	sta	|~~basicvars+395
	ldy	#$1a
	lda	[<L216+p_1],Y
	sta	|~~basicvars+395+2
	ldy	#$2
	lda	[<L216+p_1],Y
	sta	|~~basicvars+399
	ldy	#$4
	lda	[<L216+p_1],Y
	sta	|~~basicvars+399+2
	clc
	lda	#$1c
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	bcc	L217
	inc	|~~basicvars+42+2
L217:
	clc
	lda	#$2
	adc	<L216+p_1
	sta	<R0
	lda	#$0
	adc	<L216+p_1+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	pea	#^L10078
	pea	#<L10078
	lda	#$e
	xref	~~~fmov
	jsl	~~~fmov
	lda	#^L10078
	tax
	lda	#<L10078
L218:
	tay
	pld
	tsc
	clc
	adc	#L215
	tcs
	tya
	rtl
L215	equ	8
L216	equ	5
	ends
	efunc
	code
	xdef	~~pop_gosub
	func
~~pop_gosub:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L219
	tcs
	phd
	tcd
	udata
L10079:
	ds	8
	ends
p_1	set	0
	lda	|~~basicvars+42
	sta	<L220+p_1
	lda	|~~basicvars+42+2
	sta	<L220+p_1+2
	ldy	#$2
	lda	[<L220+p_1],Y
	sta	|~~basicvars+403
	ldy	#$4
	lda	[<L220+p_1],Y
	sta	|~~basicvars+403+2
	clc
	lda	#$a
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	bcc	L221
	inc	|~~basicvars+42+2
L221:
	clc
	lda	#$2
	adc	<L220+p_1
	sta	<R0
	lda	#$0
	adc	<L220+p_1+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	pea	#^L10079
	pea	#<L10079
	lda	#$8
	xref	~~~fmov
	jsl	~~~fmov
	lda	#^L10079
	tax
	lda	#<L10079
L222:
	tay
	pld
	tsc
	clc
	adc	#L219
	tcs
	tya
	rtl
L219	equ	8
L220	equ	5
	ends
	efunc
	code
	func
~~discard:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L223
	tcs
	phd
	tcd
item_0	set	4
temp_1	set	0
	lda	<L223+item_0
	brl	L10080
L10082:
	jsl	~~pop_string
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	tdc
	adc	#<L224+temp_1
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
	adc	#<L224+temp_1
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
	brl	L10081
L10083:
	pea	#<$1
	jsl	~~restore
	brl	L10081
L10084:
	pea	#<$1
	jsl	~~restore_retparm
	brl	L10081
L10085:
	jsl	~~pop_gosub
	brl	L10081
L10086:
	jsl	~~pop_proc
	brl	L10081
L10087:
	jsl	~~pop_fn
	brl	L10081
L10088:
	jsl	~~pop_error
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	pea	#<~~basicvars+232
	lda	#$9
	xref	~~~fnmov
	jsl	~~~fnmov
	brl	L10081
L10089:
	jsl	~~pop_data
	sta	|~~basicvars+407
	stx	|~~basicvars+407+2
	brl	L10081
L10090:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	clc
	lda	|~~entrysize+24
	ldy	#$2
	adc	[<R0],Y
	sta	<R1
	ldy	#$0
	lda	<R1
	bpl	L225
	dey
L225:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars+42
	adc	<R0
	sta	|~~basicvars+42
	lda	|~~basicvars+42+2
	adc	<R0+2
	sta	|~~basicvars+42+2
	brl	L10081
L10091:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	ldy	#$2
	lda	[<R0],Y
	pha
	ldy	#$0
	lda	|~~entrysize+24
	bpl	L226
	dey
L226:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars+42
	adc	<R0
	sta	<R1
	lda	|~~basicvars+42+2
	adc	<R0+2
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	jsl	~~discard_strings
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	clc
	lda	|~~entrysize+24
	ldy	#$2
	adc	[<R0],Y
	sta	<R1
	ldy	#$0
	lda	<R1
	bpl	L227
	dey
L227:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars+42
	adc	<R0
	sta	|~~basicvars+42
	lda	|~~basicvars+42+2
	adc	<R0+2
	sta	|~~basicvars+42+2
	brl	L10081
L10092:
	lda	<L223+item_0
	bne	L229
	brl	L228
L229:
	sec
	lda	<L223+item_0
	sbc	#<$1b
	bvs	L230
	eor	#$8000
L230:
	bmi	L231
	brl	L10093
L231:
L228:
	pea	#^L186
	pea	#<L186
	pea	#<$3ca
	pea	#<$82
	pea	#10
	jsl	~~error
L10093:
	lda	<L223+item_0
	asl	A
	sta	<R0
	ldy	#$0
	ldx	<R0
	lda	|~~entrysize,X
	bpl	L232
	dey
L232:
	sta	<R1
	sty	<R1+2
	clc
	lda	|~~basicvars+42
	adc	<R1
	sta	|~~basicvars+42
	lda	|~~basicvars+42+2
	adc	<R1+2
	sta	|~~basicvars+42+2
	brl	L10081
L10080:
	xref	~~~fsw
	jsl	~~~fsw
	dw	5
	dw	20
	dw	L10092-1
	dw	L10082-1
	dw	L10092-1
	dw	L10092-1
	dw	L10092-1
	dw	L10092-1
	dw	L10092-1
	dw	L10092-1
	dw	L10090-1
	dw	L10091-1
	dw	L10085-1
	dw	L10086-1
	dw	L10087-1
	dw	L10083-1
	dw	L10084-1
	dw	L10092-1
	dw	L10092-1
	dw	L10092-1
	dw	L10092-1
	dw	L10088-1
	dw	L10089-1
L10081:
L233:
	lda	<L223+2
	sta	<L223+2+2
	lda	<L223+1
	sta	<L223+1+2
	pld
	tsc
	clc
	adc	#L223+2
	tcs
	rtl
L223	equ	14
L224	equ	9
	ends
	efunc
	data
L186:
	db	$73,$74,$61,$63,$6B,$00
	ends
	code
	xdef	~~get_while
	func
~~get_while:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L235
	tcs
	phd
	tcd
item_1	set	0
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L236+item_1
L10094:
	ldx	<L236+item_1
	lda	|~~disposible,X
	and	#$ff
	bne	L237
	brl	L10095
L237:
	pei	<L236+item_1
	jsl	~~discard
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L236+item_1
	lda	<L236+item_1
	cmp	#<$13
	beq	L238
	brl	L10096
L238:
	ldx	|~~basicvars+42+2
	lda	|~~basicvars+42
L239:
	tay
	pld
	tsc
	clc
	adc	#L235
	tcs
	tya
	rtl
L10096:
	brl	L10094
L10095:
	lda	#$0
	tax
	lda	#$0
	brl	L239
L235	equ	6
L236	equ	5
	ends
	efunc
	code
	xdef	~~pop_while
	func
~~pop_while:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L240
	tcs
	phd
	tcd
	clc
	lda	#$a
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	bcc	L242
	inc	|~~basicvars+42+2
L242:
L243:
	pld
	tsc
	clc
	adc	#L240
	tcs
	rtl
L240	equ	0
L241	equ	1
	ends
	efunc
	code
	xdef	~~get_repeat
	func
~~get_repeat:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L244
	tcs
	phd
	tcd
item_1	set	0
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L245+item_1
L10097:
	ldx	<L245+item_1
	lda	|~~disposible,X
	and	#$ff
	bne	L246
	brl	L10098
L246:
	pei	<L245+item_1
	jsl	~~discard
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L245+item_1
	lda	<L245+item_1
	cmp	#<$14
	beq	L247
	brl	L10099
L247:
	ldx	|~~basicvars+42+2
	lda	|~~basicvars+42
L248:
	tay
	pld
	tsc
	clc
	adc	#L244
	tcs
	tya
	rtl
L10099:
	brl	L10097
L10098:
	lda	#$0
	tax
	lda	#$0
	brl	L248
L244	equ	6
L245	equ	5
	ends
	efunc
	code
	xdef	~~pop_repeat
	func
~~pop_repeat:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L249
	tcs
	phd
	tcd
	clc
	lda	#$6
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	bcc	L251
	inc	|~~basicvars+42+2
L251:
L252:
	pld
	tsc
	clc
	adc	#L249
	tcs
	rtl
L249	equ	0
L250	equ	1
	ends
	efunc
	code
	xdef	~~get_for
	func
~~get_for:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L253
	tcs
	phd
	tcd
item_1	set	0
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L254+item_1
L10100:
	ldx	<L254+item_1
	lda	|~~disposible,X
	and	#$ff
	bne	L255
	brl	L10101
L255:
	pei	<L254+item_1
	jsl	~~discard
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	sta	<L254+item_1
	lda	<L254+item_1
	cmp	#<$15
	bne	L257
	brl	L256
L257:
	lda	<L254+item_1
	cmp	#<$16
	beq	L258
	brl	L10102
L258:
L256:
	ldx	|~~basicvars+42+2
	lda	|~~basicvars+42
L259:
	tay
	pld
	tsc
	clc
	adc	#L253
	tcs
	tya
	rtl
L10102:
	brl	L10100
L10101:
	lda	#$0
	tax
	lda	#$0
	brl	L259
L253	equ	6
L254	equ	5
	ends
	efunc
	code
	xdef	~~pop_for
	func
~~pop_for:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L260
	tcs
	phd
	tcd
	clc
	lda	#$16
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	bcc	L262
	inc	|~~basicvars+42+2
L262:
L263:
	pld
	tsc
	clc
	adc	#L260
	tcs
	rtl
L260	equ	0
L261	equ	1
	ends
	efunc
	code
	xdef	~~pop_data
	func
~~pop_data:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L264
	tcs
	phd
	tcd
p_1	set	0
	lda	|~~basicvars+42
	sta	<L265+p_1
	lda	|~~basicvars+42+2
	sta	<L265+p_1+2
	clc
	lda	#$6
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	bcc	L266
	inc	|~~basicvars+42+2
L266:
	ldy	#$4
	lda	[<L265+p_1],Y
	tax
	ldy	#$2
	lda	[<L265+p_1],Y
L267:
	tay
	pld
	tsc
	clc
	adc	#L264
	tcs
	tya
	rtl
L264	equ	4
L265	equ	1
	ends
	efunc
	code
	xdef	~~pop_error
	func
~~pop_error:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L268
	tcs
	phd
	tcd
	udata
L10103:
	ds	9
	ends
p_1	set	0
	lda	|~~basicvars+42
	sta	<L269+p_1
	lda	|~~basicvars+42+2
	sta	<L269+p_1+2
	clc
	lda	#$c
	adc	|~~basicvars+42
	sta	|~~basicvars+42
	bcc	L270
	inc	|~~basicvars+42+2
L270:
	clc
	lda	#$2
	adc	<L269+p_1
	sta	<R0
	lda	#$0
	adc	<L269+p_1+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	pea	#^L10103
	pea	#<L10103
	lda	#$9
	xref	~~~fmov
	jsl	~~~fmov
	lda	#^L10103
	tax
	lda	#<L10103
L271:
	tay
	pld
	tsc
	clc
	adc	#L268
	tcs
	tya
	rtl
L268	equ	8
L269	equ	5
	ends
	efunc
	code
	xdef	~~empty_stack
	func
~~empty_stack:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L272
	tcs
	phd
	tcd
required_0	set	4
L10106:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	pha
	jsl	~~discard
L10104:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	cmp	<L272+required_0
	beq	L274
	brl	L10106
L274:
L10105:
L275:
	lda	<L272+2
	sta	<L272+2+2
	lda	<L272+1
	sta	<L272+1+2
	pld
	tsc
	clc
	adc	#L272+2
	tcs
	rtl
L272	equ	4
L273	equ	5
	ends
	efunc
	code
	xdef	~~reset_stack
	func
~~reset_stack:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L276
	tcs
	phd
	tcd
newstacktop_0	set	4
L10107:
	lda	|~~basicvars+42
	cmp	<L276+newstacktop_0
	lda	|~~basicvars+42+2
	sbc	<L276+newstacktop_0+2
	bcc	L278
	brl	L10108
L278:
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	[<R0]
	pha
	jsl	~~discard
	brl	L10107
L10108:
	lda	|~~basicvars+42
	cmp	|~~basicvars+46
	bne	L279
	lda	|~~basicvars+42+2
	cmp	|~~basicvars+46+2
L279:
	bne	L280
	brl	L10109
L280:
	lda	|~~basicvars+42
	cmp	<L276+newstacktop_0
	bne	L281
	lda	|~~basicvars+42+2
	cmp	<L276+newstacktop_0+2
L281:
	bne	L282
	brl	L10109
L282:
	lda	|~~basicvars+46
	sta	|~~basicvars+42
	lda	|~~basicvars+46+2
	sta	|~~basicvars+42+2
	pea	#^L234
	pea	#<L234
	pea	#<$456
	pea	#<$82
	pea	#10
	jsl	~~error
L10109:
L283:
	lda	<L276+2
	sta	<L276+2+4
	lda	<L276+1
	sta	<L276+1+4
	pld
	tsc
	clc
	adc	#L276+4
	tcs
	rtl
L276	equ	4
L277	equ	5
	ends
	efunc
	data
L234:
	db	$73,$74,$61,$63,$6B,$00
	ends
	code
	xdef	~~init_stack
	func
~~init_stack:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L285
	tcs
	phd
	tcd
	lda	|~~basicvars+50
	sta	|~~basicvars+42
	lda	|~~basicvars+50+2
	sta	|~~basicvars+42+2
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
	lda	#$0
	sta	[<R0]
	lda	|~~basicvars+42
	sta	<R0
	lda	|~~basicvars+42+2
	sta	<R0+2
	lda	#$5453
	ldy	#$2
	sta	[<R0],Y
	lda	|~~basicvars+42
	sta	|~~basicvars+46
	lda	|~~basicvars+42+2
	sta	|~~basicvars+46+2
L287:
	pld
	tsc
	clc
	adc	#L285
	tcs
	rtl
L285	equ	4
L286	equ	5
	ends
	efunc
	code
	xdef	~~clear_stack
	func
~~clear_stack:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L288
	tcs
	phd
	tcd
	lda	|~~basicvars+46
	sta	|~~basicvars+42
	lda	|~~basicvars+46+2
	sta	|~~basicvars+42+2
	stz	|~~basicvars+399
	stz	|~~basicvars+399+2
	stz	|~~basicvars+403
	stz	|~~basicvars+403+2
L290:
	pld
	tsc
	clc
	adc	#L288
	tcs
	rtl
L288	equ	0
L289	equ	1
	ends
	efunc
	xref	~~error
	xref	~~get_stringlen
	xref	~~discard_strings
	xref	~~free_string
	xref	~~alloc_string
	xref	~~store_float
	xref	~~store_integer
	xref	~~get_float
	xref	~~get_integer
	xref	~~memmove
	xref	~~basicvars
	end
