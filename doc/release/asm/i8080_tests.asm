;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
;// This file uses the 8080 emulator to run the test suite (roms in cpu_tests
;// directory). It uses a simple array as memory.
;
;//#include <stdio.h>
;#include <stdlib.h>
;//#include <string.h>
;//#include <time.h>
;
;#include "i8080.h"
;
;// memory callbacks
;#define MEMORY_SIZE 0x10000
;static uint8_t* memory = NULL;
	data
~~memory:
	dl	$0
	ends
;static bool test_finished = 0;
	data
~~test_finished:
	dw	$0
	ends
;
;static uint8_t rb(void* userdata, uint16_t addr) {
	code
	func
~~rb:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
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
	ldy	<L2+addr_0
	lda	[<R0],Y
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
;}
L2	equ	4
L3	equ	5
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
	sbc	#L5
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
	lda	<L5+val_0
	ldy	<L5+addr_0
	sta	[<R0],Y
	rep	#$20
	longa	on
;}
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
L5	equ	4
L6	equ	5
	ends
	efunc
;
;static uint8_t port_in(void* userdata, uint8_t port) {
	code
	func
~~port_in:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L8
	tcs
	phd
	tcd
userdata_0	set	4
port_0	set	8
;  return 0x00;
	lda	#$0
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
;}
L8	equ	0
L9	equ	1
	ends
	efunc
;
;static void port_out(void* userdata, uint8_t port, uint8_t value) {
	code
	func
~~port_out:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L11
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
	lda	<L11+userdata_0
	sta	<L12+c_1
	lda	<L11+userdata_0+2
	sta	<L12+c_1+2
	lda	<L11+port_0
	and	#$ff
	bne	L10001
;    test_finished = 1;
	lda	#$1
	sta	|~~test_finished
;  } else if (port == 1) {
L18:
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
L10001:
	sep	#$20
	longa	off
	lda	<L11+port_0
	cmp	#<$1
	rep	#$20
	longa	on
	bne	L18
;    uint8_t operation = c->c;
;
;    if (operation == 2) { // print a character stored in E
operation_2	set	4
	sep	#$20
	longa	off
	ldy	#$1e
	lda	[<L12+c_1],Y
	sta	<L12+operation_2
	cmp	#<$2
	rep	#$20
	longa	on
	bne	L10004
;      printf("%c", c->e);
	iny
	iny
	lda	[<L12+c_1],Y
	and	#$ff
	pha
	pea	#^L1
	pea	#<L1
	pea	#8
	jsl	~~printf
;    } else if (operation == 9) { // print from memory at (DE) until '$' char
	bra	L18
L10004:
	sep	#$20
	longa	off
	lda	<L12+operation_2
	cmp	#<$9
	rep	#$20
	longa	on
	bne	L18
;      uint16_t addr = (c->d << 8) | c->e;
;      do {
addr_3	set	5
	ldy	#$1f
	lda	[<L12+c_1],Y
	and	#$ff
	xba
	and	#$ff00
	sta	<R0
	iny
	lda	[<L12+c_1],Y
	and	#$ff
	ora	<R0
	sta	<L12+addr_3
L10009:
;        printf("%c", rb(c, addr++));
	lda	<L12+addr_3
	sta	<R0
	inc	<L12+addr_3
	pei	<R0
	pei	<L12+c_1+2
	pei	<L12+c_1
	jsl	~~rb
	sep	#$20
	longa	off
	sta	<R1
	rep	#$20
	longa	on
	lda	<R1
	and	#$ff
	pha
	pea	#^L1+3
	pea	#<L1+3
	pea	#8
	jsl	~~printf
;      } while (rb(c, addr) != '$');
	pei	<L12+addr_3
	pei	<L12+c_1+2
	pei	<L12+c_1
	jsl	~~rb
	sep	#$20
	longa	off
	cmp	#<$24
	rep	#$20
	longa	on
	bne	L10009
	brl	L18
;    }
;  }
;}
L11	equ	15
L12	equ	9
	ends
	efunc
	data
L1:
	db	$25,$63,$00,$25,$63,$00
	ends
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
	sbc	#L20
	tcs
	phd
	tcd
filename_0	set	4
addr_0	set	8
;  size_t result;
;  FILE* f;
;  size_t file_size;
;  
;  f = fopen(filename, "rb");
result_1	set	0
f_1	set	2
file_size_1	set	6
	pea	#^L19
	pea	#<L19
	pei	<L20+filename_0+2
	pei	<L20+filename_0
	jsl	~~fopen
	sta	<L21+f_1
	stx	<L21+f_1+2
