;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
	data
~~binsizes:
	dw	$0,$4,$8,$C,$10,$14,$18,$1C,$20,$24
	dw	$28,$2C,$30,$34,$38,$3C,$40,$44,$48,$4C
	dw	$50,$54,$58,$5C,$60,$64,$68,$6C,$70,$74
	dw	$78,$7C,$80,$100,$180,$200,$280,$300,$380,$400
	dw	$800,$1000,$2000,$4000,$8000,$0
	ends
	code
	func
~~find_bin:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
size_0	set	4
	sec
	lda	#$80
	sbc	<L2+size_0
	bvs	L4
	eor	#$8000
L4:
	bmi	L5
	brl	L10001
L5:
	ldy	#$0
	lda	<L2+size_0
	bpl	L6
	dey
L6:
	sta	<R1
	sty	<R1+2
	clc
	lda	#$1
	adc	<R1
	sta	<R2
	lda	#$0
	adc	<R1+2
	sta	<R2+2
	pei	<R2+2
	pei	<R2
	lda	#$1
	xref	~~~llsr
	jsl	~~~llsr
	sta	<R0
	stx	<R0+2
	lda	<R0
L7:
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
	sec
	lda	#$400
	sbc	<L2+size_0
	bvs	L8
	eor	#$8000
L8:
	bmi	L9
	brl	L10002
L9:
	clc
	lda	#$7f
	adc	<L2+size_0
	sta	<R0
	lda	<R0
	ldx	#<$80
	xref	~~~div
	jsl	~~~div
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L10
	dey
L10:
	sta	<R0
	sty	<R0+2
	clc
	lda	#$3f
	adc	<R0
	sta	<R1
	lda	#$0
	adc	<R0+2
	sta	<R1+2
	lda	<R1
	brl	L7
L10002:
n_2	set	0
	lda	#$48
	sta	<L3+n_2
L10005:
	lda	<L3+n_2
	asl	A
	sta	<R0
	sec
	ldx	<R0
	lda	|~~binsizes,X
	sbc	<L2+size_0
	bvs	L11
	eor	#$8000
L11:
	bmi	L12
	brl	L10006
L12:
	lda	<L3+n_2
	brl	L7
L10006:
	inc	<L3+n_2
L10003:
	sec
	lda	<L3+n_2
	sbc	#<$2e
	bvs	L13
	eor	#$8000
L13:
	bmi	L14
	brl	L10005
L14:
L10004:
	pea	#^L1
	pea	#<L1
	pea	#<$87
	pea	#<$82
	pea	#10
	jsl	~~error
	lda	#$0
	brl	L7
L2	equ	14
L3	equ	13
	ends
	efunc
	data
L1:
	db	$73,$74,$72,$69,$6E,$67,$73,$00
	ends
	code
	xdef	~~alloc_string
	func
~~alloc_string:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L16
	tcs
	phd
	tcd
size_0	set	4
bin_1	set	0
unused_1	set	2
p_1	set	4
last_1	set	8
reclaimed_1	set	12
	lda	<L16+size_0
	beq	L18
	brl	L10007
L18:
	lda	#<~~emptystring
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	ldx	<R0+2
	lda	<R0
L19:
	tay
	lda	<L16+2
	sta	<L16+2+2
	lda	<L16+1
	sta	<L16+1+2
	pld
	tsc
	clc
	adc	#L16+2
	tcs
	tya
	rtl
L10007:
	lda	#$40
	tsb	~~basicvars+423
	pei	<L16+size_0
	jsl	~~find_bin
	sta	<L17+bin_1
	sep	#$20
	longa	off
	stz	<L17+reclaimed_1
	rep	#$20
	longa	on
L10010:
	lda	<L17+bin_1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~binlists
	adc	<R0
	sta	<R1
	lda	(<R1)
	ldy	#$2
	ora	(<R1),Y
	bne	L20
	brl	L10011
L20:
	lda	<L17+bin_1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~binlists
	adc	<R0
	sta	<R1
	lda	(<R1)
	sta	<L17+p_1
	ldy	#$2
	lda	(<R1),Y
	sta	<L17+p_1+2
	lda	<L17+bin_1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~binlists
	adc	<R0
	sta	<R1
	lda	[<L17+p_1]
	sta	(<R1)
	ldy	#$2
	lda	[<L17+p_1],Y
	ldy	#$2
	sta	(<R1),Y
	dec	|~~freestrings
	ldx	<L17+p_1+2
	lda	<L17+p_1
	brl	L19
L10011:
	lda	<L17+bin_1
	asl	A
	sta	<R0
	ldx	<R0
	lda	|~~binsizes,X
	sta	<L16+size_0
	pei	<L16+size_0
	jsl	~~condalloc
	sta	<L17+p_1
	stx	<L17+p_1+2
	lda	<L17+p_1
	ora	<L17+p_1+2
	bne	L21
	brl	L10012
