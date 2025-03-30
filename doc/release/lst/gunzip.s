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
;int inflate(char *inBuf, char *outBuf, long *outLen);
;
;char* loadFile(char *fname, long *flenout) {
	code
	xdef	~~loadFile
	func
~~loadFile:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
fname_0	set	4
flenout_0	set	8
;	FILE *fin;
;	size_t flen;
;	struct stat st;
;	char *buf;
;	
;	if (stat(fname, &st) == -1) {
fin_1	set	0
flen_1	set	4
st_1	set	8
buf_1	set	14
	pea	#0
	clc
	tdc
	adc	#<L3+st_1
	pha
	pei	<L2+fname_0+2
	pei	<L2+fname_0
	jsl	~~stat
	cmp	#<$ffffffff
	bne	L10001
;		return NULL;
L20002:
	lda	#$0
	tax
L5:
	tay
	lda	<L2+2
	sta	<L2+2+8
	lda	<L2+1
	sta	<L2+1+8
	pld
	tsc
	clc
	adc	#L2+8
	tcs
	tya
	rtl
;	}
;	*flenout = st.st_size;
L10001:
	lda	<L3+st_1+2
	sta	[<L2+flenout_0]
	lda	<L3+st_1+4
	ldy	#$2
	sta	[<L2+flenout_0],Y
;	
;	fin = fopen(fname, "rb");
	pea	#^L1
	pea	#<L1
	pei	<L2+fname_0+2
	pei	<L2+fname_0
	jsl	~~fopen
	sta	<L3+fin_1
	stx	<L3+fin_1+2
;	
;	if (fin == NULL) {
	ora	<L3+fin_1+2
	bne	L10002
;		printf("can't read file %s\n", fname);
	pei	<L2+fname_0+2
	pei	<L2+fname_0
	pea	#^L1+3
	pea	#<L1+3
	pea	#10
	jsl	~~printf
;		return NULL;
	bra	L20002
;	}
;	
;//	vbuf = malloc(1024);
;//	setvbuf(fin, vbuf, _IOFBF, 1024);
;
;	buf = malloc(st.st_size);
L10002:
	pei	<L3+st_1+4
	pei	<L3+st_1+2
	jsl	~~malloc
	sta	<L3+buf_1
	stx	<L3+buf_1+2
;	//printf("loading %s, length: %lu\n", fname, st.st_size);
;	
;	flen = fread(buf, 1, st.st_size, fin);
	pei	<L3+fin_1+2
	pei	<L3+fin_1
	pei	<L3+st_1+4
	pei	<L3+st_1+2
	pea	#^$1
	pea	#<$1
	pei	<L3+buf_1+2
	pei	<L3+buf_1
	jsl	~~fread
	sta	<L3+flen_1
	stx	<L3+flen_1+2
;	
;	//printf("%lu bytes loaded @ %p\n", flen, buf);
;	
;	fclose(fin);
	pei	<L3+fin_1+2
	pei	<L3+fin_1
	jsl	~~fclose
;	
;	return buf;
	ldx	<L3+buf_1+2
	lda	<L3+buf_1
	bra	L5
;}
L2	equ	22
L3	equ	5
	ends
	efunc
	data
L1:
	db	$72,$62,$00,$63,$61,$6E,$27,$74,$20,$72,$65,$61,$64,$20,$66
	db	$69,$6C,$65,$20,$25,$73,$0A,$00
	ends
;
;int gunzip(char *comprData, long flen) {
	code
	xdef	~~gunzip
	func
~~gunzip:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L8
	tcs
	phd
	tcd
comprData_0	set	4
flen_0	set	8
;	int flag, rc;
;	char *inBuf;
;	char *filename, *outBuf, *vbuf;
;	long *origLen, outLen;
;	FILE *fout;
;	
;	filename = NULL;
flag_1	set	0
rc_1	set	2
inBuf_1	set	4
filename_1	set	8
outBuf_1	set	12
vbuf_1	set	16
origLen_1	set	20
outLen_1	set	24
fout_1	set	28
	stz	<L9+filename_1
	stz	<L9+filename_1+2
;	
;	if (! (comprData[0] == 0x1f && comprData[1] == 0x8b)) {
	sep	#$20
	longa	off
	lda	[<L8+comprData_0]
	cmp	#<$1f
	rep	#$20
	longa	on
	bne	L10
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L8+comprData_0],Y
	cmp	#<$8b
	rep	#$20
	longa	on
	beq	L10003
L10:
;		return -1;
	lda	#$ffff
L13:
	tay
	lda	<L8+2
	sta	<L8+2+8
	lda	<L8+1
	sta	<L8+1+8
	pld
	tsc
	clc
	adc	#L8+8
	tcs
	tya
	rtl
;	}
;	
;	/*
;		bit 0   FTEXT
;		bit 1   FHCRC
;		bit 2   FEXTRA
;		bit 3   FNAME
;		bit 4   FCOMMENT
;	*/	   
;	flag = comprData[3];
L10003:
	ldy	#$3
	lda	[<L8+comprData_0],Y
	and	#$ff
	sta	<L9+flag_1
