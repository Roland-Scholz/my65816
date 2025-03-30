	module	inflate
	
	xdef	~~inflate
	func
	.include homebrewWDC.inc
	
; inflate - uncompress data stored in the DEFLATE format
; by Piotr Fusik <foxAscene.pl>
; Last modified: 2017-11-07

; Compile with xasm (http://xasm.atari.org/), for example:
; xasm inflate.asx /l /d:inflate=$b700 /d:inflate_data=$b900 /d:inflate_zp=$f0
; inflate is 508 bytes of code and constants
; inflate_data is 765 bytes of uninitialized data
; inflate_zp is 10 bytes on page zero

	PAGE0

inflate_zp			equ	13;

; Pointer to compressed data
inputPointer                    equ	inflate_zp    ; 4 bytes

; Pointer to uncompressed data
outputPointer                   equ	inflate_zp+4  ; 4 bytes

; Local variables

local_vars			equ	1

getBit_buffer                   equ	local_vars+0  ; 1 byte

getBits_base                    equ	local_vars+1  ; 1 byte
inflateStored_pageCounter       equ	local_vars+1  ; 1 byte

inflateDynamic_symbol           equ	local_vars+2  ; 1 byte
inflateDynamic_lastLength       equ	local_vars+3  ; 1 byte
inflateDynamic_tempCodes        equ	local_vars+3  ; 1 byte

inflateCodes_lengthMinus2       equ	local_vars+4  ; 1 byte
inflateDynamic_allCodes         equ	local_vars+4  ; 1 byte

inflateDynamic_primaryCodes     equ	local_vars+5  ; 1 byte

inflateCodes_sourcePointer      equ	local_vars+6  ; 3 bytes

DIRECT_BYTES			equ	9

	CODE

; Argument values for getBits
GET_1_BIT                       equ	$81
GET_2_BITS                      equ	$82
GET_3_BITS                      equ	$84
GET_4_BITS                      equ	$88
GET_5_BITS                      equ	$90
GET_6_BITS                      equ	$a0
GET_7_BITS                      equ	$c0

; Huffman trees
TREE_SIZE                       equ	16
PRIMARY_TREE                    equ	0
DISTANCE_TREE                   equ	TREE_SIZE

; Alphabet
LENGTH_SYMBOLS                  equ	1+29+2
DISTANCE_SYMBOLS                equ	30
CONTROL_SYMBOLS                 equ	LENGTH_SYMBOLS+DISTANCE_SYMBOLS


; Uncompress DEFLATE stream starting from the address stored in inputPointer
; to the memory starting from the address stored in outputPointer
;	org	inflate

~~inflate:
	xref	~~printhex
	xref	~~printchar
	longa	on
	longi	on
	sei

	tsc			;stack-pointer to accu
        sec			;-9
        sbc	#DIRECT_BYTES
        tcs			;accu to sp
        phd			;save direct
        tcd			;accu to direct
				;stack: 1 + 8(local_vars) + 3(jsl) +8(in/out-pointer)

;	pei	inputPointer+2	
;	jsl	~~printhex
;	pei	inputPointer+1
;	jsl	~~printhex
;	pei	inputPointer+0
;	jsl	~~printhex
;	
;	pei	outputPointer+2	
;	jsl	~~printhex
;	pei	outputPointer+1
;	jsl	~~printhex
;	pei	outputPointer+0
;	jsl	~~printhex
		
	sep	#$30

	longa	off
	longi	off
	
	ldy	#0	
	sty	getBit_buffer
inflate_blockLoop
; Get a bit of EOF and two bits of block type
;	ldy	#0	
	sty	getBits_base
	lda	#GET_3_BITS
	jsr	getBits
	
;	rep	#$30
;	pha
;	phx
;	phy
;	pha
;	jsl	~~printhex
;	pea	#$a
;	jsl	~~printchar
;	ply
;	plx
;	pla
;	sep	#$30
	
	lsr	A
	php
	bne	inflateCompressed

; Copy uncompressed block
;	ldy	#0
	sty	getBit_buffer  ; ignore bits until byte boundary
	jsr	getWord        ; skip the length we don't need
	jsr	getWord        ; get the one's complement length
	sta	inflateStored_pageCounter
;	jmp	inflateStored_firstByte
	bcs	inflateStored_firstByte
inflateStored_copyByte
	jsr	getByte
	jsr	storeByte
inflateStored_firstByte
	inx
	bne	inflateStored_copyByte
	inc	inflateStored_pageCounter
	bne	inflateStored_copyByte

inflate_nextBlock
	plp
;	jmp 	exit
	bcc	inflate_blockLoop
	jmp 	exit

inflateCompressed
; A=1: fixed block, initialize with fixed codes
; A=2: dynamic block, start by clearing all code lengths
; A=3: invalid compressed data, not handled in this routine

	eor	#2

;	ldy	#0
inflateCompressed_setCodeLengths
	tax
	beq	inflateCompressed_setLiteralCodeLength
; fixed Huffman literal codes:
; :144 dta 8
; :112 dta 9
	lda	#4
	cpy	#144
	rol	A
inflateCompressed_setLiteralCodeLength
	sta	literalSymbolCodeLength,y
	beq	inflateCompressed_setControlCodeLength
; fixed Huffman control codes:
; :24  dta 7
; :6   dta 8
; :2   dta 8 ; meaningless codes
; :30  dta 5+DISTANCE_TREE
	lda	#5+DISTANCE_TREE
	cpy	#LENGTH_SYMBOLS
	bcs	inflateCompressed_setControlCodeLength
	cpy	#24
	adc	#2-DISTANCE_TREE
inflateCompressed_setControlCodeLength
	cpy	#CONTROL_SYMBOLS
	bcs	label02
	sta	controlSymbolCodeLength,y
label02
	iny
	bne	inflateCompressed_setCodeLengths

	tax
	bne	inflateCodes

; Decompress a block reading Huffman trees first

; Build the tree for temporary codes

	jsr	buildTempHuffmanTree
	
	php
	clc
	lda	inflateDynamic_primaryCodes
	adc	inflateDynamic_allCodes
	sta	inflateDynamic_allCodes
	plp
	
; Use temporary codes to get lengths of literal/length and distance codes
;	ldx	#0
;	sec
inflateDynamic_decodeLength
; C=1: literal codes
; C=0: control codes
	stx	inflateDynamic_symbol
	php
; Fetch a temporary code
	jsr	fetchPrimaryCode
; Temporary code 0..15: put this length
	jsr	phex
	bpl	inflateDynamic_verbatimLength
; Temporary code 16: repeat last length 3 + getBits(2) times
; Temporary code 17: put zero length 3 + getBits(3) times
; Temporary code 18: put zero length 11 + getBits(7) times
	tax
	jsr	getBits
	cpx	#GET_3_BITS
	bcc	inflateDynamic_repeatLast
	beq	label03
	adc	#7
;	ldy	#0
label03
	sty	inflateDynamic_lastLength
inflateDynamic_repeatLast
	tay
	lda	inflateDynamic_lastLength
	iny
	iny
inflateDynamic_verbatimLength
	iny
	plp
	ldx	inflateDynamic_symbol
inflateDynamic_storeLength
	bcc	inflateDynamic_controlSymbolCodeLength
	sta	literalSymbolCodeLength,x
	inx
	cpx	#1
inflateDynamic_storeNext
	dey
	bne	inflateDynamic_storeLength
	sta	inflateDynamic_lastLength
;	jmp	inflateDynamic_decodeLength
	beq	inflateDynamic_decodeLength
	
inflateDynamic_controlSymbolCodeLength
;	cpx	inflateDynamic_primaryCodes
;	bcc	inflateDynamic_storeControl
; the code lengths we skip here were zero-initialized
; in inflateCompressed_setControlCodeLength
;	bne	label04
;	ldx	#LENGTH_SYMBOLS
label04
;	ora	#DISTANCE_TREE
inflateDynamic_storeControl
	sta	controlSymbolCodeLength,x
	inx
	cpx	inflateDynamic_allCodes
	bcc	inflateDynamic_storeNext
	dey
;	ldy	#0

	jsr	newline
	jsr	plength
	
; Decompress a block
inflateCodes
	jsr	buildHuffmanTree	
	
	php
	jsr	ptree
	plp	
	
;	jmp	inflateCodes_loop
	beq	inflateCodes_loop
	

inflateCodes_literal
	jsr	storeByte
inflateCodes_loop
	jsr	fetchPrimaryCode
	
	jsr	phex
	
	bcc	inflateCodes_literal
	bne	label05
	jmp	inflate_nextBlock
; Copy sequence from look-behind buffer
;	ldy	#0
label05
	sty	getBits_base
	cmp	#9
	bcc	inflateCodes_setSequenceLength
	tya
;	lda	#0
	cpx	#1+28
	bcs	inflateCodes_setSequenceLength
	dex
	txa
	lsr	A
	ror	getBits_base
	inc	getBits_base
	lsr	A
	rol	getBits_base
	jsr	getAMinus1BitsMax8
;	sec
	adc	#0
inflateCodes_setSequenceLength
	sta	inflateCodes_lengthMinus2
	ldx	#DISTANCE_TREE
	jsr	fetchCode
	cmp	#4
	bcc	inflateCodes_setOffsetLowByte
	inc	getBits_base
	lsr	A
	jsr	getAMinus1BitsMax8
inflateCodes_setOffsetLowByte
	eor	#$ff
	sta	inflateCodes_sourcePointer
	lda	getBits_base
	cpx	#10
	bcc	inflateCodes_setOffsetHighByte
	lda	getNPlus1Bits_mask-10,x
	jsr	getBits
	clc
inflateCodes_setOffsetHighByte
	eor	#$ff
;	clc
	adc	outputPointer+1
	sta	inflateCodes_sourcePointer+1
	lda	#0
	adc	outputPointer+2
	sta	inflateCodes_sourcePointer+2

	jsr	copyByte
	jsr	copyByte
inflateCodes_copyByte
	jsr	copyByte
	dec	inflateCodes_lengthMinus2
	bne	inflateCodes_copyByte
;	jmp	inflateCodes_loop
	beq	inflateCodes_loop



; Get dynamic block header and use it to build the temporary tree
buildTempHuffmanTree
;	ldy	#0
; numberOfPrimaryCodes = 257 + getBits(5)
; numberOfDistanceCodes = 1 + getBits(5)
; numberOfTemporaryCodes = 4 + getBits(4)
	ldx	#3
inflateDynamic_getHeader
	lda	inflateDynamic_headerBits-1,x
	jsr	getBits

;	sec
	adc	inflateDynamic_headerBase-1,x
	sta	inflateDynamic_tempCodes-1,x
	dex
	bne	inflateDynamic_getHeader

; Get lengths of temporary codes in the order stored in inflateDynamic_tempSymbols
;	ldx	#0
inflateDynamic_getTempCodeLengths
	lda	#GET_3_BITS
	jsr	getBits
	
	ldy	inflateDynamic_tempSymbols,x
	sta	literalSymbolCodeLength,y
	ldy	#0
	inx
	cpx	inflateDynamic_tempCodes
	bcc	inflateDynamic_getTempCodeLengths

; Build Huffman trees basing on code lengths (in bits)
; stored in the *SymbolCodeLength arrays
buildHuffmanTree
; Clear nBitCode_literalCount, nBitCode_controlCount
	tya
;	lda	#0
loop00	sta	nBitCode_clearFrom,y
	iny
	bne	loop00
	
;	sta:rne	nBitCode_clearFrom,y+
; Count number of codes of each length
;	ldy	#0
buildHuffmanTree_countCodeLengths
	ldx	literalSymbolCodeLength,y
	inc	nBitCode_literalCount,x
	bne	label00
	stx	allLiteralsCodeLength
label00	cpy	#CONTROL_SYMBOLS
	bcs	buildHuffmanTree_noControlSymbol
	ldx	controlSymbolCodeLength,y
	inc	nBitCode_controlCount,x
buildHuffmanTree_noControlSymbol
	iny
	bne	buildHuffmanTree_countCodeLengths


; Calculate offsets of symbols sorted by code length
;	lda	#0
	ldx	#-4*TREE_SIZE
buildHuffmanTree_calculateOffsets
	sta	nBitCode_literalOffset+4*TREE_SIZE-$100,x
	clc
	adc	nBitCode_literalCount+4*TREE_SIZE-$100,x
	inx
	bne	buildHuffmanTree_calculateOffsets
; Put symbols in their place in the sorted array
;	ldy	#0
buildHuffmanTree_assignCode


	tya
	ldx	literalSymbolCodeLength,y
	ldy	nBitCode_literalOffset,x
	inc	nBitCode_literalOffset,x
	sta	codeToLiteralSymbol,y
	tay
	cpy	#CONTROL_SYMBOLS
	bcs	buildHuffmanTree_noControlSymbol2
	ldx	controlSymbolCodeLength,y
	ldy	nBitCode_controlOffset,x
	inc	nBitCode_controlOffset,x
	sta	codeToControlSymbol,y
	tay
buildHuffmanTree_noControlSymbol2
	iny
	bne	buildHuffmanTree_assignCode	
	

;l0:	lda	codeToLiteralSymbol,y
;	jsr	phex
;	iny
;	bne	l0

	rts

exit:
	rep	#$30
	longa	on
	longi	on
	
	lda	<DIRECT_BYTES
	sta	<DIRECT_BYTES+8
	lda	<DIRECT_BYTES+2
	sta	<DIRECT_BYTES+2+8
	
	pld
	tsc
	clc
	adc	#DIRECT_BYTES+8
	tcs
	cli
	rtl

	longa 	off
	longi	off

ptree
	ldy	#0
ptree0
	lda	codeToLiteralSymbol,y
	jsr	phex
	iny
	bne	ptree0
	
ptree1
	lda	codeToControlSymbol,y
	jsr	phex
	iny
	cpy	#CONTROL_SYMBOLS
	bne	ptree1
	beq	newline
	

plength
	ldy	#0
plength0
	lda	literalSymbolCodeLength,y
	jsr	phex
	iny
	bne	plength0
	
plength1
	lda	controlSymbolCodeLength,y
	jsr	phex
	iny
	cpy	#CONTROL_SYMBOLS
	bne	plength1
	beq	newline

phex
	php
	pha
	pha
	lsr
	lsr
	lsr
	lsr
	jsr	pnibble
	pla
	and	#15
	jsr	pnibble
	lda	#32
	jsr	pout
	pla
	plp
	rts
	
pnibble
	cmp	#10
	bcc	pnibble1
	adc	#6
pnibble1
	adc	#'0'
	bne	pout
	
newline
	lda	#$0a
pout
	pha
pout1	lda	>LSR0
	and	#64
	beq	pout1
	pla
	sta	>THR0
	rts

; Read Huffman code using the primary tree
fetchPrimaryCode
	ldx	#PRIMARY_TREE
; Read a code from input using the tree specified in X,
; return low byte of this code in A,
; return C flag reset for literal code, set for length code
fetchCode
;	ldy	#0
	tya
fetchCode_nextBit
	jsr	getBit
	rol	A
	inx
	bcs	fetchCode_ge256
; are all 256 literal codes of this length?
	cpx	allLiteralsCodeLength
	beq	fetchCode_allLiterals
; is it literal code of length X?
	sec
	sbc	nBitCode_literalCount,x
	bcs	fetchCode_notLiteral
; literal code
;	clc
	adc	nBitCode_literalOffset,x
	tax
	lda	codeToLiteralSymbol,x
fetchCode_allLiterals
	clc
	rts
; code >= 256, must be control
fetchCode_ge256
;	sec
	sbc	nBitCode_literalCount,x
	sec
; is it control code of length X?
fetchCode_notLiteral
;	sec
	sbc	nBitCode_controlCount,x
	bcs	fetchCode_nextBit
; control code
;	clc
	adc	nBitCode_controlOffset,x
	tax
	lda	codeToControlSymbol,x
	and	#$1f	; make distance symbols zero-based
	tax
;	sec
	rts



; Read A minus 1 bits, but no more than 8
getAMinus1BitsMax8
	rol	getBits_base
	tax
	cmp	#9
	bcs	getByte
	lda	getNPlus1Bits_mask-2,x
getBits
	jsr	getBits_loop
getBits_normalizeLoop
	lsr	getBits_base
	ror	A
	bcc	getBits_normalizeLoop
	rts

; Read 16 bits
getWord
	jsr	getByte
	tax
; Read 8 bits
getByte
	lda	#$80
getBits_loop
	jsr	getBit
	ror	A
	bcc	getBits_loop
	rts

; Read one bit, return in the C flag
getBit
	lsr	getBit_buffer
	bne	getBit_return
	pha
	
;	rep	#$30
;	phx
;	phy
;	pei	inputPointer+2	
;	jsl	~~printhex	
;	pei	inputPointer+1	
;	jsl	~~printhex	
;	pei	inputPointer+0	
;	jsl	~~printhex
;	pea	#$a
;	jsl	~~printchar
;	ply
;	plx
;	sep	#$30

;	ldy	#0
	lda	[inputPointer]	;,y
	inc	inputPointer
	bne	label01
	inc	inputPointer+1
	bne	label01
	inc	inputPointer+2
label01
	sec
	ror	A
	sta	getBit_buffer
	pla
getBit_return
	rts

; Copy a previously written byte
copyByte
	ldy	outputPointer
	lda	[inflateCodes_sourcePointer],y
	ldy	#0
; Write a byte
storeByte
;	ldy	#0
;	pha
;	phx
;	phy
;	rep	#$30
;	pei	outputPointer+2		
;	jsl	~~printhex	
;	pei	outputPointer+1		
;	jsl	~~printhex	
;	pei	outputPointer+0		
;	jsl	~~printhex
;	pea	#$a
;	jsl	~~printchar
;	sep	#$30
;	ply
;	plx
;	pla

	sta	[outputPointer],y
	
	inc	outputPointer
	bne	storeByte_return1
	inc	outputPointer+1
	bne	storeByte_return1
	inc	outputPointer+2
	
storeByte_return1:
	inc	inflateCodes_sourcePointer+1
	bne	storeByte_return
	inc	inflateCodes_sourcePointer+2

storeByte_return
	rts

;	ends
	
;	data

getNPlus1Bits_mask
	db	GET_1_BIT,GET_2_BITS,GET_3_BITS,GET_4_BITS,GET_5_BITS,GET_6_BITS,GET_7_BITS

inflateDynamic_tempSymbols
	db	GET_2_BITS,GET_3_BITS,GET_7_BITS,0,8,7,9,6,10,5,11,4,12,3,13,2,14,1,15

inflateDynamic_headerBits
	db	GET_4_BITS,GET_5_BITS,GET_5_BITS
	
inflateDynamic_headerBase
	db	3,0,0

;	ends
;	udata
; Data for building trees

literalSymbolCodeLength
	DS	256
controlSymbolCodeLength
	DS	CONTROL_SYMBOLS

; Huffman trees

nBitCode_clearFrom:
nBitCode_literalCount:
	DS	2*TREE_SIZE
nBitCode_controlCount:
	DS	2*TREE_SIZE
nBitCode_literalOffset:
	DS	2*TREE_SIZE
nBitCode_controlOffset:
	DS	2*TREE_SIZE
allLiteralsCodeLength:
	DS	1

codeToLiteralSymbol:
	DS	256
codeToControlSymbol:
	DS	CONTROL_SYMBOLS
	
	ends
	efunc
	endmod
	