L21:
	ldx	<L17+p_1+2
	lda	<L17+p_1
	brl	L19
L10012:
	lda	|~~freelist
	sta	<L17+p_1
	lda	|~~freelist+2
	sta	<L17+p_1+2
	stz	<L17+last_1
	stz	<L17+last_1+2
L10013:
	lda	<L17+p_1
	ora	<L17+p_1+2
	bne	L22
	brl	L10014
L22:
	sec
	ldy	#$4
	lda	[<L17+p_1],Y
	sbc	<L16+size_0
	bvs	L23
	eor	#$8000
L23:
	bpl	L24
	brl	L10014
L24:
	lda	<L17+p_1
	sta	<L17+last_1
	lda	<L17+p_1+2
	sta	<L17+last_1+2
	lda	[<L17+p_1]
	sta	<R0
	ldy	#$2
	lda	[<L17+p_1],Y
	sta	<R0+2
	lda	<R0
	sta	<L17+p_1
	lda	<R0+2
	sta	<L17+p_1+2
	brl	L10013
L10014:
	lda	<L17+p_1
	ora	<L17+p_1+2
	bne	L25
	brl	L10015
L25:
	sec
	ldy	#$4
	lda	[<L17+p_1],Y
	sbc	<L16+size_0
	sta	<L17+unused_1
	sec
	lda	#$80
	sbc	<L17+unused_1
	bvs	L26
	eor	#$8000
L26:
	bmi	L27
	brl	L10016
L27:
	lda	<L17+last_1
	ora	<L17+last_1+2
	beq	L28
	brl	L10017
L28:
	lda	[<L17+p_1]
	sta	|~~freelist
	ldy	#$2
	lda	[<L17+p_1],Y
	sta	|~~freelist+2
	brl	L10018
L10017:
	lda	[<L17+p_1]
	sta	[<L17+last_1]
	ldy	#$2
	lda	[<L17+p_1],Y
	ldy	#$2
	sta	[<L17+last_1],Y
L10018:
	dec	|~~freestrings
	sec
	lda	#$0
	sbc	<L17+unused_1
	bvs	L29
	eor	#$8000
L29:
	bpl	L30
	brl	L10019
L30:
descriptor_2	set	13
	ldy	#$0
	lda	<L16+size_0
	bpl	L31
	dey
L31:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L17+p_1
	adc	<R0
	sta	<L17+descriptor_2+2
	lda	<L17+p_1+2
	adc	<R0+2
	sta	<L17+descriptor_2+4
	lda	<L17+unused_1
	sta	<L17+descriptor_2
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L17+descriptor_2
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
L10019:
	brl	L10020
L10016:
up_3	set	13
	ldy	#$0
	lda	<L16+size_0
	bpl	L32
	dey
L32:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L17+p_1
	adc	<R0
	sta	<L17+up_3
	lda	<L17+p_1+2
	adc	<R0+2
	sta	<L17+up_3+2
	lda	[<L17+p_1]
	sta	[<L17+up_3]
	ldy	#$2
	lda	[<L17+p_1],Y
	ldy	#$2
	sta	[<L17+up_3],Y
	lda	<L17+unused_1
	ldy	#$4
	sta	[<L17+up_3],Y
	lda	<L17+last_1
	ora	<L17+last_1+2
	beq	L33
	brl	L10021
L33:
	lda	<L17+up_3
	sta	|~~freelist
	lda	<L17+up_3+2
	sta	|~~freelist+2
	brl	L10022
L10021:
	lda	<L17+up_3
	sta	[<L17+last_1]
	lda	<L17+up_3+2
	ldy	#$2
	sta	[<L17+last_1],Y
L10022:
L10020:
	ldx	<L17+p_1+2
	lda	<L17+p_1
	brl	L19
L10015:
	lda	<L17+reclaimed_1
	and	#$ff
	beq	L35
	brl	L34
L35:
	jsl	~~collect
	and	#$ff
	beq	L36
	brl	L10023
L36:
L34:
	pea	#<$59
	pea	#4
	jsl	~~error
L10023:
	sep	#$20
	longa	off
	lda	#$1
	sta	<L17+reclaimed_1
	rep	#$20
	longa	on
L10008:
	brl	L10010
	lda	#$0
	tax
	lda	#$0
	brl	L19
L16	equ	27
L17	equ	9
	ends
	efunc
	code
	xdef	~~free_string
	func
~~free_string:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L37
	tcs
	phd
	tcd
descriptor_0	set	4
hp_1	set	0
hp2_1	set	4
size_1	set	8
bin_1	set	10
	lda	<L37+descriptor_0
	sta	<L38+size_1
	lda	<L38+size_1
	beq	L39
	brl	L10024