;	//printf("flag: %d\n", flag);
;		
;	inBuf = comprData+10;
	lda	#$a
	clc
	adc	<L8+comprData_0
	sta	<L9+inBuf_1
	lda	#$0
	adc	<L8+comprData_0+2
	sta	<L9+inBuf_1+2
;	
;	//skip comment
;	if (flag & 0x10) {
	lda	<L9+flag_1
	and	#<$10
	beq	L10004
;		while(*inBuf++);
L10005:
	lda	<L9+inBuf_1
	sta	<R0
	lda	<L9+inBuf_1+2
	sta	<R0+2
	inc	<L9+inBuf_1
	bne	L15
	inc	<L9+inBuf_1+2
L15:
	lda	[<R0]
	and	#$ff
	bne	L10005
;	}
;	//skip filename
;	if (flag & 0x08) {
L10004:
	lda	<L9+flag_1
	and	#<$8
	beq	L10007
;		filename = inBuf;
	lda	<L9+inBuf_1
	sta	<L9+filename_1
	lda	<L9+inBuf_1+2
	sta	<L9+filename_1+2
;		while(*inBuf++);
L10008:
	lda	<L9+inBuf_1
	sta	<R0
	lda	<L9+inBuf_1+2
	sta	<R0+2
	inc	<L9+inBuf_1
	bne	L18
	inc	<L9+inBuf_1+2
L18:
	lda	[<R0]
	and	#$ff
	bne	L10008
;	}
;	if (flag & 0x02) {
L10007:
	lda	<L9+flag_1
	and	#<$2
	beq	L10010
;		inBuf += 2;
	lda	#$2
	clc
	adc	<L9+inBuf_1
	sta	<L9+inBuf_1
	bcc	L10010
	inc	<L9+inBuf_1+2
;	}
;
;	if (filename)
L10010:
;		printf("filename: %s\n", filename);
	lda	<L9+filename_1
	ora	<L9+filename_1+2
	beq	L10011
	pei	<L9+filename_1+2
	pei	<L9+filename_1
	pea	#^L7
	pea	#<L7
	pea	#10
	jsl	~~printf
;	
;	origLen = (long *)&(comprData[flen-4]);
L10011:
	lda	#$fffc
	clc
	adc	<L8+flen_0
	sta	<R0
	lda	#$ffff
	adc	<L8+flen_0+2
	sta	<R0+2
	lda	<L8+comprData_0
	clc
	adc	<R0
	sta	<L9+origLen_1
	lda	<L8+comprData_0+2
	adc	<R0+2
	sta	<L9+origLen_1+2
;	//printf("origLen: %lu\n", *origLen);
;	
;	outBuf = malloc(*origLen);
	ldy	#$2
	lda	[<L9+origLen_1],Y
	pha
	lda	[<L9+origLen_1]
	pha
	jsl	~~malloc
	sta	<L9+outBuf_1
	stx	<L9+outBuf_1+2
;	//printf("inBuf: %p, outBuf: %p\n", inBuf, outBuf);
;	
;	rc = inflate(inBuf, outBuf, &outLen);
	pea	#0
	clc
	tdc
	adc	#<L9+outLen_1
	pha
	pei	<L9+outBuf_1+2
	pei	<L9+outBuf_1
	pei	<L9+inBuf_1+2
	pei	<L9+inBuf_1
	jsl	~~inflate
	sta	<L9+rc_1
