;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
;#include <stdio.h>
;#include <stdlib.h>
;#include <string.h>
;#include <stdbool.h>
;#include "FreeRTOS.h"
;#include "task.h"
;#include <homebrew.h>
;#include <errno.h>
;
;
;int main(int argc, char**argv) {
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
;	
;	char *p, c;
;	
;	printf("dump address>");
p_1	set	0
c_1	set	4
	pea	#^L1
	pea	#<L1
	pea	#6
	jsl	~~printf
;	
;	if (argc >= 2) {
	sec
	lda	<L2+argc_0
	sbc	#<$2
	bvs	L4
	eor	#$8000
L4:
	bpl	L10001
;		p = (char *)str2hex(argv[1]);
	ldy	#$6
	lda	[<L2+argv_0],Y
	pha
	dey
	dey
	lda	[<L2+argv_0],Y
	pha
	jsl	~~str2hex
	stx	<R0+2
	sta	<L3+p_1
	lda	<R0+2
	sta	<L3+p_1+2
;		printf("%s",argv[1]);
	ldy	#$6
	lda	[<L2+argv_0],Y
	pha
	dey
	dey
	lda	[<L2+argv_0],Y
	pha
	pea	#^L1+14
	pea	#<L1+14
	pea	#10
	jsl	~~printf
;	} else {	
	bra	L10002
L10001:
;		p = (char *)getHex8();
	jsl	~~getHex8
	stx	<R0+2
	sta	<L3+p_1
	lda	<R0+2
	sta	<L3+p_1+2
;	}
L10002:
;	
;	printf("\n");
	pea	#^L1+17
	pea	#<L1+17
	pea	#6
	jsl	~~printf
;
;	for (;;) {		
L10005:
;		dump(p, 256, 1);
	pea	#<$1
	pea	#<$100
	pei	<L3+p_1+2
	pei	<L3+p_1
	jsl	~~dump
;		c = toupper(getchar());
	lda	|~~stdin+2
	pha
	lda	|~~stdin
	pha
	jsl	~~fgetc
	pha
	jsl	~~toupper
	sep	#$20
	longa	off
	sta	<L3+c_1
;		if (c == 'X') break;
	cmp	#<$58
	rep	#$20
	longa	on
	beq	L8
;		p += 256;
	lda	#$100
	clc
	adc	<L3+p_1
	sta	<L3+p_1
	bcc	L10005
	inc	<L3+p_1+2
;	}
	bra	L10005
;
;}
L8:
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
L2	equ	9
L3	equ	5
	ends
	efunc
	data
L1:
	db	$64,$75,$6D,$70,$20,$61,$64,$64,$72,$65,$73,$73,$3E,$00,$25
	db	$73,$00,$0A,$00
	ends
;
;
	xref	~~toupper
	xref	~~dump
	xref	~~str2hex
	xref	~~getHex8
	xref	~~fgetc
	xref	~~printf
	xref	~~stdin
