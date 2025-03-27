;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
	code
	xdef	~~isapath
	func
~~isapath:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
name_0	set	4
	stz	<R0
	pea	#^L1
	pea	#<L1
	pei	<L2+name_0+2
	pei	<L2+name_0
	jsl	~~strpbrk
	lda	<R1
	ora	<R1+2
	bne	L5
	brl	L4
L5:
	inc	<R0
L4:
L6:
	tay
	lda	<L2+2
	sta	<L2+2+4
	lda	<L2+1
	sta	<L2+1+4
	pld
	tsc
	clc
	adc	#L2+4
	tcs
	tya
	rtl
L2	equ	8
L3	equ	9
	ends
	efunc
	data
L1:
	db	$2F,$00
	ends
	code
	func
~~map_handle:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L8
	tcs
	phd
	tcd
handle_0	set	4
	sec
	lda	#$fe
	sbc	<L8+handle_0
	sta	<L8+handle_0
	lda	<L8+handle_0
	bpl	L11
	brl	L10
L11:
	sec
	lda	<L8+handle_0
	sbc	#<$19
	bvs	L12
	eor	#$8000
L12:
	bpl	L13
	brl	L10
L13:
	lda	<L8+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L8+handle_0
	sta	<R0
	ldx	<R0
	lda	|~~fileinfo+4,X
	beq	L14
	brl	L10001
L14:
L10:
	pea	#<$7c
	pea	#4
	jsl	~~error
L10001:
	lda	<L8+handle_0
L15:
	tay
	lda	<L8+2
	sta	<L8+2+2
	lda	<L8+1
	sta	<L8+1+2
	pld
	tsc
	clc
	adc	#L8+2
	tcs
	tya
	rtl
L8	equ	4
L9	equ	5
	ends
	efunc
	code
	xdef	~~fileio_openin
	func
~~fileio_openin:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L16
	tcs
	phd
	tcd
name_0	set	4
namelen_0	set	8
thefile_1	set	0
n_1	set	4
filename_1	set	6
	stz	<L17+n_1
	brl	L10005
L10004:
L10002:
	inc	<L17+n_1
L10005:
	sec
	lda	<L17+n_1
	sbc	#<$19
	bvs	L19
	eor	#$8000
L19:
	bpl	L20
	brl	L18
L20:
	lda	<L17+n_1
	asl	A
	asl	A
	asl	A
	adc	<L17+n_1
	sta	<R0
	clc
	lda	#<~~fileinfo
	adc	<R0
	sta	<R1
	lda	(<R1)
	ldy	#$2
	ora	(<R1),Y
	beq	L21
	brl	L10004
L21:
L18:
L10003:
	sec
	lda	<L17+n_1
	sbc	#<$19
	bvs	L22
	eor	#$8000
L22:
	bmi	L23
	brl	L10006
L23:
	pea	#<$80
	pea	#4
	jsl	~~error
L10006:
	ldy	#$0
	lda	<L16+namelen_0
	bpl	L24
	dey
L24:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L16+name_0+2
	pei	<L16+name_0
	pea	#0
	clc
	tdc
	adc	#<L17+filename_1
	pha
	jsl	~~memmove
	sep	#$20
	longa	off
	lda	#$0
	ldx	<L16+namelen_0
	sta	<L17+filename_1,X
	rep	#$20
	longa	on
	pea	#^L7
	pea	#<L7
	pea	#0
	clc
	tdc
	adc	#<L17+filename_1
	pha
	jsl	~~fopen
	sta	<L17+thefile_1
	stx	<L17+thefile_1+2
	lda	<L17+thefile_1
	ora	<L17+thefile_1+2
	beq	L25
	brl	L10007
L25:
	lda	#$0
L26:
	tay
	lda	<L16+2
	sta	<L16+2+6
	lda	<L16+1
	sta	<L16+1+6
	pld
	tsc
	clc
	adc	#L16+6
	tcs
	tya
	rtl
L10007:
	lda	<L17+n_1
	asl	A
	asl	A
	asl	A
	adc	<L17+n_1
	sta	<R0
	clc
	lda	#<~~fileinfo
	adc	<R0
	sta	<R1
	lda	<L17+thefile_1
	sta	(<R1)
	lda	<L17+thefile_1+2
	ldy	#$2
	sta	(<R1),Y
	lda	<L17+n_1
	asl	A
	asl	A
	asl	A
	adc	<L17+n_1
	sta	<R0
	lda	#$1
	ldx	<R0
	sta	|~~fileinfo+4,X
	lda	<L17+n_1
	asl	A
	asl	A
	asl	A
	adc	<L17+n_1
	sta	<R0
	lda	#$0
	ldx	<R0
	sta	|~~fileinfo+6,X
	lda	<L17+n_1
	asl	A
	asl	A
	asl	A
	adc	<L17+n_1
	sta	<R0
	sep	#$20
	longa	off
	lda	#$0
	ldx	<R0
	sta	|~~fileinfo+8,X
	rep	#$20
	longa	on
	sec
	lda	#$fe
	sbc	<L17+n_1
	brl	L26
L16	equ	30
L17	equ	9
	ends
	efunc
	data
L7:
	db	$72,$00
	ends
	code
	xdef	~~fileio_openout
	func
~~fileio_openout:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L28
	tcs
	phd
	tcd
name_0	set	4
namelen_0	set	8
thefile_1	set	0
n_1	set	4
filename_1	set	6
	stz	<L29+n_1
	brl	L10011
L10010:
L10008:
	inc	<L29+n_1
L10011:
	sec
	lda	<L29+n_1
	sbc	#<$19
	bvs	L31
	eor	#$8000
L31:
	bpl	L32
	brl	L30
L32:
	lda	<L29+n_1
	asl	A
	asl	A
	asl	A
	adc	<L29+n_1
	sta	<R0
	clc
	lda	#<~~fileinfo
	adc	<R0
	sta	<R1
	lda	(<R1)
	ldy	#$2
	ora	(<R1),Y
	beq	L33
	brl	L10010
L33:
L30:
L10009:
	sec
	lda	<L29+n_1
	sbc	#<$19
	bvs	L34
	eor	#$8000
L34:
	bmi	L35
	brl	L10012
L35:
	pea	#<$80
	pea	#4
	jsl	~~error
L10012:
	ldy	#$0
	lda	<L28+namelen_0
	bpl	L36
	dey
L36:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L28+name_0+2
	pei	<L28+name_0
	pea	#0
	clc
	tdc
	adc	#<L29+filename_1
	pha
	jsl	~~memmove
	sep	#$20
	longa	off
	lda	#$0
	ldx	<L28+namelen_0
	sta	<L29+filename_1,X
	rep	#$20
	longa	on
	pea	#^L27
	pea	#<L27
	pea	#0
	clc
	tdc
	adc	#<L29+filename_1
	pha
	jsl	~~fopen
	sta	<L29+thefile_1
	stx	<L29+thefile_1+2
	lda	<L29+thefile_1
	ora	<L29+thefile_1+2
	beq	L37
	brl	L10013
L37:
	pea	#0
	clc
	tdc
	adc	#<L29+filename_1
	pha
	pea	#<$6f
	pea	#8
	jsl	~~error
