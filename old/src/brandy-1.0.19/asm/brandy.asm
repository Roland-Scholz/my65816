;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
	code
	xdef	~~main
	func
~~main:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
argc_0	set	4
argv_0	set	6
	jsl	~~init1
	pei	<L2+argv_0+2
	pei	<L2+argv_0
	pei	<L2+argc_0
	jsl	~~check_cmdline
	jsl	~~init2
	jsl	~~run_interpreter
	lda	#$1
L4:
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
L2	equ	0
L3	equ	1
	ends
	efunc
	code
	func
~~add_arg:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L5
	tcs
	phd
	tcd
p_0	set	4
ap_1	set	0
	pea	#^$8
	pea	#<$8
	jsl	~~malloc
	sta	<L6+ap_1
	stx	<L6+ap_1+2
	lda	<L5+p_0
	sta	[<L6+ap_1]
	lda	<L5+p_0+2
	ldy	#$2
	sta	[<L6+ap_1],Y
	lda	#$0
	ldy	#$4
	sta	[<L6+ap_1],Y
	lda	#$0
	ldy	#$6
	sta	[<L6+ap_1],Y
	lda	|~~arglast
	ora	|~~arglast+2
	beq	L7
	brl	L10001
L7:
	lda	<L6+ap_1
	sta	|~~basicvars+1386
	lda	<L6+ap_1+2
	sta	|~~basicvars+1386+2
	brl	L10002
L10001:
	inc	|~~basicvars+492
	lda	|~~arglast
	sta	<R0
	lda	|~~arglast+2
	sta	<R0+2
	lda	<L6+ap_1
	ldy	#$4
	sta	[<R0],Y
	lda	<L6+ap_1+2
	ldy	#$6
	sta	[<R0],Y
L10002:
	lda	<L6+ap_1
	sta	|~~arglast
	lda	<L6+ap_1+2
	sta	|~~arglast+2
L8:
	lda	<L5+2
	sta	<L5+2+4
	lda	<L5+1
	sta	<L5+1+4
	pld
	tsc
	clc
	adc	#L5+4
	tcs
	rtl
L5	equ	8
L6	equ	5
	ends
	efunc
	code
	func
~~init1:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L9
	tcs
	phd
	tcd
	stz	|~~basicvars+415
	stz	|~~basicvars+415+2
	stz	|~~basicvars+490
	lda	#$1
	trb	~~basicvars+429
	lda	#$2
	trb	~~basicvars+429
	lda	#$4
	trb	~~basicvars+429
	lda	#$8
	trb	~~basicvars+429
	lda	#$10
	trb	~~basicvars+429
	lda	#$40
	trb	~~basicvars+429
	lda	#$1
	trb	~~basicvars+435
	lda	#$2
	trb	~~basicvars+435
	lda	#$4
	trb	~~basicvars+435
	lda	#$8
	trb	~~basicvars+435
	lda	#$10
	trb	~~basicvars+435
	lda	#$20
	trb	~~basicvars+435
	lda	#$40
	trb	~~basicvars+435
	lda	#$200
	trb	~~basicvars+423
	lda	#$400
	trb	~~basicvars+423
	lda	#$2
	trb	~~basicvars+423
	lda	#$4
	trb	~~basicvars+423
	lda	#$8
	trb	~~basicvars+423
	lda	#$1000
	trb	~~basicvars+423
	lda	#$800
	tsb	~~basicvars+423
	lda	#$2
	tsb	~~basicvars+437
	lda	#$8
	trb	~~basicvars+437
	stz	|~~basicvars+419
	stz	|~~basicvars+419+2
	stz	|~~basicvars+492
	stz	|~~basicvars+1386
	stz	|~~basicvars+1386+2
	stz	|~~arglast
	stz	|~~arglast+2
	stz	|~~liblast
	stz	|~~liblast+2
	stz	|~~liblist
	stz	|~~liblist+2
	stz	|~~worksize
	pea	#^L1
	pea	#<L1
	jsl	~~add_arg
L11:
	pld
	tsc
	clc
	adc	#L9
	tcs
	rtl
L9	equ	0
L10	equ	1
	ends
	efunc
	data
L1:
	db	$00
	ends
	code
	func
