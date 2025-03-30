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
;#define DISASS24	$E052
;#define	DISSADRLO	*((unsigned int *) 0x2)
;#define	DISSADRBANK	*((char *) 0x4)
;
;
;int main(int argc, char **argv) {
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
;	int x, y;
;
;	for (;;) {
p_1	set	0
c_1	set	4
x_1	set	5
y_1	set	7
L10003:
;		printf("disass address>");
	pea	#^L1
	pea	#<L1
	pea	#6
	jsl	~~printf
;		
;		if (argc >= 2) {
	sec
	lda	<L2+argc_0
	sbc	#<$2
	bvs	L4
	eor	#$8000
L4:
	bpl	L10004
;			p = (char *)str2hex(argv[1]);
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
;			printf("%s",argv[1]);
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
;			argc = 1;
	lda	#$1
	sta	<L2+argc_0
;		} else {	
	bra	L10005
L10004:
;			p = (char *)getHex8();
	jsl	~~getHex8
	stx	<R0+2
	sta	<L3+p_1
	lda	<R0+2
	sta	<L3+p_1+2
;		}
L10005:
;		
;		printf("\n");	
	pea	#^L1+19
	pea	#<L1+19
	pea	#6
	jsl	~~printf
;		
;		DISSADRLO = (unsigned int)((size_t)p);
	lda	<L3+p_1
	sta	>2
;		DISSADRBANK = (size_t)p >> 16;
	pei	<L3+p_1+2
	pei	<L3+p_1
	lda	#$10
	xref	~~~llsr
	jsl	~~~llsr
	sta	<R0
	stx	<R0+2
	sep	#$20
	longa	off
	lda	<R0
	sta	>4
	rep	#$20
	longa	on
;		
;		asm{jsl $e052;}
	asmstart
	jsl $e052
	asmend
;
;		if (getchar() == 'x') {
	lda	|~~stdin+2
	pha
	lda	|~~stdin
	pha
	jsl	~~fgetc
	cmp	#<$78
	beq	*+5
	brl	L10003
;			break;
;		}
;	}
;}
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
L2	equ	13
L3	equ	5
	ends
	efunc
	data
L1:
	db	$64,$69,$73,$61,$73,$73,$20,$61,$64,$64,$72,$65,$73,$73,$3E
	db	$00,$25,$73,$00,$0A,$00
	ends
;
	xref	~~str2hex
	xref	~~getHex8
	xref	~~fgetc
	xref	~~printf
	xref	~~stdin
