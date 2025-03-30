#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "homebrew.h"

#define WIDTH_MIN	10
#define WIDTH_MAX	78
#define HEIGHT_MIN	5
#define HEIGHT_MAX	23

#define FILEDESC	100

#define VT100_SCREEN_WIDTH		80
#define VT100_SCREEN_HEIGHT		25
#define VT100_CHAR_WIDTH		0
#define VT100_CHAR_HEIGHT		1
#define VT100_HEIGHT			(term->height)
#define VT100_WIDTH				(term->width)
#define MAX_COMMAND_ARGS		4
#define KEY_ESC					0x1b
#define KEY_DEL					0x7f
#define KEY_BELL				0x07

#define STATE(NAME, TERM, EV, ARG)	void NAME(win_t *TERM, uint8_t EV, uint16_t ARG)

// states 
enum {
	STATE_IDLE,
	STATE_ESCAPE,
	STATE_COMMAND
};

// events that are passed into states
enum {
	EV_CHAR = 1
};

/*
static struct vt100 {
	union flags {
		uint8_t val;
		struct {
			// 0 = cursor remains on last column when it gets there
			// 1 = lines wrap after last column to next line
			uint8_t cursor_wrap : 1; 
			uint8_t scroll_mode : 1;
			uint8_t origin_mode : 1; 
		}; 
	} flags;
	
	//uint16_t screen_width, screen_height;
	// cursor position on the screen (0, 0) = top left corner. 
	int16_t cursor_x, cursor_y;
	int16_t saved_cursor_x, saved_cursor_y; // used for cursor save restore
	int16_t scroll_start_row, scroll_end_row; 
	// character width and height
	int8_t char_width, char_height;
	// colors used for rendering current characters
	uint16_t back_color, front_color;
	// the starting y-position of the screen scroll
	uint16_t scroll_value; 
	// command arguments that get parsed as they appear in the terminal
	uint8_t narg; uint16_t args[MAX_COMMAND_ARGS];
	// current arg pointer (we use it for parsing) 
	uint8_t carg;
	
	void (*state)(win_t *w, uint8_t ev, uint16_t arg);
	void (*send_response)(char *str);
	void (*ret_state)(win_t *w, uint8_t ev, uint16_t arg); 
} term;*/


typedef struct window win_t;
typedef union flags flags_t;

union flags {
	uint8_t val;
	struct {
		// 0 = cursor remains on last column when it gets there
		// 1 = lines wrap after last column to next line
		uint8_t cursor_wrap : 1; 
		uint8_t scroll_mode : 1;
		uint8_t origin_mode : 1; 
	} f; 
};
	

struct window {
	flags_t flags;
	uint16_t x0;
	uint16_t y0;
	uint16_t width;
	uint16_t height;
	uint16_t z;
	char title[16];
	uint16_t fd;
	win_t *next;
	win_t *prev;
	uint16_t cursor_x;
	uint16_t cursor_y;
	uint16_t saved_cursor_x;
	uint16_t saved_cursor_y;
	uint16_t scroll_start_row;
	uint16_t scroll_end_row;
	uint16_t scroll_value; 
	uint16_t front_color;
	uint16_t back_color;
	char data[2000];
	char *pdata;
	uint16_t narg;
	uint16_t args[MAX_COMMAND_ARGS];
	void (*state)(win_t *w, uint8_t ev, uint16_t arg);
	void (*send_response)(char *str);
	void (*ret_state)(win_t *w, uint8_t ev, uint16_t arg); 
};

struct windows {
	win_t *anchor;
	uint16_t maxFileDesc;
};
typedef struct windows wins_t;

/*----------------------S T A T I C-------------------*/
static wins_t wins;
static const char hextab[] = "0123456789abcdef"; 
static const uint16_t colors[] = {
	0x0000, // black
	0xf800, // red
	0x0780, // green
	0xfe00, // yellow
	0x001f, // blue
	0xf81f, // magenta
	0x07ff, // cyan
	0xffff  // white
};

/*----------------------------------------------------*/


/*-----------------D E C L A R A T I O N S------------*/
STATE(_st_idle, term, ev, arg);
STATE(_st_esc_sq_bracket, term, ev, arg);
STATE(_st_esc_question, term, ev, arg);
STATE(_st_esc_hash, term, ev, arg);
STATE(_st_command_arg, term, ev, arg);



/*-----------------C O M M O N  F U N C---------------*/

void ili9340_setBackColor(uint16_t col) {
	//debugf("ili9340_setBackColor: %d\n", (long)col);
}; 

void ili9340_setFrontColor(uint16_t col) {
	//debugf("ili9340_setFrontColor: %d\n", (long)col);
}; 

void ili9340_fillRect(uint16_t x, uint16_t y, uint16_t w, uint16_t h, uint16_t color) {
	debugf("ili9340_fillRect: %d %d %d %d %d\n", (long)x, (long)y, (long)w, (long)h, (long)color);
}; 


