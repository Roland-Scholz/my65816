;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
	code
	func
~~emulate_mos:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
address_0	set	4
areg_1	set	0
xreg_1	set	2
	lda	|~~basicvars+542
	sta	<L3+areg_1
	lda	|~~basicvars+1048
	sta	<L3+xreg_1
	lda	<L2+address_0
	brl	L10001
L10003:
	lda	<L3+areg_1
	beq	L4
	brl	L10004
L4:
	lda	<L3+xreg_1
	bne	L5
	brl	L10004
L5:
	lda	#$800
L6:
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
L10004:
	pea	#<$1
	pea	#4
	jsl	~~error
	brl	L10002
L10005:
	pei	<L3+areg_1
	jsl	~~emulate_vdu
	lda	<L3+areg_1
	brl	L6
L10006:
	pea	#<$1
	pea	#4
	jsl	~~error
	brl	L10002
L10001:
	xref	~~~swt
	jsl	~~~swt
	dw	2
	dw	65518
	dw	L10005-1
	dw	65524
	dw	L10003-1
	dw	L10006-1
L10002:
	lda	#$0
	brl	L6
L2	equ	4
L3	equ	1
	ends
	efunc
	code
	xdef	~~emulate_call
	func
~~emulate_call:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L7
	tcs
	phd
	tcd
address_0	set	4
parmcount_0	set	6
parameters_0	set	8
	lda	<L7+parmcount_0
	beq	L9
	brl	L10007
L9:
	lda	<L7+address_0
	cmp	#<$ffce
	bcs	L10
	brl	L10007
L10:
	lda	#$fff7
	cmp	<L7+address_0
	bcs	L11
	brl	L10007
L11:
	pei	<L7+address_0
	jsl	~~emulate_mos
	brl	L10008
L10007:
	pea	#<$1
	pea	#4
	jsl	~~error
L10008:
L12:
	lda	<L7+2
	sta	<L7+2+8
	lda	<L7+1
	sta	<L7+1+8
	pld
	tsc
	clc
	adc	#L7+8
	tcs
	rtl
L7	equ	0
L8	equ	1
	ends
	efunc
	code
	xdef	~~emulate_usr
	func
~~emulate_usr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L13
	tcs
	phd
	tcd
address_0	set	4
	lda	<L13+address_0
	cmp	#<$ffce
	bcs	L15
	brl	L10009
L15:
	lda	#$fff7
	cmp	<L13+address_0
	bcs	L16
	brl	L10009
L16:
	pei	<L13+address_0
	jsl	~~emulate_mos
L17:
	tay
	lda	<L13+2
	sta	<L13+2+2
	lda	<L13+1
	sta	<L13+1+2
	pld
	tsc
	clc
	adc	#L13+2
	tcs
	tya
	rtl
L10009:
	pea	#<$1
	pea	#4
	jsl	~~error
	lda	#$0
	brl	L17
L13	equ	0
L14	equ	1
	ends
	efunc
	code
	xdef	~~emulate_time
	func
~~emulate_time:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L18
	tcs
	phd
	tcd
rc_1	set	0
tv_1	set	2
tzp_1	set	10
	pea	#0
	clc
	tdc
	adc	#<L19+tzp_1
	pha
	pea	#0
	clc
	tdc
	adc	#<L19+tv_1
	pha
	jsl	~~gettimeofday
	lda	<L19+tv_1
	sta	<R0
	lda	<L19+tv_1+2
	and	#^$ffffff
	sta	<R0+2
	lda	<R0
	sta	<L19+rc_1
	lda	<L19+rc_1
	ldx	#<$64
	xref	~~~mul
	jsl	~~~mul
	sta	<L19+rc_1
	lda	<L19+rc_1
	sta	<R0
	stz	<R0+2
	pea	#^$2710
	pea	#<$2710
	pei	<L19+tv_1+6
	pei	<L19+tv_1+4
	xref	~~~ldiv
	jsl	~~~ldiv
	sta	<R1
	stx	<R1+2
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	lda	<R1+2
	adc	<R0+2
	sta	<R2+2
	lda	<R2
	sta	<L19+rc_1
	lda	<L19+rc_1
	sta	<R0
	stz	<R0+2
	sec
	lda	<R0
	sbc	|~~startime
	sta	<R1
	lda	<R0+2
	sbc	|~~startime+2
	sta	<R1+2
	lda	<R1
	sta	<L19+rc_1
	lda	<L19+rc_1
