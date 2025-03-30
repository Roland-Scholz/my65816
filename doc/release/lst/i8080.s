;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
;#include "i8080.h"
;
;// this array defines the number of cycles one opcode takes.
;// note that there are some special cases: conditional RETs and CALLs
;// add +6 cycles if the condition is met
;// clang-format off
;/*
;static const uint8_t OPCODES_CYCLES[256] = {
;//  0  1   2   3   4   5   6   7   8  9   A   B   C   D   E  F
;    4, 10, 7,  5,  5,  5,  7,  4,  4, 10, 7,  5,  5,  5,  7, 4,  // 0
;    4, 10, 7,  5,  5,  5,  7,  4,  4, 10, 7,  5,  5,  5,  7, 4,  // 1
;    4, 10, 16, 5,  5,  5,  7,  4,  4, 10, 16, 5,  5,  5,  7, 4,  // 2
;    4, 10, 13, 5,  10, 10, 10, 4,  4, 10, 13, 5,  5,  5,  7, 4,  // 3
;    5, 5,  5,  5,  5,  5,  7,  5,  5, 5,  5,  5,  5,  5,  7, 5,  // 4
;    5, 5,  5,  5,  5,  5,  7,  5,  5, 5,  5,  5,  5,  5,  7, 5,  // 5
;    5, 5,  5,  5,  5,  5,  7,  5,  5, 5,  5,  5,  5,  5,  7, 5,  // 6
;    7, 7,  7,  7,  7,  7,  7,  7,  5, 5,  5,  5,  5,  5,  7, 5,  // 7
;    4, 4,  4,  4,  4,  4,  7,  4,  4, 4,  4,  4,  4,  4,  7, 4,  // 8
;    4, 4,  4,  4,  4,  4,  7,  4,  4, 4,  4,  4,  4,  4,  7, 4,  // 9
;    4, 4,  4,  4,  4,  4,  7,  4,  4, 4,  4,  4,  4,  4,  7, 4,  // A
;    4, 4,  4,  4,  4,  4,  7,  4,  4, 4,  4,  4,  4,  4,  7, 4,  // B
;    5, 10, 10, 10, 11, 11, 7,  11, 5, 10, 10, 10, 11, 17, 7, 11, // C
;    5, 10, 10, 10, 11, 11, 7,  11, 5, 10, 10, 10, 11, 17, 7, 11, // D
;    5, 10, 10, 18, 11, 11, 7,  11, 5, 5,  10, 4,  11, 17, 7, 11, // E
;    5, 10, 10, 4,  11, 11, 7,  11, 5, 5,  10, 4,  11, 17, 7, 11  // F
;};*/
;// clang-format on
;
;/*
;static const char* DISASSEMBLE_TABLE[] = {"nop", "lxi b,#", "stax b", "inx b",
;    "inr b", "dcr b", "mvi b,#", "rlc", "ill", "dad b", "ldax b", "dcx b",
;    "inr c", "dcr c", "mvi c,#", "rrc", "ill", "lxi d,#", "stax d", "inx d",
;    "inr d", "dcr d", "mvi d,#", "ral", "ill", "dad d", "ldax d", "dcx d",
;    "inr e", "dcr e", "mvi e,#", "rar", "ill", "lxi h,#", "shld", "inx h",
;    "inr h", "dcr h", "mvi h,#", "daa", "ill", "dad h", "lhld", "dcx h",
;    "inr l", "dcr l", "mvi l,#", "cma", "ill", "lxi sp,#", "sta $", "inx sp",
;    "inr M", "dcr M", "mvi M,#", "stc", "ill", "dad sp", "lda $", "dcx sp",
;    "inr a", "dcr a", "mvi a,#", "cmc", "mov b,b", "mov b,c", "mov b,d",
;    "mov b,e", "mov b,h", "mov b,l", "mov b,M", "mov b,a", "mov c,b", "mov c,c",
;    "mov c,d", "mov c,e", "mov c,h", "mov c,l", "mov c,M", "mov c,a", "mov d,b",
;    "mov d,c", "mov d,d", "mov d,e", "mov d,h", "mov d,l", "mov d,M", "mov d,a",
;    "mov e,b", "mov e,c", "mov e,d", "mov e,e", "mov e,h", "mov e,l", "mov e,M",
;    "mov e,a", "mov h,b", "mov h,c", "mov h,d", "mov h,e", "mov h,h", "mov h,l",
;    "mov h,M", "mov h,a", "mov l,b", "mov l,c", "mov l,d", "mov l,e", "mov l,h",
;    "mov l,l", "mov l,M", "mov l,a", "mov M,b", "mov M,c", "mov M,d", "mov M,e",
;    "mov M,h", "mov M,l", "hlt", "mov M,a", "mov a,b", "mov a,c", "mov a,d",
;    "mov a,e", "mov a,h", "mov a,l", "mov a,M", "mov a,a", "add b", "add c",
;    "add d", "add e", "add h", "add l", "add M", "add a", "adc b", "adc c",
;    "adc d", "adc e", "adc h", "adc l", "adc M", "adc a", "sub b", "sub c",
;    "sub d", "sub e", "sub h", "sub l", "sub M", "sub a", "sbb b", "sbb c",
;    "sbb d", "sbb e", "sbb h", "sbb l", "sbb M", "sbb a", "ana b", "ana c",
;    "ana d", "ana e", "ana h", "ana l", "ana M", "ana a", "xra b", "xra c",
;    "xra d", "xra e", "xra h", "xra l", "xra M", "xra a", "ora b", "ora c",
;    "ora d", "ora e", "ora h", "ora l", "ora M", "ora a", "cmp b", "cmp c",
;    "cmp d", "cmp e", "cmp h", "cmp l", "cmp M", "cmp a", "rnz", "pop b",
;    "jnz $", "jmp $", "cnz $", "push b", "adi #", "rst 0", "rz", "ret", "jz $",
;    "ill", "cz $", "call $", "aci #", "rst 1", "rnc", "pop d", "jnc $", "out p",
;    "cnc $", "push d", "sui #", "rst 2", "rc", "ill", "jc $", "in p", "cc $",
;    "ill", "sbi #", "rst 3", "rpo", "pop h", "jpo $", "xthl", "cpo $", "push h",
;    "ani #", "rst 4", "rpe", "pchl", "jpe $", "xchg", "cpe $", "ill", "xri #",
;    "rst 5", "rp", "pop psw", "jp $", "di", "cp $", "push psw", "ori #",
;    "rst 6", "rm", "sphl", "jm $", "ei", "cm $", "ill", "cpi #", "rst 7"};
;*/
;
;#define SET_ZSP(c, val) \
;  do { \
;    c->zf = (val) == 0; \
;    c->sf = (val) >> 7; \
;    c->pf = parity(val); \
;  } while (0)
;
;// memory helpers (the only four to use `read_byte` and `write_byte` function
;// pointers)
;
;// reads a byte from memory
;static  uint8_t i8080_rb(i8080* const c, uint16_t addr) {
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
;  return c->read_byte(c->userdata, addr);
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
;}
L2	equ	4
L3	equ	5
	ends
	efunc
