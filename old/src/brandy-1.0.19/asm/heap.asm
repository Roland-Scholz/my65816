;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
	code
	xdef	~~init_heap
	func
~~init_heap:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
	pea	#^$1000
	pea	#<$1000
	jsl	~~malloc
	sta	|~~basicvars+70
	stx	|~~basicvars+70+2
	stz	<R0
	lda	|~~basicvars+70
	ora	|~~basicvars+70+2
	bne	L5
	brl	L4
L5:
	inc	<R0
L4:
	lda	<R0
	and	#$ff
L6:
	tay
	pld
	tsc
	clc
	adc	#L2
	tcs
	tya
	rtl
L2	equ	4
L3	equ	5
	ends
	efunc
	code
	xdef	~~init_workspace
	func
~~init_workspace:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L7
	tcs
	phd
	tcd
heapsize_0	set	4
wp_1	set	0
	lda	<L7+heapsize_0
	beq	L9
	brl	L10001
L9:
	stz	<L7+heapsize_0
	brl	L10002
L10001:
	sec
	lda	<L7+heapsize_0
	sbc	#<$2800
	bvs	L10
	eor	#$8000
L10:
	bpl	L11
	brl	L10003
L11:
	lda	#$2800
	sta	<L7+heapsize_0
	brl	L10004
L10003:
	lda	<L7+heapsize_0
	ina
	and	#<$fffffffe
	sta	<L7+heapsize_0
L10004:
L10002:
	ldy	#$0
	lda	<L7+heapsize_0
	bpl	L12
	dey
L12:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~malloc
	sta	<L8+wp_1
	stx	<L8+wp_1+2
	lda	<L8+wp_1
	ora	<L8+wp_1+2
	beq	L13
	brl	L10005
L13:
	stz	<L7+heapsize_0
L10005:
	lda	<L7+heapsize_0
	sta	|~~basicvars+4
	lda	<L8+wp_1
	sta	|~~basicvars
	lda	<L8+wp_1+2
	sta	|~~basicvars+2
	lda	<L8+wp_1
	sta	|~~basicvars+18
	lda	<L8+wp_1+2
	sta	|~~basicvars+18+2
	ldy	#$0
	lda	|~~basicvars+4
	bpl	L14
	dey
L14:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L8+wp_1
	adc	<R0
	sta	|~~basicvars+50
	lda	<L8+wp_1+2
	adc	<R0+2
	sta	|~~basicvars+50+2
	lda	|~~basicvars+50
	sta	|~~basicvars+54
	lda	|~~basicvars+50+2
	sta	|~~basicvars+54+2
	lda	|~~basicvars+50
	sta	|~~basicvars+58
	lda	|~~basicvars+50+2
	sta	|~~basicvars+58+2
	lda	<L8+wp_1
	sta	|~~basicvars+6
	lda	<L8+wp_1+2
	sta	|~~basicvars+6+2
	stz	<R0
	lda	<L8+wp_1
	ora	<L8+wp_1+2
	bne	L16
	brl	L15
L16:
	inc	<R0
L15:
	lda	<R0
	and	#$ff
L17:
	tay
	lda	<L7+2
	sta	<L7+2+2
	lda	<L7+1
	sta	<L7+1+2
	pld
	tsc
	clc
	adc	#L7+2
	tcs
	tya
	rtl
L7	equ	8
L8	equ	5
	ends
	efunc
	code
	xdef	~~release_workspace
	func
~~release_workspace:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L18
	tcs
	phd
	tcd
	lda	|~~basicvars
	ora	|~~basicvars+2
	bne	L20
	brl	L10006
L20:
	lda	|~~basicvars+2
	pha
	lda	|~~basicvars
	pha
	jsl	~~free
	stz	|~~basicvars
	stz	|~~basicvars+2
	stz	|~~basicvars+4
L10006:
L21:
	pld
	tsc
	clc
	adc	#L18
	tcs
	rtl
L18	equ	0
L19	equ	1
	ends
	efunc
	code
	xdef	~~release_heap
	func
~~release_heap:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L22
	tcs
	phd
	tcd
lp_1	set	0
lp2_1	set	4
	lda	|~~basicvars+415
	sta	<L23+lp_1
	lda	|~~basicvars+415+2
	sta	<L23+lp_1+2