void ili9340_setScrollStart(uint16_t start) {
	debugf("ili9340_setScrollStart: %d\n", (long)start);
}; 

void ili9340_setScrollMargins(uint16_t top, uint16_t bottom) {
	debugf("ili9340_setScrollMargins: %d %d\n", (long)top, (long)bottom);
}; 

void ili9340_drawChar(win_t *w, uint16_t ch) {
	w->data[w->cursor_x + w->cursor_y * 80] = ch;
}

void ili9340_drawCursor(win_t *w) {
	w->data[w->cursor_x + w->cursor_y * 80] = '_';
}

win_t* findWindow(int fd) {
	win_t *w;
	
	w = wins.anchor;
	while (w) {
		if (w->fd == fd) return w; 
		w = w->next;
	}
	
	strcpy(w->title, "Dummy");
	
	return NULL;
}


void _vt100_reset(win_t *term){
	//term->char_height = 8;
	//term->char_width = 6;
	term->x0 = 0;
	term->y0 = 0;
	term->width = 39;
	term->height = 19;
	term->z = 0;
	term->next = NULL;
	term->prev = NULL;
	term->fd = wins.maxFileDesc;
	term->pdata = term->data;
	term->narg = 0;
	term->state = _st_idle;
	//*term->pdata = '_';

	term->back_color = 0x0000;
	term->front_color = 0xffff;
	term->cursor_x = term->cursor_y = term->saved_cursor_x = term->saved_cursor_y = 0;
	term->narg = 0;
	term->state = _st_idle;
	term->ret_state = 0;
	term->scroll_value = 0; 
	term->scroll_start_row = 0;
	term->scroll_end_row = VT100_HEIGHT - 1; // outside of screen = whole screen scrollable
	term->flags.f.cursor_wrap = 1;
	term->flags.f.origin_mode = 0; 
	
 	memset(term->data, ' ', 2000);
   
	ili9340_setFrontColor(term->front_color);
	ili9340_setBackColor(term->back_color);
	ili9340_setScrollMargins(0, 0); 
	ili9340_setScrollStart(0);   
}

win_t* initWindow() {
	win_t *w;
	
	w = (win_t *)malloc(sizeof(win_t));
	if (!w) {
		printf("can't alloc window\n");
		return NULL;
	}
	
	_vt100_reset(w);
	wins.maxFileDesc++;

	return w;
}

void printWindow(win_t *w) {
	printf("Title :%s*\n", w->title);
	printf("   x0 :%d\n", w->x0);
	printf("   y0 :%d\n", w->y0);
	printf("width :%d\n", w->width);
	printf("height:%d\n", w->height);
	printf("     Z:%d\n", w->z);
	printf("    fd:%d\n", w->fd);
}

void printWindows() {
	win_t *w;
	
	w = wins.anchor;
	while (w) {
		printWindow(w);
		w = w->next;
	}
}

void foregroundWindow(win_t *fg) {
	win_t *w;
	
	w = findWindow(fg->fd);
	if (!w) return;
	
	w = wins.anchor;
	while (w) {
		if (w->fd == fg->fd)
			w->z = 0; 
		else
			w->z++;

		w = w->next;
	}

}

void addWindow(win_t *w) {
	if (wins.anchor != NULL) {
		w->next = wins.anchor;
		wins.anchor->prev = w;
	}
	wins.anchor = w;
}

void clearWindow(win_t *w) {
	uint16_t y;
	char *p;
	
	for (y = w->y0; y <= w->height + w->y0 + 1; y++) {
		p = SCREEN + 80 * y + w->x0;
		memset(p, ' ', w->width + 2);
	}
	
}

void drawWindow(win_t *w) {
	uint16_t i, k;
	uint16_t tlen;
	uint16_t tmax;
	char *p, c;
	
	tlen = strlen(w->title);
	tmax = w->width - 6;
	
	p = SCREEN + 80 * w->y0 + w->x0;
	
	if (tlen > tmax) tlen = tmax;
	

	/*	185:╣	186:║	187:╗	188:╝	200:╚
		201:╔	202:╩	203:╦	204:╠	205:═	206:╬	*/

	for (i = 0, k = 0; i <= w->width+1; i++) {
		if (i == 0) c = 201;
		if (i > 0) c = 205;
		if (i > 2 && k < tlen) {
			c = w->title[k];
			k++;
		}			
		if (i == w->width - 5) c = '[';
		if (i == w->width - 4) c = '_';
		if (i == w->width - 3) c = '-';
		if (i == w->width - 2) c = 'X';
		if (i == w->width - 1) c = ']';
//		if (i == w->width - 0) c = 205;
		if (i == w->width + 1) c = 187;

		if (w->x0 + i < 80) {
			*p = c;
			p++;
		}
	}
	
	for (i = 1; i <= w->height; i++) {
		p = SCREEN + 80 * (w->y0 + i) + w->x0;
		memcpy(p+1, w->data + 80 * (i-1), w->width);
		*p = 186;
		p += w->width + 1;
		*p = 186;
	}
	
	p = SCREEN + 80 * (w->y0 + w->height + 1) + w->x0;

	for (i = 0, k = 0; i <= w->width+1; i++) {
		if (i == 0) c = 200;
		if (i > 0) c = 205;
		if (i == w->width + 1) c = 188;
		*p = c;
		p++;
	}	
}

