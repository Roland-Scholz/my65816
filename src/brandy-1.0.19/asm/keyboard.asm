;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
	code
	func
~~push_key:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
ch_0	set	4
	inc	|~~holdcount
	lda	|~~holdcount
	asl	A
	sta	<R0
	lda	<L2+ch_0
	ldx	<R0
	sta	|~~holdstack,X
L4:
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
L2	equ	4
L3	equ	5
	ends
	efunc
	code
	func
~~pop_key:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L5
	tcs
	phd
	tcd
	lda	|~~holdcount
	sta	<R1
	dec	|~~holdcount
	lda	<R1
	asl	A
	sta	<R0
	ldx	<R0
	lda	|~~holdstack,X
L7:
	tay
	pld
	tsc
	clc
	adc	#L5
	tcs
	tya
	rtl
L5	equ	8
L6	equ	9
	ends
	efunc
	code
	xdef	~~set_fn_string
	func
~~set_fn_string:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L8
	tcs
	phd
	tcd
key_0	set	4
string_0	set	6
length_0	set	10
	lda	<L8+key_0
	asl	A
	adc	<L8+key_0
	asl	A
	sta	<R0
	clc
	lda	#$2
	adc	#<~~fn_key
	sta	<R1
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	lda	(<R2)
	ldy	#$2
	ora	(<R2),Y
	bne	L10
	brl	L10001
L10:
	lda	<L8+key_0
	asl	A
	adc	<L8+key_0
	asl	A
	sta	<R0
	clc
	lda	#$2
	adc	#<~~fn_key
	sta	<R1
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	ldy	#$2
	lda	(<R2),Y
	pha
	lda	(<R2)
	pha
	jsl	~~free
L10001:
	lda	<L8+key_0
	asl	A
	adc	<L8+key_0
	asl	A
	sta	<R0
	lda	<L8+length_0
	ldx	<R0
	sta	|~~fn_key,X
	lda	<L8+key_0
	asl	A
	adc	<L8+key_0
	asl	A
	sta	<R0
	clc
	lda	#$2
	adc	#<~~fn_key
	sta	<R1
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	ldy	#$0
	lda	<L8+length_0
	bpl	L11
	dey
L11:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~malloc
	sta	<R1
	stx	<R1+2
	lda	<R1
	sta	(<R2)
	lda	<R1+2
	ldy	#$2
	sta	(<R2),Y
	lda	<L8+key_0
	asl	A
	adc	<L8+key_0
	asl	A
	sta	<R0
	clc
	lda	#$2
	adc	#<~~fn_key
	sta	<R1
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	lda	(<R2)
	ldy	#$2
	ora	(<R2),Y
	bne	L12
	brl	L10002
L12:
	ldy	#$0
	lda	<L8+length_0
	bpl	L13
	dey
L13:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L8+string_0+2
	pei	<L8+string_0
	lda	<L8+key_0
	asl	A
	adc	<L8+key_0
	asl	A
	sta	<R1
	clc
	lda	#$2
	adc	#<~~fn_key
	sta	<R2
	clc
	lda	<R2
	adc	<R1
	sta	<R3
	ldy	#$2
	lda	(<R3),Y
	pha
	lda	(<R3)
	pha
	jsl	~~memcpy
L10002:
L14:
	lda	<L8+2
	sta	<L8+2+8
	lda	<L8+1
	sta	<L8+1+8
	pld
	tsc
	clc
	adc	#L8+8
	tcs
	rtl
L8	equ	16
L9	equ	17
	ends
	efunc
	code
	func
~~switch_fn_string:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L15
	tcs
	phd
	tcd
key_0	set	4
ch_1	set	0
	lda	<L15+key_0
	asl	A
	adc	<L15+key_0
	asl	A
	sta	<R0
	ldx	<R0
	lda	|~~fn_key,X
	cmp	#<$1
	beq	L17
	brl	L10003
L17:
	lda	<L15+key_0
	asl	A
	adc	<L15+key_0
	asl	A
	sta	<R0
	clc
	lda	#$2
	adc	#<~~fn_key
	sta	<R1
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	lda	(<R2)
	sta	<R0
	ldy	#$2
	lda	(<R2),Y
	sta	<R0+2
	lda	[<R0]
	and	#$ff
L18:
	tay
	lda	<L15+2
	sta	<L15+2+2
	lda	<L15+1
	sta	<L15+1+2
	pld
	tsc
	clc
	adc	#L15+2
	tcs
	tya
	rtl
L10003:
	lda	<L15+key_0
	asl	A
	adc	<L15+key_0
	asl	A
	sta	<R0
	clc
	lda	#$2
	adc	#<~~fn_key
	sta	<R1
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	lda	(<R2)
	sta	|~~fn_string
	ldy	#$2
	lda	(<R2),Y
	sta	|~~fn_string+2
	lda	<L15+key_0
	asl	A
	adc	<L15+key_0
	asl	A
	sta	<R0
	clc
	lda	#$ffff
	ldx	<R0
	adc	|~~fn_key,X
	sta	|~~fn_string_count
	lda	|~~fn_string
	sta	<R0
	lda	|~~fn_string+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	sta	<L16+ch_1
	inc	|~~fn_string
	bne	L19
	inc	|~~fn_string+2
L19:
	lda	<L16+ch_1
	brl	L18
L15	equ	14
L16	equ	13
	ends
	efunc
	code
	func
~~read_fn_string:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L20
	tcs
	phd
	tcd
ch_1	set	0
	lda	|~~fn_string
	sta	<R0
	lda	|~~fn_string+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	sta	<L21+ch_1
	inc	|~~fn_string
	bne	L22
	inc	|~~fn_string+2
L22:
	dec	|~~fn_string_count
	lda	|~~fn_string_count
	beq	L23
	brl	L10004
L23:
	stz	|~~fn_string
	stz	|~~fn_string+2
L10004:
	lda	<L21+ch_1
L24:
	tay
	pld
	tsc
	clc
	adc	#L20
	tcs
	tya
	rtl
L20	equ	6
L21	equ	5
	ends
	efunc
	code
	func
~~is_fn_key:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L25
	tcs
	phd
	tcd
key_0	set	4
	sec
	lda	<L25+key_0
	sbc	#<$81
	bvs	L27
	eor	#$8000
L27:
	bmi	L28
	brl	L10005
L28:
	sec
	lda	#$89
	sbc	<L25+key_0
	bvs	L29
	eor	#$8000
L29:
	bmi	L30
	brl	L10005
L30:
	clc
	lda	#$ff80
	adc	<L25+key_0
L31:
	tay
	lda	<L25+2
	sta	<L25+2+2
	lda	<L25+1
	sta	<L25+1+2
	pld
	tsc
	clc
	adc	#L25+2
	tcs
	tya
	rtl
L10005:
	sec
	lda	<L25+key_0
	sbc	#<$ca
	bvs	L32
	eor	#$8000
L32:
	bmi	L33
	brl	L10006
L33:
	sec
	lda	#$cc
	sbc	<L25+key_0
	bvs	L34
	eor	#$8000
L34:
	bmi	L35
	brl	L10006
L35:
	clc
	lda	#$ff40
	adc	<L25+key_0
	brl	L31
L10006:
	lda	#$0
	brl	L31
