;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
;// This file uses the 8080 emulator to run the test suite (roms in cpu_tests
;// directory). It uses a simple array as memory.
;
;void *heap_start = ( void * )0x10000;
	data
	xdef	~~heap_start
~~heap_start:
	dl	$10000
	ends
;void *heap_end = (void * )0xfffff;
	data
	xdef	~~heap_end
~~heap_end:
	dl	$FFFFF
	ends
;extern unsigned char fd2iocb[8];
;
;
;//#include <stdio.h>
;#include <stdlib.h>
;//#include <string.h>
;//#include <time.h>
;
;#include "i8080.h"
;#include "homebrew.h"
;
;// memory callbacks
;#define MEMORY_SIZE 0xFFFF
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
;static void cpm_port_out(void* userdata, uint8_t port, uint8_t value) {
	code
	func
~~cpm_port_out:
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
;  uint8_t operation;
;   
;   
;  switch (port) {
c_1	set	0
operation_1	set	4
	lda	<L11+userdata_0
	sta	<L12+c_1
	lda	<L11+userdata_0+2
	sta	<L12+c_1+2
	lda	<L11+port_0
	and	#$ff
	xref	~~~swt
	jsl	~~~swt
	dw	2
	dw	0
	dw	L10003-1
	dw	1
	dw	L10004-1
	dw	L13-1
;  case 0:
L10003:
;	c->a = 0;
	sep	#$20
	longa	off
	lda	#$0
	ldy	#$1c
	sta	[<L12+c_1],Y
	rep	#$20
	longa	on
;	break;
L13:
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
;  case 1:
L10004:
;	printf("%c", value);
	lda	<L11+value_0
	and	#$ff
	pha
	pea	#^L1
	pea	#<L1
	pea	#8
	jsl	~~printf
;	fflush(stdout);
	lda	#<~~_iob+20
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	jsl	~~fflush
;	break;
	bra	L13
;  default:
;	break;
;  }
;  
;  /*
;  if (port == 0) {
;    test_finished = 1;
;  } else if (port == 1) {
;    uint8_t operation = c->c;
;
;    if (operation == 2) { // print a character stored in E
;      printf("%c", c->e);
;    } else if (operation == 9) { // print from memory at (DE) until '$' char
;      uint16_t addr = (c->d << 8) | c->e;
;      do {
;        printf("%c", rb(c, addr++));
;      } while (rb(c, addr) != '$');
;    }
;  }*/
;}
L11	equ	9
L12	equ	5
	ends
	efunc
	data
L1:
	db	$25,$63,$00
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
	sbc	#L15
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
	lda	<L15+userdata_0
	sta	<L16+c_1
	lda	<L15+userdata_0+2
	sta	<L16+c_1+2
	lda	<L15+port_0
	and	#$ff
	bne	L10006
;    test_finished = 1;
	lda	#$1
	sta	|~~test_finished
;  } else if (port == 1) {
L10007:
	lda	#<~~_iob+20
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	jsl	~~fflush
;}
	lda	<L15+2
	sta	<L15+2+8
	lda	<L15+1
	sta	<L15+1+8
	pld
	tsc
	clc
	adc	#L15+8
	tcs
	rtl
L10006:
	sep	#$20
	longa	off
	lda	<L15+port_0
	cmp	#<$1
	rep	#$20
	longa	on
	bne	L10007
;    uint8_t operation = c->c;
;
;    if (operation == 2) { // print a character stored in E
operation_2	set	4
	sep	#$20
	longa	off
	ldy	#$1e
	lda	[<L16+c_1],Y
	sta	<L16+operation_2
	cmp	#<$2
	rep	#$20
	longa	on
	bne	L10009
;      printf("%c", c->e);
	iny
	iny
	lda	[<L16+c_1],Y
	and	#$ff
	pha
	pea	#^L14
	pea	#<L14
	pea	#8
	jsl	~~printf
;    } else if (operation == 9) { // print from memory at (DE) until '$' char
	bra	L10007
L10009:
	sep	#$20
	longa	off
	lda	<L16+operation_2
	cmp	#<$9
	rep	#$20
	longa	on
	bne	L10007
;      uint16_t addr = (c->d << 8) | c->e;
;      do {
addr_3	set	5
	ldy	#$1f
	lda	[<L16+c_1],Y
	and	#$ff
	xba
	and	#$ff00
	sta	<R0
	iny
	lda	[<L16+c_1],Y
	and	#$ff
	ora	<R0
	sta	<L16+addr_3
L10014:
;        printf("%c", rb(c, addr++));
	lda	<L16+addr_3
	sta	<R0
	inc	<L16+addr_3
	pei	<R0
	pei	<L16+c_1+2
	pei	<L16+c_1
	jsl	~~rb
	sep	#$20
	longa	off
	sta	<R1
	rep	#$20
	longa	on
	lda	<R1
	and	#$ff
	pha
	pea	#^L14+3
	pea	#<L14+3
	pea	#8
	jsl	~~printf
;      } while (rb(c, addr) != '$');
	pei	<L16+addr_3
	pei	<L16+c_1+2
	pei	<L16+c_1
	jsl	~~rb
	sep	#$20
	longa	off
	cmp	#<$24
	rep	#$20
	longa	on
	bne	L10014
	brl	L10007
;    }
;  }
;  fflush(stdout);
L15	equ	15
L16	equ	9
	ends
	efunc
	data
