;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
;#define THR0	(*(char *)0xFFFFE0)
;#define LSR0	(*(char *)0xFFFFE5)
;
;//#ifndef _SIZE_T
;//#define _SIZE_T
;//  typedef unsigned long size_t;
;//#endif
;
;
;/*
;	Copyright 2001, 2002 Georges Menie (www.menie.org)
;	stdarg version contributed by Christian Ettinger
;
;    This program is free software; you can redistribute it and/or modify
;    it under the terms of the GNU Lesser General Public License as published by
;    the Free Software Foundation; either version 2 of the License, or
;    (at your option) any later version.
;
;    This program is distributed in the hope that it will be useful,
;    but WITHOUT ANY WARRANTY; without even the implied warranty of
;    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;    GNU Lesser General Public License for more details.
;
;    You should have received a copy of the GNU Lesser General Public License
;    along with this program; if not, write to the Free Software
;    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
;*/
;
;/*
;	putchar is the only external dependency for this file,
;	if you have a working putchar, leave it commented out.
;	If not, uncomment the define below and
;	replace outbyte(c) by your own function call.
;*/
;//#define putchar(c) outbyte(c)
;
;
;#include <stdlib.h>
;#include <stdarg.h>
;
;
;static void outbyte(int c) {
	code
	func
~~outbyte:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
c_0	set	4
;	while (!(LSR0 & 0x40));
L10001:
	sep	#$20
	longa	off
	lda	>16777189
	and	#<$40
	rep	#$20
	longa	on
	beq	L10001
;	THR0 = c;
	sep	#$20
	longa	off
	lda	<L2+c_0
	sta	>16777184
	rep	#$20
	longa	on
;}
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
L2	equ	0
L3	equ	1
	ends
	efunc
;
;static void debugchar(char **str, int c)
;{
	code
	func
~~debugchar:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L6
	tcs
	phd
	tcd
str_0	set	4
c_0	set	8
;	//extern void putchar(int c);
;	
;	if (str) {
	lda	<L6+str_0
	ora	<L6+str_0+2
	beq	L10003
;		**str = c;
	lda	[<L6+str_0]
	sta	<R0
	ldy	#$2
	lda	[<L6+str_0],Y
	sta	<R0+2
	sep	#$20
	longa	off
	lda	<L6+c_0
	sta	[<R0]
	rep	#$20
	longa	on
;		++(*str);
	lda	#$1
	clc
	adc	[<L6+str_0]
	sta	[<L6+str_0]
	lda	#$0
	adc	[<L6+str_0],Y
	sta	[<L6+str_0],Y
;	}
;	else (void)outbyte(c);
	bra	L9
L10003:
	pei	<L6+c_0
	jsl	~~outbyte
;}
L9:
	lda	<L6+2
	sta	<L6+2+6
	lda	<L6+1
	sta	<L6+1+6
	pld
	tsc
	clc
	adc	#L6+6
	tcs
	rtl
L6	equ	4
L7	equ	5
	ends
	efunc