L25	equ	0
L26	equ	1
	ends
	efunc
	code
	func
~~waitkey:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L36
	tcs
	phd
	tcd
wait_0	set	4
keyset_1	set	0
waitime_1	set	128
available_1	set	136
	pea	#^$80
	pea	#<$80
	pea	#<$0
	pea	#0
	clc
	tdc
	adc	#<L37+keyset_1
	pha
	jsl	~~memset
	pea	#^$1
	pea	#<$1
	lda	|~~keyboard
	and	#<$1f
	sta	<R1
	stz	<R1+2
	lda	<R1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	ldy	#$0
	lda	|~~keyboard
	bpl	L38
	dey
L38:
	sta	<R3
	sty	<R3+2
	pei	<R3+2
	pei	<R3
	lda	#$5
	xref	~~~llsr
	jsl	~~~llsr
	sta	<R2
	stx	<R2+2
	pei	<R2+2
	pei	<R2
	lda	#$2
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R1
	stx	<R1+2
	clc
	tdc
	adc	#<L37+keyset_1
	sta	<17
	lda	#$0
	sta	<17+2
	clc
	lda	<17
	adc	<R1
	sta	<21
	lda	<17+2
	adc	<R1+2
	sta	<21+2
	lda	[<21]
	ora	<R0
	sta	[<21]
	ldy	#$2
	lda	[<21],Y
	ora	<R0+2
	ldy	#$2
	sta	[<21],Y
	lda	<L36+wait_0
	ldx	#<$64
	xref	~~~div
	jsl	~~~div
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L39
	dey
L39:
	sta	<L37+waitime_1
	sty	<L37+waitime_1+2
	lda	<L36+wait_0
	ldx	#<$64
	xref	~~~mod
	jsl	~~~mod
	sta	<R0
	lda	<R0
	ldx	#<$2710
	xref	~~~mul
	jsl	~~~mul
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L40
	dey
L40:
	sta	<L37+waitime_1+4
	sty	<L37+waitime_1+6
	stz	<R0
	sec
	lda	#$0
	sbc	<L37+available_1
	bvs	L42
	eor	#$8000
L42:
	bpl	L43
	brl	L41
L43:
	inc	<R0
L41:
	lda	<R0
	and	#$ff
L44:
	tay
	lda	<L36+2
	sta	<L36+2+2
	lda	<L36+1
	sta	<L36+1+2
	pld
	tsc
	clc
	adc	#L36+2
	tcs
	tya
	rtl
L36	equ	162
L37	equ	25
	ends
	efunc
	code
	xdef	~~read_key
	func
~~read_key:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L45
	tcs
	phd
	tcd
ch_1	set	0
errcode_1	set	1
	pea	#^$1
	pea	#<$1
	pea	#0
	clc
	tdc
	adc	#<L46+ch_1
	pha
	lda	|~~keyboard
	pha
	jsl	~~read
	sta	<L46+errcode_1
	lda	<L46+errcode_1
	bmi	L47
	brl	L10007
L47:
	jsl	~~__errno_location
	sta	<R0
	stx	<R0+2
	lda	[<R0]
	cmp	#<$20
	beq	L48
	brl	L10008
L48:
	pea	#<$8
	pea	#4
	jsl	~~error
L10008:
	pea	#^L1
	pea	#<L1
	pea	#<$19d
	pea	#<$82
	pea	#10
	jsl	~~error
L10007:
	lda	<L46+ch_1
	and	#$ff
L49:
	tay
	pld
	tsc
	clc
	adc	#L45
	tcs
	tya
	rtl
L45	equ	7
L46	equ	5
	ends
	efunc
	data
L1:
	db	$6B,$65,$79,$62,$6F,$61,$72,$64,$00
	ends
	code
	func
~~decode_sequence:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L51
	tcs
	phd
	tcd
	data
L53:
	dw	$81,$82,$83,$84,$85,$86,$87,$88,$89,$CA
	dw	$CB,$CC,$93,$94,$95,$96,$97,$98,$99,$DA
	ends
	data
L54:
	dw	$4,$5,$6,$7,$8,$9
	ends
	data
L55:
	dw	$B,$C,$D,$E,$F,$0,$10,$11,$12
	ends
	data
L56:
	dw	$13,$14,$0,$15,$16,$17,$18,$0,$19,$1A
	ends
	data
L57:
	dw	$1B,$1C,$1D,$1E
	ends
state_1	set	0
newstate_1	set	2
ch_1	set	4
ok_1	set	6
	lda	#$1
	sta	<L52+state_1
	sep	#$20
	longa	off
	lda	#$1
	sta	<L52+ok_1
	rep	#$20
	longa	on
L10009:
	lda	<L52+ok_1
	and	#$ff
	bne	L58
	brl	L10010
L58:
	pea	#<$a
	jsl	~~waitkey
	and	#$ff
	bne	L59
	brl	L10010
L59:
	jsl	~~read_key
	sta	<L52+ch_1
	lda	<L52+state_1
	brl	L10011
L10013:
	lda	<L52+ch_1
	cmp	#<$4f
	beq	L60
	brl	L10014
L60:
	lda	#$2
	sta	<L52+state_1
	brl	L10015
L10014:
	lda	<L52+ch_1
	cmp	#<$5b
	beq	L61
	brl	L10016
L61:
	lda	#$3
	sta	<L52+state_1
	brl	L10017
L10016:
	sep	#$20
	longa	off
	stz	<L52+ok_1
	rep	#$20
	longa	on
L10017:
L10015:
	brl	L10012
L10018:
	sec
	lda	<L52+ch_1
	sbc	#<$50
	bvs	L62
	eor	#$8000
L62:
	bmi	L63
	brl	L10019
L63:
	sec
	lda	#$53
	sbc	<L52+ch_1
	bvs	L64
	eor	#$8000
L64:
	bmi	L65
	brl	L10019
L65:
	clc
	lda	#$31
	adc	<L52+ch_1
	pha
	jsl	~~push_key
	lda	#$0
L66:
	tay
	pld
	tsc
	clc
	adc	#L51
	tcs
	tya
	rtl
L10019:
	sep	#$20
	longa	off
	stz	<L52+ok_1
	rep	#$20
	longa	on
	brl	L10012
L10020:
	lda	<L52+ch_1
	brl	L10021
L10023:
	pea	#<$8f
	jsl	~~push_key
	lda	#$0
	brl	L66
L10024:
	pea	#<$8e
	jsl	~~push_key
	lda	#$0
	brl	L66
L10025:
	pea	#<$8d
	jsl	~~push_key
	lda	#$0
	brl	L66
L10026:
	pea	#<$8c
	jsl	~~push_key
	lda	#$0
	brl	L66
L10027:
	pea	#<$8b
	jsl	~~push_key
	lda	#$0
	brl	L66
L10028:
	lda	#$1e
	brl	L66
L10029:
L10030:
L10031:
L10032:
L10033:
L10034:
	lda	<L52+ch_1
	asl	A
	sta	<R0
	ldx	<R0
	lda	|L54-98,X
	sta	<L52+state_1
	brl	L10022
L10035:
	lda	#$a
	sta	<L52+state_1
	brl	L10022
