;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
;#include <stdio.h>
;#include <stdlib.h>
;#include <string.h>
;
;#include "homebrew.h"
;
;#define WIDTH_MIN	10
;#define WIDTH_MAX	78
;#define HEIGHT_MIN	5
;#define HEIGHT_MAX	23
;
;#define FILEDESC	100
;
;#define VT100_SCREEN_WIDTH		80
;#define VT100_SCREEN_HEIGHT		25
;#define VT100_CHAR_WIDTH		0
;#define VT100_CHAR_HEIGHT		1
;#define VT100_HEIGHT			(term->height)
;#define VT100_WIDTH				(term->width)
;#define MAX_COMMAND_ARGS		4
;#define KEY_ESC					0x1b
;#define KEY_DEL					0x7f
;#define KEY_BELL				0x07
;
;#define STATE(NAME, TERM, EV, ARG)	void NAME(win_t *TERM, uint8_t EV, uint16_t ARG)
;
;// states 
;enum {
;	STATE_IDLE,
;	STATE_ESCAPE,
;	STATE_COMMAND
;};
;
;// events that are passed into states
;enum {
;	EV_CHAR = 1
;};
;
;/*
;static struct vt100 {
;	union flags {
;		uint8_t val;
;		struct {
;			// 0 = cursor remains on last column when it gets there
;			// 1 = lines wrap after last column to next line
;			uint8_t cursor_wrap : 1; 
;			uint8_t scroll_mode : 1;
;			uint8_t origin_mode : 1; 
;		}; 
;	} flags;
;	
;	//uint16_t screen_width, screen_height;
;	// cursor position on the screen (0, 0) = top left corner. 
;	int16_t cursor_x, cursor_y;
;	int16_t saved_cursor_x, saved_cursor_y; // used for cursor save restore
;	int16_t scroll_start_row, scroll_end_row; 
;	// character width and height
;	int8_t char_width, char_height;
;	// colors used for rendering current characters
;	uint16_t back_color, front_color;
;	// the starting y-position of the screen scroll
;	uint16_t scroll_value; 
;	// command arguments that get parsed as they appear in the terminal
;	uint8_t narg; uint16_t args[MAX_COMMAND_ARGS];
;	// current arg pointer (we use it for parsing) 
;	uint8_t carg;
;	
;	void (*state)(win_t *w, uint8_t ev, uint16_t arg);
;	void (*send_response)(char *str);
;	void (*ret_state)(win_t *w, uint8_t ev, uint16_t arg); 
;} term;*/
;
;
;typedef struct window win_t;
;typedef union flags flags_t;
;
;union flags {
;	uint8_t val;
;	struct {
;		// 0 = cursor remains on last column when it gets there
;		// 1 = lines wrap after last column to next line
;		uint8_t cursor_wrap : 1; 
;		uint8_t scroll_mode : 1;
;		uint8_t origin_mode : 1; 
;	} f; 
;};
;	
;
;struct window {
;	flags_t flags;
;	uint16_t x0;
;	uint16_t y0;
;	uint16_t width;
;	uint16_t height;
;	uint16_t z;
;	char title[16];
;	uint16_t fd;
;	win_t *next;
;	win_t *prev;
;	uint16_t cursor_x;
;	uint16_t cursor_y;
;	uint16_t saved_cursor_x;
;	uint16_t saved_cursor_y;
;	uint16_t scroll_start_row;
;	uint16_t scroll_end_row;
;	uint16_t scroll_value; 
;	uint16_t front_color;
;	uint16_t back_color;
;	char data[2000];
;	char *pdata;
;	uint16_t narg;
;	uint16_t args[MAX_COMMAND_ARGS];
;	void (*state)(win_t *w, uint8_t ev, uint16_t arg);
;	void (*send_response)(char *str);
;	void (*ret_state)(win_t *w, uint8_t ev, uint16_t arg); 
;};
;
;struct windows {
;	win_t *anchor;
;	uint16_t maxFileDesc;
;};
;typedef struct windows wins_t;
;
;/*----------------------S T A T I C-------------------*/
;static wins_t wins;
;static const char hextab[] = "0123456789abcdef"; 
	data
~~hextab:
	db	$30,$31,$32,$33,$34,$35,$36,$37,$38,$39
	db	$61,$62,$63,$64,$65,$66,$0
	ends
;static const uint16_t colors[] = {
	data
~~colors:
;	0x0000, // black
	dw	$0
;	0xf800, // red
	dw	$F800
;	0x0780, // green
	dw	$780
;	0xfe00, // yellow
	dw	$FE00
;	0x001f, // blue
	dw	$1F
;	0xf81f, // magenta
	dw	$F81F
;	0x07ff, // cyan
	dw	$7FF
;	0xffff  // white
;};
	dw	$FFFF
	ends
;
;/*----------------------------------------------------*/
;
;
;/*-----------------D E C L A R A T I O N S------------*/
;STATE(_st_idle, term, ev, arg);
;STATE(_st_esc_sq_bracket, term, ev, arg);
;STATE(_st_esc_question, term, ev, arg);
;STATE(_st_esc_hash, term, ev, arg);
;STATE(_st_command_arg, term, ev, arg);
;
;
;
;/*-----------------C O M M O N  F U N C---------------*/
;
;void ili9340_setBackColor(uint16_t col) {
	code
	xdef	~~ili9340_setBackColor
	func
~~ili9340_setBackColor:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
col_0	set	4
;	//debugf("ili9340_setBackColor: %d\n", (long)col);
;}; 
	lda	<L2+2
	sta	<L2+2+2
	lda	<L2+1
	sta	<L2+1+2
	pld
	tsc
	clc
	adc	#L2+2
	tcs
	rtl
L2	equ	0
L3	equ	1
	ends
	efunc
;
;void ili9340_setFrontColor(uint16_t col) {
	code
	xdef	~~ili9340_setFrontColor
	func
~~ili9340_setFrontColor:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L5
	tcs
	phd
	tcd
col_0	set	4
;	//debugf("ili9340_setFrontColor: %d\n", (long)col);
;}; 
	lda	<L5+2
	sta	<L5+2+2
	lda	<L5+1
	sta	<L5+1+2
	pld
	tsc
	clc
	adc	#L5+2
	tcs
	rtl
L5	equ	0
L6	equ	1
	ends
	efunc
;
;void ili9340_fillRect(uint16_t x, uint16_t y, uint16_t w, uint16_t h, uint16_t color) {
	code
	xdef	~~ili9340_fillRect
	func
~~ili9340_fillRect:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L8
	tcs
	phd
	tcd
x_0	set	4
y_0	set	6
w_0	set	8
h_0	set	10
color_0	set	12
;	debugf("ili9340_fillRect: %d %d %d %d %d\n", (long)x, (long)y, (long)w, (long)h, (long)color);
	lda	<L8+color_0
	sta	<R0
	stz	<R0+2
	pei	<R0+2
	pei	<R0
	lda	<L8+h_0
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	lda	<L8+w_0
	sta	<R2
	stz	<R2+2
	pei	<R2+2
	pei	<R2
	lda	<L8+y_0
	sta	<R3
	stz	<R3+2
	pei	<R3+2
	pei	<R3
	lda	<L8+x_0
	sta	<17
	stz	<17+2
	pei	<17+2
	pei	<17
	pea	#^L1
	pea	#<L1
	pea	#26
	jsl	~~debugf
;}; 
	lda	<L8+2
	sta	<L8+2+10
	lda	<L8+1
	sta	<L8+1+10
	pld
	tsc
	clc
	adc	#L8+10
	tcs
	rtl
L8	equ	20
L9	equ	21
	ends
	efunc
	data
L1:
	db	$69,$6C,$69,$39,$33,$34,$30,$5F,$66,$69,$6C,$6C,$52,$65,$63
	db	$74,$3A,$20,$25,$64,$20,$25,$64,$20,$25,$64,$20,$25,$64,$20
	db	$25,$64,$0A,$00
	ends
;
;
;void ili9340_setScrollStart(uint16_t start) {
	code
	xdef	~~ili9340_setScrollStart
	func
~~ili9340_setScrollStart:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L12
	tcs
	phd
	tcd
start_0	set	4
;	debugf("ili9340_setScrollStart: %d\n", (long)start);
	lda	<L12+start_0
	sta	<R0
	stz	<R0+2
	pei	<R0+2
	pei	<R0
	pea	#^L11
	pea	#<L11
	pea	#10
	jsl	~~debugf
;}; 
	lda	<L12+2
	sta	<L12+2+2
	lda	<L12+1
	sta	<L12+1+2
	pld
	tsc
	clc
	adc	#L12+2
	tcs
	rtl
L12	equ	4
L13	equ	5
	ends
	efunc
	data
L11:
	db	$69,$6C,$69,$39,$33,$34,$30,$5F,$73,$65,$74,$53,$63,$72,$6F
	db	$6C,$6C,$53,$74,$61,$72,$74,$3A,$20,$25,$64,$0A,$00
	ends
;
;void ili9340_setScrollMargins(uint16_t top, uint16_t bottom) {
	code
	xdef	~~ili9340_setScrollMargins
	func
~~ili9340_setScrollMargins:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L16
	tcs
	phd
	tcd
top_0	set	4
bottom_0	set	6
;	debugf("ili9340_setScrollMargins: %d %d\n", (long)top, (long)bottom);
	lda	<L16+bottom_0
	sta	<R0
	stz	<R0+2
	pei	<R0+2
	pei	<R0
	lda	<L16+top_0
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	pea	#^L15
	pea	#<L15
	pea	#14
	jsl	~~debugf
;}; 
	lda	<L16+2
	sta	<L16+2+4
	lda	<L16+1
	sta	<L16+1+4
	pld
	tsc
	clc
	adc	#L16+4
	tcs
	rtl
L16	equ	8
L17	equ	9
	ends
	efunc
	data
L15:
	db	$69,$6C,$69,$39,$33,$34,$30,$5F,$73,$65,$74,$53,$63,$72,$6F
	db	$6C,$6C,$4D,$61,$72,$67,$69,$6E,$73,$3A,$20,$25,$64,$20,$25
	db	$64,$0A,$00
	ends
