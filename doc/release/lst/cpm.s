;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
;// This file uses the 8080 emulator to run the test suite (roms in cpu_tests
;// directory). It uses a simple array as memory.
;
;#include <stdio.h>
;#include <stdlib.h>
;#include <string.h>
;#include <time.h>
;
;#include "i8080.h"
;#include "homebrew.h"
;
;
;// memory callbacks
;#define MEMORY_SIZE 0x10000
;#define DISK_SIZE 256256
;
;static uint8_t* memory = NULL;
	data
~~memory:
	dl	$0
	ends
;static uint8_t* disk = NULL;
	data
~~disk:
	dl	$0
	ends
;static size_t disk_size;
;
;
;static bool test_finished = 0;
	data
~~test_finished:
	dw	$0
	ends
;static bool debug = 0;
	data
~~debug:
	dw	$0
	ends
;
;#include "i8080.c"
	code
	func
~~i8080_rb:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
c_0	set	4
addr_0	set	8
	pei	<L2+addr_0
	ldy	#$12
	lda	[<L2+c_0],Y
	pha
	dey
	dey
	lda	[<L2+c_0],Y
	pha
	ldy	#$2
	lda	[<L2+c_0],Y
	tax
	lda	[<L2+c_0]
	xref	~~~lcal
	jsl	~~~lcal
	sep	#$20
	longa	off
	sta	<R0
	rep	#$20
	longa	on
	lda	<R0
	and	#$ff
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
L3	equ	5
	ends
	efunc
	code
	func
~~i8080_wb:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L5
	tcs
	phd
	tcd
c_0	set	4
addr_0	set	8
val_0	set	10
	pei	<L5+val_0
	pei	<L5+addr_0
	ldy	#$12
	lda	[<L5+c_0],Y
	pha
	dey
	dey
	lda	[<L5+c_0],Y
	pha
	ldy	#$6
	lda	[<L5+c_0],Y
	tax
	dey
	dey
	lda	[<L5+c_0],Y
	xref	~~~lcal
	jsl	~~~lcal
	lda	<L5+2
	sta	<L5+2+8
	lda	<L5+1
	sta	<L5+1+8
	pld
	tsc
	clc
	adc	#L5+8
	tcs
	rtl
L5	equ	0
L6	equ	1
	ends
	efunc
	code
	func
~~i8080_rw:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L8
	tcs
	phd
	tcd
c_0	set	4
addr_0	set	8
	lda	<L8+addr_0
	ina
	pha
	ldy	#$12
	lda	[<L8+c_0],Y
	pha
	dey
	dey
	lda	[<L8+c_0],Y
	pha
	ldy	#$2
	lda	[<L8+c_0],Y
	tax
	lda	[<L8+c_0]
	xref	~~~lcal
	jsl	~~~lcal
	sep	#$20
	longa	off
	sta	<R1
	rep	#$20
	longa	on
	lda	<R1
	and	#$ff
	xba
	and	#$ff00
	sta	<R0
	pei	<L8+addr_0
	ldy	#$12
	lda	[<L8+c_0],Y
	pha
	dey
	dey
	lda	[<L8+c_0],Y
	pha
	ldy	#$2
	lda	[<L8+c_0],Y
	tax
	lda	[<L8+c_0]
	xref	~~~lcal
	jsl	~~~lcal
	sep	#$20
	longa	off
	sta	<R1
	rep	#$20
	longa	on
	lda	<R1
	and	#$ff
	ora	<R0
	tay
	lda	<L8+2
	sta	<L8+2+6
	lda	<L8+1
	sta	<L8+1+6
	pld
	tsc
	clc
	adc	#L8+6
	tcs
	tya
	rtl
L8	equ	8
L9	equ	9
	ends
	efunc
	code
	func
~~i8080_ww:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L11
	tcs
	phd
	tcd
c_0	set	4
addr_0	set	8
val_0	set	10
	lda	<L11+val_0
	and	#<$ff
	pha
	pei	<L11+addr_0
	ldy	#$12
	lda	[<L11+c_0],Y
	pha
	dey
	dey
	lda	[<L11+c_0],Y
	pha
	ldy	#$6
	lda	[<L11+c_0],Y
	tax
	dey
	dey
	lda	[<L11+c_0],Y
	xref	~~~lcal
	jsl	~~~lcal
	lda	<L11+val_0
	xba
	and	#$00ff
	pha
	lda	<L11+addr_0
	ina
	pha
	ldy	#$12
	lda	[<L11+c_0],Y
	pha
	dey
	dey
	lda	[<L11+c_0],Y
	pha
	ldy	#$6
	lda	[<L11+c_0],Y
	tax
	dey
	dey
	lda	[<L11+c_0],Y
	xref	~~~lcal
	jsl	~~~lcal
	lda	<L11+2
	sta	<L11+2+8
	lda	<L11+1
	sta	<L11+1+8
	pld
	tsc
	clc
	adc	#L11+8
	tcs
	rtl
L11	equ	0
L12	equ	1
	ends
	efunc
	code
	func
~~i8080_next_byte:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L14
	tcs
	phd
	tcd
c_0	set	4
	ldy	#$18
	lda	[<L14+c_0],Y
	sta	<R0
	lda	[<L14+c_0],Y
	ina
	sta	[<L14+c_0],Y
	pei	<R0
	pei	<L14+c_0+2
	pei	<L14+c_0
	jsl	~~i8080_rb
	sep	#$20
	longa	off
	sta	<R1
	rep	#$20
	longa	on
	lda	<R1
	and	#$ff
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
L14	equ	8
L15	equ	9
	ends
	efunc
	code
	func
~~i8080_next_word:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L17
	tcs
	phd
	tcd
c_0	set	4
result_1	set	0
	ldy	#$18
	lda	[<L17+c_0],Y
	pha
	pei	<L17+c_0+2
	pei	<L17+c_0
	jsl	~~i8080_rw
	sta	<L18+result_1
	lda	#$18
	clc
	adc	<L17+c_0
	sta	<R0
	lda	#$0
	adc	<L17+c_0+2
	sta	<R0+2
	lda	#$2
	clc
	adc	[<R0]
	sta	[<R0]
	lda	<L18+result_1
	tay
	lda	<L17+2
	sta	<L17+2+4
	lda	<L17+1
	sta	<L17+1+4
	pld
	tsc
	clc
	adc	#L17+4
	tcs
	tya
	rtl
L17	equ	6
L18	equ	5
	ends
	efunc
	code
	func
~~i8080_set_bc:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L20
	tcs
	phd
	tcd
c_0	set	4
val_0	set	8
	lda	<L20+val_0
	xba
	and	#$00ff
	sep	#$20
	longa	off
	ldy	#$1d
	sta	[<L20+c_0],Y
	rep	#$20
	longa	on
	lda	<L20+val_0
	and	#<$ff
	sep	#$20
	longa	off
	iny
	sta	[<L20+c_0],Y
	rep	#$20
	longa	on
	lda	<L20+2
	sta	<L20+2+6
	lda	<L20+1
	sta	<L20+1+6
	pld
	tsc
	clc
	adc	#L20+6
	tcs
	rtl
L20	equ	0
L21	equ	1
	ends
	efunc
	code
	func
~~i8080_set_de:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L23
	tcs
	phd
	tcd
c_0	set	4
val_0	set	8
	lda	<L23+val_0
	xba
	and	#$00ff
	sep	#$20
	longa	off
	ldy	#$1f
	sta	[<L23+c_0],Y
	rep	#$20
	longa	on
	lda	<L23+val_0
	and	#<$ff
	sep	#$20
	longa	off
	iny
	sta	[<L23+c_0],Y
	rep	#$20
	longa	on
	lda	<L23+2
	sta	<L23+2+6
	lda	<L23+1
	sta	<L23+1+6
	pld
	tsc
	clc
	adc	#L23+6
	tcs
	rtl
L23	equ	0
L24	equ	1
	ends
	efunc
	code
	func
~~i8080_set_hl:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L26
	tcs
	phd
	tcd
c_0	set	4
val_0	set	8
	lda	<L26+val_0
	xba
	and	#$00ff
	sep	#$20
	longa	off
	ldy	#$21
	sta	[<L26+c_0],Y
	rep	#$20
	longa	on
	lda	<L26+val_0
	and	#<$ff
	sep	#$20
	longa	off
	iny
	sta	[<L26+c_0],Y
	rep	#$20
	longa	on
	lda	<L26+2
	sta	<L26+2+6
	lda	<L26+1
	sta	<L26+1+6
	pld
	tsc
	clc
	adc	#L26+6
	tcs
	rtl
L26	equ	0
L27	equ	1
	ends
	efunc
	code
	func
~~i8080_get_bc:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L29
	tcs
	phd
	tcd
c_0	set	4
	ldy	#$1d
	lda	[<L29+c_0],Y
	and	#$ff
	xba
	and	#$ff00
	sta	<R0
	iny
	lda	[<L29+c_0],Y
	and	#$ff
	ora	<R0
	tay
	lda	<L29+2
	sta	<L29+2+4
	lda	<L29+1
	sta	<L29+1+4
	pld
	tsc
	clc
	adc	#L29+4
	tcs
	tya
	rtl
L29	equ	8
L30	equ	9
	ends
	efunc
	code
	func
~~i8080_get_de:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L32
	tcs
	phd
	tcd
c_0	set	4
	ldy	#$1f
	lda	[<L32+c_0],Y
	and	#$ff
	xba
	and	#$ff00
	sta	<R0
	iny
	lda	[<L32+c_0],Y
	and	#$ff
	ora	<R0
	tay
	lda	<L32+2
	sta	<L32+2+4
	lda	<L32+1
	sta	<L32+1+4
	pld
	tsc
	clc
	adc	#L32+4
	tcs
	tya
	rtl
L32	equ	8
L33	equ	9
	ends
	efunc
	code
	func
~~i8080_get_hl:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L35
	tcs
	phd
	tcd
c_0	set	4
	ldy	#$21
	lda	[<L35+c_0],Y
	and	#$ff
	xba
	and	#$ff00
	sta	<R0
	iny
	lda	[<L35+c_0],Y
	and	#$ff
	ora	<R0
	tay
	lda	<L35+2
	sta	<L35+2+4
	lda	<L35+1
	sta	<L35+1+4
	pld
	tsc
	clc
	adc	#L35+4
	tcs
	tya
	rtl
L35	equ	8
L36	equ	9
	ends
	efunc
	code
	func
~~i8080_push_stack:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L38
	tcs
	phd
	tcd
c_0	set	4
val_0	set	8
	lda	#$1a
	clc
	adc	<L38+c_0
	sta	<R0
	lda	#$0
	adc	<L38+c_0+2
	sta	<R0+2
	lda	#$fffe
	clc
	adc	[<R0]
	sta	[<R0]
	pei	<L38+val_0
	ldy	#$1a
	lda	[<L38+c_0],Y
	pha
	pei	<L38+c_0+2
	pei	<L38+c_0
	jsl	~~i8080_ww
	lda	<L38+2
	sta	<L38+2+6
	lda	<L38+1
	sta	<L38+1+6
	pld
	tsc
	clc
	adc	#L38+6
	tcs
	rtl
L38	equ	4
L39	equ	5
	ends
	efunc
	code
	func
~~i8080_pop_stack:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L41
	tcs
	phd
	tcd
c_0	set	4
val_1	set	0
	ldy	#$1a
	lda	[<L41+c_0],Y
	pha
	pei	<L41+c_0+2
	pei	<L41+c_0
	jsl	~~i8080_rw
	sta	<L42+val_1
	lda	#$1a
	clc
	adc	<L41+c_0
	sta	<R0
	lda	#$0
	adc	<L41+c_0+2
	sta	<R0+2
	lda	#$2
	clc
	adc	[<R0]
	sta	[<R0]
	lda	<L42+val_1
	tay
	lda	<L41+2
	sta	<L41+2+4
	lda	<L41+1
	sta	<L41+1+4
	pld
	tsc
	clc
	adc	#L41+4
	tcs
	tya
	rtl
L41	equ	6
L42	equ	5
	ends
	efunc
	code
	func
~~parity:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L44
	tcs
	phd
	tcd
val_0	set	4
i_1	set	0
nb_one_bits_1	set	2
	stz	<L45+nb_one_bits_1
	stz	<L45+i_1
	bra	L10004
L10003:
	lda	<L44+val_0
	and	#$ff
	ldx	<L45+i_1
	xref	~~~asr
	jsl	~~~asr
	and	#<$1
	clc
	adc	<L45+nb_one_bits_1
	sta	<L45+nb_one_bits_1
	inc	<L45+i_1
L10004:
	lda	<L45+i_1
	cmp	#<$8
	bcc	L10003
	stz	<R0
	lda	<L45+nb_one_bits_1
	and	#<$1
	bne	L47
	inc	<R0
L47:
	lda	<R0
	tay
	lda	<L44+2
	sta	<L44+2+2
	lda	<L44+1
	sta	<L44+1+2
	pld
	tsc
	clc
	adc	#L44+2
	tcs
	tya
	rtl
L44	equ	8
L45	equ	5
	ends
	efunc
	code
	func
~~carry:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L50
	tcs
	phd
	tcd
bit_no_0	set	4
a_0	set	6
b_0	set	8
cy_0	set	10
result_1	set	0
carry_1	set	2
	lda	<L50+b_0
	and	#$ff
	sta	<R0
	lda	<L50+a_0
	and	#$ff
	clc
	adc	<R0
	clc
	adc	<L50+cy_0
	sta	<L51+result_1
	lda	<L50+a_0
	and	#$ff
	sta	<R0
	lda	<L50+b_0
	and	#$ff
	eor	<R0
	sta	<R2
	lda	<L51+result_1
	eor	<R2
	sta	<L51+carry_1
	stz	<R0
	lda	#$1
	ldx	<L50+bit_no_0
	xref	~~~asl
	jsl	~~~asl
	sta	<R1
	lda	<L51+carry_1
	and	<R1
	beq	L52
	inc	<R0
L52:
	lda	<R0
	sta	<L51+carry_1
	tay
	lda	<L50+2
	sta	<L50+2+8
	lda	<L50+1
	sta	<L50+1+8
	pld
	tsc
	clc
	adc	#L50+8
	tcs
	tya
	rtl
L50	equ	16
L51	equ	13
	ends
	efunc
	code
	func
~~i8080_add:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L55
	tcs
	phd
	tcd
c_0	set	4
reg_0	set	8
val_0	set	12
cy_0	set	14
result_1	set	0
	lda	<L55+val_0
	and	#$ff
	sta	<R0
	lda	[<L55+reg_0]
	and	#$ff
	clc
	adc	<R0
	clc
	adc	<L55+cy_0
	sep	#$20
	longa	off
	sta	<L56+result_1
	rep	#$20
	longa	on
	pei	<L55+cy_0
	pei	<L55+val_0
	lda	[<L55+reg_0]
	pha
	pea	#<$8
	jsl	~~carry
	asl
	asl
	asl
	asl
	and	#<$10
	sta	<R0
	ldy	#$23
	lda	[<L55+c_0],Y
	and	#<$ffffffef
	ora	<R0
	sta	[<L55+c_0],Y
	pei	<L55+cy_0
	pei	<L55+val_0
	lda	[<L55+reg_0]
	pha
	pea	#<$4
	jsl	~~carry
	asl
	asl
	and	#<$4
	sta	<R0
	ldy	#$23
	lda	[<L55+c_0],Y
	and	#<$fffffffb
	ora	<R0
	sta	[<L55+c_0],Y
	stz	<R0
	lda	<L56+result_1
	and	#$ff
	bne	L57
	inc	<R0
