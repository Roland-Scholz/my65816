;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
;#include <stdio.h>
;#include <stdlib.h>
;#include <string.h>
;#include <stdbool.h>
;
;#include <homebrew.h>
;
;#define BUFSIZE	512
;
;#ifdef RTOS
;#include "FreeRTOS.h"
;#include "task.h"
;#include "semphr.h"
;#endif
;
;void *heap_start = ( void * )0x8000;
	data
	xdef	~~heap_start
~~heap_start:
	dl	$8000
	ends
;void *heap_end = (void * )0xafff;
	data
	xdef	~~heap_end
~~heap_end:
	dl	$AFFF
	ends
;
;static char buffer[BUFSIZE];
;static char fname[16];
;
;extern unsigned char fd2iocb[8];
;
;static char inbyte() {
	code
	func
~~inbyte:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
;	while (!(LSR0 & 0x01));
L10001:
	sep	#$20
	longa	off
	lda	>16777189
	and	#<$1
	rep	#$20
	longa	on
	beq	L4
	brl	L10002
L4:
	brl	L10001
L10002:
;	return RBR0;
	lda	>16777184
	and	#$ff
L5:
	tay
	pld
	tsc
	clc
	adc	#L2
	tcs
	tya
	rtl
;}
L2	equ	0
L3	equ	1
	ends
	efunc
;
;static void outbyte(int c) {
	code
	func
~~outbyte:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L6
	tcs
	phd
	tcd
c_0	set	4
;	while (!(LSR0 & 0x40));
L10003:
	sep	#$20
	longa	off
	lda	>16777189
	and	#<$40
	rep	#$20
	longa	on
	beq	L8
	brl	L10004
L8:
	brl	L10003
L10004:
;	THR0 = c;
	sep	#$20
	longa	off
	lda	<L6+c_0
	sta	>16777184
	rep	#$20
	longa	on
;}
L9:
	lda	<L6+2
	sta	<L6+2+2
	lda	<L6+1
	sta	<L6+1+2
	pld
	tsc
	clc
	adc	#L6+2
	tcs
	rtl
L6	equ	0
L7	equ	1
	ends
	efunc
