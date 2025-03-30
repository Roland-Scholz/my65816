;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
;#include <stdio.h>
;#include <stdlib.h>
;#include <string.h>
;#include <errno.h>
;#include <fcntl.h>
;#include <sys/types.h>
;
;#include "homebrew.h"
;
;//DIR dir_fd[8];
;//struct dirent dirent[8];
;
;//int debugf(const char *format, ...);
;
;
;union iocb {
;	struct {
;		unsigned int iocbLo;
;		unsigned int iocbHi;
;	} iocbWord;
;	iocb_t *iocb;
;};
;
;
;typedef union iocb iocb_ut;
;
;
;unsigned char fd2iocb[8];
;
;char getFreeIocb() {
	code
	xdef	~~getFreeIocb
	func
~~getFreeIocb:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
;	char *p = IOCBSTRT;
;	unsigned int i;
;	
;	for(i = 0; i < 8; i++, p += 16) {
p_1	set	0
i_1	set	4
	lda	#$280
	sta	<L3+p_1
	lda	#$0
	sta	<L3+p_1+2
	stz	<L3+i_1
L10003:
;		if (*p == 0xff) break;
	sep	#$20
	longa	off
	lda	[<L3+p_1]
	cmp	#<$ff
	rep	#$20
	longa	on
	beq	L10002
;	}
	lda	#$10
	clc
	adc	<L3+p_1
	sta	<L3+p_1
	bcc	L5
	inc	<L3+p_1+2
L5:
	inc	<L3+i_1
	lda	<L3+i_1
	cmp	#<$8
	bcc	L10003
L10002:
;
;	return i;
	lda	<L3+i_1
	and	#$ff
	tay
	pld
	tsc
	clc
	adc	#L2
	tcs
	tya
	rtl
;}
L2	equ	6
L3	equ	1
	ends
	efunc
;
;unsigned char callCIO(char channel, char cmd, char *buffer, size_t len, char aux1, char aux2) {
	code
	xdef	~~callCIO
	func
~~callCIO:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L8
	tcs
	phd
	tcd
channel_0	set	4
cmd_0	set	6
buffer_0	set	8
len_0	set	12
aux1_0	set	14
aux2_0	set	16
;	iocb_ut iocb;
;	ptrconv_t p;
;	char status;
;	
;	
;	iocb.iocbWord.iocbHi = 0;
iocb_1	set	0
p_1	set	4
status_1	set	8
	stz	<L9+iocb_1+2
;	iocb.iocbWord.iocbLo = channel << 4;
	lda	<L8+channel_0
	and	#$ff
	asl	A
	asl	A
	asl	A
	asl	A
	sta	<L9+iocb_1
;#asm 
;	tax
;#endasm
	asmstart
	tax
	asmend
;	iocb.iocbWord.iocbLo += (unsigned int)(0x0280);
	lda	#$280
	clc
	adc	<L9+iocb_1
	sta	<L9+iocb_1
;
;	if (cmd == IOCB_OPEN) {
	sep	#$20
	longa	off
	lda	<L8+cmd_0
	cmp	#<$3
	rep	#$20
	longa	on
	bne	L10004
;		iocb.iocb->aux1 = aux1;
	sep	#$20
	longa	off
	lda	<L8+aux1_0
	ldy	#$a
	sta	[<L9+iocb_1],Y
;		iocb.iocb->aux2 = aux2;	
	lda	<L8+aux2_0
	iny
	sta	[<L9+iocb_1],Y
	rep	#$20
	longa	on
;	} 
;	//else if (cmd == IOCB_CLOSE && !iocb.iocb->handler) {
;	//	return SUCCES;
;	//}
;	
;	iocb.iocb->command = cmd;
L10004:
	sep	#$20
	longa	off
	lda	<L8+cmd_0
	ldy	#$2
	sta	[<L9+iocb_1],Y
	rep	#$20
	longa	on
;	
;	p.ptr = buffer;
	lda	<L8+buffer_0
	sta	<L9+p_1
	lda	<L8+buffer_0+2
	sta	<L9+p_1+2
;	iocb.iocb->buffer = p.adrBank.ptr16;
	lda	<L9+p_1
	iny
	iny
	sta	[<L9+iocb_1],Y
;	iocb.iocb->bufferBank = p.adrBank.ptrBank;
	sep	#$20
	longa	off
	lda	<L9+p_1+2
	iny
	iny
	sta	[<L9+iocb_1],Y
	rep	#$20
	longa	on
;	
;	p.ul = len;
	lda	<L8+len_0
	sta	<L9+p_1
	stz	<L9+p_1+2
;	iocb.iocb->buflen = p.adrBank.ptr16;
	lda	<L9+p_1
	iny
	sta	[<L9+iocb_1],Y
;	iocb.iocb->buflenBank = p.adrBank.ptrBank;
	sep	#$20
	longa	off
	lda	<L9+p_1+2
	iny
	iny
	sta	[<L9+iocb_1],Y
	rep	#$20
	longa	on
;	
;#asm
;	jsl $C021
;#endasm
	asmstart
	jsl $C021
	asmend
;	errno = 0;
	stz	|~~errno
;	status = iocb.iocb->status;
	sep	#$20
	longa	off
	ldy	#$3
	lda	[<L9+iocb_1],Y
	sta	<L9+status_1
;	
;	if (status != 1) errno = ENOENT;
	cmp	#<$1
	rep	#$20
	longa	on
	beq	L10005
	lda	#$1
	sta	|~~errno
;	
;	/*
;	if (cmd == IOCB_GETREC) {
;		printf("IOCB:%d, buffer:%p, cmd:%d, rc:%d \n", channel, buffer, cmd, iocb.iocb->status);
;	}
;	*/
;		
;	return status;
L10005:
	lda	<L9+status_1
	and	#$ff
	tay
	lda	<L8+2
	sta	<L8+2+14
	lda	<L8+1
	sta	<L8+1+14
	pld
	tsc
	clc
	adc	#L8+14
	tcs
	tya
	rtl
;}
L8	equ	13
L9	equ	5
	ends
	efunc