L57:
	asl	<R0
	lda	<R0
	and	#<$2
	sta	<R0
	ldy	#$23
	lda	[<L55+c_0],Y
	and	#<$fffffffd
	ora	<R0
	sta	[<L55+c_0],Y
	lda	<L56+result_1
	and	#$ff
	ldx	#<$7
	xref	~~~asr
	jsl	~~~asr
	and	#<$1
	sta	<R0
	ldy	#$23
	lda	[<L55+c_0],Y
	and	#<$fffffffe
	ora	<R0
	sta	[<L55+c_0],Y
	pei	<L56+result_1
	jsl	~~parity
	asl
	asl
	asl
	and	#<$8
	sta	<R0
	ldy	#$23
	lda	[<L55+c_0],Y
	and	#<$fffffff7
	ora	<R0
	sta	[<L55+c_0],Y
	sep	#$20
	longa	off
	lda	<L56+result_1
	sta	[<L55+reg_0]
	rep	#$20
	longa	on
	lda	<L55+2
	sta	<L55+2+12
	lda	<L55+1
	sta	<L55+1+12
	pld
	tsc
	clc
	adc	#L55+12
	tcs
	rtl
L55	equ	13
L56	equ	13
	ends
	efunc
	code
	func
~~i8080_sub:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L60
	tcs
	phd
	tcd
c_0	set	4
reg_0	set	8
val_0	set	12
cy_0	set	14
	stz	<R0
	lda	<L60+cy_0
	bne	L62
	inc	<R0
L62:
	pei	<R0
	lda	<L60+val_0
	and	#$ff
	eor	#<$ffffffff
	pha
	pei	<L60+reg_0+2
	pei	<L60+reg_0
	pei	<L60+c_0+2
	pei	<L60+c_0
	jsl	~~i8080_add
	stz	<R0
	ldy	#$23
	lda	[<L60+c_0],Y
	bit	#$10
	bne	L64
	inc	<R0
L64:
	asl	<R0
	asl	<R0
	asl	<R0
	asl	<R0
	lda	<R0
	and	#<$10
	sta	<R0
	ldy	#$23
	lda	[<L60+c_0],Y
	and	#<$ffffffef
	ora	<R0
	sta	[<L60+c_0],Y
	lda	<L60+2
	sta	<L60+2+12
	lda	<L60+1
	sta	<L60+1+12
	pld
	tsc
	clc
	adc	#L60+12
	tcs
	rtl
L60	equ	4
L61	equ	5
	ends
	efunc
	code
	func
~~i8080_dad:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L67
	tcs
	phd
	tcd
c_0	set	4
val_0	set	8
result_1	set	0
	lda	<L67+val_0
	sta	<R0
	stz	<R0+2
	pei	<L67+c_0+2
	pei	<L67+c_0
	jsl	~~i8080_get_hl
	sta	<R1
	stz	<R1+2
	lda	<R1
	clc
	adc	<R0
	sta	<L68+result_1
	lda	<R1+2
	adc	<R0+2
	sta	<L68+result_1+2
	pha
	pei	<L68+result_1
	lda	#$10
	xref	~~~llsr
	jsl	~~~llsr
	sta	<L68+result_1
	stx	<L68+result_1+2
	and	#<$1
	sta	<R0
	stz	<R0+2
	asl	<R0
	asl	<R0
	asl	<R0
	asl	<R0
	lda	<R0
	and	#<$10
	sta	<R0
	ldy	#$23
	lda	[<L67+c_0],Y
	and	#<$ffffffef
	ora	<R0
	sta	[<L67+c_0],Y
	pei	<L67+c_0+2
	pei	<L67+c_0
	jsl	~~i8080_get_hl
	clc
	adc	<L67+val_0
	pha
	pei	<L67+c_0+2
	pei	<L67+c_0
	jsl	~~i8080_set_hl
	lda	<L67+2
	sta	<L67+2+6
	lda	<L67+1
	sta	<L67+1+6
	pld
	tsc
	clc
	adc	#L67+6
	tcs
	rtl
L67	equ	12
L68	equ	9
	ends
	efunc
	code
	func
~~i8080_inr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L70
	tcs
	phd
	tcd
c_0	set	4
val_0	set	8
result_1	set	0
	sep	#$20
	longa	off
	lda	<L70+val_0
	ina
	sta	<L71+result_1
	rep	#$20
	longa	on
	stz	<R0
	sep	#$20
	longa	off
	lda	<L71+result_1
	and	#<$f
	rep	#$20
	longa	on
	bne	L72
	inc	<R0
L72:
	asl	<R0
	asl	<R0
	lda	<R0
	and	#<$4
	sta	<R0
	ldy	#$23
	lda	[<L70+c_0],Y
	and	#<$fffffffb
	ora	<R0
	sta	[<L70+c_0],Y
	stz	<R0
	lda	<L71+result_1
	and	#$ff
	bne	L74
	inc	<R0
L74:
	asl	<R0
	lda	<R0
	and	#<$2
	sta	<R0
	ldy	#$23
	lda	[<L70+c_0],Y
	and	#<$fffffffd
	ora	<R0
	sta	[<L70+c_0],Y
	lda	<L71+result_1
	and	#$ff
	ldx	#<$7
	xref	~~~asr
	jsl	~~~asr
	and	#<$1
	sta	<R0
	ldy	#$23
	lda	[<L70+c_0],Y
	and	#<$fffffffe
	ora	<R0
	sta	[<L70+c_0],Y
	pei	<L71+result_1
	jsl	~~parity
	asl
	asl
	asl
	and	#<$8
	sta	<R0
	ldy	#$23
	lda	[<L70+c_0],Y
	and	#<$fffffff7
	ora	<R0
	sta	[<L70+c_0],Y
	lda	<L71+result_1
	and	#$ff
	tay
	lda	<L70+2
	sta	<L70+2+6
	lda	<L70+1
	sta	<L70+1+6
	pld
	tsc
	clc
	adc	#L70+6
	tcs
	tya
	rtl
L70	equ	5
L71	equ	5
	ends
	efunc
	code
	func
~~i8080_dcr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L77
	tcs
	phd
	tcd
c_0	set	4
val_0	set	8
result_1	set	0
	lda	<L77+val_0
	and	#$ff
	sta	<R0
	clc
	adc	#$ffff
	sep	#$20
	longa	off
	sta	<L78+result_1
	rep	#$20
	longa	on
	stz	<R0
	lda	<L78+result_1
	and	#<$f
	cmp	#<$f
	beq	L79
	inc	<R0
L79:
	asl	<R0
	asl	<R0
	lda	<R0
	and	#<$4
	sta	<R0
	ldy	#$23
	lda	[<L77+c_0],Y
	and	#<$fffffffb
	ora	<R0
	sta	[<L77+c_0],Y
	stz	<R0
	lda	<L78+result_1
	and	#$ff
	bne	L81
	inc	<R0
L81:
	asl	<R0
	lda	<R0
	and	#<$2
	sta	<R0
	ldy	#$23
	lda	[<L77+c_0],Y
	and	#<$fffffffd
	ora	<R0
	sta	[<L77+c_0],Y
	lda	<L78+result_1
	and	#$ff
	ldx	#<$7
	xref	~~~asr
	jsl	~~~asr
	and	#<$1
	sta	<R0
	ldy	#$23
	lda	[<L77+c_0],Y
	and	#<$fffffffe
	ora	<R0
	sta	[<L77+c_0],Y
	pei	<L78+result_1
	jsl	~~parity
	asl
	asl
	asl
	and	#<$8
	sta	<R0
	ldy	#$23
	lda	[<L77+c_0],Y
	and	#<$fffffff7
	ora	<R0
	sta	[<L77+c_0],Y
	lda	<L78+result_1
	and	#$ff
	tay
	lda	<L77+2
	sta	<L77+2+6
	lda	<L77+1
	sta	<L77+1+6
	pld
	tsc
	clc
	adc	#L77+6
	tcs
	tya
	rtl
L77	equ	9
L78	equ	9
	ends
	efunc
	code
	func
~~i8080_ana:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L84
	tcs
	phd
	tcd
c_0	set	4
val_0	set	8
result_1	set	0
	sep	#$20
	longa	off
	lda	<L84+val_0
	ldy	#$1c
	and	[<L84+c_0],Y
	sta	<L85+result_1
	rep	#$20
	longa	on
	ldy	#$23
	lda	[<L84+c_0],Y
	and	#<$ffffffef
	sta	[<L84+c_0],Y
	stz	<R0
	ldy	#$1c
	lda	[<L84+c_0],Y
	and	#$ff
	sta	<R1
	lda	<L84+val_0
	and	#$ff
	ora	<R1
	and	#<$8
	beq	L86
	inc	<R0
L86:
	asl	<R0
	asl	<R0
	lda	<R0
	and	#<$4
	sta	<R0
	ldy	#$23
	lda	[<L84+c_0],Y
	and	#<$fffffffb
	ora	<R0
	sta	[<L84+c_0],Y
	stz	<R0
	lda	<L85+result_1
	and	#$ff
	bne	L88
	inc	<R0
L88:
	asl	<R0
	lda	<R0
	and	#<$2
	sta	<R0
	ldy	#$23
	lda	[<L84+c_0],Y
	and	#<$fffffffd
	ora	<R0
	sta	[<L84+c_0],Y
	lda	<L85+result_1
	and	#$ff
	ldx	#<$7
	xref	~~~asr
	jsl	~~~asr
	and	#<$1
	sta	<R0
	ldy	#$23
	lda	[<L84+c_0],Y
	and	#<$fffffffe
	ora	<R0
	sta	[<L84+c_0],Y
	pei	<L85+result_1
	jsl	~~parity
	asl
	asl
	asl
	and	#<$8
	sta	<R0
	ldy	#$23
	lda	[<L84+c_0],Y
	and	#<$fffffff7
	ora	<R0
	sta	[<L84+c_0],Y
	sep	#$20
	longa	off
	lda	<L85+result_1
	ldy	#$1c
	sta	[<L84+c_0],Y
	rep	#$20
	longa	on
	lda	<L84+2
	sta	<L84+2+6
	lda	<L84+1
	sta	<L84+1+6
	pld
	tsc
	clc
	adc	#L84+6
	tcs
	rtl
L84	equ	17
L85	equ	17
	ends
	efunc
	code
	func
~~i8080_xra:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L91
	tcs
	phd
	tcd
c_0	set	4
val_0	set	8
	lda	#$1c
	clc
	adc	<L91+c_0
	sta	<R0
	lda	#$0
	adc	<L91+c_0+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	<L91+val_0
	eor	[<R0]
	sta	[<R0]
	rep	#$20
	longa	on
	ldy	#$23
	lda	[<L91+c_0],Y
	and	#<$ffffffef
	and	#<$fffffffb
	sta	[<L91+c_0],Y
	stz	<R0
	ldy	#$1c
	lda	[<L91+c_0],Y
	and	#$ff
	bne	L93
	inc	<R0
L93:
	asl	<R0
	lda	<R0
	and	#<$2
	sta	<R0
	ldy	#$23
	lda	[<L91+c_0],Y
	and	#<$fffffffd
	ora	<R0
	sta	[<L91+c_0],Y
	ldy	#$1c
	lda	[<L91+c_0],Y
	and	#$ff
	ldx	#<$7
	xref	~~~asr
	jsl	~~~asr
	and	#<$1
	sta	<R0
	ldy	#$23
	lda	[<L91+c_0],Y
	and	#<$fffffffe
	ora	<R0
	sta	[<L91+c_0],Y
	ldy	#$1c
	lda	[<L91+c_0],Y
	pha
	jsl	~~parity
	asl
	asl
	asl
	and	#<$8
	sta	<R0
	ldy	#$23
	lda	[<L91+c_0],Y
	and	#<$fffffff7
	ora	<R0
	sta	[<L91+c_0],Y
	lda	<L91+2
	sta	<L91+2+6
	lda	<L91+1
	sta	<L91+1+6
	pld
	tsc
	clc
	adc	#L91+6
	tcs
	rtl
L91	equ	4
L92	equ	5
	ends
	efunc
	code
	func
~~i8080_ora:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L96
	tcs
	phd
	tcd
c_0	set	4
val_0	set	8
	lda	#$1c
	clc
	adc	<L96+c_0
	sta	<R0
	lda	#$0
	adc	<L96+c_0+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	<L96+val_0
	ora	[<R0]
	sta	[<R0]
	rep	#$20
	longa	on
	ldy	#$23
	lda	[<L96+c_0],Y
	and	#<$ffffffef
	and	#<$fffffffb
	sta	[<L96+c_0],Y
	stz	<R0
	ldy	#$1c
	lda	[<L96+c_0],Y
	and	#$ff
	bne	L98
	inc	<R0
L98:
	asl	<R0
	lda	<R0
	and	#<$2
	sta	<R0
	ldy	#$23
	lda	[<L96+c_0],Y
	and	#<$fffffffd
	ora	<R0
	sta	[<L96+c_0],Y
	ldy	#$1c
	lda	[<L96+c_0],Y
	and	#$ff
	ldx	#<$7
	xref	~~~asr
	jsl	~~~asr
	and	#<$1
	sta	<R0
	ldy	#$23
	lda	[<L96+c_0],Y
	and	#<$fffffffe
	ora	<R0
	sta	[<L96+c_0],Y
	ldy	#$1c
	lda	[<L96+c_0],Y
	pha
	jsl	~~parity
	asl
	asl
	asl
	and	#<$8
	sta	<R0
	ldy	#$23
	lda	[<L96+c_0],Y
	and	#<$fffffff7
	ora	<R0
	sta	[<L96+c_0],Y
	lda	<L96+2
	sta	<L96+2+6
	lda	<L96+1
	sta	<L96+1+6
	pld
	tsc
	clc
	adc	#L96+6
	tcs
	rtl
L96	equ	4
L97	equ	5
	ends
	efunc
	code
	func
~~i8080_cmp:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L101
	tcs
	phd
	tcd
c_0	set	4
val_0	set	8
result_1	set	0
	lda	<L101+val_0
	and	#$ff
	sta	<R0
	ldy	#$1c
	lda	[<L101+c_0],Y
	and	#$ff
	sec
	sbc	<R0
	sta	<L102+result_1
	ldx	#<$8
	xref	~~~asr
	jsl	~~~asr
	asl
	asl
	asl
	asl
	and	#<$10
	sta	<R0
	ldy	#$23
	lda	[<L101+c_0],Y
	and	#<$ffffffef
	ora	<R0
	sta	[<L101+c_0],Y
	ldy	#$1c
	lda	[<L101+c_0],Y
	and	#$ff
	sta	<R0
	lda	<L101+val_0
	and	#$ff
	eor	<R0
	sta	<R2
	lda	<L102+result_1
	eor	<R2
	eor	#<$ffffffff
	and	#<$10
	asl
	asl
	and	#<$4
	sta	<R0
	ldy	#$23
	lda	[<L101+c_0],Y
	and	#<$fffffffb
	ora	<R0
	sta	[<L101+c_0],Y
	stz	<R0
	lda	<L102+result_1
	and	#<$ff
	bne	L103
	inc	<R0
L103:
	asl	<R0
	lda	<R0
	and	#<$2
	sta	<R0
	ldy	#$23
	lda	[<L101+c_0],Y
	and	#<$fffffffd
	ora	<R0
	sta	[<L101+c_0],Y
	lda	<L102+result_1
	and	#<$ff
	ldx	#<$7
	xref	~~~asr
	jsl	~~~asr
	and	#<$1
	sta	<R0
	ldy	#$23
	lda	[<L101+c_0],Y
	and	#<$fffffffe
	ora	<R0
	sta	[<L101+c_0],Y
	lda	<L102+result_1
	and	#<$ff
	pha
	jsl	~~parity
	asl
	asl
	asl
	and	#<$8
	sta	<R0
	ldy	#$23
	lda	[<L101+c_0],Y
	and	#<$fffffff7
	ora	<R0
	sta	[<L101+c_0],Y
	lda	<L101+2
	sta	<L101+2+6
	lda	<L101+1
	sta	<L101+1+6
	pld
	tsc
	clc
	adc	#L101+6
	tcs
	rtl
L101	equ	14
L102	equ	13
	ends
	efunc
	code
	func