L10036:
	sep	#$20
	longa	off
	stz	<L52+ok_1
	rep	#$20
	longa	on
	brl	L10022
L10021:
	xref	~~~swt
	jsl	~~~swt
	dw	13
	dw	49
	dw	L10029-1
	dw	50
	dw	L10030-1
	dw	51
	dw	L10031-1
	dw	52
	dw	L10032-1
	dw	53
	dw	L10033-1
	dw	54
	dw	L10034-1
	dw	65
	dw	L10023-1
	dw	66
	dw	L10024-1
	dw	67
	dw	L10025-1
	dw	68
	dw	L10026-1
	dw	70
	dw	L10027-1
	dw	72
	dw	L10028-1
	dw	91
	dw	L10035-1
	dw	L10036-1
L10022:
	brl	L10012
L10037:
	sec
	lda	<L52+ch_1
	sbc	#<$31
	bvs	L67
	eor	#$8000
L67:
	bmi	L68
	brl	L10038
L68:
	sec
	lda	#$39
	sbc	<L52+ch_1
	bvs	L69
	eor	#$8000
L69:
	bmi	L70
	brl	L10038
L70:
	lda	<L52+ch_1
	asl	A
	sta	<R0
	ldx	<R0
	lda	|L55-98,X
	sta	<L52+newstate_1
	lda	<L52+newstate_1
	beq	L71
	brl	L10039
L71:
	sep	#$20
	longa	off
	stz	<L52+ok_1
	rep	#$20
	longa	on
	brl	L10040
L10039:
	lda	<L52+newstate_1
	sta	<L52+state_1
L10040:
	brl	L10041
L10038:
	lda	<L52+ch_1
	cmp	#<$7e
	beq	L72
	brl	L10042
L72:
	lda	#$1e
	brl	L66
L10042:
	sep	#$20
	longa	off
	stz	<L52+ok_1
	rep	#$20
	longa	on
L10041:
	brl	L10012
L10043:
	sec
	lda	<L52+ch_1
	sbc	#<$30
	bvs	L73
	eor	#$8000
L73:
	bmi	L74
	brl	L10044
L74:
	sec
	lda	#$39
	sbc	<L52+ch_1
	bvs	L75
	eor	#$8000
L75:
	bmi	L76
	brl	L10044
L76:
	lda	<L52+ch_1
	asl	A
	sta	<R0
	ldx	<R0
	lda	|L56-96,X
	sta	<L52+newstate_1
	lda	<L52+newstate_1
	beq	L77
	brl	L10045
L77:
	sep	#$20
	longa	off
	stz	<L52+ok_1
	rep	#$20
	longa	on
	brl	L10046
L10045:
	lda	<L52+newstate_1
	sta	<L52+state_1
L10046:
	brl	L10047
L10044:
	lda	<L52+ch_1
	cmp	#<$7e
	beq	L78
	brl	L10048
L78:
	pea	#<$cd
	jsl	~~push_key
	lda	#$0
	brl	L66
L10048:
	sep	#$20
	longa	off
	stz	<L52+ok_1
	rep	#$20
	longa	on
L10047:
	brl	L10012
L10049:
	sec
	lda	<L52+ch_1
	sbc	#<$31
	bvs	L79
	eor	#$8000
L79:
	bmi	L80
	brl	L10050
L80:
	sec
	lda	#$34
	sbc	<L52+ch_1
	bvs	L81
	eor	#$8000
L81:
	bmi	L82
	brl	L10050
L82:
	lda	<L52+ch_1
	asl	A
	sta	<R0
	ldx	<R0
	lda	|L57-98,X
	sta	<L52+newstate_1
	lda	<L52+newstate_1
	beq	L83
	brl	L10051
L83:
	sep	#$20
	longa	off
	stz	<L52+ok_1
	rep	#$20
	longa	on
	brl	L10052
L10051:
	lda	<L52+newstate_1
	sta	<L52+state_1
L10052:
	brl	L10053
L10050:
	lda	<L52+ch_1
	cmp	#<$7e
	beq	L84
	brl	L10054
L84:
	lda	#$8
	brl	L66
L10054:
	sep	#$20
	longa	off
	stz	<L52+ok_1
	rep	#$20
	longa	on
L10053:
	brl	L10012
L10055:
	lda	<L52+ch_1
	cmp	#<$7e
	beq	L85
	brl	L10056
L85:
	pea	#<$8b
	jsl	~~push_key
	lda	#$0
	brl	L66
L10056:
	sep	#$20
	longa	off
	stz	<L52+ok_1
	rep	#$20
	longa	on
	brl	L10012
L10057:
	lda	<L52+ch_1
	cmp	#<$7e
	beq	L86
	brl	L10058
L86:
	pea	#<$9f
	jsl	~~push_key
	lda	#$0
	brl	L66
L10058:
	sep	#$20
	longa	off
	stz	<L52+ok_1
	rep	#$20
	longa	on
	brl	L10012
L10059:
	lda	<L52+ch_1
	cmp	#<$7e
	beq	L87
	brl	L10060
L87:
	pea	#<$9e
	jsl	~~push_key
	lda	#$0
	brl	L66
L10060:
	sep	#$20
	longa	off
	stz	<L52+ok_1
	rep	#$20
	longa	on
	brl	L10012
L10061:
	sec
	lda	<L52+ch_1
	sbc	#<$41
	bvs	L88
	eor	#$8000
L88:
	bmi	L89
	brl	L10062
L89:
	sec
	lda	#$45
	sbc	<L52+ch_1
	bvs	L90
	eor	#$8000
L90:
	bmi	L91
	brl	L10062
L91:
	clc
	lda	#$40
	adc	<L52+ch_1
	pha
	jsl	~~push_key
	lda	#$0
	brl	L66
L10062:
	sep	#$20
	longa	off
	stz	<L52+ok_1
	rep	#$20
	longa	on
	brl	L10012
L10063:
L10064:
L10065:
L10066:
L10067:
L10068:
L10069:
L10070:
L10071:
L10072:
L10073:
L10074:
L10075:
L10076:
L10077:
L10078:
L10079:
L10080:
L10081:
L10082:
	lda	<L52+ch_1
	cmp	#<$7e
	beq	L92
	brl	L10083
L92:
	lda	<L52+state_1
	asl	A
	sta	<R0
	ldx	<R0
	lda	|L53-22,X
	pha
	jsl	~~push_key
	lda	#$0
	brl	L66
L10083:
	sep	#$20
	longa	off
	stz	<L52+ok_1
	rep	#$20
	longa	on
	brl	L10012
L10011:
	xref	~~~fsw
	jsl	~~~fsw
	dw	1
	dw	30
	dw	L10012-1
	dw	L10013-1
	dw	L10018-1
	dw	L10020-1
	dw	L10037-1
	dw	L10043-1
	dw	L10049-1
	dw	L10055-1
	dw	L10057-1
	dw	L10059-1
	dw	L10061-1
	dw	L10063-1
	dw	L10064-1
	dw	L10065-1
	dw	L10066-1
	dw	L10067-1
	dw	L10068-1
	dw	L10069-1
	dw	L10070-1
	dw	L10071-1
	dw	L10072-1
	dw	L10073-1
	dw	L10074-1
	dw	L10075-1
	dw	L10076-1
	dw	L10077-1
	dw	L10078-1
	dw	L10079-1
	dw	L10080-1
	dw	L10081-1
	dw	L10082-1