;
;unsigned char aclose(char channel) {
	code
	xdef	~~aclose
	func
~~aclose:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L13
	tcs
	phd
	tcd
channel_0	set	4
;	return callCIO(channel, IOCB_CLOSE, NULL, 0ul, 0, 0);	
	pea	#<$0
	pea	#<$0
	pea	#<$0
	pea	#^$0
	pea	#<$0
	pea	#<$c
	pei	<L13+channel_0
	jsl	~~callCIO
	sep	#$20
	longa	off
	sta	<R0
	rep	#$20
	longa	on
	lda	<R0
	and	#$ff
	tay
	lda	<L13+2
	sta	<L13+2+2
	lda	<L13+1
	sta	<L13+1+2
	pld
	tsc
	clc
	adc	#L13+2
	tcs
	tya
	rtl
;}
L13	equ	4
L14	equ	5
	ends
	efunc
;
;unsigned char agetrec(char channel, char *buffer) {
	code
	xdef	~~agetrec
	func
~~agetrec:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L16
	tcs
	phd
	tcd
channel_0	set	4
buffer_0	set	6
;	return callCIO(channel, IOCB_GETREC, buffer, 256ul, 0, 0);	
	pea	#<$0
	pea	#<$0
	pea	#<$100
	pei	<L16+buffer_0+2
	pei	<L16+buffer_0
	pea	#<$5
	pei	<L16+channel_0
	jsl	~~callCIO
	sep	#$20
	longa	off
	sta	<R0
	rep	#$20
	longa	on
	lda	<R0
	and	#$ff
	tay
	lda	<L16+2
	sta	<L16+2+6
	lda	<L16+1
	sta	<L16+1+6
	pld
	tsc
	clc
	adc	#L16+6
	tcs
	tya
	rtl
;}
L16	equ	4
L17	equ	5
	ends
	efunc
;
;unsigned char aputrec(char channel, char *buffer) {
	code
	xdef	~~aputrec
	func
~~aputrec:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L19
	tcs
	phd
	tcd
channel_0	set	4
buffer_0	set	6
;	return callCIO(channel, IOCB_PUTREC, buffer, 256ul, 0, 0);	
	pea	#<$0
	pea	#<$0
	pea	#<$100
	pei	<L19+buffer_0+2
	pei	<L19+buffer_0
	pea	#<$9
	pei	<L19+channel_0
	jsl	~~callCIO
	sep	#$20
	longa	off
	sta	<R0
	rep	#$20
	longa	on
	lda	<R0
	and	#$ff
	tay
	lda	<L19+2
	sta	<L19+2+6
	lda	<L19+1
	sta	<L19+1+6
	pld
	tsc
	clc
	adc	#L19+6
	tcs
	tya
	rtl
;}
L19	equ	4
L20	equ	5
	ends
	efunc
