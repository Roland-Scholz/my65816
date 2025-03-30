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
;	char *p, *ncode;
;	int x, y;
;
;	ncode = (char *)0x34d;
p_1	set	0
ncode_1	set	4
x_1	set	8
y_1	set	10
	lda	#$34d
	sta	<L3+ncode_1
	lda	#$0
	sta	<L3+ncode_1+2
;	for (;;) {
L10003:
;		printf("break address>");
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
	pea	#^L1+15
	pea	#<L1+15
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
	pea	#^L1+18
	pea	#<L1+18
	pea	#6
	jsl	~~printf
;		*ncode = *p;
	sep	#$20
	longa	off
	lda	[<L3+p_1]
	sta	[<L3+ncode_1]
;		*p = 0;
	lda	#$0
	sta	[<L3+p_1]
	rep	#$20
	longa	on
;	}
	bra	L10003
;}
L2	equ	16
L3	equ	5
	ends
	efunc
	data
L1:
	db	$62,$72,$65,$61,$6B,$20,$61,$64,$64,$72,$65,$73,$73,$3E,$00
	db	$25,$73,$00,$0A,$00
	ends
;
	xref	~~str2hex
	xref	~~getHex8
	xref	~~printf
