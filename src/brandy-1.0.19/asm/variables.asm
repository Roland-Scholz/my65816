;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
	data
	xdef	~~nullstring
~~nullstring:
	dl	L1+0
	ends
	data
L1:
	db	$00
	ends
	code
	func
~~hash:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L3
	tcs
	phd
	tcd
p_0	set	4
hashtotal_1	set	0
	stz	<L4+hashtotal_1
L10001:
	lda	[<L3+p_0]
	and	#$ff
	bne	L5
	brl	L10002
L5:
	lda	<L4+hashtotal_1
	asl	A
	asl	A
	adc	<L4+hashtotal_1
	sta	<R0
	lda	[<L3+p_0]
	and	#$ff
	sta	<R1
	lda	<R1
	eor	<R0
	sta	<L4+hashtotal_1
	inc	<L3+p_0
	bne	L6
	inc	<L3+p_0+2
L6:
	brl	L10001
L10002:
	lda	<L4+hashtotal_1
L7:
	tay
	lda	<L3+2
	sta	<L3+2+4
	lda	<L3+1
	sta	<L3+1+4
	pld
	tsc
	clc
	adc	#L3+4
	tcs
	tya
	rtl
L3	equ	10
L4	equ	9
	ends
	efunc
	code
	xdef	~~clear_varlists
	func
~~clear_varlists:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L8
	tcs
	phd
	tcd
n_1	set	0
lp_1	set	2
	stz	<L9+n_1
L10005:
	lda	<L9+n_1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~basicvars+1098
	adc	<R0
	sta	<R1
	lda	#$0
	sta	(<R1)
	lda	#$0
	ldy	#$2
	sta	(<R1),Y
L10003:
	inc	<L9+n_1
	sec
	lda	<L9+n_1
	sbc	#<$40
	bvs	L10
	eor	#$8000
L10:
	bmi	L11
	brl	L10005
L11:
L10004:
	lda	#$40
	trb	~~basicvars+423
	lda	|~~basicvars+22
	sta	|~~basicvars+498
	lda	|~~basicvars+22+2
	sta	|~~basicvars+498+2
	stz	|~~basicvars+411
	stz	|~~basicvars+411+2
	lda	|~~basicvars+415
	sta	<L9+lp_1
	lda	|~~basicvars+415+2
	sta	<L9+lp_1+2
L10006:
	lda	<L9+lp_1
	ora	<L9+lp_1+2
	bne	L12
	brl	L10007
L12:
	lda	#$0
	ldy	#$e
	sta	[<L9+lp_1],Y
	lda	#$0
	ldy	#$10
	sta	[<L9+lp_1],Y
	stz	<L9+n_1
L10010:
	ldy	#$0
	lda	<L9+n_1
	bpl	L13
	dey
L13:
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
	adc	<L9+lp_1
	sta	<R2
	lda	#$0
	adc	<L9+lp_1+2
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
L10008:
	inc	<L9+n_1
	sec
	lda	<L9+n_1
	sbc	#<$40
	bvs	L14
	eor	#$8000
L14:
	bmi	L15
	brl	L10010
L15:
L10009:
	lda	[<L9+lp_1]
	sta	<R0
	ldy	#$2
	lda	[<L9+lp_1],Y
	sta	<R0+2
	lda	<R0
	sta	<L9+lp_1
	lda	<R0+2
	sta	<L9+lp_1+2
	brl	L10006
L10007:
L16:
	pld
	tsc
	clc
	adc	#L8
	tcs
	rtl
L8	equ	22
L9	equ	17
	ends
	efunc
	code
	func
~~list_varlist:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L17
	tcs
	phd
	tcd
which_0	set	4
lp_0	set	6
vp_1	set	0
temp_1	set	4
done_1	set	132
columns_1	set	134
next_1	set	136
len_1	set	138
n_1	set	140
width_1	set	142
	stz	<L18+done_1
	stz	<L18+columns_1
	lda	|~~basicvars+496
	beq	L20
	brl	L19
L20:
	lda	#$50
	bra	L21
L19:
	lda	|~~basicvars+496
L21:
	sta	<L18+width_1
	stz	<L18+n_1
L10013:
	lda	<L17+lp_0
	ora	<L17+lp_0+2
	beq	L22
	brl	L10014
L22:
	lda	<L18+n_1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~basicvars+1098
	adc	<R0
	sta	<R1
	lda	(<R1)
	sta	<L18+vp_1
	ldy	#$2
	lda	(<R1),Y
	sta	<L18+vp_1+2
	brl	L10015
L10014:
	ldy	#$0
	lda	<L18+n_1
	bpl	L23
	dey
L23:
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
	adc	<L17+lp_0
	sta	<R2
	lda	#$0
	adc	<L17+lp_0+2
	sta	<R2+2
	clc
	lda	<R2
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	lda	[<R3]
	sta	<L18+vp_1
	ldy	#$2
	lda	[<R3],Y
	sta	<L18+vp_1+2
L10015:
L10016:
	lda	<L18+vp_1
	ora	<L18+vp_1+2
	bne	L24
	brl	L10017
L24:
	ldy	#$6
	lda	[<L18+vp_1],Y
	sta	<R0
	ldy	#$8
	lda	[<L18+vp_1],Y
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	<L17+which_0
	rep	#$20
	longa	on
	bne	L26
	brl	L25
L26:
	ldy	#$6
	lda	[<L18+vp_1],Y
	sta	<R0
	ldy	#$8
	lda	[<L18+vp_1],Y
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$cd
	rep	#$20
	longa	on
	bne	L28
	brl	L27
L28:
	ldy	#$6
	lda	[<L18+vp_1],Y
	sta	<R0
	ldy	#$8
	lda	[<L18+vp_1],Y
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$ad
	rep	#$20
	longa	on
	beq	L29
	brl	L10018
L29:
L27:
	ldy	#$6
	lda	[<L18+vp_1],Y
	sta	<R0
	ldy	#$8
	lda	[<L18+vp_1],Y
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<R0],Y
	cmp	<L17+which_0
	rep	#$20
	longa	on
	beq	L30
	brl	L10018
L30:
L25:
	inc	<L18+done_1
	ldy	#$4
	lda	[<L18+vp_1],Y
	brl	L10019
L10021:
	lda	|~~basicvars+435
	bit	#$4
	bne	L31
	brl	L10022
L31:
	ldy	#$10
	lda	[<L18+vp_1],Y
	pha
	ldy	#$8
	lda	[<L18+vp_1],Y
	pha
	ldy	#$6
	lda	[<L18+vp_1],Y
	pha
	pei	<L18+vp_1+2
	pei	<L18+vp_1
	pea	#^L2
	pea	#<L2
	pea	#0
	clc
	tdc
	adc	#<L18+temp_1
	pha
	pea	#20
	jsl	~~sprintf
	sta	<L18+len_1
	brl	L10023
L10022:
	ldy	#$10
	lda	[<L18+vp_1],Y
	pha
	ldy	#$8
	lda	[<L18+vp_1],Y
	pha
	ldy	#$6
	lda	[<L18+vp_1],Y
	pha
	pea	#^L2+12
	pea	#<L2+12
	pea	#0
	clc
	tdc
	adc	#<L18+temp_1
	pha
	pea	#16
	jsl	~~sprintf
	sta	<L18+len_1
L10023:
	brl	L10020
L10024:
	lda	|~~basicvars+435
	bit	#$4
	bne	L32
	brl	L10025
L32:
	ldy	#$12
	lda	[<L18+vp_1],Y
	pha
	ldy	#$10
	lda	[<L18+vp_1],Y
	pha
	xref	~~~ftod
	jsl	~~~ftod
	ldy	#$8
	lda	[<L18+vp_1],Y
	pha
	ldy	#$6
	lda	[<L18+vp_1],Y
	pha
	pei	<L18+vp_1+2
	pei	<L18+vp_1
	pea	#^L2+20
	pea	#<L2+20
	pea	#0
	clc
	tdc
	adc	#<L18+temp_1
	pha
	pea	#26
	jsl	~~sprintf
	sta	<L18+len_1
	brl	L10026
L10025:
	ldy	#$12
	lda	[<L18+vp_1],Y
	pha
	ldy	#$10
	lda	[<L18+vp_1],Y
	pha
	xref	~~~ftod
	jsl	~~~ftod
	ldy	#$8
	lda	[<L18+vp_1],Y
	pha
	ldy	#$6
	lda	[<L18+vp_1],Y
	pha
	pea	#^L2+32
	pea	#<L2+32
	pea	#0
	clc
	tdc
	adc	#<L18+temp_1
	pha
	pea	#22
	jsl	~~sprintf
	sta	<L18+len_1
L10026:
	brl	L10020
L10027:
count_2	set	144
	lda	|~~basicvars+435
	bit	#$4
	bne	L33
	brl	L10028
L33:
	ldy	#$8
	lda	[<L18+vp_1],Y
	pha
	ldy	#$6
	lda	[<L18+vp_1],Y
	pha
	pei	<L18+vp_1+2
	pei	<L18+vp_1
	pea	#^L2+40
	pea	#<L2+40
	pea	#0
	clc
	tdc
	adc	#<L18+temp_1
	pha
	pea	#18
	jsl	~~sprintf
	sta	<L18+len_1
	brl	L10029
L10028:
	ldy	#$8
	lda	[<L18+vp_1],Y
	pha
	ldy	#$6
	lda	[<L18+vp_1],Y
	pha
	pea	#^L2+51
	pea	#<L2+51
	pea	#0
	clc
	tdc
	adc	#<L18+temp_1
	pha
	pea	#14
	jsl	~~sprintf
	sta	<L18+len_1
L10029:
	sec
	lda	#$2d
	ldy	#$10
	sbc	[<L18+vp_1],Y
	bvs	L34
	eor	#$8000
L34:
	bmi	L35
	brl	L10030
L35:
	ldy	#$10
	lda	[<L18+vp_1],Y
	sta	<L18+count_2
	brl	L10031
L10030:
	lda	#$2d
	sta	<L18+count_2
L10031:
	ldy	#$0
	lda	<L18+count_2
	bpl	L36
	dey
L36:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	ldy	#$14
	lda	[<L18+vp_1],Y
	pha
	ldy	#$12
	lda	[<L18+vp_1],Y
	pha
	ldy	#$0
	lda	<L18+len_1
	bpl	L37
	dey
L37:
	sta	<R1
	sty	<R1+2
	clc
	tdc
	adc	#<L18+temp_1
	sta	<R2
	lda	#$0
	sta	<R2+2
	clc
	lda	<R2
	adc	<R1
	sta	<R3
	lda	<R2+2
	adc	<R1+2
	sta	<R3+2
	pei	<R3+2
	pei	<R3
	jsl	~~memmove
	sec
	lda	#$2d
	ldy	#$10
	sbc	[<L18+vp_1],Y
	bvs	L38
	eor	#$8000
L38:
	bmi	L39
	brl	L10032
L39:
	pea	#^L2+58
	pea	#<L2+58
	ldy	#$0
	lda	<L18+count_2
	bpl	L40
	dey
L40:
	sta	<R0
	sty	<R0+2
	ldy	#$0
	lda	<L18+len_1
	bpl	L41
	dey
L41:
	sta	<R1
	sty	<R1+2
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	lda	<R1+2
	adc	<R0+2
	sta	<R2+2
	clc
	tdc
	adc	#<L18+temp_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	clc
	lda	<R0
	adc	<R2
	sta	<R1
	lda	<R0+2
	adc	<R2+2
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	jsl	~~strcpy
	brl	L10033
L10032:
	pea	#^L2+60
	pea	#<L2+60
	ldy	#$0
	lda	<L18+count_2
	bpl	L42
	dey
L42:
	sta	<R0
	sty	<R0+2
	ldy	#$0
	lda	<L18+len_1
	bpl	L43
	dey
L43:
	sta	<R1
	sty	<R1+2
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	lda	<R1+2
	adc	<R0+2
	sta	<R2+2
	clc
	tdc
	adc	#<L18+temp_1
	sta	<R0
	lda	#$0
	sta	<R0+2
	clc
	lda	<R0
	adc	<R2
	sta	<R1
	lda	<R0+2
	adc	<R2+2
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	jsl	~~strcpy
L10033:
	pea	#0
	clc
	tdc
	adc	#<L18+temp_1
	pha
	jsl	~~strlen
	sta	<L18+len_1
	brl	L10020
L10034:
L10035:
L10036:
i_3	set	144
temp2_3	set	146
ap_3	set	166
	lda	|~~basicvars+435
	bit	#$4
	bne	L44
	brl	L10037
L44:
	ldy	#$8
	lda	[<L18+vp_1],Y
	pha
	ldy	#$6
	lda	[<L18+vp_1],Y
	pha
	pei	<L18+vp_1+2
	pei	<L18+vp_1
	pea	#^L2+65
	pea	#<L2+65
	pea	#0
	clc
	tdc
	adc	#<L18+temp_1
	pha
	pea	#18
	jsl	~~sprintf
	sta	<L18+len_1
	brl	L10038
