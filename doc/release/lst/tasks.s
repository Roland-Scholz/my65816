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
;	char *str = malloc(8 * 1024);
;
;	vTaskList(str);
str_1	set	0
	pea	#^$2000
	pea	#<$2000
	jsl	~~malloc
	sta	<L3+str_1
	stx	<L3+str_1+2
	pei	<L3+str_1+2
	pei	<L3+str_1
	jsl	~~vTaskList
;	printf("%s", str);
	pei	<L3+str_1+2
	pei	<L3+str_1
	pea	#^L1
	pea	#<L1
	pea	#10
	jsl	~~printf
;	free(str);
	pei	<L3+str_1+2
	pei	<L3+str_1
	jsl	~~free
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
L2	equ	4
L3	equ	1
	ends
	efunc
	data
L1:
	db	$25,$73,$00
	ends
;
	xref	~~vTaskList
	xref	~~free
	xref	~~malloc
	xref	~~printf