L39:
L40:
	lda	<L37+2
	sta	<L37+2+6
	lda	<L37+1
	sta	<L37+1+6
	pld
	tsc
	clc
	adc	#L37+6
	tcs
	rtl
L10024:
	lda	<L37+descriptor_0+2
	sta	<L38+hp_1
	lda	<L37+descriptor_0+4
	sta	<L38+hp_1+2
	pei	<L38+size_1
	jsl	~~find_bin
	sta	<L38+bin_1
	lda	<L38+bin_1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~binlists
	adc	<R0
	sta	<R1
	lda	(<R1)
	sta	<L38+hp2_1
	ldy	#$2
	lda	(<R1),Y
	sta	<L38+hp2_1+2
	lda	<L38+hp2_1
	ora	<L38+hp2_1+2
	bne	L42
	brl	L41
L42:
	lda	<L38+hp_1
	cmp	<L38+hp2_1
	lda	<L38+hp_1+2
	sbc	<L38+hp2_1+2
	bcc	L43
	brl	L10025
L43:
L41:
	lda	<L38+hp2_1
	sta	[<L38+hp_1]
	lda	<L38+hp2_1+2
	ldy	#$2
	sta	[<L38+hp_1],Y
	lda	<L38+bin_1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~binlists
	adc	<R0
	sta	<R1
	lda	<L38+hp_1
	sta	(<R1)
	lda	<L38+hp_1+2
	ldy	#$2
	sta	(<R1),Y
	brl	L10026
L10025:
last_2	set	12
L10029:
	lda	<L38+hp2_1
	sta	<L38+last_2
	lda	<L38+hp2_1+2
	sta	<L38+last_2+2
	lda	[<L38+hp2_1]
	sta	<R0
	ldy	#$2
	lda	[<L38+hp2_1],Y
	sta	<R0+2
	lda	<R0
	sta	<L38+hp2_1
	lda	<R0+2
	sta	<L38+hp2_1+2
L10027:
	lda	<L38+hp2_1
	ora	<L38+hp2_1+2
	bne	L45
	brl	L44
L45:
	lda	<L38+hp2_1
	cmp	<L38+hp_1
	lda	<L38+hp2_1+2
	sbc	<L38+hp_1+2
	bcs	L46
	brl	L10029
L46:
L44:
L10028:
	lda	[<L38+last_2]
	sta	[<L38+hp_1]
	ldy	#$2
	lda	[<L38+last_2],Y
	ldy	#$2
	sta	[<L38+hp_1],Y
	lda	<L38+hp_1
	sta	[<L38+last_2]
	lda	<L38+hp_1+2
	ldy	#$2
	sta	[<L38+last_2],Y
L10026:
	inc	|~~freestrings
	brl	L40
L37	equ	24
L38	equ	9
	ends
	efunc
	code
	xdef	~~discard_strings
	func
~~discard_strings:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L47
	tcs
	phd
	tcd
base_0	set	4
size_0	set	8
p_1	set	0
n_1	set	4
	lda	<L47+base_0
	sta	<L48+p_1
	lda	<L47+base_0+2
	sta	<L48+p_1+2
	ldy	#$0
	lda	<L47+size_0
	bpl	L49
	dey
L49:
	sta	<R0
	sty	<R0+2
	pea	#^$6
	pea	#<$6
	pei	<R0+2
	pei	<R0
	xref	~~~ludv
	jsl	~~~ludv
	sta	<R0
	stx	<R0+2
	lda	<R0
	sta	<L48+n_1
L10030:
	sec
	lda	#$0
	sbc	<L48+n_1
	bvs	L50
	eor	#$8000
L50:
	bpl	L51
	brl	L10031
L51:
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	pei	<L48+p_1+2
	pei	<L48+p_1
	pei	<R0+2
	pei	<R0
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
	jsl	~~free_string
	clc
	lda	#$6
	adc	<L48+p_1
	sta	<L48+p_1
	bcc	L52
	inc	<L48+p_1+2
L52:
	dec	<L48+n_1
	brl	L10030
L10031:
L53:
	lda	<L47+2
	sta	<L47+2+6
	lda	<L47+1
	sta	<L47+1+6
	pld
	tsc
	clc
	adc	#L47+6
	tcs
	rtl
L47	equ	10
L48	equ	5
	ends
	efunc
	code
	xdef	~~resize_string
	func
~~resize_string:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L54
	tcs
	phd
	tcd
