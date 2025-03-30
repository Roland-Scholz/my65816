;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
;#define SLOW
;/*
; * puff.c
; * Copyright (C) 2002-2010 Mark Adler
; * For conditions of distribution and use, see copyright notice in puff.h
; * version 2.2, 25 Apr 2010
; *
; * puff.c is a simple inflate written to be an unambiguous way to specify the
; * deflate format.  It is not written for speed but rather simplicity.  As a
; * side benefit, this code might actually be useful when small code is more
; * important than speed, such as bootstrap applications.  For typical deflate
; * data, zlib's inflate() is about four times as fast as puff().  zlib's
; * inflate compiles to around 20K on my machine, whereas puff.c compiles to
; * around 4K on my machine (a PowerPC using GNU cc).  If the faster decode()
; * function here is used, then puff() is only twice as slow as zlib's
; * inflate().
; *
; * All dynamically allocated memory comes from the stack.  The stack required
; * is less than 2K bytes.  This code is compatible with 16-bit int's and
; * assumes that long's are at least 32 bits.  puff.c uses the short data type,
; * assumed to be 16 bits, for arrays in order to to conserve memory.  The code
; * works whether integers are stored big endian or little endian.
; *
; * In the comments below are "Format notes" that describe the inflate process
; * and document some of the less obvious aspects of the format.  This source
; * code is meant to supplement RFC 1951, which formally describes the deflate
; * format:
; *
; *    http://www.zlib.org/rfc-deflate.html
; */
;
;/*
; * Change history:
; *
; * 1.0  10 Feb 2002     - First version
; * 1.1  17 Feb 2002     - Clarifications of some comments and notes
; *                      - Update puff() dest and source pointers on negative
; *                        errors to facilitate debugging deflators
; *                      - Remove longest from struct huffman -- not needed
; *                      - Simplify offs[] index in construct()
; *                      - Add input size and checking, using longjmp() to
; *                        maintain easy readability
; *                      - Use short data type for large arrays
; *                      - Use pointers instead of long to specify source and
; *                        destination sizes to avoid arbitrary 4 GB limits
; * 1.2  17 Mar 2002     - Add faster version of decode(), doubles speed (!),
; *                        but leave simple version for readabilty
; *                      - Make sure invalid distances detected if pointers
; *                        are 16 bits
; *                      - Fix fixed codes table error
; *                      - Provide a scanning mode for determining size of
; *                        uncompressed data
; * 1.3  20 Mar 2002     - Go back to lengths for puff() parameters [Gailly]
; *                      - Add a puff.h file for the interface
; *                      - Add braces in puff() for else do [Gailly]
; *                      - Use indexes instead of pointers for readability
; * 1.4  31 Mar 2002     - Simplify construct() code set check
; *                      - Fix some comments
; *                      - Add FIXLCODES #define
; * 1.5   6 Apr 2002     - Minor comment fixes
; * 1.6   7 Aug 2002     - Minor format changes
; * 1.7   3 Mar 2003     - Added test code for distribution
; *                      - Added zlib-like license
; * 1.8   9 Jan 2004     - Added some comments on no distance codes case
; * 1.9  21 Feb 2008     - Fix bug on 16-bit integer architectures [Pohland]
; *                      - Catch missing end-of-block symbol error
; * 2.0  25 Jul 2008     - Add #define to permit distance too far back
; *                      - Add option in TEST code for puff to write the data
; *                      - Add option in TEST code to skip input bytes
; *                      - Allow TEST code to read from piped stdin
; * 2.1   4 Apr 2010     - Avoid variable initialization for happier compilers
; *                      - Avoid unsigned comparisons for even happier compilers
; * 2.2  25 Apr 2010     - Fix bug in variable initializations [Oberhumer]
; *                      - Add const where appropriate [Oberhumer]
; *                      - Split if's and ?'s for coverage testing
; *                      - Break out test code to separate file
; *                      - Move NIL to puff.h
; *                      - Allow incomplete code only if single code length is 1
; *                      - Add full code coverage test to Makefile
; */
;
;#include <stdio.h>
;#include <stdlib.h>
;#include <setjmp.h>             /* for setjmp(), longjmp(), and jmp_buf */
;#include "puff.h"               /* prototype for puff() */
;
;int debugf(const char *format, ...);
;
;#define local static            /* for local function definitions */
;
;/*
; * Maximums for allocations and loops.  It is not useful to change these --
; * they are fixed by the deflate format.
; */
;#define MAXBITS 15              /* maximum bits in a code */
;#define MAXLCODES 286           /* maximum number of literal/length codes */
;#define MAXDCODES 30            /* maximum number of distance codes */
;#define MAXCODES (MAXLCODES+MAXDCODES)  /* maximum codes lengths to read */
;#define FIXLCODES 288           /* number of fixed literal/length codes */
;
;/* input and output state */
;struct state {
;    /* output state */
;    unsigned char *out;         /* output buffer */
;    unsigned long outlen;       /* available space at out */
;    unsigned long outcnt;       /* bytes written to out so far */
;
;    /* input state */
;    const unsigned char *in;    /* input buffer */
;    unsigned long inlen;        /* available input at in */
;    unsigned long incnt;        /* bytes read so far */
;    int bitbuf;                 /* bit buffer */
;    int bitcnt;                 /* number of bits in bit buffer */
;
;    /* input limit error return state for bits() and decode() */
;    jmp_buf env;
;};
;
;/*
; * Return need bits from the input stream.  This always leaves less than
; * eight bits in the buffer.  bits() works properly for need == 0.
; *
; * Format notes:
; *
; * - Bits are stored in bytes from the least significant bit to the most
; *   significant bit.  Therefore bits are dropped from the bottom of the bit
; *   buffer, using shift right, and new bytes are appended to the top of the
; *   bit buffer, using shift left.
; */
;void longjmp(jmp_buf env, int val) {
	code
	xdef	~~longjmp
	func
~~longjmp:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
env_0	set	4
val_0	set	8
;	printf("longjump error: %d\n", val);
	pei	<L2+val_0
	pea	#^L1
	pea	#<L1
	pea	#8
	jsl	~~printf
;}
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
L2	equ	0
L3	equ	1
	ends
	efunc
	data
L1:
	db	$6C,$6F,$6E,$67,$6A,$75,$6D,$70,$20,$65,$72,$72,$6F,$72,$3A
	db	$20,$25,$64,$0A,$00
	ends
; 
;local int bits(struct state *s, int need)
;{
	code
	func
~~bits:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L6
	tcs
	phd
	tcd
s_0	set	4
need_0	set	8
;    long val;           /* bit accumulator (can use up to 20 bits) */
;	int ret;
;	
;    /* load at least need bits into val */
;    val = s->bitbuf;
val_1	set	0
ret_1	set	4
	ldy	#$0
	phy
	ldy	#$18
	lda	[<L6+s_0],Y
	ply
	rol	A
	ror	A
	bpl	L8
	dey
L8:
	sta	<L7+val_1
	sty	<L7+val_1+2
;    while (s->bitcnt < need) {
	brl	L10001
L20001:
;        if (s->incnt == s->inlen)
;            longjmp(s->env, 1);         /* out of input */
	ldy	#$14
	lda	[<L6+s_0],Y
	ldy	#$10
	cmp	[<L6+s_0],Y
	bne	L11
	ldy	#$16
	lda	[<L6+s_0],Y
	ldy	#$12
	cmp	[<L6+s_0],Y
L11:
	bne	L10003
	pea	#<$1
	lda	#$1c
	clc
	adc	<L6+s_0
	sta	<R0
	lda	#$0
	adc	<L6+s_0+2
	pha
	pei	<R0
	jsl	~~longjmp
;		val |= (long)(s->in[s->incnt++]) << s->bitcnt;  /* load eight bits */
L10003:
	ldy	#$14
	lda	[<L6+s_0],Y
	sta	<R1
	iny
	iny
	lda	[<L6+s_0],Y
	sta	<R1+2
	clc
	ldy	#$c
	lda	[<L6+s_0],Y
	adc	<R1
	sta	<R2
	iny
	iny
	lda	[<L6+s_0],Y
	adc	<R1+2
	sta	<R2+2
	lda	[<R2]
	and	#$ff
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	ldy	#$1a
	lda	[<L6+s_0],Y
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	lda	<L7+val_1
	ora	<R0
	sta	<L7+val_1
	lda	<L7+val_1+2
	ora	<R0+2
	sta	<L7+val_1+2
	clc
	lda	#$1
	ldy	#$14
	adc	[<L6+s_0],Y
	sta	[<L6+s_0],Y
	lda	#$0
	iny
	iny
	adc	[<L6+s_0],Y
	sta	[<L6+s_0],Y
;        s->bitcnt += 8;
	lda	#$1a
	clc
	adc	<L6+s_0
	sta	<R0
	lda	#$0
	adc	<L6+s_0+2
	sta	<R0+2
	lda	#$8
	clc
	adc	[<R0]
	sta	[<R0]
;    }
L10001:
	sec
	ldy	#$1a
	lda	[<L6+s_0],Y
	sbc	<L6+need_0
	bvs	L9
	eor	#$8000
L9:
	bmi	*+5
	brl	L20001
;
;    /* drop need bits and update buffer, always zero to seven bits left */
;    s->bitbuf = (int)(val >> need);
	pei	<L7+val_1+2
	pei	<L7+val_1
	lda	<L6+need_0
	xref	~~~lasr
	jsl	~~~lasr
	stx	<R0+2
	ldy	#$18
	sta	[<L6+s_0],Y
;    s->bitcnt -= need;
	lda	#$1a
	clc
	adc	<L6+s_0
	sta	<R0
	lda	#$0
	adc	<L6+s_0+2
	sta	<R0+2
	sec
	lda	[<R0]
	sbc	<L6+need_0
	sta	[<R0]
;
;    /* return need bits, zeroing the bits above that */
;	ret = (int)(val & ((1L << need) - 1));
	pea	#^$1
	pea	#<$1
	lda	<L6+need_0
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	lda	#$ffff
	clc
	adc	<R0
	sta	<R1
	lda	#$ffff
	adc	<R0+2
	sta	<R1+2
	lda	<L7+val_1
	and	<R1
	sta	<R0
	lda	<L7+val_1+2
	and	<R1+2
	sta	<R0+2
	lda	<R0
	sta	<L7+ret_1
;	
;    return ret;
	tay
	lda	<L6+2
	sta	<L6+2+6
	lda	<L6+1
	sta	<L6+1+6
	pld
	tsc
	clc
	adc	#L6+6
	tcs
	tya
	rtl
;}
L6	equ	18
L7	equ	13
	ends
	efunc
