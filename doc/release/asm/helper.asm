;:ts=8
	module	input
	code
	xdef	~~input
	func
~~input:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
s_0	set	4
maxlen_0	set	8
c_1	set	0
cnt_1	set	2
	stz	<L3+cnt_1
	dec	<L2+maxlen_0
L10001:
	lda	|~~stdin+2
	pha
	lda	|~~stdin
	pha
	jsl	~~fgetc
	sta	<L3+c_1
	sec
	lda	<L3+c_1
	sbc	#<$20
	bvs	L4
	eor	#$8000
L4:
	bmi	L5
	brl	L10003
L5:
	sec
	lda	<L3+c_1
	sbc	#<$7f
	bvs	L6
	eor	#$8000
L6:
	bpl	L7
	brl	L10003
L7:
	sec
	lda	<L3+cnt_1
	sbc	<L2+maxlen_0
	bvs	L8
	eor	#$8000
L8:
	bpl	L9
	brl	L10004
L9:
	lda	|~~stdout+2
	pha
	lda	|~~stdout
	pha
	pei	<L3+c_1
	jsl	~~fputc
	lda	|~~stdout+2
	pha
	lda	|~~stdout
	pha
	jsl	~~fflush
	sep	#$20
	longa	off
	lda	<L3+c_1
	ldy	<L3+cnt_1
	sta	[<L2+s_0],Y
	rep	#$20
	longa	on
	inc	<L3+cnt_1
L10004:
L10003:
	lda	<L3+c_1
	cmp	#<$8
	beq	L10
	brl	L10005
L10:
	sec
	lda	#$0
	sbc	<L3+cnt_1
	bvs	L11
	eor	#$8000
L11:
	bpl	L12
	brl	L10006
L12:
	lda	|~~stdout+2
	pha
	lda	|~~stdout
	pha
	pei	<L3+c_1
	jsl	~~fputc
	lda	|~~stdout+2
	pha
	lda	|~~stdout
	pha
	jsl	~~fflush
	dec	<L3+cnt_1
L10006:
L10005:
	lda	<L3+c_1
	cmp	#<$a
	beq	L13
	brl	L10007
L13:
	sep	#$20
	longa	off
	lda	#$0
	ldy	<L3+cnt_1
	sta	[<L2+s_0],Y
	rep	#$20
	longa	on
	pei	<L2+s_0+2
	pei	<L2+s_0
	jsl	~~strlen
	sta	<1
	stx	<1+2
	lda	<1
L14:
	tay
	lda	<L2+2
	sta	<L2+2+6
	lda	<L2+1
	sta	<L2+1+6
	pld
	tsc
	clc
	adc	#L2+6
	tcs
	tya
	rtl
L10007:
	brl	L10001
L2	equ	8
L3	equ	5
	xref	~~strlen
	xref	~~fflush
	xref	~~fputc
	xref	~~fgetc
	xref	~~stdout
	xref	~~stdin
	ends
	efunc
	endmod
	module	int2hex
	code
	xdef	~~int2hex
	func
~~int2hex:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L15
	tcs
	phd
	tcd
c_0	set	4
	sec
	lda	<L15+c_0
	sbc	#<$a
	bvs	L17
	eor	#$8000
L17:
	bpl	L18
	brl	L10008
L18:
	clc
	lda	#$30
	adc	<L15+c_0
	sta	<1
	lda	<1
	and	#$ff
L19:
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
L10008:
	clc
	lda	#$37
	adc	<L15+c_0
	sta	<1
	lda	<1
	and	#$ff
	brl	L19
L15	equ	4
L16	equ	5
	ends
	efunc
	endmod
	module	printhex
	code
	xdef	~~printhex
	func
~~printhex:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L20
	tcs
	phd
	tcd
c_0	set	4
	lda	<L20+c_0
	and	#$ff
	ldx	#<$4
	xref	~~~asr
	jsl	~~~asr
	pha
	jsl	~~int2hex
	pha
	jsl	~~printchar
	lda	<L20+c_0
	and	#<$f
	pha
	jsl	~~int2hex
	pha
	jsl	~~printchar
L22:
	lda	<L20+2
	sta	<L20+2+2
	lda	<L20+1
	sta	<L20+1+2
	pld
	tsc
	clc
	adc	#L20+2
	tcs
	rtl
