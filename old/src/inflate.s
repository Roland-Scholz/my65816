	module	inflate
	
	xdef	~~inflate
	func
	.include homebrewWDC.inc

	PAGE0

; Local variables

local_vars			equ	1

bit_buffer	                equ	local_vars+0	; 2 byte
last_block			equ	local_vars+2	; 2 byte
tree_ptr			equ	local_vars+4	; 2 byte
base				equ	local_vars+6	; 2 byte
offset				equ	local_vars+8	; 2 byte
last				equ	local_vars+10	; 2 byte
length_ptr			equ	local_vars+12	; 2 byte
sourcePointer			equ	local_vars+14	; 4 byte
rc				equ	local_vars+18	; 2 bytes

LOCAL_BYTES			equ	20


LINKAGE				equ	LOCAL_BYTES+4;

; Pointer to compressed data
inputPointer                    equ	LINKAGE    ; 4 bytes
; Pointer to uncompressed data
outputPointer                   equ	LINKAGE+4  ; 4 bytes
; Pointer to (long) outputLength
outputLength			equ	LINKAGE+8  ; 4 bytes
;
LINKAGE_BYTES			equ	12

MAXBITS				equ	15

		CODE


; Uncompress DEFLATE stream starting from the address stored in inputPointer
; to the memory starting from the address stored in outputPointer
;	org	inflate

~~inflate:
		xref	~~printhex
		xref	~~printchar
		
		longa	on
		longi	on
		
;		sei
	
		tsc			;stack-pointer to accu
		sec			;-9
		sbc	#LOCAL_BYTES
		tcs			;accu to sp
		phd			;save direct
		tcd			;accu to direct
					;stack: 1 + 9(local_vars) + 3(jsl) +8(in/out-pointer)
		
;		ldx	#MAXBITS*2
;inflate_3
;		stz	bitcounts,x
;		dex
;		dex
;		bpl	inflate_3
		
		ldy	#2
		stz	rc		;clear rc
		stz	last_block

		lda	outputLength	;outputLength == NULL?
		ora	outputLength
		beq	inflate_1	;yes, skip length computing
		
		lda	outputPointer	;otherwise copy original pointer
		sta	[outputLength]
		lda	outputPointer+2
		sta	[outputLength],y
		
inflate_1
		dey			;y = 1
;		lda	#1
		sty	bit_buffer	;signal empty buffer
block_loop
		lda	#3*2
		jsr	getBitX
		lsr
		rol	last_block	;if 1, this is last block
		cmp	#2
		beq	call_dynamic
		dec	rc		;rc = -1
		bra	exit

call_dynamic	
		jsr	dynamic_codes
		
		lda	last_block
		beq	block_loop
		
exit:		
;		ldx	#MAXBITS*2
;inflate_4
;		txa
;		lsr
;		jsr	pword
;		lda	bitcounts,x
;		jsr	pword
;		jsr	newline
;		dex
;		dex
;		bpl	inflate_4

		lda	outputLength
		ora	outputLength
		beq	inflate_2
		
		ldy	#2
		sec
		lda	outputPointer
		sbc	[outputLength]
		sta	[outputLength]
		lda	outputPointer+2
		sbc	[outputLength],y
		sta	[outputLength],y

inflate_2
		ldy	rc
		
		lda	<LOCAL_BYTES
		sta	<LOCAL_BYTES+LINKAGE_BYTES
		lda	<LOCAL_BYTES+2
		sta	<LOCAL_BYTES+2+LINKAGE_BYTES
		
		pld
		tsc
		clc
		adc	#LOCAL_BYTES+LINKAGE_BYTES
		tcs
		tya
		rtl

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
;stored
;		lda	#'S'
;		jsr	pout		
;		rts
		
;fixed_codes
;		lda	#'F'
;		jsr	pout
;		rts

;	nlen = bits(s, 5) + 257;
;	ndist = bits(s, 5) + 1;
;	ncode = bits(s, 4) + 4;
;
;
dynamic_codes
		ldy	#6