;  if (f == NULL) {
	ora	<L21+f_1+2
	bne	L10010
;    fprintf(stderr, "error: can't open file '%s'.\n", filename);
	pei	<L20+filename_0+2
	pei	<L20+filename_0
	pea	#^L19+3
	pea	#<L19+3
L20009:
	lda	#<~~_iob+40
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	pea	#14
	jsl	~~fprintf
;    return 1;
	lda	#$1
L23:
	tay
	lda	<L20+2
	sta	<L20+2+6
	lda	<L20+1
	sta	<L20+1+6
	pld
	tsc
	clc
	adc	#L20+6
	tcs
	tya
	rtl
;  }
;
;  // file size check:
;  
;  fseek(f, 0, SEEK_END);
L10010:
	pea	#<$2
	pea	#^$0
	pea	#<$0
	pei	<L21+f_1+2
	pei	<L21+f_1
	jsl	~~fseek
;  file_size = ftell(f);
	pei	<L21+f_1+2
	pei	<L21+f_1
	jsl	~~ftell
	sta	<L21+file_size_1
;  rewind(f);
	pei	<L21+f_1+2
	pei	<L21+f_1
	jsl	~~rewind
;
;  if (file_size + addr >= MEMORY_SIZE) {
	lda	<L21+file_size_1
	clc
	adc	<L20+addr_0
	sta	<R0
	stz	<R0+2
	sec
	lda	<R0
	sbc	#<$10000
	lda	<R0+2
	sbc	#^$10000
	bvs	L24
	eor	#$8000
L24:
	bpl	L10011
;    fprintf(stderr, "error: file %s can't fit in memory.\n", filename);
	pei	<L20+filename_0+2
	pei	<L20+filename_0
	pea	#^L19+33
	pea	#<L19+33
	bra	L20009
;    return 1;
;  }
;
;  // copying the bytes in memory:
;  result = fread(&memory[addr], sizeof(uint8_t), file_size, f);
L10011:
	pei	<L21+f_1+2
	pei	<L21+f_1
	pei	<L21+file_size_1
	pea	#<$1
	lda	<L20+addr_0
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
	jsl	~~fread
	sta	<L21+result_1
;  if (result != file_size) {
	cmp	<L21+file_size_1
	beq	L10012
;    fprintf(stderr, "error: while reading file '%s'\n", filename);
	pei	<L20+filename_0+2
	pei	<L20+filename_0
	pea	#^L19+70
	pea	#<L19+70
	brl	L20009
;    return 1;
;  }
;
;  fclose(f);
L10012:
	pei	<L21+f_1+2
	pei	<L21+f_1
	jsl	~~fclose
;  return 0;
	lda	#$0
	brl	L23
;}
L20	equ	16
L21	equ	9
	ends
	efunc
	data
L19:
	db	$72,$62,$00,$65,$72,$72,$6F,$72,$3A,$20,$63,$61,$6E,$27,$74
	db	$20,$6F,$70,$65,$6E,$20,$66,$69,$6C,$65,$20,$27,$25,$73,$27
	db	$2E,$0A,$00,$65,$72,$72,$6F,$72,$3A,$20,$66,$69,$6C,$65,$20
	db	$25,$73,$20,$63,$61,$6E,$27,$74,$20,$66,$69,$74,$20,$69,$6E
	db	$20,$6D,$65,$6D,$6F,$72,$79,$2E,$0A,$00,$65,$72,$72,$6F,$72
	db	$3A,$20,$77,$68,$69,$6C,$65,$20,$72,$65,$61,$64,$69,$6E,$67
	db	$20,$66,$69,$6C,$65,$20,$27,$25,$73,$27,$0A,$00
	ends