L10037:
	ldy	#$8
	lda	[<L18+vp_1],Y
	pha
	ldy	#$6
	lda	[<L18+vp_1],Y
	pha
	pea	#^L2+72
	pea	#<L2+72
	pea	#0
	clc
	tdc
	adc	#<L18+temp_1
	pha
	pea	#14
	jsl	~~sprintf
	sta	<L18+len_1
L10038:
	ldy	#$10
	lda	[<L18+vp_1],Y
	ldy	#$12
	ora	[<L18+vp_1],Y
	beq	L45
	brl	L10039
L45:
	sep	#$20
	longa	off
	lda	#$29
	ldx	<L18+len_1
	sta	<L18+temp_1,X
	rep	#$20
	longa	on
	lda	<L18+len_1
	ina
	sta	<R0
	sep	#$20
	longa	off
	lda	#$0
	ldx	<R0
	sta	<L18+temp_1,X
	rep	#$20
	longa	on
	brl	L10040
L10039:
	ldy	#$10
	lda	[<L18+vp_1],Y
	sta	<L18+ap_3
	ldy	#$12
	lda	[<L18+vp_1],Y
	sta	<L18+ap_3+2
	stz	<L18+i_3
	brl	L10044
L10043:
	lda	<L18+i_3
	ina
	sta	<R0
	lda	<R0
	cmp	[<L18+ap_3]
	beq	L46
	brl	L10045
L46:
	ldy	#$0
	lda	<L18+i_3
	bpl	L47
	dey
L47:
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
	adc	<L18+ap_3
	sta	<R2
	lda	#$0
	adc	<L18+ap_3+2
	sta	<R2+2
	clc
	lda	<R2
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	clc
	lda	#$ffff
	adc	[<R3]
	pha
	pea	#^L2+75
	pea	#<L2+75
	pea	#0
	clc
	tdc
	adc	#<L18+temp2_3
	pha
	pea	#12
	jsl	~~sprintf
	brl	L10046
L10045:
	ldy	#$0
	lda	<L18+i_3
	bpl	L48
	dey
L48:
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
	adc	<L18+ap_3
	sta	<R2
	lda	#$0
	adc	<L18+ap_3+2
	sta	<R2+2
	clc
	lda	<R2
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	clc
	lda	#$ffff
	adc	[<R3]
	pha
	pea	#^L2+79
	pea	#<L2+79
	pea	#0
	clc
	tdc
	adc	#<L18+temp2_3
	pha
	pea	#12
	jsl	~~sprintf
L10046:
	pea	#0
	clc
	tdc
	adc	#<L18+temp2_3
	pha
	pea	#0
	clc
	tdc
	adc	#<L18+temp_1
	pha
	jsl	~~strcat
L10041:
	inc	<L18+i_3
L10044:
	sec
	lda	<L18+i_3
	sbc	[<L18+ap_3]
	bvs	L49
	eor	#$8000
L49:
	bmi	L50
	brl	L10043
L50:
L10042:
L10040:
	pea	#0
	clc
	tdc
	adc	#<L18+temp_1
	pha
	jsl	~~strlen
	sta	<L18+len_1
	brl	L10020
L10047:
L10048:
fp_4	set	144
p_4	set	148
	ldy	#$4
	lda	[<L18+vp_1],Y
	cmp	#<$20
	beq	L51
	brl	L10049
L51:
	lda	#<L2+83
	sta	<L18+p_4
	lda	#^L2+83
	sta	<L18+p_4+2
	brl	L10050
L10049:
	lda	#<L2+88
	sta	<L18+p_4
	lda	#^L2+88
	sta	<L18+p_4+2
L10050:
	lda	|~~basicvars+435
	bit	#$4
	bne	L52
	brl	L10051
L52:
	clc
	lda	#$1
	ldy	#$6
	adc	[<L18+vp_1],Y
	sta	<R0
	lda	#$0
	ldy	#$8
	adc	[<L18+vp_1],Y
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L18+p_4+2
	pei	<L18+p_4
	pei	<L18+vp_1+2
	pei	<L18+vp_1
	pea	#^L2+91
	pea	#<L2+91
	pea	#0
	clc
	tdc
	adc	#<L18+temp_1
	pha
	pea	#22
	jsl	~~sprintf
	sta	<L18+len_1
	brl	L10052
L10051:
	clc
	lda	#$1
	ldy	#$6
	adc	[<L18+vp_1],Y
	sta	<R0
	lda	#$0
	ldy	#$8
	adc	[<L18+vp_1],Y
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L18+p_4+2
	pei	<L18+p_4
	pea	#^L2+100
	pea	#<L2+100
	pea	#0
	clc
	tdc
	adc	#<L18+temp_1
	pha
	pea	#18
	jsl	~~sprintf
	sta	<L18+len_1
L10052:
	ldy	#$10
	lda	[<L18+vp_1],Y
	sta	<R0
	ldy	#$12
	lda	[<L18+vp_1],Y
	sta	<R0+2
	ldy	#$7
	lda	[<R0],Y
	sta	<L18+fp_4
	ldy	#$9
	lda	[<R0],Y
	sta	<L18+fp_4+2
	lda	<L18+fp_4
	ora	<L18+fp_4+2
	bne	L53
	brl	L10053
L53:
	pea	#^L2+105
	pea	#<L2+105
	pea	#0
	clc
	tdc
	adc	#<L18+temp_1
	pha
	jsl	~~strcat
L10056:
	ldy	#$4
	lda	[<L18+fp_4],Y
	and	#<$200
	bne	L54
	brl	L10057
L54:
	pea	#^L2+107
	pea	#<L2+107
	pea	#0
	clc
	tdc
	adc	#<L18+temp_1
	pha
	jsl	~~strcat
L10057:
	ldy	#$4
	lda	[<L18+fp_4],Y
	and	#<$1f
	brl	L10058
L10060:
L10061:
L10062:
	pea	#^L2+115
	pea	#<L2+115
	pea	#0
	clc
	tdc
	adc	#<L18+temp_1
	pha
	jsl	~~strcat
	brl	L10059
L10063:
L10064:
	pea	#^L2+123
	pea	#<L2+123
	pea	#0
	clc
	tdc
	adc	#<L18+temp_1
	pha
	jsl	~~strcat
	brl	L10059
L10065:
L10066:
	pea	#^L2+128
	pea	#<L2+128
	pea	#0
	clc
	tdc
	adc	#<L18+temp_1
	pha
	jsl	~~strcat
	brl	L10059
L10067:
	pea	#^L2+135
	pea	#<L2+135
	pea	#0
	clc
	tdc
	adc	#<L18+temp_1
	pha
	jsl	~~strcat
	brl	L10059
L10068:
	pea	#^L2+145
	pea	#<L2+145
	pea	#0
	clc
	tdc
	adc	#<L18+temp_1
	pha
	jsl	~~strcat
	brl	L10059
L10069:
	pea	#^L2+152
	pea	#<L2+152
	pea	#0
	clc
	tdc
	adc	#<L18+temp_1
	pha
	jsl	~~strcat
	brl	L10059
L10070:
	pea	#<$82
	pea	#4
	jsl	~~error
	brl	L10059
L10058:
	xref	~~~fsw
	jsl	~~~fsw
	dw	2
	dw	20
	dw	L10070-1
	dw	L10060-1
	dw	L10063-1
	dw	L10065-1
	dw	L10070-1
	dw	L10070-1
	dw	L10070-1
	dw	L10070-1
	dw	L10070-1
	dw	L10067-1
	dw	L10068-1
	dw	L10069-1
	dw	L10070-1
	dw	L10070-1
	dw	L10070-1
	dw	L10070-1
	dw	L10061-1
	dw	L10062-1
	dw	L10064-1
	dw	L10070-1
	dw	L10066-1
L10059:
	lda	[<L18+fp_4]
	sta	<R0
	ldy	#$2
	lda	[<L18+fp_4],Y
	sta	<R0+2
	lda	<R0
	sta	<L18+fp_4
	lda	<R0+2
	sta	<L18+fp_4+2
	lda	<L18+fp_4
	ora	<L18+fp_4+2
	beq	L55
	brl	L10071
L55:
	pea	#^L2+161
	pea	#<L2+161
	pea	#0
	clc
	tdc
	adc	#<L18+temp_1
	pha
	jsl	~~strcat
	brl	L10072
L10071:
	pea	#^L2+163
	pea	#<L2+163
	pea	#0
	clc
	tdc
	adc	#<L18+temp_1
	pha
	jsl	~~strcat
L10072:
L10054:
	lda	<L18+fp_4
	ora	<L18+fp_4+2
	beq	L56
	brl	L10056
L56:
L10055:
L10053:
	pea	#0
	clc
	tdc
	adc	#<L18+temp_1
	pha
	jsl	~~strlen
	sta	<L18+len_1
	brl	L10020
L10073:
p_5	set	144
	ldy	#$6
	lda	[<L18+vp_1],Y
	sta	<R0
	ldy	#$8
	lda	[<L18+vp_1],Y
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$cd
	rep	#$20
	longa	on
	beq	L57
	brl	L10074
L57:
	lda	#<L2+165
	sta	<L18+p_5
	lda	#^L2+165
	sta	<L18+p_5+2
	brl	L10075
L10074:
	lda	#<L2+170
	sta	<L18+p_5
	lda	#^L2+170
	sta	<L18+p_5+2
L10075:
	lda	|~~basicvars+435
	bit	#$4
	bne	L58
	brl	L10076
L58:
	clc
	lda	#$1
	ldy	#$6
	adc	[<L18+vp_1],Y
	sta	<R0
	lda	#$0
	ldy	#$8
	adc	[<L18+vp_1],Y
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L18+p_5+2
	pei	<L18+p_5
	ldy	#$12
	lda	[<L18+vp_1],Y
	pha
	ldy	#$10
	lda	[<L18+vp_1],Y
	pha
	jsl	~~find_linestart
	sta	<R1
	stx	<R1+2
	phx
	pha
	jsl	~~get_lineno
	pha
	pei	<L18+vp_1+2
	pei	<L18+vp_1
	pea	#^L2+173
	pea	#<L2+173
	pea	#0
	clc
	tdc
	adc	#<L18+temp_1
	pha
	pea	#24
	jsl	~~sprintf
	sta	<L18+len_1
	brl	L10077
L10076:
	clc
	lda	#$1
	ldy	#$6
	adc	[<L18+vp_1],Y
	sta	<R0
	lda	#$0
	ldy	#$8
	adc	[<L18+vp_1],Y
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L18+p_5+2
	pei	<L18+p_5
	ldy	#$12
	lda	[<L18+vp_1],Y
	pha
	ldy	#$10
	lda	[<L18+vp_1],Y
	pha
	jsl	~~find_linestart
	sta	<R1
	stx	<R1+2
	phx
	pha
	jsl	~~get_lineno
	pha
	pea	#^L2+192
	pea	#<L2+192
	pea	#0
	clc
	tdc
	adc	#<L18+temp_1
	pha
	pea	#20
	jsl	~~sprintf
	sta	<L18+len_1
L10077:
	brl	L10020
L10078:
	pea	#<$82
	pea	#4
	jsl	~~error
	brl	L10020
L10019:
	xref	~~~swt
	jsl	~~~swt
	dw	9
	dw	2
	dw	L10021-1
	dw	3
	dw	L10024-1
	dw	4
	dw	L10027-1
	dw	10
	dw	L10034-1
	dw	11
	dw	L10035-1
	dw	12
	dw	L10036-1
	dw	32
	dw	L10047-1
	dw	64
	dw	L10048-1
	dw	128
	dw	L10073-1
	dw	L10078-1
L10020:
	clc
	lda	#$13
	adc	<L18+columns_1
	sta	<R0
	lda	<R0
	ldx	#<$14
	xref	~~~div
	jsl	~~~div
	sta	<R0
	lda	<R0
	ldx	#<$14
	xref	~~~mul
	jsl	~~~mul
	sta	<L18+next_1
	sec
	lda	<L18+next_1
	sbc	<L18+width_1
	bvs	L59
	eor	#$8000
L59:
	bmi	L60
	brl	L10079
L60:
	pea	#0
	clc
	tdc
	adc	#<L18+temp_1
	pha
	pea	#^L2+207
	pea	#<L2+207
	pea	#10
	jsl	~~emulate_printf
	lda	<L18+len_1
	sta	<L18+columns_1
	brl	L10080
L10079:
L10081:
	sec
	lda	<L18+columns_1
	sbc	<L18+next_1
	bvs	L61
	eor	#$8000
L61:
	bpl	L62
	brl	L10082
L62:
	pea	#<$20
	jsl	~~emulate_vdu
	inc	<L18+columns_1
	brl	L10081
L10082:
	pea	#0
	clc
	tdc
	adc	#<L18+temp_1
	pha
	pea	#^L2+212
	pea	#<L2+212
	pea	#10
	jsl	~~emulate_printf
	clc
	lda	<L18+columns_1
	adc	<L18+len_1
	sta	<L18+columns_1
L10080:
L10018:
	lda	[<L18+vp_1]
	sta	<R0
	ldy	#$2
	lda	[<L18+vp_1],Y
	sta	<R0+2
	lda	<R0
	sta	<L18+vp_1
	lda	<R0+2
	sta	<L18+vp_1+2
	brl	L10016