L10013:
	lda	<L29+n_1
	asl	A
	asl	A
	asl	A
	adc	<L29+n_1
	sta	<R0
	clc
	lda	#<~~fileinfo
	adc	<R0
	sta	<R1
	lda	<L29+thefile_1
	sta	(<R1)
	lda	<L29+thefile_1+2
	ldy	#$2
	sta	(<R1),Y
	lda	<L29+n_1
	asl	A
	asl	A
	asl	A
	adc	<L29+n_1
	sta	<R0
	lda	#$3
	ldx	<R0
	sta	|~~fileinfo+4,X
	lda	<L29+n_1
	asl	A
	asl	A
	asl	A
	adc	<L29+n_1
	sta	<R0
	lda	#$0
	ldx	<R0
	sta	|~~fileinfo+6,X
	lda	<L29+n_1
	asl	A
	asl	A
	asl	A
	adc	<L29+n_1
	sta	<R0
	sep	#$20
	longa	off
	lda	#$0
	ldx	<R0
	sta	|~~fileinfo+8,X
	rep	#$20
	longa	on
	sec
	lda	#$fe
	sbc	<L29+n_1
L38:
	tay
	lda	<L28+2
	sta	<L28+2+6
	lda	<L28+1
	sta	<L28+1+6
	pld
	tsc
	clc
	adc	#L28+6
	tcs
	tya
	rtl
L28	equ	30
L29	equ	9
	ends
	efunc
	data
L27:
	db	$77,$2B,$00
	ends
	code
	xdef	~~fileio_openup
	func
~~fileio_openup:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L40
	tcs
	phd
	tcd
name_0	set	4
namelen_0	set	8
thefile_1	set	0
n_1	set	4
filename_1	set	6
	stz	<L41+n_1
	brl	L10017
L10016:
L10014:
	inc	<L41+n_1
L10017:
	sec
	lda	<L41+n_1
	sbc	#<$19
	bvs	L43
	eor	#$8000
L43:
	bpl	L44
	brl	L42
L44:
	lda	<L41+n_1
	asl	A
	asl	A
	asl	A
	adc	<L41+n_1
	sta	<R0
	clc
	lda	#<~~fileinfo
	adc	<R0
	sta	<R1
	lda	(<R1)
	ldy	#$2
	ora	(<R1),Y
	beq	L45
	brl	L10016
L45:
L42:
L10015:
	sec
	lda	<L41+n_1
	sbc	#<$19
	bvs	L46
	eor	#$8000
L46:
	bmi	L47
	brl	L10018
L47:
	pea	#<$80
	pea	#4
	jsl	~~error
L10018:
	ldy	#$0
	lda	<L40+namelen_0
	bpl	L48
	dey
L48:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L40+name_0+2
	pei	<L40+name_0
	pea	#0
	clc
	tdc
	adc	#<L41+filename_1
	pha
	jsl	~~memmove
	sep	#$20
	longa	off
	lda	#$0
	ldx	<L40+namelen_0
	sta	<L41+filename_1,X
	rep	#$20
	longa	on
	pea	#^L39
	pea	#<L39
	pea	#0
	clc
	tdc
	adc	#<L41+filename_1
	pha
	jsl	~~fopen
	sta	<L41+thefile_1
	stx	<L41+thefile_1+2
	lda	<L41+thefile_1
	ora	<L41+thefile_1+2
	beq	L49
	brl	L10019
L49:
	pea	#0
	clc
	tdc
	adc	#<L41+filename_1
	pha
	pea	#<$70
	pea	#8
	jsl	~~error
L10019:
	lda	<L41+n_1
	asl	A
	asl	A
	asl	A
	adc	<L41+n_1
	sta	<R0
	clc
	lda	#<~~fileinfo
	adc	<R0
	sta	<R1
	lda	<L41+thefile_1
	sta	(<R1)
	lda	<L41+thefile_1+2
	ldy	#$2
	sta	(<R1),Y
	lda	<L41+n_1
	asl	A
	asl	A
	asl	A
	adc	<L41+n_1
	sta	<R0
	lda	#$2
	ldx	<R0
	sta	|~~fileinfo+4,X
	lda	<L41+n_1
	asl	A
	asl	A
	asl	A
	adc	<L41+n_1
	sta	<R0
	lda	#$0
	ldx	<R0
	sta	|~~fileinfo+6,X
	lda	<L41+n_1
	asl	A
	asl	A
	asl	A
	adc	<L41+n_1
	sta	<R0
	sep	#$20
	longa	off
	lda	#$0
	ldx	<R0
	sta	|~~fileinfo+8,X
	rep	#$20
	longa	on
	sec
	lda	#$fe
	sbc	<L41+n_1
L50:
	tay
	lda	<L40+2
	sta	<L40+2+6
	lda	<L40+1
	sta	<L40+1+6
	pld
	tsc
	clc
	adc	#L40+6
	tcs
	tya
	rtl
L40	equ	30
L41	equ	9
	ends
	efunc
	data
L39:
	db	$72,$2B,$00
	ends
	code
	func
~~close_file:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L52
	tcs
	phd
	tcd
handle_0	set	4
	lda	<L52+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L52+handle_0
	sta	<R0
	clc
	lda	#<~~fileinfo
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	pha
	lda	(<R1)
	pha
	jsl	~~fclose
	lda	<L52+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L52+handle_0
	sta	<R0
	clc
	lda	#<~~fileinfo
	adc	<R0
	sta	<R1
	lda	#$0
	sta	(<R1)
	lda	#$0
	ldy	#$2
	sta	(<R1),Y
	lda	<L52+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L52+handle_0
	sta	<R0
	lda	#$0
	ldx	<R0
	sta	|~~fileinfo+4,X
	lda	<L52+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L52+handle_0
	sta	<R0
	sep	#$20
	longa	off
	lda	#$0
	ldx	<R0
	sta	|~~fileinfo+8,X
	rep	#$20
	longa	on
L54:
	lda	<L52+2
	sta	<L52+2+2
	lda	<L52+1
	sta	<L52+1+2
	pld
	tsc
	clc
	adc	#L52+2
	tcs
	rtl
L52	equ	8
L53	equ	9
	ends
	efunc
	code
	xdef	~~fileio_close
	func
~~fileio_close:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L55
	tcs
	phd
	tcd
handle_0	set	4
n_1	set	0
	lda	<L55+handle_0
	beq	L57
	brl	L10020
L57:
	stz	<L56+n_1
L10023:
	lda	<L56+n_1
	asl	A
	asl	A
	asl	A
	adc	<L56+n_1
	sta	<R0
	ldx	<R0
	lda	|~~fileinfo+4,X
	bne	L58
	brl	L10024
L58:
	pei	<L56+n_1
	jsl	~~close_file
L10024:
L10021:
	inc	<L56+n_1
	sec
	lda	<L56+n_1
	sbc	#<$19
	bvs	L59
	eor	#$8000
L59:
	bmi	L60
	brl	L10023
L60:
L10022:
	brl	L10025
L10020:
	pei	<L55+handle_0
	jsl	~~map_handle
	sta	<L56+n_1
	lda	<L56+n_1
	asl	A
	asl	A
	asl	A
	adc	<L56+n_1
	sta	<R0
	ldx	<R0
	lda	|~~fileinfo+4,X
	bne	L61
	brl	L10026
L61:
	pei	<L56+n_1
	jsl	~~close_file
L10026:
L10025:
L62:
	lda	<L55+2
	sta	<L55+2+2
	lda	<L55+1
	sta	<L55+1+2
	pld
	tsc
	clc
	adc	#L55+2
	tcs
	rtl
L55	equ	6
L56	equ	5
	ends
	efunc
	code
	xdef	~~fileio_bget
	func
~~fileio_bget:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L63
	tcs
	phd
	tcd
handle_0	set	4
ch_1	set	0
	pei	<L63+handle_0
	jsl	~~map_handle
	sta	<L63+handle_0
	lda	<L63+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L63+handle_0
	sta	<R0
	ldx	<R0
	lda	|~~fileinfo+6,X
	bne	L65
	brl	L10027