L20:
	tay
	pld
	tsc
	clc
	adc	#L18
	tcs
	tya
	rtl
L18	equ	26
L19	equ	13
	ends
	efunc
	code
	xdef	~~emulate_setime
	func
~~emulate_setime:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L21
	tcs
	phd
	tcd
time_0	set	4
	ldy	#$0
	lda	<L21+time_0
	bpl	L23
	dey
L23:
	sta	|~~startime
	sty	|~~startime+2
	jsl	~~emulate_time
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L24
	dey
L24:
	sta	|~~startime
	sty	|~~startime+2
L25:
	lda	<L21+2
	sta	<L21+2+2
	lda	<L21+1
	sta	<L21+1+2
	pld
	tsc
	clc
	adc	#L21+2
	tcs
	rtl
L21	equ	4
L22	equ	5
	ends
	efunc
	code
	xdef	~~emulate_setimedol
	func
~~emulate_setimedol:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L26
	tcs
	phd
	tcd
time_0	set	4
L28:
	lda	<L26+2
	sta	<L26+2+4
	lda	<L26+1
	sta	<L26+1+4
	pld
	tsc
	clc
	adc	#L26+4
	tcs
	rtl
L26	equ	0
L27	equ	1
	ends
	efunc
	code
	xdef	~~emulate_mouse_on
	func
~~emulate_mouse_on:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L29
	tcs
	phd
	tcd
pointer_0	set	4
	pea	#<$1
	pea	#4
	jsl	~~error
L31:
	lda	<L29+2
	sta	<L29+2+2
	lda	<L29+1
	sta	<L29+1+2
	pld
	tsc
	clc
	adc	#L29+2
	tcs
	rtl
L29	equ	0
L30	equ	1
	ends
	efunc
	code
	xdef	~~emulate_mouse_off
	func
~~emulate_mouse_off:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L32
	tcs
	phd
	tcd
	pea	#<$1
	pea	#4
	jsl	~~error
L34:
	pld
	tsc
	clc
	adc	#L32
	tcs
	rtl
L32	equ	0
L33	equ	1
	ends
	efunc
	code
	xdef	~~emulate_mouse_to
	func
~~emulate_mouse_to:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L35
	tcs
	phd
	tcd
x_0	set	4
y_0	set	6
	pea	#<$1
	pea	#4
	jsl	~~error
L37:
	lda	<L35+2
	sta	<L35+2+4
	lda	<L35+1
	sta	<L35+1+4
	pld
	tsc
	clc
	adc	#L35+4
	tcs
	rtl
L35	equ	0
L36	equ	1
	ends
	efunc
	code
	xdef	~~emulate_mouse_step
	func
~~emulate_mouse_step:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L38
	tcs
	phd
	tcd
x_0	set	4
y_0	set	6
	pea	#<$1
	pea	#4
	jsl	~~error
L40:
	lda	<L38+2
	sta	<L38+2+4
	lda	<L38+1
	sta	<L38+1+4
	pld
	tsc
	clc
	adc	#L38+4
	tcs
	rtl
L38	equ	0
L39	equ	1
	ends
	efunc
	code
	xdef	~~emulate_mouse_colour
	func
~~emulate_mouse_colour:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L41
	tcs
	phd
	tcd
colour_0	set	4
red_0	set	6
green_0	set	8
blue_0	set	10
	pea	#<$1
	pea	#4
	jsl	~~error
L43:
	lda	<L41+2
	sta	<L41+2+8
	lda	<L41+1
	sta	<L41+1+8
	pld
	tsc
	clc
	adc	#L41+8
	tcs
	rtl
L41	equ	0
L42	equ	1
	ends
	efunc
	code
	xdef	~~emulate_mouse_rectangle
	func
~~emulate_mouse_rectangle:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L44
	tcs
	phd
	tcd
left_0	set	4
bottom_0	set	6
right_0	set	8
top_0	set	10
	pea	#<$1
	pea	#4
	jsl	~~error
L46:
	lda	<L44+2
	sta	<L44+2+8
	lda	<L44+1
	sta	<L44+1+8
	pld
	tsc
	clc
	adc	#L44+8
	tcs
	rtl
L44	equ	0
L45	equ	1
	ends
	efunc
	code
	xdef	~~emulate_mouse
	func
