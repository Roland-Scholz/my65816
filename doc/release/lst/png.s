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
;//#include "tinf.h"
;//#include "puff.h"
;
;int inflate(char *, char *, unsigned long *);
;
;struct image {
;	char *data;
;	unsigned long width;
;	unsigned long height;
;	char palette[256];
;	unsigned int depth;
;	unsigned int colorType;
;	unsigned long dataLength; 
;	unsigned int bytesPerPixel;
;	unsigned int bytesPerScanline;
;};	
;typedef struct image t_image;
;
;struct header {
;	char png[4];
;	char txt[4];
;};
;typedef struct header t_header;
;
;struct chunk {
;	unsigned long len;
;	char name[4];
;};
;typedef struct chunk t_chunk;
;
;struct chunkIDAT {
;	unsigned long len;
;	char name[4];
;	unsigned long width;
;	unsigned long height;
;	char depth;
;	char colorType;
;	char compression;
;	char filter;
;	char interlace;
;	unsigned long crc;
;};
;typedef struct chunkIDAT t_chunkIDAT;
;
;
;//FILE *stdin, *stdout, *stderr;
;t_image image;
;
;	
;size_t swapLong(size_t in) {
	code
	xdef	~~swapLong
	func
~~swapLong:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
in_0	set	4
;	size_t out;
;	char *s, *d;
;
;	s = (char *)&in;
out_1	set	0
s_1	set	4
d_1	set	8
	clc
	tdc
	adc	#<L2+in_0
	sta	<L3+s_1
	lda	#$0
	sta	<L3+s_1+2
;	d = (char *)&out;
	clc
	tdc
	adc	#<L3+out_1
	sta	<L3+d_1
	lda	#$0
	sta	<L3+d_1+2
;	
;	d[0] = s[3];
	sep	#$20
	longa	off
	ldy	#$3
	lda	[<L3+s_1],Y
	sta	[<L3+d_1]
;	d[1] = s[2];
	dey
	lda	[<L3+s_1],Y
	dey
	sta	[<L3+d_1],Y
;	d[2] = s[1];
	lda	[<L3+s_1],Y
	iny
	sta	[<L3+d_1],Y
;	d[3] = s[0];
	lda	[<L3+s_1]
	iny
	sta	[<L3+d_1],Y
	rep	#$20
	longa	on
;	
;	return out;
	ldx	<L3+out_1+2
	lda	<L3+out_1
	tay
	lda	<L2+2
	sta	<L2+2+4
	lda	<L2+1
	sta	<L2+1+4
	pld
	tsc
	clc
	adc	#L2+4
	tcs
	tya
	rtl
;}
L2	equ	12
L3	equ	1
	ends
	efunc
;
;unsigned int computeBytesPerScanline(unsigned int bytesPerPixel, unsigned int imageWidth) {
	code
	xdef	~~computeBytesPerScanline
	func
~~computeBytesPerScanline:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L5
	tcs
	phd
	tcd
bytesPerPixel_0	set	4
imageWidth_0	set	6
;	
;	unsigned int bytesPerScanline;
;	
;	bytesPerScanline = imageWidth * bytesPerPixel;
bytesPerScanline_1	set	0
	lda	<L5+imageWidth_0
	ldx	<L5+bytesPerPixel_0
	xref	~~~mul
	jsl	~~~mul
	sta	<L6+bytesPerScanline_1
;	
;	switch(image.depth) {
	lda	|~~image+268
	xref	~~~swt
	jsl	~~~swt
	dw	4
	dw	1
	dw	L10003-1
	dw	2
	dw	L10004-1
	dw	4
	dw	L10005-1
	dw	16
	dw	L10007-1
	dw	L10002-1
;	case 1:
L10003:
;		bytesPerScanline >>= 3;
	lda	<L6+bytesPerScanline_1
	lsr	A
	lsr	A
	lsr	A
	sta	<L6+bytesPerScanline_1
;		break;		
L10002:
;
;	return bytesPerScanline;
	lda	<L6+bytesPerScanline_1
	tay
	lda	<L5+2
	sta	<L5+2+4
	lda	<L5+1
	sta	<L5+1+4
	pld
	tsc
	clc
	adc	#L5+4
	tcs
	tya
	rtl
;	case 2:
L10004:
;		bytesPerScanline >>= 2;
	lsr	<L6+bytesPerScanline_1
	lsr	<L6+bytesPerScanline_1
;		break;		
	bra	L10002
;	case 4:
L10005:
;		bytesPerScanline >>= 1;
	lsr	<L6+bytesPerScanline_1
;		if (imageWidth & 0x1) bytesPerScanline++;
	lda	<L5+imageWidth_0
	and	#<$1
	beq	L10002
	inc	<L6+bytesPerScanline_1
;		break;		
	bra	L10002
;	case 16:
L10007:
;		bytesPerScanline <<= 1;
	asl	<L6+bytesPerScanline_1
;		break;
	bra	L10002
;	}
;}
L5	equ	2
L6	equ	1
	ends
	efunc
;
;
;unsigned int computeBytesPerPixel(unsigned int colorType) {
	code
	xdef	~~computeBytesPerPixel
	func
~~computeBytesPerPixel:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L9
	tcs
	phd
	tcd
colorType_0	set	4
;	
;	unsigned int bytesPerPixel;
;	
;	bytesPerPixel = 1;
bytesPerPixel_1	set	0
	lda	#$1
	sta	<L10+bytesPerPixel_1
;	
;	switch(colorType) {
	lda	<L9+colorType_0
	xref	~~~swt
	jsl	~~~swt
	dw	3
	dw	2
	dw	L10010-1
	dw	4
	dw	L10011-1
	dw	6
	dw	L10012-1
	dw	L10009-1
;	//depth: 1,2,4,8,16  Each pixel is a grayscale sample.
;	//case 0:
;	//	break;
;	//depth: 8,16        Each pixel is an R,G,B triple.
;	case 2:
L10010:
;		bytesPerPixel = 3;
	lda	#$3
L20000:
	sta	<L10+bytesPerPixel_1
;		break;
L10009:
;	
;	if (image.depth == 16)
;		bytesPerPixel <<= 1;
	lda	|~~image+268
	cmp	#<$10
	bne	L10014
;	default:
;		break;
;	}
	asl	<L10+bytesPerPixel_1
;	
;	return bytesPerPixel;
L10014:
	lda	<L10+bytesPerPixel_1
	tay
	lda	<L9+2
	sta	<L9+2+2
	lda	<L9+1
	sta	<L9+1+2
	pld
	tsc
	clc
	adc	#L9+2
	tcs
	tya
	rtl
;	//depth: 1,2,4,8     Each pixel is a palette index;
;	//case 3:
;	//	break;
;	//depth: 8,16        Each pixel is a grayscale sample, followed by an alpha sample.	
;	case 4:
L10011:
;		bytesPerPixel = 2;
	lda	#$2
	bra	L20000
;		break;
;	//depth: 8,16        Each pixel is an R,G,B triple, followed by an alpha sample.
;	case 6:
L10012:
;		bytesPerPixel = 4;
	lda	#$4
	bra	L20000
;		break;
;}
L9	equ	2
L10	equ	1
	ends
	efunc
