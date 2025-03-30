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
;	ptrconv_t p;
;	size_t input;
;	char c;
;	
;	printf("change address>");
p_1	set	0
input_1	set	4
c_1	set	8
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
;		p.ptr = (char *)str2hex(argv[1]);
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
	pea	#^L1+16
	pea	#<L1+16
	pea	#10
	jsl	~~printf
;	} else {	
	bra	L10002
L10001:
;		p.ptr = (char *)getHex8();
	jsl	~~getHex8
	stx	<R0+2
	sta	<L3+p_1
	lda	<R0+2
	sta	<L3+p_1+2
;	}
L10002:
;	
;	printf("\n");
	pea	#^L1+19
	pea	#<L1+19
L20001:
	pea	#6
	jsl	~~printf
;
;	for (;;) {	
;		printf("%02X:%04X %02X >", p.adrBank.ptrBank, p.adrBank.ptr16, *(char *)p.ptr);
	lda	[<L3+p_1]
	and	#$ff
	pha
	pei	<L3+p_1
	lda	<L3+p_1+2
	and	#$ff
	pha
	pea	#^L1+21
	pea	#<L1+21
	pea	#12
	jsl	~~printf
;
;		input = getHex8();
	jsl	~~getHex8
	sta	<L3+input_1
	stx	<L3+input_1+2
;		*(char *)p.ptr = (char)input;
	sep	#$20
	longa	off
	lda	<L3+input_1
	sta	[<L3+p_1]
	rep	#$20
	longa	on
;		
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
;		if (c == 'X') {
	cmp	#<$58
	rep	#$20
	longa	on
	bne	L10006
;			printf("\n");
	pea	#^L1+38
	pea	#<L1+38
	pea	#6
	jsl	~~printf
;			break;
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
;		}
;		printf("\n");
L10006:
	pea	#^L1+40
	pea	#<L1+40
	bra	L20001
;	}
;
;}
L2	equ	13
L3	equ	5
	ends
	efunc
	data
L1:
	db	$63,$68,$61,$6E,$67,$65,$20,$61,$64,$64,$72,$65,$73,$73,$3E
	db	$00,$25,$73,$00,$0A,$00,$25,$30,$32,$58,$3A,$25,$30,$34,$58
	db	$20,$25,$30,$32,$58,$20,$3E,$00,$0A,$00,$0A,$00
	ends
;
;
	xref	~~toupper
	xref	~~str2hex
	xref	~~getHex8
	xref	~~fgetc
	xref	~~printf
	xref	~~stdin
