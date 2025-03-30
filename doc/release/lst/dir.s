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
;static unsigned int parsedir(char *path) {
	code
	func
~~parsedir:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
path_0	set	4
;	
;	char *p, *p0, *pathcopy;
;	int end;
;	int rc;
;	unsigned int index;
;	
;	pathcopy = p = strdup(path);
p_1	set	0
p0_1	set	4
pathcopy_1	set	8
end_1	set	12
rc_1	set	14
index_1	set	16
	pei	<L2+path_0+2
	pei	<L2+path_0
	jsl	~~strdup
	sta	<L3+p_1
	stx	<L3+p_1+2
	sta	<L3+pathcopy_1
	lda	<L3+p_1+2
	sta	<L3+pathcopy_1+2
;	
;	rc = -1;
	lda	#$ffff
	sta	<L3+rc_1
;	end = 0;
	stz	<L3+end_1
;	index = 0;
	stz	<L3+index_1
;	
;	if (*p == '/'){
	sep	#$20
	longa	off
	lda	[<L3+p_1]
	cmp	#<$2f
	rep	#$20
	longa	on
	bne	L10001
;		rc = chdir("/");
	pea	#^L1
	pea	#<L1
	jsl	~~chdir
	sta	<L3+rc_1
;		p++;
	inc	<L3+p_1
	bne	L10001
	inc	<L3+p_1+2
;	}
;	
;	for (p0 = p; !end; p0++) {
L10001:
	lda	<L3+p_1
	sta	<L3+p0_1
	lda	<L3+p_1+2
	sta	<L3+p0_1+2
	bra	L10005
L10004:
;		if (*p0 == 0) end = 1;
	lda	[<L3+p0_1]
	and	#$ff
	bne	L10006
	lda	#$1
	sta	<L3+end_1
;		
;		if (*p0 == '/' || *p0 == 0) {
L10006:
	sep	#$20
	longa	off
	lda	[<L3+p0_1]
	cmp	#<$2f
	rep	#$20
	longa	on
	beq	L7
	lda	[<L3+p0_1]
	and	#$ff
	bne	L10002
L7:
;			*p0 = 0;
	sep	#$20
	longa	off
	lda	#$0
	sta	[<L3+p0_1]
;			if (*p == '*') break;
	lda	[<L3+p_1]
	cmp	#<$2a
	rep	#$20
	longa	on
	beq	L10003
;			rc = chdir(p);
	pei	<L3+p_1+2
	pei	<L3+p_1
	jsl	~~chdir
	sta	<L3+rc_1
;			//printf("parsedir rc=%d\n", rc);
;			if (rc == -1) break;
	cmp	#<$ffffffff
	beq	L10003
;			p = p0 + 1;
	lda	#$1
	clc
	adc	<L3+p0_1
	sta	<L3+p_1
	lda	#$0
	adc	<L3+p0_1+2
	sta	<L3+p_1+2
;			index = (size_t)p - (size_t)pathcopy;
	sec
	lda	<L3+p_1
	sbc	<L3+pathcopy_1
	sta	<R0
	lda	<L3+p_1+2
	sbc	<L3+pathcopy_1+2
	sta	<R0+2
	lda	<R0
	sta	<L3+index_1
;			//printf("parsedir index=%d\n", index);
;		}
;	}
L10002:
	inc	<L3+p0_1
	bne	L10005
	inc	<L3+p0_1+2
L10005:
	lda	<L3+end_1
	beq	L10004
L10003:
;	
;	//printf("parsedir index=%d\n", index);
;	
;	free(pathcopy);
	pei	<L3+pathcopy_1+2
	pei	<L3+pathcopy_1
	jsl	~~free
;	
;	return index;
	lda	<L3+index_1
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
L2	equ	22
L3	equ	5
	ends
	efunc
	data
L1:
	db	$2F,$00
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
	sbc	#L16
	tcs
	phd
	tcd
argc_0	set	4
argv_0	set	6
;	DIR *dir;
;	struct dirent *dirent;
;	char *s, *s0;
;	char *shellpath;
;	unsigned int len, cnt, c;
;
;	s = calloc(1, 80);
dir_1	set	0
dirent_1	set	4
s_1	set	8
s0_1	set	12
shellpath_1	set	16
len_1	set	20
cnt_1	set	22
c_1	set	24
	pea	#^$50
	pea	#<$50
	pea	#^$1
	pea	#<$1
	jsl	~~calloc
	sta	<L17+s_1
	stx	<L17+s_1+2
;	
;	if (argc >= 2) {
	sec
	lda	<L16+argc_0
	sbc	#<$2
	bvs	L18
	eor	#$8000
L18:
	bpl	L10008
;		strcpy(s, argv[1]);
	ldy	#$6
	lda	[<L16+argv_0],Y
	pha
	dey
	dey
	lda	[<L16+argv_0],Y
	pha
	pei	<L17+s_1+2
	pei	<L17+s_1
	jsl	~~strcpy
;		strupper(s);
	pei	<L17+s_1+2
	pei	<L17+s_1
	jsl	~~strupper
;	}
;	
;	shellpath = getShellpath();
L10008:
	jsl	~~getShellpath
	sta	<L17+shellpath_1
	stx	<L17+shellpath_1+2
;	chdir(shellpath);
	pei	<L17+shellpath_1+2
	pei	<L17+shellpath_1
	jsl	~~chdir
;
;	len = parsedir(s);
	pei	<L17+s_1+2
	pei	<L17+s_1
	jsl	~~parsedir
	sta	<L17+len_1
;	//printf("dir s=%s len=%d\n", s, len);
;	
;	s0 = s + len;
	sta	<R0
	stz	<R0+2
	lda	<L17+s_1
	clc
	adc	<R0
	sta	<L17+s0_1
	lda	<L17+s_1+2
	adc	<R0+2
	sta	<L17+s0_1+2
;	len = strlen(s0);
	pha
	pei	<L17+s0_1
	jsl	~~strlen
	sta	<L17+len_1
;	
;	//printf("dir s=%s len=%d\n", s0, len);
;	if (len == 0) {
	lda	<L17+len_1
	bne	L10009
;		s0 = s;
	lda	<L17+s_1
	sta	<L17+s0_1
	lda	<L17+s_1+2
	sta	<L17+s0_1+2
;		strcpy(s0, "D:*.*");
	pea	#^L15
	pea	#<L15
	pei	<L17+s0_1+2
	pei	<L17+s0_1
	jsl	~~strcpy
;	}
;	//printf("dir s=%s len=%d\n", s0, strlen(s0));
;	
;	dir = opendir(s0);
L10009:
	pei	<L17+s0_1+2
	pei	<L17+s0_1
	jsl	~~opendir
	sta	<L17+dir_1
	stx	<L17+dir_1+2
;	
;	//printf("opendir dir=%p\n", dir);
;	
;	cnt = 0;
	stz	<L17+cnt_1
;	while (dir && (dirent = readdir(dir))) {
L10010:
	lda	<L17+dir_1
	ora	<L17+dir_1+2
	beq	L25
	pei	<L17+dir_1+2
	pei	<L17+dir_1
	jsl	~~readdir
	sta	<L17+dirent_1
	stx	<L17+dirent_1+2
	ora	<L17+dirent_1+2
	beq	L25
;		printf("%s", dirent->d_name);
	lda	#$b
	clc
	adc	<L17+dirent_1
	sta	<R0
	lda	#$0
	adc	<L17+dirent_1+2
	pha
	pei	<R0
	pea	#^L15+6
	pea	#<L15+6
	pea	#10
	jsl	~~printf
;		cnt++;
	inc	<L17+cnt_1
;		if (cnt >= 20) {
	lda	<L17+cnt_1
	cmp	#<$14
	bcc	L10010
;			cnt = 0;
	stz	<L17+cnt_1
;			c = toupper(getchar());
	lda	|~~stdin+2
	pha
	lda	|~~stdin
	pha
	jsl	~~fgetc
	pha
	jsl	~~toupper
	sta	<L17+c_1
;			if (c == 'X') break;
	cmp	#<$58
	bne	L10010
L25:
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
;		}
;	}
;	
;	//getchar();
;}
L16	equ	30
L17	equ	5
	ends
	efunc
	data
L15:
	db	$44,$3A,$2A,$2E,$2A,$00,$25,$73,$00
	ends
;
	xref	~~toupper
	xref	~~getShellpath
	xref	~~strupper
	xref	~~readdir
	xref	~~opendir
	xref	~~chdir
	xref	~~strdup
	xref	~~strlen
	xref	~~strcpy
	xref	~~free
	xref	~~calloc
	xref	~~fgetc
	xref	~~printf
	xref	~~stdin