L10012:
	brl	L10009
L10010:
	lda	<L52+ok_1
	and	#$ff
	beq	L93
	brl	L10084
L93:
	pei	<L52+ch_1
	jsl	~~push_key
L10084:
	lda	<L52+state_1
	brl	L10085
L10087:
	lda	#$1b
	brl	L66
L10088:
	pea	#<$4f
	jsl	~~push_key
	lda	#$1b
	brl	L66
L10089:
	brl	L10086
L10090:
L10091:
L10092:
L10093:
L10094:
L10095:
	clc
	lda	#$2d
	adc	<L52+state_1
	pha
	jsl	~~push_key
	brl	L10086
L10096:
	pea	#<$5b
	jsl	~~push_key
	brl	L10086
L10097:
L10098:
L10099:
L10100:
L10101:
	clc
	lda	#$fff6
	adc	<L52+state_1
	pha
	jsl	~~push_key
	pea	#<$31
	jsl	~~push_key
	brl	L10086
L10102:
L10103:
L10104:
	clc
	lda	#$27
	adc	<L52+state_1
	pha
	jsl	~~push_key
	pea	#<$31
	jsl	~~push_key
	brl	L10086
L10105:
L10106:
	clc
	lda	#$1d
	adc	<L52+state_1
	pha
	jsl	~~push_key
	pea	#<$32
	jsl	~~push_key
	brl	L10086
L10107:
L10108:
L10109:
L10110:
	clc
	lda	#$1e
	adc	<L52+state_1
	pha
	jsl	~~push_key
	pea	#<$32
	jsl	~~push_key
	brl	L10086
L10111:
L10112:
	clc
	lda	#$1f
	adc	<L52+state_1
	pha
	jsl	~~push_key
	pea	#<$32
	jsl	~~push_key
L10113:
L10114:
L10115:
L10116:
	clc
	lda	#$16
	adc	<L52+state_1
	pha
	jsl	~~push_key
	pea	#<$3
	jsl	~~push_key
	brl	L10086
L10085:
	xref	~~~fsw
	jsl	~~~fsw
	dw	1
	dw	30
	dw	L10086-1
	dw	L10087-1
	dw	L10088-1
	dw	L10089-1
	dw	L10090-1
	dw	L10091-1
	dw	L10092-1
	dw	L10093-1
	dw	L10094-1
	dw	L10095-1
	dw	L10096-1
	dw	L10097-1
	dw	L10098-1
	dw	L10099-1
	dw	L10100-1
	dw	L10101-1
	dw	L10102-1
	dw	L10103-1
	dw	L10104-1
	dw	L10105-1
	dw	L10106-1
	dw	L10107-1
	dw	L10108-1
	dw	L10109-1
	dw	L10110-1
	dw	L10111-1
	dw	L10112-1
	dw	L10113-1
	dw	L10114-1
	dw	L10115-1
	dw	L10116-1
L10086:
	pea	#<$5b
	jsl	~~push_key
	lda	#$1b
	brl	L66
L51	equ	11
L52	equ	5
	ends
	efunc
	code
	xdef	~~emulate_get
	func
~~emulate_get:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L94
	tcs
	phd
	tcd
ch_1	set	0
key_1	set	1
fn_keyno_1	set	3
errcode_1	set	5
	lda	|~~basicvars+423
	bit	#$200
	bne	L96
	brl	L10117
L96:
	pea	#<$1
	pea	#4
	jsl	~~error
L10117:
	lda	|~~fn_string
	ora	|~~fn_string+2
	bne	L97
	brl	L10118
L97:
	jsl	~~read_fn_string
L98:
	tay
	pld
	tsc
	clc
	adc	#L94
	tcs
	tya
	rtl
L10118:
	sec
	lda	#$0
	sbc	|~~holdcount
	bvs	L99
	eor	#$8000
L99:
	bpl	L100
	brl	L10119
L100:
	jsl	~~pop_key
	brl	L98
L10119:
	pea	#^$1
	pea	#<$1
	pea	#0
	clc
	tdc
	adc	#<L95+ch_1
	pha
	lda	|~~keyboard
	pha
	jsl	~~read
	sta	<L95+errcode_1
	lda	<L95+errcode_1
	bmi	L101
	brl	L10120
L101:
	jsl	~~__errno_location
	sta	<R0
	stx	<R0+2
	lda	[<R0]
	cmp	#<$20
	beq	L102
	brl	L10121
L102:
	pea	#<$8
	pea	#4
	jsl	~~error
L10121:
	pea	#^L50
	pea	#<L50
	pea	#<$2a6
	pea	#<$82
	pea	#10
	jsl	~~error
L10120:
	sep	#$20
	longa	off
	lda	#$0
	trb	<L95+ch_1
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	lda	<L95+ch_1
	cmp	#<$1b
	rep	#$20
	longa	on
	bne	L103
	brl	L10122
L103:
	lda	<L95+ch_1
	and	#$ff
	brl	L98
L10122:
	jsl	~~decode_sequence
	sta	<L95+key_1
	lda	<L95+key_1
	bne	L104
	brl	L10123
L104:
	lda	<L95+key_1
	brl	L98
L10123:
	jsl	~~pop_key
	sta	<L95+key_1
	pei	<L95+key_1
	jsl	~~is_fn_key
	sta	<L95+fn_keyno_1
	lda	<L95+fn_keyno_1
	beq	L105
	brl	L10124
L105:
	pei	<L95+key_1
	jsl	~~push_key
	lda	#$0
	brl	L98
L10124:
	lda	<L95+fn_keyno_1
	asl	A
	adc	<L95+fn_keyno_1
	asl	A
	sta	<R0
	clc
	lda	#$2
	adc	#<~~fn_key
	sta	<R1
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	lda	(<R2)
	ldy	#$2
	ora	(<R2),Y
	beq	L106
	brl	L10125
L106:
	pei	<L95+key_1
	jsl	~~push_key
	lda	#$0
	brl	L98
L10125:
	pei	<L95+fn_keyno_1
	jsl	~~switch_fn_string
	brl	L98
L94	equ	19
L95	equ	13
	ends
	efunc
	data
L50:
	db	$6B,$65,$79,$62,$6F,$61,$72,$64,$00
	ends
	code
	xdef	~~emulate_inkey
	func
~~emulate_inkey:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L108
	tcs
	phd
	tcd
arg_0	set	4
	lda	<L108+arg_0
	bpl	L110
	brl	L10126
L110:
	lda	|~~basicvars+423
	bit	#$200
	bne	L111
	brl	L10127
L111:
	pea	#<$1
	pea	#4
	jsl	~~error
L10127:
	sec
	lda	#$7fff
	sbc	<L108+arg_0
	bvs	L112
	eor	#$8000
L112:
	bpl	L113
	brl	L10128
L113:
	lda	#$7fff
	sta	<L108+arg_0
L10128:
	pei	<L108+arg_0
	jsl	~~waitkey
	and	#$ff
	bne	L114
	brl	L10129
L114:
	jsl	~~emulate_get