~~init2:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L13
	tcs
	phd
	tcd
	jsl	~~init_heap
	and	#$ff
	bne	L16
	brl	L15
L16:
	lda	|~~worksize
	pha
	jsl	~~init_workspace
	and	#$ff
	beq	L17
	brl	L10003
L17:
L15:
	pea	#<$4
	pea	#4
	jsl	~~cmderror
	pea	#<$1
	jsl	~~exit
L10003:
	jsl	~~init_emulation
	and	#$ff
	bne	L19
	brl	L18
L19:
	jsl	~~init_keyboard
	and	#$ff
	bne	L20
	brl	L18
L20:
	jsl	~~init_screen
	and	#$ff
	beq	L21
	brl	L10004
L21:
L18:
	pea	#<$5
	pea	#4
	jsl	~~cmderror
	pea	#<$1
	jsl	~~exit_interpreter
L10004:
	jsl	~~init_commands
	jsl	~~init_fileio
	jsl	~~clear_program
	stz	|~~basicvars+62
	stz	|~~basicvars+62+2
	lda	#$4
	trb	~~basicvars+437
	jsl	~~init_interpreter
L22:
	pld
	tsc
	clc
	adc	#L13
	tcs
	rtl
L13	equ	0
L14	equ	1
	ends
	efunc
	code
	func
~~check_cmdline:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L23
	tcs
	phd
	tcd
argc_0	set	4
argv_0	set	6
n_1	set	0
optchar_1	set	2
p_1	set	3
	stz	|~~loadfile
	stz	|~~loadfile+2
	lda	#$1
	sta	<L24+n_1
L10005:
	sec
	lda	<L24+n_1
	sbc	<L23+argc_0
	bvs	L25
	eor	#$8000
L25:
	bpl	L26
	brl	L10006
L26:
	ldy	#$0
	lda	<L24+n_1
	bpl	L27
	dey
L27:
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
	lda	<L23+argv_0
	adc	<R0
	sta	<R2
	lda	<L23+argv_0+2
	adc	<R0+2
	sta	<R2+2
	lda	[<R2]
	sta	<L24+p_1
	ldy	#$2
	lda	[<R2],Y
	sta	<L24+p_1+2
	sep	#$20
	longa	off
	lda	[<L24+p_1]
	cmp	#<$2d
	rep	#$20
	longa	on
	beq	L28
	brl	L10007
L28:
	ldy	#$1
	lda	[<L24+p_1],Y
	and	#$ff
	pha
	jsl	~~tolower
	sep	#$20
	longa	off
	sta	<L24+optchar_1
	rep	#$20
	longa	on
	sep	#$20
	longa	off
	lda	<L24+optchar_1
	cmp	#<$67
	rep	#$20
	longa	on
	beq	L29
	brl	L10008
L29:
	lda	#$8
	tsb	~~basicvars+423
	brl	L10009
L10008:
	sep	#$20
	longa	off
	lda	<L24+optchar_1
	cmp	#<$68
	rep	#$20
	longa	on
	beq	L30
	brl	L10010
L30:
	jsl	~~show_help
	brl	L10011
L10010:
	sep	#$20
	longa	off
	lda	<L24+optchar_1
	cmp	#<$63
	rep	#$20
	longa	on
	bne	L32
	brl	L31
L32:
	sep	#$20
	longa	off
	lda	<L24+optchar_1
	cmp	#<$71
	rep	#$20
	longa	on
	bne	L33
	brl	L31
L33:
	sep	#$20
	longa	off
	lda	<L24+optchar_1
	cmp	#<$6c
	rep	#$20
	longa	on
	beq	L34
	brl	L10012
L34:
	ldy	#$2
	lda	[<L24+p_1],Y
	and	#$ff
	pha
	jsl	~~tolower
	sta	<R0
	lda	<R0
	cmp	#<$6f
	beq	L35
	brl	L10012
L35:
L31:
	inc	<L24+n_1
	lda	<L24+n_1
	cmp	<L23+argc_0
	beq	L36
	brl	L10013
L36:
	pei	<L24+p_1+2
	pei	<L24+p_1
	pea	#<$1
	pea	#8
	jsl	~~cmderror
	brl	L10014