~~emulate_mouse:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L47
	tcs
	phd
	tcd
values_0	set	4
	pea	#<$1
	pea	#4
	jsl	~~error
L49:
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
L47	equ	0
L48	equ	1
	ends
	efunc
	code
	xdef	~~emulate_adval
	func
~~emulate_adval:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L50
	tcs
	phd
	tcd
x_0	set	4
	lda	|~~basicvars+423
	bit	#$800
	bne	L52
	brl	L10010
L52:
	pea	#<$1
	pea	#4
	jsl	~~error
L10010:
	lda	#$0
L53:
	tay
	lda	<L50+2
	sta	<L50+2+2
	lda	<L50+1
	sta	<L50+1+2
	pld
	tsc
	clc
	adc	#L50+2
	tcs
	tya
	rtl
L50	equ	0
L51	equ	1
	ends
	efunc
	code
	xdef	~~emulate_sound_on
	func
~~emulate_sound_on:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L54
	tcs
	phd
	tcd
	lda	|~~basicvars+423
	bit	#$800
	bne	L56
	brl	L10011
L56:
	pea	#<$1
	pea	#4
	jsl	~~error
L10011:
L57:
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
	xdef	~~emulate_sound_off
	func
~~emulate_sound_off:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L58
	tcs
	phd
	tcd
	lda	|~~basicvars+423
	bit	#$800
	bne	L60
	brl	L10012
L60:
	pea	#<$1
	pea	#4
	jsl	~~error
L10012:
L61:
	pld
	tsc
	clc
	adc	#L58
	tcs
	rtl
L58	equ	0
L59	equ	1
	ends
	efunc
	code
	xdef	~~emulate_sound
	func
~~emulate_sound:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L62
	tcs
	phd
	tcd
channel_0	set	4
amplitude_0	set	6
pitch_0	set	8
duration_0	set	10
delay_0	set	12
	lda	|~~basicvars+423
	bit	#$800
	bne	L64
	brl	L10013
L64:
	pea	#<$1
	pea	#4
	jsl	~~error
L10013:
L65:
	lda	<L62+2
	sta	<L62+2+10
	lda	<L62+1
	sta	<L62+1+10
	pld
	tsc
	clc
	adc	#L62+10
	tcs
	rtl
L62	equ	0
L63	equ	1
	ends
	efunc
	code
	xdef	~~emulate_beats
	func
~~emulate_beats:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L66
	tcs
	phd
	tcd
x_0	set	4
	lda	|~~basicvars+423
	bit	#$800
	bne	L68
	brl	L10014
L68:
	pea	#<$1
	pea	#4
	jsl	~~error
L10014:
L69:
	lda	<L66+2
	sta	<L66+2+2
	lda	<L66+1
	sta	<L66+1+2
	pld
	tsc
	clc
	adc	#L66+2
	tcs
	rtl
L66	equ	0
L67	equ	1
	ends
	efunc
	code
	xdef	~~emulate_beatfn
	func
~~emulate_beatfn:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L70
	tcs
	phd
	tcd
	lda	|~~basicvars+423
	bit	#$800
	bne	L72
	brl	L10015
L72:
	pea	#<$1
	pea	#4
	jsl	~~error
L10015:
	lda	#$0
L73:
	tay
	pld
	tsc
	clc
	adc	#L70
	tcs
	tya
	rtl
L70	equ	0
L71	equ	1
	ends
	efunc
	code
	xdef	~~emulate_tempo
	func
~~emulate_tempo:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L74
	tcs
	phd
	tcd
x_0	set	4
	lda	|~~basicvars+423
	bit	#$800
	bne	L76
	brl	L10016
L76:
	pea	#<$1
	pea	#4
	jsl	~~error
L10016:
L77:
	lda	<L74+2
	sta	<L74+2+2
	lda	<L74+1
	sta	<L74+1+2
	pld
	tsc
	clc
	adc	#L74+2
	tcs
	rtl
L74	equ	0
L75	equ	1
	ends
	efunc
	code
	xdef	~~emulate_tempofn
	func
~~emulate_tempofn:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L78
	tcs
	phd
	tcd
	lda	|~~basicvars+423
	bit	#$800
	bne	L80
	brl	L10017
L80:
	pea	#<$1
	pea	#4
	jsl	~~error
L10017:
	lda	#$0
L81:
	tay
	pld
	tsc
	clc
	adc	#L78
	tcs
	tya
	rtl