L115:
	tay
	lda	<L108+2
	sta	<L108+2+2
	lda	<L108+1
	sta	<L108+1+2
	pld
	tsc
	clc
	adc	#L108+2
	tcs
	tya
	rtl
L10129:
	lda	#$ffff
	brl	L115
L10126:
	lda	<L108+arg_0
	cmp	#<$ffffff00
	beq	L116
	brl	L10130
L116:
	lda	#$f6
	brl	L115
L10130:
	pea	#<$1
	pea	#4
	jsl	~~error
	lda	#$0
	brl	L115
L108	equ	0
L109	equ	1
	ends
	efunc
	code
	func
~~display:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L117
	tcs
	phd
	tcd
what_0	set	4
count_0	set	6
	jsl	~~echo_off
L10131:
	sec
	lda	#$0
	sbc	<L117+count_0
	bvs	L119
	eor	#$8000
L119:
	bpl	L120
	brl	L10132
L120:
	lda	<L117+what_0
	and	#$ff
	pha
	jsl	~~emulate_vdu
	dec	<L117+count_0
	brl	L10131
L10132:
	jsl	~~echo_on
L121:
	lda	<L117+2
	sta	<L117+2+4
	lda	<L117+1
	sta	<L117+1+4
	pld
	tsc
	clc
	adc	#L117+4
	tcs
	rtl
L117	equ	0
L118	equ	1
	ends
	efunc
	code
	func
~~remove_history:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L122
	tcs
	phd
	tcd
count_0	set	4
n_1	set	0
freed_1	set	2
	stz	<L123+freed_1
	stz	<L123+n_1
	brl	L10136
L10135:
	lda	<L123+n_1
	asl	A
	sta	<R0
	clc
	ldx	<R0
	lda	|~~histlength,X
	adc	<L123+freed_1
	sta	<L123+freed_1
L10133:
	inc	<L123+n_1
L10136:
	sec
	lda	<L123+n_1
	sbc	<L122+count_0
	bvs	L124
	eor	#$8000
L124:
	bmi	L125
	brl	L10135
L125:
L10134:
	sec
	lda	<L122+count_0
	sbc	|~~histindex
	bvs	L126
	eor	#$8000
L126:
	bpl	L127
	brl	L10137
L127:
	sec
	lda	|~~highbuffer
	sbc	<L123+freed_1
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L128
	dey
L128:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	clc
	lda	#<~~histbuffer
	adc	<L123+freed_1
	sta	<R2
	lda	<R2
	sta	<R1
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#<~~histbuffer
	sta	<R2
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R2+2
	pei	<R2+2
	pei	<R2
	jsl	~~memmove
	lda	<L122+count_0
	sta	<L123+n_1
	brl	L10141
L10140:
	sec
	lda	<L123+n_1
	sbc	<L122+count_0
	sta	<R1
	lda	<R1
	asl	A
	sta	<R0
	lda	<L123+n_1
	asl	A
	sta	<R1
	ldx	<R1
	lda	|~~histlength,X
	ldx	<R0
	sta	|~~histlength,X
L10138:
	inc	<L123+n_1
L10141:
	sec
	lda	<L123+n_1
	sbc	|~~histindex
	bvs	L129
	eor	#$8000
L129:
	bmi	L130
	brl	L10140
L130:
L10139:
L10137:
	sec
	lda	|~~highbuffer
	sbc	<L123+freed_1
	sta	|~~highbuffer
	sec
	lda	|~~histindex
	sbc	<L122+count_0
	sta	|~~histindex
L131:
	lda	<L122+2
	sta	<L122+2+2
	lda	<L122+1
	sta	<L122+1+2
	pld
	tsc
	clc
	adc	#L122+2
	tcs
	rtl
L122	equ	16
L123	equ	13
	ends
	efunc
	code
	func
~~add_history:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L132
	tcs
	phd
	tcd
command_0	set	4
cmdlen_0	set	8
wanted_1	set	0
n_1	set	2
freed_1	set	4
	clc
	lda	|~~highbuffer
	adc	<L132+cmdlen_0
	sta	<R0
	sec
	lda	<R0
	sbc	#<$400
	bvs	L134
	eor	#$8000
L134:
	bmi	L135
	brl	L10142
L135:
	clc
	lda	|~~highbuffer
	adc	<L132+cmdlen_0
	sta	<R0
	clc
	lda	#$fc01
	adc	<R0
	sta	<L133+wanted_1
	stz	<L133+freed_1
	stz	<L133+n_1
L10145:
	lda	<L133+n_1
	asl	A
	sta	<R0
	clc
	ldx	<R0
	lda	|~~histlength,X
	adc	<L133+freed_1
	sta	<L133+freed_1
	inc	<L133+n_1
L10143:
	sec
	lda	<L133+n_1
	sbc	|~~histindex
	bvs	L137
	eor	#$8000
L137:
	bpl	L138
	brl	L136
L138:
	sec
	lda	<L133+freed_1
	sbc	<L133+wanted_1
	bvs	L139
	eor	#$8000
L139:
	bmi	L140
	brl	L10145
L140:
L136:
L10144:
	pei	<L133+n_1
	jsl	~~remove_history
	brl	L10146
L10142:
	lda	|~~histindex
	cmp	#<$14
	beq	L141
	brl	L10147
L141:
	pea	#<$1
	jsl	~~remove_history
L10147:
L10146:
	lda	<L132+cmdlen_0
	ina
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L142
	dey
L142:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L132+command_0+2
	pei	<L132+command_0
	clc
	lda	#<~~histbuffer
	adc	|~~highbuffer
	sta	<R2
	lda	<R2
	sta	<R1
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	jsl	~~memmove
	lda	|~~histindex
	asl	A
	sta	<R0
	lda	<L132+cmdlen_0
	ina
	ldx	<R0
	sta	|~~histlength,X
	clc
	lda	|~~highbuffer
	adc	<L132+cmdlen_0
	sta	<R0
	lda	<R0
	ina
	sta	|~~highbuffer
	inc	|~~histindex
L143:
	lda	<L132+2
	sta	<L132+2+6
	lda	<L132+1
	sta	<L132+1+6
	pld
	tsc
	clc
	adc	#L132+6
	tcs
	rtl
L132	equ	18
L133	equ	13
	ends
	efunc
	code
	func
~~init_recall:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L144
	tcs
	phd
	tcd
	lda	|~~histindex
	sta	|~~recalline
L146:
	pld
	tsc
	clc
	adc	#L144
	tcs
	rtl
L144	equ	0
L145	equ	1
	ends
	efunc
	code
	func
~~recall_histline:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L147
	tcs
	phd
	tcd
buffer_0	set	4
updown_0	set	8
n_1	set	0
start_1	set	2
count_1	set	4
	lda	<L147+updown_0
	bmi	L149
	brl	L10148
L149:
	lda	|~~recalline
	beq	L150
	brl	L10149
L150:
L151:
	lda	<L147+2
	sta	<L147+2+6
	lda	<L147+1
	sta	<L147+1+6
	pld
	tsc
	clc
	adc	#L147+6
	tcs
	rtl
L10149:
	dec	|~~recalline
	brl	L10150
L10148:
	lda	|~~recalline
	cmp	|~~histindex
	beq	L152
	brl	L10151
L152:
	brl	L151
L10151:
	inc	|~~recalline
