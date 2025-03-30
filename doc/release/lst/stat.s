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
;
;#include "freeRTOS.h"
;#include "task.h"
;#include <homebrew.h>
;#include <sys/stat.h>    /* LINUX/UNIX     */
;#include <sys/types.h>   /* LINUX/UNIX     */
;
;static char buffer[32] = "D:KILO.C";
	data
~~buffer:
	db	$44,$3A,$4B,$49,$4C,$4F,$2E,$43,$0
	ds	23
	ends
;static char line[100];
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
;	char rc;
;	struct stat st;
;	FILE *fin;
;	
;	unsigned int len;
;	
;	printf("stat \n");
rc_1	set	0
st_1	set	1
fin_1	set	7
len_1	set	11
	pea	#^L1
	pea	#<L1
	pea	#6
	jsl	~~printf
;
;	rc = stat(buffer, &st);
	pea	#0
	clc
	tdc
	adc	#<L3+st_1
	pha
	lda	#<~~buffer
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	jsl	~~stat
	sep	#$20
	longa	off
	sta	<L3+rc_1
	rep	#$20
	longa	on
;	
;//		dump((char *)0x20, 16, 0);
;//		dump(IOCBSTRT, 128, 0);
;//		dump((char *)0x500, 256, 0);
;	
;	//printf("stat rc: %d, len: %lu\n", rc, st.st_size);
;
;	return 0;
	lda	#$0
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
;	fin = fopen(buffer, "rb");
;	fread(line, 100, 1, fin);
;	fseek(fin, 123, SEEK_SET);
;	
;	printf("line: %s\n", line);
;	fclose(fin);
;}
L2	equ	17
L3	equ	5
	ends
	efunc
	data
L1:
	db	$73,$74,$61,$74,$20,$0A,$00,$72,$62,$00,$6C,$69,$6E,$65,$3A
	db	$20,$25,$73,$0A,$00
	ends
;
	xref	~~stat
	xref	~~fclose
	xref	~~fread
	xref	~~fseek
	xref	~~printf
	xref	~~fopen
	udata
~~line
	ds	100
	ends