L78	equ	0
L79	equ	1
	ends
	efunc
	code
	xdef	~~emulate_voice
	func
~~emulate_voice:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L82
	tcs
	phd
	tcd
channel_0	set	4
name_0	set	6
	lda	|~~basicvars+423
	bit	#$800
	bne	L84
	brl	L10018
L84:
	pea	#<$1
	pea	#4
	jsl	~~error
L10018:
L85:
	lda	<L82+2
	sta	<L82+2+6
	lda	<L82+1
	sta	<L82+1+6
	pld
	tsc
	clc
	adc	#L82+6
	tcs
	rtl
L82	equ	0
L83	equ	1
	ends
	efunc
	code
	xdef	~~emulate_voices
	func
~~emulate_voices:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L86
	tcs
	phd
	tcd
count_0	set	4
	lda	|~~basicvars+423
	bit	#$800
	bne	L88
	brl	L10019
L88:
	pea	#<$1
	pea	#4
	jsl	~~error
L10019:
L89:
	lda	<L86+2
	sta	<L86+2+2
	lda	<L86+1
	sta	<L86+1+2
	pld
	tsc
	clc
	adc	#L86+2
	tcs
	rtl
L86	equ	0
L87	equ	1
	ends
	efunc
	code
	xdef	~~emulate_stereo
	func
~~emulate_stereo:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L90
	tcs
	phd
	tcd
channels_0	set	4
position_0	set	6
	lda	|~~basicvars+423
	bit	#$800
	bne	L92
	brl	L10020
L92:
	pea	#<$1
	pea	#4
	jsl	~~error
L10020:
L93:
	lda	<L90+2
	sta	<L90+2+4
	lda	<L90+1
	sta	<L90+1+4
	pld
	tsc
	clc
	adc	#L90+4
	tcs
	rtl
L90	equ	0
L91	equ	1
	ends
	efunc
	code
	xdef	~~emulate_endeq
	func
~~emulate_endeq:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L94
	tcs
	phd
	tcd
newend_0	set	4
	pea	#<$1
	pea	#4
	jsl	~~error
L96:
	lda	<L94+2
	sta	<L94+2+2
	lda	<L94+1
	sta	<L94+1+2
	pld
	tsc
	clc
	adc	#L94+2
	tcs
	rtl
L94	equ	0
L95	equ	1
	ends
	efunc
	code
	xdef	~~emulate_waitdelay
	func
~~emulate_waitdelay:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L97
	tcs
	phd
	tcd
time_0	set	4
delay_1	set	0
	sec
	lda	#$0
	sbc	<L97+time_0
	bvs	L99
	eor	#$8000
L99:
	bmi	L100
	brl	L10021
L100:
L101:
	lda	<L97+2
	sta	<L97+2+2
	lda	<L97+1
	sta	<L97+1+2
	pld
	tsc
	clc
	adc	#L97+2
	tcs
	rtl
L10021:
	lda	<L97+time_0
	ldx	#<$64
	xref	~~~div
	jsl	~~~div
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L102
	dey
L102:
	sta	<L98+delay_1
	sty	<L98+delay_1+2
	lda	<L97+time_0
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
	bpl	L103
	dey
L103:
	sta	<L98+delay_1+4
	sty	<L98+delay_1+6
	brl	L101
L97	equ	12
L98	equ	5
	ends
	efunc
	code
	func
~~emulate_key:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L104
	tcs
	phd
	tcd
command_0	set	4
key_1	set	0
length_1	set	2
quoted_1	set	4
ch_1	set	6
text_1	set	7
	clc
	lda	#$3
	adc	<L104+command_0
	sta	<L104+command_0
	bcc	L106
	inc	<L104+command_0+2
L106:
L10024:
	inc	<L104+command_0
	bne	L107
	inc	<L104+command_0+2
L107:
L10022:
	lda	[<L104+command_0]
	and	#$ff
	pha
	jsl	~~isspace
	tax
	beq	L108
	brl	L10024
L108:
L10023:
	lda	[<L104+command_0]
	and	#$ff
	pha
	jsl	~~isdigit
	tax
	beq	L109
	brl	L10025
L109:
	pea	#^L1
	pea	#<L1
	pea	#<$92
	pea	#8
	jsl	~~error
L10025:
	stz	<L105+length_1
	stz	<L105+key_1