void drawWindows() {
	win_t *w;
	
	w = wins.anchor;
	while(w) {
		if (w->next == NULL) break;
		w = w->next;
	}
	
	while(w) {
		drawWindow(w);
		w = w->prev;
	}
}

int w_open(char *path, int oflags) {
	
	uint16_t i;
	uint16_t tlen;
	uint16_t state;
	uint16_t start;
	win_t *w;
	char cnum[3];

	w = initWindow();
	if (!w) return -1;
	
	state = 0;
	start = 0;
	cnum[2] = 0;

	//printf("%s\n", path);
	
	for (i = 0;; i++) {
		switch (path[i]) {
			
		case 'X':
			if (state != 0) {
				start = i;
			}
			break;
		case 'Y':
			if (state != 0) {
				state = 2;
				start = i;
			}
			break;
		case 'W':
			if (state != 0) {
				state = 3;
				start = i;
			}
			break;
		case 'H':
			if (state != 0) {
				state = 4;
				start = i;
			}
			break;
		case 0:
		case ',':
			
			cnum[0] = path[start+1];
			cnum[1] = path[start+2];
			
			switch (state) {
			case 0:
				tlen = i;
				if (tlen > 15) tlen = 15;
				//printf("tlen: %d\n", tlen);
				if (tlen) {
					memset(w->title, 0, sizeof(w->title));
					memcpy(w->title, path, tlen);
				}
				state++;
				break;
			case 1:
				w->x0 = atoi(cnum);
				//printf("start: %d, end: %d num: %s\n", start, i, cnum);
				break;
			case 2:
				w->y0 = atoi(cnum);
				break;
			case 3:
				w->width = atoi(cnum);
				if (w->width > WIDTH_MAX) w->width = WIDTH_MAX; 
				if (w->width < WIDTH_MIN) w->width = WIDTH_MIN; 
				
				break;
			case 4:
				w->height = atoi(cnum);
				if (w->height > HEIGHT_MAX) w->height = HEIGHT_MAX; 
				if (w->height < HEIGHT_MIN) w->height = HEIGHT_MIN; 
				break;
			default:
				break;
			}
			break;
		default:
			break;
		}
		if (path[i] == 0) break;
	}
	
	w->scroll_end_row = w->height;
	
	addWindow(w);
	foregroundWindow(w);
	drawWindows();
	
	//printWindow(w);
	
	return w->fd;
}

int w_close(int fd) {
	win_t *w, *pred;
	
	w = findWindow(fd);
	if (w) {
		if (w == wins.anchor) {
			wins.anchor = w->next;
			w->next->prev = NULL;
		} else {
			w->prev->next = w->next;
			w->next->prev = w->prev;
		}
		clearWindow(w);
		free(w);
		drawWindows();
	}
}

#define VT100_CURSOR_X(TERM) (TERM->cursor_x)

uint16_t VT100_CURSOR_Y(win_t *t){
	uint16_t scroll_height;
	uint16_t row;
	
	// if within the top or bottom margin areas then normal addressing
	if(t->cursor_y < t->scroll_start_row || t->cursor_y >= t->scroll_end_row){
		return t->cursor_y * VT100_CHAR_HEIGHT; 
	} else {
		// otherwise we are inside scroll area
		scroll_height = t->scroll_end_row - t->scroll_start_row;
		row = t->cursor_y + t->scroll_value; 
		if(t->cursor_y + t->scroll_value >= t->scroll_end_row)
			row -= scroll_height; 
		return row * VT100_CHAR_HEIGHT; 
	}

}


void _vt100_clearLines(win_t *t, uint16_t start_line, uint16_t end_line){
	int c, cy;
	debugf("_vt100_clearLines start_line:%d, end_line:%d\n", (long)start_line, (long)end_line);
	
	for(c = start_line; c <= end_line; c++){
		cy = t->cursor_y;
		t->cursor_y = c; 
		ili9340_fillRect(0, VT100_CURSOR_Y(t), VT100_SCREEN_WIDTH, VT100_CHAR_HEIGHT, 0x0000);
		t->cursor_y = cy;
	}
}