dynamic_codes_header
		lda	header_bits-2,y
		jsr	getBitX
		adc	header_bases-2,y	;getBitX always C=0
		asl				;*2
		sta	ncode-2,y 
		dey
		dey
		bne	dynamic_codes_header

;/* read code length code lengths (really), missing lengths are zero */
;		ldy	#0
read_temp_length
		lda	#3*2
		jsr	getBitX
dynamic_codes_1
		ldx	order,y
		sta	symbol_length,x
		iny
		iny
		cpy	ncode
		bcc	read_temp_length		
		cpy	#2*19
		bcs	dynamic_codes_0
		lda	#0
		bra	dynamic_codes_1
dynamic_codes_0
		;jsr	plength
		
		lda	#symbol_length
		sta	length_ptr
		lda	#symbol_counts
		sta	tree_ptr
		lda	#19*2
		sta	ncode
		jsr	construct		;construct huffman-tree

		lda	#symbol_counts
		sta	tree_ptr
		clc				;decode length
		lda	nlen
		adc	ndist
		sta	ncode
		ldy	#0
decode_tree_lengths
		jsr	decode
		;jsr	phex
		cmp	#16
		bcs	decode_tree_control
;	length in 0..15	=> symbol
		sta	last			;last length!
		sta	symbol_length,y

		iny
		iny
		cpy	ncode
		bcc	decode_tree_lengths
		bra	decode_tree_control_3
;	16: repeat last length 3..6 times => getBits(2) + 3
;	17: repeat zero 3..10 times	  => getBits(3) + 3
;	18: repeat zero 11..138 times	  => getBits(7) + 11
decode_tree_control
		sbc	#16			;carry=1
		beq	decode_tree_control_1
		stz	last			;last length = 0
decode_tree_control_1
		asl
		tax
		phx
		lda	temp_bits,x
		jsr	getBitX
		plx
		adc	temp_base,x
		tax
		lda	last
decode_tree_control_2		
		sta	symbol_length,y
		iny
		iny
		dex
		bne	decode_tree_control_2
		cpy	ncode
		bcc	decode_tree_lengths
decode_tree_control_3
		;jsr	newline
		;jsr	plength

		lda	nlen			;construct symbol-tree
		sta	ncode
		jsr	construct
		;jsr	ptree
		
		lda	ndist
		sta	ncode
		clc
		lda	#symbol_length		;compute pointer
		adc	nlen			;to distance length
		sta	length_ptr
		lda	#dist_counts
		sta	tree_ptr
		jsr	construct		
		;jsr	ptree
		
		lda	#symbol_counts
		sta	tree_ptr

decode_loop
		jsr	decode
		;jsr	pword
		cmp	#256
		bcs	decode_lendist
		sep	#M
		sta	[outputPointer]
		rep	#M
		inc	outputPointer
		bne	decode_loop
		inc	outputPointer+2
		bra	decode_loop

decode_lendist
		beq	decode_loop_ex		;256 => exit
		
		ldx	#dist_counts		;switch to distance-tree
		stx	tree_ptr

		sbc	#257			;carry is set!
		asl
		tay
		lda	len_bits,y
		beq	decode_lendist_0
		jsr	getBitX
decode_lendist_0
		adc	len_base,y
		sta	nlen
		
		jsr	decode
		asl
		tay
		lda	dist_bits,y
		beq	decode_lendist_1
		jsr	getBitX
decode_lendist_1
		adc	dist_base,y
		sta	sourcePointer
		
		sec
		lda	outputPointer
		sbc	sourcePointer
		sta	sourcePointer
		lda	outputPointer+2
		sbc	#0
		sta	sourcePointer+2

		ldy	#0
		ldx	nlen
		sep	#M