L10013:
	lda	|~~loadfile
	ora	|~~loadfile+2
	bne	L37
	brl	L10015
L37:
	pea	#<$3
	pea	#4
	jsl	~~cmderror
	brl	L10016
L10015:
	ldy	#$0
	lda	<L24+n_1
	bpl	L38
	dey
L38:
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
	lda	<L23+argv_0
	adc	<R0
	sta	<R2
	lda	<L23+argv_0+2
	adc	<R0+2
	sta	<R2+2
	lda	[<R2]
	sta	|~~loadfile
	ldy	#$2
	lda	[<R2],Y
	sta	|~~loadfile+2
	sep	#$20
	longa	off
	lda	<L24+optchar_1
	cmp	#<$63
	rep	#$20
	longa	on
	beq	L39
	brl	L10017
L39:
	lda	#$2
	tsb	~~basicvars+423
	brl	L10018
L10017:
	sep	#$20
	longa	off
	lda	<L24+optchar_1
	cmp	#<$71
	rep	#$20
	longa	on
	beq	L40
	brl	L10019
L40:
	lda	#$6
	tsb	|~~basicvars+423
L10019:
L10018:
L10016:
L10014:
	brl	L10020
L10012:
	sep	#$20
	longa	off
	lda	<L24+optchar_1
	cmp	#<$69
	rep	#$20
	longa	on
	beq	L41
	brl	L10021
L41:
	ldy	#$2
	lda	[<L24+p_1],Y
	and	#$ff
	pha
	jsl	~~tolower
	sta	<R0
	lda	<R0
	cmp	#<$67
	beq	L42
	brl	L10021
L42:
	lda	#$800
	trb	~~basicvars+423
	brl	L10022
L10021:
	sep	#$20
	longa	off
	lda	<L24+optchar_1
	cmp	#<$6c
	rep	#$20
	longa	on
	beq	L43
	brl	L10023
L43:
	ldy	#$2
	lda	[<L24+p_1],Y
	and	#$ff
	pha
	jsl	~~tolower
	sta	<R0
	lda	<R0
	cmp	#<$69
	beq	L44
	brl	L10023
L44:
	inc	<L24+n_1
	lda	<L24+n_1
	cmp	<L23+argc_0
	beq	L45
	brl	L10024
L45:
	pei	<L24+p_1+2
	pei	<L24+p_1
	pea	#<$1
	pea	#8
	jsl	~~cmderror
	brl	L10025
L10024:
p_2	set	7
	pea	#^$8
	pea	#<$8
	jsl	~~malloc
	sta	<L24+p_2
	stx	<L24+p_2+2
	lda	<L24+p_2
	ora	<L24+p_2+2
	beq	L46
	brl	L10026
L46:
	pea	#<$4
	pea	#4
	jsl	~~cmderror
	brl	L10027
L10026:
	ldy	#$0
	lda	<L24+n_1
	bpl	L47
	dey
L47:
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
	lda	<L23+argv_0
	adc	<R0
	sta	<R2
	lda	<L23+argv_0+2
	adc	<R0+2
	sta	<R2+2
	lda	[<R2]
	sta	[<L24+p_2]
	ldy	#$2
	lda	[<R2],Y
	ldy	#$2
	sta	[<L24+p_2],Y
	lda	#$0
	ldy	#$4
	sta	[<L24+p_2],Y
	lda	#$0
	ldy	#$6
	sta	[<L24+p_2],Y
	lda	|~~liblast
	ora	|~~liblast+2
	beq	L48
	brl	L10028
L48:
	lda	<L24+p_2
	sta	|~~liblist
	lda	<L24+p_2+2
	sta	|~~liblist+2
	brl	L10029
L10028:
	lda	|~~liblast
	sta	<R0
	lda	|~~liblast+2
	sta	<R0+2
	lda	<L24+p_2
	ldy	#$4
	sta	[<R0],Y
	lda	<L24+p_2+2
	ldy	#$6
	sta	[<R0],Y
L10029:
	lda	<L24+p_2
	sta	|~~liblast
	lda	<L24+p_2+2
	sta	|~~liblast+2
L10027:
L10025:
	brl	L10030