~~i8080_jmp:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L106
	tcs
	phd
	tcd
c_0	set	4
addr_0	set	8
	lda	<L106+addr_0
	ldy	#$18
	sta	[<L106+c_0],Y
	lda	<L106+2
	sta	<L106+2+6
	lda	<L106+1
	sta	<L106+1+6
	pld
	tsc
	clc
	adc	#L106+6
	tcs
	rtl
L106	equ	0
L107	equ	1
	ends
	efunc
	code
	func
~~i8080_cond_jmp:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L109
	tcs
	phd
	tcd
c_0	set	4
condition_0	set	8
addr_1	set	0
	pei	<L109+c_0+2
	pei	<L109+c_0
	jsl	~~i8080_next_word
	sta	<L110+addr_1
	lda	<L109+condition_0
	beq	L112
	lda	<L110+addr_1
	ldy	#$18
	sta	[<L109+c_0],Y
L112:
	lda	<L109+2
	sta	<L109+2+6
	lda	<L109+1
	sta	<L109+1+6
	pld
	tsc
	clc
	adc	#L109+6
	tcs
	rtl
L109	equ	2
L110	equ	1
	ends
	efunc
	code
	func
~~i8080_call:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L113
	tcs
	phd
	tcd
c_0	set	4
addr_0	set	8
	ldy	#$18
	lda	[<L113+c_0],Y
	pha
	pei	<L113+c_0+2
	pei	<L113+c_0
	jsl	~~i8080_push_stack
	pei	<L113+addr_0
	pei	<L113+c_0+2
	pei	<L113+c_0
	jsl	~~i8080_jmp
	lda	<L113+2
	sta	<L113+2+6
	lda	<L113+1
	sta	<L113+1+6
	pld
	tsc
	clc
	adc	#L113+6
	tcs
	rtl
L113	equ	0
L114	equ	1
	ends
	efunc
	code
	func
~~i8080_cond_call:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L116
	tcs
	phd
	tcd
c_0	set	4
condition_0	set	8
addr_1	set	0
	pei	<L116+c_0+2
	pei	<L116+c_0
	jsl	~~i8080_next_word
	sta	<L117+addr_1
	lda	<L116+condition_0
	beq	L119
	pei	<L117+addr_1
	pei	<L116+c_0+2
	pei	<L116+c_0
	jsl	~~i8080_call
	lda	#$14
	clc
	adc	<L116+c_0
	sta	<R0
	lda	#$0
	adc	<L116+c_0+2
	sta	<R0+2
	lda	#$6
	clc
	adc	[<R0]
	sta	[<R0]
	lda	#$0
	ldy	#$2
	adc	[<R0],Y
	sta	[<R0],Y
L119:
	lda	<L116+2
	sta	<L116+2+6
	lda	<L116+1
	sta	<L116+1+6
	pld
	tsc
	clc
	adc	#L116+6
	tcs
	rtl
L116	equ	6
L117	equ	5
	ends
	efunc
	code
	func
~~i8080_ret:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L120
	tcs
	phd
	tcd
c_0	set	4
	pei	<L120+c_0+2
	pei	<L120+c_0
	jsl	~~i8080_pop_stack
	ldy	#$18
	sta	[<L120+c_0],Y
	lda	<L120+2
	sta	<L120+2+4
	lda	<L120+1
	sta	<L120+1+4
	pld
	tsc
	clc
	adc	#L120+4
	tcs
	rtl
L120	equ	0
L121	equ	1
	ends
	efunc
	code
	func
~~i8080_cond_ret:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L123
	tcs
	phd
	tcd
c_0	set	4
condition_0	set	8
	lda	<L123+condition_0
	beq	L126
	pei	<L123+c_0+2
	pei	<L123+c_0
	jsl	~~i8080_ret
	lda	#$14
	clc
	adc	<L123+c_0
	sta	<R0
	lda	#$0
	adc	<L123+c_0+2
	sta	<R0+2
	lda	#$6
	clc
	adc	[<R0]
	sta	[<R0]
	lda	#$0
	ldy	#$2
	adc	[<R0],Y
	sta	[<R0],Y
L126:
	lda	<L123+2
	sta	<L123+2+6
	lda	<L123+1
	sta	<L123+1+6
	pld
	tsc
	clc
	adc	#L123+6
	tcs
	rtl
L123	equ	4
L124	equ	5
	ends
	efunc
	code
	func
~~i8080_push_psw:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L127
	tcs
	phd
	tcd
c_0	set	4
psw_1	set	0
	sep	#$20
	longa	off
	stz	<L128+psw_1
	rep	#$20
	longa	on
	ldy	#$23
	lda	[<L127+c_0],Y
	and	#<$1
	ldx	#<$7
	xref	~~~casl
	jsl	~~~casl
	sep	#$20
	longa	off
	tsb	<L128+psw_1
	rep	#$20
	longa	on
	ldy	#$23
	lda	[<L127+c_0],Y
	lsr
	and	#<$1
	ldx	#<$6
	xref	~~~casl
	jsl	~~~casl
	sep	#$20
	longa	off
	tsb	<L128+psw_1
	rep	#$20
	longa	on
	ldy	#$23
	lda	[<L127+c_0],Y
	lsr
	lsr
	and	#<$1
	sep	#$20
	longa	off
	asl	A
	asl	A
	asl	A
	asl	A
	tsb	<L128+psw_1
	rep	#$20
	longa	on
	lda	[<L127+c_0],Y
	lsr
	lsr
	lsr
	and	#<$1
	sep	#$20
	longa	off
	asl	A
	asl	A
	tsb	<L128+psw_1
	lda	#$2
	tsb	<L128+psw_1
	rep	#$20
	longa	on
	lda	[<L127+c_0],Y
	lsr
	lsr
	lsr
	lsr
	and	#<$1
	sep	#$20
	longa	off
	tsb	<L128+psw_1
	rep	#$20
	longa	on
	ldy	#$1c
	lda	[<L127+c_0],Y
	and	#$ff
	xba
	and	#$ff00
	sta	<R0
	lda	<L128+psw_1
	and	#$ff
	ora	<R0
	pha
	pei	<L127+c_0+2
	pei	<L127+c_0
	jsl	~~i8080_push_stack
	lda	<L127+2
	sta	<L127+2+4
	lda	<L127+1
	sta	<L127+1+4
	pld
	tsc
	clc
	adc	#L127+4
	tcs
	rtl
L127	equ	9
L128	equ	9
	ends
	efunc
	code
	func
~~i8080_pop_psw:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L130
	tcs
	phd
	tcd
c_0	set	4
psw_1	set	0
af_1	set	1
	pei	<L130+c_0+2
	pei	<L130+c_0
	jsl	~~i8080_pop_stack
	sta	<L131+af_1
	xba
	and	#$00ff
	sep	#$20
	longa	off
	ldy	#$1c
	sta	[<L130+c_0],Y
	rep	#$20
	longa	on
	lda	<L131+af_1
	and	#<$ff
	sep	#$20
	longa	off
	sta	<L131+psw_1
	rep	#$20
	longa	on
	lda	<L131+psw_1
	and	#$ff
	ldx	#<$7
	xref	~~~asr
	jsl	~~~asr
	and	#<$1
	and	#<$1
	sta	<R0
	ldy	#$23
	lda	[<L130+c_0],Y
	and	#<$fffffffe
	ora	<R0
	sta	[<L130+c_0],Y
	lda	<L131+psw_1
	and	#$ff
	ldx	#<$6
	xref	~~~asr
	jsl	~~~asr
	and	#<$1
	asl
	and	#<$2
	sta	<R0
	ldy	#$23
	lda	[<L130+c_0],Y
	and	#<$fffffffd
	ora	<R0
	sta	[<L130+c_0],Y
	lda	<L131+psw_1
	and	#$ff
	ldx	#<$4
	xref	~~~asr
	jsl	~~~asr
	and	#<$1
	asl
	asl
	and	#<$4
	sta	<R0
	ldy	#$23
	lda	[<L130+c_0],Y
	and	#<$fffffffb
	ora	<R0
	sta	[<L130+c_0],Y
	lda	<L131+psw_1
	and	#$ff
	ldx	#<$2
	xref	~~~asr
	jsl	~~~asr
	and	#<$1
	asl
	asl
	asl
	and	#<$8
	sta	<R0
	ldy	#$23
	lda	[<L130+c_0],Y
	and	#<$fffffff7
	ora	<R0
	sta	[<L130+c_0],Y
	lda	<L131+psw_1
	and	#<$1
	asl
	asl
	asl
	asl
	and	#<$10
	sta	<R0
	lda	[<L130+c_0],Y
	and	#<$ffffffef
	ora	<R0
	sta	[<L130+c_0],Y
	lda	<L130+2
	sta	<L130+2+4
	lda	<L130+1
	sta	<L130+1+4
	pld
	tsc
	clc
	adc	#L130+4
	tcs
	rtl
L130	equ	7
L131	equ	5
	ends
	efunc
	code
	func
~~i8080_rlc:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L133
	tcs
	phd
	tcd
c_0	set	4
	ldy	#$1c
	lda	[<L133+c_0],Y
	and	#$ff
	ldx	#<$7
	xref	~~~asr
	jsl	~~~asr
	asl
	asl
	asl
	asl
	and	#<$10
	sta	<R0
	ldy	#$23
	lda	[<L133+c_0],Y
	and	#<$ffffffef
	ora	<R0
	sta	[<L133+c_0],Y
	sep	#$20
	longa	off
	ldy	#$1c
	lda	[<L133+c_0],Y
	asl	A
	sta	<R0
	rep	#$20
	longa	on
	ldy	#$23
	lda	[<L133+c_0],Y
	lsr
	lsr
	lsr
	lsr
	and	#<$1
	sep	#$20
	longa	off
	ora	<R0
	ldy	#$1c
	sta	[<L133+c_0],Y
	rep	#$20
	longa	on
	lda	<L133+2
	sta	<L133+2+4
	lda	<L133+1
	sta	<L133+1+4
	pld
	tsc
	clc
	adc	#L133+4
	tcs
	rtl
L133	equ	8
L134	equ	9
	ends
	efunc
	code
	func
~~i8080_rrc:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L136
	tcs
	phd
	tcd
c_0	set	4
	ldy	#$1c
	lda	[<L136+c_0],Y
	and	#<$1
	asl
	asl
	asl
	asl
	and	#<$10
	sta	<R0
	ldy	#$23
	lda	[<L136+c_0],Y
	and	#<$ffffffef
	ora	<R0
	sta	[<L136+c_0],Y
	sep	#$20
	longa	off
	ldy	#$1c
	lda	[<L136+c_0],Y
	lsr	A
	sta	<R0
	rep	#$20
	longa	on
	ldy	#$23
	lda	[<L136+c_0],Y
	lsr
	lsr
	lsr
	lsr
	and	#<$1
	ldx	#<$7
	xref	~~~casl
	jsl	~~~casl
	sep	#$20
	longa	off
	ora	<R0
	ldy	#$1c
	sta	[<L136+c_0],Y
	rep	#$20
	longa	on
	lda	<L136+2
	sta	<L136+2+4
	lda	<L136+1
	sta	<L136+1+4
	pld
	tsc
	clc
	adc	#L136+4
	tcs
	rtl
L136	equ	12
L137	equ	13
	ends
	efunc
	code
	func
~~i8080_ral:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L139
	tcs
	phd
	tcd
c_0	set	4
cy_1	set	0
	ldy	#$23
	lda	[<L139+c_0],Y
	lsr
	lsr
	lsr
	lsr
	and	#<$1
	sta	<L140+cy_1
	ldy	#$1c
	lda	[<L139+c_0],Y
	and	#$ff
	ldx	#<$7
	xref	~~~asr
	jsl	~~~asr
	asl
	asl
	asl
	asl
	and	#<$10
	sta	<R0
	ldy	#$23
	lda	[<L139+c_0],Y
	and	#<$ffffffef
	ora	<R0
	sta	[<L139+c_0],Y
	sep	#$20
	longa	off
	ldy	#$1c
	lda	[<L139+c_0],Y
	asl	A
	sta	<R0
	lda	<L140+cy_1
	ora	<R0
	sta	[<L139+c_0],Y
	rep	#$20
	longa	on
	lda	<L139+2
	sta	<L139+2+4
	lda	<L139+1
	sta	<L139+1+4
	pld
	tsc
	clc
	adc	#L139+4
	tcs
	rtl
L139	equ	6
L140	equ	5
	ends
	efunc
	code
	func
~~i8080_rar:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L142
	tcs
	phd
	tcd
c_0	set	4
cy_1	set	0
	ldy	#$23
	lda	[<L142+c_0],Y
	lsr
	lsr
	lsr
	lsr
	and	#<$1
	sta	<L143+cy_1
	ldy	#$1c
	lda	[<L142+c_0],Y
	and	#<$1
	asl
	asl
	asl
	asl
	and	#<$10
	sta	<R0
	ldy	#$23
	lda	[<L142+c_0],Y
	and	#<$ffffffef
	ora	<R0
	sta	[<L142+c_0],Y
	sep	#$20
	longa	off
	ldy	#$1c
	lda	[<L142+c_0],Y
	lsr	A
	sta	<R0
	rep	#$20
	longa	on
	lda	<L143+cy_1
	ldx	#<$7
	xref	~~~casl
	jsl	~~~casl
	sep	#$20
	longa	off
	ora	<R0
	ldy	#$1c
	sta	[<L142+c_0],Y
	rep	#$20
	longa	on
	lda	<L142+2
	sta	<L142+2+4
	lda	<L142+1
	sta	<L142+1+4
	pld
	tsc
	clc
	adc	#L142+4
	tcs
	rtl
L142	equ	10
L143	equ	9
	ends
	efunc
	code
	func
~~i8080_daa:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L145
	tcs
	phd
	tcd
c_0	set	4
cy_1	set	0
correction_1	set	2
lsb_1	set	3
msb_1	set	4
	ldy	#$23
	lda	[<L145+c_0],Y
	lsr
	lsr
	lsr
	lsr
	and	#<$1
	sta	<R0
	sta	<L146+cy_1
	sep	#$20
	longa	off
	stz	<L146+correction_1
	ldy	#$1c
	lda	[<L145+c_0],Y
	and	#<$f
	sta	<L146+lsb_1
	lda	[<L145+c_0],Y
	lsr	A
	lsr	A
	lsr	A
	lsr	A
	sta	<L146+msb_1
	rep	#$20
	longa	on
	ldy	#$23
	lda	[<L145+c_0],Y
	bit	#$4
	bne	L147
	sep	#$20
	longa	off
	lda	#$9
	cmp	<L146+lsb_1
	rep	#$20
	longa	on
	bcs	L10029
L147:
	sep	#$20
	longa	off
	lda	#$6
	clc
	adc	<L146+correction_1
	sta	<L146+correction_1
	rep	#$20
	longa	on
L10029:
	ldy	#$23
	lda	[<L145+c_0],Y
	bit	#$10
	bne	L150
	sep	#$20
	longa	off
	lda	#$9
	cmp	<L146+msb_1
	rep	#$20
	longa	on
	bcc	L150
	sep	#$20
	longa	off
	lda	<L146+msb_1
	cmp	#<$9
	rep	#$20
	longa	on
	bcc	L10030
	sep	#$20
	longa	off
	lda	#$9
	cmp	<L146+lsb_1
	rep	#$20
	longa	on
	bcs	L10030
L150:
	sep	#$20
	longa	off
	lda	#$60
	clc
	adc	<L146+correction_1
	sta	<L146+correction_1
	rep	#$20
	longa	on
	lda	#$1
	sta	<L146+cy_1