L20	equ	0
L21	equ	1
	xref	~~int2hex
	xref	~~printchar
	ends
	efunc
	endmod
	module	printchar
	code
	xdef	~~printchar
	func
~~printchar:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L23
	tcs
	phd
	tcd
c_0	set	4
L10009:
	sep	#$20
	longa	off
	lda	>16777189
	and	#<$40
	rep	#$20
	longa	on
	beq	L25
	brl	L10010
L25:
	brl	L10009
L10010:
	sep	#$20
	longa	off
	lda	<L23+c_0
	sta	>16777184
	rep	#$20
	longa	on
L26:
	lda	<L23+2
	sta	<L23+2+2
	lda	<L23+1
	sta	<L23+1+2
	pld
	tsc
	clc
	adc	#L23+2
	tcs
	rtl
L23	equ	0
L24	equ	1
	ends
	efunc
	endmod
	module	strupper
	code
	xdef	~~strupper
	func
~~strupper:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L27
	tcs
	phd
	tcd
str_0	set	4
L10011:
	lda	[<L27+str_0]
	and	#$ff
	bne	L29
	brl	L10012
L29:
	lda	[<L27+str_0]
	and	#$ff
	pha
	jsl	~~toupper
	sep	#$20
	longa	off
	sta	[<L27+str_0]
	rep	#$20
	longa	on
	inc	<L27+str_0
	bne	L30
	inc	<L27+str_0+2
L30:
	brl	L10011
L10012:
L31:
	lda	<L27+2
	sta	<L27+2+4
	lda	<L27+1
	sta	<L27+1+4
	pld
	tsc
	clc
	adc	#L27+4
	tcs
	rtl
L27	equ	0
L28	equ	1
	xref	~~toupper
	ends
	efunc
	endmod
	module	adjustFilename
	code
	xdef	~~adjustFilename
	func
~~adjustFilename:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L32
	tcs
	phd
	tcd
s_0	set	4
exe_0	set	8
p_1	set	0
out_1	set	4
len_1	set	8
	pei	<L32+s_0+2
	pei	<L32+s_0
	jsl	~~strlen
	sta	<L33+len_1
	clc
	lda	#$a
	adc	<L33+len_1
	sta	<1
	lda	<1
	sta	<1
	stz	<1+2
	pei	<1+2
	pei	<1
	jsl	~~malloc
	sta	<L33+out_1
	stx	<L33+out_1+2
	pei	<L32+s_0+2
	pei	<L32+s_0
	pei	<L33+out_1+2
	pei	<L33+out_1
	jsl	~~strcpy
	pei	<L33+out_1+2
	pei	<L33+out_1
	jsl	~~strupper
	sep	#$20
	longa	off
	lda	[<L33+out_1]
	cmp	#<$44
	rep	#$20
	longa	on
	beq	L35
	brl	L34
L35:
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L33+out_1],Y
	cmp	#<$3a
	rep	#$20
	longa	on
	bne	L36
	brl	L10013
L36:
L34:
	pei	<L33+out_1+2
	pei	<L33+out_1
	jsl	~~strlen
	sta	<1
	stx	<1+2
	clc
	lda	#$1
	adc	<1
	sta	<5
	lda	#$0
	adc	<1+2
	sta	<5+2
	pei	<5+2
	pei	<5
	pei	<L33+out_1+2
	pei	<L33+out_1
	clc
	lda	#$2
	adc	<L33+out_1
	sta	<1
	lda	#$0
	adc	<L33+out_1+2
	sta	<1+2
	pei	<1+2
	pei	<1
	jsl	~~memmove
	sep	#$20
	longa	off
	lda	#$44
	sta	[<L33+out_1]
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	lda	#$3a
	ldy	#$1
	sta	[<L33+out_1],Y
	rep	#$20
	longa	on
L10013:
	ldx	<L33+out_1+2
	lda	<L33+out_1
L37:
	tay
	lda	<L32+2
	sta	<L32+2+6
	lda	<L32+1
	sta	<L32+1+6
	pld
	tsc
	clc
	adc	#L32+6
	tcs
	tya
	rtl
L32	equ	18
L33	equ	9
	xref	~~strupper
	xref	~~strlen
	xref	~~memmove
	xref	~~strcpy
	xref	~~malloc
	ends
	efunc
	endmod
	module	hex2int
	code
	xdef	~~hex2int
	func
