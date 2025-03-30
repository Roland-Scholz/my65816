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
;
;
;static unsigned int i, sec, min, hour;
;static char s[10];
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
;	const TickType_t xDelay = 200;
;	char *screen = (char *)0x7FF800+72;
;	unsigned int i;
;	
;	sec = min = hour = 0;
xDelay_1	set	0
screen_1	set	2
i_1	set	6
	lda	#$c8
	sta	<L3+xDelay_1
	lda	#$f848
	sta	<L3+screen_1
	lda	#$7f
	sta	<L3+screen_1+2
	stz	|~~hour
	stz	|~~min
	stz	|~~sec
;	
;	hour = atoi(argv[1]);
	ldy	#$6
	lda	[<L2+argv_0],Y
	pha
	dey
	dey
	lda	[<L2+argv_0],Y
	pha
	jsl	~~atoi
	sta	|~~hour
;	min = atoi(argv[2]);
	ldy	#$a
	lda	[<L2+argv_0],Y
	pha
	dey
	dey
	lda	[<L2+argv_0],Y
	pha
	jsl	~~atoi
	sta	|~~min
;	
;	for(;;) {
L10003:
;		sec++;
	inc	|~~sec
;		if (sec == 60) {
	lda	|~~sec
	cmp	#<$3c
	bne	L10004
;			sec = 0;
	stz	|~~sec
;			min++;
	inc	|~~min
;			if (min == 60) {
	lda	|~~min
	cmp	#<$3c
	bne	L10004
;				min = 0;
	stz	|~~min
;				hour++;
	inc	|~~hour
;				if (hour == 24) hour = 0;
	lda	|~~hour
	cmp	#<$18
	bne	L10004
	stz	|~~hour
;			}
;		}
;		
;		sprintf(s, "%02d:%02d:%02d", hour, min, sec);
L10004:
	lda	|~~sec
	pha
	lda	|~~min
	pha
	lda	|~~hour
	pha
	pea	#^L1
	pea	#<L1
	lda	#<~~s
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	pea	#16
	jsl	~~sprintf
;		//memcpy(screen, s, 8);
;		for (i = 0; i < 8; i++) {
	stz	<L3+i_1
L10009:
;			screen[i] = s[i];
	sep	#$20
	longa	off
	ldx	<L3+i_1
	lda	|~~s,X
	ldy	<L3+i_1
	sta	[<L3+screen_1],Y
	rep	#$20
	longa	on
;		}
	inc	<L3+i_1
	lda	<L3+i_1
	cmp	#<$8
	bcc	L10009
;		vTaskDelay(xDelay);
	pea	#<$c8
	jsl	~~vTaskDelay
;	}
	bra	L10003
;}
L2	equ	12
L3	equ	5
	ends
	efunc
	data
L1:
	db	$25,$30,$32,$64,$3A,$25,$30,$32,$64,$3A,$25,$30,$32,$64,$00
	ends
;
	xref	~~vTaskDelay
	xref	~~atoi
	xref	~~sprintf
	udata
~~s
	ds	10
	ends
	udata
~~hour
	ds	2
	ends
	udata
~~min
	ds	2
	ends
	udata
~~sec
	ds	2
	ends
	udata
~~i
	ds	2
	ends