cp_0	set	4
oldlen_0	set	8
newlen_0	set	10
oldbin_1	set	0
newbin_1	set	2
sizediff_1	set	4
newcp_1	set	6
descriptor_1	set	10
	pei	<L54+oldlen_0
	jsl	~~find_bin
	sta	<L55+oldbin_1
	pei	<L54+newlen_0
	jsl	~~find_bin
	sta	<L55+newbin_1
	lda	<L55+newbin_1
	cmp	<L55+oldbin_1
	beq	L56
	brl	L10032
L56:
	ldx	<L54+cp_0+2
	lda	<L54+cp_0
L57:
	tay
	lda	<L54+2
	sta	<L54+2+8
	lda	<L54+1
	sta	<L54+1+8
	pld
	tsc
	clc
	adc	#L54+8
	tcs
	tya
	rtl
L10032:
	sec
	lda	<L54+oldlen_0
	sbc	<L54+newlen_0
	bvs	L58
	eor	#$8000
L58:
	bpl	L59
	brl	L10033
L59:
	pei	<L54+newlen_0
	jsl	~~alloc_string
	sta	<L55+newcp_1
	stx	<L55+newcp_1+2
	lda	<L54+oldlen_0
	bne	L60
	brl	L10034
L60:
	ldy	#$0
	lda	<L54+oldlen_0
	bpl	L61
	dey
L61:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L54+cp_0+2
	pei	<L54+cp_0
	pei	<L55+newcp_1+2
	pei	<L55+newcp_1
	jsl	~~memmove
	lda	<L54+oldlen_0
	sta	<L55+descriptor_1
	lda	<L54+cp_0
	sta	<L55+descriptor_1+2
	lda	<L54+cp_0+2
	sta	<L55+descriptor_1+4
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L55+descriptor_1
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
L10034:
	ldx	<L55+newcp_1+2
	lda	<L55+newcp_1
	brl	L57
L10033:
	lda	<L54+newlen_0
	beq	L62
	brl	L10035
L62:
	lda	<L54+oldlen_0
	sta	<L55+descriptor_1
	lda	<L54+cp_0
	sta	<L55+descriptor_1+2
	lda	<L54+cp_0+2
	sta	<L55+descriptor_1+4
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L55+descriptor_1
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
	lda	#<~~emptystring
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	ldx	<R0+2
	lda	<R0
	brl	L57
L10035:
	lda	<L55+newbin_1
	asl	A
	sta	<R0
	lda	<L55+oldbin_1
	asl	A
	sta	<R1
	sec
	ldx	<R1
	lda	|~~binsizes,X
	ldx	<R0
	sbc	|~~binsizes,X
	sta	<L55+sizediff_1
	pei	<L55+sizediff_1
	jsl	~~find_bin
	sta	<R1
	lda	<R1
	asl	A
	sta	<R0
	ldx	<R0
	lda	|~~binsizes,X
	cmp	<L55+sizediff_1
	beq	L63
	brl	L10036
L63:
	lda	<L55+sizediff_1
	sta	<L55+descriptor_1
	lda	<L55+newbin_1
	asl	A
	sta	<R0
	ldy	#$0
	ldx	<R0
	lda	|~~binsizes,X
	bpl	L64
	dey
L64:
	sta	<R1
	sty	<R1+2
	clc
	lda	<L54+cp_0
	adc	<R1
	sta	<L55+descriptor_1+2
	lda	<L54+cp_0+2
	adc	<R1+2
	sta	<L55+descriptor_1+4
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L55+descriptor_1
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
	ldx	<L54+cp_0+2
	lda	<L54+cp_0
	brl	L57
L10036:
	pei	<L54+newlen_0
	jsl	~~alloc_string
	sta	<L55+newcp_1
	stx	<L55+newcp_1+2
	ldy	#$0
	lda	<L54+newlen_0
	bpl	L65
	dey
L65:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L54+cp_0+2
	pei	<L54+cp_0
	pei	<L55+newcp_1+2
	pei	<L55+newcp_1
	jsl	~~memmove
	lda	<L54+oldlen_0
	sta	<L55+descriptor_1
	lda	<L54+cp_0
	sta	<L55+descriptor_1+2
	lda	<L54+cp_0+2
	sta	<L55+descriptor_1+4
	sec
	tsc
	sbc	#6
	tcs
	ina
	sta	<R0
	stz	<R0+2
	clc
	tdc
	adc	#<L55+descriptor_1
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
	ldx	<L55+newcp_1+2
	lda	<L55+newcp_1
	brl	L57
L54	equ	24
L55	equ	9
	ends
	efunc
	code
	xdef	~~get_stringlen
	func
~~get_stringlen:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L66
	tcs
	phd
	tcd
start_0	set	4
n_1	set	0
	lda	<L66+start_0
	sta	<L67+n_1
L10037:
	sec
	lda	<L67+n_1
	sbc	<L66+start_0
	sta	<R0
	sec
	lda	#$1000
	sbc	<R0
	bvs	L68
	eor	#$8000