L65:
	lda	<L63+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L63+handle_0
	sta	<R0
	lda	#$2
	ldx	<R0
	sta	|~~fileinfo+6,X
	pea	#<$74
	pea	#4
	jsl	~~error
	brl	L10028
L10027:
	lda	<L63+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L63+handle_0
	sta	<R0
	ldx	<R0
	lda	|~~fileinfo+4,X
	cmp	#<$3
	beq	L66
	brl	L10029
L66:
	stz	<L64+ch_1
	lda	<L63+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L63+handle_0
	sta	<R0
	lda	#$1
	ldx	<R0
	sta	|~~fileinfo+6,X
L10029:
L10028:
	lda	<L63+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L63+handle_0
	sta	<R0
	ldx	<R0
	lda	|~~fileinfo+8,X
	and	#$ff
	bne	L67
	brl	L10030
L67:
	lda	<L63+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L63+handle_0
	sta	<R0
	clc
	lda	#<~~fileinfo
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	pha
	lda	(<R1)
	pha
	jsl	~~fflush
	lda	<L63+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L63+handle_0
	sta	<R0
	sep	#$20
	longa	off
	lda	#$0
	ldx	<R0
	sta	|~~fileinfo+8,X
	rep	#$20
	longa	on
L10030:
	lda	<L63+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L63+handle_0
	sta	<R0
	clc
	lda	#<~~fileinfo
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	pha
	lda	(<R1)
	pha
	jsl	~~fgetc
	sta	<L64+ch_1
	lda	<L64+ch_1
	cmp	#<$ffffffff
	beq	L68
	brl	L10031
L68:
	lda	<L63+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L63+handle_0
	sta	<R0
	lda	#$1
	ldx	<R0
	sta	|~~fileinfo+6,X
	stz	<L64+ch_1
L10031:
	lda	<L63+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L63+handle_0
	sta	<R0
	sep	#$20
	longa	off
	lda	#$0
	ldx	<R0
	sta	|~~fileinfo+8,X
	rep	#$20
	longa	on
	lda	<L64+ch_1
L69:
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
L63	equ	10
L64	equ	9
	ends
	efunc
	code
	xdef	~~fileio_getdol
	func
~~fileio_getdol:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L70
	tcs
	phd
	tcd
handle_0	set	4
buffer_0	set	6
p_1	set	0
length_1	set	4
	pei	<L70+handle_0
	jsl	~~map_handle
	sta	<L70+handle_0
	lda	<L70+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L70+handle_0
	sta	<R0
	ldx	<R0
	lda	|~~fileinfo+6,X
	bne	L72
	brl	L10032
L72:
	lda	<L70+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L70+handle_0
	sta	<R0
	lda	#$2
	ldx	<R0
	sta	|~~fileinfo+6,X
	pea	#<$74
	pea	#4
	jsl	~~error
L10032:
	lda	<L70+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L70+handle_0
	sta	<R0
	ldx	<R0
	lda	|~~fileinfo+8,X
	and	#$ff
	bne	L73
	brl	L10033
L73:
	lda	<L70+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L70+handle_0
	sta	<R0
	clc
	lda	#<~~fileinfo
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	pha
	lda	(<R1)
	pha
	jsl	~~fflush
	lda	<L70+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L70+handle_0
	sta	<R0
	sep	#$20
	longa	off
	lda	#$0
	ldx	<R0
	sta	|~~fileinfo+8,X
	rep	#$20
	longa	on
L10033:
	lda	<L70+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L70+handle_0
	sta	<R0
	clc
	lda	#<~~fileinfo
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	pha
	lda	(<R1)
	pha
	pea	#<$1000
	pei	<L70+buffer_0+2
	pei	<L70+buffer_0
	jsl	~~fgets
	sta	<L71+p_1
	stx	<L71+p_1+2
	lda	<L71+p_1
	ora	<L71+p_1+2
	beq	L74
	brl	L10034
L74:
	pea	#<$72
	pea	#4
	jsl	~~error
L10034:
	pei	<L70+buffer_0+2
	pei	<L70+buffer_0
	jsl	~~strlen
	sta	<L71+length_1
	ldy	#$0
	lda	<L71+length_1
	bpl	L75
	dey
L75:
	sta	<R0
	sty	<R0+2
	clc
	lda	#$ffff
	adc	<R0
	sta	<R1
	lda	#$ffff
	adc	<R0+2
	sta	<R1+2
	clc
	lda	<L70+buffer_0
	adc	<R1
	sta	<L71+p_1
	lda	<L70+buffer_0+2
	adc	<R1+2
	sta	<L71+p_1+2
	sep	#$20
	longa	off
	lda	[<L71+p_1]
	cmp	#<$a
	rep	#$20
	longa	on
	beq	L76
	brl	L10035
L76:
	dec	<L71+length_1
	sec
	lda	#$0
	sbc	<L71+length_1
	bvs	L77
	eor	#$8000
L77:
	bpl	L78
	brl	L10036
L78:
	clc
	lda	#$ffff
	adc	<L71+p_1
	sta	<R0
	lda	#$ffff
	adc	<L71+p_1+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$d
	rep	#$20
	longa	on
	beq	L79
	brl	L10036
L79:
	dec	<L71+length_1
L10036:
L10035:
	lda	<L71+length_1
L80:
	tay
	lda	<L70+2
	sta	<L70+2+6
	lda	<L70+1
	sta	<L70+1+6
	pld
	tsc
	clc
	adc	#L70+6
	tcs
	tya
	rtl
L70	equ	14
L71	equ	9
	ends
	efunc
	code
	func
~~read:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L81
	tcs
	phd
	tcd
handle_0	set	4
ch_1	set	0
	pei	<L81+handle_0+2
	pei	<L81+handle_0
	jsl	~~fgetc
	sta	<L82+ch_1
	lda	<L82+ch_1
	cmp	#<$ffffffff
	beq	L83
	brl	L10037
L83:
	pea	#<$72
	pea	#4
	jsl	~~error
L10037:
	lda	<L82+ch_1
L84:
	tay
	lda	<L81+2
	sta	<L81+2+4
	lda	<L81+1
	sta	<L81+1+4
	pld
	tsc
	clc
	adc	#L81+4
	tcs
	tya
	rtl
L81	equ	2
L82	equ	1
	ends
	efunc
	code
	xdef	~~fileio_getnumber
	func
~~fileio_getnumber:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L85
	tcs
	phd
	tcd
handle_0	set	4
isint_0	set	6
ip_0	set	10
fp_0	set	14
stream_1	set	0
n_1	set	4
marker_1	set	6
temp_1	set	8
	pei	<L85+handle_0
	jsl	~~map_handle
	sta	<L85+handle_0
	lda	<L85+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L85+handle_0
	sta	<R0
	ldx	<R0
	lda	|~~fileinfo+6,X
	bne	L87
	brl	L10038
L87:
	lda	<L85+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L85+handle_0
	sta	<R0
	lda	#$2
	ldx	<R0
	sta	|~~fileinfo+6,X
	pea	#<$74
	pea	#4
	jsl	~~error
L10038:
	lda	<L85+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L85+handle_0
	sta	<R0
	ldx	<R0
	lda	|~~fileinfo+8,X
	and	#$ff
	bne	L88
	brl	L10039
L88:
	lda	<L85+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L85+handle_0
	sta	<R0
	clc
	lda	#<~~fileinfo
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	pha
	lda	(<R1)
	pha
	jsl	~~fflush
	lda	<L85+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L85+handle_0
	sta	<R0
	sep	#$20
	longa	off
	lda	#$0
	ldx	<R0
	sta	|~~fileinfo+8,X
	rep	#$20
	longa	on