;
;/*
; * Process a stored block.
; *
; * Format notes:
; *
; * - After the two-bit stored block type (00), the stored block length and
; *   stored bytes are byte-aligned for fast copying.  Therefore any leftover
; *   bits in the byte that has the last bit of the type, as many as seven, are
; *   discarded.  The value of the discarded bits are not defined and should not
; *   be checked against any expectation.
; *
; * - The second inverted copy of the stored block length does not have to be
; *   checked, but it's probably a good idea to do so anyway.
; *
; * - A stored block can have zero length.  This is sometimes used to byte-align
; *   subsets of the compressed data for random access or partial recovery.
; */
;local int stored(struct state *s)
;{
	code
	func
~~stored:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L14
	tcs
	phd
	tcd
s_0	set	4
;    unsigned len;       /* length of stored block */
;
;	printf("stored\n");
len_1	set	0
	pea	#^L5
	pea	#<L5
	pea	#6
	jsl	~~printf
;	
;    /* discard leftover bits from current byte (assumes s->bitcnt < 8) */
;    s->bitbuf = 0;
	lda	#$0
	ldy	#$18
	sta	[<L14+s_0],Y
;    s->bitcnt = 0;
	iny
	iny
	sta	[<L14+s_0],Y
;
;    /* get length and check against its one's complement */
;    if (s->incnt + 4 > s->inlen)
;        return 2;                               /* not enough input */
	clc
	lda	#$4
	ldy	#$14
	adc	[<L14+s_0],Y
	sta	<R0
	lda	#$0
	iny
	iny
	adc	[<L14+s_0],Y
	sta	<R0+2
	ldy	#$10
	lda	[<L14+s_0],Y
	cmp	<R0
	iny
	iny
	lda	[<L14+s_0],Y
	sbc	<R0+2
	bcs	L10004
L20002:
	lda	#$2
L17:
	tay
	lda	<L14+2
	sta	<L14+2+4
	lda	<L14+1
	sta	<L14+1+4
	pld
	tsc
	clc
	adc	#L14+4
	tcs
	tya
	rtl
;    len = s->in[s->incnt++];
L10004:
	ldy	#$14
	lda	[<L14+s_0],Y
	sta	<R0
	iny
	iny
	lda	[<L14+s_0],Y
	sta	<R0+2
	clc
	ldy	#$c
	lda	[<L14+s_0],Y
	adc	<R0
	sta	<R1
	iny
	iny
	lda	[<L14+s_0],Y
	adc	<R0+2
	sta	<R1+2
	lda	[<R1]
	and	#$ff
	sta	<L15+len_1
	clc
	lda	#$1
	ldy	#$14
	adc	[<L14+s_0],Y
	sta	[<L14+s_0],Y
	lda	#$0
	iny
	iny
	adc	[<L14+s_0],Y
	sta	[<L14+s_0],Y
;    len |= s->in[s->incnt++] << 8;
	dey
	dey
	lda	[<L14+s_0],Y
	sta	<R1
	iny
	iny
	lda	[<L14+s_0],Y
	sta	<R1+2
	clc
	ldy	#$c
	lda	[<L14+s_0],Y
	adc	<R1
	sta	<R2
	iny
	iny
	lda	[<L14+s_0],Y
	adc	<R1+2
	sta	<R2+2
	lda	[<R2]
	and	#$ff
	xba
	and	#$ff00
	tsb	<L15+len_1
	clc
	lda	#$1
	ldy	#$14
	adc	[<L14+s_0],Y
	sta	[<L14+s_0],Y
	lda	#$0
	iny
	iny
	adc	[<L14+s_0],Y
	sta	[<L14+s_0],Y
;    if (s->in[s->incnt++] != (~len & 0xff) ||
;        s->in[s->incnt++] != ((~len >> 8) & 0xff))
;        return -2;                              /* didn't match complement! */
	lda	<L15+len_1
	eor	#<$ffffffff
	and	#<$ff
	sta	<R0
	dey
	dey
	lda	[<L14+s_0],Y
	sta	<R1
	iny
	iny
	lda	[<L14+s_0],Y
	sta	<R1+2
	clc
	lda	#$1
	dey
	dey
	adc	[<L14+s_0],Y
	sta	[<L14+s_0],Y
	lda	#$0
	iny
	iny
	adc	[<L14+s_0],Y
	sta	[<L14+s_0],Y
	clc
	ldy	#$c
	lda	[<L14+s_0],Y
	adc	<R1
	sta	<R2
	iny
	iny
	lda	[<L14+s_0],Y
	adc	<R1+2
	sta	<R2+2
	lda	[<R2]
	and	#$ff
	cmp	<R0
	bne	L18
	lda	<L15+len_1
	eor	#<$ffffffff
	xba
	and	#$00ff
	and	#<$ff
	sta	<R0
	ldy	#$14
	lda	[<L14+s_0],Y
	sta	<R1
	iny
	iny
	lda	[<L14+s_0],Y
	sta	<R1+2
	clc
	lda	#$1
	dey
	dey
	adc	[<L14+s_0],Y
	sta	[<L14+s_0],Y
	lda	#$0
	iny
	iny
	adc	[<L14+s_0],Y
	sta	[<L14+s_0],Y
	clc
	ldy	#$c
	lda	[<L14+s_0],Y
	adc	<R1
	sta	<R2
	iny
	iny
	lda	[<L14+s_0],Y
	adc	<R1+2
	sta	<R2+2
	lda	[<R2]
	and	#$ff
	cmp	<R0
	beq	L10005
L18:
	lda	#$fffe
	brl	L17
;
;    /* copy len bytes from in to out */
;    if (s->incnt + len > s->inlen)
L10005:
;        return 2;                               /* not enough input */
	lda	<L15+len_1
	sta	<R0
	stz	<R0+2
	clc
	lda	<R0
	ldy	#$14
	adc	[<L14+s_0],Y
	sta	<R1
	lda	<R0+2
	iny
	iny
	adc	[<L14+s_0],Y
	sta	<R1+2
	ldy	#$10
	lda	[<L14+s_0],Y
	cmp	<R1
	iny
	iny
	lda	[<L14+s_0],Y
	sbc	<R1+2
	bcs	*+5
	brl	L20002
;    if (s->out != NIL) {
	lda	[<L14+s_0]
	ldy	#$2
	ora	[<L14+s_0],Y
	bne	*+5
	brl	L10007
;        if (s->outcnt + len > s->outlen)
;            return 1;                           /* not enough output space */
	lda	<L15+len_1
	sta	<R0
	stz	<R0+2
	clc
	lda	<R0
	ldy	#$8
	adc	[<L14+s_0],Y
	sta	<R1
	lda	<R0+2
	iny
	iny
	adc	[<L14+s_0],Y
	sta	<R1+2
	ldy	#$4
	lda	[<L14+s_0],Y
	cmp	<R1
	iny
	iny
	lda	[<L14+s_0],Y
	sbc	<R1+2
	bcs	L10009
	lda	#$1
	brl	L17
;        while (len--)
L10009:
	lda	<L15+len_1
	sta	<R0
	dec	<L15+len_1
	lda	<R0
	bne	*+5
	brl	L10011
;            s->out[s->outcnt++] = s->in[s->incnt++];
	ldy	#$8
	lda	[<L14+s_0],Y
	sta	<R0
	iny
	iny
	lda	[<L14+s_0],Y
	sta	<R0+2
	lda	[<L14+s_0]
	clc
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	[<L14+s_0],Y
	adc	<R0+2
	sta	<R1+2
	ldy	#$14
	lda	[<L14+s_0],Y
	sta	<R0
	iny
	iny
	lda	[<L14+s_0],Y
	sta	<R0+2
	clc
	ldy	#$c
	lda	[<L14+s_0],Y
	adc	<R0
	sta	<R2
	iny
	iny
	lda	[<L14+s_0],Y
	adc	<R0+2
	sta	<R2+2
	sep	#$20
	longa	off
	lda	[<R2]
	sta	[<R1]
	rep	#$20
	longa	on
	clc
	lda	#$1
	ldy	#$14
	adc	[<L14+s_0],Y
	sta	[<L14+s_0],Y
	lda	#$0
	iny
	iny
	adc	[<L14+s_0],Y
	sta	[<L14+s_0],Y
	clc
	lda	#$1
	ldy	#$8
	adc	[<L14+s_0],Y
	sta	[<L14+s_0],Y
	lda	#$0
	iny
	iny
	adc	[<L14+s_0],Y
	sta	[<L14+s_0],Y
	bra	L10009
;    }
;    else {                                      /* just scanning */
L10007:
;        s->outcnt += len;
	lda	#$8
	clc
	adc	<L14+s_0
	sta	<R0
	lda	#$0
	adc	<L14+s_0+2
	sta	<R0+2
	lda	<L15+len_1
	sta	<R1
	stz	<R1+2
	lda	<R1
	clc
	adc	[<R0]
	sta	[<R0]
	lda	<R1+2
	ldy	#$2
	adc	[<R0],Y
	sta	[<R0],Y
;        s->incnt += len;
	lda	#$14
	clc
	adc	<L14+s_0
	sta	<R0
	lda	#$0
	adc	<L14+s_0+2
	sta	<R0+2
	lda	<L15+len_1
	sta	<R1
	stz	<R1+2
	lda	<R1
	clc
	adc	[<R0]
	sta	[<R0]
	lda	<R1+2
	adc	[<R0],Y
	sta	[<R0],Y
;    }
L10011:
;
;    /* done with a valid stored block */
;    return 0;
	lda	#$0
	brl	L17
;}
L14	equ	14
L15	equ	13
	ends
	efunc
	data
L5:
	db	$73,$74,$6F,$72,$65,$64,$0A,$00
	ends