;
;void standardPalette() {
	code
	xdef	~~standardPalette
	func
~~standardPalette:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L13
	tcs
	phd
	tcd
;	unsigned int *palette;
;	unsigned int i, c;
;
;	palette	= (unsigned int *)PALETTE;
palette_1	set	0
i_1	set	4
c_1	set	6
	lda	#$fc00
	sta	<L14+palette_1
	lda	#$ff
	sta	<L14+palette_1+2
;	
;	for (i = 0; i < 256; i++) {
	stz	<L14+i_1
L10017:
;		c = i << 1;
	lda	<L14+i_1
	asl	A
	sta	<L14+c_1
;		c &= 0xff80;
	lda	#$7f
	trb	<L14+c_1
;		c |= i & 0x3f;
	lda	<L14+i_1
	and	#<$3f
	tsb	<L14+c_1
;		*palette = c;
	lda	<L14+c_1
	sta	[<L14+palette_1]
;		palette++;
	lda	#$2
	clc
	adc	<L14+palette_1
	sta	<L14+palette_1
	bcc	L10015
	inc	<L14+palette_1+2
;	}
L10015:
	inc	<L14+i_1
	lda	<L14+i_1
	cmp	#<$100
	bcc	L10017
;}
	pld
	tsc
	clc
	adc	#L13
	tcs
	rtl
L13	equ	12
L14	equ	5
	ends
	efunc
;
;int doPNG(char *buf, size_t len) {
	code
	xdef	~~doPNG
	func
~~doPNG:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L18
	tcs
	phd
	tcd
buf_0	set	4
len_0	set	8
;	t_header *header;
;	t_chunk *chunk;
;	t_chunkIDAT *idat;
;	char name[5], *plte, *compressedData, *palette;
;	unsigned long chunklen, imageLen;
;	unsigned int x, y, xp;
;	int rc;
;	
;	header = (t_header *) buf;
header_1	set	0
chunk_1	set	4
idat_1	set	8
name_1	set	12
plte_1	set	17
compressedData_1	set	21
palette_1	set	25
chunklen_1	set	29
imageLen_1	set	33
x_1	set	37
y_1	set	39
xp_1	set	41
rc_1	set	43
	lda	<L18+buf_0
	sta	<L19+header_1
	lda	<L18+buf_0+2
	sta	<L19+header_1+2
;	name[4] = 0;
	sep	#$20
	longa	off
	stz	<L19+name_1+4
	rep	#$20
	longa	on
;	compressedData = NULL;
	stz	<L19+compressedData_1
	stz	<L19+compressedData_1+2
;	imageLen = 0;
	stz	<L19+imageLen_1
	stz	<L19+imageLen_1+2
;	palette = (char *)PALETTE;
	lda	#$fc00
	sta	<L19+palette_1
	lda	#$ff
	sta	<L19+palette_1+2
;	
;	standardPalette();
	jsl	~~standardPalette
;	
;	if (!(header->png[0] == 0x89 &&
;		header->png[1] == 'P' &&
;		header->png[2] == 'N' &&
;		header->png[3] == 'G')) {
	sep	#$20
	longa	off
	lda	[<L19+header_1]
	cmp	#<$89
	rep	#$20
	longa	on
	bne	L20
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L19+header_1],Y
	cmp	#<$50
	rep	#$20
	longa	on
	bne	L20
	sep	#$20
	longa	off
	iny
	lda	[<L19+header_1],Y
	cmp	#<$4e
	rep	#$20
	longa	on
	bne	L20
	sep	#$20
	longa	off
	iny
	lda	[<L19+header_1],Y
	cmp	#<$47
	rep	#$20
	longa	on
	beq	L10018
L20:
;			
;		printf("no PNG file!\n");
	pea	#^L1
	pea	#<L1
	pea	#6
	jsl	~~printf
;		return -1;
L20004:
	lda	#$ffff
L25:
	tay
	lda	<L18+2
	sta	<L18+2+8
	lda	<L18+1
	sta	<L18+1+8
	pld
	tsc
	clc
	adc	#L18+8
	tcs
	tya
	rtl
;	}
;	
;	buf += sizeof(t_header);
L10018:
	clc
	lda	#$8
L20007:
	adc	<L18+buf_0
	sta	<L18+buf_0
	bcc	L10021
	inc	<L18+buf_0+2
