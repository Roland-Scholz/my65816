;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
	data
~~startmark:
	db	$C5,$C7,$C1,$D7
	ends
	data
~~endline:
	db	$0,$0,$8,$0,$6,$0,$A3,$0
	ends
	code
	xdef	~~mark_end
	func
~~mark_end:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
p_0	set	4
	pea	#^$8
	pea	#<$8
	lda	#<~~endline
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L2+p_0+2
	pei	<L2+p_0
	jsl	~~memcpy
	pea	#<$ff00
	pei	<L2+p_0+2
	pei	<L2+p_0
	jsl	~~save_lineno
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
L2	equ	4
L3	equ	5
	ends
	efunc
	code
	func
~~preserve:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L5
	tcs
	phd
	tcd
n_1	set	0
	stz	<L6+n_1
L10003:
	lda	|~~basicvars+22
	sta	<R0
	lda	|~~basicvars+22+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	<L6+n_1
	lda	[<R0],Y
	ldx	<L6+n_1
	sta	|~~basicvars+439,X
	rep	#$20
	longa	on
L10001:
	inc	<L6+n_1
	sec
	lda	<L6+n_1
	sbc	#<$8
	bvs	L7
	eor	#$8000
L7:
	bmi	L8
	brl	L10003
L8:
L10002:
	lda	#$4
	tsb	~~basicvars+437
L9:
	pld
	tsc
	clc
	adc	#L5
	tcs
	rtl
L5	equ	6
L6	equ	5
	ends
	efunc
	code
	func
~~reinstate:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L10
	tcs
	phd
	tcd
n_1	set	0
	stz	<L11+n_1
L10006:
	lda	|~~basicvars+22
	sta	<R0
	lda	|~~basicvars+22+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldx	<L11+n_1
	lda	|~~basicvars+439,X
	ldy	<L11+n_1
	sta	[<R0],Y
	rep	#$20
	longa	on
L10004:
	inc	<L11+n_1
	sec
	lda	<L11+n_1
	sbc	#<$8
	bvs	L12
	eor	#$8000
L12:
	bmi	L13
	brl	L10006
L13:
L10005:
L14:
	pld
	tsc
	clc
	adc	#L10
	tcs
	rtl
L10	equ	6
L11	equ	5
	ends
	efunc
	code
	xdef	~~clear_program
	func
~~clear_program:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L15
	tcs
	phd
	tcd
	jsl	~~clear_varlists
	jsl	~~clear_strings
	jsl	~~clear_heap
	clc
	lda	#$4
	adc	|~~basicvars+18
	sta	|~~basicvars+26
	lda	#$0
	adc	|~~basicvars+18+2
	sta	|~~basicvars+26+2
	lda	|~~basicvars+26
	sta	|~~basicvars+22
	lda	|~~basicvars+26+2
	sta	|~~basicvars+22+2
	pea	#^$4
	pea	#<$4
	lda	#<~~startmark
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	|~~basicvars+18+2
	pha
	lda	|~~basicvars+18
	pha
	jsl	~~memmove
	jsl	~~preserve
	lda	|~~basicvars+26+2
	pha
	lda	|~~basicvars+26
	pha
	jsl	~~mark_end
	clc
	lda	#$8
	adc	|~~basicvars+26
	sta	|~~basicvars+34
	lda	#$0
	adc	|~~basicvars+26+2
	sta	|~~basicvars+34+2
	lda	|~~basicvars+34
	sta	|~~basicvars+30
	lda	|~~basicvars+34+2
	sta	|~~basicvars+30+2
	clc
	lda	#$100
	adc	|~~basicvars+26
	sta	|~~basicvars+38
	lda	#$0
	adc	|~~basicvars+26+2
	sta	|~~basicvars+38+2
	lda	|~~basicvars+50
	sta	|~~basicvars+42
	lda	|~~basicvars+50+2
	sta	|~~basicvars+42+2
	lda	|~~basicvars+22
	sta	|~~basicvars+498
	lda	|~~basicvars+22+2
	sta	|~~basicvars+498+2
	stz	|~~basicvars+399
	stz	|~~basicvars+399+2
	stz	|~~basicvars+411
	stz	|~~basicvars+411+2
	stz	|~~basicvars+228
	stz	|~~basicvars+230
	stz	|~~basicvars+233
	stz	|~~basicvars+233+2
	sep	#$20
	longa	off
	stz	|~~basicvars+489
	rep	#$20
	longa	on
	lda	#$1
	trb	~~basicvars+437
	lda	#$1
	trb	~~basicvars+423
	lda	#$20
	trb	~~basicvars+423
	lda	#$40
	trb	~~basicvars+423
	lda	#$100
	tsb	~~basicvars+423
	lda	#$80
	trb	~~basicvars+423
	stz	|~~basicvars+427
	lda	#$2
	trb	~~basicvars+425
	lda	#$8
	trb	~~basicvars+425
	lda	#$4
	trb	~~basicvars+425
	lda	#$10
	trb	~~basicvars+425
	lda	#$20
	tsb	~~basicvars+425
	lda	#$90a
	sta	|~~basicvars+520
	stz	|~~basicvars+447
	stz	|~~basicvars+494
	stz	|~~basicvars+496
	sep	#$20
	longa	off
	stz	|~~basicvars+1354
	rep	#$20
	longa	on
	stz	|~~basicvars+502
	stz	|~~last_added
	stz	|~~last_added+2
	jsl	~~init_stack
L17:
	pld
	tsc
	clc
	adc	#L15
	tcs
	rtl
L15	equ	4
L16	equ	5
	ends
	efunc
	code
	func
~~adjust_heaplimits:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L18
	tcs
	phd
	tcd
	clc
	lda	#$8
	adc	|~~basicvars+26
	sta	<R0
	lda	#$0
	adc	|~~basicvars+26+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~alignaddr
	sta	|~~basicvars+34
	stx	|~~basicvars+34+2
	lda	|~~basicvars+34
	sta	|~~basicvars+30
	lda	|~~basicvars+34+2
	sta	|~~basicvars+30+2
	clc
	lda	#$100
	adc	|~~basicvars+34
	sta	|~~basicvars+38
	lda	#$0
	adc	|~~basicvars+34+2
	sta	|~~basicvars+38+2
L20:
	pld
	tsc
	clc
	adc	#L18
	tcs
	rtl
L18	equ	4
L19	equ	5
	ends
	efunc
	code
	func
~~isvalidprog:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L21
	tcs
	phd
	tcd
lastline_1	set	0
p_1	set	2
isnotfirst_1	set	6
	stz	<L22+lastline_1
	sep	#$20
	longa	off
	stz	<L22+isnotfirst_1
	rep	#$20
	longa	on
	lda	|~~basicvars+22
	sta	<L22+p_1
	lda	|~~basicvars+22+2
	sta	<L22+p_1+2
L10007:
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L22+p_1],Y
	cmp	#<$ff
	rep	#$20
	longa	on
	bne	L23
	brl	L10008
L23:
	pei	<L22+p_1+2
	pei	<L22+p_1
	jsl	~~isvalid
	and	#$ff
	bne	L25
	brl	L24
L25:
	lda	<L22+isnotfirst_1
	and	#$ff
	bne	L26
	brl	L10009
L26:
	pei	<L22+p_1+2
	pei	<L22+p_1
	jsl	~~get_lineno
	sta	<R0
	sec
	lda	<L22+lastline_1
	sbc	<R0
	bvs	L27
	eor	#$8000
L27:
	bmi	L28
	brl	L10009
L28:
L24:
	lda	#$0
L29:
	tay
	pld
	tsc
	clc
	adc	#L21
	tcs
	tya
	rtl
L10009:
	pei	<L22+p_1+2
	pei	<L22+p_1
	jsl	~~get_lineno
	sta	<L22+lastline_1
	sep	#$20
	longa	off
	lda	#$1
	sta	<L22+isnotfirst_1
	rep	#$20
	longa	on
	pei	<L22+p_1+2
	pei	<L22+p_1
	jsl	~~get_linelen
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L30
	dey
L30:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L22+p_1
	adc	<R0
	sta	<L22+p_1
	lda	<L22+p_1+2
	adc	<R0+2
	sta	<L22+p_1+2
	brl	L10007
L10008:
	stz	<R0
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L22+p_1],Y
	cmp	#<$ff
	rep	#$20
	longa	on
	beq	L32
	brl	L31
L32:
	inc	<R0
L31:
	lda	<R0
	and	#$ff
	brl	L29
L21	equ	11
L22	equ	5
	ends
	efunc
	code
	xdef	~~recover_program
	func
~~recover_program:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L33
	tcs
	phd
	tcd
bp_1	set	0
	lda	|~~basicvars+437
	bit	#$4
	bne	L35
	brl	L10010
L35:
	jsl	~~reinstate
	lda	|~~basicvars+22
	sta	<L34+bp_1
	lda	|~~basicvars+22+2
	sta	<L34+bp_1+2
	jsl	~~isvalidprog
	sep	#$20
	longa	off
	sta	<R0
	rep	#$20
	longa	on
	lda	<R0
	and	#$ff
	sta	<R0
	asl	<R0
	asl	<R0
	lda	<R0
	and	#<$4
	sta	<R0
	lda	#$4
	trb	|~~basicvars+437
	lda	<R0
	tsb	|~~basicvars+437