L10039:
	lda	<L85+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L85+handle_0
	sta	<R0
	clc
	lda	#<~~fileinfo
	adc	<R0
	sta	<R1
	lda	(<R1)
	sta	<L86+stream_1
	ldy	#$2
	lda	(<R1),Y
	sta	<L86+stream_1+2
	pei	<L86+stream_1+2
	pei	<L86+stream_1
	jsl	~~read
	sta	<L86+marker_1
	lda	<L86+marker_1
	brl	L10040
L10042:
	lda	#$0
	sta	[<L85+ip_0]
	lda	#$18
	sta	<L86+n_1
L10045:
	pei	<L86+stream_1+2
	pei	<L86+stream_1
	jsl	~~read
	ldx	<L86+n_1
	xref	~~~asl
	jsl	~~~asl
	sta	<R0
	lda	[<L85+ip_0]
	ora	<R0
	sta	[<L85+ip_0]
L10043:
	clc
	lda	#$fff8
	adc	<L86+n_1
	sta	<L86+n_1
	lda	<L86+n_1
	bmi	L89
	brl	L10045
L89:
L10044:
	sep	#$20
	longa	off
	lda	#$1
	sta	[<L85+isint_0]
	rep	#$20
	longa	on
	brl	L10041
L10046:
	lda	|~~double_type
	brl	L10047
L10049:
	stz	<L86+n_1
	brl	L10053
L10052:
	pei	<L86+stream_1+2
	pei	<L86+stream_1
	jsl	~~read
	sep	#$20
	longa	off
	ldx	<L86+n_1
	sta	<L86+temp_1,X
	rep	#$20
	longa	on
L10050:
	inc	<L86+n_1
L10053:
	lda	<L86+n_1
	cmp	#<$4
	bcs	L90
	brl	L10052
L90:
L10051:
	brl	L10048
L10054:
	stz	<L86+n_1
	brl	L10058
L10057:
	lda	<L86+n_1
	eor	#<$4
	sta	<R0
	pei	<L86+stream_1+2
	pei	<L86+stream_1
	jsl	~~read
	sep	#$20
	longa	off
	ldx	<R0
	sta	<L86+temp_1,X
	rep	#$20
	longa	on
L10055:
	inc	<L86+n_1
L10058:
	lda	<L86+n_1
	cmp	#<$4
	bcs	L91
	brl	L10057
L91:
L10056:
	brl	L10048
L10059:
	stz	<L86+n_1
	brl	L10063
L10062:
	lda	<L86+n_1
	eor	#<$3
	sta	<R0
	pei	<L86+stream_1+2
	pei	<L86+stream_1
	jsl	~~read
	sep	#$20
	longa	off
	ldx	<R0
	sta	<L86+temp_1,X
	rep	#$20
	longa	on
L10060:
	inc	<L86+n_1
L10063:
	lda	<L86+n_1
	cmp	#<$4
	bcs	L92
	brl	L10062
L92:
L10061:
	brl	L10048
L10064:
	stz	<L86+n_1
	brl	L10068
L10067:
	lda	<L86+n_1
	eor	#<$7
	sta	<R0
	pei	<L86+stream_1+2
	pei	<L86+stream_1
	jsl	~~read
	sep	#$20
	longa	off
	ldx	<R0
	sta	<L86+temp_1,X
	rep	#$20
	longa	on
L10065:
	inc	<L86+n_1
L10068:
	lda	<L86+n_1
	cmp	#<$4
	bcs	L93
	brl	L10067
L93:
L10066:
	brl	L10048
L10047:
	xref	~~~fsw
	jsl	~~~fsw
	dw	0
	dw	4
	dw	L10048-1
	dw	L10049-1
	dw	L10054-1
	dw	L10059-1
	dw	L10064-1
L10048:
	pea	#^$4
	pea	#<$4
	pea	#0
	clc
	tdc
	adc	#<L86+temp_1
	pha
	pei	<L85+fp_0+2
	pei	<L85+fp_0
	jsl	~~memmove
	sep	#$20
	longa	off
	lda	#$0
	sta	[<L85+isint_0]
	rep	#$20
	longa	on
	brl	L10041
L10069:
exponent_2	set	12
mantissa_2	set	14
	pei	<L86+stream_1+2
	pei	<L86+stream_1
	jsl	~~read
	sta	<L86+mantissa_2
	pei	<L86+stream_1+2
	pei	<L86+stream_1
	jsl	~~read
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	lda	<R0
	tsb	<L86+mantissa_2
	pei	<L86+stream_1+2
	pei	<L86+stream_1
	jsl	~~read
	ldx	#<$10
	xref	~~~asl
	jsl	~~~asl
	sta	<R0
	lda	<R0
	tsb	<L86+mantissa_2
	pei	<L86+stream_1+2
	pei	<L86+stream_1
	jsl	~~read
	ldx	#<$18
	xref	~~~asl
	jsl	~~~asl
	sta	<R0
	lda	<R0
	tsb	<L86+mantissa_2
	pei	<L86+stream_1+2
	pei	<L86+stream_1
	jsl	~~read
	sta	<L86+exponent_2
	lda	<L86+exponent_2
	beq	L95
	brl	L94
L95:
	lda	<L86+mantissa_2
	bne	L96
	brl	L10070
L96:
L94:
	lda	<L86+mantissa_2
	bmi	L98
	brl	L97
L98:
	lda	#$ffff
	bra	L99
L97:
	lda	#$1
L99:
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L100
	dey
L100:
	phy
	pha
	xref	~~~dflt
	jsl	~~~dflt
	pea	#$3FE0
	pea	#$0000
	pea	#$0000
	pea	#$0000
	pea	#$41F0
	pea	#$0000
	pea	#$0000
	pea	#$0000
	ldy	#$0
	lda	<L86+mantissa_2
	bpl	L101
	dey
L101:
	sta	<R0
	sty	<R0+2
	lda	<R0
	sta	<R1
	lda	<R0+2
	and	#^$7fffffff
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	xref	~~~dflt
	jsl	~~~dflt
	xref	~~~ddiv
	jsl	~~~ddiv
	xref	~~~dadc
	jsl	~~~dadc
	phy
	phy
	phy
	phy
	clc
	lda	#$ff80
	adc	<L86+exponent_2
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L102
	dey
L102:
	phy
	pha
	xref	~~~dflt
	jsl	~~~dflt
	pea	#$4000
	pea	#$0000
	pea	#$0000
	pea	#$0000
	jsl	~~pow
	xref	~~~dmul
	jsl	~~~dmul
	xref	~~~dmul
	jsl	~~~dmul
	xref	~~~dtof
	jsl	~~~dtof
	pla
	sta	[<L85+fp_0]
	pla
	ldy	#$2
	sta	[<L85+fp_0],Y
	brl	L10071
L10070:
	lda	#$0
	sta	[<L85+fp_0]
	lda	#$0
	ldy	#$2
	sta	[<L85+fp_0],Y
L10071:
	sep	#$20
	longa	off
	lda	#$0
	sta	[<L85+isint_0]
	rep	#$20
	longa	on
	brl	L10041
L10072:
	pea	#<$3f
	pea	#4
	jsl	~~error
	brl	L10041
L10040:
	xref	~~~swt
	jsl	~~~swt
	dw	3
	dw	64
	dw	L10042-1
	dw	128
	dw	L10069-1
	dw	136
	dw	L10046-1
	dw	L10072-1
L10041:
L103:
	lda	<L85+2
	sta	<L85+2+14
	lda	<L85+1
	sta	<L85+1+14
	pld
	tsc
	clc
	adc	#L85+14
	tcs
	rtl