;
;unsigned char agetchr(char channel, char *buffer, size_t len) {
	code
	xdef	~~agetchr
	func
~~agetchr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L22
	tcs
	phd
	tcd
channel_0	set	4
buffer_0	set	6
len_0	set	10
;	return callCIO(channel, IOCB_GETCHR, buffer, len, 0, 0);	
	pea	#<$0
	pea	#<$0
	pei	<L22+len_0
	pei	<L22+buffer_0+2
	pei	<L22+buffer_0
	pea	#<$7
	pei	<L22+channel_0
	jsl	~~callCIO
	sep	#$20
	longa	off
	sta	<R0
	rep	#$20
	longa	on
	lda	<R0
	and	#$ff
	tay
	lda	<L22+2
	sta	<L22+2+8
	lda	<L22+1
	sta	<L22+1+8
	pld
	tsc
	clc
	adc	#L22+8
	tcs
	tya
	rtl
;}
L22	equ	4
L23	equ	5
	ends
	efunc
;
;unsigned char aputchr(char channel, char *buffer, size_t len) {
	code
	xdef	~~aputchr
	func
~~aputchr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L25
	tcs
	phd
	tcd
channel_0	set	4
buffer_0	set	6
len_0	set	10
;	return callCIO(channel, IOCB_PUTCHR, buffer, len, 0, 0);	
	pea	#<$0
	pea	#<$0
	pei	<L25+len_0
	pei	<L25+buffer_0+2
	pei	<L25+buffer_0
	pea	#<$b
	pei	<L25+channel_0
	jsl	~~callCIO
	sep	#$20
	longa	off
	sta	<R0
	rep	#$20
	longa	on
	lda	<R0
	and	#$ff
	tay
	lda	<L25+2
	sta	<L25+2+8
	lda	<L25+1
	sta	<L25+1+8
	pld
	tsc
	clc
	adc	#L25+8
	tcs
	tya
	rtl
;}
L25	equ	4
L26	equ	5
	ends
	efunc
;
;unsigned char aopen(unsigned char channel, char *buffer, char aux1, char aux2) {
	code
	xdef	~~aopen
	func
~~aopen:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L28
	tcs
	phd
	tcd
channel_0	set	4
buffer_0	set	6
aux1_0	set	10
aux2_0	set	12
;	return callCIO(channel, IOCB_OPEN, buffer, 256ul, aux1, aux2);	
	pei	<L28+aux2_0
	pei	<L28+aux1_0
	pea	#<$100
	pei	<L28+buffer_0+2
	pei	<L28+buffer_0
	pea	#<$3
	pei	<L28+channel_0
	jsl	~~callCIO
	sep	#$20
	longa	off
	sta	<R0
	rep	#$20
	longa	on
	lda	<R0
	and	#$ff
	tay
	lda	<L28+2
	sta	<L28+2+10
	lda	<L28+1
	sta	<L28+1+10
	pld
	tsc
	clc
	adc	#L28+10
	tcs
	tya
	rtl
;}
L28	equ	4
L29	equ	5
	ends
	efunc
;
;unsigned char achdir(unsigned char channel, char *buffer) {
	code
	xdef	~~achdir
	func
~~achdir:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L31
	tcs
	phd
	tcd
channel_0	set	4
buffer_0	set	6
;	return callCIO(channel, IOCB_CHDIR_MYDOS, buffer, 0, 0, 0);	
	pea	#<$0
	pea	#<$0
	pea	#<$0
	pei	<L31+buffer_0+2
	pei	<L31+buffer_0
	pea	#<$29
	pei	<L31+channel_0
	jsl	~~callCIO
	sep	#$20
	longa	off
	sta	<R0
	rep	#$20
	longa	on
	lda	<R0
	and	#$ff
	tay
	lda	<L31+2
	sta	<L31+2+6
	lda	<L31+1
	sta	<L31+1+6
	pld
	tsc
	clc
	adc	#L31+6
	tcs
	tya
	rtl
;}
L31	equ	4
L32	equ	5
	ends
	efunc