L10010:
	lda	|~~basicvars+437
	bit	#$4
	bne	L36
	brl	L10011
L36:
L10012:
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L34+bp_1],Y
	cmp	#<$ff
	rep	#$20
	longa	on
	bne	L37
	brl	L10013
L37:
	pei	<L34+bp_1+2
	pei	<L34+bp_1
	jsl	~~get_linelen
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L38
	dey
L38:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L34+bp_1
	adc	<R0
	sta	<L34+bp_1
	lda	<L34+bp_1+2
	adc	<R0+2
	sta	<L34+bp_1+2
	brl	L10012
L10013:
	lda	<L34+bp_1
	sta	|~~basicvars+26
	lda	<L34+bp_1+2
	sta	|~~basicvars+26+2
	jsl	~~adjust_heaplimits
	brl	L10014
L10011:
	jsl	~~clear_varlists
	jsl	~~clear_strings
	jsl	~~clear_heap
	lda	#$1
	tsb	~~basicvars+437
	pea	#<$ff00
	lda	|~~basicvars+22+2
	pha
	lda	|~~basicvars+22
	pha
	jsl	~~save_lineno
	clc
	lda	#$4
	adc	|~~basicvars+18
	sta	|~~basicvars+26
	lda	#$0
	adc	|~~basicvars+18+2
	sta	|~~basicvars+26+2
	lda	|~~basicvars+26
	sta	|~~basicvars+407
	lda	|~~basicvars+26+2
	sta	|~~basicvars+407+2
	lda	|~~basicvars+26
	sta	|~~basicvars+62
	lda	|~~basicvars+26+2
	sta	|~~basicvars+62+2
	jsl	~~adjust_heaplimits
	pea	#<$7
	pea	#4
	jsl	~~error
L10014:
L39:
	pld
	tsc
	clc
	adc	#L33
	tcs
	rtl
L33	equ	8
L34	equ	5
	ends
	efunc
	code
	func
~~clear_refs:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L40
	tcs
	phd
	tcd
bp_1	set	0
lp_1	set	4
	lda	|~~basicvars+423
	bit	#$40
	bne	L42
	brl	L10015
L42:
	jsl	~~clear_varlists
	jsl	~~clear_heap
	jsl	~~clear_strings
L10015:
	lda	|~~basicvars+423
	bit	#$20
	bne	L43
	brl	L10016
L43:
	lda	|~~basicvars+22
	sta	<L41+bp_1
	lda	|~~basicvars+22+2
	sta	<L41+bp_1+2
L10017:
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L41+bp_1],Y
	cmp	#<$ff
	rep	#$20
	longa	on
	bne	L44
	brl	L10018
L44:
	pei	<L41+bp_1+2
	pei	<L41+bp_1
	jsl	~~clear_linerefs
	pei	<L41+bp_1+2
	pei	<L41+bp_1
	jsl	~~get_linelen
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L45
	dey
L45:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L41+bp_1
	adc	<R0
	sta	<L41+bp_1
	lda	<L41+bp_1+2
	adc	<R0+2
	sta	<L41+bp_1+2
	brl	L10017
L10018:
	lda	|~~basicvars+415
	sta	<L41+lp_1
	lda	|~~basicvars+415+2
	sta	<L41+lp_1+2
L10019:
	lda	<L41+lp_1
	ora	<L41+lp_1+2
	bne	L46
	brl	L10020
L46:
	ldy	#$8
	lda	[<L41+lp_1],Y
	sta	<L41+bp_1
	ldy	#$a
	lda	[<L41+lp_1],Y
	sta	<L41+bp_1+2
L10021:
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L41+bp_1],Y
	cmp	#<$ff
	rep	#$20
	longa	on
	bne	L47
	brl	L10022
L47:
	pei	<L41+bp_1+2
	pei	<L41+bp_1
	jsl	~~clear_linerefs
	ldy	#$2
	lda	[<L41+bp_1],Y
	and	#$ff
	sta	<R0
	ldy	#$3
	lda	[<L41+bp_1],Y
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
	bpl	L48
	dey
L48:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L41+bp_1
	adc	<R0
	sta	<L41+bp_1
	lda	<L41+bp_1+2
	adc	<R0+2
	sta	<L41+bp_1+2
	brl	L10021
L10022:
	lda	[<L41+lp_1]
	sta	<R0
	ldy	#$2
	lda	[<L41+lp_1],Y
	sta	<R0+2
	lda	<R0
	sta	<L41+lp_1
	lda	<R0+2
	sta	<L41+lp_1+2
	brl	L10019
L10020:
L10016:
	stz	|~~basicvars+411
	stz	|~~basicvars+411+2
	lda	#$20
	trb	~~basicvars+423
	lda	#$40
	trb	~~basicvars+423
L49:
	pld
	tsc
	clc
	adc	#L40
	tcs
	rtl
L40	equ	20
L41	equ	13
	ends
	efunc
	code
	func
~~insert_line:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L50
	tcs
	phd
	tcd
line_0	set	4
lendiff_1	set	0
newline_1	set	2
newlength_1	set	4
bp_1	set	6
prev_1	set	10
	pei	<L50+line_0+2
	pei	<L50+line_0
	jsl	~~get_lineno
	sta	<L51+newline_1
	pei	<L50+line_0+2
	pei	<L50+line_0
	jsl	~~get_linelen
	sta	<L51+newlength_1
	lda	|~~last_added
	ora	|~~last_added+2
	bne	L52
	brl	L10023
L52:
	lda	|~~last_added+2
	pha
	lda	|~~last_added
	pha
	jsl	~~get_lineno
	sta	<R0
	sec
	lda	<L51+newline_1
	sbc	<R0
	bvs	L53
	eor	#$8000
L53:
	bmi	L54
	brl	L10023
L54:
	lda	|~~last_added
	sta	<L51+bp_1
	lda	|~~last_added+2
	sta	<L51+bp_1+2
	brl	L10024
L10023:
	lda	|~~basicvars+22
	sta	<L51+bp_1
	lda	|~~basicvars+22+2
	sta	<L51+bp_1+2
L10024:
	stz	<L51+prev_1
	stz	<L51+prev_1+2
L10025:
	pei	<L51+bp_1+2
	pei	<L51+bp_1
	jsl	~~get_lineno
	sta	<R0
	sec
	lda	<L51+newline_1
	sbc	<R0
	bvs	L55
	eor	#$8000
L55:
	bmi	L56
	brl	L10026
L56:
	lda	<L51+bp_1
	sta	<L51+prev_1
	lda	<L51+bp_1+2
	sta	<L51+prev_1+2
	pei	<L51+bp_1+2
	pei	<L51+bp_1
	jsl	~~get_linelen
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L57
	dey
L57:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L51+bp_1
	adc	<R0
	sta	<L51+bp_1
	lda	<L51+bp_1+2
	adc	<R0+2
	sta	<L51+bp_1+2
	brl	L10025
L10026:
	lda	<L51+prev_1
	ora	<L51+prev_1+2
	bne	L58
	brl	L10027
L58:
	pei	<L51+prev_1+2
	pei	<L51+prev_1
	jsl	~~get_lineno
	sta	<R0
	lda	<R0
	cmp	<L51+newline_1
	beq	L59
	brl	L10027
L59:
	pei	<L51+prev_1+2
	pei	<L51+prev_1
	jsl	~~get_linelen
	sta	<R0
	sec
	lda	<L51+newlength_1
	sbc	<R0
	sta	<L51+lendiff_1
	lda	<L51+lendiff_1
	bne	L60
	brl	L10028
L60:
	ldy	#$0
	lda	<L51+lendiff_1
	bpl	L61
	dey
L61:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars+26
	adc	<R0
	sta	<R1
	lda	|~~basicvars+26+2
	adc	<R0+2
	sta	<R1+2
	lda	<R1
	cmp	|~~basicvars+50
	lda	<R1+2
	sbc	|~~basicvars+50+2
	bcs	L62
	brl	L10029
L62:
	pea	#<$59
	pea	#4
	jsl	~~error
L10029:
	sec
	lda	|~~basicvars+26
	sbc	<L51+bp_1
	sta	<R0
	lda	|~~basicvars+26+2
	sbc	<L51+bp_1+2
	sta	<R0+2
	clc
	lda	#$8
	adc	<R0
	sta	<R1
	lda	#$0
	adc	<R0+2
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<L51+bp_1+2
	pei	<L51+bp_1
	ldy	#$0
	lda	<L51+newlength_1
	bpl	L63
	dey
L63:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L51+prev_1
	adc	<R0
	sta	<R2
	lda	<L51+prev_1+2
	adc	<R0+2
	sta	<R2+2
	pei	<R2+2
	pei	<R2
	jsl	~~memmove
	ldy	#$0
	lda	<L51+lendiff_1
	bpl	L64
	dey
L64:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars+26
	adc	<R0
	sta	|~~basicvars+26
	lda	|~~basicvars+26+2
	adc	<R0+2
	sta	|~~basicvars+26+2