// scrolls the scroll region up (lines > 0) or down (lines < 0)
void _vt100_scroll(win_t *t, int16_t lines){
	uint16_t scroll_height;
	uint16_t scroll_start;
	uint8_t *srcp, *dstp;
	
	if(!lines) return;

	// get height of scroll area in rows
	scroll_height = t->scroll_end_row - t->scroll_start_row; 
	// clearing of lines that we have scrolled up or down
	
	
	if(lines > 0){
		//_vt100_clearLines(t, t->scroll_start_row, t->scroll_start_row+lines-1); 
		// update the scroll value (wraps around scroll_height)
		//t->scroll_value = (t->scroll_value + lines) % scroll_height;
		// scrolling up so clear first line of scroll area
		//uint16_t y = (t->scroll_start_row + t->scroll_value) * VT100_CHAR_HEIGHT; 
		//ili9340_fillRect(0, y, VT100_SCREEN_WIDTH, lines * VT100_CHAR_HEIGHT, 0x0000);
		
		dstp = t->data + t->scroll_start_row * 80;
		srcp = dstp + 80;
		memmove(dstp, srcp, (t->scroll_end_row - t->scroll_start_row - 1) * 80);
		memset(t->data + (t->scroll_end_row - 1) * 80, ' ', 80); 
	} else if(lines < 0){
		_vt100_clearLines(t, t->scroll_end_row - lines, t->scroll_end_row - 1); 
		// make sure that the value wraps down 
		//t->scroll_value = (scroll_height + t->scroll_value + lines) % scroll_height; 
		// scrolling down - so clear last line of the scroll area
		//uint16_t y = (t->scroll_start_row + t->scroll_value) * VT100_CHAR_HEIGHT; 
		//ili9340_fillRect(0, y, VT100_SCREEN_WIDTH, lines * VT100_CHAR_HEIGHT, 0x0000);
	}
	/*
	scroll_start = (t->scroll_start_row + t->scroll_value) * VT100_CHAR_HEIGHT; 
	
	ili9340_setScrollStart(scroll_start); 
	*/
	
	
	//debugf("_vt100_scroll line:%d, scr_height:%d, scr_start_row:%d, scr_end_row:%d \n", (long)lines, (long)scroll_height, (long)t->scroll_start_row, (long)t->scroll_end_row);
	
}


// moves the cursor relative to current cursor position and scrolls the screen
void _vt100_move(win_t *term, int16_t right_left, int16_t bottom_top){
	// calculate how many lines we need to move down or up if x movement goes outside screen
	int16_t new_y;
	int16_t to_scroll;
	int16_t new_x;

	new_x = right_left + term->cursor_x; 
		
	if(new_x >= (int16_t)(VT100_WIDTH)){
		if(term->flags.f.cursor_wrap){
			bottom_top += new_x / VT100_WIDTH;
			term->cursor_x = new_x % VT100_WIDTH /*- 1*/;
		} else {
			term->cursor_x = VT100_WIDTH;
		}
	} else if(new_x < 0){
		//bottom_top += new_x / VT100_WIDTH - 1;
		//term->cursor_x = VT100_WIDTH - (abs(new_x) % VT100_WIDTH) + 1;
	} else {
		term->cursor_x = new_x;
	}

	//debugf("move: new_x:%d, term->cursor_x:%d, bottom_top:%d \n", (long)new_x, (long)term->cursor_x, (long)bottom_top);
	
	if(bottom_top){
		new_y = term->cursor_y + bottom_top;
		to_scroll = 0;
		// bottom margin 39 marks last line as static on 40 line display
		// therefore, we would scroll when new cursor has moved to line 39
		// (or we could use new_y > VT100_HEIGHT here
		// NOTE: new_y >= term->scroll_end_row ## to_scroll = (new_y - term->scroll_end_row) +1
		if(new_y >= term->scroll_end_row){
			//scroll = new_y / VT100_HEIGHT;
			//term->cursor_y = VT100_HEIGHT;
			to_scroll = (new_y - term->scroll_end_row) + 1; 
			// place cursor back within the scroll region
			term->cursor_y = term->scroll_end_row - 1; //new_y - to_scroll; 
			//scroll = new_y - term->bottom_margin; 
			//term->cursor_y = term->bottom_margin; 
		} else if(new_y < term->scroll_start_row){
			to_scroll = (new_y - term->scroll_start_row); 
			term->cursor_y = term->scroll_start_row; //new_y - to_scroll; 
			//scroll = new_y / (term->bottom_margin - term->top_margin) - 1;
			//term->cursor_y = term->top_margin; 
		} else {
			// otherwise we move as normal inside the screen
			term->cursor_y = new_y;
		}
		_vt100_scroll(term, to_scroll);
		
		//debugf("move: new_y:%d, term->cursor_y:%d, to_scroll:%d \n", (long)new_y, (long)term->cursor_y, (long)to_scroll);

	}
}