L10017:
L10011:
	inc	<L18+n_1
	sec
	lda	<L18+n_1
	sbc	#<$40
	bvs	L63
	eor	#$8000
L63:
	bmi	L64
	brl	L10013
L64:
L10012:
	lda	<L18+done_1
	bne	L65
	brl	L10083
L65:
	pea	#^L2+215
	pea	#<L2+215
	pea	#6
	jsl	~~emulate_printf
L10083:
L66:
	lda	<L17+2
	sta	<L17+2+6
	lda	<L17+1
	sta	<L17+1+6
	pld
	tsc
	clc
	adc	#L17+6
	tcs
	rtl
L17	equ	186
L18	equ	17
	ends
	efunc
	data
L2:
	db	$25,$70,$20,$20,$25,$73,$20,$3D,$20,$25,$64,$00,$25,$73,$20
	db	$3D,$20,$25,$64,$00,$25,$70,$20,$20,$25,$73,$20,$3D,$20,$25
	db	$67,$00,$25,$73,$20,$3D,$20,$25,$67,$00,$25,$70,$20,$20,$25
	db	$73,$20,$3D,$20,$22,$00,$25,$73,$20,$3D,$20,$22,$00,$22,$00
	db	$2E,$2E,$2E,$22,$00,$25,$70,$20,$20,$25,$73,$00,$25,$73,$00
	db	$25,$64,$29,$00,$25,$64,$2C,$00,$50,$52,$4F,$43,$00,$46,$4E
	db	$00,$25,$70,$20,$20,$25,$73,$25,$73,$00,$25,$73,$25,$73,$00
	db	$28,$00,$52,$45,$54,$55,$52,$4E,$20,$00,$69,$6E,$74,$65,$67
	db	$65,$72,$00,$72,$65,$61,$6C,$00,$73,$74,$72,$69,$6E,$67,$00
	db	$69,$6E,$74,$65,$67,$65,$72,$28,$29,$00,$72,$65,$61,$6C,$28
	db	$29,$00,$73,$74,$72,$69,$6E,$67,$28,$29,$00,$29,$00,$2C,$00
	db	$50,$52,$4F,$43,$00,$46,$4E,$00,$25,$70,$20,$20,$5B,$6C,$69
	db	$6E,$65,$20,$25,$64,$5D,$20,$25,$73,$25,$73,$00,$5B,$6C,$69
	db	$6E,$65,$20,$25,$64,$5D,$20,$25,$73,$25,$73,$00,$0D,$0A,$25
	db	$73,$00,$25,$73,$00,$0D,$0A,$0A,$00
	ends
	code
	func
~~list_entries:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L68
	tcs
	phd
	tcd
lp_0	set	4
n_1	set	0
	sep	#$20
	longa	off
	lda	#$41
	sta	<L69+n_1
	rep	#$20
	longa	on
	brl	L10087
L10086:
	pei	<L68+lp_0+2
	pei	<L68+lp_0
	pei	<L69+n_1
	jsl	~~list_varlist
	pei	<L68+lp_0+2
	pei	<L68+lp_0
	lda	<L69+n_1
	and	#$ff
	pha
	jsl	~~tolower
	pha
	jsl	~~list_varlist
L10084:
	sep	#$20
	longa	off
	inc	<L69+n_1
	rep	#$20
	longa	on
L10087:
	sep	#$20
	longa	off
	lda	#$5a
	cmp	<L69+n_1
	rep	#$20
	longa	on
	bcc	L70
	brl	L10086
L70:
L10085:
	pei	<L68+lp_0+2
	pei	<L68+lp_0
	pea	#<$5f
	jsl	~~list_varlist
	pei	<L68+lp_0+2
	pei	<L68+lp_0
	pea	#<$60
	jsl	~~list_varlist
L71:
	lda	<L68+2
	sta	<L68+2+4
	lda	<L68+1
	sta	<L68+1+4
	pld
	tsc
	clc
	adc	#L68+4
	tcs
	rtl
L68	equ	1
L69	equ	1
	ends
	efunc
	code
	xdef	~~list_variables
	func
~~list_variables:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L72
	tcs
	phd
	tcd
which_0	set	4
n_1	set	0
temp_1	set	1
columns_1	set	41
len_1	set	43
next_1	set	45
width_1	set	47
	lda	|~~basicvars+496
	beq	L75
	brl	L74
L75:
	lda	#$50
	bra	L76
L74:
	lda	|~~basicvars+496
L76:
	sta	<L73+width_1
	sep	#$20
	longa	off
	lda	<L72+which_0
	cmp	#<$20
	rep	#$20
	longa	on
	beq	L77
	brl	L10088
L77:
	pea	#^L67
	pea	#<L67
	pea	#6
	jsl	~~emulate_printf
	stz	<L73+columns_1
	sep	#$20
	longa	off
	lda	#$41
	sta	<L73+n_1
	rep	#$20
	longa	on
	brl	L10092
L10091:
	lda	<L73+n_1
	and	#$ff
	sta	<R0
	lda	<R0
	ldx	#<$16
	xref	~~~mul
	jsl	~~~mul
	sta	<R0
	ldx	<R0
	lda	|~~basicvars+504-1392,X
	pha
	lda	<L73+n_1
	and	#$ff
	pha
	pea	#^L67+28
	pea	#<L67+28
	pea	#0
	clc
	tdc
	adc	#<L73+temp_1
	pha
	pea	#14
	jsl	~~sprintf
	sta	<L73+len_1
	clc
	lda	#$13
	adc	<L73+columns_1
	sta	<R0
	lda	<R0
	ldx	#<$14
	xref	~~~div
	jsl	~~~div
	sta	<R0
	lda	<R0
	ldx	#<$14
	xref	~~~mul
	jsl	~~~mul
	sta	<L73+next_1
	sec
	lda	<L73+next_1
	sbc	<L73+width_1
	bvs	L78
	eor	#$8000
L78:
	bmi	L79
	brl	L10093
L79:
	pea	#0
	clc
	tdc
	adc	#<L73+temp_1
	pha
	pea	#^L67+38
	pea	#<L67+38
	pea	#10
	jsl	~~emulate_printf
	lda	<L73+len_1
	sta	<L73+columns_1
	brl	L10094
L10093:
L10095:
	sec
	lda	<L73+columns_1
	sbc	<L73+next_1
	bvs	L80
	eor	#$8000
L80:
	bpl	L81
	brl	L10096
L81:
	pea	#<$20
	jsl	~~emulate_vdu
	inc	<L73+columns_1
	brl	L10095
L10096:
	pea	#0
	clc
	tdc
	adc	#<L73+temp_1
	pha
	pea	#^L67+43
	pea	#<L67+43
	pea	#10
	jsl	~~emulate_printf
	clc
	lda	<L73+columns_1
	adc	<L73+len_1
	sta	<L73+columns_1
L10094:
L10089:
	sep	#$20
	longa	off
	inc	<L73+n_1
	rep	#$20
	longa	on
L10092:
	sep	#$20
	longa	off
	lda	#$5a
	cmp	<L73+n_1
	rep	#$20
	longa	on
	bcc	L82
	brl	L10091
L82:
L10090:
	pea	#^L67+46
	pea	#<L67+46
	pea	#6
	jsl	~~emulate_printf
	pea	#^$0
	pea	#<$0
	jsl	~~list_entries
	brl	L10097
L10088:
	sep	#$20
	longa	off
	lda	<L72+which_0
	cmp	#<$41
	rep	#$20
	longa	on
	bcs	L83
	brl	L10098
L83:
	sep	#$20
	longa	off
	lda	#$5a
	cmp	<L72+which_0
	rep	#$20
	longa	on
	bcs	L84
	brl	L10098
L84:
	lda	<L72+which_0
	and	#$ff
	sta	<R0
	lda	<R0
	ldx	#<$16
	xref	~~~mul
	jsl	~~~mul
	sta	<R0
	ldx	<R0
	lda	|~~basicvars+504-1392,X
	pha
	lda	<L72+which_0
	and	#$ff
	pha
	pea	#^L67+96
	pea	#<L67+96
	pea	#10
	jsl	~~emulate_printf
L10098:
	pea	#^L67+134
	pea	#<L67+134
	pea	#6
	jsl	~~emulate_printf
	pea	#^$0
	pea	#<$0
	pei	<L72+which_0
	jsl	~~list_varlist
L10097:
L85:
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
L72	equ	53
L73	equ	5
	ends
	efunc
	data
L67:
	db	$53,$74,$61,$74,$69,$63,$20,$69,$6E,$74,$65,$67,$65,$72,$20
	db	$76,$61,$72,$69,$61,$62,$6C,$65,$73,$3A,$0D,$0A,$00,$25,$63
	db	$25,$25,$20,$3D,$20,$25,$64,$00,$0D,$0A,$25,$73,$00,$25,$73
	db	$00,$0D,$0A,$0A,$44,$79,$6E,$61,$6D,$69,$63,$20,$76,$61,$72
	db	$69,$61,$62,$6C,$65,$73,$2C,$20,$70,$72,$6F,$63,$65,$64,$75
	db	$72,$65,$73,$20,$61,$6E,$64,$20,$66,$75,$6E,$63,$74,$69,$6F
	db	$6E,$73,$3A,$0D,$0A,$00,$53,$74,$61,$74,$69,$63,$20,$69,$6E
	db	$74,$65,$67,$65,$72,$20,$76,$61,$72,$69,$61,$62,$6C,$65,$20
	db	$27,$25,$63,$25,$25,$27,$20,$3D,$20,$25,$64,$0D,$0A,$00,$44
	db	$79,$6E,$61,$6D,$69,$63,$20,$76,$61,$72,$69,$61,$62,$6C,$65
	db	$73,$2C,$20,$70,$72,$6F,$63,$65,$64,$75,$72,$65,$73,$20,$61
	db	$6E,$64,$20,$66,$75,$6E,$63,$74,$69,$6F,$6E,$73,$3A,$0D,$0A
	db	$00
	ends
	code
	xdef	~~detail_library
	func
~~detail_library:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L87
	tcs
	phd
	tcd
lp_0	set	4
n_1	set	0
	ldy	#$6
	lda	[<L87+lp_0],Y
	pha
	ldy	#$4
	lda	[<L87+lp_0],Y
	pha
	pea	#^L86
	pea	#<L86
	pea	#10
	jsl	~~emulate_printf
	stz	<L88+n_1
	brl	L10102
L10101:
L10099:
	inc	<L88+n_1
L10102:
	sec
	lda	<L88+n_1
	sbc	#<$40
	bvs	L90
	eor	#$8000
L90:
	bpl	L91
	brl	L89
L91:
	ldy	#$0
	lda	<L88+n_1
	bpl	L92
	dey
L92:
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
	adc	<L87+lp_0
	sta	<R2
	lda	#$0
	adc	<L87+lp_0+2
	sta	<R2+2
	clc
	lda	<R2
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	lda	[<R3]
	ldy	#$2
	ora	[<R3],Y
	bne	L93
	brl	L10101
L93:
L89:
L10100:
	lda	<L88+n_1
	cmp	#<$40
	beq	L94
	brl	L10103
L94:
	ldy	#$6
	lda	[<L87+lp_0],Y
	pha
	ldy	#$4
	lda	[<L87+lp_0],Y
	pha
	pea	#^L86+5
	pea	#<L86+5
	pea	#10
	jsl	~~emulate_printf
	brl	L10104
L10103:
	pea	#^L86+38
	pea	#<L86+38
	pea	#6
	jsl	~~emulate_printf
	pei	<L87+lp_0+2
	pei	<L87+lp_0
	jsl	~~list_entries
L10104:
L95:
	lda	<L87+2
	sta	<L87+2+4
	lda	<L87+1
	sta	<L87+1+4
	pld
	tsc
	clc
	adc	#L87+4
	tcs
	rtl
L87	equ	18
L88	equ	17
	ends
	efunc
	data
L86:
	db	$25,$73,$0D,$0A,$00,$4C,$69,$62,$72,$61,$72,$79,$20,$68,$61
	db	$73,$20,$6E,$6F,$20,$6C,$6F,$63,$61,$6C,$20,$76,$61,$72,$69
	db	$61,$62,$6C,$65,$73,$0D,$0A,$00,$56,$61,$72,$69,$61,$62,$6C
	db	$65,$73,$20,$6C,$6F,$63,$61,$6C,$20,$74,$6F,$20,$6C,$69,$62
	db	$72,$61,$72,$79,$3A,$0D,$0A,$00
	ends
	code
	xdef	~~list_libraries
	func
~~list_libraries:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L97
	tcs
	phd
	tcd
ch_0	set	4
lp_1	set	0
	lda	|~~basicvars+411
	ora	|~~basicvars+411+2
	bne	L99
	brl	L10105
L99:
	pea	#^L96
	pea	#<L96
	pea	#6
	jsl	~~emulate_printf
	lda	|~~basicvars+411
	sta	<L98+lp_1
	lda	|~~basicvars+411+2
	sta	<L98+lp_1+2
	brl	L10109
L10108:
	pei	<L98+lp_1+2
	pei	<L98+lp_1
	jsl	~~detail_library