;
;unsigned char astat(unsigned char channel, struct stat *buffer) {
	code
	xdef	~~astat
	func
~~astat:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L34
	tcs
	phd
	tcd
channel_0	set	4
buffer_0	set	6
;	return callCIO(channel, IOCB_STAT, (char *)buffer, sizeof(struct stat), 0, 0);	
	pea	#<$0
	pea	#<$0
	pea	#<$6
	pei	<L34+buffer_0+2
	pei	<L34+buffer_0
	pea	#<$28
	pei	<L34+channel_0
	jsl	~~callCIO
	sep	#$20
	longa	off
	sta	<R0
	rep	#$20
	longa	on
	lda	<R0
	and	#$ff
	tay
	lda	<L34+2
	sta	<L34+2+6
	lda	<L34+1
	sta	<L34+1+6
	pld
	tsc
	clc
	adc	#L34+6
	tcs
	tya
	rtl
;}
L34	equ	4
L35	equ	5
	ends
	efunc
;
;
;int isatty(int i) {
	code
	xdef	~~isatty
	func
~~isatty:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L37
	tcs
	phd
	tcd
i_0	set	4
;	return 1;
	lda	#$1
	tay
	lda	<L37+2
	sta	<L37+2+2
	lda	<L37+1
	sta	<L37+1+2
	pld
	tsc
	clc
	adc	#L37+2
	tcs
	tya
	rtl
;}
L37	equ	0
L38	equ	1
	ends
	efunc
;
;ssize_t returnSize(int fd, int rc) {
	code
	xdef	~~returnSize
	func
~~returnSize:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L40
	tcs
	phd
	tcd
fd_0	set	4
rc_0	set	6
;	iocb_ut iocb;
;	ptrconv_t p;
;	
;	if (rc != SUCCES && rc != EOFERR)
iocb_1	set	0
p_1	set	4
;		return -1;
	lda	<L40+rc_0
	cmp	#<$1
	beq	L10006
	lda	<L40+rc_0
	cmp	#<$88
	beq	L10006
	lda	#$ffff
L44:
	tay
	lda	<L40+2
	sta	<L40+2+4
	lda	<L40+1
	sta	<L40+1+4
	pld
	tsc
	clc
	adc	#L40+4
	tcs
	tya
	rtl
;
;	iocb.iocbWord.iocbHi = 0;
L10006:
	stz	<L41+iocb_1+2
;	iocb.iocbWord.iocbLo = (fd2iocb[fd] << 4) + 0x280;
	ldx	<L40+fd_0
	lda	|~~fd2iocb,X
	and	#$ff
	asl	A
	asl	A
	asl	A
	asl	A
	clc
	adc	#$280
	sta	<L41+iocb_1
;	p.adrBank.ptr16 = iocb.iocb->buflen;
	ldy	#$7
	lda	[<L41+iocb_1],Y
	sta	<L41+p_1
;	p.adrBank.ptrBank = iocb.iocb->buflenBank;
	sep	#$20
	longa	off
	iny
	iny
	lda	[<L41+iocb_1],Y
	sta	<L41+p_1+2
;	p.adrBank.ptrUnused = 0;
	stz	<L41+p_1+3
	rep	#$20
	longa	on
;
;	return p.ul;	
	lda	<L41+p_1
	bra	L44
;}
L40	equ	16
L41	equ	9
	ends
	efunc
;
;size_t write(int fd, void* buf, size_t len) {
	code
	xdef	~~write
	func
~~write:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L45
	tcs
	phd
	tcd
fd_0	set	4
buf_0	set	6
len_0	set	10
;	unsigned char rc;
;	ssize_t size;
;	
;	//debugf("write fd: %04X, len: %04X\n", (long)fd, (long)len);
;	
;	rc = aputchr(fd2iocb[fd], (char *)buf, len);
rc_1	set	0
size_1	set	1
	pei	<L45+len_0
	pei	<L45+buf_0+2
	pei	<L45+buf_0
	ldx	<L45+fd_0
	lda	|~~fd2iocb,X
	pha
	jsl	~~aputchr
	sep	#$20
	longa	off
	sta	<L46+rc_1
	rep	#$20
	longa	on
;	
;	size = returnSize(fd, rc);
	lda	<L46+rc_1
	and	#$ff
	pha
	pei	<L45+fd_0
	jsl	~~returnSize
	sta	<L46+size_1
;		
;	return size;	
	tay
	lda	<L45+2
	sta	<L45+2+8
	lda	<L45+1
	sta	<L45+1+8
	pld
	tsc
	clc
	adc	#L45+8
	tcs
	tya
	rtl
;}
L45	equ	3
L46	equ	1
	ends
	efunc