~~hex2int:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L38
	tcs
	phd
	tcd
c_0	set	4
val_1	set	0
	lda	#$ffff
	sta	<L39+val_1
	lda	<L38+c_0
	and	#$ff
	pha
	jsl	~~toupper
	sep	#$20
	longa	off
	sta	<L38+c_0
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	lda	<L38+c_0
	cmp	#<$30
	rep	#$20
	longa	on
	bcs	L40
	brl	L10014
L40:
	sep	#$20
	longa	off
	lda	#$39
	cmp	<L38+c_0
	rep	#$20
	longa	on
	bcs	L41
	brl	L10014
L41:
	lda	<L38+c_0
	and	#$ff
	sta	<1
	clc
	lda	#$ffd0
	adc	<1
	sta	<L39+val_1
L10014:
	sep	#$20
	longa	off
	lda	<L38+c_0
	cmp	#<$41
	rep	#$20
	longa	on
	bcs	L42
	brl	L10015
L42:
	sep	#$20
	longa	off
	lda	#$46
	cmp	<L38+c_0
	rep	#$20
	longa	on
	bcs	L43
	brl	L10015
L43:
	lda	<L38+c_0
	and	#$ff
	sta	<1
	clc
	lda	#$ffc9
	adc	<1
	sta	<L39+val_1
L10015:
	lda	<L39+val_1
L44:
	tay
	lda	<L38+2
	sta	<L38+2+2
	lda	<L38+1
	sta	<L38+1+2
	pld
	tsc
	clc
	adc	#L38+2
	tcs
	tya
	rtl
L38	equ	6
L39	equ	5
	xref	~~toupper
	ends
	efunc
	endmod
	module	getHex8
	code
	xdef	~~getHex8
	func
~~getHex8:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L45
	tcs
	phd
	tcd
val_1	set	0
c_1	set	4
cnt_1	set	6
i_1	set	8
	stz	<L46+val_1
	stz	<L46+val_1+2
	stz	<L46+cnt_1
L10018:
	lda	|~~stdin+2
	pha
	lda	|~~stdin
	pha
	jsl	~~fgetc
	sta	<L46+c_1
	pei	<L46+c_1
	jsl	~~hex2int
	sta	<L46+i_1
	lda	<L46+i_1
	bpl	L47
	brl	L10019
L47:
	pei	<L46+c_1
	pea	#^L1
	pea	#<L1
	pea	#8
	jsl	~~printf
	asl	<L46+val_1
	rol	<L46+val_1+2
	asl	<L46+val_1
	rol	<L46+val_1+2
	asl	<L46+val_1
	rol	<L46+val_1+2
	asl	<L46+val_1
	rol	<L46+val_1+2
	ldy	#$0
	lda	<L46+i_1
	bpl	L48
	dey
L48:
	sta	<1
	sty	<1+2
	clc
	lda	<1
	adc	<L46+val_1
	sta	<L46+val_1
	lda	<1+2
	adc	<L46+val_1+2
	sta	<L46+val_1+2
	inc	<L46+cnt_1
	brl	L10016
L10019:
	lda	<L46+c_1
	cmp	#<$8
	beq	L49
	brl	L10020
L49:
	sec
	lda	#$0
	sbc	<L46+cnt_1
	bvs	L50
	eor	#$8000
L50:
	bpl	L51
	brl	L10021
L51:
	pei	<L46+c_1
	pea	#^L1+3
	pea	#<L1+3
	pea	#8
	jsl	~~printf
	lsr	<L46+val_1+2
	ror	<L46+val_1
	lsr	<L46+val_1+2
	ror	<L46+val_1
	lsr	<L46+val_1+2
	ror	<L46+val_1
	lsr	<L46+val_1+2
	ror	<L46+val_1
	dec	<L46+cnt_1
L10021:
L10020:
	lda	<L46+c_1
	cmp	#<$a
	bne	L52
	brl	L10017
L52:
L10016:
	sec
	lda	<L46+cnt_1
	sbc	#<$8
	bvs	L53
	eor	#$8000
L53:
	bmi	L54
	brl	L10018
L54:
L10017:
	ldx	<L46+val_1+2
	lda	<L46+val_1
L55:
	tay
	pld
	tsc
	clc
	adc	#L45
	tcs
	tya
	rtl
L45	equ	14
L46	equ	5
	xref	~~hex2int
	xref	~~fgetc
	xref	~~printf
	xref	~~stdin
	ends
	efunc
	data