void _vt100_putc(win_t *w, uint8_t ch){
	uint16_t x;
	uint16_t y;
	
	if(ch < 0x20 || ch > 0x7e){
		_vt100_putc(w, '0'); 
		_vt100_putc(w, 'x'); 
		_vt100_putc(w, hextab[((ch & 0xf0) >> 4)]);
		_vt100_putc(w, hextab[(ch & 0x0f)]);
		return;
	}
	
	// calculate current cursor position in the display ram
	x = VT100_CURSOR_X(w);
	y = VT100_CURSOR_Y(w);

	//debugf("_vt100_putc x:%d y:%d addr:%d\n", (long)x, (long)y, (long)(x + y * w->width));
	
	ili9340_setFrontColor(w->front_color);
	ili9340_setBackColor(w->back_color); 
	
	ili9340_drawChar(w, ch);
	
	// move cursor right
	_vt100_move(w, 1, 0); 
	ili9340_drawCursor(w);
}

void vt100_putc(win_t *w, uint8_t c){	
	w->state(w, EV_CHAR, 0x0000 | c);
}

ssize_t w_write(int fd, char *buf, size_t len) {
	
	win_t *w;
	size_t l;
	
	l = len;
	
	w = findWindow(fd);
	if (!w) return -1;
	
	for (; len; len--, buf++) {	
		w->state(w, EV_CHAR, 0x0000 | *buf);
		//vt100_putc(w, *buf);
	}
	
	drawWindows();
	return l;
}


void _vt100_resetScroll(win_t *term){
	term->scroll_start_row = 0;
	term->scroll_end_row = VT100_HEIGHT;
	term->scroll_value = 0; 
	ili9340_setScrollMargins(0, 0);
	ili9340_setScrollStart(0); 
}

STATE(_st_esc_question, term, ev, arg){
	// DEC mode commands
	switch(ev){
		case EV_CHAR: {
			if(isdigit(arg)){ // start of an argument
				term->ret_state = _st_esc_question; 
				_st_command_arg(term, ev, arg);
				term->state = _st_command_arg;
			} else if(arg == ';'){ // arg separator. 
				// skip. And also stay in the command state
			} else {
				switch(arg) {
					case 'l': 
						// dec mode: OFF (arg[0] = function)
					case 'h': {
						// dec mode: ON (arg[0] = function)
						switch(term->args[0]){
							case 1: { // cursor keys mode
								// h = esc 0 A for cursor up
								// l = cursor keys send ansi commands
								break;
							}
							case 2: { // ansi / vt52
								// h = ansi mode
								// l = vt52 mode
								break;
							}
							case 3: {
								// h = 132 chars per line
								// l = 80 chars per line
								break;
							}
							case 4: {
								// h = smooth scroll
								// l = jump scroll
								break;
							}
							case 5: {
								// h = black on white bg
								// l = white on black bg
								break;
							}
							case 6: {
								// h = cursor relative to scroll region
								// l = cursor independent of scroll region
								term->flags.f.origin_mode = (arg == 'h')?1:0; 
								break;
							}
							case 7: {
								// h = new line after last column
								// l = cursor stays at the end of line
								term->flags.f.cursor_wrap = (arg == 'h')?1:0; 
								break;
							}
							case 8: {
								// h = keys will auto repeat
								// l = keys do not auto repeat when held down
								break;
							}
							case 9: {
								// h = display interlaced
								// l = display not interlaced
								break;
							}
							// 10-38 - all quite DEC speciffic commands so omitted here
						}
						term->state = _st_idle;
						break; 
					}
					case 'i': /* Printing */  
					case 'n': /* Request printer status */
					default:  
						term->state = _st_idle; 
						break;
				}
				term->state = _st_idle;
			}
		}
	}
}

STATE(_st_esc_left_br, term, ev, arg){
	switch(ev){
		case EV_CHAR: {
			switch(arg) {  
				case 'A':  
				case 'B':  
					// translation map command?
				case '0':  
				case 'O':
					// another translation map command?
					term->state = _st_idle;
					break;
				default:
					term->state = _st_idle;
			}
			//term->state = _st_idle;
		}
	}
}

STATE(_st_esc_right_br, term, ev, arg){
	switch(ev){
		case EV_CHAR: {
			switch(arg) {  
				case 'A':  
				case 'B':  
					// translation map command?
				case '0':  
				case 'O':
					// another translation map command?
					term->state = _st_idle;
					break;
				default:
					term->state = _st_idle;
			}
			//term->state = _st_idle;
		}
	}
}

STATE(_st_esc_hash, term, ev, arg){
	switch(ev){
		case EV_CHAR: {
			switch(arg) {  
				case '8': {
					// self test: fill the screen with 'E'
					
					term->state = _st_idle;
					break;
				}
				default:
					term->state = _st_idle;
			}
		}
	}
}