L10030:
	pea	#<$0
	pei	<L146+correction_1
	lda	#$1c
	clc
	adc	<L145+c_0
	sta	<R0
	lda	#$0
	adc	<L145+c_0+2
	pha
	pei	<R0
	pei	<L145+c_0+2
	pei	<L145+c_0
	jsl	~~i8080_add
	lda	<L146+cy_1
	asl
	asl
	asl
	asl
	and	#<$10
	sta	<R0
	ldy	#$23
	lda	[<L145+c_0],Y
	and	#<$ffffffef
	ora	<R0
	sta	[<L145+c_0],Y
	lda	<L145+2
	sta	<L145+2+4
	lda	<L145+1
	sta	<L145+1+4
	pld
	tsc
	clc
	adc	#L145+4
	tcs
	rtl
L145	equ	9
L146	equ	5
	ends
	efunc
	code
	func
~~i8080_xchg:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L156
	tcs
	phd
	tcd
c_0	set	4
de_1	set	0
	pei	<L156+c_0+2
	pei	<L156+c_0
	jsl	~~i8080_get_de
	sta	<L157+de_1
	pei	<L156+c_0+2
	pei	<L156+c_0
	jsl	~~i8080_get_hl
	pha
	pei	<L156+c_0+2
	pei	<L156+c_0
	jsl	~~i8080_set_de
	pei	<L157+de_1
	pei	<L156+c_0+2
	pei	<L156+c_0
	jsl	~~i8080_set_hl
	lda	<L156+2
	sta	<L156+2+4
	lda	<L156+1
	sta	<L156+1+4
	pld
	tsc
	clc
	adc	#L156+4
	tcs
	rtl
L156	equ	2
L157	equ	1
	ends
	efunc
	code
	func
~~i8080_xthl:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L159
	tcs
	phd
	tcd
c_0	set	4
val_1	set	0
	ldy	#$1a
	lda	[<L159+c_0],Y
	pha
	pei	<L159+c_0+2
	pei	<L159+c_0
	jsl	~~i8080_rw
	sta	<L160+val_1
	pei	<L159+c_0+2
	pei	<L159+c_0
	jsl	~~i8080_get_hl
	pha
	ldy	#$1a
	lda	[<L159+c_0],Y
	pha
	pei	<L159+c_0+2
	pei	<L159+c_0
	jsl	~~i8080_ww
	pei	<L160+val_1
	pei	<L159+c_0+2
	pei	<L159+c_0
	jsl	~~i8080_set_hl
	lda	<L159+2
	sta	<L159+2+4
	lda	<L159+1
	sta	<L159+1+4
	pld
	tsc
	clc
	adc	#L159+4
	tcs
	rtl
L159	equ	2
L160	equ	1
	ends
	efunc
	code
	func
~~i8080_execute:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L162
	tcs
	phd
	tcd
c_0	set	4
opcode_0	set	8
	sep	#$20
	longa	off
	lda	#$0
	ldy	#$26
	cmp	[<L162+c_0],Y
	rep	#$20
	longa	on
	bcs	L10031
	tya
	clc
	adc	<L162+c_0
	sta	<R0
	lda	#$0
	adc	<L162+c_0+2
	sta	<R0+2
	lda	[<R0]
	and	#$ff
	clc
	adc	#$ffff
	sep	#$20
	longa	off
	sta	[<R0]
	rep	#$20
	longa	on
L10031:
	lda	|~~debug
	beq	L10032
	lda	|~~stdin+2
	pha
	lda	|~~stdin
	pha
	jsl	~~fgetc
L10032:
	lda	<L162+opcode_0
	and	#$ff
	xref	~~~fsw
	jsl	~~~fsw
	dw	0
	dw	256
	dw	L216-1
	dw	L216-1
	dw	L10112-1
	dw	L10109-1
	dw	L10181-1
	dw	L10166-1
	dw	L10174-1
	dw	L10102-1
	dw	L10193-1
	dw	L216-1
	dw	L10157-1
	dw	L10043-1
	dw	L10185-1
	dw	L10167-1
	dw	L10175-1
	dw	L10103-1
	dw	L10194-1
	dw	L216-1
	dw	L10113-1
	dw	L10110-1
	dw	L10182-1
	dw	L10168-1
	dw	L10176-1
	dw	L10104-1
	dw	L10195-1
	dw	L216-1
	dw	L10158-1
	dw	L10044-1
	dw	L10186-1
	dw	L10169-1
	dw	L10177-1
	dw	L10105-1
	dw	L10196-1
	dw	L216-1
	dw	L10114-1
	dw	L10117-1
	dw	L10183-1
	dw	L10170-1
	dw	L10178-1
	dw	L10106-1
	dw	L10189-1
	dw	L216-1
	dw	L10159-1
	dw	L10116-1
	dw	L10187-1
	dw	L10171-1
	dw	L10179-1
	dw	L10107-1
	dw	L10190-1
	dw	L216-1
	dw	L10115-1
	dw	L10111-1
	dw	L10184-1
	dw	L10172-1
	dw	L10180-1
	dw	L10108-1
	dw	L10191-1
	dw	L216-1
	dw	L10160-1
	dw	L10045-1
	dw	L10188-1
	dw	L10165-1
	dw	L10173-1
	dw	L10101-1
	dw	L10192-1
	dw	L10047-1
	dw	L10048-1
	dw	L10049-1
	dw	L10050-1
	dw	L10051-1
	dw	L10052-1
	dw	L10053-1
	dw	L10046-1
	dw	L10055-1
	dw	L10056-1
	dw	L10057-1
	dw	L10058-1
	dw	L10059-1
	dw	L10060-1
	dw	L10061-1
	dw	L10054-1
	dw	L10063-1
	dw	L10064-1
	dw	L10065-1
	dw	L10066-1
	dw	L10067-1
	dw	L10068-1
	dw	L10069-1
	dw	L10062-1
	dw	L10071-1
	dw	L10072-1
	dw	L10073-1
	dw	L10074-1
	dw	L10075-1
	dw	L10076-1
	dw	L10077-1
	dw	L10070-1
	dw	L10079-1
	dw	L10080-1
	dw	L10081-1
	dw	L10082-1
	dw	L10083-1
	dw	L10084-1
	dw	L10085-1
	dw	L10078-1
	dw	L10087-1
	dw	L10088-1
	dw	L10089-1
	dw	L10090-1
	dw	L10091-1
	dw	L10092-1
	dw	L10093-1
	dw	L10086-1
	dw	L10095-1
	dw	L10096-1
	dw	L10097-1
	dw	L10098-1
	dw	L10099-1
	dw	L10100-1
	dw	L10164-1
	dw	L10094-1
	dw	L10036-1
	dw	L10037-1
	dw	L10038-1
	dw	L10039-1
	dw	L10040-1
	dw	L10041-1
	dw	L10042-1
	dw	L10035-1
	dw	L10122-1
	dw	L10123-1
	dw	L10124-1
	dw	L10125-1
	dw	L10126-1
	dw	L10127-1
	dw	L10128-1
	dw	L10121-1
	dw	L10131-1
	dw	L10132-1
	dw	L10133-1
	dw	L10134-1
	dw	L10135-1
	dw	L10136-1
	dw	L10137-1
	dw	L10130-1
	dw	L10140-1
	dw	L10141-1
	dw	L10142-1
	dw	L10143-1
	dw	L10144-1
	dw	L10145-1
	dw	L10146-1
	dw	L10139-1
	dw	L10149-1
	dw	L10150-1
	dw	L10151-1
	dw	L10152-1
	dw	L10153-1
	dw	L10154-1
	dw	L10155-1
	dw	L10148-1
	dw	L10198-1
	dw	L10199-1
	dw	L10200-1
	dw	L10201-1
	dw	L10202-1
	dw	L10203-1
	dw	L10204-1
	dw	L10197-1
	dw	L10207-1
	dw	L10208-1
	dw	L10209-1
	dw	L10210-1
	dw	L10211-1
	dw	L10212-1
	dw	L10213-1
	dw	L10206-1
	dw	L10216-1
	dw	L10217-1
	dw	L10218-1
	dw	L10219-1
	dw	L10220-1
	dw	L10221-1
	dw	L10222-1
	dw	L10215-1
	dw	L10225-1
	dw	L10226-1
	dw	L10227-1
	dw	L10228-1
	dw	L10229-1
	dw	L10230-1
	dw	L10231-1
	dw	L10224-1
	dw	L10253-1
	dw	L10273-1
	dw	L10234-1
	dw	L10233-1
	dw	L10244-1
	dw	L10269-1
	dw	L10129-1
	dw	L10261-1
	dw	L10254-1
	dw	L10252-1
	dw	L10235-1
	dw	L10233-1
	dw	L10245-1
	dw	L10243-1
	dw	L10138-1
	dw	L10262-1
	dw	L10255-1
	dw	L10274-1
	dw	L10236-1
	dw	L10278-1
	dw	L10246-1
	dw	L10270-1
	dw	L10147-1
	dw	L10263-1
	dw	L10256-1
	dw	L10252-1
	dw	L10237-1
	dw	L10277-1
	dw	L10247-1
	dw	L10243-1
	dw	L10156-1
	dw	L10264-1
	dw	L10257-1
	dw	L10275-1
	dw	L10238-1
	dw	L10120-1
	dw	L10248-1
	dw	L10271-1
	dw	L10205-1
	dw	L10265-1
	dw	L10258-1
	dw	L10242-1
	dw	L10239-1
	dw	L10119-1
	dw	L10249-1
	dw	L10243-1
	dw	L10214-1
	dw	L10266-1
	dw	L10259-1
	dw	L10276-1
	dw	L10240-1
	dw	L10161-1
	dw	L10250-1
	dw	L10272-1
	dw	L10223-1
	dw	L10267-1
	dw	L10260-1
	dw	L10118-1
	dw	L10241-1
	dw	L10162-1
	dw	L10251-1
	dw	L10243-1
	dw	L10232-1
	dw	L10268-1
L10035:
	sep	#$20
	longa	off
	ldy	#$1c
	lda	[<L162+c_0],Y
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
L216:
	lda	<L162+2
	sta	<L162+2+6
	lda	<L162+1
	sta	<L162+1+6
	pld
	tsc
	clc
	adc	#L162+6
	tcs
	rtl
L10036:
	sep	#$20
	longa	off
	ldy	#$1d
	lda	[<L162+c_0],Y
	dey
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	bra	L216
L10037:
	sep	#$20
	longa	off
	ldy	#$1e
	lda	[<L162+c_0],Y
	dey
	dey
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	bra	L216
L10038:
	sep	#$20
	longa	off
	ldy	#$1f
	lda	[<L162+c_0],Y
	ldy	#$1c
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	bra	L216
L10039:
	sep	#$20
	longa	off
	ldy	#$20
	lda	[<L162+c_0],Y
	ldy	#$1c
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	bra	L216
L10040:
	sep	#$20
	longa	off
	ldy	#$21
	lda	[<L162+c_0],Y
	ldy	#$1c
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	bra	L216
L10041:
	sep	#$20
	longa	off
	ldy	#$22
	lda	[<L162+c_0],Y
	ldy	#$1c
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	bra	L216
L10042:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_hl
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_rb
	sep	#$20
	longa	off
	ldy	#$1c
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10043:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_bc
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_rb
	sep	#$20
	longa	off
	ldy	#$1c
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10044:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_de
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_rb
	sep	#$20
	longa	off
	ldy	#$1c
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10045:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_word
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_rb
	sep	#$20
	longa	off
	ldy	#$1c
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10046:
	sep	#$20
	longa	off
	ldy	#$1c
	lda	[<L162+c_0],Y
	iny
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10047:
	sep	#$20
	longa	off
	ldy	#$1d
	lda	[<L162+c_0],Y
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10048:
	sep	#$20
	longa	off
	ldy	#$1e
	lda	[<L162+c_0],Y
	dey
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10049:
	sep	#$20
	longa	off
	ldy	#$1f
	lda	[<L162+c_0],Y
	dey
	dey
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10050:
	sep	#$20
	longa	off
	ldy	#$20
	lda	[<L162+c_0],Y
	ldy	#$1d
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10051:
	sep	#$20
	longa	off
	ldy	#$21
	lda	[<L162+c_0],Y
	ldy	#$1d
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10052:
	sep	#$20
	longa	off
	ldy	#$22
	lda	[<L162+c_0],Y
	ldy	#$1d
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10053:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_hl
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_rb
	sep	#$20
	longa	off
	ldy	#$1d
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10054:
	sep	#$20
	longa	off
	ldy	#$1c
	lda	[<L162+c_0],Y
	iny
	iny
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10055:
	sep	#$20
	longa	off
	ldy	#$1d
	lda	[<L162+c_0],Y
	iny
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10056:
	sep	#$20
	longa	off
	ldy	#$1e
	lda	[<L162+c_0],Y
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10057:
	sep	#$20
	longa	off
	ldy	#$1f
	lda	[<L162+c_0],Y
	dey
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10058:
	sep	#$20
	longa	off
	ldy	#$20
	lda	[<L162+c_0],Y
	dey
	dey
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10059:
	sep	#$20
	longa	off
	ldy	#$21
	lda	[<L162+c_0],Y
	ldy	#$1e
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10060:
	sep	#$20
	longa	off
	ldy	#$22
	lda	[<L162+c_0],Y
	ldy	#$1e
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10061:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_hl
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_rb
	sep	#$20
	longa	off
	ldy	#$1e
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10062:
	sep	#$20
	longa	off
	ldy	#$1c
	lda	[<L162+c_0],Y
	ldy	#$1f
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10063:
	sep	#$20
	longa	off
	ldy	#$1d
	lda	[<L162+c_0],Y
	iny
	iny
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10064:
	sep	#$20
	longa	off
	ldy	#$1e
	lda	[<L162+c_0],Y
	iny
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10065:
	sep	#$20
	longa	off
	ldy	#$1f
	lda	[<L162+c_0],Y
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10066:
	sep	#$20
	longa	off
	ldy	#$20
	lda	[<L162+c_0],Y
	dey
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10067:
	sep	#$20
	longa	off
	ldy	#$21
	lda	[<L162+c_0],Y
	dey
	dey
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10068:
	sep	#$20
	longa	off
	ldy	#$22
	lda	[<L162+c_0],Y
	ldy	#$1f
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10069:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_hl
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_rb
	sep	#$20
	longa	off
	ldy	#$1f
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10070:
	sep	#$20
	longa	off
	ldy	#$1c
	lda	[<L162+c_0],Y
	ldy	#$20
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10071:
	sep	#$20
	longa	off
	ldy	#$1d
	lda	[<L162+c_0],Y
	ldy	#$20
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10072:
	sep	#$20
	longa	off
	ldy	#$1e
	lda	[<L162+c_0],Y
	iny
	iny
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10073:
	sep	#$20
	longa	off
	ldy	#$1f
	lda	[<L162+c_0],Y
	iny
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10074:
	sep	#$20
	longa	off
	ldy	#$20
	lda	[<L162+c_0],Y
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10075:
	sep	#$20
	longa	off
	ldy	#$21
	lda	[<L162+c_0],Y
	dey
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10076:
	sep	#$20
	longa	off
	ldy	#$22
	lda	[<L162+c_0],Y
	dey
	dey
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10077:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_hl
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_rb
	sep	#$20
	longa	off
	ldy	#$20
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10078:
	sep	#$20
	longa	off
	ldy	#$1c
	lda	[<L162+c_0],Y
	ldy	#$21
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10079:
	sep	#$20
	longa	off
	ldy	#$1d
	lda	[<L162+c_0],Y
	ldy	#$21
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10080:
	sep	#$20
	longa	off
	ldy	#$1e
	lda	[<L162+c_0],Y
	ldy	#$21
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10081:
	sep	#$20
	longa	off
	ldy	#$1f
	lda	[<L162+c_0],Y
	iny
	iny
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10082:
	sep	#$20
	longa	off
	ldy	#$20
	lda	[<L162+c_0],Y
	iny
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10083:
	sep	#$20
	longa	off
	ldy	#$21
	lda	[<L162+c_0],Y
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10084:
	sep	#$20
	longa	off
	ldy	#$22
	lda	[<L162+c_0],Y
	dey
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10085:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_hl
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_rb
	sep	#$20
	longa	off
	ldy	#$21
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10086:
	sep	#$20
	longa	off
	ldy	#$1c
	lda	[<L162+c_0],Y
	ldy	#$22
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10087:
	sep	#$20
	longa	off
	ldy	#$1d
	lda	[<L162+c_0],Y
	ldy	#$22
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10088:
	sep	#$20
	longa	off
	ldy	#$1e
	lda	[<L162+c_0],Y
	ldy	#$22
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10089:
	sep	#$20
	longa	off
	ldy	#$1f
	lda	[<L162+c_0],Y
	ldy	#$22
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10090:
	sep	#$20
	longa	off
	ldy	#$20
	lda	[<L162+c_0],Y
	iny
	iny
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10091:
	sep	#$20
	longa	off
	ldy	#$21
	lda	[<L162+c_0],Y
	iny
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10092:
	sep	#$20
	longa	off
	ldy	#$22
	lda	[<L162+c_0],Y
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10093:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_hl
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_rb
	sep	#$20
	longa	off
	ldy	#$22
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10094:
	ldy	#$1c