;
;void run_test(
;    i8080* const c, const char* filename, unsigned long cyc_expected) {
	code
	xdef	~~run_test
	func
~~run_test:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L28
	tcs
	phd
	tcd
c_0	set	4
filename_0	set	8
cyc_expected_0	set	12
;  long nb_instructions;		
;  
;  i8080_init(c);
nb_instructions_1	set	0
	pei	<L28+c_0+2
	pei	<L28+c_0
	jsl	~~i8080_init
;  c->userdata = c;
	lda	<L28+c_0
	ldy	#$10
	sta	[<L28+c_0],Y
	lda	<L28+c_0+2
	iny
	iny
	sta	[<L28+c_0],Y
;  c->read_byte = rb;
	lda	#<~~rb
	sta	[<L28+c_0]
	lda	#^~~rb
	ldy	#$2
	sta	[<L28+c_0],Y
;  c->write_byte = wb;
	lda	#<~~wb
	iny
	iny
	sta	[<L28+c_0],Y
	lda	#^~~wb
	iny
	iny
	sta	[<L28+c_0],Y
;  c->port_in = port_in;
	lda	#<~~port_in
	iny
	iny
	sta	[<L28+c_0],Y
	lda	#^~~port_in
	iny
	iny
	sta	[<L28+c_0],Y
;  c->port_out = port_out;
	lda	#<~~port_out
	iny
	iny
	sta	[<L28+c_0],Y
	lda	#^~~port_out
	iny
	iny
	sta	[<L28+c_0],Y
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
;  if (load_file(filename, 0x100) != 0) {
	pea	#<$100
	pei	<L28+filename_0+2
	pei	<L28+filename_0
	jsl	~~load_file
	tax
	beq	L10013
;    return;
L31:
	lda	<L28+2
	sta	<L28+2+12
	lda	<L28+1
	sta	<L28+1+12
	pld
	tsc
	clc
	adc	#L28+12
	tcs
	rtl
;  }
;  printf("*** TEST: %s\n", filename);
L10013:
	pei	<L28+filename_0+2
	pei	<L28+filename_0
	pea	#^L27
	pea	#<L27
	pea	#10
	jsl	~~printf
;
;  c->pc = 0x100;
	lda	#$100
	ldy	#$18
	sta	[<L28+c_0],Y
;
;  // inject "out 0,a" at 0x0000 (signal to stop the test)
;  memory[0x0000] = 0xD3;
	lda	|~~memory
	sta	<R0
	lda	|~~memory+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$d3
	sta	[<R0]
	rep	#$20
	longa	on
;  memory[0x0001] = 0x00;
	lda	|~~memory
	sta	<R0
	lda	|~~memory+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$0
	ldy	#$1
	sta	[<R0],Y
	rep	#$20
	longa	on
;
;  // inject "out 1,a" at 0x0005 (signal to output some characters)
;  memory[0x0005] = 0xD3;
	lda	|~~memory
	sta	<R0
	lda	|~~memory+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$d3
	ldy	#$5
	sta	[<R0],Y
	rep	#$20
	longa	on
;  memory[0x0006] = 0x01;
	lda	|~~memory
	sta	<R0
	lda	|~~memory+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$1
	iny
	sta	[<R0],Y
	rep	#$20
	longa	on
;  memory[0x0007] = 0xC9;
	lda	|~~memory
	sta	<R0
	lda	|~~memory+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$c9
	iny
	sta	[<R0],Y
	rep	#$20
	longa	on
;
;  nb_instructions = 0;
	stz	<L29+nb_instructions_1
	stz	<L29+nb_instructions_1+2
;
;  test_finished = 0;
	stz	|~~test_finished
;  while (!test_finished) {
	bra	L10014
L20011:
;    nb_instructions += 1;
	inc	<L29+nb_instructions_1
	bne	L33
	inc	<L29+nb_instructions_1+2
L33:
;
;    // uncomment following line to have a debug output of machine state
;    // warning: will output multiple GB of data for the whole test suite
;    // i8080_debug_output(c, false);
;
;    i8080_step(c);
	pei	<L28+c_0+2
	pei	<L28+c_0
	jsl	~~i8080_step
;  }
L10014:
	lda	|~~test_finished
	beq	L20011
;
;/*
;  long long diff = cyc_expected - c->cyc;
;  printf("\n*** %lu instructions executed on %lu cycles"
;         " (expected=%lu, diff=%lld)\n\n",
;      nb_instructions, c->cyc, cyc_expected, diff);*/
;}
	brl	L31
L28	equ	8
L29	equ	5
	ends
	efunc
	data
L27:
	db	$2A,$2A,$2A,$20,$54,$45,$53,$54,$3A,$20,$25,$73,$0A,$00
	ends
;
;int main(void) {
	code
	xdef	~~main
	func
~~main:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L35
	tcs
	phd
	tcd
;  i8080 cpu;
;  
;  memory = malloc(MEMORY_SIZE);
cpu_1	set	0
	pea	#<$10000
	jsl	~~malloc
	sta	|~~memory
	stx	|~~memory+2
;  if (memory == NULL) {
	ora	|~~memory+2
	bne	L10016
;    return 1;
	lda	#$1
L38:
	tay
	pld
	tsc
	clc
	adc	#L35
	tcs
	tya
	rtl
;  }
;
;  
;  run_test(&cpu, "cpu_tests/TST8080.COM", 4924LU);
L10016:
	pea	#^$133c
	pea	#<$133c
	pea	#^L34
	pea	#<L34
	pea	#0
	clc
	tdc
	adc	#<L36+cpu_1
	pha
	jsl	~~run_test
;  /*
;  run_test(&cpu, "cpu_tests/CPUTEST.COM", 255653383LU);
;  run_test(&cpu, "cpu_tests/8080PRE.COM", 7817LU);
;  run_test(&cpu, "cpu_tests/8080EXM.COM", 23803381171LU);
;  */
;  free(memory);
	lda	|~~memory+2
	pha
	lda	|~~memory
	pha
	jsl	~~free
;
;  return 0;
	lda	#$0
	bra	L38
;}
L35	equ	39
L36	equ	1
	ends
	efunc
	data
L34:
	db	$63,$70,$75,$5F,$74,$65,$73,$74,$73,$2F,$54,$53,$54,$38,$30
	db	$38,$30,$2E,$43,$4F,$4D,$00
	ends
;
	xref	~~memset
	xref	~~i8080_step
	xref	~~i8080_init
	xref	~~rewind
	xref	~~printf
	xref	~~ftell
	xref	~~fseek
	xref	~~fread
	xref	~~fprintf
	xref	~~fopen
	xref	~~fclose
	xref	~~malloc
	xref	~~free
	xref	~~_iob