L68:
	bmi	L69
	brl	L10038
L69:
	lda	|~~basicvars+6
	sta	<R0
	lda	|~~basicvars+6+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	<L67+n_1
	lda	[<R0],Y
	cmp	#<$d
	rep	#$20
	longa	on
	bne	L70
	brl	L10038
L70:
	inc	<L67+n_1
	brl	L10037
L10038:
	lda	|~~basicvars+6
	sta	<R0
	lda	|~~basicvars+6+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	<L67+n_1
	lda	[<R0],Y
	cmp	#<$d
	rep	#$20
	longa	on
	beq	L71
	brl	L10039
L71:
	sec
	lda	<L67+n_1
	sbc	<L66+start_0
L72:
	tay
	lda	<L66+2
	sta	<L66+2+2
	lda	<L66+1
	sta	<L66+1+2
	pld
	tsc
	clc
	adc	#L66+2
	tcs
	tya
	rtl
L10039:
	lda	#$0
	brl	L72
L66	equ	6
L67	equ	5
	ends
	efunc
	code
	xdef	~~clear_strings
	func
~~clear_strings:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L73
	tcs
	phd
	tcd
n_1	set	0
	stz	<L74+n_1
L10042:
	lda	<L74+n_1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~binlists
	adc	<R0
	sta	<R1
	lda	#$0
	sta	(<R1)
	lda	#$0
	ldy	#$2
	sta	(<R1),Y
L10040:
	inc	<L74+n_1
	sec
	lda	<L74+n_1
	sbc	#<$2e
	bvs	L75
	eor	#$8000
L75:
	bmi	L76
	brl	L10042
L76:
L10041:
	stz	|~~freestrings
	stz	|~~freelist
	stz	|~~freelist+2
L77:
	pld
	tsc
	clc
	adc	#L73
	tcs
	rtl
L73	equ	10
L74	equ	9
	ends
	efunc
	code
	xdef	~~compare
	func
~~compare:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L78
	tcs
	phd
	tcd
first_0	set	4
second_0	set	8
	sec
	lda	[<L78+first_0]
	sbc	[<L78+second_0]
	sta	<R0
	ldy	#$2
	lda	[<L78+first_0],Y
	ldy	#$2
	sbc	[<L78+second_0],Y
	sta	<R0+2
	lda	<R0
L80:
	tay
	lda	<L78+2
	sta	<L78+2+8
	lda	<L78+1
	sta	<L78+1+8
	pld
	tsc
	clc
	adc	#L78+8
	tcs
	tya
	rtl
L78	equ	4
L79	equ	5
	ends
	efunc
	code
	func
~~collect:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L81
	tcs
	phd
	tcd
n_1	set	0
here_1	set	2
next_1	set	4
size_1	set	6
p_1	set	8
base_1	set	12
merged_1	set	16
	lda	|~~freestrings
	beq	L83
	brl	L10043
L83:
	lda	#$0
L84:
	tay
	pld
	tsc
	clc
	adc	#L81
	tcs
	tya
	rtl
L10043:
	ldy	#$0
	lda	|~~freestrings
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
	pei	<R0+2
	pei	<R0
	jsl	~~malloc
	sta	<L82+base_1
	stx	<L82+base_1+2
	lda	<L82+base_1
	ora	<L82+base_1+2
	beq	L86
	brl	L10044
L86:
	lda	#$0
	brl	L84
L10044:
	stz	<L82+next_1
	lda	|~~freelist
	sta	<L82+p_1
	lda	|~~freelist+2
	sta	<L82+p_1+2
L10045:
	lda	<L82+p_1
	ora	<L82+p_1+2
	bne	L87
	brl	L10046
L87:
	ldy	#$0
	lda	<L82+next_1
	bpl	L88
	dey
L88:
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
	lda	<L82+base_1
	adc	<R0
	sta	<R1
	lda	<L82+base_1+2
	adc	<R0+2
	sta	<R1+2
	lda	<L82+p_1
	sta	[<R1]
	lda	<L82+p_1+2
	ldy	#$2
	sta	[<R1],Y
	ldy	#$0
	lda	<L82+next_1
	bpl	L89
	dey
L89:
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
	lda	#$4
	adc	<L82+base_1
	sta	<R1
	lda	#$0
	adc	<L82+base_1+2
	sta	<R1+2
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	lda	<R1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$4
	lda	[<L82+p_1],Y
	sta	[<R2]
	inc	<L82+next_1
	lda	[<L82+p_1]
	sta	<R0
	ldy	#$2
	lda	[<L82+p_1],Y
	sta	<R0+2
	lda	<R0
	sta	<L82+p_1
	lda	<R0+2
	sta	<L82+p_1+2
	brl	L10045