;
;void ili9340_drawChar(win_t *w, uint16_t ch) {
	code
	xdef	~~ili9340_drawChar
	func
~~ili9340_drawChar:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L20
	tcs
	phd
	tcd
w_0	set	4
ch_0	set	8
;	w->data[w->cursor_x + w->cursor_y * 80] = ch;
	ldy	#$27
	lda	[<L20+w_0],Y
	ldx	#<$50
	xref	~~~mul
	jsl	~~~mul
	clc
	ldy	#$25
	adc	[<L20+w_0],Y
	clc
	adc	#$37
	tay
	sep	#$20
	longa	off
	lda	<L20+ch_0
	sta	[<L20+w_0],Y
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
L20	equ	8
L21	equ	9
	ends
	efunc
;
;void ili9340_drawCursor(win_t *w) {
	code
	xdef	~~ili9340_drawCursor
	func
~~ili9340_drawCursor:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L23
	tcs
	phd
	tcd
w_0	set	4
;	w->data[w->cursor_x + w->cursor_y * 80] = '_';
	ldy	#$27
	lda	[<L23+w_0],Y
	ldx	#<$50
	xref	~~~mul
	jsl	~~~mul
	clc
	ldy	#$25
	adc	[<L23+w_0],Y
	clc
	adc	#$37
	tay
	sep	#$20
	longa	off
	lda	#$5f
	sta	[<L23+w_0],Y
	rep	#$20
	longa	on
;}
	lda	<L23+2
	sta	<L23+2+4
	lda	<L23+1
	sta	<L23+1+4
	pld
	tsc
	clc
	adc	#L23+4
	tcs
	rtl
L23	equ	8
L24	equ	9
	ends
	efunc
;
;win_t* findWindow(int fd) {
	code
	xdef	~~findWindow
	func
~~findWindow:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L26
	tcs
	phd
	tcd
fd_0	set	4
;	win_t *w;
;	
;	w = wins.anchor;
w_1	set	0
	lda	|~~wins
	sta	<L27+w_1
	lda	|~~wins+2
L20000:
	sta	<L27+w_1+2
;	while (w) {
	lda	<L27+w_1
	ora	<L27+w_1+2
	bne	L20002
;	
;	strcpy(w->title, "Dummy");
	pea	#^L19
	pea	#<L19
	lda	#$b
	clc
	adc	<L27+w_1
	sta	<R0
	lda	#$0
	adc	<L27+w_1+2
	pha
	pei	<R0
	jsl	~~strcpy
;	
;	return NULL;
	lda	#$0
	tax
	bra	L30
L20002:
;		if (w->fd == fd) return w; 
	ldy	#$1b
	lda	[<L27+w_1],Y
	cmp	<L26+fd_0
	bne	L10003
	ldx	<L27+w_1+2
	lda	<L27+w_1
L30:
	tay
	lda	<L26+2
	sta	<L26+2+2
	lda	<L26+1
	sta	<L26+1+2
	pld
	tsc
	clc
	adc	#L26+2
	tcs
	tya
	rtl
;		w = w->next;
L10003:
	ldy	#$1d
	lda	[<L27+w_1],Y
	sta	<R0
	iny
	iny
	lda	[<L27+w_1],Y
	sta	<R0+2
	lda	<R0
	sta	<L27+w_1
	lda	<R0+2
	bra	L20000
;	}
;}
L26	equ	8
L27	equ	5
	ends
	efunc
	data
L19:
	db	$44,$75,$6D,$6D,$79,$00
	ends
;
;
;void _vt100_reset(win_t *term){
	code
	xdef	~~_vt100_reset
	func
~~_vt100_reset:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L32
	tcs
	phd
	tcd
term_0	set	4
;	//term->char_height = 8;
;	//term->char_width = 6;
;	term->x0 = 0;
	lda	#$0
	ldy	#$1
	sta	[<L32+term_0],Y
;	term->y0 = 0;
	iny
	iny
	sta	[<L32+term_0],Y
;	term->width = 39;
	lda	#$27
	iny
	iny
	sta	[<L32+term_0],Y
;	term->height = 19;
	lda	#$13
	iny
	iny
	sta	[<L32+term_0],Y
;	term->z = 0;
	lda	#$0
	iny
	iny
	sta	[<L32+term_0],Y
;	term->next = NULL;
	ldy	#$1d
	sta	[<L32+term_0],Y
	iny
	iny
	sta	[<L32+term_0],Y
;	term->prev = NULL;
	iny
	iny
	sta	[<L32+term_0],Y
	iny
	iny
	sta	[<L32+term_0],Y
;	term->fd = wins.maxFileDesc;
	lda	|~~wins+4
	ldy	#$1b
	sta	[<L32+term_0],Y
;	term->pdata = term->data;
	lda	#$37
	clc
	adc	<L32+term_0
	sta	<R0
	lda	#$0
	adc	<L32+term_0+2
	sta	<R0+2
	lda	<R0
	ldy	#$807
	sta	[<L32+term_0],Y
	lda	<R0+2
	iny
	iny
	sta	[<L32+term_0],Y
;	term->narg = 0;
	lda	#$0
	iny
	iny
	sta	[<L32+term_0],Y
;	term->state = _st_idle;
	lda	#<~~_st_idle
	ldy	#$815
	sta	[<L32+term_0],Y
	lda	#^~~_st_idle
	iny
	iny
	sta	[<L32+term_0],Y
;	//*term->pdata = '_';
;
;	term->back_color = 0x0000;
	lda	#$0
	ldy	#$35
	sta	[<L32+term_0],Y
;	term->front_color = 0xffff;
	lda	#$ffff
	dey
	dey
	sta	[<L32+term_0],Y
;	term->cursor_x = term->cursor_y = term->saved_cursor_x = term->saved_cursor_y = 0;
	lda	#$0
	ldy	#$2b
	sta	[<L32+term_0],Y
	dey
	dey
	sta	[<L32+term_0],Y
	dey
	dey
	sta	[<L32+term_0],Y
	dey
	dey
	sta	[<L32+term_0],Y
;	term->narg = 0;
	ldy	#$80b
	sta	[<L32+term_0],Y
;	term->state = _st_idle;
	lda	#<~~_st_idle
	ldy	#$815
	sta	[<L32+term_0],Y
	lda	#^~~_st_idle
	iny
	iny
	sta	[<L32+term_0],Y
;	term->ret_state = 0;
	lda	#$0
	ldy	#$81d
	sta	[<L32+term_0],Y
	iny
	iny
	sta	[<L32+term_0],Y
;	term->scroll_value = 0; 
	ldy	#$31
	sta	[<L32+term_0],Y
;	term->scroll_start_row = 0;
	ldy	#$2d
	sta	[<L32+term_0],Y
;	term->scroll_end_row = VT100_HEIGHT - 1; // outside of screen = whole screen scrollable
	clc
	lda	#$ffff
	ldy	#$7
	adc	[<L32+term_0],Y
	ldy	#$2f
	sta	[<L32+term_0],Y
;	term->flags.f.cursor_wrap = 1;
	sep	#$20
	longa	off
	lda	[<L32+term_0]
	ora	#<$1
;	term->flags.f.origin_mode = 0; 
	and	#<$fffffffb
	sta	[<L32+term_0]
	rep	#$20
	longa	on
;	
; 	memset(term->data, ' ', 2000);
	pea	#^$7d0
	pea	#<$7d0
	pea	#<$20
	lda	#$37
	clc
	adc	<L32+term_0
	sta	<R0
	lda	#$0
	adc	<L32+term_0+2
	pha
	pei	<R0
	jsl	~~memset
;   
;	ili9340_setFrontColor(term->front_color);
	ldy	#$33
	lda	[<L32+term_0],Y
	pha
	jsl	~~ili9340_setFrontColor
;	ili9340_setBackColor(term->back_color);
	ldy	#$35
	lda	[<L32+term_0],Y
	pha
	jsl	~~ili9340_setBackColor
;	ili9340_setScrollMargins(0, 0); 
	pea	#<$0
	pea	#<$0
	jsl	~~ili9340_setScrollMargins
;	ili9340_setScrollStart(0);   
	pea	#<$0
	jsl	~~ili9340_setScrollStart
;}
	lda	<L32+2
	sta	<L32+2+4
	lda	<L32+1
	sta	<L32+1+4
	pld
	tsc
	clc
	adc	#L32+4
	tcs
	rtl
L32	equ	4
L33	equ	5
	ends
	efunc
;
;win_t* initWindow() {
	code
	xdef	~~initWindow
	func
~~initWindow:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L35
	tcs
	phd
	tcd
;	win_t *w;
;	
;	w = (win_t *)malloc(sizeof(win_t));
w_1	set	0
	pea	#^$821
	pea	#<$821
	jsl	~~malloc
	sta	<L36+w_1
	stx	<L36+w_1+2
;	if (!w) {
	ora	<L36+w_1+2
	bne	L10004
;		printf("can't alloc window\n");
	pea	#^L31
	pea	#<L31
	pea	#6
	jsl	~~printf
;		return NULL;
	lda	#$0
	tax
L38:
	tay
	pld
	tsc
	clc
	adc	#L35
	tcs
	tya
	rtl
;	}
;	
;	_vt100_reset(w);
L10004:
	pei	<L36+w_1+2
	pei	<L36+w_1
	jsl	~~_vt100_reset
;	wins.maxFileDesc++;
	inc	|~~wins+4
;
;	return w;
	ldx	<L36+w_1+2
	lda	<L36+w_1
	bra	L38
;}
L35	equ	4
L36	equ	1
	ends
	efunc
	data
L31:
	db	$63,$61,$6E,$27,$74,$20,$61,$6C,$6C,$6F,$63,$20,$77,$69,$6E
	db	$64,$6F,$77,$0A,$00
	ends
;
;void printWindow(win_t *w) {
	code
	xdef	~~printWindow
	func
~~printWindow:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L40
	tcs
	phd
	tcd
w_0	set	4
;	printf("Title :%s*\n", w->title);
	lda	#$b
	clc
	adc	<L40+w_0
	sta	<R0
	lda	#$0
	adc	<L40+w_0+2
	pha
	pei	<R0
	pea	#^L39
	pea	#<L39
	pea	#10
	jsl	~~printf
;	printf("   x0 :%d\n", w->x0);
	ldy	#$1
	lda	[<L40+w_0],Y
	pha
	pea	#^L39+12
	pea	#<L39+12
	pea	#8
	jsl	~~printf
;	printf("   y0 :%d\n", w->y0);
	ldy	#$3
	lda	[<L40+w_0],Y
	pha
	pea	#^L39+23
	pea	#<L39+23
	pea	#8
	jsl	~~printf
;	printf("width :%d\n", w->width);
	ldy	#$5
	lda	[<L40+w_0],Y
	pha
	pea	#^L39+34
	pea	#<L39+34
	pea	#8
	jsl	~~printf
;	printf("height:%d\n", w->height);
	ldy	#$7
	lda	[<L40+w_0],Y
	pha
	pea	#^L39+45
	pea	#<L39+45
	pea	#8
	jsl	~~printf
;	printf("     Z:%d\n", w->z);
	ldy	#$9
	lda	[<L40+w_0],Y
	pha
	pea	#^L39+56
	pea	#<L39+56
	pea	#8
	jsl	~~printf
;	printf("    fd:%d\n", w->fd);
	ldy	#$1b
	lda	[<L40+w_0],Y
	pha
	pea	#^L39+67
	pea	#<L39+67
	pea	#8
	jsl	~~printf
;}
	lda	<L40+2
	sta	<L40+2+4
	lda	<L40+1
	sta	<L40+1+4
	pld
	tsc
	clc
	adc	#L40+4
	tcs
	rtl
L40	equ	4
L41	equ	5
	ends
	efunc
	data
L39:
	db	$54,$69,$74,$6C,$65,$20,$3A,$25,$73,$2A,$0A,$00,$20,$20,$20
	db	$78,$30,$20,$3A,$25,$64,$0A,$00,$20,$20,$20,$79,$30,$20,$3A
	db	$25,$64,$0A,$00,$77,$69,$64,$74,$68,$20,$3A,$25,$64,$0A,$00
	db	$68,$65,$69,$67,$68,$74,$3A,$25,$64,$0A,$00,$20,$20,$20,$20
	db	$20,$5A,$3A,$25,$64,$0A,$00,$20,$20,$20,$20,$66,$64,$3A,$25
	db	$64,$0A,$00
	ends
;
;void printWindows() {
	code
	xdef	~~printWindows
	func
~~printWindows:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L44
	tcs
	phd
	tcd
;	win_t *w;
;	
;	w = wins.anchor;
w_1	set	0
	lda	|~~wins
	sta	<L45+w_1
	lda	|~~wins+2
L20003:
	sta	<L45+w_1+2
;	while (w) {
	lda	<L45+w_1
	ora	<L45+w_1+2
	bne	L20005
;}
	pld
	tsc
	clc
	adc	#L44
	tcs
	rtl
L20005:
;		printWindow(w);
	pei	<L45+w_1+2
	pei	<L45+w_1
	jsl	~~printWindow
;		w = w->next;
	ldy	#$1d
	lda	[<L45+w_1],Y
	sta	<R0
	iny
	iny
	lda	[<L45+w_1],Y
	sta	<R0+2
	lda	<R0
	sta	<L45+w_1
	lda	<R0+2
	bra	L20003
;	}
L44	equ	8
L45	equ	5
	ends
	efunc
;
;void foregroundWindow(win_t *fg) {
	code
	xdef	~~foregroundWindow
	func
~~foregroundWindow:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L48
	tcs
	phd
	tcd
fg_0	set	4
;	win_t *w;
;	
;	w = findWindow(fg->fd);
w_1	set	0
	ldy	#$1b
	lda	[<L48+fg_0],Y
	pha
	jsl	~~findWindow
	sta	<L49+w_1
	stx	<L49+w_1+2
;	if (!w) return;
	ora	<L49+w_1+2
	bne	L10007
L51:
	lda	<L48+2
	sta	<L48+2+4
	lda	<L48+1
	sta	<L48+1+4
	pld
	tsc
	clc
	adc	#L48+4
	tcs
	rtl
;	
;	w = wins.anchor;
L10007:
	lda	|~~wins
	sta	<L49+w_1
	lda	|~~wins+2
L20007:
	sta	<L49+w_1+2
;	while (w) {
	lda	<L49+w_1
	ora	<L49+w_1+2
	beq	L51
;
;}
;		if (w->fd == fg->fd)
;			w->z = 0; 
	ldy	#$1b
	lda	[<L49+w_1],Y
	cmp	[<L48+fg_0],Y
	bne	L10010
	lda	#$0
	bra	L20010
;		else
L10010:
;			w->z++;
	ldy	#$9
	lda	[<L49+w_1],Y
	ina
L20010:
	ldy	#$9
	sta	[<L49+w_1],Y
;
;		w = w->next;
	ldy	#$1d
	lda	[<L49+w_1],Y
	sta	<R0
	iny
	iny
	lda	[<L49+w_1],Y
	sta	<R0+2
	lda	<R0
	sta	<L49+w_1
	lda	<R0+2
	bra	L20007
;	}
L48	equ	8
L49	equ	5
	ends
	efunc
;
;void addWindow(win_t *w) {
	code
	xdef	~~addWindow
	func
~~addWindow:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L54
	tcs
	phd
	tcd
w_0	set	4
;	if (wins.anchor != NULL) {
	lda	|~~wins
	ora	|~~wins+2
	beq	L10012
;		w->next = wins.anchor;
	lda	|~~wins
	ldy	#$1d
	sta	[<L54+w_0],Y
	lda	|~~wins+2
	iny
	iny
	sta	[<L54+w_0],Y
;		wins.anchor->prev = w;
	lda	|~~wins
	sta	<R0
	lda	|~~wins+2
	sta	<R0+2
	lda	<L54+w_0
	iny
	iny
	sta	[<R0],Y
	lda	<L54+w_0+2
	iny
	iny
	sta	[<R0],Y
;	}
;	wins.anchor = w;
L10012:
	lda	<L54+w_0
	sta	|~~wins
	lda	<L54+w_0+2
	sta	|~~wins+2
;}
	lda	<L54+2
	sta	<L54+2+4
	lda	<L54+1
	sta	<L54+1+4
	pld
	tsc
	clc
	adc	#L54+4
	tcs
	rtl
L54	equ	4
L55	equ	5
	ends
	efunc
;
;void clearWindow(win_t *w) {
	code
	xdef	~~clearWindow
	func
~~clearWindow:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L58
	tcs
	phd
	tcd
w_0	set	4
;	uint16_t y;
;	char *p;
;	
;	for (y = w->y0; y <= w->height + w->y0 + 1; y++) {
y_1	set	0
p_1	set	2
	ldy	#$3
	lda	[<L58+w_0],Y
	sta	<L59+y_1
	bra	L10016
L10015:
;		p = SCREEN + 80 * y + w->x0;
	ldy	#$1
	lda	[<L58+w_0],Y
	sta	<R0
	stz	<R0+2
	lda	<L59+y_1
	ldx	#<$50
	xref	~~~mul
	jsl	~~~mul
	sta	<R1
	stz	<R1+2
	lda	<R1
	clc
	adc	<R0
	sta	<R2
	lda	<R1+2
	adc	<R0+2
	sta	<R2+2
	lda	#$f000
	clc
	adc	<R2
	sta	<L59+p_1
	lda	#$7f
	adc	<R2+2
	sta	<L59+p_1+2
;		memset(p, ' ', w->width + 2);
	clc
	lda	#$2
	ldy	#$5
	adc	[<L58+w_0],Y
	sta	<R0
	stz	<R0+2
	pei	<R0+2
	pei	<R0
	pea	#<$20
	pei	<L59+p_1+2
	pei	<L59+p_1
	jsl	~~memset
;	}
	inc	<L59+y_1
L10016:
	clc
	ldy	#$7
	lda	[<L58+w_0],Y
	ldy	#$3
	adc	[<L58+w_0],Y
	ina
	cmp	<L59+y_1
	bcs	L10015
;	
;}
	lda	<L58+2
	sta	<L58+2+4
	lda	<L58+1
	sta	<L58+1+4
	pld
	tsc
	clc
	adc	#L58+4
	tcs
	rtl
L58	equ	18
L59	equ	13
	ends
	efunc
;
;void drawWindow(win_t *w) {
	code
	xdef	~~drawWindow
	func
~~drawWindow:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L62
	tcs
	phd
	tcd
w_0	set	4
;	uint16_t i, k;
;	uint16_t tlen;
;	uint16_t tmax;
;	char *p, c;
;	
;	tlen = strlen(w->title);
i_1	set	0
k_1	set	2
tlen_1	set	4
tmax_1	set	6
p_1	set	8
c_1	set	12
	lda	#$b
	clc
	adc	<L62+w_0
	sta	<R0
	lda	#$0
	adc	<L62+w_0+2
	sta	<R0+2
	pha
	pei	<R0
	jsl	~~strlen
	sta	<L63+tlen_1
;	tmax = w->width - 6;
	clc
	lda	#$fffa
	ldy	#$5
	adc	[<L62+w_0],Y
	sta	<L63+tmax_1
;	
;	p = SCREEN + 80 * w->y0 + w->x0;
	ldy	#$1
	lda	[<L62+w_0],Y
	sta	<R0
	stz	<R0+2
	iny
	iny
	lda	[<L62+w_0],Y
	ldx	#<$50
	xref	~~~mul
	jsl	~~~mul
	sta	<R1
	stz	<R1+2
	lda	<R1
	clc
	adc	<R0
	sta	<R2
	lda	<R1+2
	adc	<R0+2
	sta	<R2+2
	lda	#$f000
	clc
	adc	<R2
	sta	<L63+p_1
	lda	#$7f
	adc	<R2+2
	sta	<L63+p_1+2
;	
;	if (tlen > tmax) tlen = tmax;
	lda	<L63+tmax_1
	cmp	<L63+tlen_1
	bcs	L10017
	lda	<L63+tmax_1
	sta	<L63+tlen_1
;	
;
;	/*	185:╣	186:║	187:╗	188:╝	200:╚
;		201:╔	202:╩	203:╦	204:╠	205:═	206:╬	*/
;
;	for (i = 0, k = 0; i <= w->width+1; i++) {
L10017:
	stz	<L63+i_1
	stz	<L63+k_1
	brl	L10021
L10020:
;		if (i == 0) c = 201;
	lda	<L63+i_1
	bne	L10022
	sep	#$20
	longa	off
	lda	#$c9
	sta	<L63+c_1
	rep	#$20
	longa	on
;		if (i > 0) c = 205;
L10022:
	lda	#$0
	cmp	<L63+i_1
	bcs	L10023
	sep	#$20
	longa	off
	lda	#$cd
	sta	<L63+c_1
	rep	#$20
	longa	on
;		if (i > 2 && k < tlen) {
L10023:
	lda	#$2
	cmp	<L63+i_1
	bcs	L10024
	lda	<L63+k_1
	cmp	<L63+tlen_1
	bcs	L10024
;			c = w->title[k];
	lda	#$b
	clc
	adc	<L63+k_1
	tay
	sep	#$20
	longa	off
	lda	[<L62+w_0],Y
	sta	<L63+c_1
	rep	#$20
	longa	on
;			k++;
	inc	<L63+k_1
;		}			
;		if (i == w->width - 5) c = '[';
L10024:
	clc
	lda	#$fffb
	ldy	#$5
	adc	[<L62+w_0],Y
	cmp	<L63+i_1
	bne	L10025
	sep	#$20
	longa	off
	lda	#$5b
	sta	<L63+c_1
	rep	#$20
	longa	on
;		if (i == w->width - 4) c = '_';
L10025:
	clc
	lda	#$fffc
	ldy	#$5
	adc	[<L62+w_0],Y
	cmp	<L63+i_1
	bne	L10026
	sep	#$20
	longa	off
	lda	#$5f
	sta	<L63+c_1
	rep	#$20
	longa	on
;		if (i == w->width - 3) c = '-';
L10026:
	clc
	lda	#$fffd
	ldy	#$5
	adc	[<L62+w_0],Y
	cmp	<L63+i_1
	bne	L10027
	sep	#$20
	longa	off
	lda	#$2d
	sta	<L63+c_1
	rep	#$20
	longa	on
;		if (i == w->width - 2) c = 'X';
L10027:
	clc
	lda	#$fffe
	ldy	#$5
	adc	[<L62+w_0],Y
	cmp	<L63+i_1
	bne	L10028
	sep	#$20
	longa	off
	lda	#$58
	sta	<L63+c_1
	rep	#$20
	longa	on
;		if (i == w->width - 1) c = ']';
L10028:
	clc
	lda	#$ffff
	ldy	#$5
	adc	[<L62+w_0],Y
	cmp	<L63+i_1
	bne	L10029
	sep	#$20
	longa	off
	lda	#$5d
	sta	<L63+c_1
	rep	#$20
	longa	on
;//		if (i == w->width - 0) c = 205;
;		if (i == w->width + 1) c = 187;
L10029:
	ldy	#$5
	lda	[<L62+w_0],Y
	ina
	cmp	<L63+i_1
	bne	L10030
	sep	#$20
	longa	off
	lda	#$bb
	sta	<L63+c_1
	rep	#$20
	longa	on
;
;		if (w->x0 + i < 80) {
L10030:
	clc
	ldy	#$1
	lda	[<L62+w_0],Y
	adc	<L63+i_1
	cmp	#<$50
	bcs	L10018
;			*p = c;
	sep	#$20
	longa	off
	lda	<L63+c_1
	sta	[<L63+p_1]
	rep	#$20
	longa	on
;			p++;
	inc	<L63+p_1
	bne	L10018
	inc	<L63+p_1+2
;		}
;	}
L10018:
	inc	<L63+i_1
L10021:
	ldy	#$5
	lda	[<L62+w_0],Y
	ina
	cmp	<L63+i_1
	bcc	*+5
	brl	L10020
;	
;	for (i = 1; i <= w->height; i++) {
	lda	#$1
	sta	<L63+i_1
	brl	L10035
L10034:
;		p = SCREEN + 80 * (w->y0 + i) + w->x0;
	ldy	#$1
	lda	[<L62+w_0],Y
	sta	<R0
	stz	<R0+2
	clc
	iny
	iny
	lda	[<L62+w_0],Y
	adc	<L63+i_1
	ldx	#<$50
	xref	~~~mul
	jsl	~~~mul
	sta	<R1
	stz	<R1+2
	lda	<R1
	clc
	adc	<R0
	sta	<R2
	lda	<R1+2
	adc	<R0+2
	sta	<R2+2
	lda	#$f000
	clc
	adc	<R2
	sta	<L63+p_1
	lda	#$7f
	adc	<R2+2
	sta	<L63+p_1+2
;		memcpy(p+1, w->data + 80 * (i-1), w->width);
	ldy	#$5
	lda	[<L62+w_0],Y
	sta	<R0
	stz	<R0+2
	pei	<R0+2
	pei	<R0
	lda	<L63+i_1
	ldx	#<$50
	xref	~~~mul
	jsl	~~~mul
	clc
	adc	#$ffb0
	sta	<R1
	stz	<R1+2
	lda	#$37
	clc
	adc	<R1
	sta	<R2
	lda	#$0
	adc	<R1+2
	sta	<R2+2
	lda	<L62+w_0
	clc
	adc	<R2
	sta	<R1
	lda	<L62+w_0+2
	adc	<R2+2
	pha
	pei	<R1
	lda	#$1
	clc
	adc	<L63+p_1
	sta	<R3
	lda	#$0
	adc	<L63+p_1+2
	pha
	pei	<R3
	jsl	~~memcpy
;		*p = 186;
	sep	#$20
	longa	off
	lda	#$ba
	sta	[<L63+p_1]
	rep	#$20
	longa	on
;		p += w->width + 1;
	ldy	#$5
	lda	[<L62+w_0],Y
	ina
	sta	<R0
	stz	<R0+2
	lda	<L63+p_1
	clc
	adc	<R0
	sta	<L63+p_1
	lda	<L63+p_1+2
	adc	<R0+2
	sta	<L63+p_1+2
;		*p = 186;
	sep	#$20
	longa	off
	lda	#$ba
	sta	[<L63+p_1]
	rep	#$20
	longa	on
;	}
	inc	<L63+i_1
L10035:
	ldy	#$7
	lda	[<L62+w_0],Y
	cmp	<L63+i_1
	bcc	*+5
	brl	L10034
;	
;	p = SCREEN + 80 * (w->y0 + w->height + 1) + w->x0;
	ldy	#$1
	lda	[<L62+w_0],Y
	sta	<R0
	stz	<R0+2
	clc
	iny
	iny
	lda	[<L62+w_0],Y
	ldy	#$7
	adc	[<L62+w_0],Y
	ldx	#<$50
	xref	~~~mul
	jsl	~~~mul
	clc
	adc	#$50
	sta	<R1
	stz	<R1+2
	lda	<R1
	clc
	adc	<R0
	sta	<R2
	lda	<R1+2
	adc	<R0+2
	sta	<R2+2
	lda	#$f000
	clc
	adc	<R2
	sta	<L63+p_1
	lda	#$7f
	adc	<R2+2
	sta	<L63+p_1+2
;
;	for (i = 0, k = 0; i <= w->width+1; i++) {
	stz	<L63+i_1
	stz	<L63+k_1
	bra	L10039
L10038:
;		if (i == 0) c = 200;
	lda	<L63+i_1
	bne	L10040
	sep	#$20
	longa	off
	lda	#$c8
	sta	<L63+c_1
	rep	#$20
	longa	on
;		if (i > 0) c = 205;
L10040:
	lda	#$0
	cmp	<L63+i_1
	bcs	L10041
	sep	#$20
	longa	off
	lda	#$cd
	sta	<L63+c_1
	rep	#$20
	longa	on
;		if (i == w->width + 1) c = 188;
L10041:
	ldy	#$5
	lda	[<L62+w_0],Y
	ina
	cmp	<L63+i_1
	bne	L10042
	sep	#$20
	longa	off
	lda	#$bc
	sta	<L63+c_1
	rep	#$20
	longa	on
;		*p = c;
L10042:
	sep	#$20
	longa	off
	lda	<L63+c_1
	sta	[<L63+p_1]
	rep	#$20
	longa	on
;		p++;
	inc	<L63+p_1
	bne	L10036
	inc	<L63+p_1+2
;	}	
L10036:
	inc	<L63+i_1
L10039:
	ldy	#$5
	lda	[<L62+w_0],Y
	ina
	cmp	<L63+i_1
	bcs	L10038
;}
	lda	<L62+2
	sta	<L62+2+4
	lda	<L62+1
	sta	<L62+1+4
	pld
	tsc
	clc
	adc	#L62+4
	tcs
	rtl
L62	equ	29
L63	equ	17
	ends
	efunc
;
;void drawWindows() {
	code
	xdef	~~drawWindows
	func
~~drawWindows:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L85
	tcs
	phd
	tcd
;	win_t *w;
;	
;	w = wins.anchor;
w_1	set	0
	lda	|~~wins
	sta	<L86+w_1
	lda	|~~wins+2
L20011:
	sta	<L86+w_1+2
;	while(w) {
	lda	<L86+w_1
	ora	<L86+w_1+2
	beq	L10045
;	
;	while(w) {
;		if (w->next == NULL) break;
	ldy	#$1d
	lda	[<L86+w_1],Y
	iny
	iny
	ora	[<L86+w_1],Y
	beq	L10045
;		w = w->next;
	dey
	dey
	lda	[<L86+w_1],Y
	sta	<R0
	iny
	iny
	lda	[<L86+w_1],Y
	sta	<R0+2
	lda	<R0
	sta	<L86+w_1
	lda	<R0+2
	bra	L20011
;	}
L20015:
;		drawWindow(w);
	pei	<L86+w_1+2
	pei	<L86+w_1
	jsl	~~drawWindow
;		w = w->prev;
	ldy	#$21
	lda	[<L86+w_1],Y
	sta	<R0
	iny
	iny
	lda	[<L86+w_1],Y
	sta	<R0+2
	lda	<R0
	sta	<L86+w_1
	lda	<R0+2
	sta	<L86+w_1+2
;	}
L10045:
	lda	<L86+w_1
	ora	<L86+w_1+2
	bne	L20015
;}
	pld
	tsc
	clc
	adc	#L85
	tcs
	rtl
L85	equ	8
L86	equ	5
	ends
	efunc
;
;int w_open(char *path, int oflags) {
	code
	xdef	~~w_open
	func
~~w_open:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L91
	tcs
	phd
	tcd
path_0	set	4
oflags_0	set	8
;	
;	uint16_t i;
;	uint16_t tlen;
;	uint16_t state;
;	uint16_t start;
;	win_t *w;
;	char cnum[3];
;
;	w = initWindow();
i_1	set	0
tlen_1	set	2
state_1	set	4
start_1	set	6
w_1	set	8
cnum_1	set	12
	jsl	~~initWindow
	sta	<L92+w_1
	stx	<L92+w_1+2
;	if (!w) return -1;
	ora	<L92+w_1+2
	bne	L10047
	lda	#$ffff
L94:
	tay
	lda	<L91+2
	sta	<L91+2+6
	lda	<L91+1
	sta	<L91+1+6
	pld
	tsc
	clc
	adc	#L91+6
	tcs
	tya
	rtl
;	
;	state = 0;
L10047:
	stz	<L92+state_1
;	start = 0;
	stz	<L92+start_1
;	cnum[2] = 0;
	sep	#$20
	longa	off
	stz	<L92+cnum_1+2
	rep	#$20
	longa	on
;
;	//printf("%s\n", path);
;	
;	for (i = 0;; i++) {
	stz	<L92+i_1
L10050:
;		switch (path[i]) {
	ldy	<L92+i_1
	lda	[<L91+path_0],Y
	and	#$ff
	xref	~~~swt
	jsl	~~~swt
	dw	6
	dw	0
	dw	L10062-1
	dw	44
	dw	L10062-1
	dw	72
	dw	L10059-1
	dw	87
	dw	L10057-1
	dw	88
	dw	L10053-1
	dw	89
	dw	L10055-1
	dw	L10052-1
;			
;		case 'X':
L10053:
;			if (state != 0) {
	lda	<L92+state_1
	beq	L10052
;				start = i;
L20018:
	lda	<L92+i_1
	sta	<L92+start_1
;			}
;			break;
;			break;
L10052:
;		if (path[i] == 0) break;
	ldy	<L92+i_1
	lda	[<L91+path_0],Y
	and	#$ff
	beq	L20016
;		default:
;			break;
;		}
;	}
	inc	<L92+i_1
	bra	L10050
L20016:
;	
;	w->scroll_end_row = w->height;
	ldy	#$7
	lda	[<L92+w_1],Y
	ldy	#$2f
	sta	[<L92+w_1],Y
;	
;	addWindow(w);
	pei	<L92+w_1+2
	pei	<L92+w_1
	jsl	~~addWindow
;	foregroundWindow(w);
	pei	<L92+w_1+2
	pei	<L92+w_1
	jsl	~~foregroundWindow
;	drawWindows();
	jsl	~~drawWindows
;	
;	//printWindow(w);
;	
;	return w->fd;
	ldy	#$1b
	lda	[<L92+w_1],Y
	bra	L94
;		case 'Y':
L10055:
;			if (state != 0) {
	lda	<L92+state_1
	beq	L10052
;				state = 2;
	lda	#$2
L20019:
	sta	<L92+state_1
;				start = i;
	bra	L20018
;			}
;			break;
;		case 'W':
L10057:
;			if (state != 0) {
	lda	<L92+state_1
	beq	L10052
;				state = 3;
	lda	#$3
;				start = i;
	bra	L20019
;			}
;			break;
;		case 'H':
L10059:
;			if (state != 0) {
	lda	<L92+state_1
	beq	L10052
;				state = 4;
	lda	#$4
;				start = i;
	bra	L20019
;			}
;			break;
;		case 0:
;		case ',':
L10062:
;			
;			cnum[0] = path[start+1];
	lda	<L92+start_1
	ina
	tay
	sep	#$20
	longa	off
	lda	[<L91+path_0],Y
	sta	<L92+cnum_1
	rep	#$20
	longa	on
;			cnum[1] = path[start+2];
	lda	#$2
	clc
	adc	<L92+start_1
	tay
	sep	#$20
	longa	off
	lda	[<L91+path_0],Y
	sta	<L92+cnum_1+1
	rep	#$20
	longa	on
;			
;			switch (state) {
	lda	<L92+state_1
	xref	~~~fsw
	jsl	~~~fsw
	dw	0
	dw	5
	dw	L10052-1
	dw	L10065-1
	dw	L10068-1
	dw	L10069-1
	dw	L10070-1
	dw	L10073-1
;			case 0:
L10065:
;				tlen = i;
	lda	<L92+i_1
	sta	<L92+tlen_1
;				if (tlen > 15) tlen = 15;
	lda	#$f
	cmp	<L92+tlen_1
	bcs	L10066
	sta	<L92+tlen_1
;				//printf("tlen: %d\n", tlen);
;				if (tlen) {
L10066:
	lda	<L92+tlen_1
	beq	L10067
;					memset(w->title, 0, sizeof(w->title));
	pea	#^$10
	pea	#<$10
	pea	#<$0
	lda	#$b
	clc
	adc	<L92+w_1
	sta	<R0
	lda	#$0
	adc	<L92+w_1+2
	sta	<R0+2
	pha
	pei	<R0
	jsl	~~memset
;					memcpy(w->title, path, tlen);
	lda	<L92+tlen_1
	sta	<R0
	stz	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L91+path_0+2
	pei	<L91+path_0
	lda	#$b
	clc
	adc	<L92+w_1
	sta	<R1
	lda	#$0
	adc	<L92+w_1+2
	pha
	pei	<R1
	jsl	~~memcpy
;				}
;				state++;
L10067:
	inc	<L92+state_1
;				break;
	brl	L10052
;			case 1:
L10068:
;				w->x0 = atoi(cnum);
	pea	#0
	clc
	tdc
	adc	#<L92+cnum_1
	pha
	jsl	~~atoi
	ldy	#$1
L20020:
	sta	[<L92+w_1],Y
;				//printf("start: %d, end: %d num: %s\n", start, i, cnum);
;				break;
	brl	L10052
;			case 2:
L10069:
;				w->y0 = atoi(cnum);
	pea	#0
	clc
	tdc
	adc	#<L92+cnum_1
	pha
	jsl	~~atoi
	ldy	#$3
;				break;
	bra	L20020
;			case 3:
L10070:
;				w->width = atoi(cnum);
	pea	#0
	clc
	tdc
	adc	#<L92+cnum_1
	pha
	jsl	~~atoi
	ldy	#$5
	sta	[<L92+w_1],Y
;				if (w->width > WIDTH_MAX) w->width = WIDTH_MAX; 
	lda	#$4e
	cmp	[<L92+w_1],Y
	bcs	L10071
	sta	[<L92+w_1],Y
;				if (w->width < WIDTH_MIN) w->width = WIDTH_MIN; 
L10071:
	ldy	#$5
	lda	[<L92+w_1],Y
	cmp	#<$a
	bcc	*+5
	brl	L10052
	lda	#$a
;				
;				break;
	bra	L20020
;			case 4:
L10073:
;				w->height = atoi(cnum);
	pea	#0
	clc
	tdc
	adc	#<L92+cnum_1
	pha
	jsl	~~atoi
	ldy	#$7
	sta	[<L92+w_1],Y
;				if (w->height > HEIGHT_MAX) w->height = HEIGHT_MAX; 
	lda	#$17
	cmp	[<L92+w_1],Y
	bcs	L10074
	sta	[<L92+w_1],Y
;				if (w->height < HEIGHT_MIN) w->height = HEIGHT_MIN; 
L10074:
	ldy	#$7
	lda	[<L92+w_1],Y
	cmp	#<$5
	bcc	*+5
	brl	L10052
	lda	#$5
;				break;
	bra	L20020
;			default:
;				break;
;			}
;}
L91	equ	23
L92	equ	9
	ends
	efunc
;
;int w_close(int fd) {
	code
	xdef	~~w_close
	func
~~w_close:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L106
	tcs
	phd
	tcd
fd_0	set	4
;	win_t *w, *pred;
;	
;	w = findWindow(fd);
w_1	set	0
pred_1	set	4
	pei	<L106+fd_0
	jsl	~~findWindow
	sta	<L107+w_1
	stx	<L107+w_1+2
;	if (w) {
	ora	<L107+w_1+2
	beq	L111
;		if (w == wins.anchor) {
	lda	<L107+w_1
	cmp	|~~wins
	bne	L109
	lda	<L107+w_1+2
	cmp	|~~wins+2
L109:
	bne	L10079
;			wins.anchor = w->next;
	ldy	#$1d
	lda	[<L107+w_1],Y
	sta	|~~wins
	iny
	iny
	lda	[<L107+w_1],Y
	sta	|~~wins+2
;			w->next->prev = NULL;
	dey
	dey
	lda	[<L107+w_1],Y
	sta	<R0
	iny
	iny
	lda	[<L107+w_1],Y
	sta	<R0+2
	lda	#$0
	iny
	iny
	sta	[<R0],Y
	bra	L20022
;		} else {
L10079:
;			w->prev->next = w->next;
	ldy	#$21
	lda	[<L107+w_1],Y
	sta	<R0
	iny
	iny
	lda	[<L107+w_1],Y
	sta	<R0+2
	ldy	#$1d
	lda	[<L107+w_1],Y
	sta	[<R0],Y
	iny
	iny
	lda	[<L107+w_1],Y
	sta	[<R0],Y
;			w->next->prev = w->prev;
	dey
	dey
	lda	[<L107+w_1],Y
	sta	<R0
	iny
	iny
	lda	[<L107+w_1],Y
	sta	<R0+2
	iny
	iny
	lda	[<L107+w_1],Y
	sta	[<R0],Y
	iny
	iny
	lda	[<L107+w_1],Y
L20022:
	ldy	#$23
	sta	[<R0],Y
;		}
;		clearWindow(w);
	pei	<L107+w_1+2
	pei	<L107+w_1
	jsl	~~clearWindow
;		free(w);
	pei	<L107+w_1+2
	pei	<L107+w_1
	jsl	~~free
;		drawWindows();
	jsl	~~drawWindows
;	}
;}
L111:
	tay
	lda	<L106+2
	sta	<L106+2+2
	lda	<L106+1
	sta	<L106+1+2
	pld
	tsc
	clc
	adc	#L106+2
	tcs
	tya
	rtl
L106	equ	12
L107	equ	5
	ends
	efunc
;
;#define VT100_CURSOR_X(TERM) (TERM->cursor_x)
;
;uint16_t VT100_CURSOR_Y(win_t *t){
	code
	xdef	~~VT100_CURSOR_Y
	func
~~VT100_CURSOR_Y:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L112
	tcs
	phd
	tcd
t_0	set	4
;	uint16_t scroll_height;
;	uint16_t row;
;	
;	// if within the top or bottom margin areas then normal addressing
;	if(t->cursor_y < t->scroll_start_row || t->cursor_y >= t->scroll_end_row){
scroll_height_1	set	0
row_1	set	2
	ldy	#$27
	lda	[<L112+t_0],Y
	ldy	#$2d
	cmp	[<L112+t_0],Y
	bcc	L114
	ldy	#$27
	lda	[<L112+t_0],Y
	ldy	#$2f
	cmp	[<L112+t_0],Y
	bcc	L10081
L114:
;		return t->cursor_y * VT100_CHAR_HEIGHT; 
	ldy	#$27
	lda	[<L112+t_0],Y
L117:
	tay
	lda	<L112+2
	sta	<L112+2+4
	lda	<L112+1
	sta	<L112+1+4
	pld
	tsc
	clc
	adc	#L112+4
	tcs
	tya
	rtl
;	} else {
L10081:
;		// otherwise we are inside scroll area
;		scroll_height = t->scroll_end_row - t->scroll_start_row;
	sec
	ldy	#$2f
	lda	[<L112+t_0],Y
	dey
	dey
	sbc	[<L112+t_0],Y
	sta	<L113+scroll_height_1
;		row = t->cursor_y + t->scroll_value; 
	clc
	ldy	#$27
	lda	[<L112+t_0],Y
	ldy	#$31
	adc	[<L112+t_0],Y
	sta	<L113+row_1
;		if(t->cursor_y + t->scroll_value >= t->scroll_end_row)
;			row -= scroll_height; 
	clc
	ldy	#$27
	lda	[<L112+t_0],Y
	ldy	#$31
	adc	[<L112+t_0],Y
	dey
	dey
	cmp	[<L112+t_0],Y
	bcc	L10082
	sec
	lda	<L113+row_1
	sbc	<L113+scroll_height_1
	sta	<L113+row_1
;		return row * VT100_CHAR_HEIGHT; 
L10082:
	lda	<L113+row_1
	bra	L117
;	}
;
;}
L112	equ	8
L113	equ	5
	ends
	efunc
;
;
;void _vt100_clearLines(win_t *t, uint16_t start_line, uint16_t end_line){
	code
	xdef	~~_vt100_clearLines
	func
~~_vt100_clearLines:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L119
	tcs
	phd
	tcd
t_0	set	4
start_line_0	set	8
end_line_0	set	10
;	int c, cy;
;	debugf("_vt100_clearLines start_line:%d, end_line:%d\n", (long)start_line, (long)end_line);
c_1	set	0
cy_1	set	2
	lda	<L119+end_line_0
	sta	<R0
	stz	<R0+2
	pei	<R0+2
	pei	<R0
	lda	<L119+start_line_0
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	pea	#^L43
	pea	#<L43
	pea	#14
	jsl	~~debugf
;	
;	for(c = start_line; c <= end_line; c++){
	lda	<L119+start_line_0
	sta	<L120+c_1
	bra	L10086
L10085:
;		cy = t->cursor_y;
	ldy	#$27
	lda	[<L119+t_0],Y
	sta	<L120+cy_1
;		t->cursor_y = c; 
	lda	<L120+c_1
	sta	[<L119+t_0],Y
;		ili9340_fillRect(0, VT100_CURSOR_Y(t), VT100_SCREEN_WIDTH, VT100_CHAR_HEIGHT, 0x0000);
	pea	#<$0
	pea	#<$1
	pea	#<$50
	pei	<L119+t_0+2
	pei	<L119+t_0
	jsl	~~VT100_CURSOR_Y
	pha
	pea	#<$0
	jsl	~~ili9340_fillRect
;		t->cursor_y = cy;
	lda	<L120+cy_1
	ldy	#$27
	sta	[<L119+t_0],Y
;	}
	inc	<L120+c_1
L10086:
	lda	<L119+end_line_0
	cmp	<L120+c_1
	bcs	L10085
;}
	lda	<L119+2
	sta	<L119+2+8
	lda	<L119+1
	sta	<L119+1+8
	pld
	tsc
	clc
	adc	#L119+8
	tcs
	rtl
L119	equ	12
L120	equ	9
	ends
	efunc
	data
L43:
	db	$5F,$76,$74,$31,$30,$30,$5F,$63,$6C,$65,$61,$72,$4C,$69,$6E
	db	$65,$73,$20,$73,$74,$61,$72,$74,$5F,$6C,$69,$6E,$65,$3A,$25
	db	$64,$2C,$20,$65,$6E,$64,$5F,$6C,$69,$6E,$65,$3A,$25,$64,$0A
	db	$00
	ends
;
;
;// scrolls the scroll region up (lines > 0) or down (lines < 0)
;void _vt100_scroll(win_t *t, int16_t lines){
	code
	xdef	~~_vt100_scroll
	func
~~_vt100_scroll:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L124
	tcs
	phd
	tcd
t_0	set	4
lines_0	set	8
;	uint16_t scroll_height;
;	uint16_t scroll_start;
;	uint8_t *srcp, *dstp;
;	
;	if(!lines) return;
scroll_height_1	set	0
scroll_start_1	set	2
srcp_1	set	4
dstp_1	set	8
	lda	<L124+lines_0
	bne	L10087
L127:
	lda	<L124+2
	sta	<L124+2+6
	lda	<L124+1
	sta	<L124+1+6
	pld
	tsc
	clc
	adc	#L124+6
	tcs
	rtl
;
;	// get height of scroll area in rows
;	scroll_height = t->scroll_end_row - t->scroll_start_row; 
L10087:
	sec
	ldy	#$2f
	lda	[<L124+t_0],Y
	dey
	dey
	sbc	[<L124+t_0],Y
	sta	<L125+scroll_height_1
;	// clearing of lines that we have scrolled up or down
;	
;	
;	if(lines > 0){
	sec
	lda	#$0
	sbc	<L124+lines_0
	bvs	L128
	eor	#$8000
L128:
	bpl	*+5
	brl	L10088
;		//_vt100_clearLines(t, t->scroll_start_row, t->scroll_start_row+lines-1); 
;		// update the scroll value (wraps around scroll_height)
;		//t->scroll_value = (t->scroll_value + lines) % scroll_height;
;		// scrolling up so clear first line of scroll area
;		//uint16_t y = (t->scroll_start_row + t->scroll_value) * VT100_CHAR_HEIGHT; 
;		//ili9340_fillRect(0, y, VT100_SCREEN_WIDTH, lines * VT100_CHAR_HEIGHT, 0x0000);
;		
;		dstp = t->data + t->scroll_start_row * 80;
	ldy	#$2d
	lda	[<L124+t_0],Y
	ldx	#<$50
	xref	~~~mul
	jsl	~~~mul
	sta	<R0
	stz	<R0+2
	lda	#$37
	clc
	adc	<R0
	sta	<R1
	lda	#$0
	adc	<R0+2
	sta	<R1+2
	lda	<L124+t_0
	clc
	adc	<R1
	sta	<L125+dstp_1
	lda	<L124+t_0+2
	adc	<R1+2
	sta	<L125+dstp_1+2
;		srcp = dstp + 80;
	lda	#$50
	clc
	adc	<L125+dstp_1
	sta	<L125+srcp_1
	lda	#$0
	adc	<L125+dstp_1+2
	sta	<L125+srcp_1+2
;		memmove(dstp, srcp, (t->scroll_end_row - t->scroll_start_row - 1) * 80);
	sec
	ldy	#$2f
	lda	[<L124+t_0],Y
	dey
	dey
	sbc	[<L124+t_0],Y
	ldx	#<$50
	xref	~~~mul
	jsl	~~~mul
	clc
	adc	#$ffb0
	sta	<R0
	stz	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L125+srcp_1+2
	pei	<L125+srcp_1
	pei	<L125+dstp_1+2
	pei	<L125+dstp_1
	jsl	~~memmove
;		memset(t->data + (t->scroll_end_row - 1) * 80, ' ', 80); 
	pea	#^$50
	pea	#<$50
	pea	#<$20
	ldy	#$2f
	lda	[<L124+t_0],Y
	ldx	#<$50
	xref	~~~mul
	jsl	~~~mul
	clc
	adc	#$ffb0
	sta	<R0
	stz	<R0+2
	lda	#$37
	clc
	adc	<R0
	sta	<R1
	lda	#$0
	adc	<R0+2
	sta	<R1+2
	lda	<L124+t_0
	clc
	adc	<R1
	sta	<R0
	lda	<L124+t_0+2
	adc	<R1+2
	pha
	pei	<R0
	jsl	~~memset
;	} else if(lines < 0){
	brl	L127
L10088:
	lda	<L124+lines_0
	bmi	*+5
	brl	L127
;		_vt100_clearLines(t, t->scroll_end_row - lines, t->scroll_end_row - 1); 
	clc
	lda	#$ffff
	ldy	#$2f
	adc	[<L124+t_0],Y
	pha
	sec
	lda	[<L124+t_0],Y
	sbc	<L124+lines_0
	pha
	pei	<L124+t_0+2
	pei	<L124+t_0
	jsl	~~_vt100_clearLines
;		// make sure that the value wraps down 
;		//t->scroll_value = (scroll_height + t->scroll_value + lines) % scroll_height; 
;		// scrolling down - so clear last line of the scroll area
;		//uint16_t y = (t->scroll_start_row + t->scroll_value) * VT100_CHAR_HEIGHT; 
;		//ili9340_fillRect(0, y, VT100_SCREEN_WIDTH, lines * VT100_CHAR_HEIGHT, 0x0000);
;	}
;	/*
;	scroll_start = (t->scroll_start_row + t->scroll_value) * VT100_CHAR_HEIGHT; 
;	
;	ili9340_setScrollStart(scroll_start); 
;	*/
;	
;	
;	//debugf("_vt100_scroll line:%d, scr_height:%d, scr_start_row:%d, scr_end_row:%d \n", (long)lines, (long)scroll_height, (long)t->scroll_start_row, (long)t->scroll_end_row);
;	
;}
	brl	L127
L124	equ	20
L125	equ	9
	ends
	efunc
;
;
;// moves the cursor relative to current cursor position and scrolls the screen
;void _vt100_move(win_t *term, int16_t right_left, int16_t bottom_top){
	code
	xdef	~~_vt100_move
	func
~~_vt100_move:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L131
	tcs
	phd
	tcd
term_0	set	4
right_left_0	set	8
bottom_top_0	set	10
;	// calculate how many lines we need to move down or up if x movement goes outside screen
;	int16_t new_y;
;	int16_t to_scroll;
;	int16_t new_x;
;
;	new_x = right_left + term->cursor_x; 
new_y_1	set	0
to_scroll_1	set	2
new_x_1	set	4
	clc
	lda	<L131+right_left_0
	ldy	#$25
	adc	[<L131+term_0],Y
	sta	<L132+new_x_1
;		
;	if(new_x >= (int16_t)(VT100_WIDTH)){
	sec
	ldy	#$5
	sbc	[<L131+term_0],Y
	bvs	L133
	eor	#$8000
L133:
	bpl	L10091
;		if(term->flags.f.cursor_wrap){
	lda	[<L131+term_0]
	bit	#$1
	beq	L10092
;			bottom_top += new_x / VT100_WIDTH;
	ldy	#$5
	lda	[<L131+term_0],Y
	tax
	lda	<L132+new_x_1
	xref	~~~udv
	jsl	~~~udv
	clc
	adc	<L131+bottom_top_0
	sta	<L131+bottom_top_0
;			term->cursor_x = new_x % VT100_WIDTH /*- 1*/;
	ldy	#$5
	lda	[<L131+term_0],Y
	tax
	lda	<L132+new_x_1
	xref	~~~umd
	jsl	~~~umd
	bra	L20025
;		} else {
L10092:
;			term->cursor_x = VT100_WIDTH;
	ldy	#$5
	lda	[<L131+term_0],Y
	bra	L20025
;		}
;	} else if(new_x < 0){
L10091:
	lda	<L132+new_x_1
	bmi	L10094
;		//bottom_top += new_x / VT100_WIDTH - 1;
;		//term->cursor_x = VT100_WIDTH - (abs(new_x) % VT100_WIDTH) + 1;
;	} else {
;		term->cursor_x = new_x;
	lda	<L132+new_x_1
L20025:
	ldy	#$25
	sta	[<L131+term_0],Y
;	}
L10094:
;
;	//debugf("move: new_x:%d, term->cursor_x:%d, bottom_top:%d \n", (long)new_x, (long)term->cursor_x, (long)bottom_top);
;	
;	if(bottom_top){
	lda	<L131+bottom_top_0
	beq	L140
;		new_y = term->cursor_y + bottom_top;
	clc
	ldy	#$27
	lda	[<L131+term_0],Y
	adc	<L131+bottom_top_0
	sta	<L132+new_y_1
;		to_scroll = 0;
	stz	<L132+to_scroll_1
;		// bottom margin 39 marks last line as static on 40 line display
;		// therefore, we would scroll when new cursor has moved to line 39
;		// (or we could use new_y > VT100_HEIGHT here
;		// NOTE: new_y >= term->scroll_end_row ## to_scroll = (new_y - term->scroll_end_row) +1
;		if(new_y >= term->scroll_end_row){
	lda	<L132+new_y_1
	ldy	#$2f
	cmp	[<L131+term_0],Y
	bcc	L10098
;			//scroll = new_y / VT100_HEIGHT;
;			//term->cursor_y = VT100_HEIGHT;
;			to_scroll = (new_y - term->scroll_end_row) + 1; 
	sec
	lda	<L132+new_y_1
	sbc	[<L131+term_0],Y
	ina
	sta	<L132+to_scroll_1
;			// place cursor back within the scroll region
;			term->cursor_y = term->scroll_end_row - 1; //new_y - to_scroll; 
	lda	#$ffff
	clc
	adc	[<L131+term_0],Y
	bra	L20026
;			//scroll = new_y - term->bottom_margin; 
;			//term->cursor_y = term->bottom_margin; 
;		} else if(new_y < term->scroll_start_row){
L10098:
	lda	<L132+new_y_1
	ldy	#$2d
	cmp	[<L131+term_0],Y
	bcs	L10100
;			to_scroll = (new_y - term->scroll_start_row); 
	sec
	lda	<L132+new_y_1
	sbc	[<L131+term_0],Y
	sta	<L132+to_scroll_1
;			term->cursor_y = term->scroll_start_row; //new_y - to_scroll; 
	lda	[<L131+term_0],Y
	bra	L20026
;			//scroll = new_y / (term->bottom_margin - term->top_margin) - 1;
;			//term->cursor_y = term->top_margin; 
;		} else {
L10100:
;			// otherwise we move as normal inside the screen
;			term->cursor_y = new_y;
	lda	<L132+new_y_1
L20026:
	ldy	#$27
	sta	[<L131+term_0],Y
;		}
;		_vt100_scroll(term, to_scroll);
	pei	<L132+to_scroll_1
	pei	<L131+term_0+2
	pei	<L131+term_0
	jsl	~~_vt100_scroll
;		
;		//debugf("move: new_y:%d, term->cursor_y:%d, to_scroll:%d \n", (long)new_y, (long)term->cursor_y, (long)to_scroll);
;
;	}
;}
L140:
	lda	<L131+2
	sta	<L131+2+8
	lda	<L131+1
	sta	<L131+1+8
	pld
	tsc
	clc
	adc	#L131+8
	tcs
	rtl
L131	equ	10
L132	equ	5
	ends
	efunc
;
;
;void _vt100_putc(win_t *w, uint8_t ch){
	code
	xdef	~~_vt100_putc
	func
~~_vt100_putc:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L141
	tcs
	phd
	tcd
w_0	set	4
ch_0	set	8
;	uint16_t x;
;	uint16_t y;
;	
;	if(ch < 0x20 || ch > 0x7e){
x_1	set	0
y_1	set	2
	sep	#$20
	longa	off
	lda	<L141+ch_0
	cmp	#<$20
	rep	#$20
	longa	on
	bcc	L143
	sep	#$20
	longa	off
	lda	#$7e
	cmp	<L141+ch_0
	rep	#$20
	longa	on
	bcs	L10102
L143:
;		_vt100_putc(w, '0'); 
	pea	#<$30
	pei	<L141+w_0+2
	pei	<L141+w_0
	jsl	~~_vt100_putc
;		_vt100_putc(w, 'x'); 
	pea	#<$78
	pei	<L141+w_0+2
	pei	<L141+w_0
	jsl	~~_vt100_putc
;		_vt100_putc(w, hextab[((ch & 0xf0) >> 4)]);
	lda	<L141+ch_0
	and	#<$f0
	ldx	#<$4
	xref	~~~asr
	jsl	~~~asr
	tax
	lda	|~~hextab,X
	pha
	pei	<L141+w_0+2
	pei	<L141+w_0
	jsl	~~_vt100_putc
;		_vt100_putc(w, hextab[(ch & 0x0f)]);
	lda	<L141+ch_0
	and	#<$f
	tax
	lda	|~~hextab,X
	pha
	pei	<L141+w_0+2
	pei	<L141+w_0
	jsl	~~_vt100_putc
;		return;
L146:
	lda	<L141+2
	sta	<L141+2+6
	lda	<L141+1
	sta	<L141+1+6
	pld
	tsc
	clc
	adc	#L141+6
	tcs
	rtl
;	}
;	
;	// calculate current cursor position in the display ram
;	x = VT100_CURSOR_X(w);
L10102:
	ldy	#$25
	lda	[<L141+w_0],Y
	sta	<L142+x_1
;	y = VT100_CURSOR_Y(w);
	pei	<L141+w_0+2
	pei	<L141+w_0
	jsl	~~VT100_CURSOR_Y
	sta	<L142+y_1
;
;	//debugf("_vt100_putc x:%d y:%d addr:%d\n", (long)x, (long)y, (long)(x + y * w->width));
;	
;	ili9340_setFrontColor(w->front_color);
	ldy	#$33
	lda	[<L141+w_0],Y
	pha
	jsl	~~ili9340_setFrontColor
;	ili9340_setBackColor(w->back_color); 
	ldy	#$35
	lda	[<L141+w_0],Y
	pha
	jsl	~~ili9340_setBackColor
;	
;	ili9340_drawChar(w, ch);
	lda	<L141+ch_0
	and	#$ff
	pha
	pei	<L141+w_0+2
	pei	<L141+w_0
	jsl	~~ili9340_drawChar
;	
;	// move cursor right
;	_vt100_move(w, 1, 0); 
	pea	#<$0
	pea	#<$1
	pei	<L141+w_0+2
	pei	<L141+w_0
	jsl	~~_vt100_move
;	ili9340_drawCursor(w);
	pei	<L141+w_0+2
	pei	<L141+w_0
	jsl	~~ili9340_drawCursor
;}
	bra	L146
L141	equ	8
L142	equ	5
	ends
	efunc
;
;void vt100_putc(win_t *w, uint8_t c){	
	code
	xdef	~~vt100_putc
	func
~~vt100_putc:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L147
	tcs
	phd
	tcd
w_0	set	4
c_0	set	8
;	w->state(w, EV_CHAR, 0x0000 | c);
	lda	<L147+c_0
	and	#$ff
	pha
	pea	#<$1
	pei	<L147+w_0+2
	pei	<L147+w_0
	ldy	#$817
	lda	[<L147+w_0],Y
	tax
	dey
	dey
	lda	[<L147+w_0],Y
	xref	~~~lcal
	jsl	~~~lcal
;}
	lda	<L147+2
	sta	<L147+2+6
	lda	<L147+1
	sta	<L147+1+6
	pld
	tsc
	clc
	adc	#L147+6
	tcs
	rtl
L147	equ	0
L148	equ	1
	ends
	efunc
;
;ssize_t w_write(int fd, char *buf, size_t len) {
	code
	xdef	~~w_write
	func
~~w_write:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L150
	tcs
	phd
	tcd
fd_0	set	4
buf_0	set	6
len_0	set	10
;	
;	win_t *w;
;	size_t l;
;	
;	l = len;
w_1	set	0
l_1	set	4
	lda	<L150+len_0
	sta	<L151+l_1
	lda	<L150+len_0+2
	sta	<L151+l_1+2
;	
;	w = findWindow(fd);
	pei	<L150+fd_0
	jsl	~~findWindow
	sta	<L151+w_1
	stx	<L151+w_1+2
;	if (!w) return -1;
	ora	<L151+w_1+2
	bne	L10107
	lda	#$ffff
	tax
L153:
	tay
	lda	<L150+2
	sta	<L150+2+10
	lda	<L150+1
	sta	<L150+1+10
	pld
	tsc
	clc
	adc	#L150+10
	tcs
	tya
	rtl
;	
;	for (; len; len--, buf++) {	
L10106:
;		w->state(w, EV_CHAR, 0x0000 | *buf);
	lda	[<L150+buf_0]
	and	#$ff
	pha
	pea	#<$1
	pei	<L151+w_1+2
	pei	<L151+w_1
	ldy	#$817
	lda	[<L151+w_1],Y
	tax
	dey
	dey
	lda	[<L151+w_1],Y
	xref	~~~lcal
	jsl	~~~lcal
;		//vt100_putc(w, *buf);
;	}
	inc	<L150+buf_0
	bne	L154
	inc	<L150+buf_0+2
L154:
	lda	<L150+len_0
	bne	L155
	dec	<L150+len_0+2
L155:
	dec	<L150+len_0
L10107:
	lda	<L150+len_0
	ora	<L150+len_0+2
	bne	L10106
;	
;	drawWindows();
	jsl	~~drawWindows
;	return l;
	ldx	<L151+l_1+2
	lda	<L151+l_1
	bra	L153
;}
L150	equ	8
L151	equ	1
	ends
	efunc
;
;
;void _vt100_resetScroll(win_t *term){
	code
	xdef	~~_vt100_resetScroll
	func
~~_vt100_resetScroll:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L157
	tcs
	phd
	tcd
term_0	set	4
;	term->scroll_start_row = 0;
	lda	#$0
	ldy	#$2d
	sta	[<L157+term_0],Y
;	term->scroll_end_row = VT100_HEIGHT;
	ldy	#$7
	lda	[<L157+term_0],Y
	ldy	#$2f
	sta	[<L157+term_0],Y
;	term->scroll_value = 0; 
	lda	#$0
	iny
	iny
	sta	[<L157+term_0],Y
;	ili9340_setScrollMargins(0, 0);
	pea	#<$0
	pea	#<$0
	jsl	~~ili9340_setScrollMargins
;	ili9340_setScrollStart(0); 
	pea	#<$0
	jsl	~~ili9340_setScrollStart
;}
	lda	<L157+2
	sta	<L157+2+4
	lda	<L157+1
	sta	<L157+1+4
	pld
	tsc
	clc
	adc	#L157+4
	tcs
	rtl
L157	equ	0
L158	equ	1
	ends
	efunc
;
;STATE(_st_esc_question, term, ev, arg){
	code
	xdef	~~_st_esc_question
	func
~~_st_esc_question:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L160
	tcs
	phd
	tcd
term_0	set	4
ev_0	set	8
arg_0	set	10
;	// DEC mode commands
;	switch(ev){
	lda	<L160+ev_0
	and	#$ff
	xref	~~~swt
	jsl	~~~swt
	dw	1
	dw	1
	dw	L10110-1
	dw	L170-1
;		case EV_CHAR: {
L10110:
;			if(isdigit(arg)){ // start of an argument
	pei	<L160+arg_0
	jsl	~~isdigit
	tax
	beq	L10111
;				term->ret_state = _st_esc_question; 
	lda	#<~~_st_esc_question
	ldy	#$81d
	sta	[<L160+term_0],Y
	lda	#^~~_st_esc_question
	iny
	iny
	sta	[<L160+term_0],Y
;				_st_command_arg(term, ev, arg);
	pei	<L160+arg_0
	pei	<L160+ev_0
	pei	<L160+term_0+2
	pei	<L160+term_0
	jsl	~~_st_command_arg
;				term->state = _st_command_arg;
	lda	#<~~_st_command_arg
	ldy	#$815
	sta	[<L160+term_0],Y
	lda	#^~~_st_command_arg
L20032:
	ldy	#$817
	sta	[<L160+term_0],Y
;			} else if(arg == ';'){ // arg separator. 
L170:
	lda	<L160+2
	sta	<L160+2+8
	lda	<L160+1
	sta	<L160+1+8
	pld
	tsc
	clc
	adc	#L160+8
	tcs
	rtl
L10111:
	lda	<L160+arg_0
	cmp	#<$3b
	beq	L170
;				// skip. And also stay in the command state
;			} else {
;				switch(arg) {
	lda	<L160+arg_0
	xref	~~~fsw
	jsl	~~~fsw
	dw	104
	dw	7
	dw	L10120-1
	dw	L10118-1
	dw	L10120-1
	dw	L10120-1
	dw	L10120-1
	dw	L10118-1
	dw	L10120-1
	dw	L10120-1
;					case 'l': 
;						// dec mode: OFF (arg[0] = function)
;					case 'h': {
L10118:
;						// dec mode: ON (arg[0] = function)
;						switch(term->args[0]){
	ldy	#$80d
	lda	[<L160+term_0],Y
	xref	~~~fsw
	jsl	~~~fsw
	dw	1
	dw	9
	dw	L10120-1
	dw	L10120-1
	dw	L10120-1
	dw	L10120-1
	dw	L10120-1
	dw	L10120-1
	dw	L10126-1
	dw	L10127-1
	dw	L10120-1
	dw	L10120-1
;							case 1: { // cursor keys mode
;								// h = esc 0 A for cursor up
;								// l = cursor keys send ansi commands
;								break;
;							}
;							case 2: { // ansi / vt52
;								// h = ansi mode
;								// l = vt52 mode
;								break;
;							}
;							case 3: {
;								// h = 132 chars per line
;								// l = 80 chars per line
;								break;
;							}
;							case 4: {
;								// h = smooth scroll
;								// l = jump scroll
;								break;
;							}
;							case 5: {
;								// h = black on white bg
;								// l = white on black bg
;								break;
;							}
;							case 6: {
L10126:
;								// h = cursor relative to scroll region
;								// l = cursor independent of scroll region
;								term->flags.f.origin_mode = (arg == 'h')?1:0; 
	lda	<L160+arg_0
	cmp	#<$68
	bne	L164
	lda	#$1
	sta	<R0
	bra	L20027
L164:
	stz	<R0
L20027:
	lda	<R0
	sta	<R0
	sep	#$20
	longa	off
	asl	<R0
	asl	<R0
	lda	<R0
	and	#<$4
	sta	<R0
	lda	[<L160+term_0]
	and	#<$fffffffb
	ora	<R0
	sta	[<L160+term_0]
	rep	#$20
	longa	on
;								break;
L10120:
;						term->state = _st_idle;
	lda	#<~~_st_idle
	ldy	#$815
	sta	[<L160+term_0],Y
	lda	#^~~_st_idle
	iny
	iny
	sta	[<L160+term_0],Y
;						break; 
;				term->state = _st_idle;
	lda	#<~~_st_idle
	dey
	dey
	sta	[<L160+term_0],Y
	lda	#^~~_st_idle
	brl	L20032
;			}
;		}
;	}
;							}
;							case 7: {
L10127:
;								// h = new line after last column
;								// l = cursor stays at the end of line
;								term->flags.f.cursor_wrap = (arg == 'h')?1:0; 
	lda	<L160+arg_0
	cmp	#<$68
	bne	L167
	lda	#$1
	sta	<R0
	bra	L20028
L167:
	stz	<R0
L20028:
	lda	<R0
	sep	#$20
	longa	off
	and	#<$1
	sta	<R0
	lda	[<L160+term_0]
	and	#<$fffffffe
	ora	<R0
	sta	[<L160+term_0]
	rep	#$20
	longa	on
;								break;
	bra	L10120
;							}
;							case 8: {
;								// h = keys will auto repeat
;								// l = keys do not auto repeat when held down
;								break;
;							}
;							case 9: {
;								// h = display interlaced
;								// l = display not interlaced
;								break;
;							}
;							// 10-38 - all quite DEC speciffic commands so omitted here
;						}
;					}
;					case 'i': /* Printing */  
;					case 'n': /* Request printer status */
;					default:  
;						term->state = _st_idle; 
;						break;
;				}
;}
L160	equ	4
L161	equ	5
	ends
	efunc
;
;STATE(_st_esc_left_br, term, ev, arg){
	code
	xdef	~~_st_esc_left_br
	func
~~_st_esc_left_br:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L171
	tcs
	phd
	tcd
term_0	set	4
ev_0	set	8
arg_0	set	10
;	switch(ev){
	lda	<L171+ev_0
	and	#$ff
	xref	~~~swt
	jsl	~~~swt
	dw	1
	dw	1
	dw	L10135-1
	dw	L173-1
;		case EV_CHAR: {
L10135:
;			switch(arg) {  
	lda	<L171+arg_0
	xref	~~~swt
	jsl	~~~swt
	dw	4
	dw	48
	dw	L10141-1
	dw	65
	dw	L10141-1
	dw	66
	dw	L10141-1
	dw	79
	dw	L10141-1
	dw	L10141-1
;				case 'A':  
;				case 'B':  
;					// translation map command?
;				case '0':  
;				case 'O':
L10141:
;					// another translation map command?
;					term->state = _st_idle;
	lda	#<~~_st_idle
	ldy	#$815
	sta	[<L171+term_0],Y
	lda	#^~~_st_idle
	iny
	iny
	sta	[<L171+term_0],Y
;					break;
L173:
	lda	<L171+2
	sta	<L171+2+8
	lda	<L171+1
	sta	<L171+1+8
	pld
	tsc
	clc
	adc	#L171+8
	tcs
	rtl
;				default:
;					term->state = _st_idle;
;			}
;			//term->state = _st_idle;
;		}
;	}
;}
L171	equ	0
L172	equ	1
	ends
	efunc
;
;STATE(_st_esc_right_br, term, ev, arg){
	code
	xdef	~~_st_esc_right_br
	func
~~_st_esc_right_br:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L174
	tcs
	phd
	tcd
term_0	set	4
ev_0	set	8
arg_0	set	10
;	switch(ev){
	lda	<L174+ev_0
	and	#$ff
	xref	~~~swt
	jsl	~~~swt
	dw	1
	dw	1
	dw	L10145-1
	dw	L176-1
;		case EV_CHAR: {
L10145:
;			switch(arg) {  
	lda	<L174+arg_0
	xref	~~~swt
	jsl	~~~swt
	dw	4
	dw	48
	dw	L10151-1
	dw	65
	dw	L10151-1
	dw	66
	dw	L10151-1
	dw	79
	dw	L10151-1
	dw	L10151-1
;				case 'A':  
;				case 'B':  
;					// translation map command?
;				case '0':  
;				case 'O':
L10151:
;					// another translation map command?
;					term->state = _st_idle;
	lda	#<~~_st_idle
	ldy	#$815
	sta	[<L174+term_0],Y
	lda	#^~~_st_idle
	iny
	iny
	sta	[<L174+term_0],Y
;					break;
L176:
	lda	<L174+2
	sta	<L174+2+8
	lda	<L174+1
	sta	<L174+1+8
	pld
	tsc
	clc
	adc	#L174+8
	tcs
	rtl
;				default:
;					term->state = _st_idle;
;			}
;			//term->state = _st_idle;
;		}
;	}
;}
L174	equ	0
L175	equ	1
	ends
	efunc
;
;STATE(_st_esc_hash, term, ev, arg){
	code
	xdef	~~_st_esc_hash
	func
~~_st_esc_hash:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L177
	tcs
	phd
	tcd
term_0	set	4
ev_0	set	8
arg_0	set	10
;	switch(ev){
	lda	<L177+ev_0
	and	#$ff
	xref	~~~swt
	jsl	~~~swt
	dw	1
	dw	1
	dw	L10155-1
	dw	L179-1
;		case EV_CHAR: {
L10155:
;			switch(arg) {  
	lda	<L177+arg_0
	xref	~~~swt
	jsl	~~~swt
	dw	1
	dw	56
	dw	L10158-1
	dw	L10158-1
;				case '8': {
L10158:
;					// self test: fill the screen with 'E'
;					
;					term->state = _st_idle;
	lda	#<~~_st_idle
	ldy	#$815
	sta	[<L177+term_0],Y
	lda	#^~~_st_idle
	iny
	iny
	sta	[<L177+term_0],Y
;					break;
L179:
	lda	<L177+2
	sta	<L177+2+8
	lda	<L177+1
	sta	<L177+1+8
	pld
	tsc
	clc
	adc	#L177+8
	tcs
	rtl
;				}
;				default:
;					term->state = _st_idle;
;			}
;		}
;	}
;}
L177	equ	0
L178	equ	1
	ends
	efunc
;
;STATE(_st_escape, term, ev, arg){
	code
	xdef	~~_st_escape
	func
~~_st_escape:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L180
	tcs
	phd
	tcd
term_0	set	4
ev_0	set	8
arg_0	set	10
;	uint16_t c;
;	
;	switch(ev){
c_1	set	0
	lda	<L180+ev_0
	and	#$ff
	xref	~~~swt
	jsl	~~~swt
	dw	1
	dw	1
	dw	L10162-1
	dw	L10185-1
;		case EV_CHAR: {
L10162:
;			#define CLEAR_ARGS \
;				{ term->narg = 0;\
;				for(c = 0; c < MAX_COMMAND_ARGS; c++)\
;					term->args[c] = 0; }\
;			
;			switch(arg){
	lda	<L180+arg_0
	xref	~~~swt
	jsl	~~~swt
	dw	21
	dw	27
	dw	L186-1
	dw	35
	dw	L10180-1
	dw	40
	dw	L10170-1
	dw	41
	dw	L10175-1
	dw	55
	dw	L10190-1
	dw	56
	dw	L10192-1
	dw	60
	dw	L10185-1
	dw	61
	dw	L10185-1
	dw	62
	dw	L10185-1
	dw	68
	dw	L10186-1
	dw	69
	dw	L10188-1
	dw	72
	dw	L10185-1
	dw	77
	dw	L10187-1
	dw	78
	dw	L10185-1
	dw	79
	dw	L10185-1
	dw	80
	dw	L10185-1
	dw	90
	dw	L10195-1
	dw	91
	dw	L10165-1
	dw	99
	dw	L10196-1
	dw	115
	dw	L10190-1
	dw	117
	dw	L10192-1
	dw	L10185-1
;				case '[': { // command
L10165:
;					// prepare command state and switch to it
;					CLEAR_ARGS; 
	lda	#$0
	ldy	#$80b
	sta	[<L180+term_0],Y
	stz	<L181+c_1
	bra	L10169
L10168:
	lda	<L181+c_1
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	lda	#$80d
	clc
	adc	<L180+term_0
	sta	<R2
	lda	#$0
	adc	<L180+term_0+2
	sta	<R2+2
	lda	<R2
	clc
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	lda	#$0
	sta	[<R3]
	inc	<L181+c_1
L10169:
	lda	<L181+c_1
	cmp	#<$4
	bcc	L10168
;					term->state = _st_esc_sq_bracket;
	lda	#<~~_st_esc_sq_bracket
	ldy	#$815
	sta	[<L180+term_0],Y
	lda	#^~~_st_esc_sq_bracket
L20052:
	ldy	#$817
	sta	[<L180+term_0],Y
;					break;
L186:
	lda	<L180+2
	sta	<L180+2+8
	lda	<L180+1
	sta	<L180+1+8
	pld
	tsc
	clc
	adc	#L180+8
	tcs
	rtl
;				}
;				case '(': /* ESC ( */  
L10170:
;					CLEAR_ARGS;
	lda	#$0
	ldy	#$80b
	sta	[<L180+term_0],Y
	stz	<L181+c_1
	bra	L10174
L10173:
	lda	<L181+c_1
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	lda	#$80d
	clc
	adc	<L180+term_0
	sta	<R2
	lda	#$0
	adc	<L180+term_0+2
	sta	<R2+2
	lda	<R2
	clc
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	lda	#$0
	sta	[<R3]
	inc	<L181+c_1
L10174:
	lda	<L181+c_1
	cmp	#<$4
	bcc	L10173
;					term->state = _st_esc_left_br;
	lda	#<~~_st_esc_left_br
	ldy	#$815
	sta	[<L180+term_0],Y
	lda	#^~~_st_esc_left_br
	bra	L20052
;					break; 
;				case ')': /* ESC ) */  
L10175:
;					CLEAR_ARGS;
	lda	#$0
	ldy	#$80b
	sta	[<L180+term_0],Y
	stz	<L181+c_1
	bra	L10179
L10178:
	lda	<L181+c_1
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	lda	#$80d
	clc
	adc	<L180+term_0
	sta	<R2
	lda	#$0
	adc	<L180+term_0+2
	sta	<R2+2
	lda	<R2
	clc
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	lda	#$0
	sta	[<R3]
	inc	<L181+c_1
L10179:
	lda	<L181+c_1
	cmp	#<$4
	bcc	L10178
;					term->state = _st_esc_right_br;
	lda	#<~~_st_esc_right_br
	ldy	#$815
	sta	[<L180+term_0],Y
	lda	#^~~_st_esc_right_br
	brl	L20052
;					break;  
;				case '#': // ESC # 
L10180:
;					CLEAR_ARGS;
	lda	#$0
	ldy	#$80b
	sta	[<L180+term_0],Y
	stz	<L181+c_1
	bra	L10184
L10183:
	lda	<L181+c_1
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	lda	#$80d
	clc
	adc	<L180+term_0
	sta	<R2
	lda	#$0
	adc	<L180+term_0+2
	sta	<R2+2
	lda	<R2
	clc
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	lda	#$0
	sta	[<R3]
	inc	<L181+c_1
L10184:
	lda	<L181+c_1
	cmp	#<$4
	bcc	L10183
;					term->state = _st_esc_hash;
	lda	#<~~_st_esc_hash
	ldy	#$815
	sta	[<L180+term_0],Y
	lda	#^~~_st_esc_hash
	brl	L20052
;					break;  
;				case 'P': //ESC P (DCS, Device Control String)
;					break;
;				case 'D': // moves cursor down one line and scrolls if necessary
L10186:
;					// move cursor down one line and scroll window if at bottom line
;					_vt100_move(term, 0, 1); 
	pea	#<$1
L20092:
	pea	#<$0
	pei	<L180+term_0+2
	pei	<L180+term_0
	jsl	~~_vt100_move
;					term->state = _st_idle;
L10185:
;					term->state = _st_idle; 
	lda	#<~~_st_idle
	ldy	#$815
	sta	[<L180+term_0],Y
	lda	#^~~_st_idle
	brl	L20052
;					break; 
;				case 'M': // Cursor up
L10187:
;					// move cursor up one line and scroll window if at top line
;					_vt100_move(term, 0, -1); 
	pea	#<$ffffffff
;					term->state = _st_idle;
	bra	L20092
;					break; 
;				case 'E': // next line
L10188:
;					// same as '\r\n'
;					_vt100_move(term, 0, 1);
	pea	#<$1
	pea	#<$0
	pei	<L180+term_0+2
	pei	<L180+term_0
	jsl	~~_vt100_move
;					term->cursor_x = 0; 
	lda	#$0
	ldy	#$25
L20093:
	sta	[<L180+term_0],Y
;					term->state = _st_idle;
	bra	L10185
;					break;  
;				case '7': // Save attributes and cursor position  
;				case 's':  
L10190:
;					term->saved_cursor_x = term->cursor_x;
	ldy	#$25
	lda	[<L180+term_0],Y
	ldy	#$29
	sta	[<L180+term_0],Y
;					term->saved_cursor_y = term->cursor_y;
	dey
	dey
	lda	[<L180+term_0],Y
	ldy	#$2b
;					term->state = _st_idle;
	bra	L20093
;					break;  
;				case '8': // Restore them  
;				case 'u': 
L10192:
;					term->cursor_x = term->saved_cursor_x;
	ldy	#$29
	lda	[<L180+term_0],Y
	ldy	#$25
	sta	[<L180+term_0],Y
;					term->cursor_y = term->saved_cursor_y; 
	ldy	#$2b
	lda	[<L180+term_0],Y
	ldy	#$27
;					term->state = _st_idle;
	bra	L20093
;					break; 
;				case '=': // Keypad into applications mode 
;					term->state = _st_idle;
;					break; 
;				case '>': // Keypad into numeric mode   
;					term->state = _st_idle;
;					break;  
;				case 'Z': // Report terminal type 
L10195:
;					// vt 100 response
;					term->send_response("\033[?1;0c");  
	pea	#^L123
	pea	#<L123
	ldy	#$81b
	lda	[<L180+term_0],Y
	tax
	dey
	dey
	lda	[<L180+term_0],Y
	xref	~~~lcal
	jsl	~~~lcal
;					// unknown terminal     
;						//out("\033[?c");
;					term->state = _st_idle;
	bra	L10185
;					break;    
;				case 'c': // Reset terminal to initial state 
L10196:
;					_vt100_reset(term);
	pei	<L180+term_0+2
	pei	<L180+term_0
	jsl	~~_vt100_reset
;					term->state = _st_idle;
	bra	L10185
;					break;  
;				case 'H': // Set tab in current position 
;				case 'N': // G2 character set for next character only  
;				case 'O': // G3 "               "     
;				case '<': // Exit vt52 mode
;					// ignore
;					term->state = _st_idle;
;					break; 
;				case KEY_ESC: { // marks start of next escape sequence
;					// stay in escape state
;					break;
;				}
;				default: { // unknown sequence - return to normal mode
;					term->state = _st_idle;
;					break;
;				}
;			}
;			#undef CLEAR_ARGS
;			break;
;		}
;		default: {
;			// for all other events restore normal mode
;			term->state = _st_idle; 
;		}
;	}
;}
L180	equ	18
L181	equ	17
	ends
	efunc
	data
L123:
	db	$1B,$5B,$3F,$31,$3B,$30,$63,$00
	ends
;
;
;STATE(_st_idle, term, ev, arg){
	code
	xdef	~~_st_idle
	func
~~_st_idle:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L188
	tcs
	phd
	tcd
term_0	set	4
ev_0	set	8
arg_0	set	10
;	//debugf("idle\n");
;	ili9340_drawChar(term, ' ');
	pea	#<$20
	pei	<L188+term_0+2
	pei	<L188+term_0
	jsl	~~ili9340_drawChar
;
;	switch(ev){
	lda	<L188+ev_0
	and	#$ff
	xref	~~~swt
	jsl	~~~swt
	dw	1
	dw	1
	dw	L10206-1
	dw	L10205-1
;		case EV_CHAR: {
L10206:
;			switch(arg){
	lda	<L188+arg_0
	xref	~~~swt
	jsl	~~~swt
	dw	8
	dw	5
	dw	L10209-1
	dw	7
	dw	L10205-1
	dw	8
	dw	L10212-1
	dw	9
	dw	L10214-1
	dw	10
	dw	L10210-1
	dw	13
	dw	L20098-1
	dw	27
	dw	L10218-1
	dw	127
	dw	L10213-1
	dw	L10219-1
;				
;				case 5: // AnswerBack for vt100's  
L10209:
;					term->send_response("X"); // should send SCCS_ID?
	pea	#^L187
	pea	#<L187
	ldy	#$81b
	lda	[<L188+term_0],Y
	tax
	dey
	dey
	lda	[<L188+term_0],Y
	xref	~~~lcal
	jsl	~~~lcal
;					break;  
L10205:
;	ili9340_drawCursor(term);
	pei	<L188+term_0+2
	pei	<L188+term_0
	jsl	~~ili9340_drawCursor
;}
	lda	<L188+2
	sta	<L188+2+8
	lda	<L188+1
	sta	<L188+1+8
	pld
	tsc
	clc
	adc	#L188+8
	tcs
	rtl
;				case '\n': { // new line
L10210:
;					_vt100_move(term, 0, 1);
	pea	#<$1
	pea	#<$0
	pei	<L188+term_0+2
	pei	<L188+term_0
	jsl	~~_vt100_move
;					term->cursor_x = 0; 
L20098:
	lda	#$0
	ldy	#$25
L20099:
	sta	[<L188+term_0],Y
;					//_vt100_moveCursor(term, 0, term->cursor_y + 1);
;					// do scrolling here! 
;					break;
	bra	L10205
;				}
;				case '\r': { // carrage return (0x0d)
;					term->cursor_x = 0; 
;					//_vt100_move(term, 0, 1);
;					//_vt100_moveCursor(term, 0, term->cursor_y); 
;					break;
;				}
;				case '\b': { // backspace 0x08
;				}
;				case KEY_DEL: { // del - delete character under cursor
L10213:
;					// Problem: with current implementation, we can't move the rest of line
;					// to the left as is the proper behavior of the delete character
;					// fill the current position with background color
;					_vt100_putc(term, ' ');
	pea	#<$20
	pei	<L188+term_0+2
	pei	<L188+term_0
	jsl	~~_vt100_putc
;					_vt100_move(term, -1, 0);
;					//_vt100_clearChar(term, term->cursor_x, term->cursor_y); 
;					break;
L10212:
;					_vt100_move(term, -1, 0); 
	pea	#<$0
	pea	#<$ffffffff
	pei	<L188+term_0+2
	pei	<L188+term_0
	jsl	~~_vt100_move
;					// backspace does not delete the character! Only moves cursor!
;					//ili9340_drawChar(term->cursor_x * term->char_width,
;					//	term->cursor_y * term->char_height, ' ');
;					break;
	bra	L10205
;				}
;				case '\t': { // tab
L10214:
;					// tab fills characters on the line until we reach a multiple of tab_stop
;					int tab_stop = 4;
;					int to_put = tab_stop - (term->cursor_x % tab_stop); 
;					while(to_put--) _vt100_putc(term, ' ');
tab_stop_2	set	0
to_put_2	set	2
	lda	#$4
	sta	<L189+tab_stop_2
	ldy	#$25
	lda	[<L188+term_0],Y
	ldx	<L189+tab_stop_2
	xref	~~~umd
	jsl	~~~umd
	sta	<R0
	sec
	lda	<L189+tab_stop_2
	sbc	<R0
	sta	<L189+to_put_2
	bra	L10215
L20095:
	pea	#<$20
	pei	<L188+term_0+2
	pei	<L188+term_0
	jsl	~~_vt100_putc
L10215:
	lda	<L189+to_put_2
	sta	<R0
	dec	<L189+to_put_2
	lda	<R0
	bne	L20095
;					break;
	bra	L10205
;				}
;				case KEY_BELL: { // bell is sent by bash for ex. when doing tab completion
;					// sound the speaker bell?
;					// skip
;					break; 
;				}
;				case KEY_ESC: {// escape
L10218:
;					term->state = _st_escape;
	lda	#<~~_st_escape
	ldy	#$815
	sta	[<L188+term_0],Y
	lda	#^~~_st_escape
	iny
	iny
;					break;
	bra	L20099
;				}
;				default: {
L10219:
;					_vt100_putc(term, arg);
	pei	<L188+arg_0
	pei	<L188+term_0+2
	pei	<L188+term_0
	jsl	~~_vt100_putc
;					break;
	brl	L10205
;				}
;			}
;			break;
;		}
;		default: {}
;	}
L188	equ	8
L189	equ	5
	ends
	efunc
	data
L187:
	db	$58,$00
	ends
;
;STATE(_st_command_arg, term, ev, arg){
	code
	xdef	~~_st_command_arg
	func
~~_st_command_arg:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L193
	tcs
	phd
	tcd
term_0	set	4
ev_0	set	8
arg_0	set	10
;	switch(ev){
	lda	<L193+ev_0
	and	#$ff
	xref	~~~swt
	jsl	~~~swt
	dw	1
	dw	1
	dw	L10223-1
	dw	L198-1
;		case EV_CHAR: {
L10223:
;			if(isdigit(arg)){ // a digit argument
	pei	<L193+arg_0
	jsl	~~isdigit
	tax
	bne	*+5
	brl	L10224
;				term->args[term->narg] = term->args[term->narg] * 10 + (arg - '0');
	ldy	#$80b
	lda	[<L193+term_0],Y
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	lda	#$80d
	clc
	adc	<L193+term_0
	sta	<R2
	lda	#$0
	adc	<L193+term_0+2
	sta	<R2+2
	lda	<R2
	clc
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	ldy	#$80b
	lda	[<L193+term_0],Y
	sta	<R2
	stz	<R2+2
	pei	<R2+2
	pei	<R2
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	lda	#$80d
	clc
	adc	<L193+term_0
	sta	<17
	lda	#$0
	adc	<L193+term_0+2
	sta	<17+2
	lda	<17
	clc
	adc	<R0
	sta	<21
	lda	<17+2
	adc	<R0+2
	sta	<21+2
	lda	[<21]
	asl	A
	asl	A
	adc	[<21]
	asl	A
	clc
	adc	<L193+arg_0
	sta	<17
	clc
	adc	#$ffd0
	sta	[<R3]
;			} else if(arg == ';') { // separator
	bra	L198
L20105:
;				term->narg++;
	ldy	#$80b
	lda	[<L193+term_0],Y
	ina
	sta	[<L193+term_0],Y
;			} else { // no more arguments
L198:
	lda	<L193+2
	sta	<L193+2+8
	lda	<L193+1
	sta	<L193+1+8
	pld
	tsc
	clc
	adc	#L193+8
	tcs
	rtl
L10224:
	lda	<L193+arg_0
	cmp	#<$3b
	beq	L20105
;				// go back to command state 
;				term->narg++;
	ldy	#$80b
	lda	[<L193+term_0],Y
	ina
	sta	[<L193+term_0],Y
;				if(term->ret_state){
	ldy	#$81d
	lda	[<L193+term_0],Y
	iny
	iny
	ora	[<L193+term_0],Y
	beq	L10228
;					term->state = term->ret_state;
	dey
	dey
	lda	[<L193+term_0],Y
	ldy	#$815
	sta	[<L193+term_0],Y
	ldy	#$81f
	lda	[<L193+term_0],Y
	bra	L20107
;				}
;				else {
L10228:
;					term->state = _st_idle;
	lda	#<~~_st_idle
	ldy	#$815
	sta	[<L193+term_0],Y
	lda	#^~~_st_idle
L20107:
	ldy	#$817
	sta	[<L193+term_0],Y
;				}
;				// execute next state as well because we have already consumed a char!
;				term->state(term, ev, arg);
	pei	<L193+arg_0
	pei	<L193+ev_0
	pei	<L193+term_0+2
	pei	<L193+term_0
	lda	[<L193+term_0],Y
	tax
	dey
	dey
	lda	[<L193+term_0],Y
	xref	~~~lcal
	jsl	~~~lcal
;			}
;			break;
	bra	L198
;		}
;	}
;}
L193	equ	24
L194	equ	25
	ends
	efunc
;
;STATE(_st_esc_sq_bracket, term, ev, arg){
	code
	xdef	~~_st_esc_sq_bracket
	func
~~_st_esc_sq_bracket:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L199
	tcs
	phd
	tcd
term_0	set	4
ev_0	set	8
arg_0	set	10
;	uint16_t n;
;	uint16_t x;
;	uint16_t y;
;	uint16_t top_margin;
;	uint16_t bottom_margin;
;	uint16_t c;
;	
;	switch(ev){
n_1	set	0
x_1	set	2
y_1	set	4
top_margin_1	set	6
bottom_margin_1	set	8
c_1	set	10
	lda	<L199+ev_0
	and	#$ff
	xref	~~~swt
	jsl	~~~swt
	dw	1
	dw	1
	dw	L10232-1
	dw	L10240-1
;		case EV_CHAR: {
L10232:
;			if(isdigit(arg)){ // start of an argument
	pei	<L199+arg_0
	jsl	~~isdigit
	tax
	bne	*+5
	brl	L10233
;				term->ret_state = _st_esc_sq_bracket; 
	lda	#<~~_st_esc_sq_bracket
	ldy	#$81d
	sta	[<L199+term_0],Y
	lda	#^~~_st_esc_sq_bracket
	iny
	iny
	sta	[<L199+term_0],Y
;				_st_command_arg(term, ev, arg);
	pei	<L199+arg_0
	pei	<L199+ev_0
	pei	<L199+term_0+2
	pei	<L199+term_0
	jsl	~~_st_command_arg
;				term->state = _st_command_arg;
	lda	#<~~_st_command_arg
	ldy	#$815
	sta	[<L199+term_0],Y
	lda	#^~~_st_command_arg
L20113:
	ldy	#$817
	sta	[<L199+term_0],Y
;			} else if(arg == ';'){ // arg separator. 
	brl	L258
L20112:
;				// skip. And also stay in the command state
;			} else { // otherwise we execute the command and go back to idle
;				switch(arg){
	lda	<L199+arg_0
	xref	~~~fsw
	jsl	~~~fsw
	dw	61
	dw	61
	dw	L10240-1
	dw	L10240-1
	dw	L10240-1
	dw	L10294-1
	dw	L10240-1
	dw	L10239-1
	dw	L10241-1
	dw	L10243-1
	dw	L10245-1
	dw	L10240-1
	dw	L10240-1
	dw	L10240-1
	dw	L10248-1
	dw	L10240-1
	dw	L10253-1
	dw	L10259-1
	dw	L10240-1
	dw	L10240-1
	dw	L10240-1
	dw	L10240-1
	dw	L10267-1
	dw	L10240-1
	dw	L10240-1
	dw	L10240-1
	dw	L10240-1
	dw	L10240-1
	dw	L10240-1
	dw	L10240-1
	dw	L10240-1
	dw	L10240-1
	dw	L10240-1
	dw	L10240-1
	dw	L10240-1
	dw	L10240-1
	dw	L10240-1
	dw	L10240-1
	dw	L10240-1
	dw	L10240-1
	dw	L10240-1
	dw	L10272-1
	dw	L10240-1
	dw	L10240-1
	dw	L10248-1
	dw	L10240-1
	dw	L10240-1
	dw	L10240-1
	dw	L10240-1
	dw	L10240-1
	dw	L10240-1
	dw	L10279-1
	dw	L10240-1
	dw	L10240-1
	dw	L10240-1
	dw	L10240-1
	dw	L10288-1
	dw	L10274-1
	dw	L10240-1
	dw	L10275-1
	dw	L10240-1
	dw	L10240-1
	dw	L10240-1
	dw	L10240-1
;					case 'A': {// move cursor up (cursor stops at top margin)
L10239:
;						n = (term->narg > 0)?term->args[0]:1;
	lda	#$0
	ldy	#$80b
	cmp	[<L199+term_0],Y
	bcs	L203
	iny
	iny
	lda	[<L199+term_0],Y
	bra	L205
L203:
	lda	#$1
L205:
	sta	<L200+n_1
;						term->cursor_y -= n;
	lda	#$27
	clc
	adc	<L199+term_0
	sta	<R0
	lda	#$0
	adc	<L199+term_0+2
	sta	<R0+2
	sec
	lda	[<R0]
	sbc	<L200+n_1
	sta	[<R0]
;						if(term->cursor_y < 0) term->cursor_y = 0; 
	ldy	#$27
	lda	[<L199+term_0],Y
	cmp	#<$0
	bcs	L10240
	lda	#$0
L20154:
	ldy	#$27
L20150:
	sta	[<L199+term_0],Y
;						term->state = _st_idle; 
L10240:
	lda	#<~~_st_idle
	ldy	#$815
	sta	[<L199+term_0],Y
	lda	#^~~_st_idle
	brl	L20113
;						break;
;					} 
;					case 'B': { // cursor down (cursor stops at bottom margin)
L10241:
;						n = (term->narg > 0)?term->args[0]:1;
	lda	#$0
	ldy	#$80b
	cmp	[<L199+term_0],Y
	bcs	L207
	iny
	iny
	lda	[<L199+term_0],Y
	bra	L209
L207:
	lda	#$1
L209:
	sta	<L200+n_1
;						term->cursor_y += n;
	lda	#$27
	clc
	adc	<L199+term_0
	sta	<R0
	lda	#$0
	adc	<L199+term_0+2
	sta	<R0+2
	lda	[<R0]
	clc
	adc	<L200+n_1
	sta	[<R0]
;						if(term->cursor_y > VT100_HEIGHT) term->cursor_y = VT100_HEIGHT; 
L20190:
	ldy	#$7
	lda	[<L199+term_0],Y
	ldy	#$27
	cmp	[<L199+term_0],Y
	bcs	L10240
	ldy	#$7
L20191:
	lda	[<L199+term_0],Y
	bra	L20154
;						term->state = _st_idle; 
;						break;
;					}
;					case 'C': { // cursor right (cursor stops at right margin)
L10243:
;						n = (term->narg > 0)?term->args[0]:1;
	lda	#$0
	ldy	#$80b
	cmp	[<L199+term_0],Y
	bcs	L211
	iny
	iny
	lda	[<L199+term_0],Y
	bra	L213
L211:
	lda	#$1
L213:
	sta	<L200+n_1
;						term->cursor_x += n;
	lda	#$25
	clc
	adc	<L199+term_0
	sta	<R0
	lda	#$0
	adc	<L199+term_0+2
	sta	<R0+2
	lda	[<R0]
	clc
	adc	<L200+n_1
	sta	[<R0]
;						if(term->cursor_x > VT100_WIDTH) term->cursor_x = VT100_WIDTH;
	ldy	#$5
	lda	[<L199+term_0],Y
	ldy	#$25
	cmp	[<L199+term_0],Y
	bcc	*+5
	brl	L10240
	ldy	#$5
	lda	[<L199+term_0],Y
	ldy	#$25
	brl	L20150
;						term->state = _st_idle; 
;						break;
;					}
;					case 'D': { // cursor left
L10245:
;						n = (term->narg > 0)?term->args[0]:1;
	lda	#$0
	ldy	#$80b
	cmp	[<L199+term_0],Y
	bcs	L215
	iny
	iny
	lda	[<L199+term_0],Y
	bra	L217
L215:
	lda	#$1
L217:
	sta	<L200+n_1
;						term->cursor_x -= n;
	lda	#$25
	clc
	adc	<L199+term_0
	sta	<R0
	lda	#$0
	adc	<L199+term_0+2
	sta	<R0+2
	sec
	lda	[<R0]
	sbc	<L200+n_1
	sta	[<R0]
;						if(term->cursor_x < 0) term->cursor_x = 0;
	ldy	#$25
	lda	[<L199+term_0],Y
	cmp	#<$0
	bcc	*+5
	brl	L10240
	lda	#$0
	brl	L20150
;						term->state = _st_idle; 
;						break;
;					}
;					case 'f': 
;					case 'H': { // move cursor to position (default 0;0)
L10248:
;						// cursor stops at respective margins
;						term->cursor_x = (term->narg >= 1)?(term->args[1]-1):0; 
	ldy	#$80b
	lda	[<L199+term_0],Y
	cmp	#<$1
	bcc	L219
	clc
	lda	#$ffff
	ldy	#$80f
	adc	[<L199+term_0],Y
	bra	L221
L219:
	lda	#$0
L221:
	ldy	#$25
	sta	[<L199+term_0],Y
;						term->cursor_y = (term->narg == 2)?(term->args[0]-1):0;
	ldy	#$80b
	lda	[<L199+term_0],Y
	cmp	#<$2
	bne	L222
	clc
	lda	#$ffff
	iny
	iny
	adc	[<L199+term_0],Y
	bra	L224
L222:
	lda	#$0
L224:
	ldy	#$27
	sta	[<L199+term_0],Y
;						if(term->flags.f.origin_mode) {
	lda	[<L199+term_0]
	bit	#$4
	beq	L10249
;							term->cursor_y += term->scroll_start_row;
	tya
	clc
	adc	<L199+term_0
	sta	<R0
	lda	#$0
	adc	<L199+term_0+2
	sta	<R0+2
	clc
	lda	[<R0]
	ldy	#$2d
	adc	[<L199+term_0],Y
	sta	[<R0]
;							if(term->cursor_y >= term->scroll_end_row){
	ldy	#$27
	lda	[<L199+term_0],Y
	ldy	#$2f
	cmp	[<L199+term_0],Y
	bcc	L10249
;								term->cursor_y = term->scroll_end_row - 1;
	lda	#$ffff
	clc
	adc	[<L199+term_0],Y
	ldy	#$27
	sta	[<L199+term_0],Y
;							}
;						}
;						if(term->cursor_x > VT100_WIDTH) term->cursor_x = VT100_WIDTH;
L10249:
	ldy	#$5
	lda	[<L199+term_0],Y
	ldy	#$25
	cmp	[<L199+term_0],Y
	bcc	*+5
	brl	L20190
	ldy	#$5
	lda	[<L199+term_0],Y
	ldy	#$25
	sta	[<L199+term_0],Y
;						if(term->cursor_y > VT100_HEIGHT) term->cursor_y = VT100_HEIGHT; 
	brl	L20190
;						term->state = _st_idle; 
;						break;
;					}
;					case 'J':{// clear screen from cursor up or down
L10253:
;						y = VT100_CURSOR_Y(term); 
	pei	<L199+term_0+2
	pei	<L199+term_0
	jsl	~~VT100_CURSOR_Y
	sta	<L200+y_1
;						if(term->narg == 0 || (term->narg == 1 && term->args[0] == 0)){
	ldy	#$80b
	lda	[<L199+term_0],Y
	beq	L229
	lda	[<L199+term_0],Y
	cmp	#<$1
	bne	L10254
	iny
	iny
	lda	[<L199+term_0],Y
	bne	L10254
L229:
;							// clear down to the bottom of screen (including cursor)
;							_vt100_clearLines(term, term->cursor_y, VT100_HEIGHT); 
	ldy	#$7
	lda	[<L199+term_0],Y
	pha
	ldy	#$27
	lda	[<L199+term_0],Y
	pha
	bra	L20181
L20183:
	iny
	iny
	lda	[<L199+term_0],Y
	cmp	#<$1
	bne	L10256
;							// clear top of screen to current line (including cursor)
;							_vt100_clearLines(term, 0, term->cursor_y); 
	ldy	#$27
	lda	[<L199+term_0],Y
	pha
	pea	#<$0
;						} else if(term->narg == 1 && term->args[0] == 2){
L20181:
	pei	<L199+term_0+2
	pei	<L199+term_0
	jsl	~~_vt100_clearLines
;						} else if(term->narg == 1 && term->args[0] == 1){
	brl	L10240
L10254:
	ldy	#$80b
	lda	[<L199+term_0],Y
	cmp	#<$1
	beq	L20183
L10256:
	ldy	#$80b
	lda	[<L199+term_0],Y
	cmp	#<$1
	beq	*+5
	brl	L10240
	iny
	iny
	lda	[<L199+term_0],Y
	cmp	#<$2
	beq	*+5
	brl	L10240
;							// clear whole screen
;							_vt100_clearLines(term, 0, VT100_HEIGHT);
	ldy	#$7
	lda	[<L199+term_0],Y
	pha
	pea	#<$0
	pei	<L199+term_0+2
	pei	<L199+term_0
	jsl	~~_vt100_clearLines
;							// reset scroll value
;							_vt100_resetScroll(term); 
L20194:
	pei	<L199+term_0+2
	pei	<L199+term_0
	jsl	~~_vt100_resetScroll
;						}
;						term->state = _st_idle; 
	brl	L10240
;						break;
;					}
;					case 'K':{// clear line from cursor right/left
L10259:
;						x = VT100_CURSOR_X(term);
	ldy	#$25
	lda	[<L199+term_0],Y
	sta	<L200+x_1
;						y = VT100_CURSOR_Y(term);
	pei	<L199+term_0+2
	pei	<L199+term_0
	jsl	~~VT100_CURSOR_Y
	sta	<L200+y_1
;
;						if(term->narg == 0 || (term->narg == 1 && term->args[0] == 0)){
	ldy	#$80b
	lda	[<L199+term_0],Y
	beq	L237
	lda	[<L199+term_0],Y
	cmp	#<$1
	bne	L10260
	iny
	iny
	lda	[<L199+term_0],Y
	bne	L10260
L237:
;							// clear to end of line (to \n or to edge?)
;							// including cursor
;							ili9340_fillRect(x, y, VT100_SCREEN_WIDTH - x, VT100_CHAR_HEIGHT, term->back_color);
	ldy	#$35
	lda	[<L199+term_0],Y
	pha
	pea	#<$1
	sec
	lda	#$50
	sbc	<L200+x_1
	pha
	pei	<L200+y_1
	pei	<L200+x_1
	bra	L20109
;						} else if(term->narg == 1 && term->args[0] == 1){
L10260:
	ldy	#$80b
	lda	[<L199+term_0],Y
	cmp	#<$1
	bne	L10262
	iny
	iny
	lda	[<L199+term_0],Y
	cmp	#<$1
	bne	L10262
;							// clear from left to current cursor position
;							ili9340_fillRect(0, y, x + VT100_CHAR_WIDTH, VT100_CHAR_HEIGHT, term->back_color);
	ldy	#$35
	lda	[<L199+term_0],Y
	pha
	pea	#<$1
	pei	<L200+x_1
	bra	L20115
;						} else if(term->narg == 1 && term->args[0] == 2){
L10262:
	ldy	#$80b
	lda	[<L199+term_0],Y
	cmp	#<$1
	beq	*+5
	brl	L10240
	iny
	iny
	lda	[<L199+term_0],Y
	cmp	#<$2
	beq	*+5
	brl	L10240
;							// clear whole current line
;							ili9340_fillRect(0, y, VT100_SCREEN_WIDTH, VT100_CHAR_HEIGHT, term->back_color);
	ldy	#$35
	lda	[<L199+term_0],Y
	pha
	pea	#<$1
	pea	#<$50
L20115:
	pei	<L200+y_1
	pea	#<$0
L20109:
	jsl	~~ili9340_fillRect
;						}
;						term->state = _st_idle; 
	brl	L10240
;						break;
;					}
;					
;					case 'L': // insert lines (args[0] = number of lines)
;					case 'M': // delete lines (args[0] = number of lines)
;						term->state = _st_idle;
;						break; 
;					case 'P': {// delete characters args[0] or 1 in front of cursor
L10267:
;						// TODO: this needs to correctly delete n chars
;						n = ((term->narg > 0)?term->args[0]:1);
	lda	#$0
	ldy	#$80b
	cmp	[<L199+term_0],Y
	bcs	L245
	iny
	iny
	lda	[<L199+term_0],Y
	bra	L247
L245:
	lda	#$1
L247:
	sta	<L200+n_1
;						_vt100_move(term, -n, 0);
	pea	#<$0
	sec
	lda	#$0
	sbc	<L200+n_1
	pha
	pei	<L199+term_0+2
	pei	<L199+term_0
	jsl	~~_vt100_move
;						for(c = 0; c < n; c++){
	stz	<L200+c_1
	bra	L10271
L10270:
;							_vt100_putc(term, ' ');
	pea	#<$20
	pei	<L199+term_0+2
	pei	<L199+term_0
	jsl	~~_vt100_putc
;						}
	inc	<L200+c_1
L10271:
	lda	<L200+c_1
	cmp	<L200+n_1
	bcc	L10270
;						term->state = _st_idle;
	brl	L10240
;						break;
;					}
;					case 'c':{ // query device code
L10272:
;						term->send_response("\x1b[?1;0c"); 
	pea	#^L192
	pea	#<L192
	ldy	#$81b
	lda	[<L199+term_0],Y
	tax
	dey
	dey
	lda	[<L199+term_0],Y
	xref	~~~lcal
	jsl	~~~lcal
;						term->state = _st_idle; 
	brl	L10240
;						break; 
;					}
;					case 'x': {
;						term->state = _st_idle;
;						break;
;					}
;					case 's':{// save cursor pos
L10274:
;						term->saved_cursor_x = term->cursor_x;
	ldy	#$25
	lda	[<L199+term_0],Y
	ldy	#$29
	sta	[<L199+term_0],Y
;						term->saved_cursor_y = term->cursor_y;
	dey
	dey
	lda	[<L199+term_0],Y
	ldy	#$2b
;						term->state = _st_idle; 
	brl	L20150
;						break;
;					}
;					case 'u':{// restore cursor pos
L10275:
;						term->cursor_x = term->saved_cursor_x;
	ldy	#$29
	lda	[<L199+term_0],Y
	ldy	#$25
	sta	[<L199+term_0],Y
;						term->cursor_y = term->saved_cursor_y; 
	ldy	#$2b
;						//_vt100_moveCursor(term, term->saved_cursor_x, term->saved_cursor_y);
;						term->state = _st_idle; 
	brl	L20191
;						break;
;					}
;					case 'h':
;					case 'l': {
;						term->state = _st_idle;
;						break;
;					}
;					
;					case 'g': {
;						term->state = _st_idle;
;						break;
;					}
;					case 'm': { // sets colors. Accepts up to 3 args
L10279:
;						// [m means reset the colors to default
;						if(!term->narg){
	ldy	#$80b
	lda	[<L199+term_0],Y
	beq	*+5
	brl	L10281
;							term->front_color = 0xffff;
	lda	#$ffff
	ldy	#$33
	sta	[<L199+term_0],Y
;							term->back_color = 0x0000;
	lda	#$0
	iny
	iny
	sta	[<L199+term_0],Y
;						}
;						while(term->narg){
	brl	L10281
L20110:
;							term->narg--; 
	clc
	lda	#$ffff
	ldy	#$80b
	adc	[<L199+term_0],Y
	sta	[<L199+term_0],Y
;							n = term->args[term->narg];
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$1
	xref	~~~lasl
	jsl	~~~lasl
	sta	<R0
	stx	<R0+2
	lda	#$80d
	clc
	adc	<L199+term_0
	sta	<R2
	lda	#$0
	adc	<L199+term_0+2
	sta	<R2+2
	lda	<R2
	clc
	adc	<R0
	sta	<R3
	lda	<R2+2
	adc	<R0+2
	sta	<R3+2
	lda	[<R3]
	sta	<L200+n_1
;							if(n == 0){ // all attributes off
	lda	<L200+n_1
	bne	L10283
;								term->front_color = 0xffff;
	lda	#$ffff
	ldy	#$33
	sta	[<L199+term_0],Y
;								term->back_color = 0x0000;
	lda	#$0
	iny
	iny
	sta	[<L199+term_0],Y
;								
;								ili9340_setFrontColor(term->front_color);
	dey
	dey
	lda	[<L199+term_0],Y
	pha
	jsl	~~ili9340_setFrontColor
;								ili9340_setBackColor(term->back_color);
	ldy	#$35
	lda	[<L199+term_0],Y
	pha
	jsl	~~ili9340_setBackColor
;							}
;							if(n >= 30 && n < 38){ // fg colors
L10283:
	lda	<L200+n_1
	cmp	#<$1e
	bcc	L10284
	lda	<L200+n_1
	cmp	#<$26
	bcs	L10284
;								term->front_color = colors[n-30]; 
	lda	<L200+n_1
	asl	A
	tax
	lda	|~~colors+65476,X
	ldy	#$33
	sta	[<L199+term_0],Y
;								ili9340_setFrontColor(term->front_color);
	pha
	jsl	~~ili9340_setFrontColor
;							} else if(n >= 40 && n < 48){
	bra	L10281
L10284:
	lda	<L200+n_1
	cmp	#<$28
	bcc	L10281
	lda	<L200+n_1
	cmp	#<$30
	bcs	L10281
;								term->back_color = colors[n-40]; 
	lda	<L200+n_1
	asl	A
	tax
	lda	|~~colors+65456,X
	ldy	#$35
	sta	[<L199+term_0],Y
;								ili9340_setBackColor(term->back_color); 
	pha
	jsl	~~ili9340_setBackColor
;							}
;						}
L10281:
	ldy	#$80b
	lda	[<L199+term_0],Y
	beq	*+5
	brl	L20110
;						term->state = _st_idle; 
	brl	L10240
;						break;
;					}
;					
;					case '@': // Insert Characters          
;						term->state = _st_idle;
;						break; 
;					case 'r': // Set scroll region (top and bottom margins)
L10288:
;						// the top value is first row of scroll region
;						// the bottom value is the first row of static region after scroll
;						if(term->narg == 2 && term->args[0] < term->args[1]){
	ldy	#$80b
	lda	[<L199+term_0],Y
	cmp	#<$2
	beq	*+5
	brl	L20194
	iny
	iny
	lda	[<L199+term_0],Y
	iny
	iny
	cmp	[<L199+term_0],Y
	bcc	*+5
	brl	L20194
;							// [1;40r means scroll region between 8 and 312
;							// bottom margin is 320 - (40 - 1) * 8 = 8 pix
;							term->scroll_start_row = term->args[0] - 1;
	clc
	lda	#$ffff
	dey
	dey
	adc	[<L199+term_0],Y
	ldy	#$2d
	sta	[<L199+term_0],Y
;							term->scroll_end_row = term->args[1] - 1; 
	clc
	lda	#$ffff
	ldy	#$80f
	adc	[<L199+term_0],Y
	ldy	#$2f
	sta	[<L199+term_0],Y
;							top_margin = term->scroll_start_row * VT100_CHAR_HEIGHT;
	dey
	dey
	lda	[<L199+term_0],Y
	sta	<L200+top_margin_1
;							bottom_margin = VT100_SCREEN_HEIGHT -
;								(term->scroll_end_row * VT100_CHAR_HEIGHT); 
	sec
	lda	#$19
	iny
	iny
	sbc	[<L199+term_0],Y
	sta	<L200+bottom_margin_1
;							ili9340_setScrollMargins(top_margin, bottom_margin);
	pha
	pei	<L200+top_margin_1
	jsl	~~ili9340_setScrollMargins
;							//ili9340_setScrollStart(0); // reset scroll 
;						} else {
	brl	L10240
;							_vt100_resetScroll(term); 
;						}
;						term->state = _st_idle; 
;						break;  
;					case 'i': // Printing  
;					case 'y': // self test modes..
;					case '=':{ // argument follows... 
;						//term->state = _st_screen_mode;
;						term->state = _st_idle; 
;						break; 
;					}
;					case '?': // '[?' escape mode
L10294:
;						term->state = _st_esc_question;
	lda	#<~~_st_esc_question
	ldy	#$815
	sta	[<L199+term_0],Y
	lda	#^~~_st_esc_question
	brl	L20113
;						break; 
;					default: { // unknown sequence
;						
;						term->state = _st_idle;
;						break;
L10233:
	lda	<L199+arg_0
	cmp	#<$3b
	beq	*+5
	brl	L20112
;					}
;				}
;				//term->state = _st_idle;
;			} // else
;			break;
L258:
	lda	<L199+2
	sta	<L199+2+8
	lda	<L199+1
	sta	<L199+1+8
	pld
	tsc
	clc
	adc	#L199+8
	tcs
	rtl
;		}
;		default: { // switch (ev)
;			// for all other events restore normal mode
;			term->state = _st_idle; 
;		}
;	}
;}
L199	equ	28
L200	equ	17
	ends
	efunc
	data
L192:
	db	$1B,$5B,$3F,$31,$3B,$30,$63,$00
	ends
;
;
;int main(int argv, char **s) {
	code
	xdef	~~main
	func
~~main:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L260
	tcs
	phd
	tcd
argv_0	set	4
s_0	set	6
;	
;	int fd0, fd1, c;
;	
;	wins.anchor = NULL;
fd0_1	set	0
fd1_1	set	2
c_1	set	4
	stz	|~~wins
	stz	|~~wins+2
;	wins.maxFileDesc = FILEDESC;
	lda	#$64
	sta	|~~wins+4
;	
;	fd0 = w_open("W:FD0,X01,Y02,W11,H10", 0);
	pea	#<$0
	pea	#^L259
	pea	#<L259
	jsl	~~w_open
	sta	<L261+fd0_1
;	fd1 = w_open("W:FD1,X15,Y05,W40,H15", 0);
	pea	#<$0
	pea	#^L259+22
	pea	#<L259+22
	jsl	~~w_open
	sta	<L261+fd1_1
;
;	w_write(fd0, "1234567890\x1b[B4567890", 20);
	pea	#^$14
	pea	#<$14
	pea	#^L259+44
	pea	#<L259+44
	pei	<L261+fd0_1
	jsl	~~w_write
;	w_write(fd1, "123456789012345678901234567890123456789012345678901234567890", 60);
	pea	#^$3c
	pea	#<$3c
	pea	#^L259+65
	pea	#<L259+65
	pei	<L261+fd1_1
	jsl	~~w_write
;	
;	while(1) {
L10297:
;		c = getchar();
	lda	|~~stdin+2
	pha
	lda	|~~stdin
	pha
	jsl	~~fgetc
	sta	<L261+c_1
;		w_write(fd0, (char *)&c, 1);
	pea	#^$1
	pea	#<$1
	pea	#0
	clc
	tdc
	adc	#<L261+c_1
	pha
	pei	<L261+fd0_1
	jsl	~~w_write
;		if (c == 'X') break;
	lda	<L261+c_1
	cmp	#<$58
	bne	L10297
;	}
;
;	getchar();	
	lda	|~~stdin+2
	pha
	lda	|~~stdin
	pha
	jsl	~~fgetc
;	w_close(fd1);
	pei	<L261+fd1_1
	jsl	~~w_close
;	getchar();
	lda	|~~stdin+2
	pha
	lda	|~~stdin
	pha
	jsl	~~fgetc
;	w_close(fd0);
	pei	<L261+fd0_1
	jsl	~~w_close
;	getchar();
	lda	|~~stdin+2
	pha
	lda	|~~stdin
	pha
	jsl	~~fgetc
;	
;	printWindows();
	jsl	~~printWindows
;	return 0;
	lda	#$0
	tay
	lda	<L260+2
	sta	<L260+2+6
	lda	<L260+1
	sta	<L260+1+6
	pld
	tsc
	clc
	adc	#L260+6
	tcs
	tya
	rtl
;}
L260	equ	6
L261	equ	1
	ends
	efunc
	data
L259:
	db	$57,$3A,$46,$44,$30,$2C,$58,$30,$31,$2C,$59,$30,$32,$2C,$57
	db	$31,$31,$2C,$48,$31,$30,$00,$57,$3A,$46,$44,$31,$2C,$58,$31
	db	$35,$2C,$59,$30,$35,$2C,$57,$34,$30,$2C,$48,$31,$35,$00,$31
	db	$32,$33,$34,$35,$36,$37,$38,$39,$30,$1B,$5B,$42,$34,$35,$36
	db	$37,$38,$39,$30,$00,$31,$32,$33,$34,$35,$36,$37,$38,$39,$30
	db	$31,$32,$33,$34,$35,$36,$37,$38,$39,$30,$31,$32,$33,$34,$35
	db	$36,$37,$38,$39,$30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$30
	db	$31,$32,$33,$34,$35,$36,$37,$38,$39,$30,$31,$32,$33,$34,$35
	db	$36,$37,$38,$39,$30,$00
	ends
;
	xref	~~isdigit
	xref	~~debugf
	xref	~~strlen
	xref	~~memcpy
	xref	~~memset
	xref	~~memmove
	xref	~~strcpy
	xref	~~atoi
	xref	~~free
	xref	~~malloc
	xref	~~fgetc
	xref	~~printf
	udata
~~wins
	ds	6
	ends
	xref	~~stdin