;
;size_t read(int fd, void* buf, size_t len) {	
	code
	xdef	~~read
	func
~~read:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L48
	tcs
	phd
	tcd
fd_0	set	4
buf_0	set	6
len_0	set	10
;	unsigned char rc;
;	size_t size;
;	
;	//debugf("read fd:%04X, len: %04X @ %08X\n", (long)fd, (long)len, buf);
;		
;	rc = agetchr(fd2iocb[fd], (char *)buf, len);
rc_1	set	0
size_1	set	1
	pei	<L48+len_0
	pei	<L48+buf_0+2
	pei	<L48+buf_0
	ldx	<L48+fd_0
	lda	|~~fd2iocb,X
	pha
	jsl	~~agetchr
	sep	#$20
	longa	off
	sta	<L49+rc_1
	rep	#$20
	longa	on
;		
;	size = returnSize(fd, rc);
	lda	<L49+rc_1
	and	#$ff
	pha
	pei	<L48+fd_0
	jsl	~~returnSize
	sta	<L49+size_1
;		
;	//debugf("read size: %04X, rc: %02X\n", (long)size, (long)rc);
;	
;	return size;	
	tay
	lda	<L48+2
	sta	<L48+2+8
	lda	<L48+1
	sta	<L48+1+8
	pld
	tsc
	clc
	adc	#L48+8
	tcs
	tya
	rtl
;}
L48	equ	3
L49	equ	1
	ends
	efunc
;
;//int ioctl(int fd, long reqs, void *term) {
;//	return 0;
;//}
;
;/*
;int fstat(int fd, struct stat *buf) {
;	int rc;
;	
;	//rc = astat(fd2iocb[fd], buf);
;	
;	//if (rc >= 128) rc = -1;
;	//else rc = 0;
;	rc = 0;
;	return rc;
;}*/
;
;
;int close(int fd) {
	code
	xdef	~~close
	func
~~close:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L51
	tcs
	phd
	tcd
fd_0	set	4
;
;	//debugf("close fd:%d\n", (long)fd);
;	
;	aclose(fd2iocb[fd]);
	ldx	<L51+fd_0
	lda	|~~fd2iocb,X
	pha
	jsl	~~aclose
;	fd2iocb[fd] = 0xff;
	sep	#$20
	longa	off
	lda	#$ff
	ldx	<L51+fd_0
	sta	|~~fd2iocb,X
	rep	#$20
	longa	on
;		
;	return 0;
	lda	#$0
	tay
	lda	<L51+2
	sta	<L51+2+2
	lda	<L51+1
	sta	<L51+1+2
	pld
	tsc
	clc
	adc	#L51+2
	tcs
	tya
	rtl
;}
L51	equ	0
L52	equ	1
	ends
	efunc