L10046:
	lda	#$1
	sta	<L82+n_1
L10049:
	lda	<L82+n_1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~binlists
	adc	<R0
	sta	<R1
	lda	(<R1)
	sta	<L82+p_1
	ldy	#$2
	lda	(<R1),Y
	sta	<L82+p_1+2
	lda	<L82+n_1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~binlists
	adc	<R0
	sta	<R1
	lda	#$0
	sta	(<R1)
	lda	#$0
	ldy	#$2
	sta	(<R1),Y
	lda	<L82+n_1
	asl	A
	sta	<R0
	ldx	<R0
	lda	|~~binsizes,X
	sta	<L82+size_1
L10050:
	lda	<L82+p_1
	ora	<L82+p_1+2
	bne	L90
	brl	L10051
L90:
	ldy	#$0
	lda	<L82+next_1
	bpl	L91
	dey
L91:
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
	lda	<L82+base_1
	adc	<R0
	sta	<R1
	lda	<L82+base_1+2
	adc	<R0+2
	sta	<R1+2
	lda	<L82+p_1
	sta	[<R1]
	lda	<L82+p_1+2
	ldy	#$2
	sta	[<R1],Y
	ldy	#$0
	lda	<L82+next_1
	bpl	L92
	dey
L92:
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
	lda	#$4
	adc	<L82+base_1
	sta	<R1
	lda	#$0
	adc	<L82+base_1+2
	sta	<R1+2
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	lda	<R1+2
	adc	<R0+2
	sta	<R2+2
	lda	<L82+size_1
	sta	[<R2]
	inc	<L82+next_1
	lda	[<L82+p_1]
	sta	<R0
	ldy	#$2
	lda	[<L82+p_1],Y
	sta	<R0+2
	lda	<R0
	sta	<L82+p_1
	lda	<R0+2
	sta	<L82+p_1+2
	brl	L10050
L10051:
L10047:
	inc	<L82+n_1
	sec
	lda	<L82+n_1
	sbc	#<$2e
	bvs	L93
	eor	#$8000
L93:
	bmi	L94
	brl	L10049
L94:
L10048:
	pea	#^~~compare
	pea	#<~~compare
	pea	#^$6
	pea	#<$6
	ldy	#$0
	lda	|~~freestrings
	bpl	L95
	dey
L95:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L82+base_1+2
	pei	<L82+base_1
	jsl	~~qsort
	sep	#$20
	longa	off
	stz	<L82+merged_1
	rep	#$20
	longa	on
	stz	<L82+here_1
	lda	#$1
	sta	<L82+next_1
L10054:
	ldy	#$0
	lda	<L82+here_1
	bpl	L96
	dey
L96:
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
	lda	#$4
	adc	<L82+base_1
	sta	<R1
	lda	#$0
	adc	<L82+base_1+2
	sta	<R1+2
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	lda	<R1+2
	adc	<R0+2
	sta	<R2+2
	lda	[<R2]
	sta	<L82+size_1
L10055:
	sec
	lda	<L82+next_1
	sbc	|~~freestrings
	bvs	L97
	eor	#$8000
L97:
	bpl	L98
	brl	L10056
L98:
	ldy	#$0
	lda	<L82+size_1
	bpl	L99
	dey
L99:
	sta	<R0
	sty	<R0+2
	ldy	#$0
	lda	<L82+here_1
	bpl	L100
	dey
L100:
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
	lda	<L82+base_1
	adc	<R1
	sta	<R2
	lda	<L82+base_1+2
	adc	<R1+2
	sta	<R2+2
	clc
	lda	[<R2]
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	[<R2],Y
	adc	<R0+2
	sta	<R1+2
	ldy	#$0
	lda	<L82+next_1
	bpl	L101
	dey
L101:
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
	lda	<L82+base_1
	adc	<R0
	sta	<R2
	lda	<L82+base_1+2
	adc	<R0+2
	sta	<R2+2
	lda	[<R2]
	cmp	<R1
	bne	L102
	ldy	#$2
	lda	[<R2],Y
	cmp	<R1+2
L102:
	beq	L103
	brl	L10056
L103:
	ldy	#$0
	lda	<L82+here_1
	bpl	L104
	dey
L104:
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
	lda	#$4
	adc	<L82+base_1
	sta	<R1
	lda	#$0
	adc	<L82+base_1+2
	sta	<R1+2
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	lda	<R1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	<L82+next_1
	bpl	L105
	dey
L105:
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
	lda	#$4
	adc	<L82+base_1
	sta	<R1
	lda	#$0
	adc	<L82+base_1+2
	sta	<R1+2
	clc
	lda	<R1
	adc	<R0
	sta	<R3
	lda	<R1+2
	adc	<R0+2
	sta	<R3+2
	clc
	lda	[<R3]
	adc	<L82+size_1
	sta	<L82+size_1
	lda	<L82+size_1
	sta	[<R2]
	ldy	#$0
	lda	<L82+next_1
	bpl	L106
	dey