L10007:
	lda	<L23+lp_1
	ora	<L23+lp_1+2
	bne	L24
	brl	L10008
L24:
	lda	[<L23+lp_1]
	sta	<L23+lp2_1
	ldy	#$2
	lda	[<L23+lp_1],Y
	sta	<L23+lp2_1+2
	ldy	#$6
	lda	[<L23+lp_1],Y
	pha
	ldy	#$4
	lda	[<L23+lp_1],Y
	pha
	jsl	~~free
	pei	<L23+lp_1+2
	pei	<L23+lp_1
	jsl	~~free
	lda	<L23+lp2_1
	sta	<L23+lp_1
	lda	<L23+lp2_1+2
	sta	<L23+lp_1+2
	brl	L10007
L10008:
	jsl	~~release_workspace
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	jsl	~~free
	lda	|~~basicvars+419
	ora	|~~basicvars+419+2
	bne	L25
	brl	L10009
L25:
	lda	|~~basicvars+419+2
	pha
	lda	|~~basicvars+419
	pha
	jsl	~~free
L10009:
L26:
	pld
	tsc
	clc
	adc	#L22
	tcs
	rtl
L22	equ	8
L23	equ	1
	ends
	efunc
	code
	xdef	~~allocmem
	func
~~allocmem:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L27
	tcs
	phd
	tcd
size_0	set	4
newlimit_1	set	0
	lda	<L27+size_0
	ina
	and	#<$fffffffe
	sta	<L27+size_0
	ldy	#$0
	lda	<L27+size_0
	bpl	L29
	dey
L29:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars+38
	adc	<R0
	sta	<L28+newlimit_1
	lda	|~~basicvars+38+2
	adc	<R0+2
	sta	<L28+newlimit_1+2
	lda	<L28+newlimit_1
	cmp	|~~basicvars+42
	lda	<L28+newlimit_1+2
	sbc	|~~basicvars+42+2
	bcs	L30
	brl	L10010
L30:
	pea	#<$59
	pea	#4
	jsl	~~error
L10010:
	lda	<L28+newlimit_1
	sta	|~~basicvars+38
	lda	<L28+newlimit_1+2
	sta	|~~basicvars+38+2
	lda	|~~basicvars+34
	sta	<L28+newlimit_1
	lda	|~~basicvars+34+2
	sta	<L28+newlimit_1+2
	ldy	#$0
	lda	<L27+size_0
	bpl	L31
	dey
L31:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars+34
	adc	<R0
	sta	|~~basicvars+34
	lda	|~~basicvars+34+2
	adc	<R0+2
	sta	|~~basicvars+34+2
	ldx	<L28+newlimit_1+2
	lda	<L28+newlimit_1
L32:
	tay
	lda	<L27+2
	sta	<L27+2+2
	lda	<L27+1
	sta	<L27+1+2
	pld
	tsc
	clc
	adc	#L27+2
	tcs
	tya
	rtl
L27	equ	8
L28	equ	5
	ends
	efunc
	code
	xdef	~~condalloc
	func
~~condalloc:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L33
	tcs
	phd
	tcd
size_0	set	4
newlimit_1	set	0
	lda	<L33+size_0
	ina
	and	#<$fffffffe
	sta	<L33+size_0
	ldy	#$0
	lda	<L33+size_0
	bpl	L35
	dey
L35:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars+38
	adc	<R0
	sta	<L34+newlimit_1
	lda	|~~basicvars+38+2
	adc	<R0+2
	sta	<L34+newlimit_1+2
	lda	<L34+newlimit_1
	cmp	|~~basicvars+42
	lda	<L34+newlimit_1+2
	sbc	|~~basicvars+42+2
	bcs	L36
	brl	L10011
L36:
	lda	#$0
	tax
	lda	#$0
L37:
	tay
	lda	<L33+2
	sta	<L33+2+2
	lda	<L33+1
	sta	<L33+1+2
	pld
	tsc
	clc
	adc	#L33+2
	tcs
	tya
	rtl
L10011:
	lda	<L34+newlimit_1
	sta	|~~basicvars+38
	lda	<L34+newlimit_1+2
	sta	|~~basicvars+38+2
	lda	|~~basicvars+34
	sta	<L34+newlimit_1
	lda	|~~basicvars+34+2
	sta	<L34+newlimit_1+2
	ldy	#$0
	lda	<L33+size_0
	bpl	L38
	dey