L14:
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
	sbc	#L24
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
	pea	#^L23
	pea	#<L23
	pei	<L24+filename_0+2
	pei	<L24+filename_0
	jsl	~~fopen
	sta	<L25+f_1
	stx	<L25+f_1+2
;  if (f == NULL) {
	ora	<L25+f_1+2
	bne	L10015
;    fprintf(stderr, "error: can't open file '%s'.\n", filename);
	pei	<L24+filename_0+2
	pei	<L24+filename_0
	pea	#^L23+3
	pea	#<L23+3
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
L27:
	tay
	lda	<L24+2
	sta	<L24+2+6
	lda	<L24+1
	sta	<L24+1+6
	pld
	tsc
	clc
	adc	#L24+6
	tcs
	tya
	rtl
;  }
;
;  // file size check:
;  /*
;  fseek(f, 0, SEEK_END);
;  file_size = ftell(f);
;  rewind(f);
;
;  if (file_size + addr >= MEMORY_SIZE) {
;    fprintf(stderr, "error: file %s can't fit in memory.\n", filename);
;    return 1;
;  }
;*/
;
;  // copying the bytes in memory:
;  result = fread(&memory[addr], sizeof(uint8_t), 0xffff/*file_size*/, f);
L10015:
	pei	<L25+f_1+2
	pei	<L25+f_1
	pea	#<$ffff
	pea	#<$1
	lda	<L24+addr_0
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
	sta	<L25+result_1
;  /*
;  if (result != file_size) {
;    fprintf(stderr, "error: while reading file '%s'\n", filename);
;    return 1;
;  }
;*/
;  printf("loaded %d bytes at %p\n", result, &memory[addr]); 
	lda	<L24+addr_0
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
	pei	<L25+result_1
	pea	#^L23+33
	pea	#<L23+33
	pea	#12
	jsl	~~printf
;  fclose(f);
	pei	<L25+f_1+2
	pei	<L25+f_1
	jsl	~~fclose
;  return 0;
	lda	#$0
	bra	L27
;}
L24	equ	16
L25	equ	9
	ends
	efunc
	data
L23:
	db	$72,$62,$00,$65,$72,$72,$6F,$72,$3A,$20,$63,$61,$6E,$27,$74
	db	$20,$6F,$70,$65,$6E,$20,$66,$69,$6C,$65,$20,$27,$25,$73,$27
	db	$2E,$0A,$00,$6C,$6F,$61,$64,$65,$64,$20,$25,$64,$20,$62,$79
	db	$74,$65,$73,$20,$61,$74,$20,$25,$70,$0A,$00
	ends
;
;void run_test(i8080* const c, const char* filename /*, unsigned long cyc_expected */) {
	code
	xdef	~~run_test
	func
~~run_test:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L29
	tcs
	phd
	tcd
c_0	set	4
filename_0	set	8
;	  
;  long nb_instructions;		
;  long diff;
;  
;  //printf("r_t 1\n");
;  
;  i8080_init(c);
nb_instructions_1	set	0
diff_1	set	4
	pei	<L29+c_0+2
	pei	<L29+c_0
	jsl	~~i8080_init
;  c->userdata = c;
	lda	<L29+c_0
	ldy	#$10
	sta	[<L29+c_0],Y
	lda	<L29+c_0+2
	iny
	iny
	sta	[<L29+c_0],Y
;  c->read_byte = rb;
	lda	#<~~rb
	sta	[<L29+c_0]
	lda	#^~~rb
	ldy	#$2
	sta	[<L29+c_0],Y
;  c->write_byte = wb;
	lda	#<~~wb
	iny
	iny
	sta	[<L29+c_0],Y
	lda	#^~~wb
	iny
	iny
	sta	[<L29+c_0],Y
;  c->port_in = port_in;
	lda	#<~~port_in
	iny
	iny
	sta	[<L29+c_0],Y
	lda	#^~~port_in
	iny
	iny
	sta	[<L29+c_0],Y
;  c->port_out = cpm_port_out;
	lda	#<~~cpm_port_out
	iny
	iny
	sta	[<L29+c_0],Y
	lda	#^~~cpm_port_out
	iny
	iny
	sta	[<L29+c_0],Y
;  memset(memory, 0, MEMORY_SIZE);
	pea	#<$ffff
	pea	#<$0
	lda	|~~memory+2
	pha
	lda	|~~memory
	pha
	jsl	~~memset
;
;  //printf("r_t 2\n");
;  //if (load_file(filename, 0x100) != 0) {
;  if (load_file(filename, 0x000) != 0) {
	pea	#<$0
	pei	<L29+filename_0+2
	pei	<L29+filename_0
	jsl	~~load_file
	tax
	beq	L10016
;    return;
L32:
	lda	<L29+2
	sta	<L29+2+8
	lda	<L29+1
	sta	<L29+1+8
	pld
	tsc
	clc
	adc	#L29+8
	tcs
	rtl
;  }
;  printf("*** TEST: %s\n", filename);
L10016:
	pei	<L29+filename_0+2
	pei	<L29+filename_0
	pea	#^L28
	pea	#<L28
	pea	#10
	jsl	~~printf
;
;  c->pc = 0x000;
	lda	#$0
	ldy	#$18
	sta	[<L29+c_0],Y
;
;  // inject "out 0,a" at 0x0000 (signal to stop the test)
;  //memory[0x0000] = 0xD3;
;  //memory[0x0001] = 0x00;
;
;  // inject "out 1,a" at 0x0005 (signal to output some characters)
;  //memory[0x0005] = 0xD3;
;  //memory[0x0006] = 0x01;
;  //memory[0x0007] = 0xC9;
;
;  nb_instructions = 0;
	stz	<L30+nb_instructions_1
	stz	<L30+nb_instructions_1+2
;
;  test_finished = 0;
	stz	|~~test_finished
;  while (!test_finished) {
	bra	L10017
L20001:
;    nb_instructions += 1;
	inc	<L30+nb_instructions_1
	bne	L34
	inc	<L30+nb_instructions_1+2
L34:
;
;    // uncomment following line to have a debug output of machine state
;    // warning: will output multiple GB of data for the whole test suite
;    i8080_debug_output(c, true);
	pea	#<$1
	pei	<L29+c_0+2
	pei	<L29+c_0
	jsl	~~i8080_debug_output
;
;    i8080_step(c);
	pei	<L29+c_0+2
	pei	<L29+c_0
	jsl	~~i8080_step
;  }
L10017:
	lda	|~~test_finished
	beq	L20001
;
;/*
;  long long diff = cyc_expected - c->cyc;
;  diff = cyc_expected - c->cyc;
;  printf("\n*** %lu instructions executed on %lu cycles"
;         " (expected=%lu, diff=%lld)\n\n",
;      nb_instructions, c->cyc, cyc_expected, diff);
;*/
;  printf("*** Test finished ***\n");
	pea	#^L28+14
	pea	#<L28+14
	pea	#6
	jsl	~~printf
;}
	bra	L32