L10028:
	ldy	#$0
	lda	<L51+newlength_1
	bpl	L65
	dey
L65:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L50+line_0+2
	pei	<L50+line_0
	pei	<L51+prev_1+2
	pei	<L51+prev_1
	jsl	~~memmove
	lda	<L51+prev_1
	sta	|~~last_added
	lda	<L51+prev_1+2
	sta	|~~last_added+2
	brl	L10030
L10027:
	ldy	#$0
	lda	<L51+newlength_1
	bpl	L66
	dey
L66:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars+26
	adc	<R0
	sta	<R1
	lda	|~~basicvars+26+2
	adc	<R0+2
	sta	<R1+2
	lda	<R1
	cmp	|~~basicvars+50
	lda	<R1+2
	sbc	|~~basicvars+50+2
	bcs	L67
	brl	L10031
L67:
	pea	#<$59
	pea	#4
	jsl	~~error
L10031:
	sec
	lda	|~~basicvars+26
	sbc	<L51+bp_1
	sta	<R0
	lda	|~~basicvars+26+2
	sbc	<L51+bp_1+2
	sta	<R0+2
	clc
	lda	#$8
	adc	<R0
	sta	<R1
	lda	#$0
	adc	<R0+2
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<L51+bp_1+2
	pei	<L51+bp_1
	ldy	#$0
	lda	<L51+newlength_1
	bpl	L68
	dey
L68:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L51+bp_1
	adc	<R0
	sta	<R2
	lda	<L51+bp_1+2
	adc	<R0+2
	sta	<R2+2
	pei	<R2+2
	pei	<R2
	jsl	~~memmove
	ldy	#$0
	lda	<L51+newlength_1
	bpl	L69
	dey
L69:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L50+line_0+2
	pei	<L50+line_0
	pei	<L51+bp_1+2
	pei	<L51+bp_1
	jsl	~~memmove
	ldy	#$0
	lda	<L51+newlength_1
	bpl	L70
	dey
L70:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars+26
	adc	<R0
	sta	|~~basicvars+26
	lda	|~~basicvars+26+2
	adc	<R0+2
	sta	|~~basicvars+26+2
	lda	<L51+bp_1
	sta	|~~last_added
	lda	<L51+bp_1+2
	sta	|~~last_added+2
L10030:
	jsl	~~adjust_heaplimits
L71:
	lda	<L50+2
	sta	<L50+2+4
	lda	<L50+1
	sta	<L50+1+4
	pld
	tsc
	clc
	adc	#L50+4
	tcs
	rtl
L50	equ	26
L51	equ	13
	ends
	efunc
	code
	xdef	~~delete_line
	func
~~delete_line:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L72
	tcs
	phd
	tcd
line_0	set	4
length_1	set	0
p_1	set	2
	pei	<L72+line_0
	jsl	~~find_line
	sta	<L73+p_1
	stx	<L73+p_1+2
	pei	<L73+p_1+2
	pei	<L73+p_1
	jsl	~~get_lineno
	sta	<R0
	lda	<R0
	cmp	<L72+line_0
	beq	L74
	brl	L10032
L74:
	pei	<L73+p_1+2
	pei	<L73+p_1
	jsl	~~get_linelen
	sta	<L73+length_1
	ldy	#$0
	lda	<L73+length_1
	bpl	L75
	dey
L75:
	sta	<R0
	sty	<R0+2
	sec
	lda	|~~basicvars+26
	sbc	<L73+p_1
	sta	<R1
	lda	|~~basicvars+26+2
	sbc	<L73+p_1+2
	sta	<R1+2
	sec
	lda	<R1
	sbc	<R0
	sta	<R2
	lda	<R1+2
	sbc	<R0+2
	sta	<R2+2
	clc
	lda	#$8
	adc	<R2
	sta	<R0
	lda	#$0
	adc	<R2+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	ldy	#$0
	lda	<L73+length_1
	bpl	L76
	dey
L76:
	sta	<R1
	sty	<R1+2
	clc
	lda	<L73+p_1
	adc	<R1
	sta	<R2
	lda	<L73+p_1+2
	adc	<R1+2
	sta	<R2+2
	pei	<R2+2
	pei	<R2
	pei	<L73+p_1+2
	pei	<L73+p_1
	jsl	~~memmove
	ldy	#$0
	lda	<L73+length_1
	bpl	L77
	dey
L77:
	sta	<R0
	sty	<R0+2
	sec
	lda	|~~basicvars+26
	sbc	<R0
	sta	|~~basicvars+26
	lda	|~~basicvars+26+2
	sbc	<R0+2
	sta	|~~basicvars+26+2
	jsl	~~adjust_heaplimits
	stz	|~~last_added
	stz	|~~last_added+2
L10032:
L78:
	lda	<L72+2
	sta	<L72+2+2
	lda	<L72+1
	sta	<L72+1+2
	pld
	tsc
	clc
	adc	#L72+2
	tcs
	rtl
L72	equ	18
L73	equ	13
	ends
	efunc
	code
	xdef	~~delete_range
	func
~~delete_range:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L79
	tcs
	phd
	tcd
low_0	set	4
high_0	set	6
lowline_1	set	0
highline_1	set	4
	sec
	lda	<L79+high_0
	sbc	<L79+low_0
	bvs	L81
	eor	#$8000
L81:
	bpl	L82
	brl	L10033
L82:
L83:
	lda	<L79+2
	sta	<L79+2+4
	lda	<L79+1
	sta	<L79+1+4
	pld
	tsc
	clc
	adc	#L79+4
	tcs
	rtl
L10033:
	pei	<L79+low_0
	jsl	~~find_line
	sta	<L80+lowline_1
	stx	<L80+lowline_1+2
	pei	<L80+lowline_1+2
	pei	<L80+lowline_1
	jsl	~~get_lineno
	sta	<R0
	lda	<R0
	cmp	#<$ff00
	beq	L84
	brl	L10034
L84:
	brl	L83
L10034:
	jsl	~~clear_refs
	pei	<L79+high_0
	jsl	~~find_line
	sta	<L80+highline_1
	stx	<L80+highline_1+2
	pei	<L80+highline_1+2
	pei	<L80+highline_1
	jsl	~~get_lineno
	sta	<R0
	lda	<R0
	cmp	<L79+high_0
	beq	L85
	brl	L10035
L85:
	pei	<L80+highline_1+2
	pei	<L80+highline_1
	jsl	~~get_linelen
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L86
	dey
L86:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L80+highline_1
	adc	<R0
	sta	<L80+highline_1
	lda	<L80+highline_1+2
	adc	<R0+2
	sta	<L80+highline_1+2
L10035:
	sec
	lda	|~~basicvars+26
	sbc	<L80+highline_1
	sta	<R0
	lda	|~~basicvars+26+2
	sbc	<L80+highline_1+2
	sta	<R0+2
	clc
	lda	#$8
	adc	<R0
	sta	<R1
	lda	#$0
	adc	<R0+2
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	pei	<L80+highline_1+2
	pei	<L80+highline_1
	pei	<L80+lowline_1+2
	pei	<L80+lowline_1
	jsl	~~memmove
	sec
	lda	<L80+highline_1
	sbc	<L80+lowline_1
	sta	<R0
	lda	<L80+highline_1+2
	sbc	<L80+lowline_1+2
	sta	<R0+2
	sec
	lda	|~~basicvars+26
	sbc	<R0
	sta	|~~basicvars+26
	lda	|~~basicvars+26+2
	sbc	<R0+2
	sta	|~~basicvars+26+2
	jsl	~~adjust_heaplimits
	stz	|~~last_added
	stz	|~~last_added+2
	brl	L83
L79	equ	16
L80	equ	9
	ends
	efunc
	code
	xdef	~~renumber_program
	func
~~renumber_program:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L87
	tcs
	phd
	tcd
progstart_0	set	4
start_0	set	8
step_0	set	10
bp_1	set	0
ok_1	set	4
	lda	<L87+progstart_0
	sta	<L88+bp_1
	lda	<L87+progstart_0+2
	sta	<L88+bp_1+2
L10036:
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L88+bp_1],Y
	cmp	#<$ff
	rep	#$20
	longa	on
	bne	L89
	brl	L10037
L89:
	ldy	#$0
	lda	<L87+start_0
	bpl	L90
	dey
L90:
	sta	<R0
	sty	<R0+2
	sec
	lda	#$feff
	sbc	<R0
	lda	#$0
	sbc	<R0+2
	bvs	L91
	eor	#$8000
L91:
	bmi	L92
	brl	L10037
L92:
	pei	<L88+bp_1+2
	pei	<L88+bp_1
	jsl	~~resolve_linenums
	pei	<L88+bp_1+2
	pei	<L88+bp_1
	jsl	~~get_linelen
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L93
	dey
L93:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L88+bp_1
	adc	<R0
	sta	<L88+bp_1
	lda	<L88+bp_1+2
	adc	<R0+2
	sta	<L88+bp_1+2
	brl	L10036
L10037:
	lda	<L87+progstart_0
	sta	<L88+bp_1
	lda	<L87+progstart_0+2
	sta	<L88+bp_1+2