L10023:
	sep	#$20
	longa	off
	lda	<L24+optchar_1
	cmp	#<$6e
	rep	#$20
	longa	on
	beq	L49
	brl	L10031
L49:
	ldy	#$2
	lda	[<L24+p_1],Y
	and	#$ff
	pha
	jsl	~~tolower
	sta	<R0
	lda	<R0
	cmp	#<$6f
	beq	L50
	brl	L10031
L50:
	lda	#$1000
	tsb	~~basicvars+423
	brl	L10032
L10031:
	sep	#$20
	longa	off
	lda	<L24+optchar_1
	cmp	#<$70
	rep	#$20
	longa	on
	beq	L51
	brl	L10033
L51:
	inc	<L24+n_1
	lda	<L24+n_1
	cmp	<L23+argc_0
	beq	L52
	brl	L10034
L52:
	pei	<L24+p_1+2
	pei	<L24+p_1
	pea	#<$1
	pea	#8
	jsl	~~cmderror
	brl	L10035
L10034:
	lda	|~~basicvars+419
	ora	|~~basicvars+419+2
	bne	L53
	brl	L10036
L53:
	lda	|~~basicvars+419+2
	pha
	lda	|~~basicvars+419
	pha
	jsl	~~free
L10036:
	ldy	#$0
	lda	<L24+n_1
	bpl	L54
	dey
L54:
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
	lda	<L23+argv_0
	adc	<R0
	sta	<R2
	lda	<L23+argv_0+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$2
	lda	[<R2],Y
	pha
	lda	[<R2]
	pha
	jsl	~~strlen
	sta	<R0
	stx	<R0+2
	clc
	lda	#$1
	adc	<R0
	sta	<R2
	lda	#$0
	adc	<R0+2
	sta	<R2+2
	pei	<R2+2
	pei	<R2
	jsl	~~malloc
	sta	|~~basicvars+419
	stx	|~~basicvars+419+2
	lda	|~~basicvars+419
	ora	|~~basicvars+419+2
	beq	L55
	brl	L10037
L55:
	pea	#<$4
	pea	#4
	jsl	~~cmderror
	pea	#<$1
	jsl	~~exit
L10037:
	ldy	#$0
	lda	<L24+n_1
	bpl	L56
	dey
L56:
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
	lda	<L23+argv_0
	adc	<R0
	sta	<R2
	lda	<L23+argv_0+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$2
	lda	[<R2],Y
	pha
	lda	[<R2]
	pha
	lda	|~~basicvars+419+2
	pha
	lda	|~~basicvars+419
	pha
	jsl	~~strcpy
L10035:
	brl	L10038
L10033:
	sep	#$20
	longa	off
	lda	<L24+optchar_1
	cmp	#<$73
	rep	#$20
	longa	on
	beq	L57
	brl	L10039
L57:
	inc	<L24+n_1
	lda	<L24+n_1
	cmp	<L23+argc_0
	beq	L58
	brl	L10040
L58:
	pei	<L24+p_1+2
	pei	<L24+p_1
	pea	#<$2
	pea	#8
	jsl	~~cmderror
	brl	L10041
L10040:
sp_3	set	7
	pea	#<$a
	pea	#0
	clc
	tdc
	adc	#<L24+sp_3
	pha
	ldy	#$0
	lda	<L24+n_1
	bpl	L59
	dey
L59:
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
	lda	<L23+argv_0
	adc	<R0
	sta	<R2
	lda	<L23+argv_0+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$2
	lda	[<R2],Y
	pha
	lda	[<R2]
	pha
	jsl	~~strtol
	sta	|~~worksize
	lda	[<L24+sp_3]
	and	#$ff
	pha
	jsl	~~tolower
	sta	<R0
	lda	<R0
	cmp	#<$6b
	beq	L60
	brl	L10042
L60:
	lda	|~~worksize
	ldx	#<$a
	xref	~~~asl
	jsl	~~~asl
	sta	|~~worksize
	brl	L10043
L10042:
	lda	[<L24+sp_3]
	and	#$ff
	pha
	jsl	~~tolower
	sta	<R0
	lda	<R0
	cmp	#<$6d
	beq	L61
	brl	L10044