;
;#define PAD_RIGHT 1
;#define PAD_ZERO 2
;
;static int debugs(char **out, const char *string, int width, int pad)
;{
	code
	func
~~debugs:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L10
	tcs
	phd
	tcd
out_0	set	4
string_0	set	8
width_0	set	12
pad_0	set	14
;	register int pc = 0, padchar = ' ';
;
;	if (width > 0) {
pc_1	set	0
padchar_1	set	2
	stz	<L11+pc_1
	lda	#$20
	sta	<L11+padchar_1
	sec
	lda	#$0
	sbc	<L10+width_0
	bvs	L12
	eor	#$8000
L12:
	bmi	L10005
;		register int len = 0;
;		register const char *ptr;
;		for (ptr = string; *ptr; ++ptr) ++len;
len_2	set	4
ptr_2	set	6
	stz	<L11+len_2
	lda	<L10+string_0
	sta	<L11+ptr_2
	lda	<L10+string_0+2
	sta	<L11+ptr_2+2
	bra	L10009
L10008:
	inc	<L11+len_2
	inc	<L11+ptr_2
	bne	L10009
	inc	<L11+ptr_2+2
L10009:
	lda	[<L11+ptr_2]
	and	#$ff
	bne	L10008
;		if (len >= width) width = 0;
	sec
	lda	<L11+len_2
	sbc	<L10+width_0
	bvs	L16
	eor	#$8000
L16:
	bpl	L10010
	stz	<L10+width_0
;		else width -= len;
	bra	L10011
L10010:
	sec
	lda	<L10+width_0
	sbc	<L11+len_2
	sta	<L10+width_0
L10011:
;		if (pad & PAD_ZERO) padchar = '0';
	lda	<L10+pad_0
	and	#<$2
	beq	L10005
	lda	#$30
	sta	<L11+padchar_1
;	}
;	if (!(pad & PAD_RIGHT)) {
L10005:
	lda	<L10+pad_0
	and	#<$1
	beq	L10017
	bra	L10021
;		for ( ; width > 0; --width) {
L10016:
;			debugchar (out, padchar);
	pei	<L11+padchar_1
	pei	<L10+out_0+2
	pei	<L10+out_0
	jsl	~~debugchar
;			++pc;
	inc	<L11+pc_1
;		}
	dec	<L10+width_0
L10017:
	sec
	lda	#$0
	sbc	<L10+width_0
	bvs	L20
	eor	#$8000
L20:
	bmi	L10021
	bra	L10016
;	}
;	for ( ; *string ; ++string) {
L10020:
;		debugchar (out, *string);
	lda	[<L10+string_0]
	and	#$ff
	pha
	pei	<L10+out_0+2
	pei	<L10+out_0
	jsl	~~debugchar
;		++pc;
	inc	<L11+pc_1
;	}
	inc	<L10+string_0
	bne	L10021
	inc	<L10+string_0+2
L10021:
	lda	[<L10+string_0]
	and	#$ff
	beq	L10025
	bra	L10020
;	for ( ; width > 0; --width) {
L10024:
;		debugchar (out, padchar);
	pei	<L11+padchar_1
	pei	<L10+out_0+2
	pei	<L10+out_0
	jsl	~~debugchar
;		++pc;
	inc	<L11+pc_1
;	}
	dec	<L10+width_0
L10025:
	sec
	lda	#$0
	sbc	<L10+width_0
	bvs	L24
	eor	#$8000
L24:
	bpl	L10024
;
;	return pc;
	lda	<L11+pc_1
	tay
	lda	<L10+2
	sta	<L10+2+12
	lda	<L10+1
	sta	<L10+1+12
	pld
	tsc
	clc
	adc	#L10+12
	tcs
	tya
	rtl
;}
L10	equ	10
L11	equ	1
	ends
	efunc