L85	equ	24
L86	equ	9
	ends
	efunc
	code
	xdef	~~fileio_getstring
	func
~~fileio_getstring:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L104
	tcs
	phd
	tcd
handle_0	set	4
p_0	set	6
stream_1	set	0
marker_1	set	4
length_1	set	6
n_1	set	8
	pei	<L104+handle_0
	jsl	~~map_handle
	sta	<L104+handle_0
	lda	<L104+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L104+handle_0
	sta	<R0
	ldx	<R0
	lda	|~~fileinfo+6,X
	bne	L106
	brl	L10073
L106:
	lda	<L104+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L104+handle_0
	sta	<R0
	lda	#$2
	ldx	<R0
	sta	|~~fileinfo+6,X
	pea	#<$74
	pea	#4
	jsl	~~error
L10073:
	lda	<L104+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L104+handle_0
	sta	<R0
	ldx	<R0
	lda	|~~fileinfo+8,X
	and	#$ff
	bne	L107
	brl	L10074
L107:
	lda	<L104+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L104+handle_0
	sta	<R0
	clc
	lda	#<~~fileinfo
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	pha
	lda	(<R1)
	pha
	jsl	~~fflush
	lda	<L104+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L104+handle_0
	sta	<R0
	sep	#$20
	longa	off
	lda	#$0
	ldx	<R0
	sta	|~~fileinfo+8,X
	rep	#$20
	longa	on
L10074:
	lda	<L104+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L104+handle_0
	sta	<R0
	clc
	lda	#<~~fileinfo
	adc	<R0
	sta	<R1
	lda	(<R1)
	sta	<L105+stream_1
	ldy	#$2
	lda	(<R1),Y
	sta	<L105+stream_1+2
	pei	<L105+stream_1+2
	pei	<L105+stream_1
	jsl	~~read
	sta	<L105+marker_1
	lda	<L105+marker_1
	brl	L10075
L10077:
	pei	<L105+stream_1+2
	pei	<L105+stream_1
	jsl	~~read
	sta	<L105+length_1
	lda	#$1
	sta	<L105+n_1
	brl	L10081
L10080:
	sec
	lda	<L105+length_1
	sbc	<L105+n_1
	sta	<R0
	pei	<L105+stream_1+2
	pei	<L105+stream_1
	jsl	~~read
	sep	#$20
	longa	off
	ldy	<R0
	sta	[<L104+p_0],Y
	rep	#$20
	longa	on
L10078:
	inc	<L105+n_1
L10081:
	sec
	lda	<L105+length_1
	sbc	<L105+n_1
	bvs	L108
	eor	#$8000
L108:
	bpl	L109
	brl	L10080
L109:
L10079:
	brl	L10076
L10082:
	stz	<L105+length_1
	stz	<L105+n_1
	brl	L10086
L10085:
	lda	<L105+n_1
	asl	A
	asl	A
	asl	A
	pha
	pei	<L105+stream_1+2
	pei	<L105+stream_1
	jsl	~~read
	plx
	xref	~~~asl
	jsl	~~~asl
	sta	<R0
	clc
	lda	<R0
	adc	<L105+length_1
	sta	<L105+length_1
L10083:
	inc	<L105+n_1
L10086:
	lda	<L105+n_1
	cmp	#<$2
	bcs	L110
	brl	L10085
L110:
L10084:
	stz	<L105+n_1
	brl	L10090
L10089:
	pei	<L105+stream_1+2
	pei	<L105+stream_1
	jsl	~~read
	sep	#$20
	longa	off
	ldy	<L105+n_1
	sta	[<L104+p_0],Y
	rep	#$20
	longa	on
L10087:
	inc	<L105+n_1
L10090:
	sec
	lda	<L105+n_1
	sbc	<L105+length_1
	bvs	L111
	eor	#$8000
L111:
	bmi	L112
	brl	L10089
L112:
L10088:
	brl	L10076
L10091:
	pea	#<$40
	pea	#4
	jsl	~~error
	brl	L10076
L10075:
	xref	~~~swt
	jsl	~~~swt
	dw	2
	dw	0
	dw	L10077-1
	dw	1
	dw	L10082-1
	dw	L10091-1
L10076:
	lda	<L105+length_1
L113:
	tay
	lda	<L104+2
	sta	<L104+2+6
	lda	<L104+1
	sta	<L104+1+6
	pld
	tsc
	clc
	adc	#L104+6
	tcs
	tya
	rtl
L104	equ	18
L105	equ	9
	ends
	efunc
	code
	func
~~write:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L114
	tcs
	phd
	tcd
stream_0	set	4
value_0	set	8
result_1	set	0
	pei	<L114+stream_0+2
	pei	<L114+stream_0
	pei	<L114+value_0
	jsl	~~fputc
	sta	<L115+result_1
	lda	<L115+result_1
	cmp	#<$ffffffff
	beq	L116
	brl	L10092
L116:
	pea	#<$73
	pea	#4
	jsl	~~error
L10092:
L117:
	lda	<L114+2
	sta	<L114+2+6
	lda	<L114+1
	sta	<L114+1+6
	pld
	tsc
	clc
	adc	#L114+6
	tcs
	rtl
L114	equ	2
L115	equ	1
	ends
	efunc
	code
	xdef	~~fileio_bput
	func
~~fileio_bput:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L118
	tcs
	phd
	tcd
handle_0	set	4
value_0	set	6
result_1	set	0
	pei	<L118+handle_0
	jsl	~~map_handle
	sta	<L118+handle_0
	lda	<L118+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L118+handle_0
	sta	<R0
	ldx	<R0
	lda	|~~fileinfo+4,X
	cmp	#<$1
	beq	L120
	brl	L10093
L120:
	pea	#<$71
	pea	#4
	jsl	~~error
L10093:
	lda	<L118+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L118+handle_0
	sta	<R0
	lda	#$0
	ldx	<R0
	sta	|~~fileinfo+6,X
	lda	<L118+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L118+handle_0
	sta	<R0
	clc
	lda	#<~~fileinfo
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	pha
	lda	(<R1)
	pha
	pei	<L118+value_0
	jsl	~~fputc
	sta	<L119+result_1
	lda	<L119+result_1
	cmp	#<$ffffffff
	beq	L121
	brl	L10094
L121:
	pea	#<$73
	pea	#4
	jsl	~~error
L10094:
	lda	<L118+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L118+handle_0
	sta	<R0
	sep	#$20
	longa	off
	lda	#$1
	ldx	<R0
	sta	|~~fileinfo+8,X
	rep	#$20
	longa	on
L122:
	lda	<L118+2
	sta	<L118+2+4
	lda	<L118+1
	sta	<L118+1+4
	pld
	tsc
	clc
	adc	#L118+4
	tcs
	rtl
L118	equ	10
L119	equ	9
	ends
	efunc
	code
	xdef	~~fileio_bputstr
	func
~~fileio_bputstr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L123
	tcs
	phd
	tcd
handle_0	set	4
string_0	set	6
length_0	set	10
result_1	set	0
	pei	<L123+handle_0
	jsl	~~map_handle
	sta	<L123+handle_0
	lda	<L123+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L123+handle_0
	sta	<R0
	ldx	<R0
	lda	|~~fileinfo+4,X
	cmp	#<$1
	beq	L125
	brl	L10095
L125:
	pea	#<$71
	pea	#4
	jsl	~~error
L10095:
	lda	<L123+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L123+handle_0
	sta	<R0
	lda	#$0
	ldx	<R0
	sta	|~~fileinfo+6,X
	lda	<L123+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L123+handle_0
	sta	<R0
	clc
	lda	#<~~fileinfo
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	pha
	lda	(<R1)
	pha
	ldy	#$0
	lda	<L123+length_0
	bpl	L126
	dey