L20008:
	lda	[<L162+c_0],Y
L20056:
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_hl
L20060:
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_wb
	brl	L216
L10095:
	ldy	#$1d
	bra	L20008
L10096:
	ldy	#$1e
	bra	L20008
L10097:
	ldy	#$1f
	bra	L20008
L10098:
	ldy	#$20
	bra	L20008
L10099:
	ldy	#$21
	bra	L20008
L10100:
	ldy	#$22
	bra	L20008
L10101:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_byte
	sep	#$20
	longa	off
	ldy	#$1c
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10102:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_byte
	sep	#$20
	longa	off
	ldy	#$1d
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10103:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_byte
	sep	#$20
	longa	off
	ldy	#$1e
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10104:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_byte
	sep	#$20
	longa	off
	ldy	#$1f
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10105:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_byte
	sep	#$20
	longa	off
	ldy	#$20
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10106:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_byte
	sep	#$20
	longa	off
	ldy	#$21
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10107:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_byte
	sep	#$20
	longa	off
	ldy	#$22
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10108:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_byte
	brl	L20056
L10109:
	ldy	#$1c
	lda	[<L162+c_0],Y
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_bc
	brl	L20060
L10110:
	ldy	#$1c
	lda	[<L162+c_0],Y
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_de
	brl	L20060
L10111:
	ldy	#$1c
	lda	[<L162+c_0],Y
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_word
	brl	L20060
L10112:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_word
L20082:
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_set_bc
	brl	L216
L10113:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_word
L20092:
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_set_de
	brl	L216
L10114:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_word
L20102:
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_set_hl
	brl	L216
L10115:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_word
L20113:
	ldy	#$1a
L20114:
	sta	[<L162+c_0],Y
	brl	L216
L10116:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_word
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_rw
	bra	L20102
L10117:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_hl
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_word
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_ww
	brl	L216
L10118:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_hl
	bra	L20113
L10119:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_xchg
	brl	L216
L10120:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_xthl
	brl	L216
L10121:
	pea	#<$0
	ldy	#$1c
L20128:
	lda	[<L162+c_0],Y
L20206:
	pha
	lda	#$1c
	clc
	adc	<L162+c_0
	sta	<R0
	lda	#$0
	adc	<L162+c_0+2
	pha
	pei	<R0
L20221:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_add
	brl	L216
L10122:
	pea	#<$0
	ldy	#$1d
	bra	L20128
L10123:
	pea	#<$0
	ldy	#$1e
	bra	L20128
L10124:
	pea	#<$0
	ldy	#$1f
	bra	L20128
L10125:
	pea	#<$0
	ldy	#$20
	bra	L20128
L10126:
	pea	#<$0
	ldy	#$21
	bra	L20128
L10127:
	pea	#<$0
	ldy	#$22
	bra	L20128
L10128:
	pea	#<$0
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_hl
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_rb
	bra	L20206
L10129:
	pea	#<$0
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_byte
	bra	L20206
L10130:
	ldy	#$23
	lda	[<L162+c_0],Y
	lsr
	lsr
	lsr
	lsr
	and	#<$1
	pha
	ldy	#$1c
L20248:
	lda	[<L162+c_0],Y
L20308:
	pha
	lda	#$1c
	clc
	adc	<L162+c_0
	sta	<R1
	lda	#$0
	adc	<L162+c_0+2
	pha
	pei	<R1
	brl	L20221
L10131:
	ldy	#$23
	lda	[<L162+c_0],Y
	lsr
	lsr
	lsr
	lsr
	and	#<$1
	pha
	ldy	#$1d
	bra	L20248
L10132:
	ldy	#$23
	lda	[<L162+c_0],Y
	lsr
	lsr
	lsr
	lsr
	and	#<$1
	pha
	ldy	#$1e
	bra	L20248
L10133:
	ldy	#$23
	lda	[<L162+c_0],Y
	lsr
	lsr
	lsr
	lsr
	and	#<$1
	pha
	ldy	#$1f
	bra	L20248
L10134:
	ldy	#$23
	lda	[<L162+c_0],Y
	lsr
	lsr
	lsr
	lsr
	and	#<$1
	pha
	ldy	#$20
	bra	L20248
L10135:
	ldy	#$23
	lda	[<L162+c_0],Y
	lsr
	lsr
	lsr
	lsr
	and	#<$1
	pha
	dey
L20767:
	dey
	bra	L20248
L10136:
	ldy	#$23
	lda	[<L162+c_0],Y
	lsr
	lsr
	lsr
	lsr
	and	#<$1
	pha
	bra	L20767
L10137:
	ldy	#$23
	lda	[<L162+c_0],Y
	lsr
	lsr
	lsr
	lsr
	and	#<$1
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_hl
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_rb
	brl	L20308
L10138:
	ldy	#$23
	lda	[<L162+c_0],Y
	lsr
	lsr
	lsr
	lsr
	and	#<$1
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_byte
	brl	L20308
L10139:
	pea	#<$0
	ldy	#$1c
L20331:
	lda	[<L162+c_0],Y
L20409:
	pha
	lda	#$1c
	clc
	adc	<L162+c_0
	sta	<R0
	lda	#$0
	adc	<L162+c_0+2
	pha
	pei	<R0
L20424:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_sub
	brl	L216
L10140:
	pea	#<$0
	ldy	#$1d
	bra	L20331
L10141:
	pea	#<$0
	ldy	#$1e
	bra	L20331
L10142:
	pea	#<$0
	ldy	#$1f
	bra	L20331
L10143:
	pea	#<$0
	ldy	#$20
	bra	L20331
L10144:
	pea	#<$0
	ldy	#$21
	bra	L20331
L10145:
	pea	#<$0
	ldy	#$22
	bra	L20331
L10146:
	pea	#<$0
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_hl
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_rb
	bra	L20409
L10147:
	pea	#<$0
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_byte
	bra	L20409
L10148:
	ldy	#$23
	lda	[<L162+c_0],Y
	lsr
	lsr
	lsr
	lsr
	and	#<$1
	pha
	ldy	#$1c
L20451:
	lda	[<L162+c_0],Y
L20511:
	pha
	lda	#$1c
	clc
	adc	<L162+c_0
	sta	<R1
	lda	#$0
	adc	<L162+c_0+2
	pha
	pei	<R1
	brl	L20424
L10149:
	ldy	#$23
	lda	[<L162+c_0],Y
	lsr
	lsr
	lsr
	lsr
	and	#<$1
	pha
	ldy	#$1d
	bra	L20451
L10150:
	ldy	#$23
	lda	[<L162+c_0],Y
	lsr
	lsr
	lsr
	lsr
	and	#<$1
	pha
	ldy	#$1e
	bra	L20451
L10151:
	ldy	#$23
	lda	[<L162+c_0],Y
	lsr
	lsr
	lsr
	lsr
	and	#<$1
	pha
	ldy	#$1f
	bra	L20451
L10152:
	ldy	#$23
	lda	[<L162+c_0],Y
	lsr
	lsr
	lsr
	lsr
	and	#<$1
	pha
	ldy	#$20
	bra	L20451
L10153:
	ldy	#$23
	lda	[<L162+c_0],Y
	lsr
	lsr
	lsr
	lsr
	and	#<$1
	pha
	dey
L20768:
	dey
	bra	L20451
L10154:
	ldy	#$23
	lda	[<L162+c_0],Y
	lsr
	lsr
	lsr
	lsr
	and	#<$1
	pha
	bra	L20768
L10155:
	ldy	#$23
	lda	[<L162+c_0],Y
	lsr
	lsr
	lsr
	lsr
	and	#<$1
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_hl
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_rb
	brl	L20511
L10156:
	ldy	#$23
	lda	[<L162+c_0],Y
	lsr
	lsr
	lsr
	lsr
	and	#<$1
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_byte
	brl	L20511
L10157:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_bc
L20524:
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_dad
	brl	L216
L10158:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_de
	bra	L20524
L10159:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_hl
	bra	L20524
L10160:
	ldy	#$1a
	lda	[<L162+c_0],Y
	bra	L20524
L10161:
	ldy	#$23
	lda	[<L162+c_0],Y
	and	#<$ffffffdf
L20531:
	ldy	#$23
	brl	L20114
L10162:
	ldy	#$23
	lda	[<L162+c_0],Y
	ora	#<$20
	sta	[<L162+c_0],Y
	sep	#$20
	longa	off
	lda	#$1
	ldy	#$26
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10164:
	ldy	#$23
	lda	[<L162+c_0],Y
	ora	#<$40
	bra	L20531
L10165:
	ldy	#$1c
	lda	[<L162+c_0],Y
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_inr
	sep	#$20
	longa	off
	ldy	#$1c
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10166:
	ldy	#$1d
	lda	[<L162+c_0],Y
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_inr
	sep	#$20
	longa	off
	ldy	#$1d
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10167:
	ldy	#$1e
	lda	[<L162+c_0],Y
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_inr
	sep	#$20
	longa	off
	ldy	#$1e
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10168:
	ldy	#$1f
	lda	[<L162+c_0],Y
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_inr
	sep	#$20
	longa	off
	ldy	#$1f
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10169:
	ldy	#$20
	lda	[<L162+c_0],Y
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_inr
	sep	#$20
	longa	off
	ldy	#$20
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10170:
	ldy	#$21
	lda	[<L162+c_0],Y
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_inr
	sep	#$20
	longa	off
	ldy	#$21
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10171:
	ldy	#$22
	lda	[<L162+c_0],Y
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_inr
	sep	#$20
	longa	off
	ldy	#$22
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10172:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_hl
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_rb
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_inr
	brl	L20056
L10173:
	ldy	#$1c
	lda	[<L162+c_0],Y
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_dcr
	sep	#$20
	longa	off
	ldy	#$1c
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10174:
	ldy	#$1d
	lda	[<L162+c_0],Y
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_dcr
	sep	#$20
	longa	off
	ldy	#$1d
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10175:
	ldy	#$1e
	lda	[<L162+c_0],Y
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_dcr
	sep	#$20
	longa	off
	ldy	#$1e
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10176:
	ldy	#$1f
	lda	[<L162+c_0],Y
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_dcr
	sep	#$20
	longa	off
	ldy	#$1f
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10177:
	ldy	#$20
	lda	[<L162+c_0],Y
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_dcr
	sep	#$20
	longa	off
	ldy	#$20
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10178:
	ldy	#$21
	lda	[<L162+c_0],Y
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_dcr
	sep	#$20
	longa	off
	ldy	#$21
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10179:
	ldy	#$22
	lda	[<L162+c_0],Y
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_dcr
	sep	#$20
	longa	off
	ldy	#$22
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10180:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_hl
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_rb
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_dcr
	brl	L20056
L10181:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_bc
	ina
	brl	L20082
L10182:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_de
	ina
	brl	L20092
L10183:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_hl
	ina
	brl	L20102
L10184:
	lda	#$1a
	clc
	adc	<L162+c_0
	sta	<R0
	lda	#$0
	adc	<L162+c_0+2
	sta	<R0+2
	lda	[<R0]
	ina
L20532:
	sta	[<R0]
	brl	L216
L10185:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_bc
	clc
	adc	#$ffff
	brl	L20082
L10186:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_de
	clc
	adc	#$ffff
	brl	L20092
L10187:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_hl
	clc
	adc	#$ffff
	brl	L20102
L10188:
	lda	#$1a
	clc
	adc	<L162+c_0
	sta	<R0
	lda	#$0
	adc	<L162+c_0+2
	sta	<R0+2
	lda	#$ffff
	clc
	adc	[<R0]
	bra	L20532
L10189:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_daa
	brl	L216
L10190:
	sep	#$20
	longa	off
	ldy	#$1c
	lda	[<L162+c_0],Y
	eor	#<$ffffffff
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10191:
	ldy	#$23
	lda	[<L162+c_0],Y
	ora	#<$10
	brl	L20531
L10192:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$10
	bne	L166
	inc	<R0
L166:
	asl	<R0
	asl	<R0
	asl	<R0
	asl	<R0
	lda	<R0
	and	#<$10
	sta	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	and	#<$ffffffef
	sta	[<L162+c_0],Y
	ora	<R0
	brl	L20531
L10193:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_rlc
	brl	L216
L10194:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_rrc
	brl	L216
L10195:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_ral
	brl	L216
L10196:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_rar
	brl	L216
L10197:
	ldy	#$1c
L20537:
	lda	[<L162+c_0],Y
L20561:
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_ana
	brl	L216
L10198:
	ldy	#$1d
	bra	L20537
L10199:
	ldy	#$1e
	bra	L20537
L10200:
	ldy	#$1f
	bra	L20537
L10201:
	ldy	#$20
	bra	L20537
L10202:
	ldy	#$21
	bra	L20537
L10203:
	ldy	#$22
	bra	L20537
L10204:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_hl
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_rb
	bra	L20561
L10205:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_byte
	bra	L20561
L10206:
	ldy	#$1c
L20569:
	lda	[<L162+c_0],Y
L20593:
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_xra
	brl	L216
L10207:
	ldy	#$1d
	bra	L20569
L10208:
	ldy	#$1e
	bra	L20569
L10209:
	ldy	#$1f
	bra	L20569
L10210:
	ldy	#$20
	bra	L20569
L10211:
	ldy	#$21
	bra	L20569
L10212:
	ldy	#$22
	bra	L20569
L10213:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_hl
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_rb
	bra	L20593
L10214:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_byte
	bra	L20593
L10215:
	ldy	#$1c
L20601:
	lda	[<L162+c_0],Y
L20625:
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_ora
	brl	L216
L10216:
	ldy	#$1d
	bra	L20601
L10217:
	ldy	#$1e
	bra	L20601
L10218:
	ldy	#$1f
	bra	L20601
L10219:
	ldy	#$20
	bra	L20601
L10220:
	ldy	#$21
	bra	L20601
L10221:
	ldy	#$22
	bra	L20601
L10222:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_hl
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_rb
	bra	L20625
L10223:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_byte
	bra	L20625
L10224:
	ldy	#$1c
L20633:
	lda	[<L162+c_0],Y
L20657:
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_cmp
	brl	L216
L10225:
	ldy	#$1d
	bra	L20633
L10226:
	ldy	#$1e
	bra	L20633
L10227:
	ldy	#$1f
	bra	L20633
L10228:
	ldy	#$20
	bra	L20633
L10229:
	ldy	#$21
	bra	L20633
L10230:
	ldy	#$22
	bra	L20633
L10231:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_hl
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_rb
	bra	L20657
L10232:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_byte
	bra	L20657
L10233:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_word
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_jmp
	brl	L216
L10234:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$2
L20764:
	bne	L168
L20761:
	inc	<R0
L168:
	pei	<R0
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_cond_jmp
	brl	L216
L10235:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$2
L20769:
	beq	L168
	bra	L20761
L10236:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$10
	bra	L20764
L10237:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$10
	bra	L20769