;
;/* the following should be enough for 32 bit int */
;#define PRINT_BUF_LEN 12
;
;static int debugi(char **out, long i, int b, int sg, int width, int pad, int letbase)
;{
	code
	func
~~debugi:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L27
	tcs
	phd
	tcd
out_0	set	4
i_0	set	8
b_0	set	12
sg_0	set	14
width_0	set	16
pad_0	set	18
letbase_0	set	20
;	char print_buf[PRINT_BUF_LEN];
;	/*register*/ char *s;
;	/*register*/ unsigned int t, neg = 0, pc = 0;
;	/*register*/ unsigned long u = i;
;
;	if (i == 0) {
print_buf_1	set	0
s_1	set	12
t_1	set	16
neg_1	set	18
pc_1	set	20
u_1	set	22
	stz	<L28+neg_1
	stz	<L28+pc_1
	lda	<L27+i_0
	sta	<L28+u_1
	lda	<L27+i_0+2
	sta	<L28+u_1+2
	lda	<L27+i_0
	ora	<L27+i_0+2
	bne	L10026
;		print_buf[0] = '0';
	sep	#$20
	longa	off
	lda	#$30
	sta	<L28+print_buf_1
;		print_buf[1] = '\0';
	stz	<L28+print_buf_1+1
	rep	#$20
	longa	on
;		return debugs (out, print_buf, width, pad);
	pei	<L27+pad_0
	pei	<L27+width_0
	pea	#0
	clc
	tdc
	adc	#<L28+print_buf_1
	pha
	pei	<L27+out_0+2
	pei	<L27+out_0
	jsl	~~debugs
L30:
	tay
	lda	<L27+2
	sta	<L27+2+18
	lda	<L27+1
	sta	<L27+1+18
	pld
	tsc
	clc
	adc	#L27+18
	tcs
	tya
	rtl
;	}
;
;	if (sg && b == 10 && i < 0) {
L10026:
	lda	<L27+sg_0
	beq	L10027
	lda	<L27+b_0
	cmp	#<$a
	bne	L10027
	lda	<L27+i_0+2
	bpl	L10027
;		neg = 1;
	lda	#$1
	sta	<L28+neg_1
;		u = -i;
	sec
	dea
	sbc	<L27+i_0
	sta	<L28+u_1
	lda	#$0
	sbc	<L27+i_0+2
	sta	<L28+u_1+2
;	}
;
;	s = print_buf + PRINT_BUF_LEN-1;
L10027:
	clc
	tdc
	adc	#<L28+print_buf_1+11
	sta	<L28+s_1
	lda	#$0
	sta	<L28+s_1+2
;	*s = '\0';
	sep	#$20
	longa	off
	lda	#$0
	sta	[<L28+s_1]
	rep	#$20
	longa	on
;
;	while (u) {
	bra	L10028
L20001:
;		t = u % b;
	ldy	#$0
	lda	<L27+b_0
	bpl	L35
	dey
L35:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L28+u_1+2
	pei	<L28+u_1
	xref	~~~lumd
	jsl	~~~lumd
	stx	<R0+2
	sta	<L28+t_1
;		if( t >= 10 )
;			t += letbase - '0' - 10;
	cmp	#<$a
	bcc	L10030
	lda	<L28+t_1
	clc
	adc	<L27+letbase_0
	clc
	adc	#$ffc6
	sta	<L28+t_1
;		*--s = t + '0';
L10030:
	lda	<L28+s_1
	bne	L37
	dec	<L28+s_1+2
L37:
	dec	<L28+s_1
	lda	#$30
	clc
	adc	<L28+t_1
	sep	#$20
	longa	off
	sta	[<L28+s_1]
	rep	#$20
	longa	on
;		u /= b;
	ldy	#$0
	lda	<L27+b_0
	bpl	L38
	dey
L38:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L28+u_1+2
	pei	<L28+u_1
	xref	~~~ludv
	jsl	~~~ludv
	sta	<L28+u_1
	stx	<L28+u_1+2
;	}
L10028:
	lda	<L28+u_1
	ora	<L28+u_1+2
	bne	L20001
;
;	if (neg) {
	lda	<L28+neg_1
	beq	L10031
;		if( width && (pad & PAD_ZERO) ) {
	lda	<L27+width_0
	beq	L10032
	lda	<L27+pad_0
	and	#<$2
	beq	L10032
;			debugchar (out, '-');
	pea	#<$2d
	pei	<L27+out_0+2
	pei	<L27+out_0
	jsl	~~debugchar
;			++pc;
	inc	<L28+pc_1
;			--width;
	dec	<L27+width_0
;		}
;		else {
	bra	L10031
L10032:
;			*--s = '-';
	lda	<L28+s_1
	bne	L42
	dec	<L28+s_1+2
L42:
	dec	<L28+s_1
	sep	#$20
	longa	off
	lda	#$2d
	sta	[<L28+s_1]
	rep	#$20
	longa	on
;		}
;	}
;
;	return pc + debugs (out, s, width, pad);
L10031:
	pei	<L27+pad_0
	pei	<L27+width_0
	pei	<L28+s_1+2
	pei	<L28+s_1
	pei	<L27+out_0+2
	pei	<L27+out_0
	jsl	~~debugs
	lda	<R0
	clc
	adc	<L28+pc_1
	brl	L30
;}
L27	equ	30
L28	equ	5
	ends
	efunc