L10150:
	lda	|~~recalline
	cmp	|~~histindex
	beq	L153
	brl	L10152
L153:
	sep	#$20
	longa	off
	lda	#$0
	sta	[<L147+buffer_0]
	rep	#$20
	longa	on
	brl	L10153
L10152:
	stz	<L148+start_1
	stz	<L148+n_1
	brl	L10157
L10156:
	lda	<L148+n_1
	asl	A
	sta	<R0
	clc
	ldx	<R0
	lda	|~~histlength,X
	adc	<L148+start_1
	sta	<L148+start_1
L10154:
	inc	<L148+n_1
L10157:
	sec
	lda	<L148+n_1
	sbc	|~~recalline
	bvs	L154
	eor	#$8000
L154:
	bmi	L155
	brl	L10156
L155:
L10155:
	clc
	lda	#<~~histbuffer
	adc	<L148+start_1
	sta	<R1
	lda	<R1
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L147+buffer_0+2
	pei	<L147+buffer_0
	jsl	~~strcpy
L10153:
	lda	|~~place
	pha
	pea	#<$8
	jsl	~~display
	pei	<L147+buffer_0+2
	pei	<L147+buffer_0
	jsl	~~strlen
	sta	|~~place
	sec
	lda	#$0
	sbc	|~~place
	bvs	L156
	eor	#$8000
L156:
	bpl	L157
	brl	L10158
L157:
	lda	|~~place
	pha
	pei	<L147+buffer_0+2
	pei	<L147+buffer_0
	jsl	~~emulate_vdustr
L10158:
	sec
	lda	|~~highplace
	sbc	|~~place
	sta	<L148+count_1
	sec
	lda	#$0
	sbc	<L148+count_1
	bvs	L158
	eor	#$8000
L158:
	bpl	L159
	brl	L10159
L159:
	pei	<L148+count_1
	pea	#<$20
	jsl	~~display
	pei	<L148+count_1
	pea	#<$8
	jsl	~~display
L10159:
	lda	|~~place
	sta	|~~highplace
	brl	L151
L147	equ	14
L148	equ	9
	ends
	efunc
	code
	func
~~shift_down:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L160
	tcs
	phd
	tcd
buffer_0	set	4
offset_0	set	8
count_1	set	0
	sec
	lda	|~~highplace
	sbc	<L160+offset_0
	sta	<L161+count_1
	dec	|~~highplace
L10160:
	sec
	lda	<L160+offset_0
	sbc	|~~highplace
	bvs	L162
	eor	#$8000
L162:
	bpl	L163
	brl	L10161
L163:
	lda	<L160+offset_0
	ina
	sta	<R0
	sep	#$20
	longa	off
	ldy	<R0
	lda	[<L160+buffer_0],Y
	ldy	<L160+offset_0
	sta	[<L160+buffer_0],Y
	rep	#$20
	longa	on
	ldy	<L160+offset_0
	lda	[<L160+buffer_0],Y
	and	#$ff
	pha
	jsl	~~emulate_vdu
	inc	<L160+offset_0
	brl	L10160
L10161:
	pea	#<$7f
	jsl	~~emulate_vdu
	pei	<L161+count_1
	pea	#<$8
	jsl	~~display
L164:
	lda	<L160+2
	sta	<L160+2+6
	lda	<L160+1
	sta	<L160+1+6
	pld
	tsc
	clc
	adc	#L160+6
	tcs
	rtl
L160	equ	6
L161	equ	5
	ends
	efunc
	code
	func
~~shift_up:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L165
	tcs
	phd
	tcd
buffer_0	set	4
offset_0	set	8
n_1	set	0
	lda	<L165+offset_0
	cmp	|~~highplace
	beq	L167
	brl	L10162
L167:
L168:
	lda	<L165+2
	sta	<L165+2+6
	lda	<L165+1
	sta	<L165+1+6
	pld
	tsc
	clc
	adc	#L165+6
	tcs
	rtl
L10162:
	lda	|~~highplace
	sta	<L166+n_1
L10163:
	lda	<L165+offset_0
	ina
	sta	<R0
	sec
	lda	<L166+n_1
	sbc	<R0
	bvs	L169
	eor	#$8000
L169:
	bmi	L170
	brl	L10164
L170:
	clc
	lda	#$ffff
	adc	<L166+n_1
	sta	<R0
	sep	#$20
	longa	off
	ldy	<R0
	lda	[<L165+buffer_0],Y
	ldy	<L166+n_1
	sta	[<L165+buffer_0],Y
	rep	#$20
	longa	on
	dec	<L166+n_1
	brl	L10163
L10164:
	jsl	~~echo_off
	pea	#<$7f
	jsl	~~emulate_vdu
	lda	<L165+offset_0
	ina
	sta	<L166+n_1
L10165:
	sec
	lda	|~~highplace
	sbc	<L166+n_1
	bvs	L171
	eor	#$8000
L171:
	bmi	L172
	brl	L10166
L172:
	ldy	<L166+n_1
	lda	[<L165+buffer_0],Y
	and	#$ff
	pha
	jsl	~~emulate_vdu
	inc	<L166+n_1
	brl	L10165
L10166:
	jsl	~~echo_on
L10167:
	sec
	lda	<L165+offset_0
	sbc	<L166+n_1
	bvs	L173
	eor	#$8000
L173:
	bpl	L174
	brl	L10168
L174:
	pea	#<$8
	jsl	~~emulate_vdu
	dec	<L166+n_1
	brl	L10167
L10168:
	inc	|~~highplace
	brl	L168
L165	equ	6
L166	equ	5
	ends
	efunc
	code
	xdef	~~emulate_readline
	func
~~emulate_readline:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L175
	tcs
	phd
	tcd
buffer_0	set	4
length_0	set	8
ch_1	set	0
lastplace_1	set	2
	lda	|~~basicvars+423
	bit	#$200
	bne	L177
	brl	L10169
L177:
p_2	set	4
	lda	|~~stdin+2
	pha
	lda	|~~stdin
	pha
	pei	<L175+length_0
	pei	<L175+buffer_0+2
	pei	<L175+buffer_0
	jsl	~~fgets
	sta	<L176+p_2
	stx	<L176+p_2+2
	lda	<L176+p_2
	ora	<L176+p_2+2
	beq	L178
	brl	L10170
L178:
	lda	|~~stdin+2
	pha
	lda	|~~stdin
	pha
	jsl	~~ferror
	tax
	bne	L179
	brl	L10171
L179:
	pea	#<$75
	pea	#4
	jsl	~~error
L10171:
	sep	#$20
	longa	off
	lda	#$0
	sta	[<L175+buffer_0]
	rep	#$20
	longa	on
	lda	#$2
L180:
	tay
	lda	<L175+2
	sta	<L175+2+6
	lda	<L175+1
	sta	<L175+1+6
	pld
	tsc
	clc
	adc	#L175+6
	tcs
	tya
	rtl
L10170:
	lda	#$0
	brl	L180
L10169:
	pei	<L175+buffer_0+2
	pei	<L175+buffer_0
	jsl	~~strlen
	sta	|~~highplace
	sec
	lda	#$0
	sbc	|~~highplace
	bvs	L181
	eor	#$8000
L181:
	bpl	L182
	brl	L10172