L10106:
	lda	[<L98+lp_1]
	sta	<R0
	ldy	#$2
	lda	[<L98+lp_1],Y
	sta	<R0+2
	lda	<R0
	sta	<L98+lp_1
	lda	<R0+2
	sta	<L98+lp_1+2
L10109:
	lda	<L98+lp_1
	ora	<L98+lp_1+2
	beq	L100
	brl	L10108
L100:
L10107:
L10105:
	lda	|~~basicvars+415
	ora	|~~basicvars+415+2
	bne	L101
	brl	L10110
L101:
	pea	#^L96+32
	pea	#<L96+32
	pea	#6
	jsl	~~emulate_printf
	lda	|~~basicvars+415
	sta	<L98+lp_1
	lda	|~~basicvars+415+2
	sta	<L98+lp_1+2
	brl	L10114
L10113:
	pei	<L98+lp_1+2
	pei	<L98+lp_1
	jsl	~~detail_library
L10111:
	lda	[<L98+lp_1]
	sta	<R0
	ldy	#$2
	lda	[<L98+lp_1],Y
	sta	<R0+2
	lda	<R0
	sta	<L98+lp_1
	lda	<R0+2
	sta	<L98+lp_1+2
L10114:
	lda	<L98+lp_1
	ora	<L98+lp_1+2
	beq	L102
	brl	L10113
L102:
L10112:
L10110:
L103:
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
L97	equ	8
L98	equ	5
	ends
	efunc
	data
L96:
	db	$0A,$4C,$69,$62,$72,$61,$72,$69,$65,$73,$20,$28,$69,$6E,$20
	db	$73,$65,$61,$72,$63,$68,$20,$6F,$72,$64,$65,$72,$29,$3A,$0D
	db	$0A,$00,$0A,$49,$6E,$73,$74,$61,$6C,$6C,$65,$64,$20,$6C,$69
	db	$62,$72,$61,$72,$69,$65,$73,$20,$28,$69,$6E,$20,$73,$65,$61
	db	$72,$63,$68,$20,$6F,$72,$64,$65,$72,$29,$3A,$0D,$0A,$00
	ends
	code
	xdef	~~define_array
	func
~~define_array:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L105
	tcs
	phd
	tcd
vp_0	set	4
islocal_0	set	8
bounds_1	set	0
n_1	set	20
dimcount_1	set	22
highindex_1	set	24
elemsize_1	set	26
size_1	set	28
ap_1	set	30
	stz	<L106+dimcount_1
	lda	#$1
	sta	<L106+size_1
	ldy	#$4
	lda	[<L105+vp_0],Y
	brl	L10115
L10117:
	lda	#$2
	sta	<L106+elemsize_1
	brl	L10116
L10118:
	lda	#$4
	sta	<L106+elemsize_1
	brl	L10116
L10119:
	lda	#$6
	sta	<L106+elemsize_1
	brl	L10116
L10120:
	pea	#^L104
	pea	#<L104
	pea	#<$173
	pea	#<$82
	pea	#10
	jsl	~~error
	brl	L10116
L10115:
	xref	~~~swt
	jsl	~~~swt
	dw	3
	dw	10
	dw	L10117-1
	dw	11
	dw	L10118-1
	dw	12
	dw	L10119-1
	dw	L10120-1
L10116:
L10123:
	jsl	~~eval_integer
	sta	<L106+highindex_1
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
	bne	L107
	brl	L10124
L107:
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
	bne	L108
	brl	L10124
L108:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$5d
	rep	#$20
	longa	on
	bne	L109
	brl	L10124
L109:
	pea	#<$32
	pea	#4
	jsl	~~error
L10124:
	lda	<L106+highindex_1
	bmi	L110
	brl	L10125
L110:
	ldy	#$8
	lda	[<L105+vp_0],Y
	pha
	ldy	#$6
	lda	[<L105+vp_0],Y
	pha
	pea	#<$19
	pea	#8
	jsl	~~error
L10125:
	inc	<L106+highindex_1
	sec
	lda	#$a
	sbc	<L106+dimcount_1
	bvs	L111
	eor	#$8000
L111:
	bpl	L112
	brl	L10126
L112:
	ldy	#$8
	lda	[<L105+vp_0],Y
	pha
	ldy	#$6
	lda	[<L105+vp_0],Y
	pha
	pea	#<$1a
	pea	#8
	jsl	~~error
L10126:
	ldy	#$0
	lda	<L106+dimcount_1
	bpl	L113
	dey
L113:
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
	tdc
	adc	#<L106+bounds_1
	sta	<R2
	lda	#$0
	sta	<R2+2
	clc
	lda	<R2
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	lda	<L106+highindex_1
	sta	[<R3]
	lda	<L106+size_1
	ldx	<L106+highindex_1
	xref	~~~mul
	jsl	~~~mul
	sta	<L106+size_1
	inc	<L106+dimcount_1
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
	beq	L114
	brl	L10122
L114:
	inc	|~~basicvars+62
	bne	L115
	inc	|~~basicvars+62+2
L115:
L10121:
	brl	L10123
L10122:
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
	bne	L116
	brl	L10127
L116:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$5d
	rep	#$20
	longa	on
	bne	L117
	brl	L10127
L117:
	pea	#<$29
	pea	#4
	jsl	~~error
L10127:
	lda	<L106+dimcount_1
	beq	L118
	brl	L10128
L118:
	pea	#<$5
	pea	#4
	jsl	~~error
L10128:
	inc	|~~basicvars+62
	bne	L119
	inc	|~~basicvars+62+2
L119:
	lda	<L105+islocal_0
	and	#$ff
	bne	L120
	brl	L10129
L120:
	pea	#<$1c
	jsl	~~alloc_stackmem
	sta	<L106+ap_1
	stx	<L106+ap_1+2
	lda	<L106+ap_1
	ora	<L106+ap_1+2
	beq	L121
	brl	L10130
L121:
	ldy	#$8
	lda	[<L105+vp_0],Y
	pha
	ldy	#$6
	lda	[<L105+vp_0],Y
	pha
	pea	#<$17
	pea	#8
	jsl	~~error
L10130:
	ldy	#$4
	lda	[<L105+vp_0],Y
	cmp	#<$c
	beq	L122
	brl	L10131
L122:
	lda	<L106+size_1
	ldx	<L106+elemsize_1
	xref	~~~mul
	jsl	~~~mul
	pha
	jsl	~~alloc_stackstrmem
	sta	<R0
	stx	<R0+2
	lda	<R0
	ldy	#$4
	sta	[<L106+ap_1],Y
	lda	<R0+2
	ldy	#$6
	sta	[<L106+ap_1],Y
	brl	L10132
L10131:
	lda	<L106+size_1
	ldx	<L106+elemsize_1
	xref	~~~mul
	jsl	~~~mul
	pha
	jsl	~~alloc_stackmem
	sta	<R0
	stx	<R0+2
	lda	<R0
	ldy	#$4
	sta	[<L106+ap_1],Y
	lda	<R0+2
	ldy	#$6
	sta	[<L106+ap_1],Y
L10132:
	brl	L10133
L10129:
	pea	#<$1c
	jsl	~~condalloc
	sta	<L106+ap_1
	stx	<L106+ap_1+2
	lda	<L106+ap_1
	ora	<L106+ap_1+2
	beq	L123
	brl	L10134
L123:
	ldy	#$8
	lda	[<L105+vp_0],Y
	pha
	ldy	#$6
	lda	[<L105+vp_0],Y
	pha
	pea	#<$17
	pea	#8
	jsl	~~error
L10134:
	lda	<L106+size_1
	ldx	<L106+elemsize_1
	xref	~~~mul
	jsl	~~~mul
	pha
	jsl	~~condalloc
	sta	<R0
	stx	<R0+2
	lda	<R0
	ldy	#$4
	sta	[<L106+ap_1],Y
	lda	<R0+2
	ldy	#$6
	sta	[<L106+ap_1],Y
L10133:
	ldy	#$4
	lda	[<L106+ap_1],Y
	ldy	#$6
	ora	[<L106+ap_1],Y
	beq	L124
	brl	L10135
L124:
	ldy	#$8
	lda	[<L105+vp_0],Y
	pha
	ldy	#$6
	lda	[<L105+vp_0],Y
	pha
	pea	#<$17
	pea	#8
	jsl	~~error
L10135:
	lda	<L106+dimcount_1
	sta	[<L106+ap_1]
	lda	<L106+size_1
	ldy	#$2
	sta	[<L106+ap_1],Y
	stz	<L106+n_1
	brl	L10139
L10138:
	ldy	#$0
	lda	<L106+n_1
	bpl	L125
	dey
L125:
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
	adc	<L106+ap_1
	sta	<R2
	lda	#$0
	adc	<L106+ap_1+2
	sta	<R2+2
	clc
	lda	<R2
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	ldy	#$0
	lda	<L106+n_1
	bpl	L126
	dey
L126:
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
	tdc
	adc	#<L106+bounds_1
	sta	<17
	lda	#$0
	sta	<17+2
	clc
	lda	<17
	adc	<R0
	sta	<21
	lda	<17+2
	adc	<R0+2
	sta	<21+2
	lda	[<21]
	sta	[<R3]
L10136:
	inc	<L106+n_1
L10139:
	sec
	lda	<L106+n_1
	sbc	<L106+dimcount_1
	bvs	L127
	eor	#$8000
L127:
	bmi	L128
	brl	L10138
L128:
L10137:
	lda	<L106+ap_1
	ldy	#$10
	sta	[<L105+vp_0],Y
	lda	<L106+ap_1+2
	ldy	#$12
	sta	[<L105+vp_0],Y
	ldy	#$4
	lda	[<L105+vp_0],Y
	cmp	#<$a
	beq	L129
	brl	L10140
L129:
	stz	<L106+n_1
	brl	L10144
L10143:
	ldy	#$0
	lda	<L106+n_1
	bpl	L130
	dey
L130:
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
	ldy	#$4
	lda	[<L106+ap_1],Y
	adc	<R0
	sta	<R2
	ldy	#$6
	lda	[<L106+ap_1],Y
	adc	<R0+2
	sta	<R2+2
	lda	#$0
	sta	[<R2]
L10141:
	inc	<L106+n_1
L10144:
	sec
	lda	<L106+n_1
	sbc	<L106+size_1
	bvs	L131
	eor	#$8000
L131:
	bmi	L132
	brl	L10143
L132:
L10142:
	brl	L10145
L10140:
	ldy	#$4
	lda	[<L105+vp_0],Y
	cmp	#<$b
	beq	L133
	brl	L10146
L133:
	stz	<L106+n_1
	brl	L10150
L10149:
	ldy	#$0
	lda	<L106+n_1
	bpl	L134
	dey
L134:
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
	ldy	#$4
	lda	[<L106+ap_1],Y
	adc	<R0
	sta	<R2
	ldy	#$6
	lda	[<L106+ap_1],Y
	adc	<R0+2
	sta	<R2+2
	lda	#$0
	sta	[<R2]
	lda	#$0
	ldy	#$2
	sta	[<R2],Y
L10147:
	inc	<L106+n_1
L10150:
	sec
	lda	<L106+n_1
	sbc	<L106+size_1
	bvs	L135
	eor	#$8000
L135:
	bmi	L136
	brl	L10149
L136:
L10148:
	brl	L10151
L10146:
temp_2	set	34
	stz	<L106+temp_2
	lda	|~~nullstring
	sta	<L106+temp_2+2
	lda	|~~nullstring+2
	sta	<L106+temp_2+4
	stz	<L106+n_1
	brl	L10155
L10154:
	clc
	tdc
	adc	#<L106+temp_2
	sta	<R0
	lda	#$0
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	ldy	#$0
	lda	<L106+n_1
	bpl	L137
	dey
L137:
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
	ldy	#$4
	lda	[<L106+ap_1],Y
	adc	<R0
	sta	<R1
	ldy	#$6
	lda	[<L106+ap_1],Y
	adc	<R0+2
	sta	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$6
	xref	~~~fmov
	jsl	~~~fmov
L10152:
	inc	<L106+n_1
L10155:
	sec
	lda	<L106+n_1
	sbc	<L106+size_1
	bvs	L138
	eor	#$8000
L138:
	bmi	L139
	brl	L10154
L139:
L10153:
L10151:
L10145:
L140:
	lda	<L105+2
	sta	<L105+2+6
	lda	<L105+1
	sta	<L105+1+6
	pld
	tsc
	clc
	adc	#L105+6
	tcs
	rtl
L105	equ	64
L106	equ	25
	ends
	efunc
	data
L104:
	db	$76,$61,$72,$69,$61,$62,$6C,$65,$73,$00
	ends
	code
	xdef	~~create_variable
	func
~~create_variable:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L142
	tcs
	phd
	tcd
varname_0	set	4
namelen_0	set	8
lp_0	set	10
vp_1	set	0
np_1	set	4
hashvalue_1	set	8
	lda	<L142+namelen_0
	ina
	pha
	jsl	~~allocmem
	sta	<L143+np_1
	stx	<L143+np_1+2
	pea	#<$16
	jsl	~~allocmem
	sta	<L143+vp_1
	stx	<L143+vp_1+2
	ldy	#$0
	lda	<L142+namelen_0
	bpl	L144
	dey