;	
;	for(;;) {
L10021:
;		chunk = (t_chunk *) buf;
	lda	<L18+buf_0
	sta	<L19+chunk_1
	lda	<L18+buf_0+2
	sta	<L19+chunk_1+2
;		if (!memcmp(chunk->name, "IHDR", 4)) {
	pea	#^$4
	pea	#<$4
	pea	#^L1+14
	pea	#<L1+14
	lda	#$4
	clc
	adc	<L19+chunk_1
	sta	<R0
	lda	#$0
	adc	<L19+chunk_1+2
	pha
	pei	<R0
	jsl	~~memcmp
	tax
	beq	*+5
	brl	L10022
;			idat = (t_chunkIDAT *) chunk;
	lda	<L19+chunk_1
	sta	<L19+idat_1
	lda	<L19+chunk_1+2
	sta	<L19+idat_1+2
;			image.width = swapLong(idat->width);
	ldy	#$a
	lda	[<L19+idat_1],Y
	pha
	dey
	dey
	lda	[<L19+idat_1],Y
	pha
	jsl	~~swapLong
	sta	|~~image+4
	stx	|~~image+4+2
;			image.height = swapLong(idat->height);
	ldy	#$e
	lda	[<L19+idat_1],Y
	pha
	dey
	dey
	lda	[<L19+idat_1],Y
	pha
	jsl	~~swapLong
	sta	|~~image+8
	stx	|~~image+8+2
;			image.depth = idat->depth;
	ldy	#$10
	lda	[<L19+idat_1],Y
	and	#$ff
	sta	|~~image+268
;			image.colorType = idat->colorType;
	iny
	lda	[<L19+idat_1],Y
	and	#$ff
	sta	|~~image+270
;			image.bytesPerPixel = computeBytesPerPixel(image.colorType);
	pha
	jsl	~~computeBytesPerPixel
	sta	|~~image+276
;			image.bytesPerScanline = computeBytesPerScanline(image.bytesPerPixel, image.width);
	lda	|~~image+4
	pha
	lda	|~~image+276
	pha
	jsl	~~computeBytesPerScanline
	sta	|~~image+278
;
;			printf("width: %lu, height: %lu, depth: %d, colType: %d, bpP: %d, bpS: %d\n", 
;					image.width, image.height, image.depth, image.colorType, image.bytesPerPixel, image.bytesPerScanline);
	pha
	lda	|~~image+276
	pha
	lda	|~~image+270
	pha
	lda	|~~image+268
	pha
	lda	|~~image+8+2
	pha
	lda	|~~image+8
	pha
	lda	|~~image+4+2
	pha
	lda	|~~image+4
	pha
	pea	#^L1+19
	pea	#<L1+19
	pea	#22
	jsl	~~printf
;					
;			buf += sizeof(t_chunkIDAT);
	clc
	lda	#$19
	brl	L20007
;			continue;
;		}
;	
;		memcpy(name, chunk->name, 4);
L10022:
	pea	#^$4
	pea	#<$4
	lda	#$4
	clc
	adc	<L19+chunk_1
	sta	<R0
	lda	#$0
	adc	<L19+chunk_1+2
	pha
	pei	<R0
	pea	#0
	clc
	tdc
	adc	#<L19+name_1
	pha
	jsl	~~memcpy
;		chunklen = swapLong(chunk->len);
	ldy	#$2
	lda	[<L19+chunk_1],Y
	pha
	lda	[<L19+chunk_1]
	pha
	jsl	~~swapLong
	sta	<L19+chunklen_1
	stx	<L19+chunklen_1+2
;		
;		//printf("chunk: %s, len: %lu\n", name, chunklen);
;		
;		if (!memcmp(chunk->name, "IDAT", 4)) {
	pea	#^$4
	pea	#<$4
	pea	#^L1+86
	pea	#<L1+86
	lda	#$4
	clc
	adc	<L19+chunk_1
	sta	<R0
	lda	#$0
	adc	<L19+chunk_1+2
	sta	<R0+2
	pha
	pei	<R0
	jsl	~~memcmp
	tax
	beq	*+5
	brl	L10023
;			
;			image.dataLength = (image.width * image.bytesPerPixel + 1) * image.height;
	lda	|~~image+276
	sta	<R0
	stz	<R0+2
	lda	|~~image+4+2
	pha
	lda	|~~image+4
	pha
	pei	<R0+2
	pei	<R0
	xref	~~~lmul
	jsl	~~~lmul
	sta	<R0
	stx	<R0+2
	lda	#$1
	clc
	adc	<R0
	sta	<R1
	lda	#$0
	adc	<R0+2
	sta	<R1+2
	lda	|~~image+8+2
	pha
	lda	|~~image+8
	pha
	pei	<R1+2
	pei	<R1
	xref	~~~lmul
	jsl	~~~lmul
	sta	|~~image+272
	stx	|~~image+272+2
;			
;			if (imageLen == 0) {
	lda	<L19+imageLen_1
	ora	<L19+imageLen_1+2
	bne	L10024
;				imageLen = chunklen - 2;	//subtract zlib header
	lda	#$fffe
	clc
	adc	<L19+chunklen_1
	sta	<L19+imageLen_1
	lda	#$ffff
	adc	<L19+chunklen_1+2
	sta	<L19+imageLen_1+2
;				compressedData = malloc(imageLen);
	pha
	pei	<L19+imageLen_1
	jsl	~~malloc
	sta	<L19+compressedData_1
	stx	<L19+compressedData_1+2
;				memcpy(compressedData, buf + sizeof(t_chunk) + 2, imageLen);
	pei	<L19+imageLen_1+2
	pei	<L19+imageLen_1
	lda	#$a
	clc
	adc	<L18+buf_0
	sta	<R0
	lda	#$0
	adc	<L18+buf_0+2
	pha
	pei	<R0
	pei	<L19+compressedData_1+2
	pei	<L19+compressedData_1
	jsl	~~memcpy
;			} else {
	bra	L10025
L10024:
;				compressedData = realloc(compressedData, imageLen + chunklen);
	lda	<L19+imageLen_1
	clc
	adc	<L19+chunklen_1
	sta	<R0
	lda	<L19+imageLen_1+2
	adc	<L19+chunklen_1+2
	pha
	pei	<R0
	pei	<L19+compressedData_1+2
	pei	<L19+compressedData_1
	jsl	~~realloc
	sta	<L19+compressedData_1
	stx	<L19+compressedData_1+2
;				memcpy(compressedData + imageLen, buf + sizeof(t_chunk), chunklen);
	pei	<L19+chunklen_1+2
	pei	<L19+chunklen_1
	lda	#$8
	clc
	adc	<L18+buf_0
	sta	<R0
	lda	#$0
	adc	<L18+buf_0+2
	pha
	pei	<R0
	lda	<L19+compressedData_1
	clc
	adc	<L19+imageLen_1
	sta	<R1
	lda	<L19+compressedData_1+2
	adc	<L19+imageLen_1+2
	pha
	pei	<R1
	jsl	~~memcpy
;				imageLen  += chunklen;
	lda	<L19+imageLen_1
	clc
	adc	<L19+chunklen_1
	sta	<L19+imageLen_1
	lda	<L19+imageLen_1+2
	adc	<L19+chunklen_1+2
	sta	<L19+imageLen_1+2
;			}
L10025:
;			
;			if (!compressedData) {
	lda	<L19+compressedData_1
	ora	<L19+compressedData_1+2
	bne	*+5
	brl	L20004
;				return -1;
;			}
;
;		}
;		
;		if (!memcmp(chunk->name, "PLTE", 4)) {
L10023:
	pea	#^$4
	pea	#<$4
	pea	#^L1+91
	pea	#<L1+91
	lda	#$4
	clc
	adc	<L19+chunk_1
	sta	<R0
	lda	#$0
	adc	<L19+chunk_1+2
	sta	<R0+2
	pha
	pei	<R0
	jsl	~~memcmp
	tax
	beq	*+5
	brl	L10027
;			plte = buf + sizeof(t_chunk);
	lda	#$8
	clc
	adc	<L18+buf_0
	sta	<L19+plte_1
	lda	#$0
	adc	<L18+buf_0+2
	sta	<L19+plte_1+2
;			
;			y = chunklen / 3;
	pea	#^$3
	pea	#<$3
	pei	<L19+chunklen_1+2
	pei	<L19+chunklen_1
	xref	~~~ludv
	jsl	~~~ludv
	stx	<R0+2
	sta	<L19+y_1
;			
;			printf("doing palette, colors: %d\n", y);
	pha
	pea	#^L1+96
	pea	#<L1+96
	pea	#8
	jsl	~~printf
;			
;			
;			//asm {sei; wdm 7;};
;			for(x = 0, xp = 0; x < y; x++, xp++) {
	stz	<L19+x_1
	stz	<L19+xp_1
	bra	L10031
L10030:
;				palette[xp] = *plte >> 5;
	sep	#$20
	longa	off
	lda	[<L19+plte_1]
	lsr	A
	lsr	A
	lsr	A
	lsr	A
	lsr	A
	ldy	<L19+xp_1
	sta	[<L19+palette_1],Y
	rep	#$20
	longa	on
;				plte++;
	inc	<L19+plte_1
	bne	L33
	inc	<L19+plte_1+2
L33:
;				palette[xp] |= ((*plte >> 2) & 0x38);
	lda	<L19+xp_1
	sta	<R0
	stz	<R0+2
	lda	<L19+palette_1
	clc
	adc	<R0
	sta	<R1
	lda	<L19+palette_1+2
	adc	<R0+2
	sta	<R1+2
	sep	#$20
	longa	off
	lda	[<L19+plte_1]
	lsr	A
	lsr	A
	and	#<$38
	ora	[<R1]
	sta	[<R1]
	rep	#$20
	longa	on
;				plte++;
	inc	<L19+plte_1
	bne	L34
	inc	<L19+plte_1+2
L34:
;				palette[xp] |= ((*plte << 1) & 0xC0);
	lda	<L19+xp_1
	sta	<R0
	stz	<R0+2
	lda	<L19+palette_1
	clc
	adc	<R0
	sta	<R1
	lda	<L19+palette_1+2
	adc	<R0+2
	sta	<R1+2
	sep	#$20
	longa	off
	lda	[<L19+plte_1]
	asl	A
	and	#<$c0
	ora	[<R1]
	sta	[<R1]
	rep	#$20
	longa	on
;				//printf("%p:%02X ", palette+xp, palette[xp]);
;				xp++;
	inc	<L19+xp_1
;				palette[xp] = *plte >> 7;
	lda	[<L19+plte_1]
	ldx	#<$7
	xref	~~~clsr
	jsl	~~~clsr
	sep	#$20
	longa	off
	ldy	<L19+xp_1
	sta	[<L19+palette_1],Y
	rep	#$20
	longa	on
;				plte++;
	inc	<L19+plte_1
	bne	L10028
	inc	<L19+plte_1+2
;				//printf("%02X\n", palette[xp]);
;			}
L10028:
	inc	<L19+xp_1
	inc	<L19+x_1
L10031:
	lda	<L19+x_1
	cmp	<L19+y_1
	bcs	*+5
	brl	L10030
;			//asm {wdm 6; cli;};
;
;		}
;		
;		//getchar();
;		
;		if (!memcmp(chunk->name, "IEND", 4)) {
L10027:
	pea	#^$4
	pea	#<$4
	pea	#^L1+123
	pea	#<L1+123
	lda	#$4
	clc
	adc	<L19+chunk_1
	sta	<R0
	lda	#$0
	adc	<L19+chunk_1+2
	pha
	pei	<R0
	jsl	~~memcmp
	tax
	beq	*+5
	brl	L10032
;			image.data = malloc(image.dataLength);
	lda	|~~image+272+2
	pha
	lda	|~~image+272
	pha
	jsl	~~malloc
	sta	|~~image
	stx	|~~image+2
;			printf("datain: %p, dataout: %p, len: %lu\n", compressedData, image.data, image.dataLength);
	lda	|~~image+272+2
	pha
	lda	|~~image+272
	pha
	lda	|~~image+2
	pha
	lda	|~~image
	pha
	pei	<L19+compressedData_1+2
	pei	<L19+compressedData_1
	pea	#^L1+128
	pea	#<L1+128
	pea	#18
	jsl	~~printf
;			
;			imageLen -= 4;
	lda	#$fffc
	clc
	adc	<L19+imageLen_1
	sta	<L19+imageLen_1
	lda	#$ffff
	adc	<L19+imageLen_1+2
	sta	<L19+imageLen_1+2
;			//asm{wdm 1;}
;			//rc = puff(image.data, &image.dataLength, compressedData, &imageLen);
;			//asm{wdm 2;}
;			asm{wdm 1;}
	asmstart
	wdm 1
	asmend
;			rc = inflate(compressedData, image.data, &image.dataLength);
	lda	#<~~image+272
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	lda	|~~image+2
	pha
	lda	|~~image
	pha
	pei	<L19+compressedData_1+2
	pei	<L19+compressedData_1
	jsl	~~inflate
	sta	<L19+rc_1
;			asm{wdm 2;}
	asmstart
	wdm 2
	asmend
;
;			printf("rc: %d, len: %lu\n", rc, image.dataLength);
	lda	|~~image+272+2
	pha
	lda	|~~image+272
	pha
	pei	<L19+rc_1
	pea	#^L1+163
	pea	#<L1+163
	pea	#12
	jsl	~~printf
;
;			//if (rc != 0) return -1;
;			break;
	brl	L25
;		}
;		
;		buf += sizeof(t_chunk) + chunklen + sizeof(long);
L10032:
	lda	#$c
	clc
	adc	<L19+chunklen_1
	sta	<R0
	lda	#$0
	adc	<L19+chunklen_1+2
	sta	<R0+2
	lda	<L18+buf_0
	clc
	adc	<R0
	sta	<L18+buf_0
	lda	<L18+buf_0+2
	adc	<R0+2
	sta	<L18+buf_0+2
;
;	}
	brl	L10021