L61:
	lda	|~~worksize
	ldx	#<$a
	xref	~~~asl
	jsl	~~~asl
	ldx	#<$a
	xref	~~~asl
	jsl	~~~asl
	sta	|~~worksize
L10044:
L10043:
L10041:
	brl	L10045
L10039:
	sep	#$20
	longa	off
	lda	<L24+optchar_1
	cmp	#<$21
	rep	#$20
	longa	on
	beq	L62
	brl	L10046
L62:
	lda	#$2
	trb	~~basicvars+437
	brl	L10047
L10046:
	ldy	#$0
	lda	<L24+n_1
	bpl	L63
	dey
L63:
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
	lda	<L23+argv_0
	adc	<R0
	sta	<R2
	lda	<L23+argv_0+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$2
	lda	[<R2],Y
	pha
	lda	[<R2]
	pha
	jsl	~~add_arg
L10047:
L10045:
L10038:
L10032:
L10030:
L10022:
L10020:
L10011:
L10009:
	brl	L10048
L10007:
	lda	|~~loadfile
	ora	|~~loadfile+2
	beq	L64
	brl	L10049
L64:
	lda	<L24+p_1
	sta	|~~loadfile
	lda	<L24+p_1+2
	sta	|~~loadfile+2
	lda	#$2
	tsb	~~basicvars+423
	brl	L10050
L10049:
	ldy	#$0
	lda	<L24+n_1
	bpl	L65
	dey
L65:
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
	lda	<L23+argv_0
	adc	<R0
	sta	<R2
	lda	<L23+argv_0+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$2
	lda	[<R2],Y
	pha
	lda	[<R2]
	pha
	jsl	~~add_arg
L10050:
L10048:
	inc	<L24+n_1
	brl	L10005
L10006:
	lda	|~~loadfile
	ora	|~~loadfile+2
	bne	L66
	brl	L10051
L66:
	lda	|~~basicvars+1386
	sta	<R0
	lda	|~~basicvars+1386+2
	sta	<R0+2
	lda	|~~loadfile
	sta	[<R0]
	lda	|~~loadfile+2
	ldy	#$2
	sta	[<R0],Y
L10051:
L67:
	lda	<L23+2
	sta	<L23+2+6
	lda	<L23+1
	sta	<L23+1+6
	pld
	tsc
	clc
	adc	#L23+6
	tcs
	rtl
L23	equ	23
L24	equ	13
	ends
	efunc
	code
	func
~~read_command:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L68
	tcs
	phd
	tcd
ok_1	set	0
	lda	|~~basicvars+423
	bit	#$200
	beq	L70
	brl	L10052
L70:
	pea	#<$3e
	jsl	~~emulate_vdu
L10052:
	pea	#<$400
	lda	#<~~inputline
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~read_line
	sep	#$20
	longa	off
	sta	<L69+ok_1
	rep	#$20
	longa	on
	lda	<L69+ok_1
	and	#$ff
	beq	L71
	brl	L10053
L71:
	pea	#<$0
	jsl	~~exit_interpreter
L10053:
L72:
	pld
	tsc
	clc
	adc	#L68
	tcs
	rtl
L68	equ	5
L69	equ	5
	ends
	efunc
	code
	func
~~interpret_line:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L73
	tcs
	phd
	tcd
	lda	#<~~thisline
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~get_lineno
	sta	<R1
	lda	<R1
	cmp	#<$ffff
	beq	L75
	brl	L10054
L75:
	jsl	~~exec_thisline
	brl	L10055
L10054:
	jsl	~~edit_line
L10055:
L76:
	pld
	tsc
	clc
	adc	#L73
	tcs
	rtl
L73	equ	8
L74	equ	9
	ends
	efunc
	code
	func
~~load_libraries:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L77
	tcs
	phd
	tcd
p_1	set	0
	lda	|~~liblist
	sta	<L78+p_1
	lda	|~~liblist+2
	sta	<L78+p_1+2
L10058:
	pea	#<$0
	ldy	#$2
	lda	[<L78+p_1],Y
	pha
	lda	[<L78+p_1]
	pha
	jsl	~~read_library
	ldy	#$4
	lda	[<L78+p_1],Y
	sta	<R0
	ldy	#$6
	lda	[<L78+p_1],Y
	sta	<R0+2
	lda	<R0
	sta	<L78+p_1
	lda	<R0+2
	sta	<L78+p_1+2