;
;
;int open(const char *path, int flags) {
	code
	xdef	~~open
	func
~~open:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L54
	tcs
	phd
	tcd
path_0	set	4
flags_0	set	8
;	unsigned int fd;
;	unsigned char iocb, rc, mode;
;	//char hex[5];
;	
;	//aputchr(0, (char *)path, strlen(path));
;	//sprintf(hex, "%04X", flags);
;	//aputchr(0, hex, sizeof(hex));
;	//aputchr(0, "\n", 1ul);
;	
;	for(fd = 0; fd < 8; fd++) {
fd_1	set	0
iocb_1	set	2
rc_1	set	3
mode_1	set	4
	stz	<L55+fd_1
L10009:
;		if (fd2iocb[fd] >= 8) break;
	sep	#$20
	longa	off
	ldx	<L55+fd_1
	lda	|~~fd2iocb,X
	cmp	#<$8
	rep	#$20
	longa	on
	bcs	L10008
;	}
	inc	<L55+fd_1
	lda	<L55+fd_1
	cmp	#<$8
	bcc	L10009
L10008:
;	
;	//debugf("open fd:%d, flags:%04X\n", (long)fd, (long)flags);
;	
;	if (fd >= 8) {
	lda	<L55+fd_1
	cmp	#<$8
	bcc	L10010
;		fd = -1; 
L20001:
	lda	#$ffff
	sta	<L55+fd_1
;		goto open_exit;
	brl	L10011
;	}
;		
;	iocb = getFreeIocb();
L10010:
	jsl	~~getFreeIocb
	sep	#$20
	longa	off
	sta	<L55+iocb_1
;	if (iocb >= 8) {
	cmp	#<$8
	rep	#$20
	longa	on
	bcs	L20001
;		fd = -1; 
;		goto open_exit;
;	}
;	
;	//debugf("open iocb:%d \n", (size_t)iocb);
;	
;	mode = 0;
	sep	#$20
	longa	off
	stz	<L55+mode_1
	rep	#$20
	longa	on
;	if ((flags & (O_RDONLY | O_RDWR | O_BINARY | O_TEXT)) || !flags) mode += 4;
	lda	<L54+flags_0
	and	#<$9002
	bne	L60
	lda	<L54+flags_0
	bne	L10013
L60:
	sep	#$20
	longa	off
	lda	#$4
	clc
	adc	<L55+mode_1
	sta	<L55+mode_1
	rep	#$20
	longa	on
;	if (flags & (O_WRONLY | O_CREAT | O_RDWR | O_BINARY)) mode += 8;
L10013:
	lda	<L54+flags_0
	and	#<$8103
	beq	L10014
	sep	#$20
	longa	off
	lda	#$8
	clc
	adc	<L55+mode_1
	sta	<L55+mode_1
	rep	#$20
	longa	on
;	if (flags & O_APPEND) mode += 1;
L10014:
	lda	<L54+flags_0
	and	#<$800
	beq	L10015
	sep	#$20
	longa	off
	inc	<L55+mode_1
	rep	#$20
	longa	on
;	
;	//sprintf(hex, "%04X", mode);
;	//aputchr(0, hex, sizeof(hex));
;	//aputchr(0, "\n", 1ul);
;
;	//debugf("open, before aopen\n");
;	//dump((char *)0x500, 256, 0);
;	//debugf("open\n");
;	
;	rc = aopen(iocb, (char *)path, mode, 0);
L10015:
	pea	#<$0
	pei	<L55+mode_1
	pei	<L54+path_0+2
	pei	<L54+path_0
	pei	<L55+iocb_1
	jsl	~~aopen
	sep	#$20
	longa	off
	sta	<L55+rc_1
;
;	//debugf("open fd:%d, iocb:%d, rc:%d \n", (unsigned long)fd, (unsigned long)iocb, (unsigned long)rc);
;	//dump((char *)0x500, 256, 0);
;	//debugf("\n");
;	
;	if (rc >= 128) {
	cmp	#<$80
	rep	#$20
	longa	on
	bcc	L10016
;		aclose(iocb);
	pei	<L55+iocb_1
	jsl	~~aclose
;		fd2iocb[fd] = 0xff;
	sep	#$20
	longa	off
	lda	#$ff
	ldx	<L55+fd_1
	sta	|~~fd2iocb,X
	rep	#$20
	longa	on
;		fd = -1;
;		goto open_exit;
	brl	L20001
;	}	
;	
;	fd2iocb[fd] = iocb;
L10016:
	sep	#$20
	longa	off
	lda	<L55+iocb_1
	ldx	<L55+fd_1
	sta	|~~fd2iocb,X
	rep	#$20
	longa	on
;	
;open_exit:
L10011:
;	
;	return fd;
	lda	<L55+fd_1
	tay
	lda	<L54+2
	sta	<L54+2+6
	lda	<L54+1
	sta	<L54+1+6
	pld
	tsc
	clc
	adc	#L54+6
	tcs
	tya
	rtl
;}
L54	equ	5
L55	equ	1
	ends
	efunc