;}
L18	equ	53
L19	equ	9
	ends
	efunc
	data
L1:
	db	$6E,$6F,$20,$50,$4E,$47,$20,$66,$69,$6C,$65,$21,$0A,$00,$49
	db	$48,$44,$52,$00,$77,$69,$64,$74,$68,$3A,$20,$25,$6C,$75,$2C
	db	$20,$68,$65,$69,$67,$68,$74,$3A,$20,$25,$6C,$75,$2C,$20,$64
	db	$65,$70,$74,$68,$3A,$20,$25,$64,$2C,$20,$63,$6F,$6C,$54,$79
	db	$70,$65,$3A,$20,$25,$64,$2C,$20,$62,$70,$50,$3A,$20,$25,$64
	db	$2C,$20,$62,$70,$53,$3A,$20,$25,$64,$0A,$00,$49,$44,$41,$54
	db	$00,$50,$4C,$54,$45,$00,$64,$6F,$69,$6E,$67,$20,$70,$61,$6C
	db	$65,$74,$74,$65,$2C,$20,$63,$6F,$6C,$6F,$72,$73,$3A,$20,$25
	db	$64,$0A,$00,$49,$45,$4E,$44,$00,$64,$61,$74,$61,$69,$6E,$3A
	db	$20,$25,$70,$2C,$20,$64,$61,$74,$61,$6F,$75,$74,$3A,$20,$25
	db	$70,$2C,$20,$6C,$65,$6E,$3A,$20,$25,$6C,$75,$0A,$00,$72,$63
	db	$3A,$20,$25,$64,$2C,$20,$6C,$65,$6E,$3A,$20,$25,$6C,$75,$0A
	db	$00
	ends