;	//printf("rc:%d\n", rc);
;	
;	if (rc != 0) {
	lda	<L9+rc_1
	beq	L10012
;		printf("inflate: unsupported compression algorithm\n");
	pea	#^L7+14
	pea	#<L7+14
	pea	#6
	bra	L20003
L20005:
;		printf("error originalLength != outputLength (%lu != %lu)\n", *origLen, outLen);
	pei	<L9+outLen_1+2
	pei	<L9+outLen_1
	ldy	#$2
	lda	[<L9+origLen_1],Y
	pha
	lda	[<L9+origLen_1]
	pha
	pea	#^L7+58
	pea	#<L7+58
	pea	#14
;		return -1;
L20003:
	jsl	~~printf
;		return -1;
	brl	L10
;	}
;	
;	if (*origLen != outLen) {
L10012:
	lda	[<L9+origLen_1]
	cmp	<L9+outLen_1
	bne	L24
	ldy	#$2
	lda	[<L9+origLen_1],Y
	cmp	<L9+outLen_1+2
L24:
	bne	L20005
;	}
;
;	if (filename) {
	lda	<L9+filename_1
	ora	<L9+filename_1+2
	beq	L10014
;		filename = adjustFilename(filename, 0);
	pea	#<$0
	pei	<L9+filename_1+2
	pei	<L9+filename_1
	jsl	~~adjustFilename
	sta	<L9+filename_1
	stx	<L9+filename_1+2
;		
;		fout = fopen(filename, "wb");
	pea	#^L7+109
	pea	#<L7+109
	pei	<L9+filename_1+2
	pei	<L9+filename_1
	jsl	~~fopen
	sta	<L9+fout_1
	stx	<L9+fout_1+2
;		//vbuf = malloc(1024);
;		//setvbuf(fout, vbuf, _IOFBF, 1024);
;		if (fout) {
	ora	<L9+fout_1+2
	beq	L10014
;			fwrite(outBuf, 1, *origLen, fout);
	pei	<L9+fout_1+2
	pei	<L9+fout_1
	ldy	#$2
	lda	[<L9+origLen_1],Y
	pha
	lda	[<L9+origLen_1]
	pha
	pea	#^$1
	pea	#<$1
	pei	<L9+outBuf_1+2
	pei	<L9+outBuf_1
	jsl	~~fwrite
;			fclose(fout);
	pei	<L9+fout_1+2
	pei	<L9+fout_1
	jsl	~~fclose
;		}
;	}
;	return 0;
L10014:
	lda	#$0
	brl	L13
;}
L8	equ	36
L9	equ	5
	ends
	efunc
	data
L7:
	db	$66,$69,$6C,$65,$6E,$61,$6D,$65,$3A,$20,$25,$73,$0A,$00,$69
	db	$6E,$66,$6C,$61,$74,$65,$3A,$20,$75,$6E,$73,$75,$70,$70,$6F
	db	$72,$74,$65,$64,$20,$63,$6F,$6D,$70,$72,$65,$73,$73,$69,$6F
	db	$6E,$20,$61,$6C,$67,$6F,$72,$69,$74,$68,$6D,$0A,$00,$65,$72
	db	$72,$6F,$72,$20,$6F,$72,$69,$67,$69,$6E,$61,$6C,$4C,$65,$6E
	db	$67,$74,$68,$20,$21,$3D,$20,$6F,$75,$74,$70,$75,$74,$4C,$65
	db	$6E,$67,$74,$68,$20,$28,$25,$6C,$75,$20,$21,$3D,$20,$25,$6C
	db	$75,$29,$0A,$00,$77,$62,$00
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
	sbc	#L29
	tcs
	phd
	tcd
argc_0	set	4
argv_0	set	6
;	char *fname;
;	char *comprData;
;	int rc;
;	long flen;
;	
;	if (argc < 2) {
fname_1	set	0
comprData_1	set	4
rc_1	set	8
flen_1	set	10
	lda	<L29+argc_0
	bmi	L31
	dea
	dea
	bpl	L10016
L31:
;		fname = adjustFilename("z*.gz", 0);
	pea	#<$0
	pea	#^L28
	pea	#<L28
	bra	L20008
;		//printf("png <filename.png>\n");
;		//return 0;
;	} else {
L10016:
;		fname = adjustFilename(argv[1], 0);
	pea	#<$0
	ldy	#$6
	lda	[<L29+argv_0],Y
	pha
	dey
	dey
	lda	[<L29+argv_0],Y
	pha
L20008:
	jsl	~~adjustFilename
	sta	<L30+fname_1
	stx	<L30+fname_1+2
;	}
;	
;	comprData = loadFile(fname, &flen);
	pea	#0
	clc
	tdc
	adc	#<L30+flen_1
	pha
	pei	<L30+fname_1+2
	pei	<L30+fname_1
	jsl	~~loadFile
	sta	<L30+comprData_1
	stx	<L30+comprData_1+2
;	
;	if (comprData) {
	ora	<L30+comprData_1+2
	beq	L33
;		rc = gunzip(comprData, flen);
	pei	<L30+flen_1+2
	pei	<L30+flen_1
	pei	<L30+comprData_1+2
	pei	<L30+comprData_1
	jsl	~~gunzip
	sta	<L30+rc_1
;		//printf("rc=%d\n", rc);
;	}
;}
L33:
	tay
	lda	<L29+2
	sta	<L29+2+6
	lda	<L29+1
	sta	<L29+1+6
	pld
	tsc
	clc
	adc	#L29+6
	tcs
	tya
	rtl
L29	equ	14
L30	equ	1
	ends
	efunc
	data
L28:
	db	$7A,$2A,$2E,$67,$7A,$00
	ends
;
	xref	~~inflate
	xref	~~adjustFilename
	xref	~~stat
	xref	~~malloc
	xref	~~fclose
	xref	~~fwrite
	xref	~~fread
	xref	~~printf
	xref	~~fopen