L10038:
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L88+bp_1],Y
	cmp	#<$ff
	rep	#$20
	longa	on
	bne	L94
	brl	L10039
L94:
	ldy	#$0
	lda	<L87+start_0
	bpl	L95
	dey
L95:
	sta	<R0
	sty	<R0+2
	sec
	lda	#$feff
	sbc	<R0
	lda	#$0
	sbc	<R0+2
	bvs	L96
	eor	#$8000
L96:
	bmi	L97
	brl	L10039
L97:
	pei	<L87+start_0
	pei	<L88+bp_1+2
	pei	<L88+bp_1
	jsl	~~save_lineno
	clc
	lda	<L87+start_0
	adc	<L87+step_0
	sta	<L87+start_0
	pei	<L88+bp_1+2
	pei	<L88+bp_1
	jsl	~~get_linelen
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L98
	dey
L98:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L88+bp_1
	adc	<R0
	sta	<L88+bp_1
	lda	<L88+bp_1+2
	adc	<R0+2
	sta	<L88+bp_1+2
	brl	L10038
L10039:
	stz	<R0
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L88+bp_1],Y
	cmp	#<$ff
	rep	#$20
	longa	on
	beq	L100
	brl	L99
L100:
	inc	<R0
L99:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L88+ok_1
	rep	#$20
	longa	on
	lda	<L88+ok_1
	and	#$ff
	beq	L101
	brl	L10040
L101:
	lda	<L87+step_0
	cmp	#<$1
	bne	L102
	brl	L10041
L102:
	lda	#$1
	sta	<L87+start_0
	lda	<L87+progstart_0
	sta	<L88+bp_1
	lda	<L87+progstart_0+2
	sta	<L88+bp_1+2
L10042:
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L88+bp_1],Y
	cmp	#<$ff
	rep	#$20
	longa	on
	bne	L103
	brl	L10043
L103:
	ldy	#$0
	lda	<L87+start_0
	bpl	L104
	dey
L104:
	sta	<R0
	sty	<R0+2
	sec
	lda	#$feff
	sbc	<R0
	lda	#$0
	sbc	<R0+2
	bvs	L105
	eor	#$8000
L105:
	bmi	L106
	brl	L10043
L106:
	pei	<L87+start_0
	pei	<L88+bp_1+2
	pei	<L88+bp_1
	jsl	~~save_lineno
	inc	<L87+start_0
	pei	<L88+bp_1+2
	pei	<L88+bp_1
	jsl	~~get_linelen
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L107
	dey
L107:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L88+bp_1
	adc	<R0
	sta	<L88+bp_1
	lda	<L88+bp_1+2
	adc	<R0+2
	sta	<L88+bp_1+2
	brl	L10042
L10043:
L10041:
L10040:
	lda	<L87+progstart_0
	sta	<L88+bp_1
	lda	<L87+progstart_0+2
	sta	<L88+bp_1+2
L10044:
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L88+bp_1],Y
	cmp	#<$ff
	rep	#$20
	longa	on
	bne	L108
	brl	L10045
L108:
	ldy	#$0
	lda	<L87+start_0
	bpl	L109
	dey
L109:
	sta	<R0
	sty	<R0+2
	sec
	lda	#$feff
	sbc	<R0
	lda	#$0
	sbc	<R0+2
	bvs	L110
	eor	#$8000
L110:
	bmi	L111
	brl	L10045
L111:
	pei	<L88+bp_1+2
	pei	<L88+bp_1
	jsl	~~reset_linenums
	pei	<L88+bp_1+2
	pei	<L88+bp_1
	jsl	~~get_linelen
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L112
	dey
L112:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L88+bp_1
	adc	<R0
	sta	<L88+bp_1
	lda	<L88+bp_1+2
	adc	<R0+2
	sta	<L88+bp_1+2
	brl	L10044
L10045:
	lda	<L88+ok_1
	and	#$ff
	beq	L113
	brl	L10046
L113:
	pea	#<$84
	pea	#4
	jsl	~~error
L10046:
L114:
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
L87	equ	9
L88	equ	5
	ends
	efunc
	code
	func
~~open_file:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L115
	tcs
	phd
	tcd
name_0	set	4
srce_1	set	0
dest_1	set	4
handle_1	set	8
	pei	<L115+name_0+2
	pei	<L115+name_0
	lda	#<~~basicvars+1370
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~strcpy
	pea	#^L1
	pea	#<L1
	pei	<L115+name_0+2
	pei	<L115+name_0
	jsl	~~fopen
	sta	<L116+handle_1
	stx	<L116+handle_1+2
	lda	<L116+handle_1
	ora	<L116+handle_1+2
	beq	L118
	brl	L117
L118:
	lda	|~~basicvars+419
	ora	|~~basicvars+419+2
	bne	L119
	brl	L117
L119:
	pei	<L115+name_0+2
	pei	<L115+name_0
	jsl	~~isapath
	and	#$ff
	bne	L120
	brl	L10047
L120:
L117:
	ldx	<L116+handle_1+2
	lda	<L116+handle_1
L121:
	tay
	lda	<L115+2
	sta	<L115+2+4
	lda	<L115+1
	sta	<L115+1+4
	pld
	tsc
	clc
	adc	#L115+4
	tcs
	tya
	rtl
L10047:
	lda	|~~basicvars+419
	sta	<L116+srce_1
	lda	|~~basicvars+419+2
	sta	<L116+srce_1+2
L10050:
	lda	#<~~basicvars+1370
	sta	<L116+dest_1
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<L116+dest_1+2
	sep	#$20
	longa	off
	lda	[<L116+srce_1]
	cmp	#<$2c
	rep	#$20
	longa	on
	bne	L122
	brl	L10051
L122:
L10052:
	lda	[<L116+srce_1]
	and	#$ff
	bne	L123
	brl	L10053
L123:
	sep	#$20
	longa	off
	lda	[<L116+srce_1]
	cmp	#<$2c
	rep	#$20
	longa	on
	bne	L124
	brl	L10053
L124:
	sep	#$20
	longa	off
	lda	[<L116+srce_1]
	sta	[<L116+dest_1]
	rep	#$20
	longa	on
	inc	<L116+dest_1
	bne	L125
	inc	<L116+dest_1+2
L125:
	inc	<L116+srce_1
	bne	L126
	inc	<L116+srce_1+2
L126:
	brl	L10052
L10053:
	clc
	lda	#$ffff
	adc	<L116+srce_1
	sta	<R0
	lda	#$ffff
	adc	<L116+srce_1+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$2f
	rep	#$20
	longa	on
	bne	L127
	brl	L10054
L127:
	sep	#$20
	longa	off
	lda	#$2f
	sta	[<L116+dest_1]
	rep	#$20
	longa	on
	inc	<L116+dest_1
	bne	L128
	inc	<L116+dest_1+2
L128:
L10054:
L10051:
	sep	#$20
	longa	off
	lda	#$0
	sta	[<L116+dest_1]
	rep	#$20
	longa	on
	pei	<L115+name_0+2
	pei	<L115+name_0
	lda	#<~~basicvars+1370
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~strcat
	pea	#^L1+3
	pea	#<L1+3
	lda	#<~~basicvars+1370
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~fopen
	sta	<L116+handle_1
	stx	<L116+handle_1+2
	lda	<L116+handle_1
	ora	<L116+handle_1+2
	beq	L129
	brl	L10049
L129:
	lda	[<L116+srce_1]
	and	#$ff
	bne	L130
	brl	L10049
L130:
	inc	<L116+srce_1
	bne	L131
	inc	<L116+srce_1+2
L131:
L10048:
	brl	L10050
L10049:
	ldx	<L116+handle_1+2
	lda	<L116+handle_1
	brl	L121
L115	equ	16
L116	equ	5
	ends
	efunc
	data
L1:
	db	$72,$62,$00,$72,$62,$00
	ends
	code
	func
~~read_bbcfile:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L133
	tcs
	phd
	tcd
bbcfile_0	set	4
base_0	set	8
limit_0	set	12
length_1	set	0
count_1	set	2
line_1	set	4
filebase_1	set	8
tokenline_1	set	12
	stz	|~~basicvars+502
	lda	<L133+base_0
	sta	<L134+filebase_1
	lda	<L133+base_0+2
	sta	<L134+filebase_1+2
	pea	#^$400
	pea	#<$400
	jsl	~~malloc
	sta	<L134+line_1
	stx	<L134+line_1+2
	pea	#^$400
	pea	#<$400
	jsl	~~malloc
	sta	<L134+tokenline_1
	stx	<L134+tokenline_1+2
L10057:
	pei	<L133+bbcfile_0+2
	pei	<L133+bbcfile_0
	jsl	~~fgetc
	sep	#$20
	longa	off
	sta	[<L134+line_1]
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	lda	[<L134+line_1]
	cmp	#<$ff
	rep	#$20
	longa	on
	bne	L135
	brl	L10056