;
;int receiveFile() {
	code
	xdef	~~receiveFile
	func
~~receiveFile:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L10
	tcs
	phd
	tcd
;	
;	unsigned int i, bytes;
;	char c[4];
;	FILE *f;
;	
;	//printf("receiving file...\n");
;	outbyte('A');
i_1	set	0
bytes_1	set	2
c_1	set	4
f_1	set	8
	pea	#<$41
	jsl	~~outbyte
;	
;	i = 2;
	lda	#$2
	sta	<L11+i_1
;	fname[0] = 'D';
	sep	#$20
	longa	off
	lda	#$44
	sta	|~~fname
	rep	#$20
	longa	on
;	fname[1] = ':';
	sep	#$20
	longa	off
	lda	#$3a
	sta	|~~fname+1
	rep	#$20
	longa	on
;	
;	while (i < 16) {
L10005:
	lda	<L11+i_1
	cmp	#<$10
	bcc	L12
	brl	L10006
L12:
;
;		fname[i] = inbyte();
	jsl	~~inbyte
	sep	#$20
	longa	off
	ldx	<L11+i_1
	sta	|~~fname,X
	rep	#$20
	longa	on
;		
;		if (fname[i] == 0) break;
	ldx	<L11+i_1
	lda	|~~fname,X
	and	#$ff
	bne	L13
	brl	L10006
L13:
;		if (fname[i] == 0x0A) {
	sep	#$20
	longa	off
	ldx	<L11+i_1
	lda	|~~fname,X
	cmp	#<$a
	rep	#$20
	longa	on
	beq	L14
	brl	L10007
L14:
;			fname[i] = 0;
	sep	#$20
	longa	off
	lda	#$0
	ldx	<L11+i_1
	sta	|~~fname,X
	rep	#$20
	longa	on
;			break;
	brl	L10006
;		}
;		i++;
L10007:
	inc	<L11+i_1
;	}
	brl	L10005
L10006:
;	
;	printf("receiving file: '%s'\n", fname);
	lda	#<~~fname
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	pea	#^L1
	pea	#<L1
	pea	#10
	jsl	~~printf
;	
;	f = fopen(fname, "wb");
	pea	#^L1+22
	pea	#<L1+22
	lda	#<~~fname
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~fopen
	sta	<L11+f_1
	stx	<L11+f_1+2
;	if (f == NULL) {
	lda	<L11+f_1
	ora	<L11+f_1+2
	beq	L15
	brl	L10008
L15:
;		outbyte('E');
	pea	#<$45
	jsl	~~outbyte
;		printf("error: %d\n", errno);
	lda	|~~errno
	pha
	pea	#^L1+25
	pea	#<L1+25
	pea	#8
	jsl	~~printf
;	} else {
	brl	L10009
L10008:
;		bytes = 1;
	lda	#$1
	sta	<L11+bytes_1
;		while (bytes != 0) {
L10010:
	lda	<L11+bytes_1
	bne	L16
	brl	L10011
L16:
;			
;			//for (i = 0; i < 100; i++);
;			
;			outbyte('A');
	pea	#<$41
	jsl	~~outbyte
;			
;			for (i = 0; i < 3; i++) {
	stz	<L11+i_1
L10014:
;				c[i] = inbyte();
	jsl	~~inbyte
	sep	#$20
	longa	off
	ldx	<L11+i_1
	sta	<L11+c_1,X
	rep	#$20
	longa	on
;			}
L10012:
	inc	<L11+i_1
	lda	<L11+i_1
	cmp	#<$3
	bcs	L17
	brl	L10014
L17:
L10013:
;
;			c[3] = 0;
	sep	#$20
	longa	off
	stz	<L11+c_1+3
	rep	#$20
	longa	on
;			
;			bytes = atoi(c);
	pea	#0
	clc
	tdc
	adc	#<L11+c_1
	pha
	jsl	~~atoi
	sta	<L11+bytes_1
;			//printf("receiving bytes: %s %d\n", c, bytes);
;			outbyte('A');
	pea	#<$41
	jsl	~~outbyte
;			
;			for (i = 0; i < bytes; i++) {
	stz	<L11+i_1
	brl	L10018
L10017:
;				buffer[i] = inbyte();
	jsl	~~inbyte
	sep	#$20
	longa	off
	ldx	<L11+i_1
	sta	|~~buffer,X
	rep	#$20
	longa	on
;			}
L10015:
	inc	<L11+i_1
L10018:
	lda	<L11+i_1
	cmp	<L11+bytes_1
	bcs	L18
	brl	L10017
L18:
L10016:
;			//printf("received \n");
;			
;			if (bytes) {
	lda	<L11+bytes_1
	bne	L19
	brl	L10019
L19:
;				fwrite(buffer, 1, bytes, f);
	pei	<L11+f_1+2
	pei	<L11+f_1
	pei	<L11+bytes_1
	pea	#<$1
	lda	#<~~buffer
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~fwrite
;			}
;			//printf("written \n");
;		}
L10019:
	brl	L10010
L10011:
;		fclose(f);
	pei	<L11+f_1+2
	pei	<L11+f_1
	jsl	~~fclose
;		outbyte('C');
	pea	#<$43
	jsl	~~outbyte
;	}
L10009:
;	
;	return 1;
	lda	#$1
L20:
	tay
	pld
	tsc
	clc
	adc	#L10
	tcs
	tya
	rtl
;}
L10	equ	16
L11	equ	5
	ends
	efunc
	data
L1:
	db	$72,$65,$63,$65,$69,$76,$69,$6E,$67,$20,$66,$69,$6C,$65,$3A
	db	$20,$27,$25,$73,$27,$0A,$00,$77,$62,$00,$65,$72,$72,$6F,$72
	db	$3A,$20,$25,$64,$0A,$00
	ends
;
;int sendFile() {
	code
	xdef	~~sendFile
	func
~~sendFile:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L22
	tcs
	phd
	tcd
;}
L24:
	tay
	pld
	tsc
	clc
	adc	#L22
	tcs
	tya
	rtl
L22	equ	0
L23	equ	1
	ends
	efunc
