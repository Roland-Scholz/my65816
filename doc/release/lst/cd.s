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
;static void back(char *p, unsigned int len) {
	code
	func
~~back:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
p_0	set	4
len_0	set	8
;	
;	int i;
;	
;	for (i = len-1; i >= 0; i--) {
i_1	set	0
	lda	#$ffff
	clc
	adc	<L2+len_0
	sta	<L3+i_1
	bra	L10004
;		}
;	}
L10001:
	dec	<L3+i_1
L10004:
	lda	<L3+i_1
	bmi	L7
;		if (p[i] == '/') {
	sep	#$20
	longa	off
	ldy	<L3+i_1
	lda	[<L2+p_0],Y
	cmp	#<$2f
	rep	#$20
	longa	on
	bne	L10001
;			if (i == 0) i++;
	tya
	bne	L10006
	inc	<L3+i_1
;			p[i] = 0;
L10006:
	sep	#$20
	longa	off
	lda	#$0
	ldy	<L3+i_1
	sta	[<L2+p_0],Y
	rep	#$20
	longa	on
;			break;
L7:
	lda	<L2+2
	sta	<L2+2+6
	lda	<L2+1
	sta	<L2+1+6
	pld
	tsc
	clc
	adc	#L2+6
	tcs
	rtl
;}
L2	equ	2
L3	equ	1
	ends
	efunc
;	
;static void adjustShellPath(char *path, char *shellpath) {
	code
	func
~~adjustShellPath:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L8
	tcs
	phd
	tcd
path_0	set	4
shellpath_0	set	8
;	
;	unsigned int len;
;	
;	len = strlen(shellpath);
len_1	set	0
	pei	<L8+shellpath_0+2
	pei	<L8+shellpath_0
	jsl	~~strlen
	sta	<L9+len_1
;	
;	if (path[0] == '.' && path[1] == '.') {
	sep	#$20
	longa	off
	lda	[<L8+path_0]
	cmp	#<$2e
	rep	#$20
	longa	on
	bne	L10007
	sep	#$20
	longa	off
	ldy	#$1
	lda	[<L8+path_0],Y
	cmp	#<$2e
	rep	#$20
	longa	on
	bne	L10007
;		back(shellpath, len);
	pei	<L9+len_1
	pei	<L8+shellpath_0+2
	pei	<L8+shellpath_0
	jsl	~~back
;		return;
L12:
	lda	<L8+2
	sta	<L8+2+8
	lda	<L8+1
	sta	<L8+1+8
	pld
	tsc
	clc
	adc	#L8+8
	tcs
	rtl
;	}
;	
;	if (path[0] == '.') return;
L10007:
	sep	#$20
	longa	off
	lda	[<L8+path_0]
	cmp	#<$2e
	rep	#$20
	longa	on
	beq	L12
;	
;	if (!(shellpath[len -1] == '/' || path[0] == '/')) {
	lda	#$ffff
	clc
	adc	<L9+len_1
	tay
	sep	#$20
	longa	off
	lda	[<L8+shellpath_0],Y
	cmp	#<$2f
	rep	#$20
	longa	on
	beq	L10009
	sep	#$20
	longa	off
	lda	[<L8+path_0]
	cmp	#<$2f
	rep	#$20
	longa	on
	beq	L10009
;		strcat(shellpath, "/");
	pea	#^L1
	pea	#<L1
	pei	<L8+shellpath_0+2
	pei	<L8+shellpath_0
	jsl	~~strcat
;	}
;	
;	strcat(shellpath, path);
L10009:
	pei	<L8+path_0+2
	pei	<L8+path_0
	pei	<L8+shellpath_0+2
	pei	<L8+shellpath_0
	jsl	~~strcat
;}
	bra	L12
L8	equ	6
L9	equ	5
	ends
	efunc
	data
L1:
	db	$2F,$00
	ends