;
;
;
;void reconcile(char *scanLine, char *scanLineOld, char *imageData, unsigned int bytesPerPixel) {
	code
	xdef	~~reconcile
	func
~~reconcile:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L39
	tcs
	phd
	tcd
scanLine_0	set	4
scanLineOld_0	set	8
imageData_0	set	12
bytesPerPixel_0	set	16
;	unsigned int x0, a, b, c, r, x, filter;
;	int p, xprev, pa, pb, pc;
;	
;	filter = *imageData;
x0_1	set	0
a_1	set	2
b_1	set	4
c_1	set	6
r_1	set	8
x_1	set	10
filter_1	set	12
p_1	set	14
xprev_1	set	16
pa_1	set	18
pb_1	set	20
pc_1	set	22
	lda	[<L39+imageData_0]
	and	#$ff
	sta	<L40+filter_1
;	imageData++;
	inc	<L39+imageData_0
	bne	L41
	inc	<L39+imageData_0+2
L41:
;	
;	
;	if (filter == 0) {
	lda	<L40+filter_1
	bne	L10033
;		memcpy(scanLine, imageData, image.bytesPerScanline);
	lda	|~~image+278
	sta	<R0
	stz	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L39+imageData_0+2
	pei	<L39+imageData_0
	pei	<L39+scanLine_0+2
	pei	<L39+scanLine_0
	jsl	~~memcpy
;		return;
L43:
	lda	<L39+2
	sta	<L39+2+14
	lda	<L39+1
	sta	<L39+1+14
	pld
	tsc
	clc
	adc	#L39+14
	tcs
	rtl
;	}
;	
;	for (x = 0, xprev = -bytesPerPixel; x < image.bytesPerScanline; x++, xprev++) {
L10033:
	stz	<L40+x_1
	sec
	lda	#$0
	sbc	<L39+bytesPerPixel_0
	sta	<L40+xprev_1
	brl	L10037
L10039:
;				scanLine[x] = imageData[x];
	sep	#$20
	longa	off
	ldy	<L40+x_1
	lda	[<L39+imageData_0],Y
	sta	[<L39+scanLine_0],Y
	rep	#$20
	longa	on
;			}
;			continue;
	brl	L10034
;		}
;		
;		//up
;		if (filter == 2) {
L10038:
	lda	<L40+filter_1
	cmp	#<$2
	bne	L10041
;			scanLine[x] = imageData[x] + scanLineOld[x];
	sep	#$20
	longa	off
	clc
	ldy	<L40+x_1
	lda	[<L39+imageData_0],Y
	adc	[<L39+scanLineOld_0],Y
	sta	[<L39+scanLine_0],Y
	rep	#$20
	longa	on
;			continue;
	brl	L10034
;		}
;		
;		if (filter == 3) {
L10041:
	lda	<L40+filter_1
	cmp	#<$3
	bne	L10042
;			r = scanLineOld[x];
	ldy	<L40+x_1
	lda	[<L39+scanLineOld_0],Y
	and	#$ff
	sta	<L40+r_1
;			if (xprev >= 0) {
	lda	<L40+xprev_1
	bmi	L10043
;				r += scanLine[xprev];
	ldy	<L40+xprev_1
	lda	[<L39+scanLine_0],Y
	and	#$ff
	clc
	adc	<L40+r_1
	sta	<L40+r_1
;			}
;			r >>= 1;
L10043:
	lsr	<L40+r_1
;			scanLine[x] = r + imageData[x];
	ldy	<L40+x_1
	lda	[<L39+imageData_0],Y
	and	#$ff
	clc
	adc	<L40+r_1
	sep	#$20
	longa	off
	sta	[<L39+scanLine_0],Y
	rep	#$20
	longa	on
;			continue;
	brl	L10034
;		}
;		
;		if (filter == 4) {
L10042:
	lda	<L40+filter_1
	cmp	#<$4
	beq	*+5
	brl	L10034
;			b = p = scanLineOld[x];		//b			
	ldy	<L40+x_1
	lda	[<L39+scanLineOld_0],Y
	and	#$ff
	sta	<L40+p_1
	sta	<L40+b_1
;
;			if (xprev >= 0) {
	lda	<L40+xprev_1
	bmi	L10045
;				a = scanLine[xprev];
	ldy	<L40+xprev_1
	lda	[<L39+scanLine_0],Y
	and	#$ff
	sta	<L40+a_1
;				c = scanLineOld[xprev];
	lda	[<L39+scanLineOld_0],Y
	and	#$ff
	sta	<L40+c_1
;
;				p += a - c;
	sec
	lda	<L40+a_1
	sbc	<L40+c_1
	clc
	adc	<L40+p_1
	sta	<L40+p_1
;				pa = p - a;
	sec
	sbc	<L40+a_1
	sta	<L40+pa_1
;				pc = p - c;
	sec
	lda	<L40+p_1
	sbc	<L40+c_1
	sta	<L40+pc_1
;				if (pa < 0) pa = -pa;
	lda	<L40+pa_1
	bpl	L10046
	sec
	lda	#$0
	sbc	<L40+pa_1
	sta	<L40+pa_1
;				if (pc < 0) pc = -pc;
L10046:
	lda	<L40+pc_1
	bpl	L10048
	sec
	lda	#$0
	sbc	<L40+pc_1
	bra	L20008
;			} else {
L10045:
;				a = c = 0;
	stz	<L40+c_1
	stz	<L40+a_1
;				pa = p;
	lda	<L40+p_1
	sta	<L40+pa_1
;				if (pa < 0) pa = -pa;
	lda	<L40+pa_1
	bpl	L10049
	sec
	lda	#$0
	sbc	<L40+pa_1
	sta	<L40+pa_1
;				pc = pa;
L10049:
	lda	<L40+pa_1
L20008:
	sta	<L40+pc_1
;			}
L10048:
;			pb = p - b;
	sec
	lda	<L40+p_1
	sbc	<L40+b_1
	sta	<L40+pb_1
;			if (pb < 0) pb = -pb;
	lda	<L40+pb_1
	bpl	L10050
	sec
	lda	#$0
	sbc	<L40+pb_1
	sta	<L40+pb_1
;						
;			if ((unsigned int)pa <= (unsigned int)pb & (unsigned int)pa <= (unsigned int)pc) {				
L10050:
	stz	<R0
	lda	<L40+pb_1
	cmp	<L40+pa_1
	bcc	L55
	inc	<R0
L55:
	stz	<R1
	lda	<L40+pc_1
	cmp	<L40+pa_1
	bcc	L57
	inc	<R1
L57:
	lda	<R1
	and	<R0
	beq	L10051
;				scanLine[x] =  imageData[x] + (char)a;
	sep	#$20
	longa	off
	clc
	ldy	<L40+x_1
	lda	[<L39+imageData_0],Y
	adc	<L40+a_1
	sta	[<L39+scanLine_0],Y
	rep	#$20
	longa	on
;				continue;
	bra	L10034
;			}
;			
;			if ((unsigned int)pb <= (unsigned int)pc) {
L10051:
	lda	<L40+pc_1
	cmp	<L40+pb_1
	bcc	L10052
;				scanLine[x] = imageData[x] + (char)b;
	sep	#$20
	longa	off
	clc
	ldy	<L40+x_1
	lda	[<L39+imageData_0],Y
	adc	<L40+b_1
	sta	[<L39+scanLine_0],Y
	rep	#$20
	longa	on
;				continue;
	bra	L10034
;			}
;			
;			scanLine[x] = imageData[x] + (char)c;
L10052:
	sep	#$20
	longa	off
	clc
	ldy	<L40+x_1
	lda	[<L39+imageData_0],Y
	adc	<L40+c_1
	sta	[<L39+scanLine_0],Y
	rep	#$20
	longa	on
;		}		
;	}
L10034:
	inc	<L40+xprev_1
	inc	<L40+x_1