STATE(_st_escape, term, ev, arg){
	uint16_t c;
	
	switch(ev){
		case EV_CHAR: {
			#define CLEAR_ARGS \
				{ term->narg = 0;\
				for(c = 0; c < MAX_COMMAND_ARGS; c++)\
					term->args[c] = 0; }\
			
			switch(arg){
				case '[': { // command
					// prepare command state and switch to it
					CLEAR_ARGS; 
					term->state = _st_esc_sq_bracket;
					break;
				}
				case '(': /* ESC ( */  
					CLEAR_ARGS;
					term->state = _st_esc_left_br;
					break; 
				case ')': /* ESC ) */  
					CLEAR_ARGS;
					term->state = _st_esc_right_br;
					break;  
				case '#': // ESC # 
					CLEAR_ARGS;
					term->state = _st_esc_hash;
					break;  
				case 'P': //ESC P (DCS, Device Control String)
					term->state = _st_idle; 
					break;
				case 'D': // moves cursor down one line and scrolls if necessary
					// move cursor down one line and scroll window if at bottom line
					_vt100_move(term, 0, 1); 
					term->state = _st_idle;
					break; 
				case 'M': // Cursor up
					// move cursor up one line and scroll window if at top line
					_vt100_move(term, 0, -1); 
					term->state = _st_idle;
					break; 
				case 'E': // next line
					// same as '\r\n'
					_vt100_move(term, 0, 1);
					term->cursor_x = 0; 
					term->state = _st_idle;
					break;  
				case '7': // Save attributes and cursor position  
				case 's':  
					term->saved_cursor_x = term->cursor_x;
					term->saved_cursor_y = term->cursor_y;
					term->state = _st_idle;
					break;  
				case '8': // Restore them  
				case 'u': 
					term->cursor_x = term->saved_cursor_x;
					term->cursor_y = term->saved_cursor_y; 
					term->state = _st_idle;
					break; 
				case '=': // Keypad into applications mode 
					term->state = _st_idle;
					break; 
				case '>': // Keypad into numeric mode   
					term->state = _st_idle;
					break;  
				case 'Z': // Report terminal type 
					// vt 100 response
					term->send_response("\033[?1;0c");  
					// unknown terminal     
						//out("\033[?c");
					term->state = _st_idle;
					break;    
				case 'c': // Reset terminal to initial state 
					_vt100_reset(term);
					term->state = _st_idle;
					break;  
				case 'H': // Set tab in current position 
				case 'N': // G2 character set for next character only  
				case 'O': // G3 "               "     
				case '<': // Exit vt52 mode
					// ignore
					term->state = _st_idle;
					break; 
				case KEY_ESC: { // marks start of next escape sequence
					// stay in escape state
					break;
				}
				default: { // unknown sequence - return to normal mode
					term->state = _st_idle;
					break;
				}
			}
			#undef CLEAR_ARGS
			break;
		}
		default: {
			// for all other events restore normal mode
			term->state = _st_idle; 
		}
	}
}


STATE(_st_idle, term, ev, arg){
	//debugf("idle\n");
	ili9340_drawChar(term, ' ');

	switch(ev){
		case EV_CHAR: {
			switch(arg){
				
				case 5: // AnswerBack for vt100's  
					term->send_response("X"); // should send SCCS_ID?
					break;  
				case '\n': { // new line
					_vt100_move(term, 0, 1);
					term->cursor_x = 0; 
					//_vt100_moveCursor(term, 0, term->cursor_y + 1);
					// do scrolling here! 
					break;
				}
				case '\r': { // carrage return (0x0d)
					term->cursor_x = 0; 
					//_vt100_move(term, 0, 1);
					//_vt100_moveCursor(term, 0, term->cursor_y); 
					break;
				}
				case '\b': { // backspace 0x08
					_vt100_move(term, -1, 0); 
					// backspace does not delete the character! Only moves cursor!
					//ili9340_drawChar(term->cursor_x * term->char_width,
					//	term->cursor_y * term->char_height, ' ');
					break;
				}
				case KEY_DEL: { // del - delete character under cursor
					// Problem: with current implementation, we can't move the rest of line
					// to the left as is the proper behavior of the delete character
					// fill the current position with background color
					_vt100_putc(term, ' ');
					_vt100_move(term, -1, 0);
					//_vt100_clearChar(term, term->cursor_x, term->cursor_y); 
					break;
				}
				case '\t': { // tab
					// tab fills characters on the line until we reach a multiple of tab_stop
					int tab_stop = 4;
					int to_put = tab_stop - (term->cursor_x % tab_stop); 
					while(to_put--) _vt100_putc(term, ' ');
					break;
				}
				case KEY_BELL: { // bell is sent by bash for ex. when doing tab completion
					// sound the speaker bell?
					// skip
					break; 
				}
				case KEY_ESC: {// escape
					term->state = _st_escape;
					break;
				}
				default: {
					_vt100_putc(term, arg);
					break;
				}
			}
			break;
		}
		default: {}
	}
	ili9340_drawCursor(term);
}