L10056:
	lda	<L78+p_1
	ora	<L78+p_1+2
	beq	L79
	brl	L10058
L79:
L10057:
L80:
	pld
	tsc
	clc
	adc	#L77
	tcs
	rtl
L77	equ	8
L78	equ	5
	ends
	efunc
	code
	func
~~run_interpreter:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L81
	tcs
	phd
	tcd
	pea	#<$0
	lda	#<~~basicvars+74
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~__sigsetjmp
	tax
	beq	L83
	brl	L10059
L83:
	lda	|~~basicvars+423
	bit	#$2
	beq	L84
	brl	L10060
L84:
	lda	|~~basicvars+423
	bit	#$400
	beq	L85
	brl	L10060
L85:
	jsl	~~announce
L10060:
	jsl	~~init_errors
	lda	|~~liblist
	ora	|~~liblist+2
	bne	L86
	brl	L10061
L86:
	jsl	~~load_libraries
L10061:
	lda	|~~loadfile
	ora	|~~loadfile+2
	bne	L87
	brl	L10062
L87:
	lda	|~~loadfile+2
	pha
	lda	|~~loadfile
	pha
	jsl	~~read_basic
	lda	|~~loadfile+2
	pha
	lda	|~~loadfile
	pha
	lda	#<~~basicvars+1354
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~strcpy
	lda	|~~basicvars+423
	bit	#$2
	bne	L88
	brl	L10063
L88:
	lda	|~~basicvars+22+2
	pha
	lda	|~~basicvars+22
	pha
	jsl	~~run_program
L10063:
L10062:
L10059:
L10064:
	jsl	~~read_command
	pea	#<$1
	lda	#<~~thisline
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#<~~inputline
	sta	<R1
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	jsl	~~tokenize
	jsl	~~interpret_line
	brl	L10064
L81	equ	8
L82	equ	9
	ends
	efunc
	code
	xdef	~~exit_interpreter
	func
~~exit_interpreter:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L89
	tcs
	phd
	tcd
retcode_0	set	4
	jsl	~~fileio_shutdown
	jsl	~~end_screen
	jsl	~~end_keyboard
	jsl	~~end_emulation
	jsl	~~restore_handlers
	jsl	~~release_heap
	pei	<L89+retcode_0
	jsl	~~exit
L91:
	lda	<L89+2
	sta	<L89+2+2
	lda	<L89+1
	sta	<L89+1+2
	pld
	tsc
	clc
	adc	#L89+2
	tcs
	rtl
L89	equ	0
L90	equ	1
	ends
	efunc
	xref	~~read_line
	xref	~~end_screen
	xref	~~init_screen
	xref	~~emulate_vdu
	xref	~~end_keyboard
	xref	~~init_keyboard
	xref	~~end_emulation
	xref	~~init_emulation
	xref	~~fileio_shutdown
	xref	~~init_fileio
	xref	~~run_program
	xref	~~exec_thisline
	xref	~~init_interpreter
	xref	~~init_commands
	xref	~~read_library
	xref	~~read_basic
	xref	~~clear_program
	xref	~~edit_line
	xref	~~init_workspace
	xref	~~release_heap
	xref	~~init_heap
	xref	~~announce
	xref	~~show_help
	xref	~~cmderror
	xref	~~restore_handlers
	xref	~~init_errors
	xref	~~get_lineno
	xref	~~tokenize
	xref	~~tolower
	xref	~~__sigsetjmp
	xref	~~strlen
	xref	~~strcpy
	xref	~~exit
	xref	~~strtol
	xref	~~free
	xref	~~malloc
	udata
~~liblast
	ds	4
	ends
	udata
~~liblist
	ds	4
	ends
	udata
~~arglast
	ds	4
	ends
	udata
~~worksize
	ds	2
	ends
	udata
~~loadfile
	ds	4
	ends
	udata
~~inputline
	ds	1024
	ends
	xref	~~thisline
	udata
	xdef	~~basicvars
~~basicvars
	ds	1390
	ends
	end