L144:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L142+varname_0+2
	pei	<L142+varname_0
	pei	<L143+np_1+2
	pei	<L143+np_1
	jsl	~~memcpy
	clc
	lda	#$ffff
	adc	<L142+namelen_0
	sta	<R0
	sep	#$20
	longa	off
	ldy	<R0
	lda	[<L143+np_1],Y
	cmp	#<$5b
	rep	#$20
	longa	on
	beq	L145
	brl	L10156
L145:
	clc
	lda	#$ffff
	adc	<L142+namelen_0
	sta	<R0
	sep	#$20
	longa	off
	lda	#$28
	ldy	<R0
	sta	[<L143+np_1],Y
	rep	#$20
	longa	on
L10156:
	sep	#$20
	longa	off
	lda	#$0
	ldy	<L142+namelen_0
	sta	[<L143+np_1],Y
	rep	#$20
	longa	on
	pei	<L143+np_1+2
	pei	<L143+np_1
	jsl	~~hash
	sta	<L143+hashvalue_1
	lda	<L143+np_1
	ldy	#$6
	sta	[<L143+vp_1],Y
	lda	<L143+np_1+2
	ldy	#$8
	sta	[<L143+vp_1],Y
	lda	<L143+hashvalue_1
	ldy	#$a
	sta	[<L143+vp_1],Y
	lda	<L142+lp_0
	ldy	#$c
	sta	[<L143+vp_1],Y
	lda	<L142+lp_0+2
	ldy	#$e
	sta	[<L143+vp_1],Y
	lda	<L142+lp_0
	ora	<L142+lp_0+2
	beq	L146
	brl	L10157
L146:
	lda	<L143+hashvalue_1
	and	#<$3f
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~basicvars+1098
	adc	<R0
	sta	<R1
	lda	(<R1)
	sta	[<L143+vp_1]
	ldy	#$2
	lda	(<R1),Y
	ldy	#$2
	sta	[<L143+vp_1],Y
	lda	<L143+hashvalue_1
	and	#<$3f
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~basicvars+1098
	adc	<R0
	sta	<R1
	lda	<L143+vp_1
	sta	(<R1)
	lda	<L143+vp_1+2
	ldy	#$2
	sta	(<R1),Y
	brl	L10158
L10157:
	lda	<L143+hashvalue_1
	and	#<$3f
	sta	<R1
	ldy	#$0
	lda	<R1
	bpl	L147
	dey
L147:
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
	adc	<L142+lp_0
	sta	<R2
	lda	#$0
	adc	<L142+lp_0+2
	sta	<R2+2
	clc
	lda	<R2
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	lda	[<R3]
	sta	[<L143+vp_1]
	ldy	#$2
	lda	[<R3],Y
	ldy	#$2
	sta	[<L143+vp_1],Y
	lda	<L143+hashvalue_1
	and	#<$3f
	sta	<R1
	ldy	#$0
	lda	<R1
	bpl	L148
	dey
L148:
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
	adc	<L142+lp_0
	sta	<R2
	lda	#$0
	adc	<L142+lp_0+2
	sta	<R2+2
	clc
	lda	<R2
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	lda	<L143+vp_1
	sta	[<R3]
	lda	<L143+vp_1+2
	ldy	#$2
	sta	[<R3],Y
L10158:
	lda	#$40
	tsb	~~basicvars+423
	clc
	lda	#$ffff
	adc	<L142+namelen_0
	sta	<R0
	ldy	<R0
	lda	[<L143+np_1],Y
	and	#$ff
	brl	L10159
L10161:
	clc
	lda	#$fffe
	adc	<L142+namelen_0
	sta	<R0
	ldy	<R0
	lda	[<L143+np_1],Y
	and	#$ff
	brl	L10162
L10164:
	lda	#$a
	ldy	#$4
	sta	[<L143+vp_1],Y
	brl	L10163
L10165:
	lda	#$c
	ldy	#$4
	sta	[<L143+vp_1],Y
	brl	L10163
L10166:
	lda	#$b
	ldy	#$4
	sta	[<L143+vp_1],Y
	brl	L10163
L10162:
	xref	~~~swt
	jsl	~~~swt
	dw	2
	dw	36
	dw	L10165-1
	dw	37
	dw	L10164-1
	dw	L10166-1
L10163:
	lda	#$0
	ldy	#$10
	sta	[<L143+vp_1],Y
	lda	#$0
	ldy	#$12
	sta	[<L143+vp_1],Y
	brl	L10160
L10167:
	lda	#$2
	ldy	#$4
	sta	[<L143+vp_1],Y
	lda	#$0
	ldy	#$10
	sta	[<L143+vp_1],Y
	brl	L10160
L10168:
	lda	#$4
	ldy	#$4
	sta	[<L143+vp_1],Y
	lda	#$0
	ldy	#$10
	sta	[<L143+vp_1],Y
	lda	|~~nullstring
	ldy	#$12
	sta	[<L143+vp_1],Y
	lda	|~~nullstring+2
	ldy	#$14
	sta	[<L143+vp_1],Y
	brl	L10160
L10169:
	lda	#$3
	ldy	#$4
	sta	[<L143+vp_1],Y
	lda	#$0
	ldy	#$10
	sta	[<L143+vp_1],Y
	lda	#$0
	ldy	#$12
	sta	[<L143+vp_1],Y
	brl	L10160
L10159:
	xref	~~~swt
	jsl	~~~swt
	dw	3
	dw	36
	dw	L10168-1
	dw	37
	dw	L10167-1
	dw	40
	dw	L10161-1
	dw	L10169-1
L10160:
	ldx	<L143+vp_1+2
	lda	<L143+vp_1
L149:
	tay
	lda	<L142+2
	sta	<L142+2+10
	lda	<L142+1
	sta	<L142+1+10
	pld
	tsc
	clc
	adc	#L142+10
	tcs
	tya
	rtl
L142	equ	26
L143	equ	17
	ends
	efunc
	code
	xdef	~~find_variable
	func
~~find_variable:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L150
	tcs
	phd
	tcd
np_0	set	4
namelen_0	set	8
vp_1	set	0
lp_1	set	4
name_1	set	8
hashvalue_1	set	136
	ldy	#$0
	lda	<L150+namelen_0
	bpl	L152
	dey
L152:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L150+np_0+2
	pei	<L150+np_0
	pea	#0
	clc
	tdc
	adc	#<L151+name_1
	pha
	jsl	~~memcpy
	clc
	lda	#$ffff
	adc	<L150+namelen_0
	sta	<R0
	sep	#$20
	longa	off
	ldx	<R0
	lda	<L151+name_1,X
	cmp	#<$5b
	rep	#$20
	longa	on
	beq	L153
	brl	L10170
L153:
	clc
	lda	#$ffff
	adc	<L150+namelen_0
	sta	<R0
	sep	#$20
	longa	off
	lda	#$28
	ldx	<R0
	sta	<L151+name_1,X
	rep	#$20
	longa	on
L10170:
	sep	#$20
	longa	off
	lda	#$0
	ldx	<L150+namelen_0
	sta	<L151+name_1,X
	rep	#$20
	longa	on
	pea	#0
	clc
	tdc
	adc	#<L151+name_1
	pha
	jsl	~~hash
	sta	<L151+hashvalue_1
	pei	<L150+np_0+2
	pei	<L150+np_0
	jsl	~~find_library
	sta	<L151+lp_1
	stx	<L151+lp_1+2
	lda	<L151+lp_1
	ora	<L151+lp_1+2
	bne	L154
	brl	L10171
L154:
	lda	<L151+hashvalue_1
	and	#<$3f
	sta	<R1
	ldy	#$0
	lda	<R1
	bpl	L155
	dey
L155:
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
	adc	<L151+lp_1
	sta	<R2
	lda	#$0
	adc	<L151+lp_1+2
	sta	<R2+2
	clc
	lda	<R2
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	lda	[<R3]
	sta	<L151+vp_1
	ldy	#$2
	lda	[<R3],Y
	sta	<L151+vp_1+2
L10172:
	lda	<L151+vp_1
	ora	<L151+vp_1+2
	bne	L156
	brl	L10173
L156:
	lda	<L151+hashvalue_1
	ldy	#$a
	cmp	[<L151+vp_1],Y
	beq	L158
	brl	L157
L158:
	ldy	#$8
	lda	[<L151+vp_1],Y
	pha
	ldy	#$6
	lda	[<L151+vp_1],Y
	pha
	pea	#0
	clc
	tdc
	adc	#<L151+name_1
	pha
	jsl	~~strcmp
	tax
	bne	L159
	brl	L10173
L159:
L157:
	lda	[<L151+vp_1]
	sta	<R0
	ldy	#$2
	lda	[<L151+vp_1],Y
	sta	<R0+2
	lda	<R0
	sta	<L151+vp_1
	lda	<R0+2
	sta	<L151+vp_1+2
	brl	L10172
L10173:
	lda	<L151+vp_1
	ora	<L151+vp_1+2
	bne	L160
	brl	L10174
L160:
	ldx	<L151+vp_1+2
	lda	<L151+vp_1
L161:
	tay
	lda	<L150+2
	sta	<L150+2+6
	lda	<L150+1
	sta	<L150+1+6
	pld
	tsc
	clc
	adc	#L150+6
	tcs
	tya
	rtl
L10174:
L10171:
	lda	<L151+hashvalue_1
	and	#<$3f
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~basicvars+1098
	adc	<R0
	sta	<R1
	lda	(<R1)
	sta	<L151+vp_1
	ldy	#$2
	lda	(<R1),Y
	sta	<L151+vp_1+2
L10175:
	lda	<L151+vp_1
	ora	<L151+vp_1+2
	bne	L162
	brl	L10176
L162:
	lda	<L151+hashvalue_1
	ldy	#$a
	cmp	[<L151+vp_1],Y
	beq	L164
	brl	L163
L164:
	ldy	#$8
	lda	[<L151+vp_1],Y
	pha
	ldy	#$6
	lda	[<L151+vp_1],Y
	pha
	pea	#0
	clc
	tdc
	adc	#<L151+name_1
	pha
	jsl	~~strcmp
	tax
	bne	L165
	brl	L10176
L165:
L163:
	lda	[<L151+vp_1]
	sta	<R0
	ldy	#$2
	lda	[<L151+vp_1],Y
	sta	<R0+2
	lda	<R0
	sta	<L151+vp_1
	lda	<R0+2
	sta	<L151+vp_1+2
	brl	L10175
L10176:
	ldx	<L151+vp_1+2
	lda	<L151+vp_1
	brl	L161
L150	equ	154
L151	equ	17
	ends
	efunc
	code
	func
~~scan_parmlist:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L166
	tcs
	phd
	tcd
vp_0	set	4
count_1	set	0
dp_1	set	2
formlist_1	set	6
formlast_1	set	10
fp_1	set	14
what_1	set	18
isreturn_1	set	19
	stz	<L167+count_1
	stz	<L167+formlast_1
	stz	<L167+formlast_1+2
	stz	<L167+formlist_1
	stz	<L167+formlist_1+2
	jsl	~~save_current
	ldy	#$10
	lda	[<L166+vp_0],Y
	sta	|~~basicvars+62
	ldy	#$12
	lda	[<L166+vp_0],Y
	sta	|~~basicvars+62+2
	lda	#$80
	tsb	~~basicvars+423
	ldy	#$6
	lda	[<L166+vp_0],Y
	sta	<R0
	ldy	#$8
	lda	[<L166+vp_0],Y
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	sta	<L167+what_1
	rep	#$20
	longa	on
	clc
	lda	#$5
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L168
	inc	|~~basicvars+62+2
L168:
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
	beq	L169
	brl	L10177
L169:
L10180:
	inc	|~~basicvars+62
	bne	L170
	inc	|~~basicvars+62+2
L170:
	stz	<R0
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	sep	#$20
	longa	off
	lda	[<R1]
	cmp	#<$d5
	rep	#$20
	longa	on
	beq	L172
	brl	L171
L172:
	inc	<R0
L171:
	sep	#$20
	longa	off
	lda	<R0
	sta	<L167+isreturn_1
	rep	#$20
	longa	on
	lda	<L167+isreturn_1
	and	#$ff
	bne	L173
	brl	L10181
L173:
	inc	|~~basicvars+62
	bne	L174
	inc	|~~basicvars+62+2
L174:
L10181:
	pea	#<$a
	jsl	~~allocmem
	sta	<L167+fp_1
	stx	<L167+fp_1+2
	clc
	lda	#$4
	adc	<L167+fp_1
	sta	<R0
	lda	#$0
	adc	<L167+fp_1+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~get_lvalue
	lda	<L167+isreturn_1
	and	#$ff
	bne	L175
	brl	L10182
L175:
	clc
	lda	#$4
	adc	<L167+fp_1
	sta	<R0
	lda	#$0
	adc	<L167+fp_1+2
	sta	<R0+2
	clc
	lda	#$200
	adc	[<R0]
	sta	[<R0]
L10182:
	lda	#$0
	sta	[<L167+fp_1]
	lda	#$0
	ldy	#$2
	sta	[<L167+fp_1],Y
	lda	<L167+formlist_1
	ora	<L167+formlist_1+2
	beq	L176
	brl	L10183