L126:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pea	#^$1
	pea	#<$1
	pei	<L123+string_0+2
	pei	<L123+string_0
	jsl	~~fwrite
	sta	<L124+result_1
	lda	<L124+result_1
	cmp	<L123+length_0
	bne	L127
	brl	L10096
L127:
	pea	#<$73
	pea	#4
	jsl	~~error
L10096:
	lda	<L123+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L123+handle_0
	sta	<R0
	sep	#$20
	longa	off
	lda	#$1
	ldx	<R0
	sta	|~~fileinfo+8,X
	rep	#$20
	longa	on
L128:
	lda	<L123+2
	sta	<L123+2+8
	lda	<L123+1
	sta	<L123+1+8
	pld
	tsc
	clc
	adc	#L123+8
	tcs
	rtl
L123	equ	10
L124	equ	9
	ends
	efunc
	code
	xdef	~~fileio_printint
	func
~~fileio_printint:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L129
	tcs
	phd
	tcd
handle_0	set	4
value_0	set	6
stream_1	set	0
n_1	set	4
	pei	<L129+handle_0
	jsl	~~map_handle
	sta	<L129+handle_0
	lda	<L129+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L129+handle_0
	sta	<R0
	ldx	<R0
	lda	|~~fileinfo+4,X
	cmp	#<$1
	beq	L131
	brl	L10097
L131:
	pea	#<$71
	pea	#4
	jsl	~~error
L10097:
	lda	<L129+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L129+handle_0
	sta	<R0
	lda	#$0
	ldx	<R0
	sta	|~~fileinfo+6,X
	lda	<L129+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L129+handle_0
	sta	<R0
	clc
	lda	#<~~fileinfo
	adc	<R0
	sta	<R1
	lda	(<R1)
	sta	<L130+stream_1
	ldy	#$2
	lda	(<R1),Y
	sta	<L130+stream_1+2
	pea	#<$40
	pei	<L130+stream_1+2
	pei	<L130+stream_1
	jsl	~~write
	lda	#$18
	sta	<L130+n_1
L10100:
	lda	<L129+value_0
	ldx	<L130+n_1
	xref	~~~asr
	jsl	~~~asr
	pha
	pei	<L130+stream_1+2
	pei	<L130+stream_1
	jsl	~~write
L10098:
	clc
	lda	#$fff8
	adc	<L130+n_1
	sta	<L130+n_1
	lda	<L130+n_1
	bmi	L132
	brl	L10100
L132:
L10099:
	lda	<L129+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L129+handle_0
	sta	<R0
	sep	#$20
	longa	off
	lda	#$1
	ldx	<R0
	sta	|~~fileinfo+8,X
	rep	#$20
	longa	on
L133:
	lda	<L129+2
	sta	<L129+2+4
	lda	<L129+1
	sta	<L129+1+4
	pld
	tsc
	clc
	adc	#L129+4
	tcs
	rtl
L129	equ	14
L130	equ	9
	ends
	efunc
	code
	xdef	~~fileio_printfloat
	func
~~fileio_printfloat:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L134
	tcs
	phd
	tcd
handle_0	set	4
value_0	set	6
stream_1	set	0
n_1	set	4
temp_1	set	6
	pei	<L134+handle_0
	jsl	~~map_handle
	sta	<L134+handle_0
	lda	<L134+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L134+handle_0
	sta	<R0
	ldx	<R0
	lda	|~~fileinfo+4,X
	cmp	#<$1
	beq	L136
	brl	L10101
L136:
	pea	#<$71
	pea	#4
	jsl	~~error
L10101:
	lda	<L134+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L134+handle_0
	sta	<R0
	lda	#$0
	ldx	<R0
	sta	|~~fileinfo+6,X
	lda	<L134+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L134+handle_0
	sta	<R0
	clc
	lda	#<~~fileinfo
	adc	<R0
	sta	<R1
	lda	(<R1)
	sta	<L135+stream_1
	ldy	#$2
	lda	(<R1),Y
	sta	<L135+stream_1+2
	pea	#<$88
	pei	<L135+stream_1+2
	pei	<L135+stream_1
	jsl	~~write
	pea	#^$4
	pea	#<$4
	pea	#0
	clc
	tdc
	adc	#<L134+value_0
	pha
	pea	#0
	clc
	tdc
	adc	#<L135+temp_1
	pha
	jsl	~~memmove
	lda	|~~double_type
	brl	L10102
L10104:
	stz	<L135+n_1
	brl	L10108
L10107:
	ldx	<L135+n_1
	lda	<L135+temp_1,X
	and	#$ff
	pha
	pei	<L135+stream_1+2
	pei	<L135+stream_1
	jsl	~~write
L10105:
	inc	<L135+n_1
L10108:
	lda	<L135+n_1
	cmp	#<$4
	bcs	L137
	brl	L10107
L137:
L10106:
	brl	L10103
L10109:
	stz	<L135+n_1
	brl	L10113
L10112:
	lda	<L135+n_1
	eor	#<$4
	sta	<R0
	ldx	<R0
	lda	<L135+temp_1,X
	and	#$ff
	pha
	pei	<L135+stream_1+2
	pei	<L135+stream_1
	jsl	~~write
L10110:
	inc	<L135+n_1
L10113:
	lda	<L135+n_1
	cmp	#<$4
	bcs	L138
	brl	L10112
L138:
L10111:
	brl	L10103
L10114:
	stz	<L135+n_1
	brl	L10118
L10117:
	lda	<L135+n_1
	eor	#<$3
	sta	<R0
	ldx	<R0
	lda	<L135+temp_1,X
	and	#$ff
	pha
	pei	<L135+stream_1+2
	pei	<L135+stream_1
	jsl	~~write
L10115:
	inc	<L135+n_1
L10118:
	lda	<L135+n_1
	cmp	#<$4
	bcs	L139
	brl	L10117
L139:
L10116:
	brl	L10103
L10119:
	stz	<L135+n_1
	brl	L10123
L10122:
	lda	<L135+n_1
	eor	#<$7
	sta	<R0
	ldx	<R0
	lda	<L135+temp_1,X
	and	#$ff
	pha
	pei	<L135+stream_1+2
	pei	<L135+stream_1
	jsl	~~write
L10120:
	inc	<L135+n_1
L10123:
	lda	<L135+n_1
	cmp	#<$4
	bcs	L140
	brl	L10122
L140:
L10121:
	brl	L10103
L10102:
	xref	~~~fsw
	jsl	~~~fsw
	dw	0
	dw	4
	dw	L10103-1
	dw	L10104-1
	dw	L10109-1
	dw	L10114-1
	dw	L10119-1
L10103:
	lda	<L134+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L134+handle_0
	sta	<R0
	sep	#$20
	longa	off
	lda	#$1
	ldx	<R0
	sta	|~~fileinfo+8,X
	rep	#$20
	longa	on
L141:
	lda	<L134+2
	sta	<L134+2+6
	lda	<L134+1
	sta	<L134+1+6
	pld
	tsc
	clc
	adc	#L134+6
	tcs
	rtl
L134	equ	18
L135	equ	9
	ends
	efunc
	code
	xdef	~~fileio_printstring
	func
~~fileio_printstring:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L142
	tcs
	phd
	tcd
handle_0	set	4
string_0	set	6
length_0	set	10
stream_1	set	0
n_1	set	4
temp_1	set	6
result_1	set	8
	pei	<L142+handle_0
	jsl	~~map_handle
	sta	<L142+handle_0
	lda	<L142+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L142+handle_0
	sta	<R0
	ldx	<R0
	lda	|~~fileinfo+4,X
	cmp	#<$1
	beq	L144
	brl	L10124