L38:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars+34
	adc	<R0
	sta	|~~basicvars+34
	lda	|~~basicvars+34+2
	adc	<R0+2
	sta	|~~basicvars+34+2
	ldx	<L34+newlimit_1+2
	lda	<L34+newlimit_1
	brl	L37
L33	equ	8
L34	equ	5
	ends
	efunc
	code
	xdef	~~freemem
	func
~~freemem:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L39
	tcs
	phd
	tcd
where_0	set	4
size_0	set	8
	ldy	#$0
	lda	<L39+size_0
	bpl	L41
	dey
L41:
	sta	<R0
	sty	<R0+2
	sec
	lda	|~~basicvars+34
	sbc	<R0
	sta	|~~basicvars+34
	lda	|~~basicvars+34+2
	sbc	<R0+2
	sta	|~~basicvars+34+2
	ldy	#$0
	lda	<L39+size_0
	bpl	L42
	dey
L42:
	sta	<R0
	sty	<R0+2
	sec
	lda	|~~basicvars+38
	sbc	<R0
	sta	|~~basicvars+38
	lda	|~~basicvars+38+2
	sbc	<R0+2
	sta	|~~basicvars+38+2
L43:
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
	xdef	~~returnable
	func
~~returnable:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L44
	tcs
	phd
	tcd
where_0	set	4
size_0	set	8
	lda	<L44+size_0
	ina
	and	#<$fffffffe
	sta	<L44+size_0
	stz	<R0
	ldy	#$0
	lda	<L44+size_0
	bpl	L47
	dey
L47:
	sta	<R1
	sty	<R1+2
	clc
	lda	<L44+where_0
	adc	<R1
	sta	<R2
	lda	<L44+where_0+2
	adc	<R1+2
	sta	<R2+2
	lda	|~~basicvars+34
	cmp	<R2
	bne	L48
	lda	|~~basicvars+34+2
	cmp	<R2+2
L48:
	beq	L49
	brl	L46
L49:
	inc	<R0
L46:
	lda	<R0
	and	#$ff
L50:
	tay
	lda	<L44+2
	sta	<L44+2+6
	lda	<L44+1
	sta	<L44+1+6
	pld
	tsc
	clc
	adc	#L44+6
	tcs
	tya
	rtl
L44	equ	12
L45	equ	13
	ends
	efunc
	code
	xdef	~~mark_basicheap
	func
~~mark_basicheap:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L51
	tcs
	phd
	tcd
	lda	|~~basicvars+34
	sta	|~~basicvars+66
	lda	|~~basicvars+34+2
	sta	|~~basicvars+66+2
L53:
	pld
	tsc
	clc
	adc	#L51
	tcs
	rtl
L51	equ	0
L52	equ	1
	ends
	efunc
	code
	xdef	~~release_basicheap
	func
~~release_basicheap:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L54
	tcs
	phd
	tcd
	lda	|~~basicvars+66
	sta	|~~basicvars+34
	lda	|~~basicvars+66+2
	sta	|~~basicvars+34+2
	clc
	lda	#$100
	adc	|~~basicvars+34
	sta	|~~basicvars+38
	lda	#$0
	adc	|~~basicvars+34+2
	sta	|~~basicvars+38+2
L56:
	pld
	tsc
	clc
	adc	#L54
	tcs
	rtl
L54	equ	0
L55	equ	1
	ends
	efunc
	code
	xdef	~~clear_heap
	func
~~clear_heap:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L57
	tcs
	phd
	tcd
	lda	|~~basicvars+30
	sta	|~~basicvars+34
	lda	|~~basicvars+30+2
	sta	|~~basicvars+34+2
	clc
	lda	#$100
	adc	|~~basicvars+30
	sta	|~~basicvars+38
	lda	#$0
	adc	|~~basicvars+30+2
	sta	|~~basicvars+38+2
L59:
	pld
	tsc
	clc
	adc	#L57
	tcs
	rtl
L57	equ	0
L58	equ	1
	ends
	efunc
	xref	~~error
	xref	~~free
	xref	~~malloc
	xref	~~basicvars
	end