L10238:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$8
	bra	L20764
L10239:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$8
	bra	L20769
L10240:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$1
	bra	L20764
L10241:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$1
	bra	L20769
L10242:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_hl
	ldy	#$18
	brl	L20114
L10243:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_word
	pha
L20690:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_call
	brl	L216
L10244:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$2
L20765:
	bne	L184
L20762:
	inc	<R0
L184:
	pei	<R0
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_cond_call
	brl	L216
L10245:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$2
L20770:
	beq	L184
	bra	L20762
L10246:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$10
	bra	L20765
L10247:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$10
	bra	L20770
L10248:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$8
	bra	L20765
L10249:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$8
	bra	L20770
L10250:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$1
	bra	L20765
L10251:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$1
	bra	L20770
L10252:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_ret
	brl	L216
L10253:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$2
L20766:
	bne	L200
L20763:
	inc	<R0
L200:
	pei	<R0
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_cond_ret
	brl	L216
L10254:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$2
L20771:
	beq	L200
	bra	L20763
L10255:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$10
	bra	L20766
L10256:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$10
	bra	L20771
L10257:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$8
	bra	L20766
L10258:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$8
	bra	L20771
L10259:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$1
	bra	L20766
L10260:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$1
	bra	L20771
L10261:
	pea	#<$0
	brl	L20690
L10262:
	pea	#<$8
	brl	L20690
L10263:
	pea	#<$10
	brl	L20690
L10264:
	pea	#<$18
	brl	L20690
L10265:
	pea	#<$20
	brl	L20690
L10266:
	pea	#<$28
	brl	L20690
L10267:
	pea	#<$30
	brl	L20690
L10268:
	pea	#<$38
	brl	L20690
L10269:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_bc
L20757:
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_push_stack
	brl	L216
L10270:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_de
	bra	L20757
L10271:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_hl
	bra	L20757
L10272:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_push_psw
	brl	L216
L10273:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_pop_stack
	brl	L20082
L10274:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_pop_stack
	brl	L20092
L10275:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_pop_stack
	brl	L20102
L10276:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_pop_psw
	brl	L216
L10277:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_byte
	pha
	ldy	#$12
	lda	[<L162+c_0],Y
	pha
	dey
	dey
	lda	[<L162+c_0],Y
	pha
	ldy	#$a
	lda	[<L162+c_0],Y
	tax
	dey
	dey
	lda	[<L162+c_0],Y
	xref	~~~lcal
	jsl	~~~lcal
	sep	#$20
	longa	off
	ldy	#$1c
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L216
L10278:
	ldy	#$1c
	lda	[<L162+c_0],Y
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_byte
	pha
	ldy	#$12
	lda	[<L162+c_0],Y
	pha
	dey
	dey
	lda	[<L162+c_0],Y
	pha
	dey
	dey
	lda	[<L162+c_0],Y
	tax
	dey
	dey
	lda	[<L162+c_0],Y
	xref	~~~lcal
	jsl	~~~lcal
	brl	L216
L162	equ	12
L163	equ	13
	ends
	efunc
	code
	xdef	~~i8080_init
	func
~~i8080_init:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L217
	tcs
	phd
	tcd
c_0	set	4
	lda	#$0
	sta	[<L217+c_0]
	ldy	#$2
	sta	[<L217+c_0],Y
	iny
	iny
	sta	[<L217+c_0],Y
	iny
	iny
	sta	[<L217+c_0],Y
	iny
	iny
	sta	[<L217+c_0],Y
	iny
	iny
	sta	[<L217+c_0],Y
	iny
	iny
	sta	[<L217+c_0],Y
	iny
	iny
	sta	[<L217+c_0],Y
	iny
	iny
	sta	[<L217+c_0],Y
	iny
	iny
	sta	[<L217+c_0],Y
	iny
	iny
	sta	[<L217+c_0],Y
	iny
	iny
	sta	[<L217+c_0],Y
	iny
	iny
	sta	[<L217+c_0],Y
	iny
	iny
	sta	[<L217+c_0],Y
	sep	#$20
	longa	off
	lda	#$0
	iny
	iny
	sta	[<L217+c_0],Y
	iny
	sta	[<L217+c_0],Y
	iny
	sta	[<L217+c_0],Y
	iny
	sta	[<L217+c_0],Y
	iny
	sta	[<L217+c_0],Y
	iny
	sta	[<L217+c_0],Y
	iny
	sta	[<L217+c_0],Y
	rep	#$20
	longa	on
	iny
	lda	[<L217+c_0],Y
	and	#<$fffffffe
	and	#<$fffffffd
	and	#<$fffffffb
	and	#<$fffffff7
	and	#<$ffffffef
	and	#<$ffffffdf
	and	#<$ffffffbf
	and	#<$ffffff7f
	sta	[<L217+c_0],Y
	sep	#$20
	longa	off
	lda	#$0
	iny
	iny
	sta	[<L217+c_0],Y
	iny
	sta	[<L217+c_0],Y
	rep	#$20
	longa	on
	lda	<L217+2
	sta	<L217+2+4
	lda	<L217+1
	sta	<L217+1+4
	pld
	tsc
	clc
	adc	#L217+4
	tcs
	rtl
L217	equ	0
L218	equ	1
	ends
	efunc
	code
	xdef	~~i8080_step
	func
~~i8080_step:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L220
	tcs
	phd
	tcd
c_0	set	4
	ldy	#$23
	lda	[<L220+c_0],Y
	bit	#$80
	beq	L10291
	lda	[<L220+c_0],Y
	bit	#$20
	beq	L10291
	ldy	#$26
	lda	[<L220+c_0],Y
	and	#$ff
	bne	L10291
	ldy	#$23
	lda	[<L220+c_0],Y
	and	#<$ffffff7f
	and	#<$ffffffdf
	and	#<$ffffffbf
	sta	[<L220+c_0],Y
	iny
	iny
	lda	[<L220+c_0],Y
	bra	L20775
L10291:
	ldy	#$23
	lda	[<L220+c_0],Y
	bit	#$40
	bne	L226
	pei	<L220+c_0+2
	pei	<L220+c_0
	jsl	~~i8080_next_byte
L20775:
	pha
	pei	<L220+c_0+2
	pei	<L220+c_0
	jsl	~~i8080_execute
L226:
	lda	<L220+2
	sta	<L220+2+4
	lda	<L220+1
	sta	<L220+1+4
	pld
	tsc
	clc
	adc	#L220+4
	tcs
	rtl
L220	equ	0
L221	equ	1
	ends
	efunc
	code
	xdef	~~i8080_interrupt
	func
~~i8080_interrupt:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L227
	tcs
	phd
	tcd
c_0	set	4
opcode_0	set	8
	ldy	#$23
	lda	[<L227+c_0],Y
	ora	#<$80
	sta	[<L227+c_0],Y
	sep	#$20
	longa	off
	lda	<L227+opcode_0
	iny
	iny
	sta	[<L227+c_0],Y
	rep	#$20
	longa	on
	lda	<L227+2
	sta	<L227+2+6
	lda	<L227+1
	sta	<L227+1+6
	pld
	tsc
	clc
	adc	#L227+6
	tcs
	rtl
L227	equ	0
L228	equ	1
	ends
	efunc
	code
	xdef	~~i8080_debug_output
	func
~~i8080_debug_output:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L230
	tcs
	phd
	tcd
c_0	set	4
print_disassembly_0	set	8
f_1	set	0
	sep	#$20
	longa	off
	stz	<L231+f_1
	rep	#$20
	longa	on
	ldy	#$23
	lda	[<L230+c_0],Y
	and	#<$1
	ldx	#<$7
	xref	~~~casl
	jsl	~~~casl
	sep	#$20
	longa	off
	tsb	<L231+f_1
	rep	#$20
	longa	on
	ldy	#$23
	lda	[<L230+c_0],Y
	lsr
	and	#<$1
	ldx	#<$6
	xref	~~~casl
	jsl	~~~casl
	sep	#$20
	longa	off
	tsb	<L231+f_1
	rep	#$20
	longa	on
	ldy	#$23
	lda	[<L230+c_0],Y
	lsr
	lsr
	and	#<$1
	sep	#$20
	longa	off
	asl	A
	asl	A
	asl	A
	asl	A
	tsb	<L231+f_1
	rep	#$20
	longa	on
	lda	[<L230+c_0],Y
	lsr
	lsr
	lsr
	and	#<$1
	sep	#$20
	longa	off
	asl	A
	asl	A
	tsb	<L231+f_1
	lda	#$2
	tsb	<L231+f_1
	rep	#$20
	longa	on
	lda	[<L230+c_0],Y
	lsr
	lsr
	lsr
	lsr
	and	#<$1
	sep	#$20
	longa	off
	tsb	<L231+f_1
	rep	#$20
	longa	on
	ldy	#$1a
	lda	[<L230+c_0],Y
	pha
	pei	<L230+c_0+2
	pei	<L230+c_0
	jsl	~~i8080_get_hl
	pha
	pei	<L230+c_0+2
	pei	<L230+c_0
	jsl	~~i8080_get_de
	pha
	pei	<L230+c_0+2
	pei	<L230+c_0
	jsl	~~i8080_get_bc
	pha
	ldy	#$1c
	lda	[<L230+c_0],Y
	and	#$ff
	xba
	and	#$ff00
	sta	<R0
	lda	<L231+f_1
	and	#$ff
	ora	<R0
	pha
	ldy	#$18
	lda	[<L230+c_0],Y
	pha
	pea	#^L1
	pea	#<L1
	pea	#18
	jsl	~~printf
	clc
	lda	#$3
	ldy	#$18
	adc	[<L230+c_0],Y
	pha
	pei	<L230+c_0+2
	pei	<L230+c_0
	jsl	~~i8080_rb
	sep	#$20
	longa	off
	sta	<R0
	rep	#$20
	longa	on
	lda	<R0
	and	#$ff
	pha
	clc
	lda	#$2
	ldy	#$18
	adc	[<L230+c_0],Y
	pha
	pei	<L230+c_0+2
	pei	<L230+c_0
	jsl	~~i8080_rb
	sep	#$20
	longa	off
	sta	<R0
	rep	#$20
	longa	on
	lda	<R0
	and	#$ff
	pha
	ldy	#$18
	lda	[<L230+c_0],Y
	ina
	pha
	pei	<L230+c_0+2
	pei	<L230+c_0
	jsl	~~i8080_rb
	sep	#$20
	longa	off
	sta	<R0
	rep	#$20
	longa	on
	lda	<R0
	and	#$ff
	pha
	ldy	#$18
	lda	[<L230+c_0],Y
	pha
	pei	<L230+c_0+2
	pei	<L230+c_0
	jsl	~~i8080_rb
	sep	#$20
	longa	off
	sta	<R0
	rep	#$20
	longa	on
	lda	<R0
	and	#$ff
	pha
	pea	#^L1+59
	pea	#<L1+59
	pea	#14
	jsl	~~printf
	pea	#^L1+82
	pea	#<L1+82
	pea	#6
	jsl	~~printf
	lda	<L230+2
	sta	<L230+2+6
	lda	<L230+1
	sta	<L230+1+6
	pld
	tsc
	clc
	adc	#L230+6
	tcs
	rtl
L230	equ	9
L231	equ	9
	ends
	efunc
	data
L1:
	db	$50,$43,$3A,$20,$25,$30,$34,$58,$2C,$20,$41,$46,$3A,$20,$25
	db	$30,$34,$58,$2C,$20,$42,$43,$3A,$20,$25,$30,$34,$58,$2C,$20
	db	$44,$45,$3A,$20,$25,$30,$34,$58,$2C,$20,$48,$4C,$3A,$20,$25
	db	$30,$34,$58,$2C,$20,$53,$50,$3A,$20,$25,$30,$34,$58,$00,$20
	db	$28,$25,$30,$32,$58,$20,$25,$30,$32,$58,$20,$25,$30,$32,$58
	db	$20,$25,$30,$32,$58,$29,$00,$0A,$00
	ends
;
;uint16_t z80(char *memory, uint16_t pc, int debug, void *, uint8_t*);
;
;static uint8_t rb(void* userdata, uint16_t addr) {
	code
	func
~~rb:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L234
	tcs
	phd
	tcd
userdata_0	set	4
addr_0	set	8
;  return memory[addr];
	lda	|~~memory
	sta	<R0
	lda	|~~memory+2
	sta	<R0+2
	ldy	<L234+addr_0
	lda	[<R0],Y
	and	#$ff
	tay
	lda	<L234+2
	sta	<L234+2+6
	lda	<L234+1
	sta	<L234+1+6
	pld
	tsc
	clc
	adc	#L234+6
	tcs
	tya
	rtl
;}
L234	equ	4
L235	equ	5
	ends
	efunc
;
;static void wb(void* userdata, uint16_t addr, uint8_t val) {
	code
	func
~~wb:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L237
	tcs
	phd
	tcd
userdata_0	set	4
addr_0	set	8
val_0	set	10
;  memory[addr] = val;
	lda	|~~memory
	sta	<R0
	lda	|~~memory+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	<L237+val_0
	ldy	<L237+addr_0
	sta	[<R0],Y
	rep	#$20
	longa	on
;}
	lda	<L237+2
	sta	<L237+2+8
	lda	<L237+1
	sta	<L237+1+8
	pld
	tsc
	clc
	adc	#L237+8
	tcs
	rtl
L237	equ	4
L238	equ	5
	ends
	efunc
;
;#define TRACK 0xFA33
;
;static uint8_t port_in(void* userdata, uint8_t port) {
	code
	func
~~port_in:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L240
	tcs
	phd
	tcd
userdata_0	set	4
port_0	set	8
;	
;	uint8_t *srcp, *dstp;
;	uint16_t trk, sec, dma, dsk;
;	uint32_t diskoff;
;	
;	if (debug) debugf("port_in $%02X\n", (long)port);
srcp_1	set	0
dstp_1	set	4
trk_1	set	8
sec_1	set	10
dma_1	set	12
dsk_1	set	14
diskoff_1	set	16
	lda	|~~debug
	beq	L10294
	lda	<L240+port_0
	and	#$ff
	sta	<R0
	stz	<R0+2
	pei	<R0+2
	pei	<R0
	pea	#^L233
	pea	#<L233
	pea	#10
	jsl	~~debugf
;	
;	
;	switch (port) {
L10294:
	lda	<L240+port_0
	and	#$ff
	xref	~~~swt
	jsl	~~~swt
	dw	2
	dw	1
	dw	L10297-1
	dw	2
	dw	L10298-1
	dw	L10299-1
;	case 1:
L10297:
;		return getchar();
	lda	|~~stdin+2
	pha
	lda	|~~stdin
	pha
	jsl	~~fgetc
	and	#$ff
L243:
	tay
	lda	<L240+2
	sta	<L240+2+6
	lda	<L240+1
	sta	<L240+1+6
	pld
	tsc
	clc
	adc	#L240+6
	tcs
	tya
	rtl
;		break;
;	case 2:
L10298:
;	
;		srcp = *(uint16_t *)(memory + TRACK) + memory;
	lda	#$fa33
	clc
	adc	|~~memory
	sta	<R0
	lda	#$0
	adc	|~~memory+2
	sta	<R0+2
	lda	[<R0]
	sta	<R0
	stz	<R0+2
	lda	|~~memory
	clc
	adc	<R0
	sta	<L241+srcp_1
	lda	|~~memory+2
	adc	<R0+2
	sta	<L241+srcp_1+2
;		trk = *(uint16_t *)srcp;
	lda	[<L241+srcp_1]
	sta	<L241+trk_1
;		sec = *(uint16_t *)(srcp + 2);
	ldy	#$2
	lda	[<L241+srcp_1],Y
	sta	<L241+sec_1
;		dma = *(uint16_t *)(srcp + 4);
	iny
	iny
	lda	[<L241+srcp_1],Y
	sta	<L241+dma_1
;		dsk = *(srcp + 6);
	iny
	iny
	lda	[<L241+srcp_1],Y
	and	#$ff
	sta	<L241+dsk_1
;		
;		//if (debug) 
;			debugf("read disk:%d track:%d sec:%d dma:%04X\n", (long)dsk, (long)trk, (long)sec, (long)dma);
	lda	<L241+dma_1
	sta	<R0
	stz	<R0+2
	pei	<R0+2
	pei	<R0
	lda	<L241+sec_1
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	lda	<L241+trk_1
	sta	<R2
	stz	<R2+2
	pei	<R2+2
	pei	<R2
	lda	<L241+dsk_1
	sta	<R3
	stz	<R3+2
	pei	<R3+2
	pei	<R3
	pea	#^L233+15
	pea	#<L233+15
	pea	#22
	jsl	~~debugf
;		
;		diskoff = (uint32_t)(trk * 26 + sec) << 7;
	lda	<L241+trk_1
	ldx	#<$1a
	xref	~~~mul
	jsl	~~~mul
	clc
	adc	<L241+sec_1
	sta	<R0
	stz	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$7
	xref	~~~lasl
	jsl	~~~lasl
	sta	<L241+diskoff_1
	stx	<L241+diskoff_1+2
;		srcp = disk + diskoff;
	lda	|~~disk
	clc
	adc	<L241+diskoff_1
	sta	<L241+srcp_1
	lda	|~~disk+2
	adc	<L241+diskoff_1+2
	sta	<L241+srcp_1+2
;		dstp = memory + dma;
	lda	<L241+dma_1
	sta	<R0
	stz	<R0+2
	lda	|~~memory
	clc
	adc	<R0
	sta	<L241+dstp_1
	lda	|~~memory+2
	adc	<R0+2
	sta	<L241+dstp_1+2
;		
;		memcpy(dstp, srcp, 128);
	pea	#^$80
	pea	#<$80
	pei	<L241+srcp_1+2
	pei	<L241+srcp_1
	pei	<L241+dstp_1+2
	pei	<L241+dstp_1
	jsl	~~memcpy
;		//fall through
;	default:
L10299:
;		return 0x00;
	lda	#$0
	brl	L243
;	}
;}
L240	equ	36
L241	equ	17
	ends
	efunc
	data