L135:
	pei	<L133+bbcfile_0+2
	pei	<L133+bbcfile_0
	jsl	~~fgetc
	sep	#$20
	longa	off
	ldy	#$1
	sta	[<L134+line_1],Y
	rep	#$20
	longa	on
	pei	<L133+bbcfile_0+2
	pei	<L133+bbcfile_0
	jsl	~~fgetc
	sta	<L134+length_1
	sep	#$20
	longa	off
	lda	<L134+length_1
	ldy	#$2
	sta	[<L134+line_1],Y
	rep	#$20
	longa	on
	pei	<L133+bbcfile_0+2
	pei	<L133+bbcfile_0
	clc
	lda	#$fffd
	adc	<L134+length_1
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L136
	dey
L136:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pea	#^$1
	pea	#<$1
	clc
	lda	#$3
	adc	<L134+line_1
	sta	<R1
	lda	#$0
	adc	<L134+line_1+2
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	jsl	~~fread
	sta	<L134+count_1
	clc
	lda	#$fffd
	adc	<L134+length_1
	sta	<R0
	lda	<R0
	cmp	<L134+count_1
	bne	L137
	brl	L10058
L137:
	pei	<L133+bbcfile_0+2
	pei	<L133+bbcfile_0
	jsl	~~fclose
	lda	#<~~basicvars+1370
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	pea	#<$75
	pea	#8
	jsl	~~error
L10058:
	inc	|~~basicvars+502
	pei	<L134+tokenline_1+2
	pei	<L134+tokenline_1
	pei	<L134+line_1+2
	pei	<L134+line_1
	jsl	~~reformat
	sta	<L134+length_1
	sec
	lda	#$0
	sbc	<L134+length_1
	bvs	L138
	eor	#$8000
L138:
	bpl	L139
	brl	L10059
L139:
	ldy	#$0
	lda	<L134+length_1
	bpl	L140
	dey
L140:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L133+base_0
	adc	<R0
	sta	<R1
	lda	<L133+base_0+2
	adc	<R0+2
	sta	<R1+2
	lda	<R1
	cmp	<L133+limit_0
	lda	<R1+2
	sbc	<L133+limit_0+2
	bcs	L141
	brl	L10060
L141:
	pei	<L133+bbcfile_0+2
	pei	<L133+bbcfile_0
	jsl	~~fclose
	pea	#<$59
	pea	#4
	jsl	~~error
L10060:
	ldy	#$0
	lda	<L134+length_1
	bpl	L142
	dey
L142:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L134+tokenline_1+2
	pei	<L134+tokenline_1
	pei	<L133+base_0+2
	pei	<L133+base_0
	jsl	~~memmove
	ldy	#$0
	lda	<L134+length_1
	bpl	L143
	dey
L143:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L133+base_0
	adc	<R0
	sta	<L133+base_0
	lda	<L133+base_0+2
	adc	<R0+2
	sta	<L133+base_0+2
L10059:
L10055:
	pei	<L133+bbcfile_0+2
	pei	<L133+bbcfile_0
	jsl	~~feof
	tax
	bne	L144
	brl	L10057
L144:
L10056:
	pei	<L133+bbcfile_0+2
	pei	<L133+bbcfile_0
	jsl	~~fclose
	stz	|~~basicvars+502
	clc
	lda	#$8
	adc	<L133+base_0
	sta	<R0
	lda	#$0
	adc	<L133+base_0+2
	sta	<R0+2
	lda	<R0
	cmp	<L133+limit_0
	lda	<R0+2
	sbc	<L133+limit_0+2
	bcs	L145
	brl	L10061
L145:
	pea	#<$59
	pea	#4
	jsl	~~error
L10061:
	pei	<L133+base_0+2
	pei	<L133+base_0
	jsl	~~mark_end
	pei	<L134+line_1+2
	pei	<L134+line_1
	jsl	~~free
	pei	<L134+tokenline_1+2
	pei	<L134+tokenline_1
	jsl	~~free
	sec
	lda	<L133+base_0
	sbc	<L134+filebase_1
	sta	<R0
	lda	<L133+base_0+2
	sbc	<L134+filebase_1+2
	sta	<R0+2
	clc
	lda	#$9
	adc	<R0
	sta	<R1
	lda	#$0
	adc	<R0+2
	sta	<R1+2
	lda	<R1
	and	#<$fffffffe
	sta	<R0
	lda	<R1+2
	sta	<R0+2
	lda	<R0
L146:
	tay
	lda	<L133+2
	sta	<L133+2+12
	lda	<L133+1
	sta	<L133+1+12
	pld
	tsc
	clc
	adc	#L133+12
	tcs
	tya
	rtl
L133	equ	24
L134	equ	9
	ends
	efunc
	code
	func
~~read_textfile:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L147
	tcs
	phd
	tcd
textfile_0	set	4
base_0	set	8
limit_0	set	12
silent_0	set	16
length_1	set	0
filebase_1	set	2
result_1	set	6
tokenline_1	set	10
gzipped_1	set	14
	sep	#$20
	longa	off
	stz	<L148+gzipped_1
	rep	#$20
	longa	on
	pea	#^$400
	pea	#<$400
	jsl	~~malloc
	sta	<L148+tokenline_1
	stx	<L148+tokenline_1+2
	pea	#<$0
	pea	#^$0
	pea	#<$0
	pei	<L147+textfile_0+2
	pei	<L147+textfile_0
	jsl	~~fseek
	sep	#$20
	longa	off
	lda	#$0
	ldy	#$2
	sta	[<L148+tokenline_1],Y
	rep	#$20
	longa	on
	pei	<L147+textfile_0+2
	pei	<L147+textfile_0
	pea	#^$3
	pea	#<$3
	pea	#^$1
	pea	#<$1
	pei	<L148+tokenline_1+2
	pei	<L148+tokenline_1
	jsl	~~fread
	stz	<R0
	sep	#$20
	longa	off
	lda	[<L148+tokenline_1]
	cmp	#<$1f
	rep	#$20
	longa	on
	beq	L150
	brl	L149
L150:
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L148+tokenline_1],Y
	cmp	#<$8b
	rep	#$20
	longa	on
	beq	L151
	brl	L149
L151:
	sep	#$20
	longa	off
	ldy	#$2
	lda	[<L148+tokenline_1],Y
	cmp	#<$8
	rep	#$20
	longa	on
	beq	L152
	brl	L149
L152:
	inc	<R0
L149:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L148+gzipped_1
	rep	#$20
	longa	on
	lda	<L148+gzipped_1
	and	#$ff
	bne	L153
	brl	L10062
L153:
	pea	#<$90
	pea	#4
	jsl	~~error
	brl	L10063
L10062:
	pei	<L147+textfile_0+2
	pei	<L147+textfile_0
	pea	#^L132
	pea	#<L132
	lda	#<~~basicvars+1370
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~freopen
	sta	<L147+textfile_0
	stx	<L147+textfile_0+2
	lda	<L147+textfile_0
	ora	<L147+textfile_0+2
	beq	L154
	brl	L10064
L154:
	lda	#<~~basicvars+1370
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	pea	#<$79
	pea	#8
	jsl	~~error
L10064:
L10063:
	sep	#$20
	longa	off
	stz	|~~needsnumbers
	rep	#$20
	longa	on
	stz	|~~basicvars+502
	lda	<L147+base_0
	sta	<L148+filebase_1
	lda	<L147+base_0+2
	sta	<L148+filebase_1+2
	pei	<L147+textfile_0+2
	pei	<L147+textfile_0
	pea	#<$400
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	jsl	~~fgets
	sta	<L148+result_1
	stx	<L148+result_1+2
	lda	<L148+result_1
	ora	<L148+result_1+2
	bne	L155
	brl	L10065
L155:
	lda	|~~basicvars+70
	sta	<R0
	lda	|~~basicvars+70+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$23
	rep	#$20
	longa	on
	beq	L156
	brl	L10065
L156:
	pei	<L147+textfile_0+2
	pei	<L147+textfile_0
	pea	#<$400
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	jsl	~~fgets
	sta	<L148+result_1
	stx	<L148+result_1+2
L10065:
L10066:
	lda	<L148+result_1
	ora	<L148+result_1+2
	bne	L157
	brl	L10067
L157:
	inc	|~~basicvars+502
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	jsl	~~strlen
	sta	<L148+length_1
L10070:
	dec	<L148+length_1
L10068:
	lda	<L148+length_1
	bpl	L159
	brl	L158
L159:
	lda	|~~basicvars+70
	sta	<R0
	lda	|~~basicvars+70+2
	sta	<R0+2
	ldy	<L148+length_1
	lda	[<R0],Y
	and	#$ff
	pha
	jsl	~~isspace
	tax
	beq	L160
	brl	L10070
L160:
L158:
L10069:
	inc	<L148+length_1
	lda	|~~basicvars+70
	sta	<R0
	lda	|~~basicvars+70+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$0
	ldy	<L148+length_1
	sta	[<R0],Y
	rep	#$20
	longa	on
	pea	#<$1
	pei	<L148+tokenline_1+2
	pei	<L148+tokenline_1
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	jsl	~~tokenize
	pei	<L148+tokenline_1+2
	pei	<L148+tokenline_1
	jsl	~~get_lineno
	sta	<R0
	lda	<R0
	cmp	#<$ffff
	beq	L161
	brl	L10071