;
;
;int stat(const char *filename, struct stat *buf) {
	code
	xdef	~~stat
	func
~~stat:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L67
	tcs
	phd
	tcd
filename_0	set	4
buf_0	set	8
;	int fd, rc;
;	
;	buf->st_size = 0;
fd_1	set	0
rc_1	set	2
	lda	#$0
	ldy	#$2
	sta	[<L67+buf_0],Y
	iny
	iny
	sta	[<L67+buf_0],Y
;	
;	fd = open(filename, O_RDONLY);
	pea	#<$0
	pei	<L67+filename_0+2
	pei	<L67+filename_0
	jsl	~~open
	sta	<L68+fd_1
;	
;	if (fd == -1) {
	cmp	#<$ffffffff
	beq	L20004
;		rc = -1;
;		goto stat_exit;
;	}
;
;	//debugf("stat before aopen\n");
;	//dump((char *)0x500, 256, 0);
;	
;	rc = astat(fd2iocb[fd], buf);
	pei	<L67+buf_0+2
	pei	<L67+buf_0
	ldx	<L68+fd_1
	lda	|~~fd2iocb,X
	pha
	jsl	~~astat
	sep	#$20
	longa	off
	sta	<R0
	rep	#$20
	longa	on
	lda	<R0
	and	#$ff
	sta	<L68+rc_1
;	
;	//debugf("stat iocb:%d \n", (size_t)fd2iocb[fd]);
;	//debugf("stat fd: %d, rc: %d\n", (long)fd, (long)rc);
;
;	if (rc >= 128) rc = -1;
	sec
	sbc	#<$80
	bvs	L70
	eor	#$8000
L70:
	bpl	L10018
L20004:
	lda	#$ffff
	sta	<L68+rc_1
;	
;stat_exit:
L10018:
;	//debugf("stat before close\n");
;	//dump((char *)0x500, 256, 0);
;	
;	if (!(rc == -1)) 
;		close(fd);
	lda	<L68+rc_1
	cmp	#<$ffffffff
	beq	L10020
	pei	<L68+fd_1
	jsl	~~close
;	
;	//debugf("stat fd: %d, rc: %d\n", (long)fd, (long)rc);
;	//dump((char *)0x500, 256, 0);
;	
;	return rc;
L10020:
	lda	<L68+rc_1
	tay
	lda	<L67+2
	sta	<L67+2+8
	lda	<L67+1
	sta	<L67+1+8
	pld
	tsc
	clc
	adc	#L67+8
	tcs
	tya
	rtl
;}
L67	equ	8
L68	equ	5
	ends
	efunc
;
;long lseek(int fd, long offset, int whence) {
	code
	xdef	~~lseek
	func
~~lseek:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L74
	tcs
	phd
	tcd
fd_0	set	4
offset_0	set	6
whence_0	set	10
;	//debugf("lseek fd:%d, offset:%d, whence:%d off_t:%d\n", (long)fd, offset, (long)whence, (long)sizeof(off_t));
;
;	//printf("lseek: fd:%d, offset: %lu, whence %d\n", fd, offset, whence);
;	return 0;
	lda	#$0
	tax
	tay
	lda	<L74+2
	sta	<L74+2+8
	lda	<L74+1
	sta	<L74+1+8
	pld
	tsc
	clc
	adc	#L74+8
	tcs
	tya
	rtl
;}
L74	equ	0
L75	equ	1
	ends
	efunc
;
;int unlink(const char *pathname) {
	code
	xdef	~~unlink
	func
~~unlink:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L77
	tcs
	phd
	tcd
pathname_0	set	4
;}
	tay
	lda	<L77+2
	sta	<L77+2+4
	lda	<L77+1
	sta	<L77+1+4
	pld
	tsc
	clc
	adc	#L77+4
	tcs
	tya
	rtl
L77	equ	0
L78	equ	1
	ends
	efunc
;
;int ftruncate(int fd, off_t length) {
	code
	xdef	~~ftruncate
	func
~~ftruncate:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L80
	tcs
	phd
	tcd
fd_0	set	4
length_0	set	6
;}
	tay
	lda	<L80+2
	sta	<L80+2+6
	lda	<L80+1
	sta	<L80+1+6
	pld
	tsc
	clc
	adc	#L80+6
	tcs
	tya
	rtl
L80	equ	0
L81	equ	1
	ends
	efunc
;
;static void prependDevname(char *s) {
	code
	func
~~prependDevname:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L83
	tcs
	phd
	tcd
s_0	set	4
;	
;	if (!(s[0] == 'D' && s[1] == ':')) {
	sep	#$20
	longa	off
	lda	[<L83+s_0]
	cmp	#<$44
	rep	#$20
	longa	on
	bne	L85
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L83+s_0],Y
	cmp	#<$3a
	rep	#$20
	longa	on
	beq	L88
L85:
;		memmove(s+2, s, strlen(s)+1);
	pei	<L83+s_0+2
	pei	<L83+s_0
	jsl	~~strlen
	ina
	pha
	pei	<L83+s_0+2
	pei	<L83+s_0
	lda	#$2
	clc
	adc	<L83+s_0
	sta	<R0
	lda	#$0
	adc	<L83+s_0+2
	pha
	pei	<R0
	jsl	~~memmove
;		s[0] = 'D';
	sep	#$20
	longa	off
	lda	#$44
	sta	[<L83+s_0]
;		s[1] = ':';
	lda	#$3a
	ldy	#$1
	sta	[<L83+s_0],Y
	rep	#$20
	longa	on
;	}
;}
L88:
	lda	<L83+2
	sta	<L83+2+4
	lda	<L83+1
	sta	<L83+1+4
	pld
	tsc
	clc
	adc	#L83+4
	tcs
	rtl