STATE(_st_command_arg, term, ev, arg){
	switch(ev){
		case EV_CHAR: {
			if(isdigit(arg)){ // a digit argument
				term->args[term->narg] = term->args[term->narg] * 10 + (arg - '0');
			} else if(arg == ';') { // separator
				term->narg++;
			} else { // no more arguments
				// go back to command state 
				term->narg++;
				if(term->ret_state){
					term->state = term->ret_state;
				}
				else {
					term->state = _st_idle;
				}
				// execute next state as well because we have already consumed a char!
				term->state(term, ev, arg);
			}
			break;
		}
	}
}

STATE(_st_esc_sq_bracket, term, ev, arg){
	uint16_t n;
	uint16_t x;
	uint16_t y;
	uint16_t top_margin;
	uint16_t bottom_margin;
	uint16_t c;
	
	switch(ev){
		case EV_CHAR: {
			if(isdigit(arg)){ // start of an argument
				term->ret_state = _st_esc_sq_bracket; 
				_st_command_arg(term, ev, arg);
				term->state = _st_command_arg;
			} else if(arg == ';'){ // arg separator. 
				// skip. And also stay in the command state
			} else { // otherwise we execute the command and go back to idle
				switch(arg){
					case 'A': {// move cursor up (cursor stops at top margin)
						n = (term->narg > 0)?term->args[0]:1;
						term->cursor_y -= n;
						if(term->cursor_y < 0) term->cursor_y = 0; 
						term->state = _st_idle; 
						break;
					} 
					case 'B': { // cursor down (cursor stops at bottom margin)
						n = (term->narg > 0)?term->args[0]:1;
						term->cursor_y += n;
						if(term->cursor_y > VT100_HEIGHT) term->cursor_y = VT100_HEIGHT; 
						term->state = _st_idle; 
						break;
					}
					case 'C': { // cursor right (cursor stops at right margin)
						n = (term->narg > 0)?term->args[0]:1;
						term->cursor_x += n;
						if(term->cursor_x > VT100_WIDTH) term->cursor_x = VT100_WIDTH;
						term->state = _st_idle; 
						break;
					}
					case 'D': { // cursor left
						n = (term->narg > 0)?term->args[0]:1;
						term->cursor_x -= n;
						if(term->cursor_x < 0) term->cursor_x = 0;
						term->state = _st_idle; 
						break;
					}
					case 'f': 
					case 'H': { // move cursor to position (default 0;0)
						// cursor stops at respective margins
						term->cursor_x = (term->narg >= 1)?(term->args[1]-1):0; 
						term->cursor_y = (term->narg == 2)?(term->args[0]-1):0;
						if(term->flags.f.origin_mode) {
							term->cursor_y += term->scroll_start_row;
							if(term->cursor_y >= term->scroll_end_row){
								term->cursor_y = term->scroll_end_row - 1;
							}
						}
						if(term->cursor_x > VT100_WIDTH) term->cursor_x = VT100_WIDTH;
						if(term->cursor_y > VT100_HEIGHT) term->cursor_y = VT100_HEIGHT; 
						term->state = _st_idle; 
						break;
					}
					case 'J':{// clear screen from cursor up or down
						y = VT100_CURSOR_Y(term); 
						if(term->narg == 0 || (term->narg == 1 && term->args[0] == 0)){
							// clear down to the bottom of screen (including cursor)
							_vt100_clearLines(term, term->cursor_y, VT100_HEIGHT); 
						} else if(term->narg == 1 && term->args[0] == 1){
							// clear top of screen to current line (including cursor)
							_vt100_clearLines(term, 0, term->cursor_y); 
						} else if(term->narg == 1 && term->args[0] == 2){
							// clear whole screen
							_vt100_clearLines(term, 0, VT100_HEIGHT);
							// reset scroll value
							_vt100_resetScroll(term); 
						}
						term->state = _st_idle; 
						break;
					}
					case 'K':{// clear line from cursor right/left
						x = VT100_CURSOR_X(term);
						y = VT100_CURSOR_Y(term);

						if(term->narg == 0 || (term->narg == 1 && term->args[0] == 0)){
							// clear to end of line (to \n or to edge?)
							// including cursor
							ili9340_fillRect(x, y, VT100_SCREEN_WIDTH - x, VT100_CHAR_HEIGHT, term->back_color);
						} else if(term->narg == 1 && term->args[0] == 1){
							// clear from left to current cursor position
							ili9340_fillRect(0, y, x + VT100_CHAR_WIDTH, VT100_CHAR_HEIGHT, term->back_color);
						} else if(term->narg == 1 && term->args[0] == 2){
							// clear whole current line
							ili9340_fillRect(0, y, VT100_SCREEN_WIDTH, VT100_CHAR_HEIGHT, term->back_color);
						}
						term->state = _st_idle; 
						break;
					}
					
					case 'L': // insert lines (args[0] = number of lines)
					case 'M': // delete lines (args[0] = number of lines)
						term->state = _st_idle;
						break; 
					case 'P': {// delete characters args[0] or 1 in front of cursor
						// TODO: this needs to correctly delete n chars
						n = ((term->narg > 0)?term->args[0]:1);
						_vt100_move(term, -n, 0);
						for(c = 0; c < n; c++){
							_vt100_putc(term, ' ');
						}
						term->state = _st_idle;
						break;
					}
					case 'c':{ // query device code
						term->send_response("\x1b[?1;0c"); 
						term->state = _st_idle; 
						break; 
					}
					case 'x': {
						term->state = _st_idle;
						break;
					}
					case 's':{// save cursor pos
						term->saved_cursor_x = term->cursor_x;
						term->saved_cursor_y = term->cursor_y;
						term->state = _st_idle; 
						break;
					}
					case 'u':{// restore cursor pos
						term->cursor_x = term->saved_cursor_x;
						term->cursor_y = term->saved_cursor_y; 
						//_vt100_moveCursor(term, term->saved_cursor_x, term->saved_cursor_y);
						term->state = _st_idle; 
						break;
					}
					case 'h':
					case 'l': {
						term->state = _st_idle;
						break;
					}
					
					case 'g': {
						term->state = _st_idle;
						break;
					}
					case 'm': { // sets colors. Accepts up to 3 args
						// [m means reset the colors to default
						if(!term->narg){
							term->front_color = 0xffff;
							term->back_color = 0x0000;
						}
						while(term->narg){
							term->narg--; 
							n = term->args[term->narg];
							if(n == 0){ // all attributes off
								term->front_color = 0xffff;
								term->back_color = 0x0000;
								
								ili9340_setFrontColor(term->front_color);
								ili9340_setBackColor(term->back_color);
							}
							if(n >= 30 && n < 38){ // fg colors
								term->front_color = colors[n-30]; 
								ili9340_setFrontColor(term->front_color);
							} else if(n >= 40 && n < 48){
								term->back_color = colors[n-40]; 
								ili9340_setBackColor(term->back_color); 
							}
						}
						term->state = _st_idle; 
						break;
					}
					
					case '@': // Insert Characters          
						term->state = _st_idle;
						break; 
					case 'r': // Set scroll region (top and bottom margins)
						// the top value is first row of scroll region
						// the bottom value is the first row of static region after scroll
						if(term->narg == 2 && term->args[0] < term->args[1]){
							// [1;40r means scroll region between 8 and 312
							// bottom margin is 320 - (40 - 1) * 8 = 8 pix
							term->scroll_start_row = term->args[0] - 1;
							term->scroll_end_row = term->args[1] - 1; 
							top_margin = term->scroll_start_row * VT100_CHAR_HEIGHT;
							bottom_margin = VT100_SCREEN_HEIGHT -
								(term->scroll_end_row * VT100_CHAR_HEIGHT); 
							ili9340_setScrollMargins(top_margin, bottom_margin);
							//ili9340_setScrollStart(0); // reset scroll 
						} else {
							_vt100_resetScroll(term); 
						}
						term->state = _st_idle; 
						break;  
					case 'i': // Printing  
					case 'y': // self test modes..
					case '=':{ // argument follows... 
						//term->state = _st_screen_mode;
						term->state = _st_idle; 
						break; 
					}
					case '?': // '[?' escape mode
						term->state = _st_esc_question;
						break; 
					default: { // unknown sequence
						
						term->state = _st_idle;
						break;
					}
				}
				//term->state = _st_idle;
			} // else
			break;
		}
		default: { // switch (ev)
			// for all other events restore normal mode
			term->state = _st_idle; 
		}
	}
}


int main(int argv, char **s) {
	
	int fd0, fd1, c;
	
	wins.anchor = NULL;
	wins.maxFileDesc = FILEDESC;
	
	fd0 = w_open("W:FD0,X01,Y02,W11,H10", 0);
	fd1 = w_open("W:FD1,X15,Y05,W40,H15", 0);

	w_write(fd0, "1234567890\x1b[B4567890", 20);
	w_write(fd1, "123456789012345678901234567890123456789012345678901234567890", 60);
	
	while(1) {
		c = getchar();
		w_write(fd0, (char *)&c, 1);
		if (c == 'X') break;
	}

	getchar();	
	w_close(fd1);
	getchar();
	w_close(fd0);
	getchar();
	
	printWindows();
	return 0;
}