L161:
	pea	#<$0
	pei	<L148+tokenline_1+2
	pei	<L148+tokenline_1
	jsl	~~save_lineno
	sep	#$20
	longa	off
	lda	#$1
	sta	|~~needsnumbers
	rep	#$20
	longa	on
L10071:
	pei	<L148+tokenline_1+2
	pei	<L148+tokenline_1
	jsl	~~get_linelen
	sta	<L148+length_1
	sec
	lda	#$0
	sbc	<L148+length_1
	bvs	L162
	eor	#$8000
L162:
	bpl	L163
	brl	L10072
L163:
	ldy	#$0
	lda	<L148+length_1
	bpl	L164
	dey
L164:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L147+base_0
	adc	<R0
	sta	<R1
	lda	<L147+base_0+2
	adc	<R0+2
	sta	<R1+2
	lda	<R1
	cmp	<L147+limit_0
	lda	<R1+2
	sbc	<L147+limit_0+2
	bcs	L165
	brl	L10073
L165:
	pei	<L147+textfile_0+2
	pei	<L147+textfile_0
	jsl	~~fclose
	pea	#<$59
	pea	#4
	jsl	~~error
L10073:
	ldy	#$0
	lda	<L148+length_1
	bpl	L166
	dey
L166:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L148+tokenline_1+2
	pei	<L148+tokenline_1
	pei	<L147+base_0+2
	pei	<L147+base_0
	jsl	~~memmove
	ldy	#$0
	lda	<L148+length_1
	bpl	L167
	dey
L167:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L147+base_0
	adc	<R0
	sta	<L147+base_0
	lda	<L147+base_0+2
	adc	<R0+2
	sta	<L147+base_0+2
L10072:
	pei	<L147+textfile_0+2
	pei	<L147+textfile_0
	pea	#<$400
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	jsl	~~fgets
	sta	<L148+result_1
	stx	<L148+result_1+2
	brl	L10066
L10067:
	pei	<L147+textfile_0+2
	pei	<L147+textfile_0
	jsl	~~fclose
	stz	|~~basicvars+502
	clc
	lda	#$8
	adc	<L147+base_0
	sta	<R0
	lda	#$0
	adc	<L147+base_0+2
	sta	<R0+2
	lda	<R0
	cmp	<L147+limit_0
	lda	<R0+2
	sbc	<L147+limit_0+2
	bcs	L168
	brl	L10074
L168:
	pea	#<$59
	pea	#4
	jsl	~~error
L10074:
	pei	<L147+base_0+2
	pei	<L147+base_0
	jsl	~~mark_end
	lda	|~~needsnumbers
	and	#$ff
	bne	L169
	brl	L10075
L169:
	pea	#<$1
	pea	#<$1
	pei	<L148+filebase_1+2
	pei	<L148+filebase_1
	jsl	~~renumber_program
	lda	<L147+silent_0
	and	#$ff
	beq	L170
	brl	L10076
L170:
	pea	#<$87
	pea	#4
	jsl	~~error
L10076:
L10075:
	pei	<L148+tokenline_1+2
	pei	<L148+tokenline_1
	jsl	~~free
	sec
	lda	<L147+base_0
	sbc	<L148+filebase_1
	sta	<R0
	lda	<L147+base_0+2
	sbc	<L148+filebase_1+2
	sta	<R0+2
	clc
	lda	#$9
	adc	<R0
	sta	<R1
	lda	#$0
	adc	<R0+2
	sta	<R1+2
	lda	<R1
	and	#<$fffffffe
	sta	<R0
	lda	<R1+2
	sta	<R0+2
	lda	<R0
L171:
	tay
	lda	<L147+2
	sta	<L147+2+14
	lda	<L147+1
	sta	<L147+1+14
	pld
	tsc
	clc
	adc	#L147+14
	tcs
	tya
	rtl
L147	equ	23
L148	equ	9
	ends
	efunc
	data
L132:
	db	$72,$00
	ends
	code
	func
~~identify:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L173
	tcs
	phd
	tcd
thisfile_0	set	4
name_0	set	8
firstchar_1	set	0
	pei	<L173+thisfile_0+2
	pei	<L173+thisfile_0
	jsl	~~fgetc
	sta	<L174+firstchar_1
	lda	<L174+firstchar_1
	cmp	#<$ffffffff
	beq	L175
	brl	L10077
L175:
	pei	<L173+thisfile_0+2
	pei	<L173+thisfile_0
	jsl	~~ferror
	tax
	bne	L176
	brl	L10077
L176:
	pei	<L173+thisfile_0+2
	pei	<L173+thisfile_0
	jsl	~~fclose
	pei	<L173+name_0+2
	pei	<L173+name_0
	pea	#<$75
	pea	#8
	jsl	~~error
L10077:
	lda	<L174+firstchar_1
	cmp	#<$ffffffff
	beq	L177
	brl	L10078
L177:
	pei	<L173+thisfile_0+2
	pei	<L173+thisfile_0
	jsl	~~fclose
	pei	<L173+name_0+2
	pei	<L173+name_0
	pea	#<$78
	pea	#8
	jsl	~~error
L10078:
	lda	<L174+firstchar_1
	cmp	#<$d
	beq	L178
	brl	L10079
L178:
	lda	#$1
L179:
	tay
	lda	<L173+2
	sta	<L173+2+8
	lda	<L173+1
	sta	<L173+1+8
	pld
	tsc
	clc
	adc	#L173+8
	tcs
	tya
	rtl
L10079:
	lda	#$0
	brl	L179
L173	equ	2
L174	equ	1
	ends
	efunc
	code
	xdef	~~read_basic
	func
~~read_basic:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L180
	tcs
	phd
	tcd
name_0	set	4
loadfile_1	set	0
length_1	set	4
	pei	<L180+name_0+2
	pei	<L180+name_0
	jsl	~~open_file
	sta	<L181+loadfile_1
	stx	<L181+loadfile_1+2
	lda	<L181+loadfile_1
	ora	<L181+loadfile_1+2
	beq	L182
	brl	L10080
L182:
	pei	<L180+name_0+2
	pei	<L180+name_0
	pea	#<$6e
	pea	#8
	jsl	~~error
L10080:
	stz	|~~last_added
	stz	|~~last_added+2
	pei	<L180+name_0+2
	pei	<L180+name_0
	pei	<L181+loadfile_1+2
	pei	<L181+loadfile_1
	jsl	~~identify
	sta	<R0
	lda	<R0
	cmp	#<$1
	beq	L183
	brl	L10081
L183:
	jsl	~~clear_program
	lda	|~~basicvars+50+2
	pha
	lda	|~~basicvars+50
	pha
	lda	|~~basicvars+26+2
	pha
	lda	|~~basicvars+26
	pha
	pei	<L181+loadfile_1+2
	pei	<L181+loadfile_1
	jsl	~~read_bbcfile
	sta	<L181+length_1
	brl	L10082
L10081:
	jsl	~~clear_program
	lda	|~~basicvars+423
	sta	<R0
	lsr	<R0
	lda	<R0
	and	#<$1
	sta	<R0
	pei	<R0
	lda	|~~basicvars+50+2
	pha
	lda	|~~basicvars+50
	pha
	lda	|~~basicvars+26+2
	pha
	lda	|~~basicvars+26
	pha
	pei	<L181+loadfile_1+2
	pei	<L181+loadfile_1
	jsl	~~read_textfile
	sta	<L181+length_1
L10082:
	ldy	#$0
	lda	<L181+length_1
	bpl	L184
	dey
L184:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars+26
	adc	<R0
	sta	|~~basicvars+26
	lda	|~~basicvars+26+2
	adc	<R0+2
	sta	|~~basicvars+26+2
	lda	#$1
	trb	~~basicvars+437
	jsl	~~adjust_heaplimits
	lda	|~~basicvars+435
	bit	#$1
	bne	L185
	brl	L10083
L185:
	lda	|~~basicvars+26+2
	pha
	lda	|~~basicvars+26
	pha
	lda	|~~basicvars+18+2
	pha
	lda	|~~basicvars+18
	pha
	pea	#^L172
	pea	#<L172
	lda	|~~stderr+2
	pha
	lda	|~~stderr
	pha
	pea	#18
	jsl	~~fprintf
L10083:
L186:
	lda	<L180+2
	sta	<L180+2+4
	lda	<L180+1
	sta	<L180+1+4
	pld
	tsc
	clc
	adc	#L180+4
	tcs
	rtl
L180	equ	10
L181	equ	5
	ends
	efunc
	data
L172:
	db	$50,$72,$6F,$67,$72,$61,$6D,$20,$69,$73,$20,$6C,$6F,$61,$64
	db	$65,$64,$20,$61,$74,$20,$70,$61,$67,$65,$3D,$26,$25,$70,$2C
	db	$20,$20,$74,$6F,$70,$3D,$26,$25,$70,$0A,$00
	ends
	code
	func
~~link_library:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L188
	tcs
	phd
	tcd
name_0	set	4
base_0	set	8
size_0	set	12
onheap_0	set	14
lp_1	set	0
n_1	set	4
	lda	<L188+onheap_0
	and	#$ff
	bne	L190
	brl	L10084