;
;/*
; * Huffman code decoding tables.  count[1..MAXBITS] is the number of symbols of
; * each length, which for a canonical code are stepped through in order.
; * symbol[] are the symbol values in canonical order, where the number of
; * entries is the sum of the counts in count[].  The decoding process can be
; * seen in the function decode() below.
; */
;struct huffman {
;    short *count;       /* number of symbols of each length */
;    short *symbol;      /* canonically ordered symbols */
;};
;
;/*
; * Decode a code from the stream s using huffman table h.  Return the symbol or
; * a negative value if there is an error.  If all of the lengths are zero, i.e.
; * an empty code, or if the code is incomplete and an invalid code is received,
; * then -10 is returned after reading MAXBITS bits.
; *
; * Format notes:
; *
; * - The codes as stored in the compressed data are bit-reversed relative to
; *   a simple integer ordering of codes of the same lengths.  Hence below the
; *   bits are pulled from the compressed data one at a time and used to
; *   build the code value reversed from what is in the stream in order to
; *   permit simple integer comparisons for decoding.  A table-based decoding
; *   scheme (as used in zlib) does not need to do this reversal.
; *
; * - The first code for the shortest length is all zeros.  Subsequent codes of
; *   the same length are simply integer increments of the previous code.  When
; *   moving up a length, a zero bit is appended to the code.  For a complete
; *   code, the last code of the longest length will be all ones.
; *
; * - Incomplete codes are handled by this decoder, since they are permitted
; *   in the deflate format.  See the format notes for fixed() and dynamic().
; */
;#ifdef SLOW
;local int decode(struct state *s, const struct huffman *h)
;{
	code
	func
~~decode:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L26
	tcs
	phd
	tcd
s_0	set	4
h_0	set	8
;    int len;            /* current number of bits in code */
;    int code;           /* len bits being decoded */
;    int first;          /* first code of length len */
;    int count;          /* number of codes of length len */
;    int index;          /* index of first code of length len in symbol table */
;
;    code = first = index = 0;
len_1	set	0
code_1	set	2
first_1	set	4
count_1	set	6
index_1	set	8
	stz	<L27+index_1
	stz	<L27+first_1
	stz	<L27+code_1
;    for (len = 1; len <= MAXBITS; len++) {
	lda	#$1
	sta	<L27+len_1
L10014:
;        code |= bits(s, 1);             /* get next bit */
	pea	#<$1
	pei	<L26+s_0+2
	pei	<L26+s_0
	jsl	~~bits
	tsb	<L27+code_1
;		//debugf("code: %02x ", (long)code);
;        count = h->count[len];
	ldy	#$0
	lda	<L27+len_1
	bpl	L28
	dey
L28:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	lda	[<L26+h_0]
	clc
	adc	<R0
	sta	<R2
	ldy	#$2
	lda	[<L26+h_0],Y
	adc	<R0+2
	sta	<R2+2
	lda	[<R2]
	sta	<L27+count_1
;        if (code - count < first) {      /* if length len, return symbol */
	sec
	lda	<L27+code_1
	sbc	<L27+count_1
	sec
	sbc	<L27+first_1
	bvs	L29
	eor	#$8000
L29:
	bmi	L10015
;			//debugf("c:%02x ", (long)code);
;            return h->symbol[index + (code - first)];
	sec
	lda	<L27+code_1
	sbc	<L27+first_1
	clc
	adc	<L27+index_1
	sta	<R2
	ldy	#$0
	lda	<R2
	bpl	L31
	dey
L31:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	ldy	#$4
	lda	[<L26+h_0],Y
	adc	<R0
	sta	<R2
	iny
	iny
	lda	[<L26+h_0],Y
	adc	<R0+2
	sta	<R2+2
	lda	[<R2]
L32:
	tay
	lda	<L26+2
	sta	<L26+2+8
	lda	<L26+1
	sta	<L26+1+8
	pld
	tsc
	clc
	adc	#L26+8
	tcs
	tya
	rtl
;		}
;        index += count;                 /* else update for next length */
L10015:
	lda	<L27+index_1
	clc
	adc	<L27+count_1
	sta	<L27+index_1
;        first += count;
	lda	<L27+first_1
	clc
	adc	<L27+count_1
	sta	<L27+first_1
;        first <<= 1;
	asl	<L27+first_1
;        code <<= 1;
	asl	<L27+code_1
;    }
	inc	<L27+len_1
	sec
	lda	#$f
	sbc	<L27+len_1
	bvs	L33
	eor	#$8000
L33:
	bpl	*+5
	brl	L10014
;    return -10;                         /* ran out of codes */
	lda	#$fff6
	bra	L32
;}
L26	equ	22
L27	equ	13
	ends
	efunc
;
;/*
; * A faster version of decode() for real applications of this code.   It's not
; * as readable, but it makes puff() twice as fast.  And it only makes the code
; * a few percent larger.
; */
;#else /* !SLOW */
;local int decode(struct state *s, const struct huffman *h)
;{
;    int len;            /* current number of bits in code */
;    int code;           /* len bits being decoded */
;    int first;          /* first code of length len */
;    int count;          /* number of codes of length len */
;    int index;          /* index of first code of length len in symbol table */
;    int bitbuf;         /* bits from stream */
;    int left;           /* bits left in next or left to process */
;    short *next;        /* next number of codes */
;
;    bitbuf = s->bitbuf;
;    left = s->bitcnt;
;    code = first = index = 0;
;    len = 1;
;    next = h->count + 1;
;    while (1) {
;        while (left--) {
;            code |= bitbuf & 1;
;            bitbuf >>= 1;
;            count = *next++;
;            if (code - count < first) { /* if length len, return symbol */
;                s->bitbuf = bitbuf;
;                s->bitcnt = (s->bitcnt - len) & 7;
;                return h->symbol[index + (code - first)];
;            }
;            index += count;             /* else update for next length */
;            first += count;
;            first <<= 1;
;            code <<= 1;
;            len++;
;        }
;        left = (MAXBITS+1) - len;
;        if (left == 0)
;            break;
;        if (s->incnt == s->inlen)
;            longjmp(s->env, 1);         /* out of input */
;        bitbuf = s->in[s->incnt++];
;		
;        if (left > 8)
;            left = 8;
;    }
;    return -10;                         /* ran out of codes */
;}
;#endif /* SLOW */
;
;/*
; * Given the list of code lengths length[0..n-1] representing a canonical
; * Huffman code for n symbols, construct the tables required to decode those
; * codes.  Those tables are the number of codes of each length, and the symbols
; * sorted by length, retaining their original order within each length.  The
; * return value is zero for a complete code set, negative for an over-
; * subscribed code set, and positive for an incomplete code set.  The tables
; * can be used if the return value is zero or positive, but they cannot be used
; * if the return value is negative.  If the return value is zero, it is not
; * possible for decode() using that table to return an error--any stream of
; * enough bits will resolve to a symbol.  If the return value is positive, then
; * it is possible for decode() using that table to return an error for received
; * codes past the end of the incomplete lengths.
; *
; * Not used by decode(), but used for error checking, h->count[0] is the number
; * of the n symbols not in the code.  So n - h->count[0] is the number of
; * codes.  This is useful for checking for incomplete codes that have more than
; * one symbol, which is an error in a dynamic block.
; *
; * Assumption: for all i in 0..n-1, 0 <= length[i] <= MAXBITS
; * This is assured by the construction of the length arrays in dynamic() and
; * fixed() and is not verified by construct().
; *
; * Format notes:
; *
; * - Permitted and expected examples of incomplete codes are one of the fixed
; *   codes and any code with a single symbol which in deflate is coded as one
; *   bit instead of zero bits.  See the format notes for fixed() and dynamic().
; *
; * - Within a given code length, the symbols are kept in ascending order for
; *   the code bits definition.
; */
;local int construct(struct huffman *h, const short *length, int n)
;{
	code
	func
~~construct:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L35
	tcs
	phd
	tcd
h_0	set	4
length_0	set	8
n_0	set	12
;    int symbol;         /* current symbol when stepping through length[] */
;    int len;            /* current length when stepping through h->count[] */
;    int left;           /* number of possible codes left of current length */
;    short offs[MAXBITS+1];      /* offsets in symbol table for each length */
;
;    /* count number of codes of each length */
;    for (len = 0; len <= MAXBITS; len++)
symbol_1	set	0
len_1	set	2
left_1	set	4
offs_1	set	6
	stz	<L36+len_1
L10018:
;        h->count[len] = 0;
	ldy	#$0
	lda	<L36+len_1
	bpl	L37
	dey
L37:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	lda	[<L35+h_0]
	clc
	adc	<R0
	sta	<R2
	ldy	#$2
	lda	[<L35+h_0],Y
	adc	<R0+2
	sta	<R2+2
	lda	#$0
	sta	[<R2]
	inc	<L36+len_1
	sec
	lda	#$f
	sbc	<L36+len_1
	bvs	L38
	eor	#$8000
L38:
	bmi	L10018
;    for (symbol = 0; symbol < n; symbol++)
	stz	<L36+symbol_1
	bra	L10022
L10021:
;        (h->count[length[symbol]])++;   /* assumes lengths are within bounds */
	ldy	#$0
	lda	<L36+symbol_1
	bpl	L40
	dey
L40:
	sta	<R2
	sty	<R2+2
	pei	<R2+2
	pei	<R2
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R1
	stx	<R1+2
	lda	<L35+length_0
	clc
	adc	<R1
	sta	<R3
	lda	<L35+length_0+2
	adc	<R1+2
	sta	<R3+2
	ldy	#$0
	lda	[<R3]
	bpl	L41
	dey
L41:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	lda	[<L35+h_0]
	clc
	adc	<R0
	sta	<R3
	ldy	#$2
	lda	[<L35+h_0],Y
	adc	<R0+2
	sta	<R3+2
	lda	[<R3]
	ina
	sta	[<R3]
	inc	<L36+symbol_1
L10022:
	sec
	lda	<L36+symbol_1
	sbc	<L35+n_0
	bvs	L42
	eor	#$8000
L42:
	bpl	L10021
;    if (h->count[0] == n)               /* no codes! */
;        return 0;                       /* complete, but decode() will fail */
	lda	[<L35+h_0]
	sta	<R0
	ldy	#$2
	lda	[<L35+h_0],Y
	sta	<R0+2
	lda	[<R0]
	cmp	<L35+n_0
	bne	L10023
	lda	#$0
L45:
	tay
	lda	<L35+2
	sta	<L35+2+10
	lda	<L35+1
	sta	<L35+1+10
	pld
	tsc
	clc
	adc	#L35+10
	tcs
	tya
	rtl
;	
;    /* check for an over-subscribed or incomplete set of lengths */
;    left = 1;                           /* one possible code of zero length */
L10023:
	lda	#$1
	sta	<L36+left_1
;    for (len = 1; len <= MAXBITS; len++) {
	sta	<L36+len_1
L10026:
;        left <<= 1;                     /* one more bit, double codes left */
	asl	<L36+left_1
;        left -= h->count[len];          /* deduct count from possible codes */
	ldy	#$0
	lda	<L36+len_1
	bpl	L46
	dey
L46:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	lda	[<L35+h_0]
	clc
	adc	<R0
	sta	<R2
	ldy	#$2
	lda	[<L35+h_0],Y
	adc	<R0+2
	sta	<R2+2
	sec
	lda	<L36+left_1
	sbc	[<R2]
	sta	<L36+left_1
;        if (left < 0)
;            return left;                /* over-subscribed--return negative */
	lda	<L36+left_1
	bpl	L10024
L20003:
	lda	<L36+left_1
	bra	L45
;    }                                   /* left > 0 means incomplete */
L10024:
	inc	<L36+len_1
	sec
	lda	#$f
	sbc	<L36+len_1
	bvs	L48
	eor	#$8000
L48:
	bmi	L10026
;
;    /* generate offsets into symbol table for each length for sorting */
;/*	
;	debugf("counts:\n");
;	for (len = 0; len <= MAXBITS; len++) {
;		debugf("%02X ", (long)h->count[len]);
;	}	
;	debugf("\n");
;*/
;	
;    offs[1] = 0;
	stz	<L36+offs_1+2
;    for (len = 1; len < MAXBITS; len++) {
	lda	#$1
	sta	<L36+len_1
L10030:
;        offs[len + 1] = offs[len] + h->count[len];
	lda	<L36+len_1
	ina
	sta	<R1
	ldy	#$0
	lda	<R1
	bpl	L50
	dey
L50:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	tdc
	adc	#<L36+offs_1
	sta	<R2
	lda	#$0
	sta	<R2+2
	lda	<R2
	clc
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	ldy	#$0
	lda	<L36+len_1
	bpl	L51
	dey
L51:
	sta	<R2
	sty	<R2+2
	pei	<R2+2
	pei	<R2
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	lda	[<L35+h_0]
	clc
	adc	<R0
	sta	<17
	ldy	#$2
	lda	[<L35+h_0],Y
	adc	<R0+2
	sta	<17+2
	dey
	dey
	lda	<L36+len_1
	bpl	L52
	dey
L52:
	sta	<21
	sty	<21+2
	pei	<21+2
	pei	<21
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	tdc
	adc	#<L36+offs_1
	sta	<25
	lda	#$0
	sta	<25+2
	lda	<25
	clc
	adc	<R0
	sta	<29
	lda	<25+2
	adc	<R0+2
	sta	<29+2
	lda	[<29]
	clc
	adc	[<17]
	sta	[<R3]
;	}
	inc	<L36+len_1
	sec
	lda	<L36+len_1
	sbc	#<$f
	bvs	L53
	eor	#$8000
L53:
	bmi	*+5
	brl	L10030
;
;/*
;	debugf("offsets:\n");
;    for (len = 1; len <= MAXBITS; len++) {
;		debugf("%02X ", (long)offs[len]);
;	}
;	debugf("\n");
;*/	
;    /*
;     * put symbols in table sorted by length, by symbol order within each
;     * length
;     */
;    for (symbol = 0; symbol < n; symbol++)
	stz	<L36+symbol_1
	brl	L10034
L10033:
;        if (length[symbol] != 0)
;            h->symbol[offs[length[symbol]]++] = symbol;
	ldy	#$0
	lda	<L36+symbol_1
	bpl	L55
	dey
L55:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	lda	<L35+length_0
	clc
	adc	<R0
	sta	<R2
	lda	<L35+length_0+2
	adc	<R0+2
	sta	<R2+2
	lda	[<R2]
	bne	*+5
	brl	L10031
	ldy	#$0
	lda	<L36+symbol_1
	bpl	L57
	dey
L57:
	sta	<R3
	sty	<R3+2
	pei	<R3+2
	pei	<R3
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R2
	stx	<R2+2
	lda	<L35+length_0
	clc
	adc	<R2
	sta	<17
	lda	<L35+length_0+2
	adc	<R2+2
	sta	<17+2
	ldy	#$0
	lda	[<17]
	bpl	L58
	dey
L58:
	sta	<R2
	sty	<R2+2
	pei	<R2+2
	pei	<R2
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R1
	stx	<R1+2
	clc
	tdc
	adc	#<L36+offs_1
	sta	<17
	lda	#$0
	sta	<17+2
	lda	<17
	clc
	adc	<R1
	sta	<21
	lda	<17+2
	adc	<R1+2
	sta	<21+2
	ldy	#$0
	lda	[<21]
	bpl	L59
	dey
L59:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	ldy	#$4
	lda	[<L35+h_0],Y
	adc	<R0
	sta	<17
	iny
	iny
	lda	[<L35+h_0],Y
	adc	<R0+2
	sta	<17+2
	lda	<L36+symbol_1
	sta	[<17]
	ldy	#$0
	lda	<L36+symbol_1
	bpl	L60
	dey
L60:
	sta	<25
	sty	<25+2
	pei	<25+2
	pei	<25
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<21
	stx	<21+2
	lda	<L35+length_0
	clc
	adc	<21
	sta	<29
	lda	<L35+length_0+2
	adc	<21+2
	sta	<29+2
	ldy	#$0
	lda	[<29]
	bpl	L61
	dey
L61:
	sta	<21
	sty	<21+2
	pei	<21+2
	pei	<21
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	clc
	tdc
	adc	#<L36+offs_1
	sta	<29
	lda	#$0
	sta	<29+2
	lda	<29
	clc
	adc	<R0
	sta	<33
	lda	<29+2
	adc	<R0+2
	sta	<33+2
	lda	[<33]
	ina
	sta	[<33]
;	
;	
;	//debugf("tree:\n");
;    //for (symbol = 0; symbol < n; symbol++) {
;	//	debugf("%d ", (unsigned long)h->symbol[symbol]);		
;	//}
;	//debugf("\n");
;	
;
;    /* return zero for complete set, positive for incomplete set */
;    return left;
L10031:
	inc	<L36+symbol_1
L10034:
	sec
	lda	<L36+symbol_1
	sbc	<L35+n_0
	bvs	L62
	eor	#$8000
L62:
	bmi	*+5
	brl	L10033
	brl	L20003
;}
L35	equ	74
L36	equ	37
	ends
	efunc