L182:
	lda	|~~highplace
	pha
	pei	<L175+buffer_0+2
	pei	<L175+buffer_0
	jsl	~~emulate_vdustr
L10172:
	lda	|~~highplace
	sta	|~~place
	clc
	lda	#$fffe
	adc	<L175+length_0
	sta	<L176+lastplace_1
	jsl	~~init_recall
L10175:
	jsl	~~emulate_get
	sta	<L176+ch_1
	lda	|~~basicvars+489
	and	#$ff
	bne	L183
	brl	L10176
L183:
	lda	#$1
	brl	L180
L10176:
	lda	<L176+ch_1
	brl	L10177
L10179:
L10180:
	pea	#<$d
	jsl	~~emulate_vdu
	pea	#<$a
	jsl	~~emulate_vdu
	sep	#$20
	longa	off
	lda	#$0
	ldy	|~~highplace
	sta	[<L175+buffer_0],Y
	rep	#$20
	longa	on
	sec
	lda	#$0
	sbc	|~~highplace
	bvs	L184
	eor	#$8000
L184:
	bpl	L185
	brl	L10181
L185:
	lda	|~~highplace
	pha
	pei	<L175+buffer_0+2
	pei	<L175+buffer_0
	jsl	~~add_history
L10181:
	brl	L10178
L10182:
L10183:
	sec
	lda	#$0
	sbc	|~~place
	bvs	L186
	eor	#$8000
L186:
	bpl	L187
	brl	L10184
L187:
	pea	#<$8
	jsl	~~emulate_vdu
	dec	|~~place
	lda	|~~place
	pha
	pei	<L175+buffer_0+2
	pei	<L175+buffer_0
	jsl	~~shift_down
L10184:
	brl	L10178
L10185:
	sec
	lda	|~~place
	sbc	|~~highplace
	bvs	L188
	eor	#$8000
L188:
	bpl	L189
	brl	L10186
L189:
	lda	|~~place
	pha
	pei	<L175+buffer_0+2
	pei	<L175+buffer_0
	jsl	~~shift_down
L10186:
	brl	L10178
L10187:
	sec
	lda	|~~highplace
	sbc	|~~place
	pha
	pea	#<$7f
	jsl	~~display
	sec
	lda	|~~highplace
	sbc	|~~place
	pha
	pea	#<$8
	jsl	~~display
	lda	|~~place
	sta	|~~highplace
	brl	L10178
L10188:
	lda	|~~place
	pha
	pea	#<$8
	jsl	~~display
	lda	|~~highplace
	pha
	pea	#<$7f
	jsl	~~display
	lda	|~~highplace
	pha
	pea	#<$8
	jsl	~~display
	stz	|~~place
	stz	|~~highplace
	brl	L10178
L10189:
	sec
	lda	#$0
	sbc	|~~place
	bvs	L190
	eor	#$8000
L190:
	bpl	L191
	brl	L10190
L191:
	pea	#<$8
	jsl	~~emulate_vdu
	dec	|~~place
L10190:
	brl	L10178
L10191:
	sec
	lda	|~~place
	sbc	|~~highplace
	bvs	L192
	eor	#$8000
L192:
	bpl	L193
	brl	L10192
L193:
	ldy	|~~place
	lda	[<L175+buffer_0],Y
	and	#$ff
	pha
	jsl	~~emulate_vdu
	inc	|~~place
L10192:
	brl	L10178
L10193:
	pea	#<$ffffffff
	pei	<L175+buffer_0+2
	pei	<L175+buffer_0
	jsl	~~recall_histline
	brl	L10178
L10194:
	pea	#<$1
	pei	<L175+buffer_0+2
	pei	<L175+buffer_0
	jsl	~~recall_histline
	brl	L10178
L10195:
	lda	|~~place
	pha
	pea	#<$8
	jsl	~~display
	stz	|~~place
	brl	L10178
L10196:
	jsl	~~echo_off
L10197:
	sec
	lda	|~~place
	sbc	|~~highplace
	bvs	L194
	eor	#$8000
L194:
	bpl	L195
	brl	L10198
L195:
	ldy	|~~place
	lda	[<L175+buffer_0],Y
	and	#$ff
	pha
	jsl	~~emulate_vdu
	inc	|~~place
	brl	L10197
L10198:
	jsl	~~echo_on
	brl	L10178
L10199:
	lda	|~~place
	pha
	pea	#<$8
	jsl	~~display
	stz	|~~place
	brl	L10178
L10200:
	jsl	~~emulate_get
	sta	<L176+ch_1
	lda	<L176+ch_1
	brl	L10201
L10203:
	jsl	~~echo_off
L10204:
	sec
	lda	|~~place
	sbc	|~~highplace
	bvs	L196
	eor	#$8000
L196:
	bpl	L197
	brl	L10205
L197:
	ldy	|~~place
	lda	[<L175+buffer_0],Y
	and	#$ff
	pha
	jsl	~~emulate_vdu
	inc	|~~place
	brl	L10204
L10205:
	jsl	~~echo_on
	brl	L10202
L10206:
	pea	#<$ffffffff
	pei	<L175+buffer_0+2
	pei	<L175+buffer_0
	jsl	~~recall_histline
	brl	L10202
L10207:
	pea	#<$1
	pei	<L175+buffer_0+2
	pei	<L175+buffer_0
	jsl	~~recall_histline
	brl	L10202
L10208:
	sec
	lda	#$0
	sbc	|~~place
	bvs	L198
	eor	#$8000
L198:
	bpl	L199
	brl	L10209
L199:
	pea	#<$8
	jsl	~~emulate_vdu
	dec	|~~place
L10209:
	brl	L10202
L10210:
	sec
	lda	|~~place
	sbc	|~~highplace
	bvs	L200
	eor	#$8000
L200:
	bpl	L201
	brl	L10211
L201:
	ldy	|~~place
	lda	[<L175+buffer_0],Y
	and	#$ff
	pha
	jsl	~~emulate_vdu
	inc	|~~place
L10211:
	brl	L10202
L10212:
	sec
	lda	|~~place
	sbc	|~~highplace
	bvs	L202
	eor	#$8000
L202:
	bpl	L203
	brl	L10213
L203:
	lda	|~~place
	pha
	pei	<L175+buffer_0+2
	pei	<L175+buffer_0
	jsl	~~shift_down
L10213:
	brl	L10202
L10214:
	stz	<R0
	lda	|~~enable_insert
	and	#$ff
	beq	L205
	brl	L204
L205:
	inc	<R0
L204:
	sep	#$20
	longa	off
	lda	<R0
	sta	|~~enable_insert
	rep	#$20
	longa	on
	lda	|~~enable_insert
	pha
	jsl	~~set_cursor
	brl	L10202
L10215:
	pea	#<$7
	jsl	~~emulate_vdu
	brl	L10202
L10201:
	xref	~~~swt
	jsl	~~~swt
	dw	7
	dw	127
	dw	L10212-1
	dw	139
	dw	L10203-1
	dw	140
	dw	L10208-1
	dw	141
	dw	L10210-1
	dw	142
	dw	L10207-1
	dw	143
	dw	L10206-1
	dw	205
	dw	L10214-1
	dw	L10215-1
L10202:
	brl	L10178
