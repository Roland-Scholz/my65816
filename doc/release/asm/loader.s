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
;#define BUFSIZE	4096
;
;#ifdef RTOS
;#include "FreeRTOS.h"
;#include "task.h"
;#include "semphr.h"
;#endif
;
;//unsigned char *ucHeap16 = (unsigned char *)0x009000;
;//unsigned char *ucHeap = (unsigned char *)0x020000;
;
;void *heap_start = ( void * )0x8000;
	data
	xdef	~~heap_start
~~heap_start:
	dl	$8000
	ends
;void *heap_end = (void * )0xbfff;
	data
	xdef	~~heap_end
~~heap_end:
	dl	$BFFF
	ends
;
;static char buffer[BUFSIZE];
;
;extern unsigned char fd2iocb[8];
;
;void strupper(char *str) {
	code
	xdef	~~strupper
	func
~~strupper:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
str_0	set	4
;	while(*str != 0) {
L10001:
	lda	[<L2+str_0]
	and	#$ff
	bne	L4
	brl	L10002
L4:
;		*str = toupper(*str);
	lda	[<L2+str_0]
	and	#$ff
	pha
	jsl	~~toupper
	sep	#$20
	longa	off
	sta	[<L2+str_0]
	rep	#$20
	longa	on
;		str++;
	inc	<L2+str_0
	bne	L5
	inc	<L2+str_0+2
L5:
;	}
	brl	L10001
L10002:
;}
L6:
	lda	<L2+2
	sta	<L2+2+4
	lda	<L2+1
	sta	<L2+1+4
	pld
	tsc
	clc
	adc	#L2+4
	tcs
	rtl
L2	equ	0
L3	equ	1
	ends
	efunc
;
;void loaderTask()
;{
	code
	xdef	~~loaderTask
	func
~~loaderTask:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L7
	tcs
	phd
	tcd
;	FILE *fin;
;	size_t r;
;	char *p;
;	unsigned int i;
;	int fd;
;	struct stat *stats;
;	
;	p = (char *)0x010000;
fin_1	set	0
r_1	set	4
p_1	set	6
i_1	set	10
fd_1	set	12
stats_1	set	14
	lda	#$0
	sta	<L8+p_1
	lda	#$1
	sta	<L8+p_1+2
;	
;	//setvbuf(stdin, NULL, _IONBF, 1);
;	
;	printf("loading rtest.a\n");
	pea	#^L1
	pea	#<L1
	pea	#6
	jsl	~~printf
;
;	if(stat("D:RTEST.A", stats) != -1) {
	pei	<L8+stats_1+2
	pei	<L8+stats_1
	pea	#^L1+17
	pea	#<L1+17
	jsl	~~stat
	sta	<R0
	lda	<R0
	cmp	#<$ffffffff
	bne	L9
	brl	L10003
L9:
;		printf("length: %lu\n", stats->st_size); 
	ldy	#$4
	lda	[<L8+stats_1],Y
	pha
	ldy	#$2
	lda	[<L8+stats_1],Y
	pha
	pea	#^L1+27
	pea	#<L1+27
	pea	#10
	jsl	~~printf
;		//printf("length: %lx\n", (unsigned long)0xCafebabe); 
;	}
;	
;	fin = fopen("D:RTEST.A", "r");
L10003:
	pea	#^L1+50
	pea	#<L1+50
	pea	#^L1+40
	pea	#<L1+40
	jsl	~~fopen
	sta	<L8+fin_1
	stx	<L8+fin_1+2
;	if (fin == NULL) {
	lda	<L8+fin_1
	ora	<L8+fin_1+2
	beq	L10
	brl	L10004
L10:
;		printf("can't load\n");
	pea	#^L1+52
	pea	#<L1+52
	pea	#6
	jsl	~~printf
;		return;
L11:
	pld
	tsc
	clc
	adc	#L7
	tcs
	rtl
;	}
;
;	fd = fileno(fin);
L10004:
	ldy	#$e
	lda	[<L8+fin_1],Y
	and	#$ff
	sta	<L8+fd_1
;	
;	for(i = 0; i < 16; i++){
	stz	<L8+i_1
L10007:
;		//r = fread(buffer, 1, BUFSIZE, fin);
;		r = read(fd, buffer, BUFSIZE);
	pea	#<$1000
	lda	#<~~buffer
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L8+fd_1
	jsl	~~read
	sta	<L8+r_1
;		//printf("%d dummy bytes read\n", r);
;	}
L10005:
	inc	<L8+i_1
	lda	<L8+i_1
	cmp	#<$10
	bcs	L12
	brl	L10007
L12:
L10006:
;	
;	
;	for(;;) {
L10010:
;		//r = fread(p, 1, BUFSIZE, fin);
;		r = read(fd, p, BUFSIZE);
	pea	#<$1000
	pei	<L8+p_1+2
	pei	<L8+p_1
	pei	<L8+fd_1
	jsl	~~read
	sta	<L8+r_1
;		printf("%d bytes read @ %p\n", r, p);
	pei	<L8+p_1+2
	pei	<L8+p_1
	pei	<L8+r_1
	pea	#^L1+64
	pea	#<L1+64
	pea	#12
	jsl	~~printf
;		p += r;
	lda	<L8+r_1
	sta	<R0
	stz	<R0+2
	clc
	lda	<L8+p_1
	adc	<R0
	sta	<L8+p_1
	lda	<L8+p_1+2
	adc	<R0+2
	sta	<L8+p_1+2
;		if (r != BUFSIZE) break;
	lda	<L8+r_1
	cmp	#<$1000
	beq	L13
	brl	L10009
L13:
;	}
L10008:
	brl	L10010
L10009:
;	
;	fclose(fin);
	pei	<L8+fin_1+2
	pei	<L8+fin_1
	jsl	~~fclose
;}	
	brl	L11
L7	equ	22
L8	equ	5
	ends
	efunc
	data
L1:
	db	$6C,$6F,$61,$64,$69,$6E,$67,$20,$72,$74,$65,$73,$74,$2E,$61
	db	$0A,$00,$44,$3A,$52,$54,$45,$53,$54,$2E,$41,$00,$6C,$65,$6E
	db	$67,$74,$68,$3A,$20,$25,$6C,$75,$0A,$00,$44,$3A,$52,$54,$45
	db	$53,$54,$2E,$41,$00,$72,$00,$63,$61,$6E,$27,$74,$20,$6C,$6F
	db	$61,$64,$0A,$00,$25,$64,$20,$62,$79,$74,$65,$73,$20,$72,$65
	db	$61,$64,$20,$40,$20,$25,$70,$0A,$00
	ends
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
	sbc	#L15
	tcs
	phd
	tcd
argc_0	set	4
argv_0	set	6
;	
;	int rc;
;	
;	//asm {wdm 7;};
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
;	//printf("Hallo\n");
;	loaderTask();
	jsl	~~loaderTask
;	return 0;
	lda	#$0
L17:
	tay
	lda	<L15+2
	sta	<L15+2+6
	lda	<L15+1
	sta	<L15+1+6
	pld
	tsc
	clc
	adc	#L15+6
	tcs
	tya
	rtl
;}
L15	equ	2
L16	equ	1
	ends
	efunc
;
	xref	~~read
	xref	~~stat
	xref	~~toupper
	xref	~~printf
	xref	~~fopen
	xref	~~fclose
	xref	~~fd2iocb
	udata
~~buffer
	ds	4096
	ends
	end