L106:
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
	lda	<L82+base_1
	adc	<R0
	sta	<R1
	lda	<L82+base_1+2
	adc	<R0+2
	sta	<R1+2
	lda	#$0
	sta	[<R1]
	lda	#$0
	ldy	#$2
	sta	[<R1],Y
	sep	#$20
	longa	off
	lda	#$1
	sta	<L82+merged_1
	rep	#$20
	longa	on
	inc	<L82+next_1
	brl	L10055
L10056:
	lda	<L82+next_1
	sta	<L82+here_1
	inc	<L82+next_1
L10052:
	clc
	lda	#$ffff
	adc	|~~freestrings
	sta	<R0
	sec
	lda	<L82+here_1
	sbc	<R0
	bvs	L107
	eor	#$8000
L107:
	bmi	L108
	brl	L10054
L108:
L10053:
	clc
	lda	#$ffff
	adc	|~~freestrings
	sta	<L82+n_1
L10057:
	lda	<L82+n_1
	bpl	L109
	brl	L10058
L109:
	ldy	#$0
	lda	<L82+n_1
	bpl	L110
	dey
L110:
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
	lda	<L82+base_1
	adc	<R0
	sta	<R1
	lda	<L82+base_1+2
	adc	<R0+2
	sta	<R1+2
	lda	[<R1]
	ldy	#$2
	ora	[<R1],Y
	beq	L111
	brl	L10058
L111:
	dec	<L82+n_1
	brl	L10057
L10058:
	lda	<L82+n_1
	bpl	L112
	brl	L10059
L112:
	ldy	#$0
	lda	<L82+n_1
	bpl	L113
	dey
L113:
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
	lda	#$4
	adc	<L82+base_1
	sta	<R1
	lda	#$0
	adc	<L82+base_1+2
	sta	<R1+2
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	lda	<R1+2
	adc	<R0+2
	sta	<R2+2
	lda	[<R2]
	pha
	ldy	#$0
	lda	<L82+n_1
	bpl	L114
	dey
L114:
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
	lda	<L82+base_1
	adc	<R0
	sta	<R1
	lda	<L82+base_1+2
	adc	<R0+2
	sta	<R1+2
	ldy	#$2
	lda	[<R1],Y
	pha
	lda	[<R1]
	pha
	jsl	~~returnable
	and	#$ff
	bne	L115
	brl	L10059
L115:
	ldy	#$0
	lda	<L82+n_1
	bpl	L116
	dey
L116:
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
	lda	#$4
	adc	<L82+base_1
	sta	<R1
	lda	#$0
	adc	<L82+base_1+2
	sta	<R1+2
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	lda	<R1+2
	adc	<R0+2
	sta	<R2+2
	lda	[<R2]
	pha
	ldy	#$0
	lda	<L82+n_1
	bpl	L117
	dey
L117:
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
	lda	<L82+base_1
	adc	<R0
	sta	<R1
	lda	<L82+base_1+2
	adc	<R0+2
	sta	<R1+2
	ldy	#$2
	lda	[<R1],Y
	pha
	lda	[<R1]
	pha
	jsl	~~freemem
	dec	<L82+n_1
L10059:
	stz	|~~freestrings
	stz	|~~freelist
	stz	|~~freelist+2
L10060:
	lda	<L82+n_1
	bpl	L118
	brl	L10061
L118:
	ldy	#$0
	lda	<L82+n_1
	bpl	L119
	dey
L119:
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
	lda	<L82+base_1
	adc	<R0
	sta	<R1
	lda	<L82+base_1+2
	adc	<R0+2
	sta	<R1+2
	lda	[<R1]
	ldy	#$2
	ora	[<R1],Y
	bne	L120
	brl	L10062
L120:
	ldy	#$0
	lda	<L82+n_1
	bpl	L121
	dey
L121:
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
	lda	#$4
	adc	<L82+base_1
	sta	<R1
	lda	#$0
	adc	<L82+base_1+2
	sta	<R1+2
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	lda	<R1+2
	adc	<R0+2
	sta	<R2+2
	sec
	lda	#$1000
	sbc	[<R2]
	bvs	L122
	eor	#$8000
L122:
	bmi	L123
	brl	L10063
L123:
	ldy	#$0
	lda	<L82+n_1
	bpl	L124
	dey
L124:
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
	lda	#$4
	adc	<L82+base_1
	sta	<R1
	lda	#$0
	adc	<L82+base_1+2
	sta	<R1+2
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	lda	<R1+2
	adc	<R0+2
	sta	<R2+2
	lda	[<R2]
	pha
	jsl	~~find_bin
	sta	<L82+size_1
	brl	L10064