L83	equ	4
L84	equ	5
	ends
	efunc
;
;/*
;static int chOneDir(const char *s) {
;	unsigned int i;
;	unsigned int len;
;	unsigned char iocb;
;	char s0[16];
;	int rc;
;
;	len = strlen(s);
;	//int_rc = 0;
;	
;	if (len > 0) {
;		strcpy(s0, s);
;		strupper(s0);
;	
;		s0[len] = '\n';
;		s0[len+1] = 0;
;
;		prependDevname(s0);
;		iocb = getFreeIocb();
;		if (iocb < 8) {
;			rc = achdir(iocb, s0);
;		}
;
;		if (iocb >= 8 || rc >= 128) {
;			rc = -1;
;		}
;	}
;	
;	return rc;
;}
;
;int chdir(const char *path) {
;	
;	char *p, *p0, *pSave;
;	int end = 0;
;	int rc;
;		
;	p = pSave = strdup((char *)path);
;	
;	rc = -1;
;	
;	if (*p == '/'){
;		rc = chOneDir("/");
;		p++;
;	}
;	
;	for(p0 = p; !end; p0++) {
;		if (*p0 == 0) end = 1;
;		
;		if (*p0 == '/' || *p0 == 0) {
;			*p0 = 0;
;			rc = chOneDir(p);
;			if (rc == -1) break;
;			p = p0 + 1;
;		}
;	}		
;	
;	free(pSave);
;	
;	return rc;
;}
;
;DIR *opendir(const char *path) {
;	unsigned int fd;
;	unsigned char iocb, rc;
;	DIR *dfd;
;	unsigned char *p;
;
;	dfd == NULL;
;	
;	for(fd = 0; fd < 8; fd++) {
;		if (fd2iocb[fd] >= 8) break;
;	}
;	
;	//debugf("opendir fd:%d \n", (size_t)fd);
;	
;	if (fd >= 8) goto opendir_exit;
;	
;	iocb = getFreeIocb();
;	if (iocb >= 8) goto opendir_exit;
;
;	//debugf("opendir iocb:%d \n", (size_t)iocb);
;
;	//p = calloc(1, strlen(path) + 10);
;	p = malloc(strlen(path) + 10);
;	*p = 0;
;	
;	if (path[0] != 'D' || path[1] != ':') {
;		strcpy(p, "D:");
;	}
;	
;	strcat(p, path);
;	//strupper(p);
;
;	rc = aopen(iocb, p, 6, 0);
;	free(p);
;
;	//debugf("opendir rc:%d \n", (size_t)rc);
;	
;	if (rc >= 128) {
;		close(fd);
;		return NULL;
;	}	
;	
;	fd2iocb[fd] = iocb;
;
;	dir_fd[fd] = fd;
;	dfd = &dir_fd[fd];
;
;opendir_exit:
;	return dfd;
;}
;
;int closedir (DIR *__dirp) {
;	close(__dirp->fd);
;}
;
;struct dirent *readdir (DIR *__dirp) {
;	struct dirent *d;
;	unsigned char rc;
;			
;	d = &dirent[__dirp->fd];
;	memset(d->d_name, 0, sizeof(d->d_name));
;	//strcpy(d->d_name, "TEST");
;	//*(d->d_name) = 0;
;	
;	//printf("readdir calling...\n", rc);
;	
;	rc = agetrec(fd2iocb[__dirp->fd], d->d_name);
;	
;	//printf("readdir rc: %d\n", rc);
;		
;	if (rc >= 128) {
;		close(__dirp->fd);
;		return NULL;
;	}
;	
;	d->d_reclen = strlen(d->d_name);
;			
;	return d;
;}*/
;
	xref	~~strlen
	xref	~~memmove
	udata
	xdef	~~fd2iocb
~~fd2iocb
	ds	8
	ends
	xref	~~errno