;
;/*
; * Decode literal/length and distance codes until an end-of-block code.
; *
; * Format notes:
; *
; * - Compressed data that is after the block type if fixed or after the code
; *   description if dynamic is a combination of literals and length/distance
; *   pairs terminated by and end-of-block code.  Literals are simply Huffman
; *   coded bytes.  A length/distance pair is a coded length followed by a
; *   coded distance to represent a string that occurs earlier in the
; *   uncompressed data that occurs again at the current location.
; *
; * - Literals, lengths, and the end-of-block code are combined into a single
; *   code of up to 286 symbols.  They are 256 literals (0..255), 29 length
; *   symbols (257..285), and the end-of-block symbol (256).
; *
; * - There are 256 possible lengths (3..258), and so 29 symbols are not enough
; *   to represent all of those.  Lengths 3..10 and 258 are in fact represented
; *   by just a length symbol.  Lengths 11..257 are represented as a symbol and
; *   some number of extra bits that are added as an integer to the base length
; *   of the length symbol.  The number of extra bits is determined by the base
; *   length symbol.  These are in the static arrays below, lens[] for the base
; *   lengths and lext[] for the corresponding number of extra bits.
; *
; * - The reason that 258 gets its own symbol is that the longest length is used
; *   often in highly redundant files.  Note that 258 can also be coded as the
; *   base value 227 plus the maximum extra value of 31.  While a good deflate
; *   should never do this, it is not an error, and should be decoded properly.
; *
; * - If a length is decoded, including its extra bits if any, then it is
; *   followed a distance code.  There are up to 30 distance symbols.  Again
; *   there are many more possible distances (1..32768), so extra bits are added
; *   to a base value represented by the symbol.  The distances 1..4 get their
; *   own symbol, but the rest require extra bits.  The base distances and
; *   corresponding number of extra bits are below in the static arrays dist[]
; *   and dext[].
; *
; * - Literal bytes are simply written to the output.  A length/distance pair is
; *   an instruction to copy previously uncompressed bytes to the output.  The
; *   copy is from distance bytes back in the output stream, copying for length
; *   bytes.
; *
; * - Distances pointing before the beginning of the output data are not
; *   permitted.
; *
; * - Overlapped copies, where the length is greater than the distance, are
; *   allowed and common.  For example, a distance of one and a length of 258
; *   simply copies the last byte 258 times.  A distance of four and a length of
; *   twelve copies the last four bytes three times.  A simple forward copy
; *   ignoring whether the length is greater than the distance or not implements
; *   this correctly.  You should not use memcpy() since its behavior is not
; *   defined for overlapped arrays.  You should not use memmove() or bcopy()
; *   since though their behavior -is- defined for overlapping arrays, it is
; *   defined to do the wrong thing in this case.
; */
;local int codes(struct state *s,
;                const struct huffman *lencode,
;                const struct huffman *distcode)
;{
	code
	func
~~codes:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L64
	tcs
	phd
	tcd
s_0	set	4
lencode_0	set	8
distcode_0	set	12
;	int i;
;    int symbol;         /* decoded symbol */
;    int len;            /* length for copy */
;    unsigned dist;      /* distance for copy */
;    static const short lens[29] = { /* Size base for length codes 257..285 */
;    static const short lext[29] = { /* Extra bits for length codes 257..285 */
;    static const short dists[30] = { /* Offset base for distance codes 0..29 */
;    static const short dext[30] = { /* Extra bits for distance codes 0..29 */
;
;	
;    /* decode literals and length/distance pairs */
;   i = 0;
i_1	set	0
symbol_1	set	2
len_1	set	4
dist_1	set	6
	stz	<L65+i_1
;   //debugf("codes():\n");
;   
;   do {
L10038:
;		
;        symbol = decode(s, lencode);
	pei	<L64+lencode_0+2
	pei	<L64+lencode_0
	pei	<L64+s_0+2
	pei	<L64+s_0
	jsl	~~decode
	sta	<L65+symbol_1
;		/*
;		if (i < 256) {
;			debugf("%02X ", (unsigned long)symbol);
;			i++;
;		}*/
;		
;        if (symbol < 0)
;            return symbol;              /* invalid symbol */
	lda	<L65+symbol_1
	bpl	L10039
L20004:
	lda	<L65+symbol_1
L71:
	tay
	lda	<L64+2
	sta	<L64+2+12
	lda	<L64+1
	sta	<L64+1+12
	pld
	tsc
	clc
	adc	#L64+12
	tcs
	tya
	rtl
;        if (symbol < 256) {             /* literal: symbol is the byte */
L10039:
	sec
	lda	<L65+symbol_1
	sbc	#<$100
	bvs	L72
	eor	#$8000
L72:
	bmi	L10040
;            /* write out the literal */
;            if (s->out != NIL) {
	lda	[<L64+s_0]
	ldy	#$2
	ora	[<L64+s_0],Y
	beq	L10041
;                if (s->outcnt == s->outlen)
;                    return 1;
	ldy	#$8
	lda	[<L64+s_0],Y
	ldy	#$4
	cmp	[<L64+s_0],Y
	bne	L75
	ldy	#$a
	lda	[<L64+s_0],Y
	ldy	#$6
	cmp	[<L64+s_0],Y
L75:
	bne	L10042
L20005:
	lda	#$1
	bra	L71
;                s->out[s->outcnt] = symbol;
L10042:
	ldy	#$8
	lda	[<L64+s_0],Y
	sta	<R0
	iny
	iny
	lda	[<L64+s_0],Y
	sta	<R0+2
	lda	[<L64+s_0]
	clc
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	[<L64+s_0],Y
	adc	<R0+2
	sta	<R1+2
	sep	#$20
	longa	off
	lda	<L65+symbol_1
	sta	[<R1]
	rep	#$20
	longa	on
;            }
;            s->outcnt++;
L10041:
	clc
	lda	#$1
	ldy	#$8
	adc	[<L64+s_0],Y
	sta	[<L64+s_0],Y
	lda	#$0
	iny
	iny
	adc	[<L64+s_0],Y
	sta	[<L64+s_0],Y
;        }
;        else if (symbol > 256) {        /* length */
	brl	L10036
L10040:
	sec
	lda	#$100
	sbc	<L65+symbol_1
	bvs	L77
	eor	#$8000
L77:
	bpl	*+5
	brl	L10036
;            /* get and compute length */
;            symbol -= 257;
	lda	#$feff
	clc
	adc	<L65+symbol_1
	sta	<L65+symbol_1
;            if (symbol >= 29)
;                return -10;             /* invalid fixed code */
	sec
	sbc	#<$1d
	bvs	L79
	eor	#$8000
L79:
	bpl	L10045
	lda	#$fff6
	brl	L71
;            len = lens[symbol] + bits(s, lext[symbol]);
L10045:
	lda	<L65+symbol_1
	asl	A
	sta	<R0
	lda	<L65+symbol_1
	asl	A
	tax
	lda	|L67,X ;lext
	pha
	pei	<L64+s_0+2
	pei	<L64+s_0
	jsl	~~bits
	clc
	ldx	<R0
	adc	|L66,X ;lens
	sta	<L65+len_1
;
;            /* get and check distance */
;            symbol = decode(s, distcode);
	pei	<L64+distcode_0+2
	pei	<L64+distcode_0
	pei	<L64+s_0+2
	pei	<L64+s_0
	jsl	~~decode
	sta	<L65+symbol_1
;            if (symbol < 0)
;                return symbol;          /* invalid symbol */
	lda	<L65+symbol_1
	bpl	*+5
	brl	L20004
;            dist = dists[symbol] + bits(s, dext[symbol]);
	lda	<L65+symbol_1
	asl	A
	sta	<R0
	lda	<L65+symbol_1
	asl	A
	tax
	lda	|L69,X ;dext
	pha
	pei	<L64+s_0+2
	pei	<L64+s_0
	jsl	~~bits
	clc
	ldx	<R0
	adc	|L68,X ;dists
	sta	<L65+dist_1
;#ifndef INFLATE_ALLOW_INVALID_DISTANCE_TOOFAR_ARRR
;            if (dist > s->outcnt)
;                return -11;     /* distance too far back */
	sta	<R0
	stz	<R0+2
	ldy	#$8
	lda	[<L64+s_0],Y
	cmp	<R0
	iny
	iny
	lda	[<L64+s_0],Y
	sbc	<R0+2
	bcs	L10047
	lda	#$fff5
	brl	L71
;#endif
;
;            /* copy length bytes from distance bytes back */
;            if (s->out != NIL) {
L10047:
	lda	[<L64+s_0]
	ldy	#$2
	ora	[<L64+s_0],Y
	bne	*+5
	brl	L10048
;                if (s->outcnt + len > s->outlen)
;                    return 1;
	dey
	dey
	lda	<L65+len_1
	bpl	L84
	dey
L84:
	sta	<R0
	sty	<R0+2
	clc
	lda	<R0
	ldy	#$8
	adc	[<L64+s_0],Y
	sta	<R1
	lda	<R0+2
	iny
	iny
	adc	[<L64+s_0],Y
	sta	<R1+2
	ldy	#$4
	lda	[<L64+s_0],Y
	cmp	<R1
	iny
	iny
	lda	[<L64+s_0],Y
	sbc	<R1+2
	bcs	*+5
	brl	L20005
;                while (len--) {
L10050:
	lda	<L65+len_1
	sta	<R0
	dec	<L65+len_1
	lda	<R0
	bne	*+5
	brl	L10036
;                    s->out[s->outcnt] =
;#ifdef INFLATE_ALLOW_INVALID_DISTANCE_TOOFAR_ARRR
;                        dist > s->outcnt ?
;                            0 :
;#endif
;                            s->out[s->outcnt - dist];
	ldy	#$8
	lda	[<L64+s_0],Y
	sta	<R0
	iny
	iny
	lda	[<L64+s_0],Y
	sta	<R0+2
	lda	[<L64+s_0]
	clc
	adc	<R0
	sta	<R1
	ldy	#$2
	lda	[<L64+s_0],Y
	adc	<R0+2
	sta	<R1+2
	lda	<L65+dist_1
	sta	<R0
	stz	<R0+2
	sec
	ldy	#$8
	lda	[<L64+s_0],Y
	sbc	<R0
	sta	<R2
	iny
	iny
	lda	[<L64+s_0],Y
	sbc	<R0+2
	sta	<R2+2
	lda	[<L64+s_0]
	clc
	adc	<R2
	sta	<R0
	ldy	#$2
	lda	[<L64+s_0],Y
	adc	<R2+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	sta	[<R1]
	rep	#$20
	longa	on
;                    s->outcnt++;
	clc
	lda	#$1
	ldy	#$8
	adc	[<L64+s_0],Y
	sta	[<L64+s_0],Y
	lda	#$0
	iny
	iny
	adc	[<L64+s_0],Y
	sta	[<L64+s_0],Y
;                }
	bra	L10050
;            }
;            else
L10048:
;                s->outcnt += len;
	lda	#$8
	clc
	adc	<L64+s_0
	sta	<R0
	lda	#$0
	adc	<L64+s_0+2
	sta	<R0+2
	ldy	#$0
	lda	<L65+len_1
	bpl	L87
	dey
L87:
	sta	<R1
	sty	<R1+2
	lda	<R1
	clc
	adc	[<R0]
	sta	[<R0]
	lda	<R1+2
	ldy	#$2
	adc	[<R0],Y
	sta	[<R0],Y
;        }
;    } while (symbol != 256);            /* end of block symbol */
L10036:
	lda	<L65+symbol_1
	cmp	#<$100
	beq	*+5
	brl	L10038
;	
;	//debugf("\n");
;    /* done with a valid fixed or dynamic block */
;    return 0;
	lda	#$0
	brl	L71
;}
L64	equ	20
L65	equ	13
	ends
	efunc
	data
L66:
;        3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 15, 17, 19, 23, 27, 31,
	dw	$3,$4,$5,$6,$7,$8,$9,$A,$B,$D
	dw	$F,$11,$13,$17,$1B,$1F
;        35, 43, 51, 59, 67, 83, 99, 115, 131, 163, 195, 227, 258};
	dw	$23,$2B,$33,$3B,$43,$53,$63,$73,$83,$A3
	dw	$C3,$E3,$102
	ends
	data
L67:
;        0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2,
	dw	$0,$0,$0,$0,$0,$0,$0,$0,$1,$1
	dw	$1,$1,$2,$2,$2,$2
;        3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 0};
	dw	$3,$3,$3,$3,$4,$4,$4,$4,$5,$5
	dw	$5,$5,$0
	ends
	data
L68:
;        1, 2, 3, 4, 5, 7, 9, 13, 17, 25, 33, 49, 65, 97, 129, 193,
	dw	$1,$2,$3,$4,$5,$7,$9,$D,$11,$19
	dw	$21,$31,$41,$61,$81,$C1
;        257, 385, 513, 769, 1025, 1537, 2049, 3073, 4097, 6145,
	dw	$101,$181,$201,$301,$401,$601,$801,$C01,$1001,$1801
;        8193, 12289, 16385, 24577};
	dw	$2001,$3001,$4001,$6001
	ends
	data
L69:
;        0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6,
	dw	$0,$0,$0,$0,$1,$1,$2,$2,$3,$3
	dw	$4,$4,$5,$5,$6,$6
;        7, 7, 8, 8, 9, 9, 10, 10, 11, 11,
	dw	$7,$7,$8,$8,$9,$9,$A,$A,$B,$B
;        12, 12, 13, 13};
	dw	$C,$C,$D,$D
	ends