L144:
	pea	#<$71
	pea	#4
	jsl	~~error
L10124:
	lda	<L142+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L142+handle_0
	sta	<R0
	lda	#$0
	ldx	<R0
	sta	|~~fileinfo+6,X
	lda	<L142+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L142+handle_0
	sta	<R0
	clc
	lda	#<~~fileinfo
	adc	<R0
	sta	<R1
	lda	(<R1)
	sta	<L143+stream_1
	ldy	#$2
	lda	(<R1),Y
	sta	<L143+stream_1+2
	sec
	lda	<L142+length_0
	sbc	#<$100
	bvs	L145
	eor	#$8000
L145:
	bpl	L146
	brl	L10125
L146:
	pea	#<$0
	pei	<L143+stream_1+2
	pei	<L143+stream_1
	jsl	~~write
	pei	<L142+length_0
	pei	<L143+stream_1+2
	pei	<L143+stream_1
	jsl	~~write
	sec
	lda	#$0
	sbc	<L142+length_0
	bvs	L147
	eor	#$8000
L147:
	bpl	L148
	brl	L10126
L148:
	clc
	lda	#$ffff
	adc	<L142+length_0
	sta	<L143+n_1
	brl	L10130
L10129:
	ldy	<L143+n_1
	lda	[<L142+string_0],Y
	and	#$ff
	pha
	pei	<L143+stream_1+2
	pei	<L143+stream_1
	jsl	~~write
L10127:
	dec	<L143+n_1
L10130:
	lda	<L143+n_1
	bmi	L149
	brl	L10129
L149:
L10128:
L10126:
	brl	L10131
L10125:
	pea	#<$1
	pei	<L143+stream_1+2
	pei	<L143+stream_1
	jsl	~~write
	lda	<L142+length_0
	sta	<L143+temp_1
	stz	<L143+n_1
	brl	L10135
L10134:
	lda	<L143+temp_1
	and	#<$ff
	pha
	pei	<L143+stream_1+2
	pei	<L143+stream_1
	jsl	~~write
	lda	<L143+temp_1
	ldx	#<$8
	xref	~~~asr
	jsl	~~~asr
	sta	<L143+temp_1
L10132:
	inc	<L143+n_1
L10135:
	lda	<L143+n_1
	cmp	#<$2
	bcs	L150
	brl	L10134
L150:
L10133:
	pei	<L143+stream_1+2
	pei	<L143+stream_1
	ldy	#$0
	lda	<L142+length_0
	bpl	L151
	dey
L151:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pea	#^$1
	pea	#<$1
	pei	<L142+string_0+2
	pei	<L142+string_0
	jsl	~~fwrite
	sta	<L143+result_1
	lda	<L143+result_1
	cmp	<L142+length_0
	bne	L152
	brl	L10136
L152:
	pea	#<$73
	pea	#4
	jsl	~~error
L10136:
L10131:
	lda	<L142+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L142+handle_0
	sta	<R0
	sep	#$20
	longa	off
	lda	#$1
	ldx	<R0
	sta	|~~fileinfo+8,X
	rep	#$20
	longa	on
L153:
	lda	<L142+2
	sta	<L142+2+8
	lda	<L142+1
	sta	<L142+1+8
	pld
	tsc
	clc
	adc	#L142+8
	tcs
	rtl
L142	equ	18
L143	equ	9
	ends
	efunc
	code
	xdef	~~fileio_setptr
	func
~~fileio_setptr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L154
	tcs
	phd
	tcd
handle_0	set	4
newoffset_0	set	6
result_1	set	0
	pei	<L154+handle_0
	jsl	~~map_handle
	sta	<L154+handle_0
	pea	#<$0
	ldy	#$0
	lda	<L154+newoffset_0
	bpl	L156
	dey
L156:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	lda	<L154+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L154+handle_0
	sta	<R1
	clc
	lda	#<~~fileinfo
	adc	<R1
	sta	<R2
	ldy	#$2
	lda	(<R2),Y
	pha
	lda	(<R2)
	pha
	jsl	~~fseek
	sta	<L155+result_1
	lda	<L155+result_1
	cmp	#<$ffffffff
	beq	L157
	brl	L10137
L157:
	pea	#<$7d
	pea	#4
	jsl	~~error
L10137:
	lda	<L154+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L154+handle_0
	sta	<R0
	lda	#$0
	ldx	<R0
	sta	|~~fileinfo+6,X
L158:
	lda	<L154+2
	sta	<L154+2+4
	lda	<L154+1
	sta	<L154+1+4
	pld
	tsc
	clc
	adc	#L154+4
	tcs
	rtl
L154	equ	14
L155	equ	13
	ends
	efunc
	code
	xdef	~~fileio_getptr
	func
~~fileio_getptr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L159
	tcs
	phd
	tcd
handle_0	set	4
result_1	set	0
	pei	<L159+handle_0
	jsl	~~map_handle
	sta	<L159+handle_0
	lda	<L159+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L159+handle_0
	sta	<R0
	clc
	lda	#<~~fileinfo
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	pha
	lda	(<R1)
	pha
	jsl	~~ftell
	sta	<L160+result_1
	lda	<L160+result_1
	cmp	#<$ffffffff
	beq	L161
	brl	L10138
L161:
	pea	#<$7e
	pea	#4
	jsl	~~error
L10138:
	lda	<L160+result_1
L162:
	tay
	lda	<L159+2
	sta	<L159+2+2
	lda	<L159+1
	sta	<L159+1+2
	pld
	tsc
	clc
	adc	#L159+2
	tcs
	tya
	rtl
L159	equ	10
L160	equ	9
	ends
	efunc
	code
	xdef	~~fileio_getext
	func
~~fileio_getext:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L163
	tcs
	phd
	tcd
handle_0	set	4
position_1	set	0
length_1	set	4
stream_1	set	8
	pei	<L163+handle_0
	jsl	~~map_handle
	sta	<L163+handle_0
	lda	<L163+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L163+handle_0
	sta	<R0
	clc
	lda	#<~~fileinfo
	adc	<R0
	sta	<R1
	lda	(<R1)
	sta	<L164+stream_1
	ldy	#$2
	lda	(<R1),Y
	sta	<L164+stream_1+2
	pei	<L164+stream_1+2
	pei	<L164+stream_1
	jsl	~~ftell
	sta	<L164+position_1
	stx	<L164+position_1+2
	lda	<L164+position_1
	cmp	#<$ffffffff
	bne	L165
	lda	<L164+position_1+2
	cmp	#^$ffffffff
L165:
	beq	L166
	brl	L10139
L166:
	pea	#<$7f
	pea	#4
	jsl	~~error
L10139:
	pea	#<$2
	pea	#^$0
	pea	#<$0
	pei	<L164+stream_1+2
	pei	<L164+stream_1
	jsl	~~fseek
	pei	<L164+stream_1+2
	pei	<L164+stream_1
	jsl	~~ftell
	sta	<L164+length_1
	stx	<L164+length_1+2
	pea	#<$0
	pei	<L164+position_1+2
	pei	<L164+position_1
	pei	<L164+stream_1+2
	pei	<L164+stream_1
	jsl	~~fseek
	lda	<L164+length_1
L167:
	tay
	lda	<L163+2
	sta	<L163+2+2
	lda	<L163+1
	sta	<L163+1+2
	pld
	tsc
	clc
	adc	#L163+2
	tcs
	tya
	rtl
L163	equ	20
L164	equ	9
	ends
	efunc
	code
	xdef	~~fileio_setext
	func
~~fileio_setext:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L168
	tcs
	phd
	tcd