;
;// writes a byte to memory
;static  void i8080_wb(i8080* const c, uint16_t addr, uint8_t val) {
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
;  c->write_byte(c->userdata, addr, val);
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
L5	equ	0
L6	equ	1
	ends
	efunc
;
;// reads a word from memory
;static  uint16_t i8080_rw(i8080* const c, uint16_t addr) {
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
;  return c->read_byte(c->userdata, addr + 1) << 8 |
;         c->read_byte(c->userdata, addr);
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
;}
L8	equ	8
L9	equ	9
	ends
	efunc
;
;// writes a word to memory
;static  void i8080_ww(i8080* const c, uint16_t addr, uint16_t val) {
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
;  c->write_byte(c->userdata, addr, val & 0xFF);
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
;  c->write_byte(c->userdata, addr + 1, val >> 8);
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
;}
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
;
;// returns the next byte in memory (and updates the program counter)
;static  uint8_t i8080_next_byte(i8080* const c) {
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
;  return i8080_rb(c, c->pc++);
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
;}
L14	equ	8
L15	equ	9
	ends
	efunc
;
;// returns the next word in memory (and updates the program counter)
;static  uint16_t i8080_next_word(i8080* const c) {
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
;  uint16_t result = i8080_rw(c, c->pc);
;  c->pc += 2;
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
;  return result;
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
;}
L17	equ	6
L18	equ	5
	ends
	efunc
;
;// paired registers helpers (setters and getters)
;static  void i8080_set_bc(i8080* const c, uint16_t val) {
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
;  c->b = val >> 8;
	lda	<L20+val_0
	xba
	and	#$00ff
	sep	#$20
	longa	off
	ldy	#$1d
	sta	[<L20+c_0],Y
	rep	#$20
	longa	on
;  c->c = val & 0xFF;
	lda	<L20+val_0
	and	#<$ff
	sep	#$20
	longa	off
	iny
	sta	[<L20+c_0],Y
	rep	#$20
	longa	on
;}
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
;
;static  void i8080_set_de(i8080* const c, uint16_t val) {
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
;  c->d = val >> 8;
	lda	<L23+val_0
	xba
	and	#$00ff
	sep	#$20
	longa	off
	ldy	#$1f
	sta	[<L23+c_0],Y
	rep	#$20
	longa	on
;  c->e = val & 0xFF;
	lda	<L23+val_0
	and	#<$ff
	sep	#$20
	longa	off
	iny
	sta	[<L23+c_0],Y
	rep	#$20
	longa	on
;}
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
;
;static  void i8080_set_hl(i8080* const c, uint16_t val) {
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
;  c->h = val >> 8;
	lda	<L26+val_0
	xba
	and	#$00ff
	sep	#$20
	longa	off
	ldy	#$21
	sta	[<L26+c_0],Y
	rep	#$20
	longa	on
;  c->l = val & 0xFF;
	lda	<L26+val_0
	and	#<$ff
	sep	#$20
	longa	off
	iny
	sta	[<L26+c_0],Y
	rep	#$20
	longa	on
;}
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
;
;static  uint16_t i8080_get_bc(i8080* const c) {
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
;  return (c->b << 8) | c->c;
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
;}
L29	equ	8
L30	equ	9
	ends
	efunc
;
;static  uint16_t i8080_get_de(i8080* const c) {
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
;  return (c->d << 8) | c->e;
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
;}
L32	equ	8
L33	equ	9
	ends
	efunc
;
;static  uint16_t i8080_get_hl(i8080* const c) {
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
;  return (c->h << 8) | c->l;
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
;}
L35	equ	8
L36	equ	9
	ends
	efunc
;
;// stack helpers
;
;// pushes a value into the stack and updates the stack pointer
;static  void i8080_push_stack(i8080* const c, uint16_t val) {
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
;  c->sp -= 2;
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
;  i8080_ww(c, c->sp, val);
	pei	<L38+val_0
	ldy	#$1a
	lda	[<L38+c_0],Y
	pha
	pei	<L38+c_0+2
	pei	<L38+c_0
	jsl	~~i8080_ww
;}
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
;
;// pops a value from the stack and updates the stack pointer
;static  uint16_t i8080_pop_stack(i8080* const c) {
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
;  uint16_t val = i8080_rw(c, c->sp);
;  c->sp += 2;
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
;  return val;
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
;}
L41	equ	6
L42	equ	5
	ends
	efunc
;
;// opcodes
;
;// returns the parity of byte: 0 if number of 1 bits in `val` is odd, else 1
;static  bool parity(uint8_t val) {
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
;  uint16_t i;
;  uint16_t nb_one_bits = 0;
;  for (i = 0; i < 8; i++) {
i_1	set	0
nb_one_bits_1	set	2
	stz	<L45+nb_one_bits_1
	stz	<L45+i_1
	bra	L10004
L10003:
;    nb_one_bits += ((val >> i) & 1);
	lda	<L44+val_0
	and	#$ff
	ldx	<L45+i_1
	xref	~~~asr
	jsl	~~~asr
	and	#<$1
	clc
	adc	<L45+nb_one_bits_1
	sta	<L45+nb_one_bits_1
;  }
	inc	<L45+i_1
L10004:
	lda	<L45+i_1
	cmp	#<$8
	bcc	L10003
;
;  return (nb_one_bits & 1) == 0;
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
;}
L44	equ	8
L45	equ	5
	ends
	efunc
;
;// returns if there was a carry between bit "bit_no" and "bit_no - 1" when
;// executing "a + b + cy"
;static  bool carry(int bit_no, uint8_t a, uint8_t b, bool cy) {
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
;  uint16_t result = a + b + cy;
;  uint16_t carry = result ^ a ^ b;
; 
;  carry = ((carry & (1 << bit_no)) != 0); 
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
;  //printf("carry: %d\n", carry);
;  return (carry);
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
;}
L50	equ	16
L51	equ	13
	ends
	efunc
;
;// adds a value (+ an optional carry flag) to a register
;static  void i8080_add(
;    i8080* const c, uint8_t* const reg, uint8_t val, bool cy) {
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
;  uint8_t result = *reg + val + cy;
;  c->cf = carry(8, *reg, val, cy);
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
;  c->hf = carry(4, *reg, val, cy);
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
;  
;  //printf("c->cf: %d\n", c->cf);
;  SET_ZSP(c, result);
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
;  *reg = result;
	sep	#$20
	longa	off
	lda	<L56+result_1
	sta	[<L55+reg_0]
	rep	#$20
	longa	on
;}
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
;
;// substracts a byte (+ an optional carry flag) from a register
;// see https://stackoverflow.com/a/8037485
;static  void i8080_sub(
;    i8080* const c, uint8_t* const reg, uint8_t val, bool cy) {
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
;  i8080_add(c, reg, ~val, !cy);
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
;  c->cf = !c->cf;
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
;}
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
;
;// adds a word to HL
;static  void i8080_dad(i8080* const c, uint16_t val) {
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
;  unsigned long result;
;  
;  result = (long)i8080_get_hl(c) + (long)val;
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
;  //printf("result: %08X %04X %04X\n", result, i8080_get_hl(c), val);
;  
;  result >>= 16;
	pha
	pei	<L68+result_1
	lda	#$10
	xref	~~~llsr
	jsl	~~~llsr
	sta	<L68+result_1
	stx	<L68+result_1+2
;  //printf("result: %ul\n", result);
;  
;  
;  //c->cf = ((i8080_get_hl(c) + val) >> 16) & 1;
;  c->cf = result & 1;
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
;  i8080_set_hl(c, /*(unsigned int) result */ i8080_get_hl(c) + val);
	pei	<L67+c_0+2
	pei	<L67+c_0
	jsl	~~i8080_get_hl
	clc
	adc	<L67+val_0
	pha
	pei	<L67+c_0+2
	pei	<L67+c_0
	jsl	~~i8080_set_hl
;}
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
;
;// increments a byte
;static  uint8_t i8080_inr(i8080* const c, uint8_t val) {
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
;  uint8_t result = val + 1;
;  c->hf = (result & 0xF) == 0;
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
;  SET_ZSP(c, result);
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
;  return result;
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
;}
L70	equ	5
L71	equ	5
	ends
	efunc
;
;// decrements a byte
;static  uint8_t i8080_dcr(i8080* const c, uint8_t val) {
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
;  uint8_t result = val - 1;
;  c->hf = !((result & 0xF) == 0xF);
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
;  SET_ZSP(c, result);
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
;  return result;
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
;}
L77	equ	9
L78	equ	9
	ends
	efunc
;
;// executes a logic "and" between register A and a byte, then stores the
;// result in register A
;static  void i8080_ana(i8080* const c, uint8_t val) {
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
;  uint8_t result = c->a & val;
;  c->cf = 0;
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
;  c->hf = ((c->a | val) & 0x08) != 0;
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
;  SET_ZSP(c, result);
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
;  c->a = result;
	sep	#$20
	longa	off
	lda	<L85+result_1
	ldy	#$1c
	sta	[<L84+c_0],Y
	rep	#$20
	longa	on
;}
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
;
;// executes a logic "xor" between register A and a byte, then stores the
;// result in register A
;static  void i8080_xra(i8080* const c, uint8_t val) {
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
;  c->a ^= val;
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
;  c->cf = 0;
	ldy	#$23
	lda	[<L91+c_0],Y
	and	#<$ffffffef
;  c->hf = 0;
	and	#<$fffffffb
	sta	[<L91+c_0],Y
;  SET_ZSP(c, c->a);
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
;}
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
;
;// executes a logic "or" between register A and a byte, then stores the
;// result in register A
;static  void i8080_ora(i8080* const c, uint8_t val) {
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
;  c->a |= val;
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
;  c->cf = 0;
	ldy	#$23
	lda	[<L96+c_0],Y
	and	#<$ffffffef
;  c->hf = 0;
	and	#<$fffffffb
	sta	[<L96+c_0],Y
;  SET_ZSP(c, c->a);
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
;}
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
;
;// compares the register A to another byte
;static  void i8080_cmp(i8080* const c, uint8_t val) {
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
;  int16_t result = c->a - val;
;  c->cf = result >> 8;
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
;  c->hf = ~(c->a ^ result ^ val) & 0x10;
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
;  SET_ZSP(c, result & 0xFF);
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
;}
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
;
;// sets the program counter to a given address
;static  void i8080_jmp(i8080* const c, uint16_t addr) {
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
;  c->pc = addr;
	lda	<L106+addr_0
	ldy	#$18
	sta	[<L106+c_0],Y
;}
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
;
;// jumps to next address pointed by the next word in memory if a condition
;// is met
;static  void i8080_cond_jmp(i8080* const c, bool condition) {
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
;  uint16_t addr = i8080_next_word(c);
;  if (condition) {
addr_1	set	0
	pei	<L109+c_0+2
	pei	<L109+c_0
	jsl	~~i8080_next_word
	sta	<L110+addr_1
	lda	<L109+condition_0
	beq	L112
;    c->pc = addr;
	lda	<L110+addr_1
	ldy	#$18
	sta	[<L109+c_0],Y
;  }
;}
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
;
;// pushes the current pc to the stack, then jumps to an address
;static  void i8080_call(i8080* const c, uint16_t addr) {
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
;  i8080_push_stack(c, c->pc);
	ldy	#$18
	lda	[<L113+c_0],Y
	pha
	pei	<L113+c_0+2
	pei	<L113+c_0
	jsl	~~i8080_push_stack
;  i8080_jmp(c, addr);
	pei	<L113+addr_0
	pei	<L113+c_0+2
	pei	<L113+c_0
	jsl	~~i8080_jmp
;}
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
;
;// calls to next word in memory if a condition is met
;static  void i8080_cond_call(i8080* const c, bool condition) {
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
;  uint16_t addr = i8080_next_word(c);
;  if (condition) {
addr_1	set	0
	pei	<L116+c_0+2
	pei	<L116+c_0
	jsl	~~i8080_next_word
	sta	<L117+addr_1
	lda	<L116+condition_0
	beq	L119
;    i8080_call(c, addr);
	pei	<L117+addr_1
	pei	<L116+c_0+2
	pei	<L116+c_0
	jsl	~~i8080_call
;    c->cyc += 6;
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
;  }
;}
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
;
;// returns from subroutine
;static  void i8080_ret(i8080* const c) {
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
;  c->pc = i8080_pop_stack(c);
	pei	<L120+c_0+2
	pei	<L120+c_0
	jsl	~~i8080_pop_stack
	ldy	#$18
	sta	[<L120+c_0],Y
;}
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
;
;// returns from subroutine if a condition is met
;static  void i8080_cond_ret(i8080* const c, bool condition) {
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
;  if (condition) {
	lda	<L123+condition_0
	beq	L126
;    i8080_ret(c);
	pei	<L123+c_0+2
	pei	<L123+c_0
	jsl	~~i8080_ret
;    c->cyc += 6;
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
;  }
;}
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
;
;// pushes register A and the flags into the stack
;static  void i8080_push_psw(i8080* const c) {
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
;  // note: bit 3 and 5 are always 0
;  uint8_t psw;
;  psw = 0;
psw_1	set	0
	sep	#$20
	longa	off
	stz	<L128+psw_1
	rep	#$20
	longa	on
;  psw |= c->sf << 7;
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
;  psw |= c->zf << 6;
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
;  psw |= c->hf << 4;
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
;  psw |= c->pf << 2;
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
;  psw |= 1 << 1; // bit 1 is always 1
	lda	#$2
	tsb	<L128+psw_1
	rep	#$20
	longa	on
;  psw |= c->cf << 0;
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
;  i8080_push_stack(c, c->a << 8 | psw);
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
;}
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
;
;// pops register A and the flags from the stack
;static  void i8080_pop_psw(i8080* const c) {
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
;  uint8_t psw;
;  uint16_t af = i8080_pop_stack(c);
;  
;  c->a = af >> 8;
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
;  psw = af & 0xFF;
	lda	<L131+af_1
	and	#<$ff
	sep	#$20
	longa	off
	sta	<L131+psw_1
	rep	#$20
	longa	on
;
;  c->sf = (psw >> 7) & 1;
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
;  c->zf = (psw >> 6) & 1;
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
;  c->hf = (psw >> 4) & 1;
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
;  c->pf = (psw >> 2) & 1;
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
;  c->cf = (psw >> 0) & 1;
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
;}
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
;
;// rotate register A left
;static  void i8080_rlc(i8080* const c) {
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
;  c->cf = c->a >> 7;
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
;  c->a = (c->a << 1) | c->cf;
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
;}
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
;
;// rotate register A right
;static  void i8080_rrc(i8080* const c) {
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
;  c->cf = c->a & 1;
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
;  c->a = (c->a >> 1) | (c->cf << 7);
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
;}
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
;
;// rotate register A left with the carry flag
;static  void i8080_ral(i8080* const c) {
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
;  bool cy = c->cf;
;  c->cf = c->a >> 7;
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
;  c->a = (c->a << 1) | cy;
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
;}
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
;
;// rotate register A right with the carry flag
;static  void i8080_rar(i8080* const c) {
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
;  bool cy = c->cf;
;  c->cf = c->a & 1;
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
;  c->a = (c->a >> 1) | (cy << 7);
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
;}
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
;
;// Decimal Adjust Accumulator: the eight-bit number in register A is adjusted
;// to form two four-bit binary-coded-decimal digits.
;// For example, if A=$2B and DAA is executed, A becomes $31.
;static  void i8080_daa(i8080* const c) {
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
;  bool cy = c->cf;
;  uint8_t correction = 0;
;
;  uint8_t lsb = c->a & 0x0F;
;  uint8_t msb = c->a >> 4;
;
;  if (c->hf || lsb > 9) {
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
;    correction += 0x06;
	sep	#$20
	longa	off
	lda	#$6
	clc
	adc	<L146+correction_1
	sta	<L146+correction_1
	rep	#$20
	longa	on
;  }
;
;  if (c->cf || msb > 9 || (msb >= 9 && lsb > 9)) {
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
;    correction += 0x60;
	sep	#$20
	longa	off
	lda	#$60
	clc
	adc	<L146+correction_1
	sta	<L146+correction_1
	rep	#$20
	longa	on
;    cy = 1;
	lda	#$1
	sta	<L146+cy_1
;  }
;
;  i8080_add(c, &c->a, correction, 0);
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
;  c->cf = cy;
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
;}
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
;
;// switches the value of registers DE and HL
;static  void i8080_xchg(i8080* const c) {
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
;  uint16_t de = i8080_get_de(c);
;  i8080_set_de(c, i8080_get_hl(c));
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
;  i8080_set_hl(c, de);
	pei	<L157+de_1
	pei	<L156+c_0+2
	pei	<L156+c_0
	jsl	~~i8080_set_hl
;}
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
;
;// switches the value of a word at (sp) and HL
;static  void i8080_xthl(i8080* const c) {
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
;  uint16_t val = i8080_rw(c, c->sp);
;  i8080_ww(c, c->sp, i8080_get_hl(c));
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
;  i8080_set_hl(c, val);
	pei	<L160+val_1
	pei	<L159+c_0+2
	pei	<L159+c_0
	jsl	~~i8080_set_hl
;}
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
;
;// executes one opcode
;static  void i8080_execute(i8080* const c, uint8_t opcode) {
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
;  //c->cyc += OPCODES_CYCLES[opcode];
;
;  // when DI is executed, interrupts won't be serviced
;  // until the end of next instruction:
;  if (c->interrupt_delay > 0) {
	sep	#$20
	longa	off
	lda	#$0
	ldy	#$26
	cmp	[<L162+c_0],Y
	rep	#$20
	longa	on
	bcs	L10031
;    c->interrupt_delay -= 1;
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
;  }
;
;  getchar();
L10031:
	lda	|~~stdin+2
	pha
	lda	|~~stdin
	pha
	jsl	~~fgetc
;  switch (opcode) {
	lda	<L162+opcode_0
	and	#$ff
	xref	~~~fsw
	jsl	~~~fsw
	dw	0
	dw	256
	dw	L215-1
	dw	L215-1
	dw	L10111-1
	dw	L10108-1
	dw	L10180-1
	dw	L10165-1
	dw	L10173-1
	dw	L10101-1
	dw	L10192-1
	dw	L215-1
	dw	L10156-1
	dw	L10042-1
	dw	L10184-1
	dw	L10166-1
	dw	L10174-1
	dw	L10102-1
	dw	L10193-1
	dw	L215-1
	dw	L10112-1
	dw	L10109-1
	dw	L10181-1
	dw	L10167-1
	dw	L10175-1
	dw	L10103-1
	dw	L10194-1
	dw	L215-1
	dw	L10157-1
	dw	L10043-1
	dw	L10185-1
	dw	L10168-1
	dw	L10176-1
	dw	L10104-1
	dw	L10195-1
	dw	L215-1
	dw	L10113-1
	dw	L10116-1
	dw	L10182-1
	dw	L10169-1
	dw	L10177-1
	dw	L10105-1
	dw	L10188-1
	dw	L215-1
	dw	L10158-1
	dw	L10115-1
	dw	L10186-1
	dw	L10170-1
	dw	L10178-1
	dw	L10106-1
	dw	L10189-1
	dw	L215-1
	dw	L10114-1
	dw	L10110-1
	dw	L10183-1
	dw	L10171-1
	dw	L10179-1
	dw	L10107-1
	dw	L10190-1
	dw	L215-1
	dw	L10159-1
	dw	L10044-1
	dw	L10187-1
	dw	L10164-1
	dw	L10172-1
	dw	L10100-1
	dw	L10191-1
	dw	L10046-1
	dw	L10047-1
	dw	L10048-1
	dw	L10049-1
	dw	L10050-1
	dw	L10051-1
	dw	L10052-1
	dw	L10045-1
	dw	L10054-1
	dw	L10055-1
	dw	L10056-1
	dw	L10057-1
	dw	L10058-1
	dw	L10059-1
	dw	L10060-1
	dw	L10053-1
	dw	L10062-1
	dw	L10063-1
	dw	L10064-1
	dw	L10065-1
	dw	L10066-1
	dw	L10067-1
	dw	L10068-1
	dw	L10061-1
	dw	L10070-1
	dw	L10071-1
	dw	L10072-1
	dw	L10073-1
	dw	L10074-1
	dw	L10075-1
	dw	L10076-1
	dw	L10069-1
	dw	L10078-1
	dw	L10079-1
	dw	L10080-1
	dw	L10081-1
	dw	L10082-1
	dw	L10083-1
	dw	L10084-1
	dw	L10077-1
	dw	L10086-1
	dw	L10087-1
	dw	L10088-1
	dw	L10089-1
	dw	L10090-1
	dw	L10091-1
	dw	L10092-1
	dw	L10085-1
	dw	L10094-1
	dw	L10095-1
	dw	L10096-1
	dw	L10097-1
	dw	L10098-1
	dw	L10099-1
	dw	L10163-1
	dw	L10093-1
	dw	L10035-1
	dw	L10036-1
	dw	L10037-1
	dw	L10038-1
	dw	L10039-1
	dw	L10040-1
	dw	L10041-1
	dw	L10034-1
	dw	L10121-1
	dw	L10122-1
	dw	L10123-1
	dw	L10124-1
	dw	L10125-1
	dw	L10126-1
	dw	L10127-1
	dw	L10120-1
	dw	L10130-1
	dw	L10131-1
	dw	L10132-1
	dw	L10133-1
	dw	L10134-1
	dw	L10135-1
	dw	L10136-1
	dw	L10129-1
	dw	L10139-1
	dw	L10140-1
	dw	L10141-1
	dw	L10142-1
	dw	L10143-1
	dw	L10144-1
	dw	L10145-1
	dw	L10138-1
	dw	L10148-1
	dw	L10149-1
	dw	L10150-1
	dw	L10151-1
	dw	L10152-1
	dw	L10153-1
	dw	L10154-1
	dw	L10147-1
	dw	L10197-1
	dw	L10198-1
	dw	L10199-1
	dw	L10200-1
	dw	L10201-1
	dw	L10202-1
	dw	L10203-1
	dw	L10196-1
	dw	L10206-1
	dw	L10207-1
	dw	L10208-1
	dw	L10209-1
	dw	L10210-1
	dw	L10211-1
	dw	L10212-1
	dw	L10205-1
	dw	L10215-1
	dw	L10216-1
	dw	L10217-1
	dw	L10218-1
	dw	L10219-1
	dw	L10220-1
	dw	L10221-1
	dw	L10214-1
	dw	L10224-1
	dw	L10225-1
	dw	L10226-1
	dw	L10227-1
	dw	L10228-1
	dw	L10229-1
	dw	L10230-1
	dw	L10223-1
	dw	L10252-1
	dw	L10272-1
	dw	L10233-1
	dw	L10232-1
	dw	L10243-1
	dw	L10268-1
	dw	L10128-1
	dw	L10260-1
	dw	L10253-1
	dw	L10251-1
	dw	L10234-1
	dw	L10232-1
	dw	L10244-1
	dw	L10242-1
	dw	L10137-1
	dw	L10261-1
	dw	L10254-1
	dw	L10273-1
	dw	L10235-1
	dw	L10277-1
	dw	L10245-1
	dw	L10269-1
	dw	L10146-1
	dw	L10262-1
	dw	L10255-1
	dw	L10251-1
	dw	L10236-1
	dw	L10276-1
	dw	L10246-1
	dw	L10242-1
	dw	L10155-1
	dw	L10263-1
	dw	L10256-1
	dw	L10274-1
	dw	L10237-1
	dw	L10119-1
	dw	L10247-1
	dw	L10270-1
	dw	L10204-1
	dw	L10264-1
	dw	L10257-1
	dw	L10241-1
	dw	L10238-1
	dw	L10118-1
	dw	L10248-1
	dw	L10242-1
	dw	L10213-1
	dw	L10265-1
	dw	L10258-1
	dw	L10275-1
	dw	L10239-1
	dw	L10160-1
	dw	L10249-1
	dw	L10271-1
	dw	L10222-1
	dw	L10266-1
	dw	L10259-1
	dw	L10117-1
	dw	L10240-1
	dw	L10161-1
	dw	L10250-1
	dw	L10242-1
	dw	L10231-1
	dw	L10267-1
;  case 0x7F: c->a = c->a; break; // MOV A,A
L10034:
	sep	#$20
	longa	off
	ldy	#$1c
	lda	[<L162+c_0],Y
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
L215:
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
;  case 0x78: c->a = c->b; break; // MOV A,B
L10035:
	sep	#$20
	longa	off
	ldy	#$1d
	lda	[<L162+c_0],Y
	dey
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	bra	L215
;  case 0x79: c->a = c->c; break; // MOV A,C
L10036:
	sep	#$20
	longa	off
	ldy	#$1e
	lda	[<L162+c_0],Y
	dey
	dey
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	bra	L215
;  case 0x7A: c->a = c->d; break; // MOV A,D
L10037:
	sep	#$20
	longa	off
	ldy	#$1f
	lda	[<L162+c_0],Y
	ldy	#$1c
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	bra	L215
;  case 0x7B: c->a = c->e; break; // MOV A,E
L10038:
	sep	#$20
	longa	off
	ldy	#$20
	lda	[<L162+c_0],Y
	ldy	#$1c
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	bra	L215
;  case 0x7C: c->a = c->h; break; // MOV A,H
L10039:
	sep	#$20
	longa	off
	ldy	#$21
	lda	[<L162+c_0],Y
	ldy	#$1c
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	bra	L215
;  case 0x7D: c->a = c->l; break; // MOV A,L
L10040:
	sep	#$20
	longa	off
	ldy	#$22
	lda	[<L162+c_0],Y
	ldy	#$1c
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	bra	L215
;  case 0x7E: c->a = i8080_rb(c, i8080_get_hl(c)); break; // MOV A,M
L10041:
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
	brl	L215
;
;  case 0x0A: c->a = i8080_rb(c, i8080_get_bc(c)); break; // LDAX B
L10042:
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
	brl	L215
;  case 0x1A: c->a = i8080_rb(c, i8080_get_de(c)); break; // LDAX D
L10043:
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
	brl	L215
;  case 0x3A: c->a = i8080_rb(c, i8080_next_word(c)); break; // LDA word
L10044:
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
	brl	L215
;
;  case 0x47: c->b = c->a; break; // MOV B,A
L10045:
	sep	#$20
	longa	off
	ldy	#$1c
	lda	[<L162+c_0],Y
	iny
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x40: c->b = c->b; break; // MOV B,B
L10046:
	sep	#$20
	longa	off
	ldy	#$1d
	lda	[<L162+c_0],Y
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x41: c->b = c->c; break; // MOV B,C
L10047:
	sep	#$20
	longa	off
	ldy	#$1e
	lda	[<L162+c_0],Y
	dey
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x42: c->b = c->d; break; // MOV B,D
L10048:
	sep	#$20
	longa	off
	ldy	#$1f
	lda	[<L162+c_0],Y
	dey
	dey
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x43: c->b = c->e; break; // MOV B,E
L10049:
	sep	#$20
	longa	off
	ldy	#$20
	lda	[<L162+c_0],Y
	ldy	#$1d
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x44: c->b = c->h; break; // MOV B,H
L10050:
	sep	#$20
	longa	off
	ldy	#$21
	lda	[<L162+c_0],Y
	ldy	#$1d
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x45: c->b = c->l; break; // MOV B,L
L10051:
	sep	#$20
	longa	off
	ldy	#$22
	lda	[<L162+c_0],Y
	ldy	#$1d
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x46: c->b = i8080_rb(c, i8080_get_hl(c)); break; // MOV B,M
L10052:
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
	brl	L215
;
;  case 0x4F: c->c = c->a; break; // MOV C,A
L10053:
	sep	#$20
	longa	off
	ldy	#$1c
	lda	[<L162+c_0],Y
	iny
	iny
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x48: c->c = c->b; break; // MOV C,B
L10054:
	sep	#$20
	longa	off
	ldy	#$1d
	lda	[<L162+c_0],Y
	iny
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x49: c->c = c->c; break; // MOV C,C
L10055:
	sep	#$20
	longa	off
	ldy	#$1e
	lda	[<L162+c_0],Y
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x4A: c->c = c->d; break; // MOV C,D
L10056:
	sep	#$20
	longa	off
	ldy	#$1f
	lda	[<L162+c_0],Y
	dey
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x4B: c->c = c->e; break; // MOV C,E
L10057:
	sep	#$20
	longa	off
	ldy	#$20
	lda	[<L162+c_0],Y
	dey
	dey
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x4C: c->c = c->h; break; // MOV C,H
L10058:
	sep	#$20
	longa	off
	ldy	#$21
	lda	[<L162+c_0],Y
	ldy	#$1e
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x4D: c->c = c->l; break; // MOV C,L
L10059:
	sep	#$20
	longa	off
	ldy	#$22
	lda	[<L162+c_0],Y
	ldy	#$1e
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x4E: c->c = i8080_rb(c, i8080_get_hl(c)); break; // MOV C,M
L10060:
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
	brl	L215
;
;  case 0x57: c->d = c->a; break; // MOV D,A
L10061:
	sep	#$20
	longa	off
	ldy	#$1c
	lda	[<L162+c_0],Y
	ldy	#$1f
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x50: c->d = c->b; break; // MOV D,B
L10062:
	sep	#$20
	longa	off
	ldy	#$1d
	lda	[<L162+c_0],Y
	iny
	iny
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x51: c->d = c->c; break; // MOV D,C
L10063:
	sep	#$20
	longa	off
	ldy	#$1e
	lda	[<L162+c_0],Y
	iny
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x52: c->d = c->d; break; // MOV D,D
L10064:
	sep	#$20
	longa	off
	ldy	#$1f
	lda	[<L162+c_0],Y
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x53: c->d = c->e; break; // MOV D,E
L10065:
	sep	#$20
	longa	off
	ldy	#$20
	lda	[<L162+c_0],Y
	dey
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x54: c->d = c->h; break; // MOV D,H
L10066:
	sep	#$20
	longa	off
	ldy	#$21
	lda	[<L162+c_0],Y
	dey
	dey
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x55: c->d = c->l; break; // MOV D,L
L10067:
	sep	#$20
	longa	off
	ldy	#$22
	lda	[<L162+c_0],Y
	ldy	#$1f
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x56: c->d = i8080_rb(c, i8080_get_hl(c)); break; // MOV D,M
L10068:
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
	brl	L215
;
;  case 0x5F: c->e = c->a; break; // MOV E,A
L10069:
	sep	#$20
	longa	off
	ldy	#$1c
	lda	[<L162+c_0],Y
	ldy	#$20
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x58: c->e = c->b; break; // MOV E,B
L10070:
	sep	#$20
	longa	off
	ldy	#$1d
	lda	[<L162+c_0],Y
	ldy	#$20
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x59: c->e = c->c; break; // MOV E,C
L10071:
	sep	#$20
	longa	off
	ldy	#$1e
	lda	[<L162+c_0],Y
	iny
	iny
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x5A: c->e = c->d; break; // MOV E,D
L10072:
	sep	#$20
	longa	off
	ldy	#$1f
	lda	[<L162+c_0],Y
	iny
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x5B: c->e = c->e; break; // MOV E,E
L10073:
	sep	#$20
	longa	off
	ldy	#$20
	lda	[<L162+c_0],Y
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x5C: c->e = c->h; break; // MOV E,H
L10074:
	sep	#$20
	longa	off
	ldy	#$21
	lda	[<L162+c_0],Y
	dey
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x5D: c->e = c->l; break; // MOV E,L
L10075:
	sep	#$20
	longa	off
	ldy	#$22
	lda	[<L162+c_0],Y
	dey
	dey
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x5E: c->e = i8080_rb(c, i8080_get_hl(c)); break; // MOV E,M
L10076:
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
	brl	L215
;
;  case 0x67: c->h = c->a; break; // MOV H,A
L10077:
	sep	#$20
	longa	off
	ldy	#$1c
	lda	[<L162+c_0],Y
	ldy	#$21
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x60: c->h = c->b; break; // MOV H,B
L10078:
	sep	#$20
	longa	off
	ldy	#$1d
	lda	[<L162+c_0],Y
	ldy	#$21
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x61: c->h = c->c; break; // MOV H,C
L10079:
	sep	#$20
	longa	off
	ldy	#$1e
	lda	[<L162+c_0],Y
	ldy	#$21
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x62: c->h = c->d; break; // MOV H,D
L10080:
	sep	#$20
	longa	off
	ldy	#$1f
	lda	[<L162+c_0],Y
	iny
	iny
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x63: c->h = c->e; break; // MOV H,E
L10081:
	sep	#$20
	longa	off
	ldy	#$20
	lda	[<L162+c_0],Y
	iny
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x64: c->h = c->h; break; // MOV H,H
L10082:
	sep	#$20
	longa	off
	ldy	#$21
	lda	[<L162+c_0],Y
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x65: c->h = c->l; break; // MOV H,L
L10083:
	sep	#$20
	longa	off
	ldy	#$22
	lda	[<L162+c_0],Y
	dey
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x66: c->h = i8080_rb(c, i8080_get_hl(c)); break; // MOV H,M
L10084:
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
	brl	L215
;
;  case 0x6F: c->l = c->a; break; // MOV L,A
L10085:
	sep	#$20
	longa	off
	ldy	#$1c
	lda	[<L162+c_0],Y
	ldy	#$22
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x68: c->l = c->b; break; // MOV L,B
L10086:
	sep	#$20
	longa	off
	ldy	#$1d
	lda	[<L162+c_0],Y
	ldy	#$22
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x69: c->l = c->c; break; // MOV L,C
L10087:
	sep	#$20
	longa	off
	ldy	#$1e
	lda	[<L162+c_0],Y
	ldy	#$22
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x6A: c->l = c->d; break; // MOV L,D
L10088:
	sep	#$20
	longa	off
	ldy	#$1f
	lda	[<L162+c_0],Y
	ldy	#$22
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x6B: c->l = c->e; break; // MOV L,E
L10089:
	sep	#$20
	longa	off
	ldy	#$20
	lda	[<L162+c_0],Y
	iny
	iny
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x6C: c->l = c->h; break; // MOV L,H
L10090:
	sep	#$20
	longa	off
	ldy	#$21
	lda	[<L162+c_0],Y
	iny
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x6D: c->l = c->l; break; // MOV L,L
L10091:
	sep	#$20
	longa	off
	ldy	#$22
	lda	[<L162+c_0],Y
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x6E: c->l = i8080_rb(c, i8080_get_hl(c)); break; // MOV L,M
L10092:
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
	brl	L215
;
;  case 0x77: i8080_wb(c, i8080_get_hl(c), c->a); break; // MOV M,A
L10093:
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
	brl	L215
;  case 0x70: i8080_wb(c, i8080_get_hl(c), c->b); break; // MOV M,B
L10094:
	ldy	#$1d
	bra	L20008
;  case 0x71: i8080_wb(c, i8080_get_hl(c), c->c); break; // MOV M,C
L10095:
	ldy	#$1e
	bra	L20008
;  case 0x72: i8080_wb(c, i8080_get_hl(c), c->d); break; // MOV M,D
L10096:
	ldy	#$1f
	bra	L20008
;  case 0x73: i8080_wb(c, i8080_get_hl(c), c->e); break; // MOV M,E
L10097:
	ldy	#$20
	bra	L20008
;  case 0x74: i8080_wb(c, i8080_get_hl(c), c->h); break; // MOV M,H
L10098:
	ldy	#$21
	bra	L20008
;  case 0x75: i8080_wb(c, i8080_get_hl(c), c->l); break; // MOV M,L
L10099:
	ldy	#$22
	bra	L20008
;
;  case 0x3E: c->a = i8080_next_byte(c); break; // MVI A,byte
L10100:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_byte
	sep	#$20
	longa	off
	ldy	#$1c
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x06: c->b = i8080_next_byte(c); break; // MVI B,byte
L10101:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_byte
	sep	#$20
	longa	off
	ldy	#$1d
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x0E: c->c = i8080_next_byte(c); break; // MVI C,byte
L10102:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_byte
	sep	#$20
	longa	off
	ldy	#$1e
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x16: c->d = i8080_next_byte(c); break; // MVI D,byte
L10103:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_byte
	sep	#$20
	longa	off
	ldy	#$1f
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x1E: c->e = i8080_next_byte(c); break; // MVI E,byte
L10104:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_byte
	sep	#$20
	longa	off
	ldy	#$20
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x26: c->h = i8080_next_byte(c); break; // MVI H,byte
L10105:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_byte
	sep	#$20
	longa	off
	ldy	#$21
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x2E: c->l = i8080_next_byte(c); break; // MVI L,byte
L10106:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_byte
	sep	#$20
	longa	off
	ldy	#$22
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x36:
L10107:
;    i8080_wb(c, i8080_get_hl(c), i8080_next_byte(c));
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_byte
;    break; // MVI M,byte
	brl	L20056
;
;  case 0x02: i8080_wb(c, i8080_get_bc(c), c->a); break; // STAX B
L10108:
	ldy	#$1c
	lda	[<L162+c_0],Y
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_bc
	brl	L20060
;  case 0x12: i8080_wb(c, i8080_get_de(c), c->a); break; // STAX D
L10109:
	ldy	#$1c
	lda	[<L162+c_0],Y
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_de
	brl	L20060
;  case 0x32: i8080_wb(c, i8080_next_word(c), c->a); break; // STA word
L10110:
	ldy	#$1c
	lda	[<L162+c_0],Y
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_word
	brl	L20060
;
;  case 0x01: i8080_set_bc(c, i8080_next_word(c)); break; // LXI B,word
L10111:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_word
L20082:
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_set_bc
	brl	L215
;  case 0x11: i8080_set_de(c, i8080_next_word(c)); break; // LXI D,word
L10112:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_word
L20092:
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_set_de
	brl	L215
;  case 0x21: i8080_set_hl(c, i8080_next_word(c)); break; // LXI H,word
L10113:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_word
L20102:
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_set_hl
	brl	L215
;  case 0x31: c->sp = i8080_next_word(c); break; // LXI SP,word
L10114:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_word
L20113:
	ldy	#$1a
L20114:
	sta	[<L162+c_0],Y
	brl	L215
;  case 0x2A: i8080_set_hl(c, i8080_rw(c, i8080_next_word(c))); break; // LHLD
L10115:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_word
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_rw
	bra	L20102
;  case 0x22: i8080_ww(c, i8080_next_word(c), i8080_get_hl(c)); break; // SHLD
L10116:
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
	brl	L215
;  case 0xF9: c->sp = i8080_get_hl(c); break; // SPHL
L10117:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_hl
	bra	L20113
;
;  case 0xEB: i8080_xchg(c); break; // XCHG
L10118:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_xchg
	brl	L215
;  case 0xE3: i8080_xthl(c); break; // XTHL
L10119:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_xthl
	brl	L215
;
;  case 0x87: i8080_add(c, &c->a, c->a, 0); break; // ADD A
L10120:
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
	brl	L215
;  case 0x80: i8080_add(c, &c->a, c->b, 0); break; // ADD B
L10121:
	pea	#<$0
	ldy	#$1d
	bra	L20128
;  case 0x81: i8080_add(c, &c->a, c->c, 0); break; // ADD C
L10122:
	pea	#<$0
	ldy	#$1e
	bra	L20128
;  case 0x82: i8080_add(c, &c->a, c->d, 0); break; // ADD D
L10123:
	pea	#<$0
	ldy	#$1f
	bra	L20128
;  case 0x83: i8080_add(c, &c->a, c->e, 0); break; // ADD E
L10124:
	pea	#<$0
	ldy	#$20
	bra	L20128
;  case 0x84: i8080_add(c, &c->a, c->h, 0); break; // ADD H
L10125:
	pea	#<$0
	ldy	#$21
	bra	L20128
;  case 0x85: i8080_add(c, &c->a, c->l, 0); break; // ADD L
L10126:
	pea	#<$0
	ldy	#$22
	bra	L20128
;  case 0x86:
L10127:
;    i8080_add(c, &c->a, i8080_rb(c, i8080_get_hl(c)), 0);
	pea	#<$0
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_hl
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_rb
;    break; // ADD M
	bra	L20206
;  case 0xC6: i8080_add(c, &c->a, i8080_next_byte(c), 0); break; // ADI byte
L10128:
	pea	#<$0
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_byte
	bra	L20206
;
;  case 0x8F: i8080_add(c, &c->a, c->a, c->cf); break; // ADC A
L10129:
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
;  case 0x88: i8080_add(c, &c->a, c->b, c->cf); break; // ADC B
L10130:
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
;  case 0x89: i8080_add(c, &c->a, c->c, c->cf); break; // ADC C
L10131:
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
;  case 0x8A: i8080_add(c, &c->a, c->d, c->cf); break; // ADC D
L10132:
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
;  case 0x8B: i8080_add(c, &c->a, c->e, c->cf); break; // ADC E
L10133:
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
;  case 0x8C: i8080_add(c, &c->a, c->h, c->cf); break; // ADC H
L10134:
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
;  case 0x8D: i8080_add(c, &c->a, c->l, c->cf); break; // ADC L
L10135:
	ldy	#$23
	lda	[<L162+c_0],Y
	lsr
	lsr
	lsr
	lsr
	and	#<$1
	pha
	bra	L20767
;  case 0x8E:
L10136:
;    i8080_add(c, &c->a, i8080_rb(c, i8080_get_hl(c)), c->cf);
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
;    break; // ADC M
	brl	L20308
;  case 0xCE: i8080_add(c, &c->a, i8080_next_byte(c), c->cf); break; // ACI byte
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
	jsl	~~i8080_next_byte
	brl	L20308
;
;  case 0x97: i8080_sub(c, &c->a, c->a, 0); break; // SUB A
L10138:
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
	brl	L215
;  case 0x90: i8080_sub(c, &c->a, c->b, 0); break; // SUB B
L10139:
	pea	#<$0
	ldy	#$1d
	bra	L20331
;  case 0x91: i8080_sub(c, &c->a, c->c, 0); break; // SUB C
L10140:
	pea	#<$0
	ldy	#$1e
	bra	L20331
;  case 0x92: i8080_sub(c, &c->a, c->d, 0); break; // SUB D
L10141:
	pea	#<$0
	ldy	#$1f
	bra	L20331
;  case 0x93: i8080_sub(c, &c->a, c->e, 0); break; // SUB E
L10142:
	pea	#<$0
	ldy	#$20
	bra	L20331
;  case 0x94: i8080_sub(c, &c->a, c->h, 0); break; // SUB H
L10143:
	pea	#<$0
	ldy	#$21
	bra	L20331
;  case 0x95: i8080_sub(c, &c->a, c->l, 0); break; // SUB L
L10144:
	pea	#<$0
	ldy	#$22
	bra	L20331
;  case 0x96:
L10145:
;    i8080_sub(c, &c->a, i8080_rb(c, i8080_get_hl(c)), 0);
	pea	#<$0
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_hl
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_rb
;    break; // SUB M
	bra	L20409
;  case 0xD6: i8080_sub(c, &c->a, i8080_next_byte(c), 0); break; // SUI byte
L10146:
	pea	#<$0
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_byte
	bra	L20409
;
;  case 0x9F: i8080_sub(c, &c->a, c->a, c->cf); break; // SBB A
L10147:
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
;  case 0x98: i8080_sub(c, &c->a, c->b, c->cf); break; // SBB B
L10148:
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
;  case 0x99: i8080_sub(c, &c->a, c->c, c->cf); break; // SBB C
L10149:
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
;  case 0x9A: i8080_sub(c, &c->a, c->d, c->cf); break; // SBB D
L10150:
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
;  case 0x9B: i8080_sub(c, &c->a, c->e, c->cf); break; // SBB E
L10151:
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
;  case 0x9C: i8080_sub(c, &c->a, c->h, c->cf); break; // SBB H
L10152:
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
;  case 0x9D: i8080_sub(c, &c->a, c->l, c->cf); break; // SBB L
L10153:
	ldy	#$23
	lda	[<L162+c_0],Y
	lsr
	lsr
	lsr
	lsr
	and	#<$1
	pha
	bra	L20768
;  case 0x9E:
L10154:
;    i8080_sub(c, &c->a, i8080_rb(c, i8080_get_hl(c)), c->cf);
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
;    break; // SBB M
	brl	L20511
;  case 0xDE: i8080_sub(c, &c->a, i8080_next_byte(c), c->cf); break; // SBI byte
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
	jsl	~~i8080_next_byte
	brl	L20511
;
;  case 0x09: i8080_dad(c, i8080_get_bc(c)); break; // DAD B
L10156:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_bc
L20524:
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_dad
	brl	L215
;  case 0x19: i8080_dad(c, i8080_get_de(c)); break; // DAD D
L10157:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_de
	bra	L20524
;  case 0x29: i8080_dad(c, i8080_get_hl(c)); break; // DAD H
L10158:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_hl
	bra	L20524
;  case 0x39: i8080_dad(c, c->sp); break; // DAD SP
L10159:
	ldy	#$1a
	lda	[<L162+c_0],Y
	bra	L20524
;
;  case 0xF3: c->iff = 0; break; // DI
L10160:
	ldy	#$23
	lda	[<L162+c_0],Y
	and	#<$ffffffdf
L20531:
	ldy	#$23
	brl	L20114
;  case 0xFB:
L10161:
;    c->iff = 1;
	ldy	#$23
	lda	[<L162+c_0],Y
	ora	#<$20
	sta	[<L162+c_0],Y
;    c->interrupt_delay = 1;
	sep	#$20
	longa	off
	lda	#$1
	ldy	#$26
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
;    break; // EI
	brl	L215
;  case 0x00: break; // NOP
;  case 0x76: c->halted = 1; break; // HLT
L10163:
	ldy	#$23
	lda	[<L162+c_0],Y
	ora	#<$40
	bra	L20531
;
;  case 0x3C: c->a = i8080_inr(c, c->a); break; // INR A
L10164:
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
	brl	L215
;  case 0x04: c->b = i8080_inr(c, c->b); break; // INR B
L10165:
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
	brl	L215
;  case 0x0C: c->c = i8080_inr(c, c->c); break; // INR C
L10166:
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
	brl	L215
;  case 0x14: c->d = i8080_inr(c, c->d); break; // INR D
L10167:
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
	brl	L215
;  case 0x1C: c->e = i8080_inr(c, c->e); break; // INR E
L10168:
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
	brl	L215
;  case 0x24: c->h = i8080_inr(c, c->h); break; // INR H
L10169:
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
	brl	L215
;  case 0x2C: c->l = i8080_inr(c, c->l); break; // INR L
L10170:
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
	brl	L215
;  case 0x34:
L10171:
;    i8080_wb(c, i8080_get_hl(c), i8080_inr(c, i8080_rb(c, i8080_get_hl(c))));
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
;    break; // INR M
	brl	L20056
;
;  case 0x3D: c->a = i8080_dcr(c, c->a); break; // DCR A
L10172:
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
	brl	L215
;  case 0x05: c->b = i8080_dcr(c, c->b); break; // DCR B
L10173:
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
	brl	L215
;  case 0x0D: c->c = i8080_dcr(c, c->c); break; // DCR C
L10174:
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
	brl	L215
;  case 0x15: c->d = i8080_dcr(c, c->d); break; // DCR D
L10175:
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
	brl	L215
;  case 0x1D: c->e = i8080_dcr(c, c->e); break; // DCR E
L10176:
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
	brl	L215
;  case 0x25: c->h = i8080_dcr(c, c->h); break; // DCR H
L10177:
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
	brl	L215
;  case 0x2D: c->l = i8080_dcr(c, c->l); break; // DCR L
L10178:
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
	brl	L215
;  case 0x35:
L10179:
;    i8080_wb(c, i8080_get_hl(c), i8080_dcr(c, i8080_rb(c, i8080_get_hl(c))));
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
;    break; // DCR M
	brl	L20056
;
;  case 0x03: i8080_set_bc(c, i8080_get_bc(c) + 1); break; // INX B
L10180:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_bc
	ina
	brl	L20082
;  case 0x13: i8080_set_de(c, i8080_get_de(c) + 1); break; // INX D
L10181:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_de
	ina
	brl	L20092
;  case 0x23: i8080_set_hl(c, i8080_get_hl(c) + 1); break; // INX H
L10182:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_hl
	ina
	brl	L20102
;  case 0x33: c->sp += 1; break; // INX SP
L10183:
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
	brl	L215
;
;  case 0x0B: i8080_set_bc(c, i8080_get_bc(c) - 1); break; // DCX B
L10184:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_bc
	clc
	adc	#$ffff
	brl	L20082
;  case 0x1B: i8080_set_de(c, i8080_get_de(c) - 1); break; // DCX D
L10185:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_de
	clc
	adc	#$ffff
	brl	L20092
;  case 0x2B: i8080_set_hl(c, i8080_get_hl(c) - 1); break; // DCX H
L10186:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_hl
	clc
	adc	#$ffff
	brl	L20102
;  case 0x3B: c->sp -= 1; break; // DCX SP
L10187:
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
;
;  case 0x27: i8080_daa(c); break; // DAA
L10188:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_daa
	brl	L215
;  case 0x2F: c->a = ~c->a; break; // CMA
L10189:
	sep	#$20
	longa	off
	ldy	#$1c
	lda	[<L162+c_0],Y
	eor	#<$ffffffff
	sta	[<L162+c_0],Y
	rep	#$20
	longa	on
	brl	L215
;  case 0x37: c->cf = 1; break; // STC
L10190:
	ldy	#$23
	lda	[<L162+c_0],Y
	ora	#<$10
	brl	L20531
;  case 0x3F: c->cf = !c->cf; break; // CMC
L10191:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$10
	bne	L165
	inc	<R0
L165:
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
;
;  case 0x07: i8080_rlc(c); break; // RLC (rotate left)
L10192:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_rlc
	brl	L215
;  case 0x0F: i8080_rrc(c); break; // RRC (rotate right)
L10193:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_rrc
	brl	L215
;  case 0x17: i8080_ral(c); break; // RAL
L10194:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_ral
	brl	L215
;  case 0x1F: i8080_rar(c); break; // RAR
L10195:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_rar
	brl	L215
;
;  case 0xA7: i8080_ana(c, c->a); break; // ANA A
L10196:
	ldy	#$1c
L20537:
	lda	[<L162+c_0],Y
L20561:
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_ana
	brl	L215
;  case 0xA0: i8080_ana(c, c->b); break; // ANA B
L10197:
	ldy	#$1d
	bra	L20537
;  case 0xA1: i8080_ana(c, c->c); break; // ANA C
L10198:
	ldy	#$1e
	bra	L20537
;  case 0xA2: i8080_ana(c, c->d); break; // ANA D
L10199:
	ldy	#$1f
	bra	L20537
;  case 0xA3: i8080_ana(c, c->e); break; // ANA E
L10200:
	ldy	#$20
	bra	L20537
;  case 0xA4: i8080_ana(c, c->h); break; // ANA H
L10201:
	ldy	#$21
	bra	L20537
;  case 0xA5: i8080_ana(c, c->l); break; // ANA L
L10202:
	ldy	#$22
	bra	L20537
;  case 0xA6: i8080_ana(c, i8080_rb(c, i8080_get_hl(c))); break; // ANA M
L10203:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_hl
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_rb
	bra	L20561
;  case 0xE6: i8080_ana(c, i8080_next_byte(c)); break; // ANI byte
L10204:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_byte
	bra	L20561
;
;  case 0xAF: i8080_xra(c, c->a); break; // XRA A
L10205:
	ldy	#$1c
L20569:
	lda	[<L162+c_0],Y
L20593:
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_xra
	brl	L215
;  case 0xA8: i8080_xra(c, c->b); break; // XRA B
L10206:
	ldy	#$1d
	bra	L20569
;  case 0xA9: i8080_xra(c, c->c); break; // XRA C
L10207:
	ldy	#$1e
	bra	L20569
;  case 0xAA: i8080_xra(c, c->d); break; // XRA D
L10208:
	ldy	#$1f
	bra	L20569
;  case 0xAB: i8080_xra(c, c->e); break; // XRA E
L10209:
	ldy	#$20
	bra	L20569
;  case 0xAC: i8080_xra(c, c->h); break; // XRA H
L10210:
	ldy	#$21
	bra	L20569
;  case 0xAD: i8080_xra(c, c->l); break; // XRA L
L10211:
	ldy	#$22
	bra	L20569
;  case 0xAE: i8080_xra(c, i8080_rb(c, i8080_get_hl(c))); break; // XRA M
L10212:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_hl
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_rb
	bra	L20593
;  case 0xEE: i8080_xra(c, i8080_next_byte(c)); break; // XRI byte
L10213:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_byte
	bra	L20593
;
;  case 0xB7: i8080_ora(c, c->a); break; // ORA A
L10214:
	ldy	#$1c
L20601:
	lda	[<L162+c_0],Y
L20625:
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_ora
	brl	L215
;  case 0xB0: i8080_ora(c, c->b); break; // ORA B
L10215:
	ldy	#$1d
	bra	L20601
;  case 0xB1: i8080_ora(c, c->c); break; // ORA C
L10216:
	ldy	#$1e
	bra	L20601
;  case 0xB2: i8080_ora(c, c->d); break; // ORA D
L10217:
	ldy	#$1f
	bra	L20601
;  case 0xB3: i8080_ora(c, c->e); break; // ORA E
L10218:
	ldy	#$20
	bra	L20601
;  case 0xB4: i8080_ora(c, c->h); break; // ORA H
L10219:
	ldy	#$21
	bra	L20601
;  case 0xB5: i8080_ora(c, c->l); break; // ORA L
L10220:
	ldy	#$22
	bra	L20601
;  case 0xB6: i8080_ora(c, i8080_rb(c, i8080_get_hl(c))); break; // ORA M
L10221:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_hl
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_rb
	bra	L20625
;  case 0xF6: i8080_ora(c, i8080_next_byte(c)); break; // ORI byte
L10222:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_byte
	bra	L20625
;
;  case 0xBF: i8080_cmp(c, c->a); break; // CMP A
L10223:
	ldy	#$1c
L20633:
	lda	[<L162+c_0],Y
L20657:
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_cmp
	brl	L215
;  case 0xB8: i8080_cmp(c, c->b); break; // CMP B
L10224:
	ldy	#$1d
	bra	L20633
;  case 0xB9: i8080_cmp(c, c->c); break; // CMP C
L10225:
	ldy	#$1e
	bra	L20633
;  case 0xBA: i8080_cmp(c, c->d); break; // CMP D
L10226:
	ldy	#$1f
	bra	L20633
;  case 0xBB: i8080_cmp(c, c->e); break; // CMP E
L10227:
	ldy	#$20
	bra	L20633
;  case 0xBC: i8080_cmp(c, c->h); break; // CMP H
L10228:
	ldy	#$21
	bra	L20633
;  case 0xBD: i8080_cmp(c, c->l); break; // CMP L
L10229:
	ldy	#$22
	bra	L20633
;  case 0xBE: i8080_cmp(c, i8080_rb(c, i8080_get_hl(c))); break; // CMP M
L10230:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_hl
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_rb
	bra	L20657
;  case 0xFE: i8080_cmp(c, i8080_next_byte(c)); break; // CPI byte
L10231:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_byte
	bra	L20657
;
;  case 0xC3: i8080_jmp(c, i8080_next_word(c)); break; // JMP
L10232:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_word
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_jmp
	brl	L215
;  case 0xC2: i8080_cond_jmp(c, c->zf == 0); break; // JNZ
L10233:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$2
L20764:
	bne	L167
L20761:
	inc	<R0
L167:
	pei	<R0
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_cond_jmp
	brl	L215
;  case 0xCA: i8080_cond_jmp(c, c->zf == 1); break; // JZ
L10234:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$2
L20769:
	beq	L167
	bra	L20761
;  case 0xD2: i8080_cond_jmp(c, c->cf == 0); break; // JNC
L10235:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$10
	bra	L20764
;  case 0xDA: i8080_cond_jmp(c, c->cf == 1); break; // JC
L10236:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$10
	bra	L20769
;  case 0xE2: i8080_cond_jmp(c, c->pf == 0); break; // JPO
L10237:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$8
	bra	L20764
;  case 0xEA: i8080_cond_jmp(c, c->pf == 1); break; // JPE
L10238:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$8
	bra	L20769
;  case 0xF2: i8080_cond_jmp(c, c->sf == 0); break; // JP
L10239:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$1
	bra	L20764
;  case 0xFA: i8080_cond_jmp(c, c->sf == 1); break; // JM
L10240:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$1
	bra	L20769
;
;  case 0xE9: c->pc = i8080_get_hl(c); break; // PCHL
L10241:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_hl
	ldy	#$18
	brl	L20114
;  case 0xCD: i8080_call(c, i8080_next_word(c)); break; // CALL
L10242:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_next_word
	pha
L20690:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_call
	brl	L215
;
;  case 0xC4: i8080_cond_call(c, c->zf == 0); break; // CNZ
L10243:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$2
L20765:
	bne	L183
L20762:
	inc	<R0
L183:
	pei	<R0
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_cond_call
	brl	L215
;  case 0xCC: i8080_cond_call(c, c->zf == 1); break; // CZ
L10244:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$2
L20770:
	beq	L183
	bra	L20762
;  case 0xD4: i8080_cond_call(c, c->cf == 0); break; // CNC
L10245:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$10
	bra	L20765
;  case 0xDC: i8080_cond_call(c, c->cf == 1); break; // CC
L10246:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$10
	bra	L20770
;  case 0xE4: i8080_cond_call(c, c->pf == 0); break; // CPO
L10247:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$8
	bra	L20765
;  case 0xEC: i8080_cond_call(c, c->pf == 1); break; // CPE
L10248:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$8
	bra	L20770
;  case 0xF4: i8080_cond_call(c, c->sf == 0); break; // CP
L10249:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$1
	bra	L20765
;  case 0xFC: i8080_cond_call(c, c->sf == 1); break; // CM
L10250:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$1
	bra	L20770
;
;  case 0xC9: i8080_ret(c); break; // RET
L10251:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_ret
	brl	L215
;  case 0xC0: i8080_cond_ret(c, c->zf == 0); break; // RNZ
L10252:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$2
L20766:
	bne	L199
L20763:
	inc	<R0
L199:
	pei	<R0
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_cond_ret
	brl	L215
;  case 0xC8: i8080_cond_ret(c, c->zf == 1); break; // RZ
L10253:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$2
L20771:
	beq	L199
	bra	L20763
;  case 0xD0: i8080_cond_ret(c, c->cf == 0); break; // RNC
L10254:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$10
	bra	L20766
;  case 0xD8: i8080_cond_ret(c, c->cf == 1); break; // RC
L10255:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$10
	bra	L20771
;  case 0xE0: i8080_cond_ret(c, c->pf == 0); break; // RPO
L10256:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$8
	bra	L20766
;  case 0xE8: i8080_cond_ret(c, c->pf == 1); break; // RPE
L10257:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$8
	bra	L20771
;  case 0xF0: i8080_cond_ret(c, c->sf == 0); break; // RP
L10258:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$1
	bra	L20766
;  case 0xF8: i8080_cond_ret(c, c->sf == 1); break; // RM
L10259:
	stz	<R0
	ldy	#$23
	lda	[<L162+c_0],Y
	bit	#$1
	bra	L20771
;
;  case 0xC7: i8080_call(c, 0x00); break; // RST 0
L10260:
	pea	#<$0
	brl	L20690
;  case 0xCF: i8080_call(c, 0x08); break; // RST 1
L10261:
	pea	#<$8
	brl	L20690
;  case 0xD7: i8080_call(c, 0x10); break; // RST 2
L10262:
	pea	#<$10
	brl	L20690
;  case 0xDF: i8080_call(c, 0x18); break; // RST 3
L10263:
	pea	#<$18
	brl	L20690
;  case 0xE7: i8080_call(c, 0x20); break; // RST 4
L10264:
	pea	#<$20
	brl	L20690
;  case 0xEF: i8080_call(c, 0x28); break; // RST 5
L10265:
	pea	#<$28
	brl	L20690
;  case 0xF7: i8080_call(c, 0x30); break; // RST 6
L10266:
	pea	#<$30
	brl	L20690
;  case 0xFF: i8080_call(c, 0x38); break; // RST 7
L10267:
	pea	#<$38
	brl	L20690
;
;  case 0xC5: i8080_push_stack(c, i8080_get_bc(c)); break; // PUSH B
L10268:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_bc
L20757:
	pha
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_push_stack
	brl	L215
;  case 0xD5: i8080_push_stack(c, i8080_get_de(c)); break; // PUSH D
L10269:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_de
	bra	L20757
;  case 0xE5: i8080_push_stack(c, i8080_get_hl(c)); break; // PUSH H
L10270:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_get_hl
	bra	L20757
;  case 0xF5: i8080_push_psw(c); break; // PUSH PSW
L10271:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_push_psw
	brl	L215
;  case 0xC1: i8080_set_bc(c, i8080_pop_stack(c)); break; // POP B
L10272:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_pop_stack
	brl	L20082
;  case 0xD1: i8080_set_de(c, i8080_pop_stack(c)); break; // POP D
L10273:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_pop_stack
	brl	L20092
;  case 0xE1: i8080_set_hl(c, i8080_pop_stack(c)); break; // POP H
L10274:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_pop_stack
	brl	L20102
;  case 0xF1: i8080_pop_psw(c); break; // POP PSW
L10275:
	pei	<L162+c_0+2
	pei	<L162+c_0
	jsl	~~i8080_pop_psw
	brl	L215
;
;  case 0xDB: c->a = c->port_in(c->userdata, i8080_next_byte(c)); break; // IN
L10276:
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
	brl	L215
;  case 0xD3: c->port_out(c->userdata, i8080_next_byte(c), c->a); break; // OUT
L10277:
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
	brl	L215
;
;  case 0x08:
;  case 0x10:
;  case 0x18:
;  case 0x20:
;  case 0x28:
;  case 0x30:
;  case 0x38: break; // undocumented NOPs
;
;  case 0xD9: i8080_ret(c); break; // undocumented RET
;
;  case 0xDD:
;  case 0xED:
;  case 0xFD: i8080_call(c, i8080_next_word(c)); break; // undocumented CALLs
;
;  case 0xCB: i8080_jmp(c, i8080_next_word(c)); break; // undocumented JMP
;  }
;}
L162	equ	12
L163	equ	13
	ends
	efunc
;
;// initialises the emulator with default values
;void i8080_init(i8080* const c) {
	code
	xdef	~~i8080_init
	func
~~i8080_init:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L216
	tcs
	phd
	tcd
c_0	set	4
;  c->read_byte = NULL;
	lda	#$0
	sta	[<L216+c_0]
	ldy	#$2
	sta	[<L216+c_0],Y
;  c->write_byte = NULL;
	iny
	iny
	sta	[<L216+c_0],Y
	iny
	iny
	sta	[<L216+c_0],Y
;  c->port_in = NULL;
	iny
	iny
	sta	[<L216+c_0],Y
	iny
	iny
	sta	[<L216+c_0],Y
;  c->port_out = NULL;
	iny
	iny
	sta	[<L216+c_0],Y
	iny
	iny
	sta	[<L216+c_0],Y
;  c->userdata = NULL;
	iny
	iny
	sta	[<L216+c_0],Y
	iny
	iny
	sta	[<L216+c_0],Y
;
;  c->cyc = 0;
	iny
	iny
	sta	[<L216+c_0],Y
	iny
	iny
	sta	[<L216+c_0],Y
;
;  c->pc = 0;
	iny
	iny
	sta	[<L216+c_0],Y
;  c->sp = 0;
	iny
	iny
	sta	[<L216+c_0],Y
;
;  c->a = 0;
	sep	#$20
	longa	off
	lda	#$0
	iny
	iny
	sta	[<L216+c_0],Y
;  c->b = 0;
	iny
	sta	[<L216+c_0],Y
;  c->c = 0;
	iny
	sta	[<L216+c_0],Y
;  c->d = 0;
	iny
	sta	[<L216+c_0],Y
;  c->e = 0;
	iny
	sta	[<L216+c_0],Y
;  c->h = 0;
	iny
	sta	[<L216+c_0],Y
;  c->l = 0;
	iny
	sta	[<L216+c_0],Y
	rep	#$20
	longa	on
;
;  c->sf = 0;
	iny
	lda	[<L216+c_0],Y
	and	#<$fffffffe
;  c->zf = 0;
	and	#<$fffffffd
;  c->hf = 0;
	and	#<$fffffffb
;  c->pf = 0;
	and	#<$fffffff7
;  c->cf = 0;
	and	#<$ffffffef
;  c->iff = 0;
	and	#<$ffffffdf
;
;  c->halted = 0;
	and	#<$ffffffbf
;  c->interrupt_pending = 0;
	and	#<$ffffff7f
	sta	[<L216+c_0],Y
;  c->interrupt_vector = 0;
	sep	#$20
	longa	off
	lda	#$0
	iny
	iny
	sta	[<L216+c_0],Y
;  c->interrupt_delay = 0;
	iny
	sta	[<L216+c_0],Y
	rep	#$20
	longa	on
;}
	lda	<L216+2
	sta	<L216+2+4
	lda	<L216+1
	sta	<L216+1+4
	pld
	tsc
	clc
	adc	#L216+4
	tcs
	rtl
L216	equ	0
L217	equ	1
	ends
	efunc
;
;// executes one instruction
;void i8080_step(i8080* const c) {
	code
	xdef	~~i8080_step
	func
~~i8080_step:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L219
	tcs
	phd
	tcd
c_0	set	4
;  // interrupt processing: if an interrupt is pending and IFF is set,
;  // we execute the interrupt vector passed by the user.
;  if (c->interrupt_pending && c->iff && c->interrupt_delay == 0) {
	ldy	#$23
	lda	[<L219+c_0],Y
	bit	#$80
	beq	L10290
	lda	[<L219+c_0],Y
	bit	#$20
	beq	L10290
	ldy	#$26
	lda	[<L219+c_0],Y
	and	#$ff
	bne	L10290
;    c->interrupt_pending = 0;
	ldy	#$23
	lda	[<L219+c_0],Y
	and	#<$ffffff7f
;    c->iff = 0;
	and	#<$ffffffdf
;    c->halted = 0;
	and	#<$ffffffbf
	sta	[<L219+c_0],Y
;
;    i8080_execute(c, c->interrupt_vector);
	iny
	iny
	lda	[<L219+c_0],Y
	bra	L20775
;  } else if (!c->halted) {
L10290:
	ldy	#$23
	lda	[<L219+c_0],Y
	bit	#$40
	bne	L225
;    i8080_execute(c, i8080_next_byte(c));
	pei	<L219+c_0+2
	pei	<L219+c_0
	jsl	~~i8080_next_byte
L20775:
	pha
	pei	<L219+c_0+2
	pei	<L219+c_0
	jsl	~~i8080_execute
;  }
;}
L225:
	lda	<L219+2
	sta	<L219+2+4
	lda	<L219+1
	sta	<L219+1+4
	pld
	tsc
	clc
	adc	#L219+4
	tcs
	rtl
L219	equ	0
L220	equ	1
	ends
	efunc
;
;// asks for an interrupt to be serviced
;void i8080_interrupt(i8080* const c, uint8_t opcode) {
	code
	xdef	~~i8080_interrupt
	func
~~i8080_interrupt:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L226
	tcs
	phd
	tcd
c_0	set	4
opcode_0	set	8
;  c->interrupt_pending = 1;
	ldy	#$23
	lda	[<L226+c_0],Y
	ora	#<$80
	sta	[<L226+c_0],Y
;  c->interrupt_vector = opcode;
	sep	#$20
	longa	off
	lda	<L226+opcode_0
	iny
	iny
	sta	[<L226+c_0],Y
	rep	#$20
	longa	on
;}
	lda	<L226+2
	sta	<L226+2+6
	lda	<L226+1
	sta	<L226+1+6
	pld
	tsc
	clc
	adc	#L226+6
	tcs
	rtl
L226	equ	0
L227	equ	1
	ends
	efunc
;
;// outputs a debug trace of the emulator state to the standard output,
;// including registers and flags
;void i8080_debug_output(i8080* const c, bool print_disassembly) {
	code
	xdef	~~i8080_debug_output
	func
~~i8080_debug_output:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L229
	tcs
	phd
	tcd
c_0	set	4
print_disassembly_0	set	8
;  uint8_t f = 0;
;  f |= c->sf << 7;
f_1	set	0
	sep	#$20
	longa	off
	stz	<L230+f_1
	rep	#$20
	longa	on
	ldy	#$23
	lda	[<L229+c_0],Y
	and	#<$1
	ldx	#<$7
	xref	~~~casl
	jsl	~~~casl
	sep	#$20
	longa	off
	tsb	<L230+f_1
	rep	#$20
	longa	on
;  f |= c->zf << 6;
	ldy	#$23
	lda	[<L229+c_0],Y
	lsr
	and	#<$1
	ldx	#<$6
	xref	~~~casl
	jsl	~~~casl
	sep	#$20
	longa	off
	tsb	<L230+f_1
	rep	#$20
	longa	on
;  f |= c->hf << 4;
	ldy	#$23
	lda	[<L229+c_0],Y
	lsr
	lsr
	and	#<$1
	sep	#$20
	longa	off
	asl	A
	asl	A
	asl	A
	asl	A
	tsb	<L230+f_1
	rep	#$20
	longa	on
;  f |= c->pf << 2;
	lda	[<L229+c_0],Y
	lsr
	lsr
	lsr
	and	#<$1
	sep	#$20
	longa	off
	asl	A
	asl	A
	tsb	<L230+f_1
;  f |= 1 << 1; // bit 1 is always 1
	lda	#$2
	tsb	<L230+f_1
	rep	#$20
	longa	on
;  f |= c->cf << 0;
	lda	[<L229+c_0],Y
	lsr
	lsr
	lsr
	lsr
	and	#<$1
	sep	#$20
	longa	off
	tsb	<L230+f_1
	rep	#$20
	longa	on
; 
;  //CYC: %lu",
;  printf("PC: %04X, AF: %04X, BC: %04X, DE: %04X, HL: %04X, SP: %04X",
;      c->pc, c->a << 8 | f, i8080_get_bc(c), i8080_get_de(c), i8080_get_hl(c),
;      c->sp/*, c->cyc*/);
	ldy	#$1a
	lda	[<L229+c_0],Y
	pha
	pei	<L229+c_0+2
	pei	<L229+c_0
	jsl	~~i8080_get_hl
	pha
	pei	<L229+c_0+2
	pei	<L229+c_0
	jsl	~~i8080_get_de
	pha
	pei	<L229+c_0+2
	pei	<L229+c_0
	jsl	~~i8080_get_bc
	pha
	ldy	#$1c
	lda	[<L229+c_0],Y
	and	#$ff
	xba
	and	#$ff00
	sta	<R0
	lda	<L230+f_1
	and	#$ff
	ora	<R0
	pha
	ldy	#$18
	lda	[<L229+c_0],Y
	pha
	pea	#^L1
	pea	#<L1
	pea	#18
	jsl	~~printf
;
;  printf(" (%02X %02X %02X %02X)", i8080_rb(c, c->pc), i8080_rb(c, c->pc + 1),
;      i8080_rb(c, c->pc + 2), i8080_rb(c, c->pc + 3));
	clc
	lda	#$3
	ldy	#$18
	adc	[<L229+c_0],Y
	pha
	pei	<L229+c_0+2
	pei	<L229+c_0
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
	adc	[<L229+c_0],Y
	pha
	pei	<L229+c_0+2
	pei	<L229+c_0
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
	lda	[<L229+c_0],Y
	ina
	pha
	pei	<L229+c_0+2
	pei	<L229+c_0
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
	lda	[<L229+c_0],Y
	pha
	pei	<L229+c_0+2
	pei	<L229+c_0
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
;/*
;  if (print_disassembly) {
;    printf(" - %s", DISASSEMBLE_TABLE[i8080_rb(c, c->pc)]);
;  }
;*/
;  printf("\n");
	pea	#^L1+82
	pea	#<L1+82
	pea	#6
	jsl	~~printf
;}
	lda	<L229+2
	sta	<L229+2+6
	lda	<L229+1
	sta	<L229+1+6
	pld
	tsc
	clc
	adc	#L229+6
	tcs
	rtl
L229	equ	9
L230	equ	9
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
;#undef SET_ZSP
;
	xref	~~fgetc
	xref	~~printf
	xref	~~stdin