L10028:
	lda	[<L104+command_0]
	and	#$ff
	sta	<R0
	lda	<L105+key_1
	asl	A
	asl	A
	adc	<L105+key_1
	asl	A
	sta	<R1
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	clc
	lda	#$ffd0
	adc	<R2
	sta	<L105+key_1
	sec
	lda	#$f
	sbc	<L105+key_1
	bvs	L110
	eor	#$8000
L110:
	bpl	L111
	brl	L10029
L111:
	pea	#^L1+22
	pea	#<L1+22
	pea	#<$92
	pea	#8
	jsl	~~error
L10029:
	inc	<L104+command_0
	bne	L112
	inc	<L104+command_0+2
L112:
L10026:
	lda	[<L104+command_0]
	and	#$ff
	pha
	jsl	~~isdigit
	tax
	beq	L113
	brl	L10028
L113:
L10027:
L10030:
	lda	[<L104+command_0]
	and	#$ff
	pha
	jsl	~~isspace
	tax
	bne	L114
	brl	L10031
L114:
	inc	<L104+command_0
	bne	L115
	inc	<L104+command_0+2
L115:
	brl	L10030
L10031:
	lda	[<L104+command_0]
	and	#$ff
	beq	L116
	brl	L10032
L116:
	pea	#^L1+58
	pea	#<L1+58
	pea	#<$92
	pea	#8
	jsl	~~error
L10032:
	stz	<R0
	sep	#$20
	longa	off
	lda	[<L104+command_0]
	cmp	#<$22
	rep	#$20
	longa	on
	beq	L118
	brl	L117
L118:
	inc	<R0
L117:
	lda	<R0
	sta	<L105+quoted_1
	lda	<L105+quoted_1
	bne	L119
	brl	L10033
L119:
	inc	<L104+command_0
	bne	L120
	inc	<L104+command_0+2
L120:
L10033:
L10034:
	sec
	lda	<L105+length_1
	sbc	#<$ff
	bvs	L121
	eor	#$8000
L121:
	bpl	L122
	brl	L10035
L122:
	sep	#$20
	longa	off
	lda	[<L104+command_0]
	sta	<L105+ch_1
	rep	#$20
	longa	on
	lda	<L105+quoted_1
	bne	L124
	brl	L123
L124:
	sep	#$20
	longa	off
	lda	<L105+ch_1
	cmp	#<$22
	rep	#$20
	longa	on
	bne	L125
	brl	L10035
L125:
L123:
	lda	<L105+ch_1
	and	#$ff
	bne	L126
	brl	L10035
L126:
	inc	<L104+command_0
	bne	L127
	inc	<L104+command_0+2
L127:
	sep	#$20
	longa	off
	lda	<L105+ch_1
	cmp	#<$7c
	rep	#$20
	longa	on
	bne	L129
	brl	L128
L129:
	sep	#$20
	longa	off
	lda	<L105+ch_1
	cmp	#<$dd
	rep	#$20
	longa	on
	beq	L130
	brl	L10036
L130:
L128:
	sep	#$20
	longa	off
	lda	[<L104+command_0]
	sta	<L105+ch_1
	rep	#$20
	longa	on
	inc	<L104+command_0
	bne	L131
	inc	<L104+command_0+2
L131:
	lda	<L105+ch_1
	and	#$ff
	beq	L132
	brl	L10037
L132:
	pea	#^L1+80
	pea	#<L1+80
	pea	#<$92
	pea	#8
	jsl	~~error
L10037:
	lda	<L105+ch_1
	and	#$ff
	pha
	jsl	~~isalpha
	tax
	beq	L134
	brl	L133
L134:
	sep	#$20
	longa	off
	lda	<L105+ch_1
	cmp	#<$40
	rep	#$20
	longa	on
	beq	L135
	brl	L10038
L135:
L133:
	lda	<L105+ch_1
	and	#$ff
	pha
	jsl	~~toupper
	sta	<R0
	clc
	lda	#$ffc0
	adc	<R0
	sta	<R1
	sep	#$20
	longa	off
	lda	<R1
	sta	<L105+ch_1
	rep	#$20
	longa	on
L10038:
L10036:
	sep	#$20
	longa	off
	lda	<L105+ch_1
	ldx	<L105+length_1
	sta	<L105+text_1,X
	rep	#$20
	longa	on
	inc	<L105+length_1
	brl	L10034