;
;static int debug( char **out, const char *format, va_list args )
;{
	code
	func
~~debug:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L43
	tcs
	phd
	tcd
out_0	set	4
format_0	set	8
args_0	set	12
;	/*register*/ unsigned int width, pad;
;	/*register*/ unsigned int pc = 0;
;	char scr[2];
;
;	for (; *format != 0; ++format) {
width_1	set	0
pad_1	set	2
pc_1	set	4
scr_1	set	6
	stz	<L44+pc_1
	brl	L10037
L10036:
;		if (*format == '%') {
	sep	#$20
	longa	off
	lda	[<L43+format_0]
	cmp	#<$25
	rep	#$20
	longa	on
	beq	*+5
	brl	L10039
;			++format;
	inc	<L43+format_0
	bne	L46
	inc	<L43+format_0+2
L46:
;			width = pad = 0;
	stz	<L44+pad_1
	stz	<L44+width_1
;			if (*format == '\0') break;
	lda	[<L43+format_0]
	and	#$ff
	bne	*+5
	brl	L10035
;			if (*format == '%') goto out;
	sep	#$20
	longa	off
	lda	[<L43+format_0]
	cmp	#<$25
	rep	#$20
	longa	on
	bne	*+5
	brl	L10039
;			if (*format == '-') {
	sep	#$20
	longa	off
	lda	[<L43+format_0]
	cmp	#<$2d
	rep	#$20
	longa	on
	bne	L10041
;				++format;
	inc	<L43+format_0
	bne	L50
	inc	<L43+format_0+2
L50:
;				pad = PAD_RIGHT;
	lda	#$1
	sta	<L44+pad_1
;			}
;			while (*format == '0') {
	bra	L10041
L20003:
;				++format;
	inc	<L43+format_0
	bne	L52
	inc	<L43+format_0+2
L52:
;				pad |= PAD_ZERO;
	lda	#$2
	tsb	<L44+pad_1
;			}
L10041:
	sep	#$20
	longa	off
	lda	[<L43+format_0]
	cmp	#<$30
	rep	#$20
	longa	on
	beq	L20003
;			for ( ; *format >= '0' && *format <= '9'; ++format) {
	bra	L10046
L10045:
;				width *= 10;
	lda	<L44+width_1
	asl	A
	asl	A
	adc	<L44+width_1
	asl	A
	sta	<L44+width_1
;				width += *format - '0';
	lda	[<L43+format_0]
	and	#$ff
	clc
	adc	<L44+width_1
	clc
	adc	#$ffd0
	sta	<L44+width_1
;			}
	inc	<L43+format_0
	bne	L10046
	inc	<L43+format_0+2
L10046:
	sep	#$20
	longa	off
	lda	[<L43+format_0]
	cmp	#<$30
	rep	#$20
	longa	on
	bcc	L10044
	sep	#$20
	longa	off
	lda	#$39
	cmp	[<L43+format_0]
	rep	#$20
	longa	on
	bcs	L10045
L10044:
;			if( *format == 's' ) {
	sep	#$20
	longa	off
	lda	[<L43+format_0]
	cmp	#<$73
	rep	#$20
	longa	on
	beq	*+5
	brl	L10047
;				register char *s = (char *)va_arg( args, long );
;				pc += debugs (out, s?s:"(null)", width, pad);
s_2	set	8
	lda	#$4
	clc
	adc	<L43+args_0
	sta	<L43+args_0
	bcc	L58
	inc	<L43+args_0+2
L58:
	lda	#$fffc
	clc
	adc	<L43+args_0
	sta	<R0
	lda	#$ffff
	adc	<L43+args_0+2
	sta	<R0+2
	lda	[<R0]
	sta	<L44+s_2
	ldy	#$2
	lda	[<R0],Y
	sta	<L44+s_2+2
	pei	<L44+pad_1
	pei	<L44+width_1
	lda	<L44+s_2
	ora	<L44+s_2+2
	beq	L59
	ldx	<L44+s_2+2
	lda	<L44+s_2
	bra	L61
L59:
	lda	#^L1
	tax
	lda	#<L1
L61:
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
L20076:
	pei	<L43+out_0+2
	pei	<L43+out_0
	jsl	~~debugs
	bra	L20008
L20066:
;				pc += debugi (out, va_arg( args, long), 10, 1, width, pad, 'a');
	pea	#<$61
	pei	<L44+pad_1
	pei	<L44+width_1
	pea	#<$1
L20073:
	pea	#<$a
L20072:
	lda	#$4
	clc
	adc	<L43+args_0
	sta	<L43+args_0
	bcc	L63
	inc	<L43+args_0+2
L63:
	lda	#$fffc
	clc
	adc	<L43+args_0
	sta	<R0
	lda	#$ffff
	adc	<L43+args_0+2
	sta	<R0+2
	ldy	#$2
	lda	[<R0],Y
	pha
	lda	[<R0]
	pha
	pei	<L43+out_0+2
	pei	<L43+out_0
	jsl	~~debugi
;				continue;
L20008:
	clc
	adc	<L44+pc_1
	sta	<L44+pc_1
;				continue;
	brl	L10034
;			}
;			if( *format == 'd' ) {
L10047:
	sep	#$20
	longa	off
	lda	[<L43+format_0]
	cmp	#<$64
	rep	#$20
	longa	on
	beq	L20066
;			}
;			if( *format == 'x' ) {
	sep	#$20
	longa	off
	lda	[<L43+format_0]
	cmp	#<$78
	rep	#$20
	longa	on
	bne	L10049
;				pc += debugi (out, va_arg( args, long), 16, 0, width, pad, 'a');
	pea	#<$61
	bra	L20080
L20082:
;				pc += debugi (out, va_arg( args, long), 16, 0, width, pad, 'A');
	pea	#<$41
L20080:
	pei	<L44+pad_1
	pei	<L44+width_1
	pea	#<$0
	pea	#<$10
	bra	L20072
;				continue;
;			}
;			if( *format == 'X' ) {
L10049:
	sep	#$20
	longa	off
	lda	[<L43+format_0]
	cmp	#<$58
	rep	#$20
	longa	on
	beq	L20082
;				continue;
;			}
;			if( *format == 'u' ) {
	sep	#$20
	longa	off
	lda	[<L43+format_0]
	cmp	#<$75
	rep	#$20
	longa	on
	bne	L10051
;				pc += debugi (out, va_arg( args, long), 10, 0, width, pad, 'a');
	pea	#<$61
	pei	<L44+pad_1
	pei	<L44+width_1
	pea	#<$0
	brl	L20073
;				continue;
;			}
;			if( *format == 'c' ) {
L10051:
	sep	#$20
	longa	off
	lda	[<L43+format_0]
	cmp	#<$63
	rep	#$20
	longa	on
	bne	L10034
;				/* char are converted to int then pushed on the stack */
;				scr[0] = (char)va_arg( args, int );
	lda	#$2
	clc
	adc	<L43+args_0
	sta	<L43+args_0
	bcc	L71
	inc	<L43+args_0+2
L71:
	lda	#$fffe
	clc
	adc	<L43+args_0
	sta	<R0
	lda	#$ffff
	adc	<L43+args_0+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	sta	<L44+scr_1
;				scr[1] = '\0';
	stz	<L44+scr_1+1
	rep	#$20
	longa	on
;				pc += debugs (out, scr, width, pad);
	pei	<L44+pad_1
	pei	<L44+width_1
	pea	#0
	clc
	tdc
	adc	#<L44+scr_1
	pha
	brl	L20076
;				continue;
;			}
;		}
;		else {
;		out:
L10039:
;			debugchar (out, *format);
	lda	[<L43+format_0]
	and	#$ff
	pha
	pei	<L43+out_0+2
	pei	<L43+out_0
	jsl	~~debugchar
;			++pc;
	inc	<L44+pc_1
;		}
;	}
L10034:
	inc	<L43+format_0
	bne	L10037
	inc	<L43+format_0+2
L10037:
	lda	[<L43+format_0]
	and	#$ff
	beq	*+5
	brl	L10036
L10035:
;	if (out) **out = '\0';
	lda	<L43+out_0
	ora	<L43+out_0+2
	beq	L10054
	lda	[<L43+out_0]
	sta	<R0
	ldy	#$2
	lda	[<L43+out_0],Y
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$0
	sta	[<R0]
	rep	#$20
	longa	on
;	va_end( args );
L10054:
;	
;	return pc;
	lda	<L44+pc_1
	tay
	lda	<L43+2
	sta	<L43+2+12
	lda	<L43+1
	sta	<L43+1+12
	pld
	tsc
	clc
	adc	#L43+12
	tcs
	tya
	rtl
;}
L43	equ	20
L44	equ	9
	ends
	efunc
	data