L10216:
	sec
	lda	<L176+ch_1
	sbc	#<$20
	bvs	L206
	eor	#$8000
L206:
	bpl	L207
	brl	L10217
L207:
	lda	<L176+ch_1
	cmp	#<$9
	bne	L208
	brl	L10217
L208:
	pea	#<$7
	jsl	~~emulate_vdu
	brl	L10218
L10217:
	lda	|~~highplace
	cmp	<L176+lastplace_1
	beq	L209
	brl	L10219
L209:
	pea	#<$7
	jsl	~~emulate_vdu
	brl	L10220
L10219:
	lda	|~~enable_insert
	and	#$ff
	bne	L210
	brl	L10221
L210:
	lda	|~~place
	pha
	pei	<L175+buffer_0+2
	pei	<L175+buffer_0
	jsl	~~shift_up
L10221:
	sep	#$20
	longa	off
	lda	<L176+ch_1
	ldy	|~~place
	sta	[<L175+buffer_0],Y
	rep	#$20
	longa	on
	pei	<L176+ch_1
	jsl	~~emulate_vdu
	inc	|~~place
	sec
	lda	|~~highplace
	sbc	|~~place
	bvs	L211
	eor	#$8000
L211:
	bpl	L212
	brl	L10222
L212:
	lda	|~~place
	sta	|~~highplace
L10222:
L10220:
L10218:
	brl	L10178
L10177:
	xref	~~~swt
	jsl	~~~swt
	dw	15
	dw	0
	dw	L10200-1
	dw	1
	dw	L10195-1
	dw	2
	dw	L10189-1
	dw	4
	dw	L10185-1
	dw	5
	dw	L10196-1
	dw	6
	dw	L10191-1
	dw	8
	dw	L10182-1
	dw	10
	dw	L10180-1
	dw	11
	dw	L10187-1
	dw	13
	dw	L10179-1
	dw	14
	dw	L10194-1
	dw	16
	dw	L10193-1
	dw	21
	dw	L10188-1
	dw	30
	dw	L10199-1
	dw	127
	dw	L10183-1
	dw	L10216-1
L10178:
L10173:
	lda	<L176+ch_1
	cmp	#<$d
	bne	L214
	brl	L213
L214:
	lda	<L176+ch_1
	cmp	#<$a
	beq	L215
	brl	L10175
L215:
L213:
L10174:
	lda	#$0
	brl	L180
L175	equ	12
L176	equ	5
	ends
	efunc
	code
	xdef	~~init_keyboard
	func
~~init_keyboard:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L216
	tcs
	phd
	tcd
tty_1	set	0
n_1	set	28
errcode_1	set	30
	stz	<L217+n_1
L10225:
	lda	<L217+n_1
	asl	A
	adc	<L217+n_1
	asl	A
	sta	<R0
	clc
	lda	#$2
	adc	#<~~fn_key
	sta	<R1
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	lda	#$0
	sta	(<R2)
	lda	#$0
	ldy	#$2
	sta	(<R2),Y
L10223:
	inc	<L217+n_1
	sec
	lda	<L217+n_1
	sbc	#<$f
	bvs	L218
	eor	#$8000
L218:
	bmi	L219
	brl	L10225
L219:
L10224:
	stz	|~~fn_string_count
	stz	|~~fn_string
	stz	|~~fn_string+2
	stz	|~~holdcount
	stz	|~~histindex
	stz	|~~highbuffer
	sep	#$20
	longa	off
	lda	#$1
	sta	|~~enable_insert
	rep	#$20
	longa	on
	lda	|~~enable_insert
	pha
	jsl	~~set_cursor
	lda	|~~stdin+2
	pha
	lda	|~~stdin
	pha
	jsl	~~fileno
	sta	|~~keyboard
	pea	#0
	clc
	tdc
	adc	#<L217+tty_1
	pha
	lda	|~~keyboard
	pha
	jsl	~~tcgetattr
	sta	<L217+errcode_1
	lda	<L217+errcode_1
	bmi	L220
	brl	L10226
L220:
	jsl	~~__errno_location
	sta	<R0
	stx	<R0+2
	lda	[<R0]
	cmp	#<$9
	bne	L221
	brl	L10227
L221:
	lda	#$0
L222:
	tay
	pld
	tsc
	clc
	adc	#L216
	tcs
	tya
	rtl
L10227:
	lda	#$200
	tsb	~~basicvars+423
	lda	#$1
	brl	L222
L10226:
	clc
	tdc
	adc	#<L217+tty_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	pea	#<~~origtty
	lda	#$1c
	xref	~~~fnmov
	jsl	~~~fnmov
	lda	#$c0
	trb	<L217+tty_1+6
	lda	#$a
	trb	<L217+tty_1+6
	lda	#$140
	trb	<L217+tty_1
	lda	#$80
	tsb	<L217+tty_1+4
	sep	#$20
	longa	off
	lda	#$1
	sta	<L217+tty_1+14
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	lda	#$1
	sta	<L217+tty_1+15
	rep	#$20
	longa	on
	pea	#0
	clc
	tdc
	adc	#<L217+tty_1
	pha
	pea	#<$1
	lda	|~~keyboard
	pha
	jsl	~~tcsetattr
	sta	<L217+errcode_1
	lda	<L217+errcode_1
	bmi	L223
	brl	L10228
L223:
	lda	#$0
	brl	L222
L10228:
	lda	#$1
	brl	L222
L216	equ	44
L217	equ	13
	ends
	efunc
	code
	xdef	~~end_keyboard
	func
~~end_keyboard:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L224
	tcs
	phd
	tcd
	lda	#<~~origtty
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	pea	#<$1
	lda	|~~keyboard
	pha
	jsl	~~tcsetattr
L226:
	pld
	tsc
	clc
	adc	#L224
	tcs
	rtl
L224	equ	8
L225	equ	9
	ends
	efunc
	xref	~~tcsetattr
	xref	~~tcgetattr
	xref	~~read
	xref	~~__errno_location
	xref	~~free
	xref	~~malloc
	xref	~~emulate_vdustr
	xref	~~emulate_vdu
	xref	~~set_cursor
	xref	~~echo_off
	xref	~~echo_on
	xref	~~error
	xref	~~strlen
	xref	~~memcpy
	xref	~~memset
	xref	~~memmove
	xref	~~strcpy
	xref	~~fileno
	xref	~~ferror
	xref	~~fgets
	udata
~~keyboard
	ds	2
	ends
	udata
~~origtty
	ds	28
	ends
	udata
~~fn_string_count
	ds	2
	ends
	udata
~~fn_string
	ds	4
	ends
	udata
~~holdstack
	ds	16
	ends
	udata
~~holdcount
	ds	2
	ends
	udata
~~fn_key
	ds	90
	ends
	udata
~~histlength
	ds	40
	ends
	udata
~~histbuffer
	ds	1024
	ends
	udata
~~enable_insert
	ds	1
	ends
	udata
~~recalline
	ds	2
	ends
	udata
~~highbuffer
	ds	2
	ends
	udata
~~histindex
	ds	2
	ends
	udata
~~highplace
	ds	2
	ends
	udata
~~place
	ds	2
	ends
	xref	~~basicvars
	xref	~~stdin
	end