L1:
	db	$25,$63,$00,$25,$63,$00
	ends
	endmod
	module	str2hex
	code
	xdef	~~str2hex
	func
~~str2hex:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L57
	tcs
	phd
	tcd
s_0	set	4
val_1	set	0
i_1	set	4
	stz	<L58+val_1
	stz	<L58+val_1+2
L10022:
	lda	[<L57+s_0]
	and	#$ff
	bne	L59
	brl	L10023
L59:
	lda	[<L57+s_0]
	pha
	jsl	~~hex2int
	sta	<L58+i_1
	lda	<L58+i_1
	bpl	L60
	brl	L10024
L60:
	asl	<L58+val_1
	rol	<L58+val_1+2
	asl	<L58+val_1
	rol	<L58+val_1+2
	asl	<L58+val_1
	rol	<L58+val_1+2
	asl	<L58+val_1
	rol	<L58+val_1+2
	ldy	#$0
	lda	<L58+i_1
	bpl	L61
	dey
L61:
	sta	<1
	sty	<1+2
	clc
	lda	<1
	adc	<L58+val_1
	sta	<L58+val_1
	lda	<1+2
	adc	<L58+val_1+2
	sta	<L58+val_1+2
L10024:
	inc	<L57+s_0
	bne	L62
	inc	<L57+s_0+2
L62:
	brl	L10022
L10023:
	ldx	<L58+val_1+2
	lda	<L58+val_1
L63:
	tay
	lda	<L57+2
	sta	<L57+2+4
	lda	<L57+1
	sta	<L57+1+4
	pld
	tsc
	clc
	adc	#L57+4
	tcs
	tya
	rtl
L57	equ	10
L58	equ	5
	xref	~~hex2int
	ends
	efunc
	endmod
	module	task
	code
	xdef	~~task
	func
~~task:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L64
	tcs
	phd
	tcd
tc_0	set	4
	pei	<L64+tc_0+2
	pei	<L64+tc_0
	pea	#^$0
	pea	#<$0
	jsl	~~vTaskSetApplicationTaskTag
	jsl	~~getStdin
	sta	|~~stdin
	stx	|~~stdin+2
	jsl	~~getStdout
	sta	|~~stdout
	stx	|~~stdout+2
	jsl	~~getStderr
	sta	|~~stderr
	stx	|~~stderr+2
	ldy	#$8
	lda	[<L64+tc_0],Y
	pha
	ldy	#$6
	lda	[<L64+tc_0],Y
	pha
	ldy	#$4
	lda	[<L64+tc_0],Y
	pha
	jsl	~~main
	ldy	#$1e
	sta	[<L64+tc_0],Y
	ldy	#$2c
	lda	[<L64+tc_0],Y
	beq	L66
	brl	L10025
L66:
	pea	#^$0
	pea	#<$0
	pea	#<$2
	pea	#^$0
	pea	#<$0
	ldy	#$c
	lda	[<L64+tc_0],Y
	pha
	ldy	#$a
	lda	[<L64+tc_0],Y
	pha
	jsl	~~xTaskGenericNotify
	brl	L10026
L10025:
	pei	<L64+tc_0+2
	pei	<L64+tc_0
	jsl	~~vTaskRemove
L10026:
	pea	#^$0
	pea	#<$0
	jsl	~~vTaskSuspend
L67:
	lda	<L64+2
	sta	<L64+2+4
	lda	<L64+1
	sta	<L64+1+4
	pld
	tsc
	clc
	adc	#L64+4
	tcs
	rtl
L64	equ	0
L65	equ	1
	xref	~~main
	xref	~~getStderr
	xref	~~getStdout
	xref	~~getStdin
	xref	~~vTaskRemove
	xref	~~xTaskGenericNotify
	xref	~~vTaskSetApplicationTaskTag
	xref	~~vTaskSuspend
	xref	~~stderr
	xref	~~stdout
	xref	~~stdin
	ends
	efunc
	endmod
	module	stderr
	udata
	xdef	~~stderr
~~stderr
	ds	4
	ends
	endmod
	module	stdout
	udata
	xdef	~~stdout
~~stdout
	ds	4
	ends
	endmod
	module	stdin
	udata
	xdef	~~stdin
~~stdin
	ds	4
	ends
	endmod
	end