L10035:
	sep	#$20
	longa	off
	lda	#$0
	ldx	<L105+length_1
	sta	<L105+text_1,X
	rep	#$20
	longa	on
	pei	<L105+length_1
	pea	#0
	clc
	tdc
	adc	#<L105+text_1
	pha
	pei	<L105+key_1
	jsl	~~set_fn_string
L136:
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
L104	equ	219
L105	equ	13
	ends
	efunc
	data
L1:
	db	$4B,$65,$79,$20,$6E,$75,$6D,$62,$65,$72,$20,$69,$73,$20,$6D
	db	$69,$73,$73,$69,$6E,$67,$00,$4B,$65,$79,$20,$6E,$75,$6D,$62
	db	$65,$72,$20,$69,$73,$20,$6F,$75,$74,$73,$69,$64,$65,$20,$72
	db	$61,$6E,$67,$65,$20,$30,$20,$74,$6F,$20,$31,$35,$00,$4B,$65
	db	$79,$20,$73,$74,$72,$69,$6E,$67,$20,$69,$73,$20,$6D,$69,$73
	db	$73,$69,$6E,$67,$00,$43,$68,$61,$72,$61,$63,$74,$65,$72,$20
	db	$6D,$69,$73,$73,$69,$6E,$67,$20,$61,$66,$74,$65,$72,$20,$27
	db	$7C,$27,$20,$69,$6E,$20,$6B,$65,$79,$20,$73,$74,$72,$69,$6E
	db	$67,$00
	ends
	code
	func
~~check_command:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L138
	tcs
	phd
	tcd
text_0	set	4
command_1	set	0
length_1	set	12
	lda	[<L138+text_0]
	and	#$ff
	beq	L140
	brl	L10039
L140:
	lda	#$0
L141:
	tay
	lda	<L138+2
	sta	<L138+2+4
	lda	<L138+1
	sta	<L138+1+4
	pld
	tsc
	clc
	adc	#L138+4
	tcs
	tya
	rtl
L10039:
	stz	<L139+length_1
L10040:
	sec
	lda	<L139+length_1
	sbc	#<$a
	bvs	L142
	eor	#$8000
L142:
	bpl	L143
	brl	L10041
L143:
	lda	[<L138+text_0]
	and	#$ff
	pha
	jsl	~~isalnum
	tax
	bne	L144
	brl	L10041
L144:
	lda	[<L138+text_0]
	and	#$ff
	pha
	jsl	~~tolower
	sep	#$20
	longa	off
	ldx	<L139+length_1
	sta	<L139+command_1,X
	rep	#$20
	longa	on
	inc	<L139+length_1
	inc	<L138+text_0
	bne	L145
	inc	<L138+text_0+2
L145:
	brl	L10040
L10041:
	sep	#$20
	longa	off
	lda	#$0
	ldx	<L139+length_1
	sta	<L139+command_1,X
	rep	#$20
	longa	on
	pea	#^L137
	pea	#<L137
	pea	#0
	clc
	tdc
	adc	#<L139+command_1
	pha
	jsl	~~strcmp
	tax
	beq	L146
	brl	L10042
L146:
	lda	#$1
	brl	L141
L10042:
	lda	#$0
	brl	L141
L138	equ	14
L139	equ	1
	ends
	efunc
	data
L137:
	db	$6B,$65,$79,$00
	ends
	code
	xdef	~~emulate_oscli
	func
~~emulate_oscli:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L148
	tcs
	phd
	tcd
command_0	set	4
respfile_0	set	8
cmd_1	set	0
L10043:
	sep	#$20
	longa	off
	lda	[<L148+command_0]
	cmp	#<$20
	rep	#$20
	longa	on
	bne	L151
	brl	L150
L151:
	sep	#$20
	longa	off
	lda	[<L148+command_0]
	cmp	#<$2a
	rep	#$20
	longa	on
	beq	L152
	brl	L10044
L152:
L150:
	inc	<L148+command_0
	bne	L153
	inc	<L148+command_0+2
L153:
	brl	L10043
L10044:
	lda	|~~basicvars+423
	bit	#$1000
	beq	L154
	brl	L10045
L154:
	pei	<L148+command_0+2
	pei	<L148+command_0
	jsl	~~check_command
	sta	<L149+cmd_1
	lda	<L149+cmd_1
	cmp	#<$1
	beq	L155
	brl	L10046