L176:
	lda	<L167+fp_1
	sta	<L167+formlist_1
	lda	<L167+fp_1+2
	sta	<L167+formlist_1+2
	brl	L10184
L10183:
	lda	<L167+fp_1
	sta	[<L167+formlast_1]
	lda	<L167+fp_1+2
	ldy	#$2
	sta	[<L167+formlast_1],Y
L10184:
	lda	<L167+fp_1
	sta	<L167+formlast_1
	lda	<L167+fp_1+2
	sta	<L167+formlast_1+2
	inc	<L167+count_1
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
	beq	L177
	brl	L10179
L177:
L10178:
	brl	L10180
L10179:
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
	brl	L10185
L178:
	pea	#<$32
	pea	#4
	jsl	~~error
L10185:
	inc	|~~basicvars+62
	bne	L179
	inc	|~~basicvars+62+2
L179:
L10177:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$3a
	rep	#$20
	longa	on
	beq	L180
	brl	L10186
L180:
	inc	|~~basicvars+62
	bne	L181
	inc	|~~basicvars+62+2
L181:
L10186:
L10187:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	beq	L182
	brl	L10188
L182:
	inc	|~~basicvars+62
	bne	L183
	inc	|~~basicvars+62+2
L183:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<R0],Y
	cmp	#<$ff
	rep	#$20
	longa	on
	beq	L184
	brl	L10189
L184:
	pea	#<$5
	pea	#4
	jsl	~~error
L10189:
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	ldy	#$5
	lda	[<R1],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L185
	dey
L185:
	sta	<R0
	sty	<R0+2
	lda	|~~basicvars+62
	sta	<R1
	lda	|~~basicvars+62+2
	sta	<R1+2
	ldy	#$4
	lda	[<R1],Y
	and	#$ff
	sta	<R1
	stz	<R1+2
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	lda	<R1+2
	adc	<R0+2
	sta	<R2+2
	clc
	lda	|~~basicvars+62
	adc	<R2
	sta	|~~basicvars+62
	lda	|~~basicvars+62+2
	adc	<R2+2
	sta	|~~basicvars+62+2
	brl	L10187
L10188:
	pea	#<$b
	jsl	~~allocmem
	sta	<L167+dp_1
	stx	<L167+dp_1+2
	lda	|~~basicvars+62
	sta	[<L167+dp_1]
	lda	|~~basicvars+62+2
	ldy	#$2
	sta	[<L167+dp_1],Y
	lda	<L167+count_1
	ldy	#$4
	sta	[<L167+dp_1],Y
	stz	<R0
	lda	<L167+count_1
	cmp	#<$1
	beq	L187
	brl	L186
L187:
	ldy	#$4
	lda	[<L167+formlist_1],Y
	cmp	#<$2
	beq	L188
	brl	L186
L188:
	inc	<R0
L186:
	sep	#$20
	longa	off
	lda	<R0
	ldy	#$6
	sta	[<L167+dp_1],Y
	rep	#$20
	longa	on
	lda	<L167+formlist_1
	ldy	#$7
	sta	[<L167+dp_1],Y
	lda	<L167+formlist_1+2
	ldy	#$9
	sta	[<L167+dp_1],Y
	lda	<L167+dp_1
	ldy	#$10
	sta	[<L166+vp_0],Y
	lda	<L167+dp_1+2
	ldy	#$12
	sta	[<L166+vp_0],Y
	sep	#$20
	longa	off
	lda	<L167+what_1
	cmp	#<$cd
	rep	#$20
	longa	on
	beq	L189
	brl	L10190
L189:
	lda	#$20
	ldy	#$4
	sta	[<L166+vp_0],Y
	brl	L10191
L10190:
	lda	#$40
	ldy	#$4
	sta	[<L166+vp_0],Y
L10191:
	lda	#$80
	trb	~~basicvars+423
	jsl	~~restore_current
L190:
	lda	<L166+2
	sta	<L166+2+4
	lda	<L166+1
	sta	<L166+1+4
	pld
	tsc
	clc
	adc	#L166+4
	tcs
	rtl
L166	equ	32
L167	equ	13
	ends
	efunc
	code
	func
~~add_libvars:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L191
	tcs
	phd
	tcd
tp_0	set	4
lp_0	set	8
ep_1	set	0
base_1	set	4
namelen_1	set	8
vp_1	set	10
	jsl	~~save_current
	lda	<L191+tp_0
	sta	|~~basicvars+62
	lda	<L191+tp_0+2
	sta	|~~basicvars+62+2
	clc
	lda	#$2
	adc	<L191+tp_0
	sta	<L191+tp_0
	bcc	L193
	inc	<L191+tp_0+2
L193:
L10192:
	sep	#$20
	longa	off
	lda	[<L191+tp_0]
	cmp	#<$1
	rep	#$20
	longa	on
	beq	L194
	brl	L10193
L194:
	pei	<L191+tp_0+2
	pei	<L191+tp_0
	jsl	~~get_srcaddr
	sta	<L192+base_1
	stx	<L192+base_1+2
	pei	<L192+base_1+2
	pei	<L192+base_1
	jsl	~~skip_name
	sta	<L192+ep_1
	stx	<L192+ep_1+2
	sec
	lda	<L192+ep_1
	sbc	<L192+base_1
	sta	<R0
	lda	<L192+ep_1+2
	sbc	<L192+base_1+2
	sta	<R0+2
	lda	<R0
	sta	<L192+namelen_1
	pei	<L192+namelen_1
	pei	<L192+base_1+2
	pei	<L192+base_1
	jsl	~~find_variable
	sta	<L192+vp_1
	stx	<L192+vp_1+2
	lda	<L192+vp_1
	ora	<L192+vp_1+2
	bne	L196
	brl	L195
L196:
	ldy	#$c
	lda	[<L192+vp_1],Y
	cmp	<L191+lp_0
	bne	L197
	ldy	#$e
	lda	[<L192+vp_1],Y
	cmp	<L191+lp_0+2
L197:
	bne	L198
	brl	L10194
L198:
L195:
	pei	<L191+lp_0+2
	pei	<L191+lp_0
	pei	<L192+namelen_1
	pei	<L192+base_1+2
	pei	<L192+base_1
	jsl	~~create_variable
	sta	<L192+vp_1
	stx	<L192+vp_1+2
L10194:
	clc
	lda	#$5
	adc	<L191+tp_0
	sta	<L191+tp_0
	bcc	L199
	inc	<L191+tp_0+2
L199:
	ldy	#$4
	lda	[<L192+vp_1],Y
	and	#<$8
	bne	L200
	brl	L10195
L200:
	sep	#$20
	longa	off
	lda	[<L191+tp_0]
	cmp	#<$29
	rep	#$20
	longa	on
	bne	L201
	brl	L10196
L201:
	sep	#$20
	longa	off
	lda	[<L191+tp_0]
	cmp	#<$5d
	rep	#$20
	longa	on
	bne	L202
	brl	L10196
L202:
	pea	#<$29
	pea	#4
	jsl	~~error
L10196:
	inc	<L191+tp_0
	bne	L203
	inc	<L191+tp_0+2
L203:
L10195:
	sep	#$20
	longa	off
	lda	[<L191+tp_0]
	cmp	#<$2c
	rep	#$20
	longa	on
	beq	L204
	brl	L10193
L204:
	inc	<L191+tp_0
	bne	L205
	inc	<L191+tp_0+2
L205:
	brl	L10192
L10193:
	lda	[<L191+tp_0]
	and	#$ff
	bne	L206
	brl	L10197
L206:
	sep	#$20
	longa	off
	lda	[<L191+tp_0]
	cmp	#<$3a
	rep	#$20
	longa	on
	bne	L207
	brl	L10197
L207:
	pea	#<$5
	pea	#4
	jsl	~~error
L10197:
	jsl	~~restore_current
L208:
	lda	<L191+2
	sta	<L191+2+8
	lda	<L191+1
	sta	<L191+1+8
	pld
	tsc
	clc
	adc	#L191+8
	tcs
	rtl
L191	equ	18
L192	equ	5
	ends
	efunc
	code
	func
~~add_libarray:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L209
	tcs
	phd
	tcd
tp_0	set	4
lp_0	set	8
ep_1	set	0
base_1	set	4
namelen_1	set	8
vp_1	set	10
	jsl	~~save_current
	lda	<L209+tp_0
	sta	|~~basicvars+62
	lda	<L209+tp_0+2
	sta	|~~basicvars+62+2
L10200:
	inc	|~~basicvars+62
	bne	L211
	inc	|~~basicvars+62+2
L211:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$1
	rep	#$20
	longa	on
	bne	L212
	brl	L10201
L212:
	pea	#<$5
	pea	#4
	jsl	~~error
L10201:
	lda	|~~basicvars+62+2
	pha
	lda	|~~basicvars+62
	pha
	jsl	~~get_srcaddr
	sta	<L210+base_1
	stx	<L210+base_1+2
	pei	<L210+base_1+2
	pei	<L210+base_1
	jsl	~~skip_name
	sta	<L210+ep_1
	stx	<L210+ep_1+2
	sec
	lda	<L210+ep_1
	sbc	<L210+base_1
	sta	<R0
	lda	<L210+ep_1+2
	sbc	<L210+base_1+2
	sta	<R0+2
	lda	<R0
	sta	<L210+namelen_1
	clc
	lda	#$ffff
	adc	<L210+ep_1
	sta	<R0
	lda	#$ffff
	adc	<L210+ep_1+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$28
	rep	#$20
	longa	on
	bne	L213
	brl	L10202
L213:
	clc
	lda	#$ffff
	adc	<L210+ep_1
	sta	<R0
	lda	#$ffff
	adc	<L210+ep_1+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$5b
	rep	#$20
	longa	on
	bne	L214
	brl	L10202
L214:
	pea	#<$46
	pea	#4
	jsl	~~error
L10202:
	pei	<L210+namelen_1
	pei	<L210+base_1+2
	pei	<L210+base_1
	jsl	~~find_variable
	sta	<L210+vp_1
	stx	<L210+vp_1+2
	lda	<L210+vp_1
	ora	<L210+vp_1+2
	beq	L215
	brl	L10203
L215:
	pei	<L209+lp_0+2
	pei	<L209+lp_0
	pei	<L210+namelen_1
	pei	<L210+base_1+2
	pei	<L210+base_1
	jsl	~~create_variable
	sta	<L210+vp_1
	stx	<L210+vp_1+2
	brl	L10204
L10203:
	ldy	#$c
	lda	[<L210+vp_1],Y
	cmp	<L209+lp_0
	bne	L216
	ldy	#$e
	lda	[<L210+vp_1],Y
	cmp	<L209+lp_0+2
L216:
	bne	L217
	brl	L10205
L217:
	pei	<L209+lp_0+2
	pei	<L209+lp_0
	pei	<L210+namelen_1
	pei	<L210+base_1+2
	pei	<L210+base_1
	jsl	~~create_variable
	sta	<L210+vp_1
	stx	<L210+vp_1+2
	brl	L10206
L10205:
	ldy	#$10
	lda	[<L210+vp_1],Y
	ldy	#$12
	ora	[<L210+vp_1],Y
	bne	L218
	brl	L10207
L218:
	ldy	#$8
	lda	[<L210+vp_1],Y
	pha
	ldy	#$6
	lda	[<L210+vp_1],Y
	pha
	pea	#<$1b
	pea	#8
	jsl	~~error
L10207:
L10206:
L10204:
	clc
	lda	#$5
	adc	|~~basicvars+62
	sta	|~~basicvars+62
	bcc	L219
	inc	|~~basicvars+62+2
L219:
	pea	#<$0
	pei	<L210+vp_1+2
	pei	<L210+vp_1
	jsl	~~define_array
L10198:
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
	bne	L220
	brl	L10200
L220:
L10199:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	bne	L221
	brl	L10208
L221:
	lda	|~~basicvars+62
	sta	<R0
	lda	|~~basicvars+62+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$3a
	rep	#$20
	longa	on
	bne	L222
	brl	L10208
L222:
	pea	#<$5
	pea	#4
	jsl	~~error
L10208:
	jsl	~~restore_current
L223:
	lda	<L209+2
	sta	<L209+2+8
	lda	<L209+1
	sta	<L209+1+8
	pld
	tsc
	clc
	adc	#L209+8
	tcs
	rtl
L209	equ	18
L210	equ	5
	ends
	efunc
	code
	func
~~add_procfn:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L224
	tcs
	phd
	tcd
bp_0	set	4
tp_0	set	8
ep_1	set	0
base_1	set	4
fpp_1	set	8
namelen_1	set	12
pfname_1	set	14
	clc
	lda	#$1
	adc	<L224+tp_0
	sta	<R0
	lda	#$0
	adc	<L224+tp_0+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~get_srcaddr
	sta	<L225+base_1
	stx	<L225+base_1+2
	pei	<L225+base_1+2
	pei	<L225+base_1
	jsl	~~skip_name
	sta	<L225+ep_1
	stx	<L225+ep_1+2
	clc
	lda	#$ffff
	adc	<L225+ep_1
	sta	<R0
	lda	#$ffff
	adc	<L225+ep_1+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$28
	rep	#$20
	longa	on
	beq	L226
	brl	L10209