;
;/*
; * Process a fixed codes block.
; *
; * Format notes:
; *
; * - This block type can be useful for compressing small amounts of data for
; *   which the size of the code descriptions in a dynamic block exceeds the
; *   benefit of custom codes for that block.  For fixed codes, no bits are
; *   spent on code descriptions.  Instead the code lengths for literal/length
; *   codes and distance codes are fixed.  The specific lengths for each symbol
; *   can be seen in the "for" loops below.
; *
; * - The literal/length code is complete, but has two symbols that are invalid
; *   and should result in an error if received.  This cannot be implemented
; *   simply as an incomplete code since those two symbols are in the "middle"
; *   of the code.  They are eight bits long and the longest literal/length\
; *   code is nine bits.  Therefore the code must be constructed with those
; *   symbols, and the invalid symbols must be detected after decoding.
; *
; * - The fixed distance codes also have two invalid symbols that should result
; *   in an error if received.  Since all of the distance codes are the same
; *   length, this can be implemented as an incomplete code.  Then the invalid
; *   codes are detected while decoding.
; */
;local int fixed(struct state *s)
;{
	code
	func
~~fixed:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L89
	tcs
	phd
	tcd
s_0	set	4
;    static int virgin = 1;
;    static short lencnt[MAXBITS+1], lensym[FIXLCODES];
;    static short distcnt[MAXBITS+1], distsym[MAXDCODES];
;    static struct huffman lencode, distcode;
;	int symbol;
;	short *lengths;
;
;	printf("fixed virgin: %d\n", virgin);
symbol_1	set	0
lengths_1	set	2
	lda	|L91
	pha
	pea	#^L25
	pea	#<L25
	pea	#8
	jsl	~~printf
;    /* build fixed huffman tables if first call (may not be thread safe) */
;    if (virgin) {
	lda	|L91
	bne	*+5
	brl	L10059
;        //int symbol;
;        //short lengths[FIXLCODES];
;		lengths = malloc(FIXLCODES * sizeof(short));
	pea	#^$240
	pea	#<$240
	jsl	~~malloc
	sta	<L90+lengths_1
	stx	<L90+lengths_1+2
;
;        /* construct lencode and distcode */
;        lencode.count = lencnt;
	lda	#<L10053
	sta	|L10057
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	|L10057+2
;        lencode.symbol = lensym;
	lda	#<L10054
	sta	|L10057+4
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	|L10057+4+2
;        distcode.count = distcnt;
	lda	#<L10055
	sta	|L10058
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	|L10058+2
;        distcode.symbol = distsym;
	lda	#<L10056
	sta	|L10058+4
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	|L10058+4+2
;
;        /* literal/length table */
;        for (symbol = 0; symbol < 144; symbol++)
	stz	<L90+symbol_1
L10062:
;            lengths[symbol] = 8;
	ldy	#$0
	lda	<L90+symbol_1
	bpl	L93
	dey
L93:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	lda	<L90+lengths_1
	clc
	adc	<R0
	sta	<R2
	lda	<L90+lengths_1+2
	adc	<R0+2
	sta	<R2+2
	lda	#$8
	sta	[<R2]
	inc	<L90+symbol_1
	sec
	lda	<L90+symbol_1
	sbc	#<$90
	bvs	L94
	eor	#$8000
L94:
	bmi	L10066
	bra	L10062
;        for (; symbol < 256; symbol++)
L10065:
;            lengths[symbol] = 9;
	ldy	#$0
	lda	<L90+symbol_1
	bpl	L96
	dey
L96:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	lda	<L90+lengths_1
	clc
	adc	<R0
	sta	<R2
	lda	<L90+lengths_1+2
	adc	<R0+2
	sta	<R2+2
	lda	#$9
	sta	[<R2]
	inc	<L90+symbol_1
L10066:
	sec
	lda	<L90+symbol_1
	sbc	#<$100
	bvs	L97
	eor	#$8000
L97:
	bmi	L10070
	bra	L10065
;        for (; symbol < 280; symbol++)
L10069:
;            lengths[symbol] = 7;
	ldy	#$0
	lda	<L90+symbol_1
	bpl	L99
	dey
L99:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	lda	<L90+lengths_1
	clc
	adc	<R0
	sta	<R2
	lda	<L90+lengths_1+2
	adc	<R0+2
	sta	<R2+2
	lda	#$7
	sta	[<R2]
	inc	<L90+symbol_1
L10070:
	sec
	lda	<L90+symbol_1
	sbc	#<$118
	bvs	L100
	eor	#$8000
L100:
	bmi	L10074
	bra	L10069
;        for (; symbol < FIXLCODES; symbol++)
L10073:
;            lengths[symbol] = 8;
	ldy	#$0
	lda	<L90+symbol_1
	bpl	L102
	dey
L102:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	lda	<L90+lengths_1
	clc
	adc	<R0
	sta	<R2
	lda	<L90+lengths_1+2
	adc	<R0+2
	sta	<R2+2
	lda	#$8
	sta	[<R2]
	inc	<L90+symbol_1
L10074:
	sec
	lda	<L90+symbol_1
	sbc	#<$120
	bvs	L103
	eor	#$8000
L103:
	bpl	L10073
;        construct(&lencode, lengths, FIXLCODES);
	pea	#<$120
	pei	<L90+lengths_1+2
	pei	<L90+lengths_1
	lda	#<L10057
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	jsl	~~construct
;
;        /* distance table */
;        for (symbol = 0; symbol < MAXDCODES; symbol++)
	stz	<L90+symbol_1
L10077:
;            lengths[symbol] = 5;
	ldy	#$0
	lda	<L90+symbol_1
	bpl	L105
	dey
L105:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	lda	<L90+lengths_1
	clc
	adc	<R0
	sta	<R2
	lda	<L90+lengths_1+2
	adc	<R0+2
	sta	<R2+2
	lda	#$5
	sta	[<R2]
	inc	<L90+symbol_1
	sec
	lda	<L90+symbol_1
	sbc	#<$1e
	bvs	L106
	eor	#$8000
L106:
	bpl	L10077
;        construct(&distcode, lengths, MAXDCODES);
	pea	#<$1e
	pei	<L90+lengths_1+2
	pei	<L90+lengths_1
	lda	#<L10058
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	jsl	~~construct
;
;        /* do this just once */
;        virgin = 0;
	stz	|L91
;		free(lengths);
	pei	<L90+lengths_1+2
	pei	<L90+lengths_1
	jsl	~~free
;    }
;
;    /* decode data until end-of-block code */
;    return codes(s, &lencode, &distcode);
L10059:
	lda	#<L10058
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	lda	#<L10057
	sta	<R1
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R1
	pei	<L89+s_0+2
	pei	<L89+s_0
	jsl	~~codes
	tay
	lda	<L89+2
	sta	<L89+2+4
	lda	<L89+1
	sta	<L89+1+4
	pld
	tsc
	clc
	adc	#L89+4
	tcs
	tya
	rtl
;}
L89	equ	18
L90	equ	13
	ends
	efunc
	data