;
;void server() {
	code
	xdef	~~server
	func
~~server:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L25
	tcs
	phd
	tcd
;	char c;
;		
;	c = 0;
c_1	set	0
	sep	#$20
	longa	off
	stz	<L26+c_1
	rep	#$20
	longa	on
;	
;	while (c != 'X') {
L10020:
	sep	#$20
	longa	off
	lda	<L26+c_1
	cmp	#<$58
	rep	#$20
	longa	on
	bne	L27
	brl	L10021
L27:
;		printf("R - receive file\n");
	pea	#^L21
	pea	#<L21
	pea	#6
	jsl	~~printf
;		printf("S - send file\n");
	pea	#^L21+18
	pea	#<L21+18
	pea	#6
	jsl	~~printf
;		printf("X - exit\n");
	pea	#^L21+33
	pea	#<L21+33
	pea	#6
	jsl	~~printf
;		
;		c = inbyte();
	jsl	~~inbyte
	sep	#$20
	longa	off
	sta	<L26+c_1
	rep	#$20
	longa	on
;		if (c == 'R') {
	sep	#$20
	longa	off
	lda	<L26+c_1
	cmp	#<$52
	rep	#$20
	longa	on
	beq	L28
	brl	L10022
L28:
;			receiveFile();
	jsl	~~receiveFile
;		}
;		if (c == 'S') {
L10022:
	sep	#$20
	longa	off
	lda	<L26+c_1
	cmp	#<$53
	rep	#$20
	longa	on
	beq	L29
	brl	L10023
L29:
;			sendFile();
	jsl	~~sendFile
;		}
;	}
L10023:
	brl	L10020
L10021:
;	
;}
L30:
	pld
	tsc
	clc
	adc	#L25
	tcs
	rtl
L25	equ	1
L26	equ	1
	ends
	efunc
	data
L21:
	db	$52,$20,$2D,$20,$72,$65,$63,$65,$69,$76,$65,$20,$66,$69,$6C
	db	$65,$0A,$00,$53,$20,$2D,$20,$73,$65,$6E,$64,$20,$66,$69,$6C
	db	$65,$0A,$00,$58,$20,$2D,$20,$65,$78,$69,$74,$0A,$00
	ends
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
	sbc	#L32
	tcs
	phd
	tcd
argc_0	set	4
argv_0	set	6
;	
;	int rc;
;	
;    fd2iocb[0] = 0;
rc_1	set	0
	sep	#$20
	longa	off
	stz	|~~fd2iocb
	rep	#$20
	longa	on
;    fd2iocb[1] = 0;
	sep	#$20
	longa	off
	stz	|~~fd2iocb+1
	rep	#$20
	longa	on
;    fd2iocb[2] = 0;
	sep	#$20
	longa	off
	stz	|~~fd2iocb+2
	rep	#$20
	longa	on
;    fd2iocb[3] = 0xff;
	sep	#$20
	longa	off
	lda	#$ff
	sta	|~~fd2iocb+3
	rep	#$20
	longa	on
;    fd2iocb[4] = 0xff;
	sep	#$20
	longa	off
	lda	#$ff
	sta	|~~fd2iocb+4
	rep	#$20
	longa	on
;    fd2iocb[5] = 0xff;
	sep	#$20
	longa	off
	lda	#$ff
	sta	|~~fd2iocb+5
	rep	#$20
	longa	on
;    fd2iocb[6] = 0xff;
	sep	#$20
	longa	off
	lda	#$ff
	sta	|~~fd2iocb+6
	rep	#$20
	longa	on
;    fd2iocb[7] = 0xff;
	sep	#$20
	longa	off
	lda	#$ff
	sta	|~~fd2iocb+7
	rep	#$20
	longa	on
;	
;	server();
	jsl	~~server
;	return 0;
	lda	#$0
L34:
	tay
	lda	<L32+2
	sta	<L32+2+6
	lda	<L32+1
	sta	<L32+1+6
	pld
	tsc
	clc
	adc	#L32+6
	tcs
	tya
	rtl
;}
L32	equ	2
L33	equ	1
	ends
	efunc
;
	xref	~~atoi
	xref	~~printf
	xref	~~fwrite
	xref	~~fopen
	xref	~~fclose
	xref	~~fd2iocb
	udata
~~fname
	ds	16
	ends
	udata
~~buffer
	ds	512
	ends
	xref	~~errno
	end