L29	equ	8
L30	equ	1
	ends
	efunc
	data
L28:
	db	$2A,$2A,$2A,$20,$54,$45,$53,$54,$3A,$20,$25,$73,$0A,$00,$2A
	db	$2A,$2A,$20,$54,$65,$73,$74,$20,$66,$69,$6E,$69,$73,$68,$65
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
	sbc	#L36
	tcs
	phd
	tcd
argc_0	set	4
argv_0	set	6
;  i8080 cpu;
;  
;  fd2iocb[0] = 0;
cpu_1	set	0
	sep	#$20
	longa	off
	stz	|~~fd2iocb
;  fd2iocb[1] = 0;
	stz	|~~fd2iocb+1
;  fd2iocb[2] = 0;
	stz	|~~fd2iocb+2
;  fd2iocb[3] = 0xff;
	lda	#$ff
	sta	|~~fd2iocb+3
;  fd2iocb[4] = 0xff;
	sta	|~~fd2iocb+4
;  fd2iocb[5] = 0xff;
	sta	|~~fd2iocb+5
;  fd2iocb[6] = 0xff;
	sta	|~~fd2iocb+6
;  fd2iocb[7] = 0xff; 
	sta	|~~fd2iocb+7
	rep	#$20
	longa	on
;  setvbuf(stdin, NULL, _IONBF, 1);
	pea	#<$1
	pea	#<$80
	pea	#^$0
	pea	#<$0
	lda	#<~~_iob
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	jsl	~~setvbuf
;
;  memory = malloc(MEMORY_SIZE);
	pea	#<$ffff
	jsl	~~malloc
	sta	|~~memory
	stx	|~~memory+2
;  if (memory == NULL) {
	ora	|~~memory+2
	bne	L10019
;    return 1;
	lda	#$1
L39:
	tay
	lda	<L36+2
	sta	<L36+2+6
	lda	<L36+1
	sta	<L36+1+6
	pld
	tsc
	clc
	adc	#L36+6
	tcs
	tya
	rtl
;  }
;
;  
;  run_test(&cpu, "D:CPM22.SYS");
L10019:
	pea	#^L35
	pea	#<L35
	pea	#0
	clc
	tdc
	adc	#<L37+cpu_1
	pha
	jsl	~~run_test
;  //run_test(&cpu, "D:CPUTEST.COM", 4924LU);
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
	bra	L39
;}
L36	equ	43
L37	equ	5
	ends
	efunc
	data
L35:
	db	$44,$3A,$43,$50,$4D,$32,$32,$2E,$53,$59,$53,$00
	ends
;
	xref	~~memset
	xref	~~i8080_debug_output
	xref	~~i8080_step
	xref	~~i8080_init
	xref	~~setvbuf
	xref	~~printf
	xref	~~fread
	xref	~~fprintf
	xref	~~fopen
	xref	~~fflush
	xref	~~fclose
	xref	~~malloc
	xref	~~free
	xref	~~_iob
	xref	~~fd2iocb