L91:
	dw	$1
	ends
	udata
L10053:
	ds	32
	ends
	udata
L10054:
	ds	576
	ends
	udata
L10055:
	ds	32
	ends
	udata
L10056:
	ds	60
	ends
	udata
L10057:
	ds	8
	ends
	udata
L10058:
	ds	8
	ends
	data
L25:
	db	$66,$69,$78,$65,$64,$20,$76,$69,$72,$67,$69,$6E,$3A,$20,$25
	db	$64,$0A,$00
	ends
;
;/*
; * Process a dynamic codes block.
; *
; * Format notes:
; *
; * - A dynamic block starts with a description of the literal/length and
; *   distance codes for that block.  New dynamic blocks allow the compressor to
; *   rapidly adapt to changing data with new codes optimized for that data.
; *
; * - The codes used by the deflate format are "canonical", which means that
; *   the actual bits of the codes are generated in an unambiguous way simply
; *   from the number of bits in each code.  Therefore the code descriptions
; *   are simply a list of code lengths for each symbol.
; *
; * - The code lengths are stored in order for the symbols, so lengths are
; *   provided for each of the literal/length symbols, and for each of the
; *   distance symbols.
; *
; * - If a symbol is not used in the block, this is represented by a zero as
; *   as the code length.  This does not mean a zero-length code, but rather
; *   that no code should be created for this symbol.  There is no way in the
; *   deflate format to represent a zero-length code.
; *
; * - The maximum number of bits in a code is 15, so the possible lengths for
; *   any code are 1..15.
; *
; * - The fact that a length of zero is not permitted for a code has an
; *   interesting consequence.  Normally if only one symbol is used for a given
; *   code, then in fact that code could be represented with zero bits.  However
; *   in deflate, that code has to be at least one bit.  So for example, if
; *   only a single distance base symbol appears in a block, then it will be
; *   represented by a single code of length one, in particular one 0 bit.  This
; *   is an incomplete code, since if a 1 bit is received, it has no meaning,
; *   and should result in an error.  So incomplete distance codes of one symbol
; *   should be permitted, and the receipt of invalid codes should be handled.
; *
; * - It is also possible to have a single literal/length code, but that code
; *   must be the end-of-block code, since every dynamic block has one.  This
; *   is not the most efficient way to create an empty block (an empty fixed
; *   block is fewer bits), but it is allowed by the format.  So incomplete
; *   literal/length codes of one symbol should also be permitted.
; *
; * - If there are only literal codes and no lengths, then there are no distance
; *   codes.  This is represented by one distance code with zero bits.
; *
; * - The list of up to 286 length/literal lengths and up to 30 distance lengths
; *   are themselves compressed using Huffman codes and run-length encoding.  In
; *   the list of code lengths, a 0 symbol means no code, a 1..15 symbol means
; *   that length, and the symbols 16, 17, and 18 are run-length instructions.
; *   Each of 16, 17, and 18 are follwed by extra bits to define the length of
; *   the run.  16 copies the last length 3 to 6 times.  17 represents 3 to 10
; *   zero lengths, and 18 represents 11 to 138 zero lengths.  Unused symbols
; *   are common, hence the special coding for zero lengths.
; *
; * - The symbols for 0..18 are Huffman coded, and so that code must be
; *   described first.  This is simply a sequence of up to 19 three-bit values
; *   representing no code (0) or the code length for that symbol (1..7).
; *
; * - A dynamic block starts with three fixed-size counts from which is computed
; *   the number of literal/length code lengths, the number of distance code
; *   lengths, and the number of code length code lengths (ok, you come up with
; *   a better name!) in the code descriptions.  For the literal/length and
; *   distance codes, lengths after those provided are considered zero, i.e. no
; *   code.  The code length code lengths are received in a permuted order (see
; *   the order[] array below) to make a short code length code length list more
; *   likely.  As it turns out, very short and very long codes are less likely
; *   to be seen in a dynamic code description, hence what may appear initially
; *   to be a peculiar ordering.
; *
; * - Given the number of literal/length code lengths (nlen) and distance code
; *   lengths (ndist), then they are treated as one long list of nlen + ndist
; *   code lengths.  Therefore run-length coding can and often does cross the
; *   boundary between the two sets of lengths.
; *
; * - So to summarize, the code description at the start of a dynamic block is
; *   three counts for the number of code lengths for the literal/length codes,
; *   the distance codes, and the code length codes.  This is followed by the
; *   code length code lengths, three bits each.  This is used to construct the
; *   code length code which is used to read the remainder of the lengths.  Then
; *   the literal/length code lengths and distance lengths are read as a single
; *   set of lengths using the code length codes.  Codes are constructed from
; *   the resulting two sets of lengths, and then finally you can start
; *   decoding actual compressed data in the block.
; *
; * - For reference, a "typical" size for the code description in a dynamic
; *   block is around 80 bytes.
; */
;
;local int dynamic(struct state *s)
;{
	code
	func
~~dynamic:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L110
	tcs
	phd
	tcd
s_0	set	4
;    int nlen, ndist, ncode;             /* number of lengths in descriptor */
;    int index;                          /* index of lengths[] */
;    int err, rc;                        /* construct() return value */
;    short *lengths;//[MAXCODES];        /* descriptor code lengths */
;    short lencnt[MAXBITS+1], *lensym;   //lensym[MAXLCODES];         /* lencode memory */
;    short distcnt[MAXBITS+1], *distsym; //distsym[MAXDCODES];       /* distcode memory */
;    struct huffman lencode, distcode;   /* length and distance codes */
;    static const short order[19] =      /* permutation of code length codes */
;	int len, symbol;
;	
;	//printf("dynamic length short: %d\n", sizeof(short));
;	
;	/* for (index = 0; index < 19; index ++) {
;		printf("order %d:%d\n", index, order[index]);
;	}*/
;	
;	lengths	= malloc(MAXCODES * sizeof(short));
nlen_1	set	0
ndist_1	set	2
ncode_1	set	4
index_1	set	6
err_1	set	8
rc_1	set	10
lengths_1	set	12
lencnt_1	set	16
lensym_1	set	48
distcnt_1	set	52
distsym_1	set	84
lencode_1	set	88
distcode_1	set	96
len_1	set	104
symbol_1	set	106
	pea	#^$278
	pea	#<$278
	jsl	~~malloc
	sta	<L111+lengths_1
	stx	<L111+lengths_1+2
;	lensym = malloc(MAXLCODES * sizeof(short));
	pea	#^$23c
	pea	#<$23c
	jsl	~~malloc
	sta	<L111+lensym_1
	stx	<L111+lensym_1+2
;	distsym = malloc(MAXDCODES * sizeof(short));
	pea	#^$3c
	pea	#<$3c
	jsl	~~malloc
	sta	<L111+distsym_1
	stx	<L111+distsym_1+2
;	
;    /* construct lencode and distcode */
;    lencode.count = lencnt;
	clc
	tdc
	adc	#<L111+lencnt_1
	sta	<L111+lencode_1
	lda	#$0
	sta	<L111+lencode_1+2
;    lencode.symbol = lensym;
	lda	<L111+lensym_1
	sta	<L111+lencode_1+4
	lda	<L111+lensym_1+2
	sta	<L111+lencode_1+6
;    distcode.count = distcnt;
	clc
	tdc
	adc	#<L111+distcnt_1
	sta	<L111+distcode_1
	lda	#$0
	sta	<L111+distcode_1+2
;    distcode.symbol = distsym;
	lda	<L111+distsym_1
	sta	<L111+distcode_1+4
	lda	<L111+distsym_1+2
	sta	<L111+distcode_1+6
;
;    /* get number of lengths in each table, check lengths */
;    nlen = bits(s, 5) + 257;
	pea	#<$5
	pei	<L110+s_0+2
	pei	<L110+s_0
	jsl	~~bits
	clc
	adc	#$101
	sta	<L111+nlen_1
;    ndist = bits(s, 5) + 1;
	pea	#<$5
	pei	<L110+s_0+2
	pei	<L110+s_0
	jsl	~~bits
	ina
	sta	<L111+ndist_1
;    ncode = bits(s, 4) + 4;
	pea	#<$4
	pei	<L110+s_0+2
	pei	<L110+s_0
	jsl	~~bits
	clc
	adc	#$4
	sta	<L111+ncode_1
;	
;	printf("nlen %d, ndist %d, ncode: %d\n", nlen, ndist, ncode);
	pha
	pei	<L111+ndist_1
	pei	<L111+nlen_1
	pea	#^L109
	pea	#<L109
	pea	#12
	jsl	~~printf
;	
;    if (nlen > MAXLCODES || ndist > MAXDCODES) {
	sec
	lda	#$11e
	sbc	<L111+nlen_1
	bvs	L114
	eor	#$8000
L114:
	bpl	L113
	sec
	lda	#$1e
	sbc	<L111+ndist_1
	bvs	L116
	eor	#$8000
L116:
	bmi	L10078
L113:
;        rc = -3;                      /* bad counts */
	lda	#$fffd
	brl	L20006
;		goto dynamic_exit;
;	}
;	
;    /* read code length code lengths (really), missing lengths are zero */
;    for (index = 0; index < ncode; index++) {
L10078:
	stz	<L111+index_1
	bra	L10083
L10082:
;        lengths[order[index]] = bits(s, 3);
	lda	<L111+index_1
	asl	A
	sta	<R1
	ldy	#$0
	ldx	<R1
	lda	|L112,X ;order
	bpl	L118
	dey
L118:
	sta	<R2
	sty	<R2+2
	pei	<R2+2
	pei	<R2
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	lda	<L111+lengths_1
	clc
	adc	<R0
	sta	<R3
	lda	<L111+lengths_1+2
	adc	<R0+2
	sta	<R3+2
	pea	#<$3
	pei	<L110+s_0+2
	pei	<L110+s_0
	jsl	~~bits
	sta	[<R3]
;		//printf("%02X\n", lengths[order[index]]);
;	}
	inc	<L111+index_1
L10083:
	sec
	lda	<L111+index_1
	sbc	<L111+ncode_1
	bvs	L119
	eor	#$8000
L119:
	bmi	L10087
	bra	L10082
;	
;    for (; index < 19; index++)
L10086:
;        lengths[order[index]] = 0;
	lda	<L111+index_1
	asl	A
	sta	<R1
	ldy	#$0
	ldx	<R1
	lda	|L112,X ;order
	bpl	L121
	dey
L121:
	sta	<R2
	sty	<R2+2
	pei	<R2+2
	pei	<R2
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	lda	<L111+lengths_1
	clc
	adc	<R0
	sta	<R3
	lda	<L111+lengths_1+2
	adc	<R0+2
	sta	<R3+2
	lda	#$0
	sta	[<R3]
	inc	<L111+index_1
L10087:
	sec
	lda	<L111+index_1
	sbc	#<$13
	bvs	L122
	eor	#$8000
L122:
	bpl	L10086
;
;	//debugf("length codes\n");
;	//for (index = 0; index < 19; index++) {
;	//	debugf("%02X ", (long)lengths[index]);
;	//}
;	//debugf("\n");
;	
;    /* build huffman table for code lengths codes (use lencode temporarily) */
;    err = construct(&lencode, lengths, 19);
	pea	#<$13
	pei	<L111+lengths_1+2
	pei	<L111+lengths_1
	pea	#0
	clc
	tdc
	adc	#<L111+lencode_1
	pha
	jsl	~~construct
	sta	<L111+err_1
;    if (err != 0) {               /* require complete code set here */
	lda	<L111+err_1
	beq	L10088
;        rc = -4;
	lda	#$fffc
	brl	L20006
;		goto dynamic_exit;
;	}
;
;    /* read length/literal and distance code length tables */
;    index = 0;
L10088:
	stz	<L111+index_1
;	
;	//debugf("read length/literal and distance code length tables\n");
;	
;    while (index < nlen + ndist) {
;    }
L10089:
	lda	<L111+nlen_1
	clc
	adc	<L111+ndist_1
	sta	<R0
	sec
	lda	<L111+index_1
	sbc	<R0
	bvs	L125
	eor	#$8000
L125:
	bpl	L20008
;	//debugf("\n");
;
;	
;	//debugf("length:\n");
;	//for(index = 0; index < nlen + ndist; index++) {
;	//	debugf("%02X ", (unsigned long)lengths[index]);
;	//}
;	//debugf("\n");
;	
;
;    /* check for end-of-block code -- there better be one! */
;    if (lengths[256] == 0) {
	ldy	#$200
	lda	[<L111+lengths_1],Y
	beq	*+5
	brl	L10101
;        rc = -9;
	lda	#$fff7
	brl	L20006
L20008:
;        //int symbol;             /* decoded value */
;        //int len;                /* last length to repeat */
;
;        symbol = decode(s, &lencode);
	pea	#0
	clc
	tdc
	adc	#<L111+lencode_1
	pha
	pei	<L110+s_0+2
	pei	<L110+s_0
	jsl	~~decode
	sta	<L111+symbol_1
;		//debugf("%02X ", (unsigned long)symbol);
;		
;        if (symbol < 16)                /* length in 0..15 */
;            lengths[index++] = symbol;
	sec
	sbc	#<$10
	bvs	L127
	eor	#$8000
L127:
	bmi	L10091
	ldy	#$0
	lda	<L111+index_1
	bpl	L129
	dey
L129:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	lda	<L111+lengths_1
	clc
	adc	<R0
	sta	<R2
	lda	<L111+lengths_1+2
	adc	<R0+2
	sta	<R2+2
	lda	<L111+symbol_1
	sta	[<R2]
	inc	<L111+index_1
;        else {                          /* repeat instruction */
	bra	L10089
L10091:
;            len = 0;                    /* assume repeating zeros */
	stz	<L111+len_1
;            if (symbol == 16) {         /* repeat last length 3..6 times */
	lda	<L111+symbol_1
	cmp	#<$10
	bne	L10093
;                if (index == 0) {
	lda	<L111+index_1
	bne	L10094
;                    rc = -5;          /* no last length! */
	lda	#$fffb
	brl	L20006
;					goto dynamic_exit;
;				}
;                len = lengths[index - 1];       /* last length */
L10094:
	lda	#$ffff
	clc
	adc	<L111+index_1
	sta	<R1
	ldy	#$0
	lda	<R1
	bpl	L132
	dey
L132:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	lda	<L111+lengths_1
	clc
	adc	<R0
	sta	<R2
	lda	<L111+lengths_1+2
	adc	<R0+2
	sta	<R2+2
	lda	[<R2]
	sta	<L111+len_1
;                symbol = 3 + bits(s, 2);
	pea	#<$2
	bra	L20015
L20017:
	pea	#<$3
L20015:
	pei	<L110+s_0+2
	pei	<L110+s_0
	jsl	~~bits
	sta	<R0
	clc
	lda	#$3
	bra	L20009
;            }
;            else if (symbol == 17)      /* repeat zero 3..10 times */
L10093:
;                symbol = 3 + bits(s, 3);
	lda	<L111+symbol_1
	cmp	#<$11
	beq	L20017
;            else                        /* == 18, repeat zero 11..138 times */
;                symbol = 11 + bits(s, 7);
	pea	#<$7
	pei	<L110+s_0+2
	pei	<L110+s_0
	jsl	~~bits
	sta	<R0
	clc
	lda	#$b
L20009:
	adc	<R0
	sta	<L111+symbol_1
;            if (index + symbol > nlen + ndist) {
	lda	<L111+nlen_1
	clc
	adc	<L111+ndist_1
	sta	<R0
	lda	<L111+index_1
	clc
	adc	<L111+symbol_1
	sta	<R1
	sec
	lda	<R0
	sbc	<R1
	bvs	L134
	eor	#$8000
L134:
	bmi	L10099
;                rc = -6;              /* too many lengths! */
	lda	#$fffa
	brl	L20006
;				goto dynamic_exit;
;			}
;            while (symbol--)            /* repeat last or zero symbol times */
L10099:
	lda	<L111+symbol_1
	sta	<R0
	dec	<L111+symbol_1
	lda	<R0
	bne	*+5
	brl	L10089
;                lengths[index++] = len;
	ldy	#$0
	lda	<L111+index_1
	bpl	L137
	dey
L137:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	lda	<L111+lengths_1
	clc
	adc	<R0
	sta	<R2
	lda	<L111+lengths_1+2
	adc	<R0+2
	sta	<R2+2
	lda	<L111+len_1
	sta	[<R2]
	inc	<L111+index_1
	bra	L10099
;        }
;		goto dynamic_exit;
;	}
;	
;	
;    /* build huffman table for literal/length codes */
;    err = construct(&lencode, lengths, nlen);
L10101:
	pei	<L111+nlen_1
	pei	<L111+lengths_1+2
	pei	<L111+lengths_1
	pea	#0
	clc
	tdc
	adc	#<L111+lencode_1
	pha
	jsl	~~construct
	sta	<L111+err_1
;    if (err && (err < 0 || nlen != lencode.count[0] + lencode.count[1])) {
	lda	<L111+err_1
	beq	L10102
	lda	<L111+err_1
	bmi	L140
	clc
	lda	[<L111+lencode_1]
	ldy	#$2
	adc	[<L111+lencode_1],Y
	cmp	<L111+nlen_1
	beq	L10102
L140:
;        rc = -7;      /* incomplete code ok only for single length 1 code */
	lda	#$fff9
	bra	L20006
;		goto dynamic_exit;
;	}	
;
;	/*
;	debugf("sym/len tree:\n");
;	for(index = 0; index < nlen; index++) {
;		debugf("%X ", (unsigned long)lencode.symbol[index]);
;	}
;	debugf("\n\n"); */
;	
;    /* build huffman table for distance codes */
;    err = construct(&distcode, lengths + nlen, ndist);
L10102:
	pei	<L111+ndist_1
	ldy	#$0
	lda	<L111+nlen_1
	bpl	L143
	dey
L143:
	sta	<R1
	sty	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	lda	<L111+lengths_1
	clc
	adc	<R0
	sta	<R2
	lda	<L111+lengths_1+2
	adc	<R0+2
	pha
	pei	<R2
	pea	#0
	clc
	tdc
	adc	#<L111+distcode_1
	pha
	jsl	~~construct
	sta	<L111+err_1
;    if (err && (err < 0 || ndist != distcode.count[0] + distcode.count[1])) {
	lda	<L111+err_1
	beq	L10103
	lda	<L111+err_1
	bmi	L145
	clc
	lda	[<L111+distcode_1]
	ldy	#$2
	adc	[<L111+distcode_1],Y
	cmp	<L111+ndist_1
	beq	L10103
L145:
;        rc = -8;      /* incomplete code ok only for single length 1 code */
	lda	#$fff8
	bra	L20006
;		goto dynamic_exit;
;	}
;	
;	/*
;	debugf("distance tree:\n");
;	for(index = 0; index < ndist; index++) {
;		debugf("%X ", (unsigned long)distcode.symbol[index]);
;	}
;	debugf("\n\n");*/
;
;    /* decode data until end-of-block code */
;    rc = codes(s, &lencode, &distcode);
L10103:
	pea	#0
	clc
	tdc
	adc	#<L111+distcode_1
	pha
	pea	#0
	clc
	tdc
	adc	#<L111+lencode_1
	pha
	pei	<L110+s_0+2
	pei	<L110+s_0
	jsl	~~codes
L20006:
	sta	<L111+rc_1
;	
;dynamic_exit:
;	free(lengths);
	pei	<L111+lengths_1+2
	pei	<L111+lengths_1
	jsl	~~free
;	free(lensym); 
	pei	<L111+lensym_1+2
	pei	<L111+lensym_1
	jsl	~~free
;	free(distsym);
	pei	<L111+distsym_1+2
	pei	<L111+distsym_1
	jsl	~~free
;
;	return rc;
	lda	<L111+rc_1
	tay
	lda	<L110+2
	sta	<L110+2+4
	lda	<L110+1
	sta	<L110+1+4
	pld
	tsc
	clc
	adc	#L110+4
	tcs
	tya
	rtl
;}
L110	equ	124
L111	equ	17
	ends
	efunc
	data