L233:
	db	$70,$6F,$72,$74,$5F,$69,$6E,$20,$24,$25,$30,$32,$58,$0A,$00
	db	$72,$65,$61,$64,$20,$64,$69,$73,$6B,$3A,$25,$64,$20,$74,$72
	db	$61,$63,$6B,$3A,$25,$64,$20,$73,$65,$63,$3A,$25,$64,$20,$64
	db	$6D,$61,$3A,$25,$30,$34,$58,$0A,$00
	ends
;
;static void cpm_port_out(void* userdata, uint8_t port, uint8_t value) {
	code
	func
~~cpm_port_out:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L245
	tcs
	phd
	tcd
userdata_0	set	4
port_0	set	8
value_0	set	10
;	uint8_t *srcp, *dstp;
;	uint16_t trk, sec, dma, dsk;
;	uint32_t diskoff;
;	i8080* const c = (i8080*) userdata;
;	
;	
;	if (debug) debugf("port_out $%02X, data %02X, PC: %04X\n", (long)port, (long)value, (long)c->pc);
srcp_1	set	0
dstp_1	set	4
trk_1	set	8
sec_1	set	10
dma_1	set	12
dsk_1	set	14
diskoff_1	set	16
c_1	set	20
	lda	<L245+userdata_0
	sta	<L246+c_1
	lda	<L245+userdata_0+2
	sta	<L246+c_1+2
	lda	|~~debug
	beq	L10300
	ldy	#$18
	lda	[<L246+c_1],Y
	sta	<R0
	stz	<R0+2
	pei	<R0+2
	pei	<R0
	lda	<L245+value_0
	and	#$ff
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	lda	<L245+port_0
	and	#$ff
	sta	<R2
	stz	<R2+2
	pei	<R2+2
	pei	<R2
	pea	#^L244
	pea	#<L244
	pea	#18
	jsl	~~debugf
;	
;	switch (port) {
L10300:
	lda	<L245+port_0
	and	#$ff
	xref	~~~swt
	jsl	~~~swt
	dw	4
	dw	0
	dw	L251-1
	dw	1
	dw	L10304-1
	dw	2
	dw	L10306-1
	dw	255
	dw	L10308-1
	dw	L251-1
;	case 0:
;		break;
;	case 1:
L10304:
;		if (value != 0x0d && value != 0x07) printf("%c", value);
	sep	#$20
	longa	off
	lda	<L245+value_0
	cmp	#<$d
	rep	#$20
	longa	on
	beq	L251
	sep	#$20
	longa	off
	lda	<L245+value_0
	cmp	#<$7
	rep	#$20
	longa	on
	beq	L251
	lda	<L245+value_0
	and	#$ff
	pha
	pea	#^L244+37
	pea	#<L244+37
	pea	#8
	jsl	~~printf
;	//fflush(stdout);
;		break;
L251:
	lda	<L245+2
	sta	<L245+2+8
	lda	<L245+1
	sta	<L245+1+8
	pld
	tsc
	clc
	adc	#L245+8
	tcs
	rtl
;	case 2:
L10306:
;		srcp = *(uint16_t *)(memory + TRACK) + memory;
	lda	#$fa33
	clc
	adc	|~~memory
	sta	<R0
	lda	#$0
	adc	|~~memory+2
	sta	<R0+2
	lda	[<R0]
	sta	<R0
	stz	<R0+2
	lda	|~~memory
	clc
	adc	<R0
	sta	<L246+srcp_1
	lda	|~~memory+2
	adc	<R0+2
	sta	<L246+srcp_1+2
;		trk = *(uint16_t *)srcp;
	lda	[<L246+srcp_1]
	sta	<L246+trk_1
;		sec = *(uint16_t *)(srcp + 2);
	ldy	#$2
	lda	[<L246+srcp_1],Y
	sta	<L246+sec_1
;		dma = *(uint16_t *)(srcp + 4);
	iny
	iny
	lda	[<L246+srcp_1],Y
	sta	<L246+dma_1
;		dsk = *(srcp + 6);
	iny
	iny
	lda	[<L246+srcp_1],Y
	and	#$ff
	sta	<L246+dsk_1
;		
;		if (debug) debugf("read write:%d track:%d sec:%d dma:%04X\n", (long)dsk, (long)trk, (long)sec, (long)dma);
	lda	|~~debug
	beq	L10307
	lda	<L246+dma_1
	sta	<R0
	stz	<R0+2
	pei	<R0+2
	pei	<R0
	lda	<L246+sec_1
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	lda	<L246+trk_1
	sta	<R2
	stz	<R2+2
	pei	<R2+2
	pei	<R2
	lda	<L246+dsk_1
	sta	<R3
	stz	<R3+2
	pei	<R3+2
	pei	<R3
	pea	#^L244+40
	pea	#<L244+40
	pea	#22
	jsl	~~debugf
;		
;		diskoff = (uint32_t)(trk * 26 + sec) << 7;
L10307:
	lda	<L246+trk_1
	ldx	#<$1a
	xref	~~~mul
	jsl	~~~mul
	clc
	adc	<L246+sec_1
	sta	<R0
	stz	<R0+2
	pei	<R0+2
	pei	<R0
	lda	#$7
	xref	~~~lasl
	jsl	~~~lasl
	sta	<L246+diskoff_1
	stx	<L246+diskoff_1+2
;		dstp = disk + diskoff;
	lda	|~~disk
	clc
	adc	<L246+diskoff_1
	sta	<L246+dstp_1
	lda	|~~disk+2
	adc	<L246+diskoff_1+2
	sta	<L246+dstp_1+2
;		srcp = memory + dma;
	lda	<L246+dma_1
	sta	<R0
	stz	<R0+2
	lda	|~~memory
	clc
	adc	<R0
	sta	<L246+srcp_1
	lda	|~~memory+2
	adc	<R0+2
	sta	<L246+srcp_1+2
;		
;		memcpy(dstp, srcp, 128);
	pea	#^$80
	pea	#<$80
	pei	<L246+srcp_1+2
	pei	<L246+srcp_1
	pei	<L246+dstp_1+2
	pei	<L246+dstp_1
	jsl	~~memcpy
;		break;
	brl	L251
;	case 0xff:
L10308:
;	//printf("exit called\n");
;		test_finished = 1;
	lda	#$1
	sta	|~~test_finished
;		break;
	brl	L251
;	default:
;		break;
;	}
;}
L245	equ	40
L246	equ	17
	ends
	efunc
	data
L244:
	db	$70,$6F,$72,$74,$5F,$6F,$75,$74,$20,$24,$25,$30,$32,$58,$2C
	db	$20,$64,$61,$74,$61,$20,$25,$30,$32,$58,$2C,$20,$50,$43,$3A
	db	$20,$25,$30,$34,$58,$0A,$00,$25,$63,$00,$72,$65,$61,$64,$20
	db	$77,$72,$69,$74,$65,$3A,$25,$64,$20,$74,$72,$61,$63,$6B,$3A
	db	$25,$64,$20,$73,$65,$63,$3A,$25,$64,$20,$64,$6D,$61,$3A,$25
	db	$30,$34,$58,$0A,$00
	ends
;
;static void port_out(void* userdata, uint8_t port, uint8_t value) {
	code
	func
~~port_out:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L253
	tcs
	phd
	tcd
userdata_0	set	4
port_0	set	8
value_0	set	10
;  i8080* const c = (i8080*) userdata;
;
;  if (port == 0) {
c_1	set	0
	lda	<L253+userdata_0
	sta	<L254+c_1
	lda	<L253+userdata_0+2
	sta	<L254+c_1+2
	lda	<L253+port_0
	and	#$ff
	bne	L10310
;    test_finished = 1;
	lda	#$1
	sta	|~~test_finished
;  } else if (port == 1) {
L10311:
	lda	|~~stdout+2
	pha
	lda	|~~stdout
	pha
	jsl	~~fflush
;}
	lda	<L253+2
	sta	<L253+2+8
	lda	<L253+1
	sta	<L253+1+8
	pld
	tsc
	clc
	adc	#L253+8
	tcs
	rtl
L10310:
	sep	#$20
	longa	off
	lda	<L253+port_0
	cmp	#<$1
	rep	#$20
	longa	on
	bne	L10311
;    uint8_t operation = c->c;
;
;    if (operation == 2) { // print a character stored in E
operation_2	set	4
	sep	#$20
	longa	off
	ldy	#$1e
	lda	[<L254+c_1],Y
	sta	<L254+operation_2
	cmp	#<$2
	rep	#$20
	longa	on
	bne	L10313
;      printf("%c", c->e);
	iny
	iny
	lda	[<L254+c_1],Y
	and	#$ff
	pha
	pea	#^L252
	pea	#<L252
	pea	#8
	jsl	~~printf
;    } else if (operation == 9) { // print from memory at (DE) until '$' char
	bra	L10311
L10313:
	sep	#$20
	longa	off
	lda	<L254+operation_2
	cmp	#<$9
	rep	#$20
	longa	on
	bne	L10311
;      uint16_t addr = (c->d << 8) | c->e;
;      do {
addr_3	set	5
	ldy	#$1f
	lda	[<L254+c_1],Y
	and	#$ff
	xba
	and	#$ff00
	sta	<R0
	iny
	lda	[<L254+c_1],Y
	and	#$ff
	ora	<R0
	sta	<L254+addr_3
L10318:
;        printf("%c", rb(c, addr++));
	lda	<L254+addr_3
	sta	<R0
	inc	<L254+addr_3
	pei	<R0
	pei	<L254+c_1+2
	pei	<L254+c_1
	jsl	~~rb
	sep	#$20
	longa	off
	sta	<R1
	rep	#$20
	longa	on
	lda	<R1
	and	#$ff
	pha
	pea	#^L252+3
	pea	#<L252+3
	pea	#8
	jsl	~~printf
;      } while (rb(c, addr) != '$');
	pei	<L254+addr_3
	pei	<L254+c_1+2
	pei	<L254+c_1
	jsl	~~rb
	sep	#$20
	longa	off
	cmp	#<$24
	rep	#$20
	longa	on
	bne	L10318
	brl	L10311
;    }
;  }
;  fflush(stdout);
L253	equ	15
L254	equ	9
	ends
	efunc
	data
L252:
	db	$25,$63,$00,$25,$63,$00
	ends
;
;uint8_t *load_disk(const char* filename) {
	code
	xdef	~~load_disk
	func
~~load_disk:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L262
	tcs
	phd
	tcd
filename_0	set	4
;  FILE* f;
;  
;  printf("loading disk: %s ", filename);
f_1	set	0
	pei	<L262+filename_0+2
	pei	<L262+filename_0
	pea	#^L261
	pea	#<L261
	pea	#10
	jsl	~~printf
;  f = fopen(filename, "rb");
	pea	#^L261+18
	pea	#<L261+18
	pei	<L262+filename_0+2
	pei	<L262+filename_0
	jsl	~~fopen
	sta	<L263+f_1
	stx	<L263+f_1+2
;  if (f == NULL) {
	ora	<L263+f_1+2
	bne	L10319
;    printf("error: can't open file '%s'.\n", filename);
	pei	<L262+filename_0+2
	pei	<L262+filename_0
	pea	#^L261+21
	pea	#<L261+21
	pea	#10
L20779:
	jsl	~~printf
;    return NULL;
	lda	#$0
	tax
L265:
	tay
	lda	<L262+2
	sta	<L262+2+4
	lda	<L262+1
	sta	<L262+1+4
	pld
	tsc
	clc
	adc	#L262+4
	tcs
	tya
	rtl
;  }
;
;  disk = (uint8_t *)malloc(DISK_SIZE);
L10319:
	pea	#^$3e900
	pea	#<$3e900
	jsl	~~malloc
	sta	|~~disk
	stx	|~~disk+2
;  if (!disk) {
	ora	|~~disk+2
	bne	L10320
;    printf("can't alloc disk memory\n");
	pea	#^L261+51
	pea	#<L261+51
	pea	#6
	bra	L20779
;	return NULL;
;  }
;  
;  disk_size = read(fileno(f), disk, 0xffffff);
L10320:
	pea	#^$ffffff
	pea	#<$ffffff
	lda	|~~disk+2
	pha
	lda	|~~disk
	pha
	pei	<L263+f_1+2
	pei	<L263+f_1
	jsl	~~fileno
	pha
	jsl	~~read
	sta	|~~disk_size
	stx	|~~disk_size+2
;  printf("loaded %lu bytes at %p\n", disk_size, disk); 
	lda	|~~disk+2
	pha
	lda	|~~disk
	pha
	lda	|~~disk_size+2
	pha
	lda	|~~disk_size
	pha
	pea	#^L261+76
	pea	#<L261+76
	pea	#14
	jsl	~~printf
;  fclose(f);
	pei	<L263+f_1+2
	pei	<L263+f_1
	jsl	~~fclose
;  
;  return disk;
	ldx	|~~disk+2
	lda	|~~disk
	brl	L265
;}
L262	equ	4
L263	equ	1
	ends
	efunc
	data
L261:
	db	$6C,$6F,$61,$64,$69,$6E,$67,$20,$64,$69,$73,$6B,$3A,$20,$25
	db	$73,$20,$00,$72,$62,$00,$65,$72,$72,$6F,$72,$3A,$20,$63,$61
	db	$6E,$27,$74,$20,$6F,$70,$65,$6E,$20,$66,$69,$6C,$65,$20,$27
	db	$25,$73,$27,$2E,$0A,$00,$63,$61,$6E,$27,$74,$20,$61,$6C,$6C
	db	$6F,$63,$20,$64,$69,$73,$6B,$20,$6D,$65,$6D,$6F,$72,$79,$0A
	db	$00,$6C,$6F,$61,$64,$65,$64,$20,$25,$6C,$75,$20,$62,$79,$74
	db	$65,$73,$20,$61,$74,$20,$25,$70,$0A,$00
	ends