;
;static unsigned int parsedir(char *path, char *shellpath) {
	code
	func
~~parsedir:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L17
	tcs
	phd
	tcd
path_0	set	4
shellpath_0	set	8
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
	pei	<L17+path_0+2
	pei	<L17+path_0
	jsl	~~strdup
	sta	<L18+p_1
	stx	<L18+p_1+2
	sta	<L18+pathcopy_1
	lda	<L18+p_1+2
	sta	<L18+pathcopy_1+2
;	
;	rc = -1;
	lda	#$ffff
	sta	<L18+rc_1
;	end = 0;
	stz	<L18+end_1
;	index = 0;
	stz	<L18+index_1
;	
;	if (*p == '/'){
	sep	#$20
	longa	off
	lda	[<L18+p_1]
	cmp	#<$2f
	rep	#$20
	longa	on
	bne	L10010
;		rc = chdir("/");
	pea	#^L16
	pea	#<L16
	jsl	~~chdir
	sta	<L18+rc_1
;		strcpy(shellpath, "/");
	pea	#^L16+2
	pea	#<L16+2
	pei	<L17+shellpath_0+2
	pei	<L17+shellpath_0
	jsl	~~strcpy
;		p++;
	inc	<L18+p_1
	bne	L10010
	inc	<L18+p_1+2
;	}
;	
;	for (p0 = p; !end; p0++) {
L10010:
	lda	<L18+p_1
	sta	<L18+p0_1
	lda	<L18+p_1+2
	sta	<L18+p0_1+2
	bra	L10014
L10013:
;		if (*p0 == 0) end = 1;
	lda	[<L18+p0_1]
	and	#$ff
	bne	L10015
	lda	#$1
	sta	<L18+end_1
;		
;		if (*p0 == '/' || *p0 == 0) {
L10015:
	sep	#$20
	longa	off
	lda	[<L18+p0_1]
	cmp	#<$2f
	rep	#$20
	longa	on
	beq	L22
	lda	[<L18+p0_1]
	and	#$ff
	bne	L10011
L22:
;			*p0 = 0;
	sep	#$20
	longa	off
	lda	#$0
	sta	[<L18+p0_1]
	rep	#$20
	longa	on
;			//if (*p == '*') break;
;			rc = chdir(p);
	pei	<L18+p_1+2
	pei	<L18+p_1
	jsl	~~chdir
	sta	<L18+rc_1
;			//printf("parsedir rc=%d\n", rc);
;			if (rc == -1) break;
	cmp	#<$ffffffff
	beq	L10012
;			adjustShellPath(p, shellpath);
	pei	<L17+shellpath_0+2
	pei	<L17+shellpath_0
	pei	<L18+p_1+2
	pei	<L18+p_1
	jsl	~~adjustShellPath
;			p = p0 + 1;
	lda	#$1
	clc
	adc	<L18+p0_1
	sta	<L18+p_1
	lda	#$0
	adc	<L18+p0_1+2
	sta	<L18+p_1+2
;			index = (size_t)p - (size_t)pathcopy;
	sec
	lda	<L18+p_1
	sbc	<L18+pathcopy_1
	sta	<R0
	lda	<L18+p_1+2
	sbc	<L18+pathcopy_1+2
	sta	<R0+2
	lda	<R0
	sta	<L18+index_1
;			//printf("parsedir index=%d\n", index);
;		}
;	}
L10011:
	inc	<L18+p0_1
	bne	L10014
	inc	<L18+p0_1+2
L10014:
	lda	<L18+end_1
	beq	L10013
L10012:
;	
;	//printf("parsedir index=%d\n", index);
;	
;	free(pathcopy);
	pei	<L18+pathcopy_1+2
	pei	<L18+pathcopy_1
	jsl	~~free
;	
;	return index;
	lda	<L18+index_1
	tay
	lda	<L17+2
	sta	<L17+2+8
	lda	<L17+1
	sta	<L17+1+8
	pld
	tsc
	clc
	adc	#L17+8
	tcs
	tya
	rtl
;}
L17	equ	22
L18	equ	5
	ends
	efunc
	data
L16:
	db	$2F,$00,$2F,$00
	ends
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
	sbc	#L30
	tcs
	phd
	tcd
argc_0	set	4
argv_0	set	6
;	
;	char *p, c;
;	unsigned int len;
;	int rc;
;	
;	if (argc != 2) {
p_1	set	0
c_1	set	4
len_1	set	5
rc_1	set	7
	lda	<L30+argc_0
	cmp	#<$2
	beq	L10017
;		return 8;
	lda	#$8
L33:
	tay
	lda	<L30+2
	sta	<L30+2+6
	lda	<L30+1
	sta	<L30+1+6
	pld
	tsc
	clc
	adc	#L30+6
	tcs
	tya
	rtl
;	} 
;	
;	p = getShellpath();
L10017:
	jsl	~~getShellpath
	sta	<L31+p_1
	stx	<L31+p_1+2
;	rc = chdir(p);
	pei	<L31+p_1+2
	pei	<L31+p_1
	jsl	~~chdir
	sta	<L31+rc_1
;	
;	if (rc == -1) {
	cmp	#<$ffffffff
	bne	L10018
;		strcpy(p, "/");
	pea	#^L29
	pea	#<L29
	pei	<L31+p_1+2
	pei	<L31+p_1
	jsl	~~strcpy
;		rc = chdir(p);
	pei	<L31+p_1+2
	pei	<L31+p_1
	jsl	~~chdir
	sta	<L31+rc_1
;		return 0;
L20000:
	lda	#$0
	bra	L33
;	}
;	
;	parsedir(argv[1], p);
L10018:
	pei	<L31+p_1+2
	pei	<L31+p_1
	ldy	#$6
	lda	[<L30+argv_0],Y
	pha
	dey
	dey
	lda	[<L30+argv_0],Y
	pha
	jsl	~~parsedir
;	
;	//printf("shellpath: %s\n", p);
;	
;	return 0;
	bra	L20000
;}
L30	equ	9
L31	equ	1
	ends
	efunc
	data
L29:
	db	$2F,$00
	ends
;
;
	xref	~~chdir
	xref	~~getShellpath
	xref	~~strdup
	xref	~~strlen
	xref	~~strcat
	xref	~~strcpy
	xref	~~free