L112:
;        {16, 17, 18, 0, 8, 7, 9, 6, 10, 5, 11, 4, 12, 3, 13, 2, 14, 1, 15};
	dw	$10,$11,$12,$0,$8,$7,$9,$6,$A,$5
	dw	$B,$4,$C,$3,$D,$2,$E,$1,$F
	ends
	data
L109:
	db	$6E,$6C,$65,$6E,$20,$25,$64,$2C,$20,$6E,$64,$69,$73,$74,$20
	db	$25,$64,$2C,$20,$6E,$63,$6F,$64,$65,$3A,$20,$25,$64,$0A,$00
	ends
;
;/*
; * Inflate source to dest.  On return, destlen and sourcelen are updated to the
; * size of the uncompressed data and the size of the deflate data respectively.
; * On success, the return value of puff() is zero.  If there is an error in the
; * source data, i.e. it is not in the deflate format, then a negative value is
; * returned.  If there is not enough input available or there is not enough
; * output space, then a positive error is returned.  In that case, destlen and
; * sourcelen are not updated to facilitate retrying from the beginning with the
; * provision of more input data or more output space.  In the case of invalid
; * inflate data (a negative error), the dest and source pointers are updated to
; * facilitate the debugging of deflators.
; *
; * puff() also has a mode to determine the size of the uncompressed output with
; * no output written.  For this dest must be (unsigned char *)0.  In this case,
; * the input value of *destlen is ignored, and on return *destlen is set to the
; * size of the uncompressed output.
; *
; * The return codes are:
; *
; *   2:  available inflate data did not terminate
; *   1:  output space exhausted before completing inflate
; *   0:  successful inflate
; *  -1:  invalid block type (type == 3)
; *  -2:  stored block length did not match one's complement
; *  -3:  dynamic block code description: too many length or distance codes
; *  -4:  dynamic block code description: code lengths codes incomplete
; *  -5:  dynamic block code description: repeat lengths with no first length
; *  -6:  dynamic block code description: repeat more than specified lengths
; *  -7:  dynamic block code description: invalid literal/length code lengths
; *  -8:  dynamic block code description: invalid distance code lengths
; *  -9:  dynamic block code description: missing end-of-block code
; * -10:  invalid literal/length or distance code in fixed or dynamic block
; * -11:  distance is too far back in fixed or dynamic block
; *
; * Format notes:
; *
; * - Three bits are read for each block to determine the kind of block and
; *   whether or not it is the last block.  Then the block is decoded and the
; *   process repeated if it was not the last block.
; *
; * - The leftover bits in the last byte of the deflate data after the last
; *   block (if it was a fixed or dynamic block) are undefined and have no
; *   expected values to check.
; */
;int puff(unsigned char *dest,           /* pointer to destination pointer */
;         unsigned long *destlen,        /* amount of output space */
;         const unsigned char *source,   /* pointer to source data pointer */
;         unsigned long *sourcelen)      /* amount of input available */
;{
	code
	xdef	~~puff
	func
~~puff:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L150
	tcs
	phd
	tcd
dest_0	set	4
destlen_0	set	8
source_0	set	12
sourcelen_0	set	16
;    struct state s;             /* input/output state */
;    int last, type;             /* block information */
;    int err;                    /* return value */
;
;    /* initialize output state */
;    s.out = dest;
s_1	set	0
last_1	set	182
type_1	set	184
err_1	set	186
	lda	<L150+dest_0
	sta	<L151+s_1
	lda	<L150+dest_0+2
	sta	<L151+s_1+2
;    s.outlen = *destlen;                /* ignored if dest is NIL */
	lda	[<L150+destlen_0]
	sta	<L151+s_1+4
	ldy	#$2
	lda	[<L150+destlen_0],Y
	sta	<L151+s_1+6
;    s.outcnt = 0;
	stz	<L151+s_1+8
	stz	<L151+s_1+10
;
;    /* initialize input state */
;    s.in = source;
	lda	<L150+source_0
	sta	<L151+s_1+12
	lda	<L150+source_0+2
	sta	<L151+s_1+14
;    s.inlen = *sourcelen;
	lda	[<L150+sourcelen_0]
	sta	<L151+s_1+16
	lda	[<L150+sourcelen_0],Y
	sta	<L151+s_1+18
;    s.incnt = 0;
	stz	<L151+s_1+20
	stz	<L151+s_1+22
;    s.bitbuf = 0;
	stz	<L151+s_1+24
;    s.bitcnt = 0;
	stz	<L151+s_1+26
;	
;    /* return if bits() or decode() tries to read past available input */
;    if (0 /*setjmp(s.env) != 0*/)             /* if came back here via longjmp() */
;        err = 2;                        /* then skip do-loop, return error */
;    else {
;        /* process blocks until last block or error */
;        do {
;			//printf("do\n");
;            last = bits(&s, 1);         /* one if last block */
	pea	#<$1
	pea	#0
	clc
	tdc
	adc	#<L151+s_1
	pha
	jsl	~~bits
	sta	<L151+last_1
;            type = bits(&s, 2);         /* block type 0..3 */
	pea	#<$2
	pea	#0
	clc
	tdc
	adc	#<L151+s_1
	pha
	jsl	~~bits
	sta	<L151+type_1
;			printf("block type %d\n", type);
	pha
	pea	#^L149
	pea	#<L149
	pea	#8
	jsl	~~printf
;			
;            err = type == 0 ?
;                    stored(&s) :
;                    (type == 1 ?
;                        fixed(&s) :
;                        (type == 2 ?
;                            dynamic(&s) :
;                            -1));       /* type == 3, invalid */
	lda	<L151+type_1
	bne	L152
	pea	#0
	clc
	tdc
	adc	#<L151+s_1
	pha
	jsl	~~stored
	bra	L154
L152:
	lda	<L151+type_1
	cmp	#<$1
	bne	L155
	pea	#0
	clc
	tdc
	adc	#<L151+s_1
	pha
	jsl	~~fixed
	bra	L154
L155:
	lda	<L151+type_1
	cmp	#<$2
	bne	L158
	pea	#0
	clc
	tdc
	adc	#<L151+s_1
	pha
	jsl	~~dynamic
	bra	L154
L158:
	lda	#$ffff
L154:
	sta	<L151+err_1
;            //if (err != 0)
;                break;                  /* return with error */
;        } while (!last);
;    }
;
;    /* update the lengths and return */
;    if (err <= 0) {
	sec
	lda	#$0
	sbc	<L151+err_1
	bvs	L162
	eor	#$8000
L162:
	bpl	L10109
;        *destlen = s.outcnt;
	lda	<L151+s_1+8
	sta	[<L150+destlen_0]
	lda	<L151+s_1+10
	ldy	#$2
	sta	[<L150+destlen_0],Y
;        *sourcelen = s.incnt;
	lda	<L151+s_1+20
	sta	[<L150+sourcelen_0]
	lda	<L151+s_1+22
	sta	[<L150+sourcelen_0],Y
;    }
;	
;    return err;
L10109:
	lda	<L151+err_1
	tay
	lda	<L150+2
	sta	<L150+2+16
	lda	<L150+1
	sta	<L150+1+16
	pld
	tsc
	clc
	adc	#L150+16
	tcs
	tya
	rtl
;}
L150	equ	188
L151	equ	1
	ends
	efunc
	data
L149:
	db	$62,$6C,$6F,$63,$6B,$20,$74,$79,$70,$65,$20,$25,$64,$0A,$00
	ends
;
	xref	~~free
	xref	~~malloc
	xref	~~printf