L190:
	pea	#<$112
	jsl	~~allocmem
	sta	<L189+lp_1
	stx	<L189+lp_1+2
	pei	<L188+name_0+2
	pei	<L188+name_0
	jsl	~~strlen
	sta	<R0
	stx	<R0+2
	clc
	lda	#$1
	adc	<R0
	sta	<R1
	lda	#$0
	adc	<R0+2
	sta	<R1+2
	pei	<R1
	jsl	~~allocmem
	sta	<R0
	stx	<R0+2
	lda	<R0
	ldy	#$4
	sta	[<L189+lp_1],Y
	lda	<R0+2
	ldy	#$6
	sta	[<L189+lp_1],Y
	lda	|~~basicvars+411
	sta	[<L189+lp_1]
	lda	|~~basicvars+411+2
	ldy	#$2
	sta	[<L189+lp_1],Y
	lda	<L189+lp_1
	sta	|~~basicvars+411
	lda	<L189+lp_1+2
	sta	|~~basicvars+411+2
	brl	L10085
L10084:
	pea	#^$112
	pea	#<$112
	jsl	~~malloc
	sta	<L189+lp_1
	stx	<L189+lp_1+2
	lda	<L189+lp_1
	ora	<L189+lp_1+2
	beq	L191
	brl	L10086
L191:
	pei	<L188+name_0+2
	pei	<L188+name_0
	pea	#<$6b
	pea	#8
	jsl	~~error
L10086:
	pei	<L188+name_0+2
	pei	<L188+name_0
	jsl	~~strlen
	sta	<R0
	stx	<R0+2
	clc
	lda	#$1
	adc	<R0
	sta	<R1
	lda	#$0
	adc	<R0+2
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	jsl	~~malloc
	sta	<R0
	stx	<R0+2
	lda	<R0
	ldy	#$4
	sta	[<L189+lp_1],Y
	lda	<R0+2
	ldy	#$6
	sta	[<L189+lp_1],Y
	lda	|~~basicvars+415
	sta	[<L189+lp_1]
	lda	|~~basicvars+415+2
	ldy	#$2
	sta	[<L189+lp_1],Y
	lda	<L189+lp_1
	sta	|~~basicvars+415
	lda	<L189+lp_1+2
	sta	|~~basicvars+415+2
L10085:
	pei	<L188+name_0+2
	pei	<L188+name_0
	ldy	#$6
	lda	[<L189+lp_1],Y
	pha
	ldy	#$4
	lda	[<L189+lp_1],Y
	pha
	jsl	~~strcpy
	lda	<L188+base_0
	ldy	#$8
	sta	[<L189+lp_1],Y
	lda	<L188+base_0+2
	ldy	#$a
	sta	[<L189+lp_1],Y
	lda	<L188+size_0
	ldy	#$c
	sta	[<L189+lp_1],Y
	lda	#$0
	ldy	#$e
	sta	[<L189+lp_1],Y
	lda	#$0
	ldy	#$10
	sta	[<L189+lp_1],Y
	stz	<L189+n_1
L10089:
	ldy	#$0
	lda	<L189+n_1
	bpl	L192
	dey
L192:
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
	lda	#$12
	adc	<L189+lp_1
	sta	<R2
	lda	#$0
	adc	<L189+lp_1+2
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
	lda	#$0
	ldy	#$2
	sta	[<R3],Y
L10087:
	inc	<L189+n_1
	sec
	lda	<L189+n_1
	sbc	#<$40
	bvs	L193
	eor	#$8000
L193:
	bmi	L194
	brl	L10089
L194:
L10088:
L195:
	lda	<L188+2
	sta	<L188+2+12
	lda	<L188+1
	sta	<L188+1+12
	pld
	tsc
	clc
	adc	#L188+12
	tcs
	rtl
L188	equ	22
L189	equ	17
	ends
	efunc
	code
	func
~~read_bbclib:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L196
	tcs
	phd
	tcd
libfile_0	set	4
name_0	set	8
onheap_0	set	12
size_1	set	0
base_1	set	2
	lda	|~~basicvars+34
	sta	<L197+base_1
	lda	|~~basicvars+34+2
	sta	<L197+base_1+2
	lda	|~~basicvars+42+2
	pha
	lda	|~~basicvars+42
	pha
	pei	<L197+base_1+2
	pei	<L197+base_1
	pei	<L196+libfile_0+2
	pei	<L196+libfile_0
	jsl	~~read_bbcfile
	sta	<L197+size_1
	lda	<L196+onheap_0
	and	#$ff
	bne	L198
	brl	L10090
L198:
	ldy	#$0
	lda	<L197+size_1
	bpl	L199
	dey
L199:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars+34
	adc	<R0
	sta	|~~basicvars+34
	lda	|~~basicvars+34+2
	adc	<R0+2
	sta	|~~basicvars+34+2
	clc
	lda	#$100
	adc	|~~basicvars+34
	sta	|~~basicvars+38
	lda	#$0
	adc	|~~basicvars+34+2
	sta	|~~basicvars+38+2
	brl	L10091
L10090:
installbase_2	set	6
	ldy	#$0
	lda	<L197+size_1
	bpl	L200
	dey
L200:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~malloc
	sta	<L197+installbase_2
	stx	<L197+installbase_2+2
	lda	<L197+installbase_2
	ora	<L197+installbase_2+2
	beq	L201
	brl	L10092
L201:
	pei	<L196+name_0+2
	pei	<L196+name_0
	pea	#<$6b
	pea	#8
	jsl	~~error
L10092:
	ldy	#$0
	lda	<L197+size_1
	bpl	L202
	dey
L202:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L197+base_1+2
	pei	<L197+base_1
	pei	<L197+installbase_2+2
	pei	<L197+installbase_2
	jsl	~~memmove
	lda	<L197+installbase_2
	sta	<L197+base_1
	lda	<L197+installbase_2+2
	sta	<L197+base_1+2
	lda	|~~basicvars+435
	bit	#$1
	bne	L203
	brl	L10093
L203:
	pei	<L197+size_1
	pei	<L197+base_1+2
	pei	<L197+base_1
	pei	<L196+name_0+2
	pei	<L196+name_0
	pea	#^L187
	pea	#<L187
	lda	|~~stderr+2
	pha
	lda	|~~stderr
	pha
	pea	#20
	jsl	~~fprintf
L10093:
L10091:
	pei	<L196+onheap_0
	pei	<L197+size_1
	pei	<L197+base_1+2
	pei	<L197+base_1
	pei	<L196+name_0+2
	pei	<L196+name_0
	jsl	~~link_library
L204:
	lda	<L196+2
	sta	<L196+2+10
	lda	<L196+1
	sta	<L196+1+10
	pld
	tsc
	clc
	adc	#L196+10
	tcs
	rtl
L196	equ	14
L197	equ	5
	ends
	efunc
	data
L187:
	db	$4C,$6F,$61,$64,$65,$64,$20,$6C,$69,$62,$72,$61,$72,$79,$20
	db	$27,$25,$73,$27,$20,$61,$74,$20,$25,$70,$2C,$20,$73,$69,$7A
	db	$65,$20,$3D,$20,$25,$64,$0A,$00
	ends
	code
	func
~~read_textlib:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L206
	tcs
	phd
	tcd
libfile_0	set	4
name_0	set	8
onheap_0	set	12
size_1	set	0
base_1	set	2
	lda	|~~basicvars+34
	sta	<L207+base_1
	lda	|~~basicvars+34+2
	sta	<L207+base_1+2
	pea	#<$1
	lda	|~~basicvars+42+2
	pha
	lda	|~~basicvars+42
	pha
	pei	<L207+base_1+2
	pei	<L207+base_1
	pei	<L206+libfile_0+2
	pei	<L206+libfile_0
	jsl	~~read_textfile
	sta	<L207+size_1
	lda	<L206+onheap_0
	and	#$ff
	bne	L208
	brl	L10094
L208:
	ldy	#$0
	lda	<L207+size_1
	bpl	L209
	dey
L209:
	sta	<R0
	sty	<R0+2
	clc
	lda	|~~basicvars+34
	adc	<R0
	sta	|~~basicvars+34
	lda	|~~basicvars+34+2
	adc	<R0+2
	sta	|~~basicvars+34+2
	clc
	lda	#$100
	adc	|~~basicvars+34
	sta	|~~basicvars+38
	lda	#$0
	adc	|~~basicvars+34+2
	sta	|~~basicvars+38+2
	brl	L10095
L10094:
installbase_2	set	6
	ldy	#$0
	lda	<L207+size_1
	bpl	L210
	dey
L210:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~malloc
	sta	<L207+installbase_2
	stx	<L207+installbase_2+2
	lda	<L207+installbase_2
	ora	<L207+installbase_2+2
	beq	L211
	brl	L10096
L211:
	pei	<L206+name_0+2
	pei	<L206+name_0
	pea	#<$6b
	pea	#8
	jsl	~~error
L10096:
	ldy	#$0
	lda	<L207+size_1
	bpl	L212
	dey