;
;void save_disk(const char* filename) {
	code
	xdef	~~save_disk
	func
~~save_disk:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L268
	tcs
	phd
	tcd
filename_0	set	4
;  FILE* f;
;  
;  printf("saving %s size: %lu ", filename, disk_size);
f_1	set	0
	lda	|~~disk_size+2
	pha
	lda	|~~disk_size
	pha
	pei	<L268+filename_0+2
	pei	<L268+filename_0
	pea	#^L267
	pea	#<L267
	pea	#14
	jsl	~~printf
;  f = fopen(filename, "wb");
	pea	#^L267+21
	pea	#<L267+21
	pei	<L268+filename_0+2
	pei	<L268+filename_0
	jsl	~~fopen
	sta	<L269+f_1
	stx	<L269+f_1+2
;  if (f == NULL) {
	ora	<L269+f_1+2
	bne	L10321
;    printf("error: can't open file '%s'.\n", filename);
	pei	<L268+filename_0+2
	pei	<L268+filename_0
	pea	#^L267+24
	pea	#<L267+24
	pea	#10
	jsl	~~printf
;    return;
L271:
	lda	<L268+2
	sta	<L268+2+4
	lda	<L268+1
	sta	<L268+1+4
	pld
	tsc
	clc
	adc	#L268+4
	tcs
	rtl
;  }
;  
;  disk_size = fwrite(disk, 1, disk_size, f);
L10321:
	pei	<L269+f_1+2
	pei	<L269+f_1
	lda	|~~disk_size+2
	pha
	lda	|~~disk_size
	pha
	pea	#^$1
	pea	#<$1
	lda	|~~disk+2
	pha
	lda	|~~disk
	pha
	jsl	~~fwrite
	sta	|~~disk_size
	stx	|~~disk_size+2
;  
;  printf("saved %lu bytes from %p\n", disk_size, disk); 
	lda	|~~disk+2
	pha
	lda	|~~disk
	pha
	lda	|~~disk_size+2
	pha
	lda	|~~disk_size
	pha
	pea	#^L267+54
	pea	#<L267+54
	pea	#14
	jsl	~~printf
;  fclose(f);
	pei	<L269+f_1+2
	pei	<L269+f_1
	jsl	~~fclose
;  
;  return;
	bra	L271
;}
L268	equ	4
L269	equ	1
	ends
	efunc
	data
L267:
	db	$73,$61,$76,$69,$6E,$67,$20,$25,$73,$20,$73,$69,$7A,$65,$3A
	db	$20,$25,$6C,$75,$20,$00,$77,$62,$00,$65,$72,$72,$6F,$72,$3A
	db	$20,$63,$61,$6E,$27,$74,$20,$6F,$70,$65,$6E,$20,$66,$69,$6C
	db	$65,$20,$27,$25,$73,$27,$2E,$0A,$00,$73,$61,$76,$65,$64,$20
	db	$25,$6C,$75,$20,$62,$79,$74,$65,$73,$20,$66,$72,$6F,$6D,$20
	db	$25,$70,$0A,$00
	ends
;
;
;int load_file(const char* filename, uint16_t addr) {
	code
	xdef	~~load_file
	func
~~load_file:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L273
	tcs
	phd
	tcd
filename_0	set	4
addr_0	set	8
;  size_t result;
;  FILE* f;
;  size_t file_size;
;  
;  printf("loading file: %s %04X\n", filename, addr);
result_1	set	0
f_1	set	4
file_size_1	set	8
	pei	<L273+addr_0
	pei	<L273+filename_0+2
	pei	<L273+filename_0
	pea	#^L272
	pea	#<L272
	pea	#12
	jsl	~~printf
;  
;  f = fopen(filename, "rb");
	pea	#^L272+23
	pea	#<L272+23
	pei	<L273+filename_0+2
	pei	<L273+filename_0
	jsl	~~fopen
	sta	<L274+f_1
	stx	<L274+f_1+2
;  if (f == NULL) {
	ora	<L274+f_1+2
	bne	L10322
;    fprintf(stderr, "error: can't open file '%s'.\n", filename);
	pei	<L273+filename_0+2
	pei	<L273+filename_0
	pea	#^L272+26
	pea	#<L272+26
	lda	|~~stderr+2
	pha
	lda	|~~stderr
	pha
	pea	#14
	jsl	~~fprintf
;    return 1;
	lda	#$1
L276:
	tay
	lda	<L273+2
	sta	<L273+2+6
	lda	<L273+1
	sta	<L273+1+6
	pld
	tsc
	clc
	adc	#L273+6
	tcs
	tya
	rtl
;  }
;
;  result = read(fileno(f), &memory[addr], 0x10000);
L10322:
	pea	#^$10000
	pea	#<$10000
	lda	<L273+addr_0
	sta	<R0
	stz	<R0+2
	lda	|~~memory
	clc
	adc	<R0
	sta	<R1
	lda	|~~memory+2
	adc	<R0+2
	pha
	pei	<R1
	pei	<L274+f_1+2
	pei	<L274+f_1
	jsl	~~fileno
	pha
	jsl	~~read
	sta	<L274+result_1
	stx	<L274+result_1+2
;
;  //result = fread(&memory[addr], sizeof(uint8_t), 0xffff/*file_size*/, f);
;
;  printf("loaded %lu bytes at %p\n", result, &memory[addr]); 
	lda	<L273+addr_0
	sta	<R0
	stz	<R0+2
	lda	|~~memory
	clc
	adc	<R0
	sta	<R1
	lda	|~~memory+2
	adc	<R0+2
	pha
	pei	<R1
	pei	<L274+result_1+2
	pei	<L274+result_1
	pea	#^L272+56
	pea	#<L272+56
	pea	#14
	jsl	~~printf
;  fclose(f);
	pei	<L274+f_1+2
	pei	<L274+f_1
	jsl	~~fclose
;  
;  return 0;
	lda	#$0
	bra	L276
;}
L273	equ	20
L274	equ	9
	ends
	efunc
	data
L272:
	db	$6C,$6F,$61,$64,$69,$6E,$67,$20,$66,$69,$6C,$65,$3A,$20,$25
	db	$73,$20,$25,$30,$34,$58,$0A,$00,$72,$62,$00,$65,$72,$72,$6F
	db	$72,$3A,$20,$63,$61,$6E,$27,$74,$20,$6F,$70,$65,$6E,$20,$66
	db	$69,$6C,$65,$20,$27,$25,$73,$27,$2E,$0A,$00,$6C,$6F,$61,$64
	db	$65,$64,$20,$25,$6C,$75,$20,$62,$79,$74,$65,$73,$20,$61,$74
	db	$20,$25,$70,$0A,$00
	ends
;
;void run_test(i8080* const c, const char* filename, char *diskname) {
	code
	xdef	~~run_test
	func
~~run_test:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L278
	tcs
	phd
	tcd
c_0	set	4
filename_0	set	8
diskname_0	set	12
;
;  void *daatab;
;  
;  //long nb_instructions;		
;  //long diff;
;  
;  //printf("r_t 1\n");
;  
;  i8080_init(c);
daatab_1	set	0
	pei	<L278+c_0+2
	pei	<L278+c_0
	jsl	~~i8080_init
;  c->userdata = c;
	lda	<L278+c_0
	ldy	#$10
	sta	[<L278+c_0],Y
	lda	<L278+c_0+2
	iny
	iny
	sta	[<L278+c_0],Y
;  c->read_byte = rb;
	lda	#<~~rb
	sta	[<L278+c_0]
	lda	#^~~rb
	ldy	#$2
	sta	[<L278+c_0],Y
;  c->write_byte = wb;
	lda	#<~~wb
	iny
	iny
	sta	[<L278+c_0],Y
	lda	#^~~wb
	iny
	iny
	sta	[<L278+c_0],Y
;  c->port_in = port_in;
	lda	#<~~port_in
	iny
	iny
	sta	[<L278+c_0],Y
	lda	#^~~port_in
	iny
	iny
	sta	[<L278+c_0],Y
;  c->port_out = cpm_port_out;
	lda	#<~~cpm_port_out
	iny
	iny
	sta	[<L278+c_0],Y
	lda	#^~~cpm_port_out
	iny
	iny
	sta	[<L278+c_0],Y
;  
;  memset(memory, 0, MEMORY_SIZE);
	pea	#^$10000
	pea	#<$10000
	pea	#<$0
	lda	|~~memory+2
	pha
	lda	|~~memory
	pha
	jsl	~~memset
;
;  daatab = malloc(0x10000);
	pea	#^$10000
	pea	#<$10000
	jsl	~~malloc
	sta	<L279+daatab_1
	stx	<L279+daatab_1+2
;  
;  
;  if (load_file("d:cpm22.sys", 0x0000) != 0) {
	pea	#<$0
	pea	#^L277
	pea	#<L277
	jsl	~~load_file
	tax
	beq	L10323
;    return;
L281:
	lda	<L278+2
	sta	<L278+2+12
	lda	<L278+1
	sta	<L278+1+12
	pld
	tsc
	clc
	adc	#L278+12
	tcs
	rtl
;  }
;
;
;  if (load_file(filename, 0x0100) != 0) {
L10323:
	pea	#<$100
	pei	<L278+filename_0+2
	pei	<L278+filename_0
	jsl	~~load_file
	tax
	bne	L281
;    return;
;  }
;
;
;  if (load_disk(diskname) == NULL) {
	pei	<L278+diskname_0+2
	pei	<L278+diskname_0
	jsl	~~load_disk
	stx	<R0+2
	ora	<R0+2
	beq	L281
;	  return;
;  } 
;
;  c->pc = 0x0000;
	lda	#$0
	ldy	#$18
	sta	[<L278+c_0],Y
;
;  //nb_instructions = 0;
;
;  test_finished = 0;
	stz	|~~test_finished
;  debug = 0;
	stz	|~~debug
;  
;// inject "out 1,a" at 0x0005 (signal to output some characters)
;//  memory[0x0005] = 0xc3;
;//  memory[0x0006] = 0x06;
;//  memory[0x0007] = 0xec;
;//	*memory = 0x76;		//halt
; 
;  c->pc = z80(memory, c->pc, debug, daatab, disk);
	lda	|~~disk+2
	pha
	lda	|~~disk
	pha
	pei	<L279+daatab_1+2
	pei	<L279+daatab_1
	lda	|~~debug
	pha
	lda	[<L278+c_0],Y
	pha
	lda	|~~memory+2
	pha
	lda	|~~memory
	pha
	jsl	~~z80
	ldy	#$18
	sta	[<L278+c_0],Y
;
;  free(daatab);
	pei	<L279+daatab_1+2
	pei	<L279+daatab_1
	jsl	~~free
;  
;  /*
;  while (!test_finished) {
;    //nb_instructions += 1;
;
;    // uncomment following line to have a debug output of machine state
;    // warning: will output multiple GB of data for the whole test suite
;    //if (debug) i8080_debug_output(c, true);
;	
;    //i8080_step(c);
;
;	//if (c->pc == 0x0100) debug = 1; 
;  }
;  */
;/*
;  long long diff = cyc_expected - c->cyc;
;  diff = cyc_expected - c->cyc;
;  printf("\n*** %lu instructions executed on %lu cycles"
;         " (expected=%lu, diff=%lld)\n\n",
;      nb_instructions, c->cyc, cyc_expected, diff);
;*/
;
;  save_disk(diskname);
	pei	<L278+diskname_0+2
	pei	<L278+diskname_0
	jsl	~~save_disk
;  printf("*** CP/M terminated ***\n");
	pea	#^L277+12
	pea	#<L277+12
	pea	#6
	jsl	~~printf
;  
;}
	bra	L281
L278	equ	8
L279	equ	5
	ends
	efunc
	data
L277:
	db	$64,$3A,$63,$70,$6D,$32,$32,$2E,$73,$79,$73,$00,$2A,$2A,$2A
	db	$20,$43,$50,$2F,$4D,$20,$74,$65,$72,$6D,$69,$6E,$61,$74,$65
	db	$64,$20,$2A,$2A,$2A,$0A,$00
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
	sbc	#L285
	tcs
	phd
	tcd
argc_0	set	4
argv_0	set	6
;  i8080 cpu;
;  char fname[20];
;  
;  COLORBORDER = 0x49;
cpu_1	set	0
fname_1	set	39
	lda	#$49
	sta	>16776704
;  *(uint16_t *)(PALETTE + 510) = 0x38;
	lda	#$38
	sta	>16776702
;  
;  
;  if (argc > 1) {
	sec
	lda	#$1
	sbc	<L285+argc_0
	bvs	L287
	eor	#$8000
L287:
	bmi	L10326
;	  strcpy(fname, argv[1]);
	ldy	#$6
	lda	[<L285+argv_0],Y
	pha
	dey
	dey
	lda	[<L285+argv_0],Y
	pha
	bra	L20785
;  } else {
L10326:
;	  strcpy(fname, "d:disk00.dsk");
	pea	#^L284
	pea	#<L284
L20785:
	pea	#0
	clc
	tdc
	adc	#<L286+fname_1
	pha
	jsl	~~strcpy
;  }
;  
;  memory = malloc(MEMORY_SIZE);
	pea	#^$10000
	pea	#<$10000
	jsl	~~malloc
	sta	|~~memory
	stx	|~~memory+2
;  if (memory == NULL) {
	ora	|~~memory+2
	bne	L10328
;	printf("can't allocate memory!\n");
	pea	#^L284+13
	pea	#<L284+13
	pea	#6
	jsl	~~printf
;    return 1;
	lda	#$1
L290:
	tay
	lda	<L285+2
	sta	<L285+2+6
	lda	<L285+1
	sta	<L285+1+6
	pld
	tsc
	clc
	adc	#L285+6
	tcs
	tya
	rtl
;  }
;
;  
;  //run_test(&cpu, "D:CPM22.SYS", fname);
;  run_test(&cpu, "D:ZEXDOC.COM	", fname);
L10328:
	pea	#0
	clc
	tdc
	adc	#<L286+fname_1
	pha
	pea	#^L284+37
	pea	#<L284+37
	pea	#0
	clc
	tdc
	adc	#<L286+cpu_1
	pha
	jsl	~~run_test
;  //run_test(&cpu, "D:tst8080.bin", fname);
; //run_test(&cpu, "D:z80doc.com", fname);
; //run_test(&cpu, "D:prelim.rom", fname);
; 
;  free(memory);
	lda	|~~memory+2
	pha
	lda	|~~memory
	pha
	jsl	~~free
;  free(disk);
	lda	|~~disk+2
	pha
	lda	|~~disk
	pha
	jsl	~~free
;  
;  *(uint16_t *)(PALETTE + 510) = 0x1ff;
	lda	#$1ff
	sta	>16776702
;
;  return 0;
	lda	#$0
	bra	L290
;}
L285	equ	59
L286	equ	1
	ends
	efunc
	data
L284:
	db	$64,$3A,$64,$69,$73,$6B,$30,$30,$2E,$64,$73,$6B,$00,$63,$61
	db	$6E,$27,$74,$20,$61,$6C,$6C,$6F,$63,$61,$74,$65,$20,$6D,$65
	db	$6D,$6F,$72,$79,$21,$0A,$00,$44,$3A,$5A,$45,$58,$44,$4F,$43
	db	$2E,$43,$4F,$4D,$09,$00
	ends
;
	xref	~~z80
	xref	~~debugf
	xref	~~read
	xref	~~memcpy
	xref	~~memset
	xref	~~strcpy
	xref	~~free
	xref	~~malloc
	xref	~~fileno
	xref	~~fclose
	xref	~~fflush
	xref	~~fwrite
	xref	~~fgetc
	xref	~~fprintf
	xref	~~printf
	xref	~~fopen
	udata
~~disk_size
	ds	4
	ends
	xref	~~stderr
	xref	~~stdout
	xref	~~stdin
