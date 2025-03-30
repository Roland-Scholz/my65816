;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
;#include <stdio.h>
;#include <stdlib.h>
;#include <string.h>
;#include <stdbool.h>
;#include <errno.h>
;#include <unistd.h>
;#include <dirent.h>
;#include <sys/stat.h>
;
;#include "freeRTOS.h"
;#include "task.h"
;#include <homebrew.h>
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
;	unsigned int uix, uiy;
;	int ix, iy;
;	unsigned long ulx, uly;
;	long lx, ly;
;	
;	int  iret;
;	long ret;
;	
;	ix = -1;
uix_1	set	0
uiy_1	set	2
ix_1	set	4
iy_1	set	6
ulx_1	set	8
uly_1	set	12
lx_1	set	16
ly_1	set	20
iret_1	set	24
ret_1	set	26
	lda	#$ffff
	sta	<L3+ix_1
;	iy = -1;
	sta	<L3+iy_1
;	uix = 2;
	lda	#$2
	sta	<L3+uix_1
;	uiy = 2;
	sta	<L3+uiy_1
;	
;	ly = 5;
	lda	#$5
	sta	<L3+ly_1
	lda	#$0
	sta	<L3+ly_1+2
;	
;	printf("ix * iy = %d\n", ix * iy);
	lda	<L3+ix_1
	ldx	<L3+iy_1
	xref	~~~mul
	jsl	~~~mul
	pha
	pea	#^L1
	pea	#<L1
	pea	#8
	jsl	~~printf
;	printf("uix * uiy = %d\n", uix * uiy);
	lda	<L3+uix_1
	ldx	<L3+uiy_1
	xref	~~~mul
	jsl	~~~mul
	pha
	pea	#^L1+14
	pea	#<L1+14
	pea	#8
	jsl	~~printf
;	printf("uix * iy = %d\n", uix * iy);
	lda	<L3+uix_1
	ldx	<L3+iy_1
	xref	~~~mul
	jsl	~~~mul
	pha
	pea	#^L1+30
	pea	#<L1+30
	pea	#8
	jsl	~~printf
;		
;	printf("17 * ly: %lu\n", 17 * ly);
	pea	#^$11
	pea	#<$11
	pei	<L3+ly_1+2
	pei	<L3+ly_1
	xref	~~~lmul
	jsl	~~~lmul
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	pea	#^L1+45
	pea	#<L1+45
	pea	#10
	jsl	~~printf
;	printf("ly << 5: %d\n", ly << 5);
	pei	<L3+ly_1+2
	pei	<L3+ly_1
	lda	#$5
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	pea	#^L1+59
	pea	#<L1+59
	pea	#10
	jsl	~~printf
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
L2	equ	34
L3	equ	5
	ends
	efunc
	data
L1:
	db	$69,$78,$20,$2A,$20,$69,$79,$20,$3D,$20,$25,$64,$0A,$00,$75
	db	$69,$78,$20,$2A,$20,$75,$69,$79,$20,$3D,$20,$25,$64,$0A,$00
	db	$75,$69,$78,$20,$2A,$20,$69,$79,$20,$3D,$20,$25,$64,$0A,$00
	db	$31,$37,$20,$2A,$20,$6C,$79,$3A,$20,$25,$6C,$75,$0A,$00,$6C
	db	$79,$20,$3C,$3C,$20,$35,$3A,$20,$25,$64,$0A,$00
	ends
;
	xref	~~printf