L212:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L207+base_1+2
	pei	<L207+base_1
	pei	<L207+installbase_2+2
	pei	<L207+installbase_2
	jsl	~~memmove
	lda	<L207+installbase_2
	sta	<L207+base_1
	lda	<L207+installbase_2+2
	sta	<L207+base_1+2
	lda	|~~basicvars+435
	bit	#$1
	bne	L213
	brl	L10097
L213:
	pei	<L207+size_1
	pei	<L207+base_1+2
	pei	<L207+base_1
	pei	<L206+name_0+2
	pei	<L206+name_0
	pea	#^L205
	pea	#<L205
	lda	|~~stderr+2
	pha
	lda	|~~stderr
	pha
	pea	#20
	jsl	~~fprintf
L10097:
L10095:
	pei	<L206+onheap_0
	pei	<L207+size_1
	pei	<L207+base_1+2
	pei	<L207+base_1
	pei	<L206+name_0+2
	pei	<L206+name_0
	jsl	~~link_library
L214:
	lda	<L206+2
	sta	<L206+2+10
	lda	<L206+1
	sta	<L206+1+10
	pld
	tsc
	clc
	adc	#L206+10
	tcs
	rtl
L206	equ	14
L207	equ	5
	ends
	efunc
	data
L205:
	db	$4C,$6F,$61,$64,$65,$64,$20,$6C,$69,$62,$72,$61,$72,$79,$20
	db	$27,$25,$73,$27,$20,$61,$74,$20,$25,$70,$2C,$20,$73,$69,$7A
	db	$65,$20,$3D,$20,$25,$64,$0A,$00
	ends
	code
	xdef	~~read_library
	func
~~read_library:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L216
	tcs
	phd
	tcd
name_0	set	4
onheap_0	set	8
firstchar_1	set	0
lp_1	set	2
libfile_1	set	6
	lda	<L216+onheap_0
	and	#$ff
	bne	L218
	brl	L10098
L218:
	lda	|~~basicvars+411
	sta	<L217+lp_1
	lda	|~~basicvars+411+2
	sta	<L217+lp_1+2
	brl	L10099
L10098:
	lda	|~~basicvars+415
	sta	<L217+lp_1
	lda	|~~basicvars+415+2
	sta	<L217+lp_1+2
L10099:
L10100:
	lda	<L217+lp_1
	ora	<L217+lp_1+2
	bne	L219
	brl	L10101
L219:
	pei	<L216+name_0+2
	pei	<L216+name_0
	ldy	#$6
	lda	[<L217+lp_1],Y
	pha
	ldy	#$4
	lda	[<L217+lp_1],Y
	pha
	jsl	~~strcmp
	tax
	bne	L220
	brl	L10101
L220:
	lda	[<L217+lp_1]
	sta	<R0
	ldy	#$2
	lda	[<L217+lp_1],Y
	sta	<R0+2
	lda	<R0
	sta	<L217+lp_1
	lda	<R0+2
	sta	<L217+lp_1+2
	brl	L10100
L10101:
	lda	<L217+lp_1
	ora	<L217+lp_1+2
	bne	L221
	brl	L10102
L221:
	pei	<L216+name_0+2
	pei	<L216+name_0
	pea	#<$69
	pea	#8
	jsl	~~error
L222:
	lda	<L216+2
	sta	<L216+2+6
	lda	<L216+1
	sta	<L216+1+6
	pld
	tsc
	clc
	adc	#L216+6
	tcs
	rtl
L10102:
	pei	<L216+name_0+2
	pei	<L216+name_0
	jsl	~~open_file
	sta	<L217+libfile_1
	stx	<L217+libfile_1+2
	lda	<L217+libfile_1
	ora	<L217+libfile_1+2
	beq	L223
	brl	L10103
L223:
	pei	<L216+name_0+2
	pei	<L216+name_0
	pea	#<$6a
	pea	#8
	jsl	~~error
L10103:
	pei	<L216+name_0+2
	pei	<L216+name_0
	pei	<L217+libfile_1+2
	pei	<L217+libfile_1
	jsl	~~identify
	sta	<R0
	lda	<R0
	cmp	#<$1
	beq	L224
	brl	L10104
L224:
	pei	<L216+onheap_0
	pei	<L216+name_0+2
	pei	<L216+name_0
	pei	<L217+libfile_1+2
	pei	<L217+libfile_1
	jsl	~~read_bbclib
	brl	L10105
L10104:
	pei	<L216+onheap_0
	pei	<L216+name_0+2
	pei	<L216+name_0
	pei	<L217+libfile_1+2
	pei	<L217+libfile_1
	jsl	~~read_textlib
L10105:
	brl	L222
L216	equ	14
L217	equ	5
	ends
	efunc
	code
	xdef	~~write_text
	func
~~write_text:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L225
	tcs
	phd
	tcd
name_0	set	4
savefile_1	set	0
bp_1	set	4
x_1	set	8
	pea	#^L215
	pea	#<L215
	pei	<L225+name_0+2
	pei	<L225+name_0
	jsl	~~fopen
	sta	<L226+savefile_1
	stx	<L226+savefile_1+2
	lda	<L226+savefile_1
	ora	<L226+savefile_1+2
	beq	L227
	brl	L10106
L227:
	pei	<L225+name_0+2
	pei	<L225+name_0
	pea	#<$76
	pea	#8
	jsl	~~error
L10106:
	lda	|~~basicvars+22
	sta	<L226+bp_1
	lda	|~~basicvars+22+2
	sta	<L226+bp_1+2
L10107:
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L226+bp_1],Y
	cmp	#<$ff
	rep	#$20
	longa	on
	bne	L228
	brl	L10108
L228:
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	pei	<L226+bp_1+2
	pei	<L226+bp_1
	jsl	~~expand
	pei	<L226+savefile_1+2
	pei	<L226+savefile_1
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	jsl	~~fputs
	sta	<L226+x_1
	lda	<L226+x_1
	cmp	#<$ffffffff
	bne	L229
	brl	L10109
L229:
	pei	<L226+savefile_1+2
	pei	<L226+savefile_1
	pea	#<$a
	jsl	~~fputc
	sta	<L226+x_1
L10109:
	lda	<L226+x_1
	cmp	#<$ffffffff
	beq	L230
	brl	L10110
L230:
	pei	<L226+savefile_1+2
	pei	<L226+savefile_1
	jsl	~~fclose
	pei	<L225+name_0+2
	pei	<L225+name_0
	pea	#<$77
	pea	#8
	jsl	~~error
L10110:
	pei	<L226+bp_1+2
	pei	<L226+bp_1
	jsl	~~get_linelen
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L231
	dey
L231:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L226+bp_1
	adc	<R0
	sta	<L226+bp_1
	lda	<L226+bp_1+2
	adc	<R0+2
	sta	<L226+bp_1+2
	brl	L10107
L10108:
	pei	<L226+savefile_1+2
	pei	<L226+savefile_1
	jsl	~~fclose
L232:
	lda	<L225+2
	sta	<L225+2+4
	lda	<L225+1
	sta	<L225+1+4
	pld
	tsc
	clc
	adc	#L225+4
	tcs
	rtl
L225	equ	14
L226	equ	5
	ends
	efunc
	data
L215:
	db	$77,$00
	ends
	code
	xdef	~~edit_line
	func
~~edit_line:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L234
	tcs
	phd
	tcd
	lda	|~~basicvars+437
	bit	#$1
	bne	L236
	brl	L10111
L236:
	pea	#<$7
	pea	#4
	jsl	~~error
L10111:
	jsl	~~clear_refs
	lda	#$4
	trb	~~basicvars+437
	lda	#<~~thisline
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~isempty
	and	#$ff
	bne	L237
	brl	L10112
L237:
	lda	#<~~thisline
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~get_lineno
	pha
	jsl	~~delete_line
	brl	L10113
L10112:
	lda	#<~~thisline
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~insert_line
L10113:
L238:
	pld
	tsc
	clc
	adc	#L234
	tcs
	rtl
L234	equ	4
L235	equ	5
	ends
	efunc
	xref	~~isapath
	xref	~~init_stack
	xref	~~find_line
	xref	~~alignaddr
	xref	~~clear_strings
	xref	~~isempty
	xref	~~reformat
	xref	~~reset_linenums
	xref	~~resolve_linenums
	xref	~~isvalid
	xref	~~clear_linerefs
	xref	~~get_linelen
	xref	~~get_lineno
	xref	~~save_lineno
	xref	~~expand
	xref	~~tokenize
	xref	~~clear_heap
	xref	~~allocmem
	xref	~~clear_varlists
	xref	~~error
	xref	~~isspace
	xref	~~strlen
	xref	~~strcmp
	xref	~~strcat
	xref	~~memcpy
	xref	~~memmove
	xref	~~strcpy
	xref	~~free
	xref	~~malloc
	xref	~~ferror
	xref	~~feof
	xref	~~fclose
	xref	~~fread
	xref	~~fseek
	xref	~~fputs
	xref	~~fputc
	xref	~~fgets
	xref	~~fgetc
	xref	~~fprintf
	xref	~~freopen
	xref	~~fopen
	udata
~~needsnumbers
	ds	1
	ends
	udata
~~last_added
	ds	4
	ends
	xref	~~thisline
	xref	~~basicvars
	xref	~~stderr
	end