L10063:
	stz	<L82+size_1
L10064:
	sec
	lda	#$0
	sbc	<L82+size_1
	bvs	L125
	eor	#$8000
L125:
	bpl	L126
	brl	L10065
L126:
	lda	<L82+size_1
	asl	A
	sta	<R0
	ldy	#$0
	lda	<L82+n_1
	bpl	L127
	dey
L127:
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
	lda	#$4
	adc	<L82+base_1
	sta	<R2
	lda	#$0
	adc	<L82+base_1+2
	sta	<R2+2
	clc
	lda	<R2
	adc	<R1
	sta	<R3
	lda	<R2+2
	adc	<R1+2
	sta	<R3+2
	lda	[<R3]
	ldx	<R0
	cmp	|~~binsizes,X
	beq	L128
	brl	L10065
L128:
	ldy	#$0
	lda	<L82+n_1
	bpl	L129
	dey
L129:
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
	lda	<L82+base_1
	adc	<R0
	sta	<R1
	lda	<L82+base_1+2
	adc	<R0+2
	sta	<R1+2
	lda	[<R1]
	sta	<R0
	ldy	#$2
	lda	[<R1],Y
	sta	<R0+2
	lda	<L82+size_1
	asl	A
	asl	A
	sta	<R1
	clc
	lda	#<~~binlists
	adc	<R1
	sta	<R2
	lda	(<R2)
	sta	[<R0]
	ldy	#$2
	lda	(<R2),Y
	ldy	#$2
	sta	[<R0],Y
	lda	<L82+size_1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~binlists
	adc	<R0
	sta	<R1
	ldy	#$0
	lda	<L82+n_1
	bpl	L130
	dey
L130:
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
	lda	<L82+base_1
	adc	<R0
	sta	<R2
	lda	<L82+base_1+2
	adc	<R0+2
	sta	<R2+2
	lda	[<R2]
	sta	(<R1)
	ldy	#$2
	lda	[<R2],Y
	ldy	#$2
	sta	(<R1),Y
	brl	L10066
L10065:
	ldy	#$0
	lda	<L82+n_1
	bpl	L131
	dey
L131:
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
	lda	<L82+base_1
	adc	<R0
	sta	<R1
	lda	<L82+base_1+2
	adc	<R0+2
	sta	<R1+2
	lda	[<R1]
	sta	<R0
	ldy	#$2
	lda	[<R1],Y
	sta	<R0+2
	ldy	#$0
	lda	<L82+n_1
	bpl	L132
	dey
L132:
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
	lda	#$4
	adc	<L82+base_1
	sta	<R2
	lda	#$0
	adc	<L82+base_1+2
	sta	<R2+2
	clc
	lda	<R2
	adc	<R1
	sta	<R3
	lda	<R2+2
	adc	<R1+2
	sta	<R3+2
	lda	[<R3]
	ldy	#$4
	sta	[<R0],Y
	ldy	#$0
	lda	<L82+n_1
	bpl	L133
	dey
L133:
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
	lda	<L82+base_1
	adc	<R0
	sta	<R1
	lda	<L82+base_1+2
	adc	<R0+2
	sta	<R1+2
	lda	[<R1]
	sta	<R0
	ldy	#$2
	lda	[<R1],Y
	sta	<R0+2
	lda	|~~freelist
	sta	[<R0]
	lda	|~~freelist+2
	ldy	#$2
	sta	[<R0],Y
	ldy	#$0
	lda	<L82+n_1
	bpl	L134
	dey
L134:
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
	lda	<L82+base_1
	adc	<R0
	sta	<R1
	lda	<L82+base_1+2
	adc	<R0+2
	sta	<R1+2
	lda	[<R1]
	sta	|~~freelist
	ldy	#$2
	lda	[<R1],Y
	sta	|~~freelist+2
L10066:
	inc	|~~freestrings
L10062:
	dec	<L82+n_1
	brl	L10060
L10061:
	pei	<L82+base_1+2
	pei	<L82+base_1
	jsl	~~free
	lda	<L82+merged_1
	and	#$ff
	brl	L84
L81	equ	33
L82	equ	17
	ends
	efunc
	xref	~~error
	xref	~~freemem
	xref	~~returnable
	xref	~~condalloc
	xref	~~qsort
	xref	~~free
	xref	~~malloc
	xref	~~memmove
	udata
	xdef	~~emptystring
~~emptystring
	ds	1
	ends
	udata
~~freelist
	ds	4
	ends
	udata
~~binlists
	ds	184
	ends
	udata
~~freestrings
	ds	2
	ends
	xref	~~basicvars
	end