L155:
	pei	<L148+command_0+2
	pei	<L148+command_0
	jsl	~~emulate_key
L156:
	lda	<L148+2
	sta	<L148+2+8
	lda	<L148+1
	sta	<L148+1+8
	pld
	tsc
	clc
	adc	#L148+8
	tcs
	rtl
L10046:
L10045:
	lda	<L148+respfile_0
	ora	<L148+respfile_0+2
	beq	L157
	brl	L10047
L157:
	lda	|~~stdout+2
	pha
	lda	|~~stdout
	pha
	jsl	~~fflush
	lda	|~~stderr+2
	pha
	lda	|~~stderr
	pha
	jsl	~~fflush
	pei	<L148+command_0+2
	pei	<L148+command_0
	jsl	~~system
	sta	|~~basicvars+490
	jsl	~~find_cursor
	lda	|~~basicvars+490
	bmi	L158
	brl	L10048
L158:
	pea	#<$7b
	pea	#4
	jsl	~~error
L10048:
	brl	L10049
L10047:
	pea	#^L147
	pea	#<L147
	pei	<L148+command_0+2
	pei	<L148+command_0
	jsl	~~strcat
	pei	<L148+respfile_0+2
	pei	<L148+respfile_0
	pei	<L148+command_0+2
	pei	<L148+command_0
	jsl	~~strcat
	pea	#^L147+3
	pea	#<L147+3
	pei	<L148+command_0+2
	pei	<L148+command_0
	jsl	~~strcat
	pei	<L148+command_0+2
	pei	<L148+command_0
	jsl	~~system
	sta	|~~basicvars+490
	jsl	~~find_cursor
	lda	|~~basicvars+490
	bmi	L159
	brl	L10050
L159:
	pei	<L148+respfile_0+2
	pei	<L148+respfile_0
	jsl	~~remove
	pea	#<$7b
	pea	#4
	jsl	~~error
L10050:
L10049:
	brl	L156
L148	equ	2
L149	equ	1
	ends
	efunc
	data
L147:
	db	$20,$3E,$00,$20,$32,$3E,$26,$31,$00
	ends
	code
	xdef	~~emulate_getswino
	func
~~emulate_getswino:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L161
	tcs
	phd
	tcd
name_0	set	4
length_0	set	8
	pea	#<$1
	pea	#4
	jsl	~~error
	lda	#$0
L163:
	tay
	lda	<L161+2
	sta	<L161+2+6
	lda	<L161+1
	sta	<L161+1+6
	pld
	tsc
	clc
	adc	#L161+6
	tcs
	tya
	rtl
L161	equ	0
L162	equ	1
	ends
	efunc
	code
	xdef	~~emulate_sys
	func
~~emulate_sys:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L164
	tcs
	phd
	tcd
swino_0	set	4
inregs_0	set	6
outregs_0	set	10
flags_0	set	14
	pea	#<$1
	pea	#4
	jsl	~~error
L166:
	lda	<L164+2
	sta	<L164+2+14
	lda	<L164+1
	sta	<L164+1+14
	pld
	tsc
	clc
	adc	#L164+14
	tcs
	rtl
L164	equ	0
L165	equ	1
	ends
	efunc
	code
	xdef	~~init_emulation
	func
~~init_emulation:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L167
	tcs
	phd
	tcd
	jsl	~~clock
	pea	#<$0
	jsl	~~emulate_setime
	lda	#$1
L169:
	tay
	pld
	tsc
	clc
	adc	#L167
	tcs
	tya
	rtl
L167	equ	4
L168	equ	5
	ends
	efunc
	code
	xdef	~~end_emulation
	func
~~end_emulation:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L170
	tcs
	phd
	tcd
L172:
	pld
	tsc
	clc
	adc	#L170
	tcs
	rtl
L170	equ	0
L171	equ	1
	ends
	efunc
	xref	~~set_fn_string
	xref	~~find_cursor
	xref	~~emulate_vdu
	xref	~~error
	xref	~~clock
	xref	~~gettimeofday
	xref	~~toupper
	xref	~~tolower
	xref	~~isspace
	xref	~~isdigit
	xref	~~isalpha
	xref	~~isalnum
	xref	~~strcmp
	xref	~~strcat
	xref	~~system
	xref	~~remove
	xref	~~fflush
	udata
~~startime
	ds	4
	ends
	xref	~~basicvars
	xref	~~stderr
	xref	~~stdout
	end