handle_0	set	4
newsize_0	set	6
	pei	<L168+handle_0
	jsl	~~map_handle
	sta	<L168+handle_0
	pea	#<$1
	pea	#4
	jsl	~~error
L170:
	lda	<L168+2
	sta	<L168+2+4
	lda	<L168+1
	sta	<L168+1+4
	pld
	tsc
	clc
	adc	#L168+4
	tcs
	rtl
L168	equ	0
L169	equ	1
	ends
	efunc
	code
	xdef	~~fileio_eof
	func
~~fileio_eof:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L171
	tcs
	phd
	tcd
handle_0	set	4
position_1	set	0
stream_1	set	4
ateof_1	set	8
	pei	<L171+handle_0
	jsl	~~map_handle
	sta	<L171+handle_0
	lda	<L171+handle_0
	asl	A
	asl	A
	asl	A
	adc	<L171+handle_0
	sta	<R0
	clc
	lda	#<~~fileinfo
	adc	<R0
	sta	<R1
	lda	(<R1)
	sta	<L172+stream_1
	ldy	#$2
	lda	(<R1),Y
	sta	<L172+stream_1+2
	pei	<L172+stream_1+2
	pei	<L172+stream_1
	jsl	~~ftell
	sta	<L172+position_1
	stx	<L172+position_1+2
	lda	<L172+position_1
	cmp	#<$ffffffff
	bne	L173
	lda	<L172+position_1+2
	cmp	#^$ffffffff
L173:
	beq	L174
	brl	L10140
L174:
	pei	<L172+stream_1+2
	pei	<L172+stream_1
	jsl	~~feof
	tax
	bne	L176
	brl	L175
L176:
	lda	#$1
	bra	L177
L175:
	lda	#$0
L177:
L178:
	tay
	lda	<L171+2
	sta	<L171+2+2
	lda	<L171+1
	sta	<L171+1+2
	pld
	tsc
	clc
	adc	#L171+2
	tcs
	tya
	rtl
L10140:
	pea	#<$2
	pea	#^$0
	pea	#<$0
	pei	<L172+stream_1+2
	pei	<L172+stream_1
	jsl	~~fseek
	stz	<R0
	pei	<L172+stream_1+2
	pei	<L172+stream_1
	jsl	~~ftell
	sta	<R1
	stx	<R1+2
	lda	<R1
	cmp	<L172+position_1
	bne	L180
	lda	<R1+2
	cmp	<L172+position_1+2
L180:
	beq	L181
	brl	L179
L181:
	inc	<R0
L179:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L172+ateof_1
	rep	#$20
	longa	on
	pea	#<$0
	pei	<L172+position_1+2
	pei	<L172+position_1
	pei	<L172+stream_1+2
	pei	<L172+stream_1
	jsl	~~fseek
	lda	<L172+ateof_1
	and	#$ff
	brl	L178
L171	equ	17
L172	equ	9
	ends
	efunc
	code
	xdef	~~fileio_shutdown
	func
~~fileio_shutdown:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L182
	tcs
	phd
	tcd
n_1	set	0
count_1	set	2
	stz	<L183+count_1
	stz	<L183+n_1
L10143:
	lda	<L183+n_1
	asl	A
	asl	A
	asl	A
	adc	<L183+n_1
	sta	<R0
	ldx	<R0
	lda	|~~fileinfo+4,X
	bne	L184
	brl	L10144
L184:
	pei	<L183+n_1
	jsl	~~close_file
	inc	<L183+count_1
L10144:
L10141:
	inc	<L183+n_1
	sec
	lda	<L183+n_1
	sbc	#<$19
	bvs	L185
	eor	#$8000
L185:
	bmi	L186
	brl	L10143
L186:
L10142:
	lda	<L183+count_1
	cmp	#<$1
	beq	L187
	brl	L10145
L187:
	pea	#<$8c
	pea	#4
	jsl	~~error
	brl	L10146
L10145:
	sec
	lda	#$1
	sbc	<L183+count_1
	bvs	L188
	eor	#$8000
L188:
	bpl	L189
	brl	L10147
L189:
	pei	<L183+count_1
	pea	#<$8d
	pea	#6
	jsl	~~error
L10147:
L10146:
L190:
	pld
	tsc
	clc
	adc	#L182
	tcs
	rtl
L182	equ	8
L183	equ	5
	ends
	efunc
	code
	func
~~find_floatformat:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L191
	tcs
	phd
	tcd
value_1	set	0
	lda	#$0
	sta	<L192+value_1
	lda	#$3f80
	sta	<L192+value_1+2
	sep	#$20
	longa	off
	lda	<L192+value_1+3
	cmp	#<$3f
	rep	#$20
	longa	on
	beq	L193
	brl	L10148
L193:
	stz	|~~double_type
	brl	L10149
L10148:
	sep	#$20
	longa	off
	lda	<L192+value_1+7
	cmp	#<$3f
	rep	#$20
	longa	on
	beq	L194
	brl	L10150
L194:
	lda	#$1
	sta	|~~double_type
	brl	L10151
L10150:
	sep	#$20
	longa	off
	lda	<L192+value_1
	cmp	#<$3f
	rep	#$20
	longa	on
	beq	L195
	brl	L10152
L195:
	lda	#$2
	sta	|~~double_type
	brl	L10153
L10152:
	sep	#$20
	longa	off
	lda	<L192+value_1+4
	cmp	#<$3f
	rep	#$20
	longa	on
	beq	L196
	brl	L10154
L196:
	lda	#$3
	sta	|~~double_type
	brl	L10155
L10154:
	lda	#$1
	sta	|~~double_type
	pea	#<$91
	pea	#4
	jsl	~~error
L10155:
L10153:
L10151:
L10149:
L197:
	pld
	tsc
	clc
	adc	#L191
	tcs
	rtl
L191	equ	4
L192	equ	1
	ends
	efunc
	code
	xdef	~~init_fileio
	func
~~init_fileio:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L198
	tcs
	phd
	tcd
n_1	set	0
	stz	<L199+n_1
L10158:
	lda	<L199+n_1
	asl	A
	asl	A
	asl	A
	adc	<L199+n_1
	sta	<R0
	clc
	lda	#<~~fileinfo
	adc	<R0
	sta	<R1
	lda	#$0
	sta	(<R1)
	lda	#$0
	ldy	#$2
	sta	(<R1),Y
	lda	<L199+n_1
	asl	A
	asl	A
	asl	A
	adc	<L199+n_1
	sta	<R0
	lda	#$0
	ldx	<R0
	sta	|~~fileinfo+4,X
	lda	<L199+n_1
	asl	A
	asl	A
	asl	A
	adc	<L199+n_1
	sta	<R0
	lda	#$2
	ldx	<R0
	sta	|~~fileinfo+6,X
L10156:
	inc	<L199+n_1
	sec
	lda	<L199+n_1
	sbc	#<$19
	bvs	L200
	eor	#$8000
L200:
	bmi	L201
	brl	L10158
L201:
L10157:
	jsl	~~find_floatformat
L202:
	pld
	tsc
	clc
	adc	#L198
	tcs
	rtl
L198	equ	10
L199	equ	9
	ends
	efunc
	xref	~~error
	xref	~~pow
	xref	~~strpbrk
	xref	~~strlen
	xref	~~memmove
	xref	~~feof
	xref	~~fclose
	xref	~~fflush
	xref	~~fwrite
	xref	~~ftell
	xref	~~fseek
	xref	~~fputc
	xref	~~fgets
	xref	~~fgetc
	xref	~~fopen
	udata
~~fileinfo
	ds	225
	ends
	udata
	xdef	~~double_type
~~double_type
	ds	2
	ends
	end