L1:
	db	$28,$6E,$75,$6C,$6C,$29,$00
	ends
;
;int debugf(const char *format, ...)
;{	
	code
	xdef	~~debugf
	func
~~debugf:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L77
	tcs
	phd
	tcd
format_0	set	6
;        va_list args;
;        
;        va_start( args, format );
args_1	set	0
	clc
	tdc
	adc	#<L77+format_0+4
	sta	<L78+args_1
	lda	#$0
	sta	<L78+args_1+2
;        return debug( 0, format, args );
	pha
	pei	<L78+args_1
	pei	<L77+format_0+2
	pei	<L77+format_0
	pea	#^$0
	pea	#<$0
	jsl	~~debug
	tay
	phx
	ldx	<L77+4
	lda	<L77+2
	sta	<L77+2,X
	lda	<L77+1
	sta	<L77+1,X
	txa
	plx
	pld
	pha
	tsc
	clc
	adc	#L77+2
	adc	<1,s
	tcs
	tya
	rtl
;}
L77	equ	4
L78	equ	1
	ends
	efunc
;/*
;int sprintf(char *out, const char *format, ...)
;{
;        va_list args;
;        
;        va_start( args, format );
;        return print( &out, format, args );
;}
;
;
;int snprintf( char *buf, unsigned int count, const char *format, ... )
;{
;        va_list args;
;        
;        ( void ) count;
;        
;        va_start( args, format );
;        return print( &buf, format, args );
;}
;*/
;