L226:
	lda	<L225+ep_1
	bne	L227
	dec	<L225+ep_1+2
L227:
	dec	<L225+ep_1
L10209:
	sec
	lda	<L225+ep_1
	sbc	<L225+base_1
	sta	<R0
	lda	<L225+ep_1+2
	sbc	<L225+base_1+2
	sta	<R0+2
	lda	<R0
	sta	<L225+namelen_1
	ldy	#$0
	lda	<L225+namelen_1
	bpl	L228
	dey
L228:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L225+base_1+2
	pei	<L225+base_1
	pea	#0
	clc
	tdc
	adc	#<L225+pfname_1
	pha
	jsl	~~memmove
	sep	#$20
	longa	off
	lda	#$0
	ldx	<L225+namelen_1
	sta	<L225+pfname_1,X
	rep	#$20
	longa	on
	pea	#<$12
	jsl	~~allocmem
	sta	<L225+fpp_1
	stx	<L225+fpp_1+2
	lda	<L224+bp_0
	ldy	#$4
	sta	[<L225+fpp_1],Y
	lda	<L224+bp_0+2
	ldy	#$6
	sta	[<L225+fpp_1],Y
	lda	<L225+base_1
	ldy	#$a
	sta	[<L225+fpp_1],Y
	lda	<L225+base_1+2
	ldy	#$c
	sta	[<L225+fpp_1],Y
	clc
	lda	#$1
	adc	<L224+tp_0
	sta	<R0
	lda	#$0
	adc	<L224+tp_0+2
	sta	<R0+2
	lda	<R0
	ldy	#$e
	sta	[<L225+fpp_1],Y
	lda	<R0+2
	ldy	#$10
	sta	[<L225+fpp_1],Y
	pea	#0
	clc
	tdc
	adc	#<L225+pfname_1
	pha
	jsl	~~hash
	ldy	#$8
	sta	[<L225+fpp_1],Y
	lda	#$0
	sta	[<L225+fpp_1]
	lda	#$0
	ldy	#$2
	sta	[<L225+fpp_1],Y
	ldx	<L225+fpp_1+2
	lda	<L225+fpp_1
L229:
	tay
	lda	<L224+2
	sta	<L224+2+8
	lda	<L224+1
	sta	<L224+1+8
	pld
	tsc
	clc
	adc	#L224+8
	tcs
	tya
	rtl
L224	equ	146
L225	equ	5
	ends
	efunc
	code
	func
~~scan_library:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L230
	tcs
	phd
	tcd
lp_0	set	4
tp_1	set	0
bp_1	set	4
fpp_1	set	8
fpplast_1	set	12
foundproc_1	set	16
	ldy	#$8
	lda	[<L230+lp_0],Y
	sta	<L231+bp_1
	ldy	#$a
	lda	[<L230+lp_0],Y
	sta	<L231+bp_1+2
	stz	<L231+fpplast_1
	stz	<L231+fpplast_1+2
	sep	#$20
	longa	off
	stz	<L231+foundproc_1
	rep	#$20
	longa	on
L10210:
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L231+bp_1],Y
	cmp	#<$ff
	rep	#$20
	longa	on
	bne	L232
	brl	L10211
L232:
	ldy	#$5
	lda	[<L231+bp_1],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L233
	dey
L233:
	sta	<R0
	sty	<R0+2
	ldy	#$4
	lda	[<L231+bp_1],Y
	and	#$ff
	sta	<R1
	stz	<R1+2
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	lda	<R1+2
	adc	<R0+2
	sta	<R2+2
	clc
	lda	<L231+bp_1
	adc	<R2
	sta	<L231+tp_1
	lda	<L231+bp_1+2
	adc	<R2+2
	sta	<L231+tp_1+2
	sep	#$20
	longa	off
	lda	[<L231+tp_1]
	cmp	#<$9a
	rep	#$20
	longa	on
	beq	L234
	brl	L10212
L234:
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L231+tp_1],Y
	cmp	#<$c
	rep	#$20
	longa	on
	beq	L235
	brl	L10212
L235:
	sep	#$20
	longa	off
	lda	#$1
	sta	<L231+foundproc_1
	rep	#$20
	longa	on
	pei	<L231+tp_1+2
	pei	<L231+tp_1
	pei	<L231+bp_1+2
	pei	<L231+bp_1
	jsl	~~add_procfn
	sta	<L231+fpp_1
	stx	<L231+fpp_1+2
	lda	<L231+fpplast_1
	ora	<L231+fpplast_1+2
	beq	L236
	brl	L10213
L236:
	lda	<L231+fpp_1
	ldy	#$e
	sta	[<L230+lp_0],Y
	lda	<L231+fpp_1+2
	ldy	#$10
	sta	[<L230+lp_0],Y
	brl	L10214
L10213:
	lda	<L231+fpp_1
	sta	[<L231+fpplast_1]
	lda	<L231+fpp_1+2
	ldy	#$2
	sta	[<L231+fpplast_1],Y
L10214:
	lda	<L231+fpp_1
	sta	<L231+fpplast_1
	lda	<L231+fpp_1+2
	sta	<L231+fpplast_1+2
	brl	L10215
L10212:
	lda	<L231+foundproc_1
	and	#$ff
	beq	L237
	brl	L10216
L237:
	sep	#$20
	longa	off
	lda	[<L231+tp_1]
	cmp	#<$b7
	rep	#$20
	longa	on
	beq	L238
	brl	L10216
L238:
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L231+tp_1],Y
	cmp	#<$b9
	rep	#$20
	longa	on
	beq	L239
	brl	L10216
L239:
	pei	<L230+lp_0+2
	pei	<L230+lp_0
	pei	<L231+tp_1+2
	pei	<L231+tp_1
	jsl	~~add_libvars
	brl	L10217
L10216:
	lda	<L231+foundproc_1
	and	#$ff
	beq	L240
	brl	L10218
L240:
	sep	#$20
	longa	off
	lda	[<L231+tp_1]
	cmp	#<$9b
	rep	#$20
	longa	on
	beq	L241
	brl	L10218
L241:
	pei	<L230+lp_0+2
	pei	<L230+lp_0
	pei	<L231+tp_1+2
	pei	<L231+tp_1
	jsl	~~add_libarray
L10218:
L10217:
L10215:
	pei	<L231+bp_1+2
	pei	<L231+bp_1
	jsl	~~get_linelen
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L242
	dey
L242:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L231+bp_1
	adc	<R0
	sta	<L231+bp_1
	lda	<L231+bp_1+2
	adc	<R0+2
	sta	<L231+bp_1+2
	brl	L10210
L10211:
L243:
	lda	<L230+2
	sta	<L230+2+4
	lda	<L230+1
	sta	<L230+1+4
	pld
	tsc
	clc
	adc	#L230+4
	tcs
	rtl
L230	equ	29
L231	equ	13
	ends
	efunc
	code
	func
~~search_library:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L244
	tcs
	phd
	tcd
lp_0	set	4
name_0	set	8
hashvalue_1	set	0
namelen_1	set	2
fpp_1	set	4
vp_1	set	8
	ldy	#$e
	lda	[<L244+lp_0],Y
	ldy	#$10
	ora	[<L244+lp_0],Y
	beq	L246
	brl	L10219
L246:
	pei	<L244+lp_0+2
	pei	<L244+lp_0
	jsl	~~scan_library
L10219:
	pei	<L244+name_0+2
	pei	<L244+name_0
	jsl	~~hash
	sta	<L245+hashvalue_1
	pei	<L244+name_0+2
	pei	<L244+name_0
	jsl	~~strlen
	sta	<L245+namelen_1
	ldy	#$e
	lda	[<L244+lp_0],Y
	sta	<L245+fpp_1
	ldy	#$10
	lda	[<L244+lp_0],Y
	sta	<L245+fpp_1+2
	lda	<L245+fpp_1
	ora	<L245+fpp_1+2
	beq	L247
	brl	L10220
L247:
	lda	#$0
	tax
	lda	#$0
L248:
	tay
	lda	<L244+2
	sta	<L244+2+8
	lda	<L244+1
	sta	<L244+1+8
	pld
	tsc
	clc
	adc	#L244+8
	tcs
	tya
	rtl
L10220:
L10223:
	ldy	#$8
	lda	[<L245+fpp_1],Y
	cmp	<L245+hashvalue_1
	beq	L250
	brl	L249
L250:
	ldy	#$0
	lda	<L245+namelen_1
	bpl	L251
	dey
L251:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L244+name_0+2
	pei	<L244+name_0
	ldy	#$c
	lda	[<L245+fpp_1],Y
	pha
	ldy	#$a
	lda	[<L245+fpp_1],Y
	pha
	jsl	~~memcmp
	tax
	bne	L252
	brl	L10222
L252:
L249:
	lda	[<L245+fpp_1]
	sta	<R0
	ldy	#$2
	lda	[<L245+fpp_1],Y
	sta	<R0+2
	lda	<R0
	sta	<L245+fpp_1
	lda	<R0+2
	sta	<L245+fpp_1+2
L10221:
	lda	<L245+fpp_1
	ora	<L245+fpp_1+2
	beq	L253
	brl	L10223
L253:
L10222:
	lda	<L245+fpp_1
	ora	<L245+fpp_1+2
	beq	L254
	brl	L10224
L254:
	lda	#$0
	tax
	lda	#$0
	brl	L248
L10224:
	pea	#<$16
	jsl	~~allocmem
	sta	<L245+vp_1
	stx	<L245+vp_1+2
	lda	<L245+namelen_1
	ina
	pha
	jsl	~~allocmem
	sta	<R0
	stx	<R0+2
	lda	<R0
	ldy	#$6
	sta	[<L245+vp_1],Y
	lda	<R0+2
	ldy	#$8
	sta	[<L245+vp_1],Y
	pei	<L244+name_0+2
	pei	<L244+name_0
	ldy	#$8
	lda	[<L245+vp_1],Y
	pha
	ldy	#$6
	lda	[<L245+vp_1],Y
	pha
	jsl	~~strcpy
	lda	<L245+hashvalue_1
	ldy	#$a
	sta	[<L245+vp_1],Y
	ldy	#$e
	lda	[<L245+fpp_1],Y
	ldy	#$10
	sta	[<L245+vp_1],Y
	ldy	#$10
	lda	[<L245+fpp_1],Y
	ldy	#$12
	sta	[<L245+vp_1],Y
	lda	<L245+hashvalue_1
	and	#<$3f
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~basicvars+1098
	adc	<R0
	sta	<R1
	lda	(<R1)
	sta	[<L245+vp_1]
	ldy	#$2
	lda	(<R1),Y
	ldy	#$2
	sta	[<L245+vp_1],Y
	lda	<L245+hashvalue_1
	and	#<$3f
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~basicvars+1098
	adc	<R0
	sta	<R1
	lda	<L245+vp_1
	sta	(<R1)
	lda	<L245+vp_1+2
	ldy	#$2
	sta	(<R1),Y
	lda	#$40
	tsb	~~basicvars+423
	pei	<L245+vp_1+2
	pei	<L245+vp_1
	jsl	~~scan_parmlist
	ldx	<L245+vp_1+2
	lda	<L245+vp_1
	brl	L248
L244	equ	20
L245	equ	9
	ends
	efunc
	code
	func
~~mark_procfn:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L255
	tcs
	phd
	tcd
pp_0	set	4
base_1	set	0
ep_1	set	4
vp_1	set	8
hashvalue_1	set	12
namelen_1	set	14
cp_1	set	16
	pei	<L255+pp_0+2
	pei	<L255+pp_0
	jsl	~~get_srcaddr
	sta	<L256+base_1
	stx	<L256+base_1+2
	pei	<L256+base_1+2
	pei	<L256+base_1
	jsl	~~skip_name
	sta	<L256+ep_1
	stx	<L256+ep_1+2
	clc
	lda	#$ffff
	adc	<L256+ep_1
	sta	<R0
	lda	#$ffff
	adc	<L256+ep_1+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$28
	rep	#$20
	longa	on
	beq	L257
	brl	L10225
L257:
	lda	<L256+ep_1
	bne	L258
	dec	<L256+ep_1+2
L258:
	dec	<L256+ep_1
L10225:
	sec
	lda	<L256+ep_1
	sbc	<L256+base_1
	sta	<R0
	lda	<L256+ep_1+2
	sbc	<L256+base_1+2
	sta	<R0+2
	lda	<R0
	sta	<L256+namelen_1
	lda	<L256+namelen_1
	ina
	pha
	jsl	~~allocmem
	sta	<L256+cp_1
	stx	<L256+cp_1+2
	pea	#<$16
	jsl	~~allocmem
	sta	<L256+vp_1
	stx	<L256+vp_1+2
	ldy	#$0
	lda	<L256+namelen_1
	bpl	L259
	dey