decode_lendist_2
		lda	[sourcePointer],y
		sta	[outputPointer],y
		iny
		dex
		bne	decode_lendist_2
		rep	#M
		
		lda	#symbol_counts		;switch to symbol-tree
		sta	tree_ptr
		
		clc
		tya
		adc	outputPointer
		sta	outputPointer
		bcc	decode_loop
		inc	outputPointer+2
		jmp	decode_loop
decode_loop_ex
		rts
;
;
;
;error
;		brk



;
;
;
construct
		ldy	#MAXBITS*2
		lda	#0
		tax
contruct_0
		sta	(tree_ptr),y	;clear counts
		dey
		dey
		bpl	contruct_0
	
;		ldx	#0
construct_1
		txy
		lda	(length_ptr),y	;count code length
;		jsr	phex
		asl
		tay
		lda	(tree_ptr),y
		ina
		sta	(tree_ptr),y		
		inx
		inx
		cpx	ncode
		bcc	construct_1
	
;		lda	#'C'
;		jsr	pout
;		ldy	#0
;constuct_1a
;		lda	(tree_ptr),y
;		jsr	phex
;		iny
;		iny
;		cpy	#(MAXBITS+1)*2
;		bcc	constuct_1a
;		jsr	newline
	
		stz	offsets+2	;compute offsets from counts
		ldy	#2
construct_2
		clc
		lda	offsets,y
		adc	(tree_ptr),y
		iny
		iny
		sta	offsets,y
		cpy	#MAXBITS*2
		bcc	construct_2
		
;		lda	#'O'
;		jsr	pout
;		ldx	#2
;off_loop
;		lda	offsets,x
;		jsr	phex
;		inx
;		inx
;		cpx	#MAXBITS*2
;		bcc	off_loop
;		beq	off_loop
;		jsr	newline

;     * put symbols in table sorted by length, by symbol order within each
;     * length
		
		
		ldy	#0
construct_3
		lda	(length_ptr),y
		beq	construct_4	;skip if zero
		asl
		tax
		lda	offsets,x
		inc	offsets,x
		asl
		adc	tree_ptr
		tax
		tya
		lsr
		sta	|(MAXBITS+1)*2,x
construct_4	iny
		iny
		cpy	ncode
		bcc	construct_3
				
		rts

;
;
;	
decode		phy
		stz	base
		lda	#0
		ldy	#2
decode_b
		lsr	bit_buffer
		beq	decode_c
decode_d
		rol
		cmp	(tree_ptr),y
		bcc	decode_a
		sbc	(tree_ptr),y	;carry set
		tax
		clc
		lda	base
		adc	(tree_ptr),y
		sta	base
		txa
		iny
		iny
;		cpy	#(MAXBITS+1)*2
		bra	decode_b

decode_a		
		adc	base
		asl
		adc	#(MAXBITS+1)*2
		tay
		lda	(tree_ptr),y
		ply
		rts

decode_c	
		tax
		lda	[inputPointer]
		sta	bit_buffer
		;clc
		lda	inputPointer
		adc	#1			;actually adc #2, carry always set!
		sta	inputPointer
		bcc	decode_e
		inc	inputPointer+2
decode_e
		txa
		sec
		ror	bit_buffer
		bra	decode_d

;
;
;	
getBitX		
		tax
		;inc	bitcounts,x
		lda	bittab-2,x
getBitX1
		lsr	bit_buffer
		beq	getBitX3
getBitX4	
		ror
		bcc	getBitX1

		bit 	#$FF
		bne	getBitX2
		xba
getBitX2
		lsr
		bcc	getBitX2		
		clc
		rts

getBitX3
		tax
		lda	[inputPointer]
		sta	bit_buffer
;		clc
		lda	inputPointer
		adc	#1		;carry always set!
		sta	inputPointer
		bcc	getBit3
		inc	inputPointer+2
getBit3
		txa
		sec
		ror	bit_buffer
		bra	getBitX4
	
	.IF 1=1
ptree		lda	#'T'
		jsr	pout
		ldx	#0
		ldy	#(MAXBITS+1)*2
