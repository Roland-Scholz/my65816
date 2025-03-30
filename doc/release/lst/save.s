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
;#define	BUFLEN	32
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
;	char *pfrom, *pto, fname[BUFLEN];	
;	size_t len, slen;
;	FILE *f;
;	unsigned int i;
;	
;	printf("save from:");
pfrom_1	set	0
pto_1	set	4
fname_1	set	8
len_1	set	40
slen_1	set	44
f_1	set	48
i_1	set	52
	pea	#^L1
	pea	#<L1
	pea	#6
	jsl	~~printf
;	pfrom = (char *)getHex8();
	jsl	~~getHex8
	stx	<R0+2
	sta	<L3+pfrom_1
	lda	<R0+2
	sta	<L3+pfrom_1+2
;	printf(" to:");
	pea	#^L1+11
	pea	#<L1+11
	pea	#6
	jsl	~~printf
;	pto = (char *)getHex8();
	jsl	~~getHex8
	stx	<R0+2
	sta	<L3+pto_1
	lda	<R0+2
	sta	<L3+pto_1+2
;	
;	if (pfrom < pto) {
	lda	<L3+pfrom_1
	cmp	<L3+pto_1
	lda	<L3+pfrom_1+2
	sbc	<L3+pto_1+2
	bcc	*+5
	brl	L8
;		
;		printf(" filename>");	
	pea	#^L1+16
	pea	#<L1+16
	pea	#6
	jsl	~~printf
;
;		input(fname, 16);	
	pea	#<$10
	pea	#0
	clc
	tdc
	adc	#<L3+fname_1
	pha
	jsl	~~input
;		
;		len = (size_t)(pto - pfrom) + 1;
	sec
	lda	<L3+pto_1
	sbc	<L3+pfrom_1
	sta	<R0
	lda	<L3+pto_1+2
	sbc	<L3+pfrom_1+2
	sta	<R0+2
	lda	#$1
	clc
	adc	<R0
	sta	<L3+len_1
	lda	#$0
	adc	<R0+2
	sta	<L3+len_1+2
;		
;		//printf("%p %p *%s*\n", pfrom, pto, fname);
;		
;		f = fopen(fname, "w");
	pea	#^L1+27
	pea	#<L1+27
	pea	#0
	clc
	tdc
	adc	#<L3+fname_1
	pha
	jsl	~~fopen
	sta	<L3+f_1
	stx	<L3+f_1+2
;		if (f) {
	ora	<L3+f_1+2
	beq	L10002
;			slen = fwrite(pfrom, 1, len, f);
	pei	<L3+f_1+2
	pei	<L3+f_1
	pei	<L3+len_1+2
	pei	<L3+len_1
	pea	#^$1
	pea	#<$1
	pei	<L3+pfrom_1+2
	pei	<L3+pfrom_1
	jsl	~~fwrite
	sta	<L3+slen_1
	stx	<L3+slen_1+2
;			fclose(f);
	pei	<L3+f_1+2
	pei	<L3+f_1
	jsl	~~fclose
;			printf("\nsaved from:%p to:%p bytes:%lu file:%s\n", pfrom, pto, slen, fname);
	pea	#0
	clc
	tdc
	adc	#<L3+fname_1
	pha
	pei	<L3+slen_1+2
	pei	<L3+slen_1
	pei	<L3+pto_1+2
	pei	<L3+pto_1
	pei	<L3+pfrom_1+2
	pei	<L3+pfrom_1
	pea	#^L1+29
	pea	#<L1+29
	pea	#22
	jsl	~~printf
;			if (slen != len) {
	lda	<L3+slen_1
	cmp	<L3+len_1
	bne	L6
	lda	<L3+slen_1+2
	cmp	<L3+len_1+2
L6:
	beq	L8
;				printf("warning! %lu out of %lu bytes written!\n", slen, len);
	pei	<L3+len_1+2
	pei	<L3+len_1
	pei	<L3+slen_1+2
	pei	<L3+slen_1
	pea	#^L1+69
	pea	#<L1+69
	pea	#14
	bra	L20000
;			}
;		} else {
L10002:
;			printf("error!\n");
	pea	#^L1+109
	pea	#<L1+109
	pea	#6
L20000:
	jsl	~~printf
;		}
;	}
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
L2	equ	58
L3	equ	5
	ends
	efunc
	data
L1:
	db	$73,$61,$76,$65,$20,$66,$72,$6F,$6D,$3A,$00,$20,$74,$6F,$3A
	db	$00,$20,$66,$69,$6C,$65,$6E,$61,$6D,$65,$3E,$00,$77,$00,$0A
	db	$73,$61,$76,$65,$64,$20,$66,$72,$6F,$6D,$3A,$25,$70,$20,$74
	db	$6F,$3A,$25,$70,$20,$62,$79,$74,$65,$73,$3A,$25,$6C,$75,$20
	db	$66,$69,$6C,$65,$3A,$25,$73,$0A,$00,$77,$61,$72,$6E,$69,$6E
	db	$67,$21,$20,$25,$6C,$75,$20,$6F,$75,$74,$20,$6F,$66,$20,$25
	db	$6C,$75,$20,$62,$79,$74,$65,$73,$20,$77,$72,$69,$74,$74,$65
	db	$6E,$21,$0A,$00,$65,$72,$72,$6F,$72,$21,$0A,$00
	ends
;
;
	xref	~~input
	xref	~~getHex8
	xref	~~fclose
	xref	~~fwrite
	xref	~~printf
	xref	~~fopen