L10037:
	lda	<L40+x_1
	cmp	|~~image+278
	bcc	*+5
	brl	L43
;		
;		//none
;		/*
;		if (filter == 0) {
;			scanLine[x] = imageData[x];
;			continue;
;		}*/ 
;		
;		//sub
;		if (filter == 1) {
	lda	<L40+filter_1
	cmp	#<$1
	beq	*+5
	brl	L10038
;			if (xprev >= 0) {
	lda	<L40+xprev_1
	bpl	*+5
	brl	L10039
;				scanLine[x] = imageData[x] + scanLine[xprev];
	sep	#$20
	longa	off
	clc
	ldy	<L40+x_1
	lda	[<L39+imageData_0],Y
	ldy	<L40+xprev_1
	adc	[<L39+scanLine_0],Y
	ldy	<L40+x_1
	sta	[<L39+scanLine_0],Y
	rep	#$20
	longa	on
;			} else {
	bra	L10034
;}
L39	equ	32
L40	equ	9
	ends
	efunc
;
;void display(char *scanLine, unsigned int y) {
	code
	xdef	~~display
	func
~~display:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L62
	tcs
	phd
	tcd
scanLine_0	set	4
y_0	set	8
;	unsigned int x, g;
;	char *graph;
;
;	if (y >= 200) return;
x_1	set	0
g_1	set	2
graph_1	set	4
	lda	<L62+y_0
	cmp	#<$c8
	bcc	L10053
L65:
	lda	<L62+2
	sta	<L62+2+6
	lda	<L62+1
	sta	<L62+1+6
	pld
	tsc
	clc
	adc	#L62+6
	tcs
	rtl
;	
;	graph = (char *)0x7F0000 + y * 320;
L10053:
	lda	<L62+y_0
	ldx	#<$140
	xref	~~~mul
	jsl	~~~mul
	sta	<R0
	stz	<R0+2
	lda	#$0
	clc
	adc	<R0
	sta	<L63+graph_1
	lda	#$7f
	adc	<R0+2
	sta	<L63+graph_1+2
;	
;	for (x = 0, g = 0; x < image.bytesPerScanline; x += image.bytesPerPixel) {
	stz	<L63+x_1
	stz	<L63+g_1
	brl	L10057
;			case 4:
L10062:
;				*graph = scanLine[x] >> 4;
	sep	#$20
	longa	off
	ldy	<L63+x_1
	lda	[<L62+scanLine_0],Y
	lsr	A
	lsr	A
	lsr	A
	lsr	A
	sta	[<L63+graph_1]
	rep	#$20
	longa	on
;				graph++;				
	inc	<L63+graph_1
	bne	L68
	inc	<L63+graph_1+2
L68:
;				*graph = scanLine[x] & 0x0f;
	sep	#$20
	longa	off
	ldy	<L63+x_1
	lda	[<L62+scanLine_0],Y
	and	#<$f
	sta	[<L63+graph_1]
	rep	#$20
	longa	on
;				break;								
	bra	L10065
;			case 8:
L10063:
;				*graph = scanLine[x];
	sep	#$20
	longa	off
	ldy	<L63+x_1
	lda	[<L62+scanLine_0],Y
	sta	[<L63+graph_1]
	rep	#$20
	longa	on
;				break;
	bra	L10065
;			default:
;				break;
;			}
;	
;		} else {
L10059:
;			if (image.depth == 8) {
	lda	|~~image+268
	cmp	#<$8
	bne	L10065
;				*graph 	= (scanLine[x] >> 5);
	sep	#$20
	longa	off
	ldy	<L63+x_1
	lda	[<L62+scanLine_0],Y
	lsr	A
	lsr	A
	lsr	A
	lsr	A
	lsr	A
	sta	[<L63+graph_1]
	rep	#$20
	longa	on
;				asm {iny;}
	asmstart
	iny
	asmend
;				*graph |= (scanLine[x] >> 2) & 0x38;
	sep	#$20
	longa	off
	lda	[<L62+scanLine_0],Y
	lsr	A
	lsr	A
	and	#<$38
	sta	<R0
	lda	[<L63+graph_1]
	ora	<R0
	sta	[<L63+graph_1]
	rep	#$20
	longa	on
;				asm {iny;}
	asmstart
	iny
	asmend
;				*graph |= scanLine[x] & 0xc0;
	sep	#$20
	longa	off
	lda	[<L62+scanLine_0],Y
	and	#<$c0
	sta	<R0
	lda	[<L63+graph_1]
	ora	<R0
	sta	[<L63+graph_1]
	rep	#$20
	longa	on
;			}
;		}
L10065:
;		
;		graph++;
	inc	<L63+graph_1
	bne	L70
	inc	<L63+graph_1+2
L70:
;		g++;
	inc	<L63+g_1
;	}
	lda	<L63+x_1
	clc
	adc	|~~image+276
	sta	<L63+x_1