L259:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L256+base_1+2
	pei	<L256+base_1
	pei	<L256+cp_1+2
	pei	<L256+cp_1
	jsl	~~memcpy
	sep	#$20
	longa	off
	lda	#$0
	ldy	<L256+namelen_1
	sta	[<L256+cp_1],Y
	rep	#$20
	longa	on
	lda	<L256+cp_1
	ldy	#$6
	sta	[<L256+vp_1],Y
	lda	<L256+cp_1+2
	ldy	#$8
	sta	[<L256+vp_1],Y
	pei	<L256+cp_1+2
	pei	<L256+cp_1
	jsl	~~hash
	sta	<L256+hashvalue_1
	lda	<L256+hashvalue_1
	ldy	#$a
	sta	[<L256+vp_1],Y
	lda	#$80
	ldy	#$4
	sta	[<L256+vp_1],Y
	lda	<L255+pp_0
	ldy	#$10
	sta	[<L256+vp_1],Y
	lda	<L255+pp_0+2
	ldy	#$12
	sta	[<L256+vp_1],Y
	lda	<L256+hashvalue_1
	and	#<$3f
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~basicvars+1098
	adc	<R0
	sta	<R1
	lda	(<R1)
	sta	[<L256+vp_1]
	ldy	#$2
	lda	(<R1),Y
	ldy	#$2
	sta	[<L256+vp_1],Y
	lda	<L256+hashvalue_1
	and	#<$3f
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~basicvars+1098
	adc	<R0
	sta	<R1
	lda	<L256+vp_1
	sta	(<R1)
	lda	<L256+vp_1+2
	ldy	#$2
	sta	(<R1),Y
	lda	#$40
	tsb	~~basicvars+423
	ldx	<L256+vp_1+2
	lda	<L256+vp_1
L260:
	tay
	lda	<L255+2
	sta	<L255+2+4
	lda	<L255+1
	sta	<L255+1+4
	pld
	tsc
	clc
	adc	#L255+4
	tcs
	tya
	rtl
L255	equ	28
L256	equ	9
	ends
	efunc
	code
	func
~~scan_fnproc:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L261
	tcs
	phd
	tcd
name_0	set	4
tp_1	set	0
bp_1	set	4
namehash_1	set	8
vp_1	set	10
lp_1	set	14
	pei	<L261+name_0+2
	pei	<L261+name_0
	jsl	~~hash
	sta	<L262+namehash_1
	lda	|~~basicvars+498
	sta	<L262+bp_1
	lda	|~~basicvars+498+2
	sta	<L262+bp_1+2
	stz	<L262+vp_1
	stz	<L262+vp_1+2
L10226:
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L262+bp_1],Y
	cmp	#<$ff
	rep	#$20
	longa	on
	bne	L263
	brl	L10227
L263:
	ldy	#$5
	lda	[<L262+bp_1],Y
	and	#$ff
	sta	<R1
	lda	<R1
	xba
	and	#$ff00
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L264
	dey
L264:
	sta	<R0
	sty	<R0+2
	ldy	#$4
	lda	[<L262+bp_1],Y
	and	#$ff
	sta	<R1
	stz	<R1+2
	clc
	lda	<R1
	adc	<R0
	sta	<R2
	lda	<R1+2
	adc	<R0+2
	sta	<R2+2
	clc
	lda	<L262+bp_1
	adc	<R2
	sta	<L262+tp_1
	lda	<L262+bp_1+2
	adc	<R2+2
	sta	<L262+tp_1+2
	pei	<L262+bp_1+2
	pei	<L262+bp_1
	jsl	~~get_linelen
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L265
	dey
L265:
	sta	<R0
	sty	<R0+2
	clc
	lda	<L262+bp_1
	adc	<R0
	sta	<L262+bp_1
	lda	<L262+bp_1+2
	adc	<R0+2
	sta	<L262+bp_1+2
	sep	#$20
	longa	off
	lda	[<L262+tp_1]
	cmp	#<$9a
	rep	#$20
	longa	on
	beq	L266
	brl	L10228
L266:
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L262+tp_1],Y
	cmp	#<$c
	rep	#$20
	longa	on
	beq	L267
	brl	L10228
L267:
	clc
	lda	#$1
	adc	<L262+tp_1
	sta	<R0
	lda	#$0
	adc	<L262+tp_1+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~mark_procfn
	sta	<L262+vp_1
	stx	<L262+vp_1+2
	ldy	#$a
	lda	[<L262+vp_1],Y
	cmp	<L262+namehash_1
	beq	L269
	brl	L268
L269:
	ldy	#$8
	lda	[<L262+vp_1],Y
	pha
	ldy	#$6
	lda	[<L262+vp_1],Y
	pha
	pei	<L261+name_0+2
	pei	<L261+name_0
	jsl	~~strcmp
	tax
	bne	L270
	brl	L10227
L270:
L268:
	stz	<L262+vp_1
	stz	<L262+vp_1+2
L10228:
	brl	L10226
L10227:
	lda	<L262+bp_1
	sta	|~~basicvars+498
	lda	<L262+bp_1+2
	sta	|~~basicvars+498+2
	lda	<L262+vp_1
	ora	<L262+vp_1+2
	beq	L271
	brl	L10229
L271:
	lda	|~~basicvars+411
	ora	|~~basicvars+411+2
	bne	L272
	brl	L10229
L272:
	lda	|~~basicvars+411
	sta	<L262+lp_1
	lda	|~~basicvars+411+2
	sta	<L262+lp_1+2
L10232:
	pei	<L261+name_0+2
	pei	<L261+name_0
	pei	<L262+lp_1+2
	pei	<L262+lp_1
	jsl	~~search_library
	sta	<L262+vp_1
	stx	<L262+vp_1+2
	lda	<L262+vp_1
	ora	<L262+vp_1+2
	beq	L273
	brl	L10231
L273:
	lda	[<L262+lp_1]
	sta	<R0
	ldy	#$2
	lda	[<L262+lp_1],Y
	sta	<R0+2
	lda	<R0
	sta	<L262+lp_1
	lda	<R0+2
	sta	<L262+lp_1+2
L10230:
	lda	<L262+lp_1
	ora	<L262+lp_1+2
	beq	L274
	brl	L10232
L274:
L10231:
L10229:
	lda	<L262+vp_1
	ora	<L262+vp_1+2
	beq	L275
	brl	L10233
L275:
	lda	|~~basicvars+415
	ora	|~~basicvars+415+2
	bne	L276
	brl	L10233
L276:
	lda	|~~basicvars+415
	sta	<L262+lp_1
	lda	|~~basicvars+415+2
	sta	<L262+lp_1+2
L10236:
	pei	<L261+name_0+2
	pei	<L261+name_0
	pei	<L262+lp_1+2
	pei	<L262+lp_1
	jsl	~~search_library
	sta	<L262+vp_1
	stx	<L262+vp_1+2
	lda	<L262+vp_1
	ora	<L262+vp_1+2
	beq	L277
	brl	L10235
L277:
	lda	[<L262+lp_1]
	sta	<R0
	ldy	#$2
	lda	[<L262+lp_1],Y
	sta	<R0+2
	lda	<R0
	sta	<L262+lp_1
	lda	<R0+2
	sta	<L262+lp_1+2
L10234:
	lda	<L262+lp_1
	ora	<L262+lp_1+2
	beq	L278
	brl	L10236
L278:
L10235:
L10233:
	lda	<L262+vp_1
	ora	<L262+vp_1+2
	beq	L279
	brl	L10237
L279:
	sep	#$20
	longa	off
	lda	[<L261+name_0]
	cmp	#<$cd
	rep	#$20
	longa	on
	beq	L280
	brl	L10238
L280:
	clc
	lda	#$1
	adc	<L261+name_0
	sta	<R0
	lda	#$0
	adc	<L261+name_0+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	pea	#<$10
	pea	#8
	jsl	~~error
	brl	L10239
L10238:
	clc
	lda	#$1
	adc	<L261+name_0
	sta	<R0
	lda	#$0
	adc	<L261+name_0+2
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	pea	#<$f
	pea	#8
	jsl	~~error
L10239:
L10237:
	ldx	<L262+vp_1+2
	lda	<L262+vp_1
L281:
	tay
	lda	<L261+2
	sta	<L261+2+4
	lda	<L261+1
	sta	<L261+1+4
	pld
	tsc
	clc
	adc	#L261+4
	tcs
	tya
	rtl
L261	equ	30
L262	equ	13
	ends
	efunc
	code
	xdef	~~find_fnproc
	func
~~find_fnproc:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L282
	tcs
	phd
	tcd
np_0	set	4
namelen_0	set	8
vp_1	set	0
hashvalue_1	set	4
	ldy	#$0
	lda	<L282+namelen_0
	bpl	L284
	dey
L284:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L282+np_0+2
	pei	<L282+np_0
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	jsl	~~memcpy
	lda	|~~basicvars+70
	sta	<R0
	lda	|~~basicvars+70+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$0
	ldy	<L282+namelen_0
	sta	[<R0],Y
	rep	#$20
	longa	on
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	jsl	~~hash
	sta	<L283+hashvalue_1
	lda	<L283+hashvalue_1
	and	#<$3f
	sta	<R1
	lda	<R1
	asl	A
	asl	A
	sta	<R0
	clc
	lda	#<~~basicvars+1098
	adc	<R0
	sta	<R1
	lda	(<R1)
	sta	<L283+vp_1
	ldy	#$2
	lda	(<R1),Y
	sta	<L283+vp_1+2
	lda	<L283+vp_1
	ora	<L283+vp_1+2
	bne	L285
	brl	L10240
L285:
L10241:
	lda	<L283+vp_1
	ora	<L283+vp_1+2
	bne	L286
	brl	L10242
L286:
	lda	<L283+hashvalue_1
	ldy	#$a
	cmp	[<L283+vp_1],Y
	beq	L288
	brl	L287
L288:
	ldy	#$8
	lda	[<L283+vp_1],Y
	pha
	ldy	#$6
	lda	[<L283+vp_1],Y
	pha
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	jsl	~~strcmp
	tax
	bne	L289
	brl	L10242
L289:
L287:
	lda	[<L283+vp_1]
	sta	<R0
	ldy	#$2
	lda	[<L283+vp_1],Y
	sta	<R0+2
	lda	<R0
	sta	<L283+vp_1
	lda	<R0+2
	sta	<L283+vp_1+2
	brl	L10241
L10242:
	lda	<L283+vp_1
	ora	<L283+vp_1+2
	bne	L290
	brl	L10243
L290:
	ldy	#$4
	lda	[<L283+vp_1],Y
	cmp	#<$80
	bne	L291
	brl	L10243
L291:
	ldx	<L283+vp_1+2
	lda	<L283+vp_1
L292:
	tay
	lda	<L282+2
	sta	<L282+2+6
	lda	<L282+1
	sta	<L282+1+6
	pld
	tsc
	clc
	adc	#L282+6
	tcs
	tya
	rtl
L10243:
L10240:
	lda	<L283+vp_1
	ora	<L283+vp_1+2
	beq	L293
	brl	L10244
L293:
	lda	|~~basicvars+70+2
	pha
	lda	|~~basicvars+70
	pha
	jsl	~~scan_fnproc
	sta	<L283+vp_1
	stx	<L283+vp_1+2
L10244:
	ldy	#$4
	lda	[<L283+vp_1],Y
	cmp	#<$80
	beq	L294
	brl	L10245
L294:
	pei	<L283+vp_1+2
	pei	<L283+vp_1
	jsl	~~scan_parmlist
L10245:
	ldx	<L283+vp_1+2
	lda	<L283+vp_1
	brl	L292
L282	equ	14
L283	equ	9
	ends
	efunc
	code
	xdef	~~init_staticvars
	func
~~init_staticvars:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L295
	tcs
	phd
	tcd
n_1	set	0
	stz	<L296+n_1
L10248:
	lda	<L296+n_1
	ldx	#<$16
	xref	~~~mul
	jsl	~~~mul
	sta	<R0
	lda	#$2
	ldx	<R0
	sta	|~~basicvars+504+4,X
	lda	<L296+n_1
	ldx	#<$16
	xref	~~~mul
	jsl	~~~mul
	sta	<R0
	lda	#$0
	ldx	<R0
	sta	|~~basicvars+504+16,X
L10246:
	inc	<L296+n_1
	sec
	lda	<L296+n_1
	sbc	#<$1b
	bvs	L297
	eor	#$8000
L297:
	bmi	L298
	brl	L10248
L298:
L10247:
	lda	#$90a
	sta	|~~basicvars+520
L299:
	pld
	tsc
	clc
	adc	#L295
	tcs
	rtl
L295	equ	6
L296	equ	5
	ends
	efunc
	xref	~~get_lvalue
	xref	~~emulate_printf
	xref	~~emulate_vdu
	xref	~~restore_current
	xref	~~save_current
	xref	~~find_library
	xref	~~find_linestart
	xref	~~error
	xref	~~condalloc
	xref	~~allocmem
	xref	~~alloc_stackstrmem
	xref	~~alloc_stackmem
	xref	~~get_linelen
	xref	~~get_lineno
	xref	~~get_srcaddr
	xref	~~skip_name
	xref	~~eval_integer
	xref	~~tolower
	xref	~~strlen
	xref	~~strcmp
	xref	~~strcat
	xref	~~memcpy
	xref	~~memcmp
	xref	~~memmove
	xref	~~strcpy
	xref	~~sprintf
	xref	~~basicvars
	end