ptree1		lda	(tree_ptr),y
		jsr	pword
		iny
		iny
		inx
		inx
		cpx	ncode
		bcc	ptree1
		jmp	newline
		
plength		lda	#'L'
		jsr	pout
		lda	ncode
		jsr	pword
		jsr	newline
		ldy	#0
plength1	lda	(length_ptr),y
		jsr	phex
		iny
		iny
		cpy	ncode
		bcc	plength1
		jmp	newline

;
;
;
pword:		php
		xba			;high-byte
		jsr	phex
		xba			;low-byte
		plp

;
;
;		
phex:	
		php
		pha
		pha
		lsr
		lsr
		lsr
		lsr
		and	#15
		jsr	pnibble
		pla
		and	#15
		jsr	pnibble
		lda	#32
		jsr	pout
		pla
		plp
		rts

	
pnibble:
		cmp	#10
		bcc	pnibble1
		adc	#6
pnibble1	
		adc	#'0'
		bne	pout
		
newline:	
		lda	#$0a
pout:	
		sep	#M
		longa	off
		pha
pout1:		lda	>LSR0
		and	#64
		beq	pout1
		pla
		sta	>THR0
		rep	#M
		longa	on
		rts
	.ENDIF
;
;	constants and tables
;
;algo_tab	dw	stored
;		dw	fixed_codes
;		dw	dynamic_codes
;		dw	error

		ENDS
		
		DATA
		
bittab		dw	$8001, $8002, $8004, $8008, $8010, $8020, $8040, $8080
		dw	$8100, $8200, $8400, $8800, $9000, $A000, $C000

header_bits	dw	4*2, 5*2, 5*2
header_bases	dw	4, 1, 257
order		dw	16*2, 17*2, 18*2, 0*2, 8*2, 7*2, 9*2, 6*2
		dw	10*2, 5*2, 11*2, 4*2, 12*2, 3*2, 13*2, 2*2
		dw	14*2, 1*2, 15*2
temp_bits	dw	2*2, 3*2, 7*2
temp_base	dw	3, 3, 11	

;	Size base for length codes 257..285
len_base	dw	3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 15, 17, 19, 23, 27, 31
		dw	35, 43, 51, 59, 67, 83, 99, 115, 131, 163, 195, 227, 258
;	Extra bits for length codes 257..285
len_bits	dw	0, 0, 0, 0, 0, 0, 0, 0, 1*2, 1*2, 1*2, 1*2, 2*2, 2*2, 2*2, 2*2
		dw	3*2, 3*2, 3*2, 3*2, 4*2, 4*2, 4*2, 4*2, 5*2, 5*2, 5*2, 5*2, 0
;	Offset base for distance codes 0..29
dist_base	dw	1, 2, 3, 4, 5, 7, 9, 13, 17, 25, 33, 49, 65, 97, 129, 193
		dw	257, 385, 513, 769, 1025, 1537, 2049, 3073, 4097, 6145
		dw	8193, 12289, 16385, 24577
;	Extra bits for distance codes 0..29
dist_bits	dw	0, 0, 0, 0, 1*2, 1*2, 2*2, 2*2, 3*2, 3*2, 4*2, 4*2, 5*2, 5*2, 6*2, 6*2
		dw	7*2, 7*2, 8*2, 8*2, 9*2, 9*2, 10*2, 10*2, 11*2, 11*2
		dw	12*2, 12*2, 13*2, 13*2

		ENDS
		
		UDATA
		
;	Working storage
ncode		dw	0
ndist		dw	0
nlen		dw	0

symbol_length	dsw	256
len_length	dsw	30
dist_length	dsw	30

symbol_counts	dsw	MAXBITS+1
symbol_tree	dsw	256
		dsw	30

dist_counts	dsw	MAXBITS+1
dist_tree	dsw	30

offsets		dsw	MAXBITS+1
;bitcounts	dsw	MAXBITS+1

		ENDS

		efunc
		endmod