L10057:
	lda	<L63+x_1
	cmp	|~~image+278
	bcc	*+5
	brl	L65
;		if (g >= 320) return;
	lda	<L63+g_1
	cmp	#<$140
	bcc	*+5
	brl	L65
;		if (image.bytesPerPixel == 1) {
	lda	|~~image+276
	cmp	#<$1
	bne	L10059
;			switch (image.depth) {
	lda	|~~image+268
	xref	~~~swt
	jsl	~~~swt
	dw	2
	dw	4
	dw	L10062-1
	dw	8
	dw	L10063-1
	dw	L10065-1
;}
L62	equ	12
L63	equ	5
	ends
	efunc
;
;int bitstream() {
	code
	xdef	~~bitstream
	func
~~bitstream:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L72
	tcs
	phd
	tcd
;	unsigned long rc;
;	FILE *fin;
;	unsigned int y;
;	char *scanLineOld, *scanLine, *imageData, *graph;
;			
;	imageData = image.data;
rc_1	set	0
fin_1	set	4
y_1	set	8
scanLineOld_1	set	10
scanLine_1	set	14
imageData_1	set	18
graph_1	set	22
	lda	|~~image
	sta	<L73+imageData_1
	lda	|~~image+2
	sta	<L73+imageData_1+2
;	graph = (char *)0x7F0000;
	lda	#$0
	sta	<L73+graph_1
	lda	#$7f
	sta	<L73+graph_1+2
;	memset(graph, 0, 0xf800);
	pea	#^$f800
	pea	#<$f800
	pea	#<$0
	pei	<L73+graph_1+2
	pei	<L73+graph_1
	jsl	~~memset
;	//getchar();
;	
;	
;	scanLine = calloc(image.bytesPerScanline, 1);
	pea	#^$1
	pea	#<$1
	lda	|~~image+278
	sta	<R0
	stz	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~calloc
	sta	<L73+scanLine_1
	stx	<L73+scanLine_1+2
;	scanLineOld = NULL;
	stz	<L73+scanLineOld_1
	stz	<L73+scanLineOld_1+2
;	
;	//if (image.bytesPerPixel != 1) {
;	//	CONTROL |= 0x08;
;	//}
;	
;	for (y = 0; y < image.height; y++) {
	stz	<L73+y_1
	bra	L10070
L10069:
;		free(scanLineOld);
	pei	<L73+scanLineOld_1+2
	pei	<L73+scanLineOld_1
	jsl	~~free
;		scanLineOld = scanLine;
	lda	<L73+scanLine_1
	sta	<L73+scanLineOld_1
	lda	<L73+scanLine_1+2
	sta	<L73+scanLineOld_1+2
;		scanLine = malloc(image.bytesPerScanline);
	lda	|~~image+278
	sta	<R0
	stz	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~malloc
	sta	<L73+scanLine_1
	stx	<L73+scanLine_1+2
;		
;		reconcile(scanLine, scanLineOld, imageData, image.bytesPerPixel);
	lda	|~~image+276
	pha
	pei	<L73+imageData_1+2
	pei	<L73+imageData_1
	pei	<L73+scanLineOld_1+2
	pei	<L73+scanLineOld_1
	pei	<L73+scanLine_1+2
	pei	<L73+scanLine_1
	jsl	~~reconcile
;		display(scanLine, y);
	pei	<L73+y_1
	pei	<L73+scanLine_1+2
	pei	<L73+scanLine_1
	jsl	~~display
;		
;		imageData += image.bytesPerScanline + 1;
	lda	|~~image+278
	ina
	sta	<R0
	stz	<R0+2
	lda	<L73+imageData_1
	clc
	adc	<R0
	sta	<L73+imageData_1
	lda	<L73+imageData_1+2
	adc	<R0+2
	sta	<L73+imageData_1+2
;	}
	inc	<L73+y_1
L10070:
	lda	<L73+y_1
	sta	<R0
	stz	<R0+2
	lda	<R0
	cmp	|~~image+8
	lda	<R0+2
	sbc	|~~image+8+2
	bcc	L10069
;	
;	//asm {WDM 2;}
;}
	tay
	pld
	tsc
	clc
	adc	#L72
	tcs
	tya
	rtl
L72	equ	30
L73	equ	5
	ends
	efunc
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
	sbc	#L76
	tcs
	phd
	tcd
argc_0	set	4
argv_0	set	6
;	FILE *fin;
;	char *graph, *buf, *vbuf, *fname, hi, bank;
;	size_t flen;
;	struct stat st;
;	int fd;
;	
;	if (argc < 2) {
fin_1	set	0
graph_1	set	4
buf_1	set	8
vbuf_1	set	12
fname_1	set	16
hi_1	set	20
bank_1	set	21
flen_1	set	22
st_1	set	26
fd_1	set	32
	lda	<L76+argc_0
	bmi	L78
	dea
	dea
	bpl	L10071
L78:
;		fname = adjustFilename("bu*.*", 0);
	pea	#<$0
	pea	#^L38
	pea	#<L38
	bra	L20012
;		//printf("png <filename.png>\n");
;		//return 0;
;	} else {
L10071:
;		fname = adjustFilename(argv[1], 0);
	pea	#<$0
	ldy	#$6
	lda	[<L76+argv_0],Y
	pha
	dey
	dey
	lda	[<L76+argv_0],Y
	pha
L20012:
	jsl	~~adjustFilename
	sta	<L77+fname_1
	stx	<L77+fname_1+2
;	}
;	
;	if (stat(fname, &st) == -1) {
	pea	#0
	clc
	tdc
	adc	#<L77+st_1
	pha
	pei	<L77+fname_1+2
	pei	<L77+fname_1
	jsl	~~stat
	cmp	#<$ffffffff
	bne	L10073
;		return 0;
L20010:
	lda	#$0
L80:
	tay
	lda	<L76+2
	sta	<L76+2+6
	lda	<L76+1
	sta	<L76+1+6
	pld
	tsc
	clc
	adc	#L76+6
	tcs
	tya
	rtl
;	}
;	
;	fin = fopen(fname, "rb");
L10073:
	pea	#^L38+6
	pea	#<L38+6
	pei	<L77+fname_1+2
	pei	<L77+fname_1
	jsl	~~fopen
	sta	<L77+fin_1
	stx	<L77+fin_1+2
;	
;	if (fin == NULL) {
	ora	<L77+fin_1+2
	bne	L10074
;		printf("can't read file %s\n", fname);
	pei	<L77+fname_1+2
	pei	<L77+fname_1
	pea	#^L38+9
	pea	#<L38+9
	pea	#10
	jsl	~~printf
;		return 0;
	bra	L20010
;	}
;	
;	//vbuf = malloc(2048);
;	//setvbuf(fin, vbuf, _IOFBF, 2048);
;	
;	buf = malloc(st.st_size);
L10074:
	pei	<L77+st_1+4
	pei	<L77+st_1+2
	jsl	~~malloc
	sta	<L77+buf_1
	stx	<L77+buf_1+2
;	printf("loading %s, length: %lu\n", fname, st.st_size);
	pei	<L77+st_1+4
	pei	<L77+st_1+2
	pei	<L77+fname_1+2
	pei	<L77+fname_1
	pea	#^L38+29
	pea	#<L38+29
	pea	#14
	jsl	~~printf
;	
;	//asm{wdm 1;}
;	//flen = fread(buf, 1, st.st_size, fin);
;	fd = fileno(fin);
	pei	<L77+fin_1+2
	pei	<L77+fin_1
	jsl	~~fileno
	sta	<L77+fd_1
;	flen = read(fd, buf, st.st_size);
	pei	<L77+st_1+4
	pei	<L77+st_1+2
	pei	<L77+buf_1+2
	pei	<L77+buf_1
	pei	<L77+fd_1
	jsl	~~read
	sta	<L77+flen_1
	stx	<L77+flen_1+2
;	//asm{wdm 2;}
;	
;	printf("%lu bytes loaded\n", flen);
	pei	<L77+flen_1+2
	pei	<L77+flen_1
	pea	#^L38+54
	pea	#<L38+54
	pea	#10
	jsl	~~printf
;	
;	fclose(fin);
	pei	<L77+fin_1+2
	pei	<L77+fin_1
	jsl	~~fclose
;	
;	if (flen != st.st_size) return 0;
	lda	<L77+flen_1
	cmp	<L77+st_1+2
	bne	L82
	lda	<L77+flen_1+2
	cmp	<L77+st_1+4
L82:
	beq	*+5
	brl	L20010
;	if (doPNG(buf, flen) < 0) return 0;
	pei	<L77+flen_1+2
	pei	<L77+flen_1
	pei	<L77+buf_1+2
	pei	<L77+buf_1
	jsl	~~doPNG
	sta	<R0
	lda	<R0
	bpl	*+5
	brl	L20010
;	
;	
;	CONTROL = 2;
	sep	#$20
	longa	off
	lda	#$2
	sta	>16776713
;	hi = SCREENBASEHI;
	lda	>16776711
	sta	<L77+hi_1
;	bank = SCREENBASEBANK;
	lda	>16776712
	sta	<L77+bank_1
;	SCREENBASEHI = 0x80;
	lda	#$80
	sta	>16776711
;	SCREENBASEBANK = 0x3F;
	lda	#$3f
	sta	>16776712
	rep	#$20
	longa	on
;
;	bitstream();
	jsl	~~bitstream
;	
;	getchar();
	lda	|~~stdin+2
	pha
	lda	|~~stdin
	pha
	jsl	~~fgetc
;	
;	CONTROL = 4;
	sep	#$20
	longa	off
	lda	#$4
	sta	>16776713
;	SCREENBASEHI = hi;
	lda	<L77+hi_1
	sta	>16776711
;	SCREENBASEBANK = bank;
	lda	<L77+bank_1
	sta	>16776712
	rep	#$20
	longa	on
;	
;	standardPalette();
	jsl	~~standardPalette
;	printf("%c", CLS);
	pea	#<$1
	pea	#^L38+72
	pea	#<L38+72
	pea	#8
	jsl	~~printf
;}
	brl	L80
L76	equ	38
L77	equ	5
	ends
	efunc
	data
L38:
	db	$62,$75,$2A,$2E,$2A,$00,$72,$62,$00,$63,$61,$6E,$27,$74,$20
	db	$72,$65,$61,$64,$20,$66,$69,$6C,$65,$20,$25,$73,$0A,$00,$6C
	db	$6F,$61,$64,$69,$6E,$67,$20,$25,$73,$2C,$20,$6C,$65,$6E,$67
	db	$74,$68,$3A,$20,$25,$6C,$75,$0A,$00,$25,$6C,$75,$20,$62,$79
	db	$74,$65,$73,$20,$6C,$6F,$61,$64,$65,$64,$0A,$00,$25,$63,$00
	ends
;
	xref	~~inflate
	xref	~~adjustFilename
	xref	~~stat
	xref	~~read
	xref	~~memcpy
	xref	~~memcmp
	xref	~~memset
	xref	~~realloc
	xref	~~free
	xref	~~malloc
	xref	~~calloc
	xref	~~fileno
	xref	~~fclose
	xref	~~fgetc
	xref	~~printf
	xref	~~fopen
	udata
	xdef	~~image
~~image
	ds	280
	ends
	xref	~~stdin
