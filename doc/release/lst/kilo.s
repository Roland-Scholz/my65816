;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
;/* Kilo -- A very simple editor in less than 1-kilo lines of code (as counted
; *         by "cloc"). Does not depend on libcurses, directly emits VT100
; *         escapes on the terminal.
; *
; * -----------------------------------------------------------------------
; *
; * Copyright (C) 2016 Salvatore Sanfilippo <antirez at gmail dot com>
; *
; * All rights reserved.
; *
; * Redistribution and use in source and binary forms, with or without
; * modification, are permitted provided that the following conditions are
; * met:
; *
; *  *  Redistributions of source code must retain the above copyright
; *     notice, this list of conditions and the following disclaimer.
; *
; *  *  Redistributions in binary form must reproduce the above copyright
; *     notice, this list of conditions and the following disclaimer in the
; *     documentation and/or other materials provided with the distribution.
; *
; * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
; * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
; * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
; * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
; * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
; * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
; * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
; * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
; * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
; * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
; * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
; */
;
;#include <stdio.h>
;#include <stdlib.h>
;#include <string.h>
;#include <stdbool.h>
;#include <errno.h>
;#include <unistd.h>
;#include <dirent.h>
;
;#include "freeRTOS.h"
;#include "task.h"
;#include <homebrew.h>
;
;
;#define KILO_VERSION "0.0.1"
;
;#define SCREENADR 0x7FF000
;#define FALSE 0
;#define TRUE !FALSE
;
;
;/* Syntax highlight types */
;#define HL_NORMAL 0
;#define HL_NONPRINT 1
;#define HL_COMMENT 2   /* Single line comment. */
;#define HL_MLCOMMENT 3 /* Multi-line comment. */
;#define HL_KEYWORD1 4
;#define HL_KEYWORD2 5
;#define HL_STRING 6
;#define HL_NUMBER 7
;#define HL_MATCH 8      /* Search match. */
;
;#define HL_HIGHLIGHT_STRINGS (1<<0)
;#define HL_HIGHLIGHT_NUMBERS (1<<1)
;
;
;struct editorSyntax {
;    char **filematch;
;    char **keywords;
;    char singleline_comment_start[2];
;    char multiline_comment_start[3];
;    char multiline_comment_end[3];
;    int flags;
;};
;
;/* This structure represents a single line of the file we are editing. */
;typedef struct erow {
;    int idx;            /* Row index in the file, zero-based. */
;    int size;           /* Size of the row, excluding the null term. */
;    int rsize;          /* Size of the rendered row. */
;    char *chars;        /* Row content. */
;    char *render;       /* Row content "rendered" for screen (for TABs). */
;    unsigned char *hl;  /* Syntax highlight type for each character in render.*/
;    int hl_oc;          /* Row had open comment at end in last syntax highlight
;                           check. */
;} erow;
;
;typedef struct hlcolor {
;    int r,g,b;
;} hlcolor;
;
;struct editorConfig {
;    unsigned int cx,cy;  /* Cursor x and y position in characters */
;    unsigned int rowoff;     /* Offset of row displayed. */
;    unsigned int coloff;     /* Offset of column displayed. */
;    unsigned int screenrows; /* Number of rows that we can show */
;    unsigned int screencols; /* Number of cols that we can show */
;    unsigned int numrows;    /* Number of rows */
;    unsigned int rawmode;    /* Is terminal raw mode enabled? */
;    erow *row;      /* Rows */
;    unsigned int dirty;      /* File modified but not saved. */
;	unsigned int readonly;
;	unsigned int hex;
;    char *filename; /* Currently open filename */
;    char statusmsg[80];
;    time_t statusmsg_time;
;    struct editorSyntax *syntax;    /* Current syntax highlight, or NULL. */
;	unsigned int rowsavail;
;};
;
;static struct editorConfig E;
;static int end;
;static char status[81];
;
;enum KEY_ACTION{
;        KEY_NULL = 0,       /* NULL */
;		CTRL_B = 2,
;        CTRL_C = 3,         /* Ctrl-c */
;        CTRL_D = 4,         /* Ctrl-d */
;		CTRL_E = 5,			/* Ctrl-e */
;        CTRL_F = 6,         /* Ctrl-f */
;        CTRL_H = 8,         /* Ctrl-h */
;        TAB = 9,            /* Tab */
;        CTRL_L = 12,        /* Ctrl+l */
;        CTRL_N = 14,        /* Ctrl+n */
;        ENTER = 10,         /* Enter */
;        CTRL_Q = 17,        /* Ctrl-q */
;        CTRL_S = 19,        /* Ctrl-s */
;        CTRL_U = 21,        /* Ctrl-u */
;        CTRL_X = 24,        /* Ctrl-x */
;        ESC = 27,           /* Escape */
;        BACKSPACE =  127,   /* Backspace */
;        /* The following are just soft codes, not really reported by the
;         * terminal directly. */
;        ARROW_LEFT = 1000,
;        ARROW_RIGHT,
;        ARROW_UP,
;        ARROW_DOWN,
;        DEL_KEY,
;        HOME_KEY,
;        END_KEY,
;        PAGE_UP,
;        PAGE_DOWN,
;		HOME_LINE,
;		END_LINE
;};
;
;void editorSetStatusMessage(const char *fmt, ...);
;void editorRefreshScreen(void);
;
;//unsigned char *ucHeap16 = (unsigned char *)0x0A000;
;//unsigned char *ucHeap = (unsigned char *)0x010000;
;//extern unsigned char fd2iocb[8];
;
;time_t time(time_t *t) {
	code
	xdef	~~time
	func
~~time:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
t_0	set	4
;	return 0;
	lda	#$0
	tax
	tay
	lda	<L2+2
	sta	<L2+2+4
	lda	<L2+1
	sta	<L2+1+4
	pld
	tsc
	clc
	adc	#L2+4
	tcs
	tya
	rtl
;}
L2	equ	0
L3	equ	1
	ends
	efunc
;int tcgetattr(int fd, struct termios *termios_p) {
	code
	xdef	~~tcgetattr
	func
~~tcgetattr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L5
	tcs
	phd
	tcd
fd_0	set	4
termios_p_0	set	6
;	return 1;
	lda	#$1
	tay
	lda	<L5+2
	sta	<L5+2+6
	lda	<L5+1
	sta	<L5+1+6
	pld
	tsc
	clc
	adc	#L5+6
	tcs
	tya
	rtl
;}
L5	equ	0
L6	equ	1
	ends
	efunc
;
;int tcsetattr(int fd, int optional_actions, struct termios *termios_p) {
	code
	xdef	~~tcsetattr
	func
~~tcsetattr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L8
	tcs
	phd
	tcd
fd_0	set	4
optional_actions_0	set	6
termios_p_0	set	8
;	return 1;
	lda	#$1
	tay
	lda	<L8+2
	sta	<L8+2+8
	lda	<L8+1
	sta	<L8+1+8
	pld
	tsc
	clc
	adc	#L8+8
	tcs
	tya
	rtl
;}
L8	equ	0
L9	equ	1
	ends
	efunc
;
;void exit(int status) {
	code
	xdef	~~exit
	func
~~exit:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L11
	tcs
	phd
	tcd
status_0	set	4
;}
	lda	<L11+2
	sta	<L11+2+2
	lda	<L11+1
	sta	<L11+1+2
	pld
	tsc
	clc
	adc	#L11+2
	tcs
	rtl
L11	equ	0
L12	equ	1
	ends
	efunc
;
;void toggleHex() {
	code
	xdef	~~toggleHex
	func
~~toggleHex:
	longa	on
	longi	on
;	if (E.hex) E.hex = 0;
	lda	|~~E+24
	beq	L10001
	stz	|~~E+24
;	else E.hex++;
	bra	L17
L10001:
	inc	|~~E+24
;}
L17:
	rtl
L14	equ	0
L15	equ	1
	ends
	efunc
;
;#if 0
;/* =========================== Syntax highlights DB =========================
; *
; * In order to add a new syntax, define two arrays with a list of file name
; * matches and keywords. The file name matches are used in order to match
; * a given syntax with a given file name: if a match pattern starts with a
; * dot, it is matched as the last past of the filename, for example ".c".
; * Otherwise the pattern is just searched inside the filenme, like "Makefile").
; *
; * The list of keywords to highlight is just a list of words, however if they
; * a trailing '|' character is added at the end, they are highlighted in
; * a different color, so that you can have two different sets of keywords.
; *
; * Finally add a stanza in the HLDB global variable with two two arrays
; * of strings, and a set of flags in order to enable highlighting of
; * comments and numbers.
; *
; * The characters for single and multi line comments must be exactly two
; * and must be provided as well (see the C language example).
; *
; * There is no support to highlight patterns currently. */
;
;/* C / C++ */
;char *C_HL_extensions[] = {".c",".cpp",NULL};
;char *C_HL_keywords[] = {
;        /* A few C / C++ keywords */
;        "switch","if","while","for","break","continue","return","else",
;        "struct","union","typedef","static","enum","class",
;        /* C types */
;        "int|","long|","double|","float|","char|","unsigned|","signed|",
;        "void|",NULL
;};
;
;/* Here we define an array of syntax highlights by extensions, keywords,
; * comments delimiters and flags. */
;struct editorSyntax HLDB[] = {
;    {
;        /* C / C++ */
;        C_HL_extensions,
;        C_HL_keywords,
;        "//","/*","*/",
;        HL_HIGHLIGHT_STRINGS | HL_HIGHLIGHT_NUMBERS
;    }
;};
;
;#define HLDB_ENTRIES (sizeof(HLDB)/sizeof(HLDB[0]))
;
;/* ====================== Syntax highlight color scheme  ==================== */
;
;int is_separator(int c) {
;    return c == '\0' || isspace(c) || strchr(",.()+-/*=~%[];",c) != NULL;
;}
;
;/* Return true if the specified row last char is part of a multi line comment
; * that starts at this row or at one before, and does not end at the end
; * of the row but spawns to the next row. */
;int editorRowHasOpenComment(erow *row) {
;    if (row->hl && row->rsize && row->hl[row->rsize-1] == HL_MLCOMMENT &&
;        (row->rsize < 2 || (row->render[row->rsize-2] != '*' ||
;                            row->render[row->rsize-1] != '/'))) return 1;
;    return 0;
;}
;
;
;/* Select the syntax highlight scheme depending on the filename,
; * setting it in the global state E.syntax. */
;void editorSelectSyntaxHighlight(char *filename) {
;    struct editorSyntax *s;
;    unsigned int i;
;    char *p;
;    int patlen;
;    unsigned int j;
;
;    for (j = 0; j < HLDB_ENTRIES; j++) {
;        s = HLDB+j;
;        i = 0;
;        while(s->filematch[i]) {
;            patlen = strlen(s->filematch[i]);
;            if ((p = strstr(filename,s->filematch[i])) != NULL) {
;                if (s->filematch[i][0] != '.' || p[patlen] == '\0') {
;                    E.syntax = s;
;                    return;
;                }
;            }
;            i++;
;        }
;    }
;}
;
;/* Set every byte of row->hl (that corresponds to every character in the line)
; * to the right syntax highlight type (HL_* defines). */
;void editorUpdateSyntax(erow *row) {
;    int i, prev_sep, in_string, in_comment, j, klen, kw2;
;    char *p;
;    char **keywords;
;    char *scs;
;    char *mcs;
;    char *mce;  
;    int oc;
;    
;    row->hl = realloc(row->hl,row->rsize);
;    memset(row->hl,HL_NORMAL,row->rsize);
;
;    if (E.syntax == NULL) return; /* No syntax, everything is HL_NORMAL. */
;
;    
;    keywords = E.syntax->keywords;
;    scs = E.syntax->singleline_comment_start;
;    mcs = E.syntax->multiline_comment_start;
;    mce = E.syntax->multiline_comment_end;
;
;    /* Point to the first non-space char. */
;    p = row->render;
;    i = 0; /* Current char offset */
;    while(*p && isspace(*p)) {
;        p++;
;        i++;
;    }
;    prev_sep = 1; /* Tell the parser if 'i' points to start of word. */
;    in_string = 0; /* Are we inside "" or '' ? */
;    in_comment = 0; /* Are we inside multi-line comment? */
;
;    /* If the previous line has an open comment, this line starts
;     * with an open comment state. */
;    if (row->idx > 0 && editorRowHasOpenComment(&E.row[row->idx-1]))
;        in_comment = 1;
;
;    while(*p) {
;        /* Handle // comments. */
;        if (prev_sep && *p == scs[0] && *(p+1) == scs[1]) {
;            /* From here to end is a comment */
;            memset(row->hl+i,HL_COMMENT,row->size-i);
;            return;
;        }
;
;        /* Handle multi line comments. */
;        if (in_comment) {
;            row->hl[i] = HL_MLCOMMENT;
;            if (*p == mce[0] && *(p+1) == mce[1]) {
;                row->hl[i+1] = HL_MLCOMMENT;
;                p += 2; i += 2;
;                in_comment = 0;
;                prev_sep = 1;
;                continue;
;            } else {
;                prev_sep = 0;
;                p++; i++;
;                continue;
;            }
;        } else if (*p == mcs[0] && *(p+1) == mcs[1]) {
;            row->hl[i] = HL_MLCOMMENT;
;            row->hl[i+1] = HL_MLCOMMENT;
;            p += 2; i += 2;
;            in_comment = 1;
;            prev_sep = 0;
;            continue;
;        }
;
;        /* Handle "" and '' */
;        if (in_string) {
;            row->hl[i] = HL_STRING;
;            if (*p == '\\') {
;                row->hl[i+1] = HL_STRING;
;                p += 2; i += 2;
;                prev_sep = 0;
;                continue;
;            }
;            if (*p == in_string) in_string = 0;
;            p++; i++;
;            continue;
;        } else {
;            if (*p == '"' || *p == '\'') {
;                in_string = *p;
;                row->hl[i] = HL_STRING;
;                p++; i++;
;                prev_sep = 0;
;                continue;
;            }
;        }
;
;        /* Handle non printable chars. */
;        if (!isprint(*p)) {
;            row->hl[i] = HL_NONPRINT;
;            p++; i++;
;            prev_sep = 0;
;            continue;
;        }
;
;        /* Handle numbers */
;        if ((isdigit(*p) && (prev_sep || row->hl[i-1] == HL_NUMBER)) ||
;            (*p == '.' && i >0 && row->hl[i-1] == HL_NUMBER)) {
;            row->hl[i] = HL_NUMBER;
;            p++; i++;
;            prev_sep = 0;
;            continue;
;        }
;
;        /* Handle keywords and lib calls */
;        if (prev_sep) {
;            for (j = 0; keywords[j]; j++) {
;                klen = strlen(keywords[j]);
;                kw2 = keywords[j][klen-1] == '|';
;                if (kw2) klen--;
;
;                if (!memcmp(p,keywords[j],klen) &&
;                    is_separator(*(p+klen)))
;                {
;                    /* Keyword */
;                    memset(row->hl+i,kw2 ? HL_KEYWORD2 : HL_KEYWORD1,klen);
;                    p += klen;
;                    i += klen;
;                    break;
;                }
;            }
;            if (keywords[j] != NULL) {
;                prev_sep = 0;
;                continue; /* We had a keyword match */
;            }
;        }
;
;        /* Not special chars */
;        prev_sep = is_separator(*p);
;        p++; i++;
;    }
;
;    /* Propagate syntax change to the next row if the open commen
;     * state changed. This may recursively affect all the following rows
;     * in the file. */
;    oc = editorRowHasOpenComment(row);
;    if (row->hl_oc != oc && row->idx+1 < E.numrows)
;        editorUpdateSyntax(&E.row[row->idx+1]);
;    row->hl_oc = oc;
;}
;
;/* Maps syntax highlight token types to terminal colors. */
;int editorSyntaxToColor(int hl) {
;    switch(hl) {
;    case HL_COMMENT:
;    case HL_MLCOMMENT: return 36;     /* cyan */
;    case HL_KEYWORD1: return 33;    /* yellow */
;    case HL_KEYWORD2: return 32;    /* green */
;    case HL_STRING: return 35;      /* magenta */
;    case HL_NUMBER: return 31;      /* red */
;    case HL_MATCH: return 34;      /* blu */
;    default: return 37;             /* white */
;    }
;}
;#endif
;
;/* ======================= Low level terminal handling ====================== */
;#if 0
;static struct termios orig_termios; /* In order to restore at exit.*/
;
;void disableRawMode(int fd) {
;    /* Don't even check the return value as it's too late. */
;    if (E.rawmode) {
;        tcsetattr(fd,TCSAFLUSH,&orig_termios);
;        E.rawmode = 0;
;    }
;}
;
;/* Called at exit to avoid remaining in raw mode. */
;void editorAtExit(void) {
;    disableRawMode(STDIN_FILENO);
;}
;#endif
;
;/* Raw mode: 1960 magic shit. */
;int enableRawMode(int fd) {
	code
	xdef	~~enableRawMode
	func
~~enableRawMode:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L18
	tcs
	phd
	tcd
fd_0	set	4
;#if 0
;    struct termios raw;
;
;    if (E.rawmode) return 0; /* Already enabled. */
;    if (!isatty(STDIN_FILENO)) goto fatal;
;    atexit(editorAtExit);
;    if (tcgetattr(fd,&orig_termios) == -1) goto fatal;
;
;    raw = orig_termios;  /* modify the original mode */
;    /* input modes: no break, no CR to NL, no parity check, no strip char,
;     * no start/stop output control. */
;    raw.c_iflag &= ~(BRKINT | ICRNL | INPCK | ISTRIP | IXON);
;    /* output modes - disable post processing */
;    raw.c_oflag &= ~(OPOST);
;    /* control modes - set 8 bit chars */
;    raw.c_cflag |= (CS8);
;    /* local modes - choing off, canonical off, no extended functions,
;     * no signal chars (^Z,^C) */
;    raw.c_lflag &= ~(ECHO | ICANON | IEXTEN | ISIG);
;    /* control chars - set return condition: min number of bytes and timer. */
;    raw.c_cc[VMIN] = 0; /* Return each byte, or zero for timeout. */
;    raw.c_cc[VTIME] = 1; /* 100 ms timeout (unit is tens of second). */
;
;    /* put terminal in raw mode after flushing */
;    if (tcsetattr(fd,TCSAFLUSH,&raw) < 0) goto fatal;
;#endif
;    E.rawmode = 1;
	lda	#$1
	sta	|~~E+14
;    return 0;
	dea
	tay
	lda	<L18+2
	sta	<L18+2+2
	lda	<L18+1
	sta	<L18+1+2
	pld
	tsc
	clc
	adc	#L18+2
	tcs
	tya
	rtl
;
;fatal:
;    errno = ENOTTY;
;    return -1;
;}
L18	equ	4
L19	equ	5
	ends
	efunc
;
;/* Read a key from the terminal put in raw mode, trying to handle
; * escape sequences. */
;int editorReadKey(int fd) {
	code
	xdef	~~editorReadKey
	func
~~editorReadKey:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L21
	tcs
	phd
	tcd
fd_0	set	4
;    int nread;
;    char c, seq[3];
;	char *superf = (char *)0x000244;
;	
;    while ((nread = read(fd,&c,1)) == 0);
nread_1	set	0
c_1	set	2
seq_1	set	3
superf_1	set	6
	lda	#$244
	sta	<L22+superf_1
	lda	#$0
	sta	<L22+superf_1+2
L10004:
	pea	#^$1
	pea	#<$1
	pea	#0
	clc
	tdc
	adc	#<L22+c_1
	pha
	pei	<L21+fd_0
	jsl	~~read
	sta	<L22+nread_1
	lda	<L22+nread_1
	beq	L10004
;	
;    //if (nread == -1) exit(1);
;
;	switch(c) {
	lda	<L22+c_1
	and	#$ff
	xref	~~~swt
	jsl	~~~swt
	dw	9
	dw	1
	dw	L10019-1
	dw	2
	dw	L10020-1
	dw	8
	dw	L10016-1
	dw	28
	dw	L10008-1
	dw	29
	dw	L10010-1
	dw	30
	dw	L10012-1
	dw	31
	dw	L10014-1
	dw	149
	dw	L20001-1
	dw	150
	dw	L20000-1
	dw	L10021-1
;		case CCUP:
L10008:
;			if (*superf) return HOME_LINE;
	lda	[<L22+superf_1]
	and	#$ff
	beq	L10009
	lda	#$3f1
L25:
	tay
	lda	<L21+2
	sta	<L21+2+2
	lda	<L21+1
	sta	<L21+1+2
	pld
	tsc
	clc
	adc	#L21+2
	tcs
	tya
	rtl
;			return ARROW_UP;
L10009:
	lda	#$3ea
	bra	L25
;		case CCDN:
L10010:
;			if (*superf) return END_LINE;
	lda	[<L22+superf_1]
	and	#$ff
	beq	L10011
	lda	#$3f2
	bra	L25
;			return ARROW_DOWN;
L10011:
	lda	#$3eb
	bra	L25
;		case CCLF:
L10012:
;			if (*superf) return PAGE_DOWN;
	lda	[<L22+superf_1]
	and	#$ff
	beq	L10013
L20000:
	lda	#$3f0
	bra	L25
;			return ARROW_LEFT;
L10013:
	lda	#$3e8
	bra	L25
;		case CCRT:
L10014:
;			if (*superf) return PAGE_UP;
	lda	[<L22+superf_1]
	and	#$ff
	beq	L10015
L20001:
	lda	#$3ef
	bra	L25
;			return ARROW_RIGHT;
L10015:
	lda	#$3e9
	bra	L25
;		case BACK:
L10016:
;			return DEL_KEY;
	lda	#$3ec
	bra	L25
;		case CPGUP:
;			return PAGE_UP;
;		case CPGDN:
;			return PAGE_DOWN;
;		case CLS:
L10019:
;			return HOME_KEY;
	lda	#$3ed
	bra	L25
;		case CTRL_B:
L10020:
;			return END_KEY;
	lda	#$3ee
	bra	L25
;		default:
L10021:
;			return c;
	lda	<L22+c_1
	and	#$ff
	bra	L25
;	}
;		
;		
;#if 0
;    while(1) {
;        switch(c) {
;			
;        case ESC:    /* escape sequence */
;            /* If this is just an ESC, we'll timeout here. */
;            if (read(fd,seq,1) == 0) return ESC;
;            if (read(fd,seq+1,1) == 0) return ESC;
;
;            /* ESC [ sequences. */
;            if (seq[0] == '[') {
;                if (seq[1] >= '0' && seq[1] <= '9') {
;                    /* Extended escape, read additional byte. */
;                    if (read(fd,seq+2,1) == 0) return ESC;
;                    if (seq[2] == '~') {
;                        switch(seq[1]) {
;                        case '3': return DEL_KEY;
;                        case '5': return PAGE_UP;
;                        case '6': return PAGE_DOWN;
;                        }
;                    }
;                } else {
;                    switch(seq[1]) {
;                    case 'A': return ARROW_UP;
;                    case 'B': return ARROW_DOWN;
;                    case 'C': return ARROW_RIGHT;
;                    case 'D': return ARROW_LEFT;
;                    case 'H': return HOME_KEY;
;                    case 'F': return END_KEY;
;                    }
;                }
;            }
;
;            /* ESC O sequences. */
;            else if (seq[0] == 'O') {
;                switch(seq[1]) {
;                case 'H': return HOME_KEY;
;                case 'F': return END_KEY;
;                }
;            }
;            break;
;        default:
;            return c;
;        }
;    }
;#endif
;
;}
L21	equ	10
L22	equ	1
	ends
	efunc
;
;
;void setCursor(unsigned int row, unsigned int col) {
	code
	xdef	~~setCursor
	func
~~setCursor:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L29
	tcs
	phd
	tcd
row_0	set	4
col_0	set	6
;		
;	CURSOR = row * E.screencols + col /*+ 0xB000*/;
	lda	<L29+row_0
	ldx	|~~E+10
	xref	~~~mul
	jsl	~~~mul
	clc
	adc	<L29+col_0
	sta	>16776714
;}
	lda	<L29+2
	sta	<L29+2+4
	lda	<L29+1
	sta	<L29+1+4
	pld
	tsc
	clc
	adc	#L29+4
	tcs
	rtl
L29	equ	4
L30	equ	5
	ends
	efunc
;
;void writeScreen(char *p, size_t len) {
	code
	xdef	~~writeScreen
	func
~~writeScreen:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L32
	tcs
	phd
	tcd
p_0	set	4
len_0	set	8
;	
;	int rowleft;
;	char *dst = (char *)SCREENADR;
;	
;	for (rowleft = E.screencols; len > 0; len--) {
rowleft_1	set	0
dst_1	set	2
	lda	#$f000
	sta	<L33+dst_1
	lda	#$7f
	sta	<L33+dst_1+2
	lda	|~~E+10
	sta	<L33+rowleft_1
	bra	L10025
L20003:
;		if (*p == '\n') {
	sep	#$20
	longa	off
	lda	[<L32+p_0]
	cmp	#<$a
	rep	#$20
	longa	on
	beq	L10030
;			*dst++ = *p;
	sep	#$20
	longa	off
	lda	[<L32+p_0]
	sta	[<L33+dst_1]
	rep	#$20
	longa	on
	inc	<L33+dst_1
	bne	L38
	inc	<L33+dst_1+2
L38:
;			rowleft--;
	dec	<L33+rowleft_1
;		}
	bra	L10031
;			for  (; rowleft > 0; rowleft--) {
L10029:
;				*dst++ = ' ';
	sep	#$20
	longa	off
	lda	#$20
	sta	[<L33+dst_1]
	rep	#$20
	longa	on
	inc	<L33+dst_1
	bne	L10027
	inc	<L33+dst_1+2
;			}
L10027:
	dec	<L33+rowleft_1
L10030:
	sec
	lda	#$0
	sbc	<L33+rowleft_1
	bvs	L36
	eor	#$8000
L36:
	bpl	L10029
;			rowleft = E.screencols;
	lda	|~~E+10
	sta	<L33+rowleft_1
;		} else {
L10031:
;		p++;
	inc	<L32+p_0
	bne	L10022
	inc	<L32+p_0+2
;	}
L10022:
	lda	<L32+len_0
	bne	L40
	dec	<L32+len_0+2
L40:
	dec	<L32+len_0
L10025:
	lda	#$0
	cmp	<L32+len_0
	sbc	<L32+len_0+2
	bcc	L20003
;}
	lda	<L32+2
	sta	<L32+2+8
	lda	<L32+1
	sta	<L32+1+8
	pld
	tsc
	clc
	adc	#L32+8
	tcs
	rtl
L32	equ	6
L33	equ	1
	ends
	efunc
;
;#if 0
;
;/* Use the ESC [6n escape sequence to query the horizontal cursor position
; * and return it. On error -1 is returned, on success the position of the
; * cursor is stored at *rows and *cols and 0 is returned. */
;int getCursorPosition(int ifd, int ofd, int *rows, int *cols) {
;	
;	char *row = (char *)0x0037;
;	int *col = (int *)0x0038;
;	
;	*rows = *row;
;	*cols = *col;
;	
;    static char buf[32];
;    unsigned int i = 0;
;
;    /* Report cursor location */
;    if (write(ofd, "\x1b[6n", 4) != 4) return -1;
;
;    /* Read the response: ESC [ rows ; cols R */
;    while (i < sizeof(buf)-1) {
;        if (read(ifd,buf+i,1) != 1) break;
;        if (buf[i] == 'R') break;
;        i++;
;    }
;    buf[i] = '\0';
;
;    /* Parse it. */
;    if (buf[0] != ESC || buf[1] != '[') return -1;
;    if (sscanf(buf+2,"%d;%d",rows,cols) != 2) return -1;
;
;    return 0;
;}
;#endif
;
;
;/* Try to get the number of columns in the current terminal. If the ioctl()
; * call fails the function will try to query the terminal itself.
; * Returns 0 on success, -1 on error. */
;int getWindowSize(int ifd, int ofd, unsigned int *rows, unsigned int *cols) {
	code
	xdef	~~getWindowSize
	func
~~getWindowSize:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L43
	tcs
	phd
	tcd
ifd_0	set	4
ofd_0	set	6
rows_0	set	8
cols_0	set	12
;	*rows = 25;
	lda	#$19
	sta	[<L43+rows_0]
;	*cols = 80;
	lda	#$50
	sta	[<L43+cols_0]
;	return 0;
	lda	#$0
	tay
	lda	<L43+2
	sta	<L43+2+12
	lda	<L43+1
	sta	<L43+1+12
	pld
	tsc
	clc
	adc	#L43+12
	tcs
	tya
	rtl
;	
;#if 0
;    struct winsize ws;
;    static char seq[32];
;
;    if (ioctl(1, TIOCGWINSZ, &ws) == -1 || ws.ws_col == 0) {
;        /* ioctl() failed. Try to query the terminal itself. */
;        int orig_row, orig_col, retval;
;
;        /* Get the initial position so we can restore it later. */
;        retval = getCursorPosition(ifd,ofd,&orig_row,&orig_col);
;        if (retval == -1) goto failed;
;
;        /* Go to right/bottom margin and get position. */
;        if (write(ofd,"\x1b[999C\x1b[999B",12) != 12) goto failed;
;        retval = getCursorPosition(ifd,ofd,rows,cols);
;        if (retval == -1) goto failed;
;
;        /* Restore position. */
;        snprintf(seq,32,"\x1b[%d;%dH",orig_row,orig_col);
;        if (write(ofd,seq,strlen(seq)) == -1) {
;            /* Can't recover... */
;        }
;        return 0;
;    } else {
;        *cols = ws.ws_col;
;        *rows = ws.ws_row;
;        return 0;
;    }
;
;failed:
;    return -1;
;#endif
;}
L43	equ	0
L44	equ	1
	ends
	efunc
;
;
;/* ======================= Editor rows implementation ======================= */
;
;/* Update the rendered version and the syntax highlight of a row. */
;void editorUpdateRow(erow *row) {
	code
	xdef	~~editorUpdateRow
	func
~~editorUpdateRow:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L46
	tcs
	phd
	tcd
row_0	set	4
;    int tabs, j, idx;
;//	int nonprint;
;	
;	return;
tabs_1	set	0
j_1	set	2
idx_1	set	4
L48:
	lda	<L46+2
	sta	<L46+2+4
	lda	<L46+1
	sta	<L46+1+4
	pld
	tsc
	clc
	adc	#L46+4
	tcs
	rtl
;	
;	tabs = 0;
;	//nonprint = 0;
;	
;   /* Create a version of the row we can directly print on the screen,
;     * respecting tabs, substituting non printable characters with '?'. */
;    free(row->render);
;    for (j = 0; j < row->size; j++)
L10034:
;        if (row->chars[j] == TAB) tabs++;
	ldy	#$6
	lda	[<L46+row_0],Y
	sta	<R0
	iny
	iny
	lda	[<L46+row_0],Y
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	<L47+j_1
	lda	[<R0],Y
	cmp	#<$9
	rep	#$20
	longa	on
	bne	L10032
	inc	<L47+tabs_1
;
;	if (tabs == 0) {
L10032:
	inc	<L47+j_1
	sec
	lda	<L47+j_1
	ldy	#$2
	sbc	[<L46+row_0],Y
	bvs	L50
	eor	#$8000
L50:
	bpl	L10034
	lda	<L47+tabs_1
	bne	L10037
;		row->rsize = row->size;
	ldy	#$2
	lda	[<L46+row_0],Y
	iny
	iny
	sta	[<L46+row_0],Y
;		row->render = row->chars;
	iny
	iny
	lda	[<L46+row_0],Y
	ldy	#$a
	sta	[<L46+row_0],Y
	dey
	dey
	lda	[<L46+row_0],Y
	ldy	#$c
	sta	[<L46+row_0],Y
;		return;
	bra	L48
;	}
;
;    //row->render = malloc(row->size + tabs*8 + nonprint*9 + 1);
;    row->render = malloc(row->size + (tabs << 2) + 1);
L10037:
	lda	<L47+tabs_1
	asl	A
	asl	A
	clc
	ldy	#$2
	adc	[<L46+row_0],Y
	ina
	sta	<R0
	dey
	dey
	lda	<R0
	bpl	L53
	dey
L53:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~malloc
	stx	<R1+2
	ldy	#$a
	sta	[<L46+row_0],Y
	lda	<R1+2
	iny
	iny
	sta	[<L46+row_0],Y
;	//fprintf(stderr, "editorUpdateRow render: %08lX\n", row->render);
;	
;    idx = 0;
	stz	<L47+idx_1
;    for (j = 0; j < row->size; j++) {
	stz	<L47+j_1
	brl	L10041
L10040:
;        if (row->chars[j] == TAB) {
	ldy	#$6
	lda	[<L46+row_0],Y
	sta	<R0
	iny
	iny
	lda	[<L46+row_0],Y
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	<L47+j_1
	lda	[<R0],Y
	cmp	#<$9
	rep	#$20
	longa	on
	bne	L10042
;            row->render[idx++] = ' ';
	ldy	#$a
	lda	[<L46+row_0],Y
	sta	<R0
	iny
	iny
	lda	[<L46+row_0],Y
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$20
	ldy	<L47+idx_1
	sta	[<R0],Y
	rep	#$20
	longa	on
L20004:
	inc	<L47+idx_1
;            while((idx+1) % 4 != 0) row->render[idx++] = ' ';
	lda	<L47+idx_1
	ina
	and	#$03
	tax
	beq	L10038
;        } else {
	ldy	#$a
	lda	[<L46+row_0],Y
	sta	<R0
	iny
	iny
	lda	[<L46+row_0],Y
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$20
	ldy	<L47+idx_1
	sta	[<R0],Y
	rep	#$20
	longa	on
	bra	L20004
L10042:
;            row->render[idx++] = row->chars[j];
	ldy	#$a
	lda	[<L46+row_0],Y
	sta	<R0
	iny
	iny
	lda	[<L46+row_0],Y
	sta	<R0+2
	ldy	#$6
	lda	[<L46+row_0],Y
	sta	<R1
	iny
	iny
	lda	[<L46+row_0],Y
	sta	<R1+2
	sep	#$20
	longa	off
	ldy	<L47+j_1
	lda	[<R1],Y
	ldy	<L47+idx_1
	sta	[<R0],Y
	rep	#$20
	longa	on
	inc	<L47+idx_1
;        }
;    }
L10038:
	inc	<L47+j_1
L10041:
	sec
	lda	<L47+j_1
	ldy	#$2
	sbc	[<L46+row_0],Y
	bvs	L56
	eor	#$8000
L56:
	bmi	*+5
	brl	L10040
;    row->rsize = idx;
	lda	<L47+idx_1
	ldy	#$4
	sta	[<L46+row_0],Y
;    row->render[idx] = '\0';
	ldy	#$a
	lda	[<L46+row_0],Y
	sta	<R0
	iny
	iny
	lda	[<L46+row_0],Y
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$0
	ldy	<L47+idx_1
	sta	[<R0],Y
	rep	#$20
	longa	on
;
;    /* Update the syntax highlighting attributes of the row. */
;    //editorUpdateSyntax(row);
;}
	brl	L48
L46	equ	14
L47	equ	9
	ends
	efunc
;
;/* Insert a row at the specified position, shifting the other rows on the bottom
; * if required. */
;void editorInsertRow(unsigned int at, char *s, unsigned int len) {
	code
	xdef	~~editorInsertRow
	func
~~editorInsertRow:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L58
	tcs
	phd
	tcd
at_0	set	4
s_0	set	6
len_0	set	10
;    unsigned int j;
;	erow *row;
;	size_t size;
;		
;    if (at > E.numrows) return;
j_1	set	0
row_1	set	2
size_1	set	6
	lda	|~~E+12
	cmp	<L58+at_0
	bcs	L10046
L61:
	lda	<L58+2
	sta	<L58+2+8
	lda	<L58+1
	sta	<L58+1+8
	pld
	tsc
	clc
	adc	#L58+8
	tcs
	rtl
;	
;	//fprintf(stderr, "realloc: %08lX %lu\n", E.row, sizeof(erow)*(E.numrows+1));	
;    //E.row = realloc(E.row,sizeof(erow)*(E.numrows+1));
;	
;	size = 0;
L10046:
	stz	<L59+size_1
	stz	<L59+size_1+2
;	
;	if (E.rowsavail == 0) {
	lda	|~~E+118
	bne	L10047
;		size = sizeof(erow)*(E.numrows+1000);
	lda	#$3e8
	clc
	adc	|~~E+12
	sta	<R0
	stz	<R0+2
	pea	#^$14
	pea	#<$14
	pei	<R0+2
	pei	<R0
	xref	~~~lmul
	jsl	~~~lmul
	sta	<L59+size_1
	stx	<L59+size_1+2
;		//debugf("s_erow:%d, E.numrows:%d size:%d \n", (size_t)sizeof(erow), (size_t)E.numrows, size);
;		E.row = realloc(E.row, sizeof(erow)*(E.numrows+1000));	
	lda	#$3e8
	clc
	adc	|~~E+12
	sta	<R0
	stz	<R0+2
	pea	#^$14
	pea	#<$14
	pei	<R0+2
	pei	<R0
	xref	~~~lmul
	jsl	~~~lmul
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	lda	|~~E+16+2
	pha
	lda	|~~E+16
	pha
	jsl	~~realloc
	sta	|~~E+16
	stx	|~~E+16+2
;		E.rowsavail = 1000;
	lda	#$3e8
	sta	|~~E+118
;	}
;	//debugf("realloc: %08X, size:%08X \n", E.row, size);
;	
;    if (at != E.numrows) {
L10047:
	lda	<L58+at_0
	cmp	|~~E+12
	bne	*+5
	brl	L10048
;        memmove(E.row+at+1,E.row+at,sizeof(E.row[0])*(E.numrows-at));
	sec
	lda	|~~E+12
	sbc	<L58+at_0
	sta	<R0
	stz	<R0+2
	pea	#^$14
	pea	#<$14
	pei	<R0+2
	pei	<R0
	xref	~~~lmul
	jsl	~~~lmul
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	lda	<L58+at_0
	sta	<R1
	stz	<R1+2
	pea	#^$14
	pea	#<$14
	pei	<R1+2
	pei	<R1
	xref	~~~lmul
	jsl	~~~lmul
	sta	<R1
	stx	<R1+2
	lda	|~~E+16
	clc
	adc	<R1
	sta	<R2
	lda	|~~E+16+2
	adc	<R1+2
	pha
	pei	<R2
	lda	<L58+at_0
	sta	<R1
	stz	<R1+2
	pea	#^$14
	pea	#<$14
	pei	<R1+2
	pei	<R1
	xref	~~~lmul
	jsl	~~~lmul
	sta	<R1
	stx	<R1+2
	lda	#$14
	clc
	adc	<R1
	sta	<R3
	lda	#$0
	adc	<R1+2
	sta	<R3+2
	lda	|~~E+16
	clc
	adc	<R3
	sta	<R1
	lda	|~~E+16+2
	adc	<R3+2
	pha
	pei	<R1
	jsl	~~memmove
;        for (j = at+1; j <= E.numrows; j++) E.row[j].idx++;
	lda	<L58+at_0
	ina
	sta	<L59+j_1
	bra	L10052
L10051:
	lda	<L59+j_1
	sta	<R0
	stz	<R0+2
	pea	#^$14
	pea	#<$14
	pei	<R0+2
	pei	<R0
	xref	~~~lmul
	jsl	~~~lmul
	sta	<R0
	stx	<R0+2
	lda	|~~E+16
	clc
	adc	<R0
	sta	<R1
	lda	|~~E+16+2
	adc	<R0+2
	sta	<R1+2
	lda	[<R1]
	ina
	sta	[<R1]
	inc	<L59+j_1
L10052:
	lda	|~~E+12
	cmp	<L59+j_1
	bcs	L10051
;		//printf("memmove \n");
;    }
;    
;	row = &E.row[at];
L10048:
	lda	<L58+at_0
	sta	<R0
	stz	<R0+2
	pea	#^$14
	pea	#<$14
	pei	<R0+2
	pei	<R0
	xref	~~~lmul
	jsl	~~~lmul
	sta	<R0
	stx	<R0+2
	lda	|~~E+16
	clc
	adc	<R0
	sta	<L59+row_1
	lda	|~~E+16+2
	adc	<R0+2
	sta	<L59+row_1+2
;
;    row->size = len;
	lda	<L58+len_0
	ldy	#$2
	sta	[<L59+row_1],Y
;    row->chars = malloc(len+1);
	lda	<L58+len_0
	ina
	sta	<R0
	stz	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~malloc
	stx	<R1+2
	ldy	#$6
	sta	[<L59+row_1],Y
	lda	<R1+2
	iny
	iny
	sta	[<L59+row_1],Y
;	
;	
;    memcpy(row->chars,s,len+1);
	lda	<L58+len_0
	ina
	sta	<R0
	stz	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L58+s_0+2
	pei	<L58+s_0
	lda	[<L59+row_1],Y
	pha
	dey
	dey
	lda	[<L59+row_1],Y
	pha
	jsl	~~memcpy
;    row->hl = NULL;
	lda	#$0
	ldy	#$e
	sta	[<L59+row_1],Y
	iny
	iny
	sta	[<L59+row_1],Y
;    row->hl_oc = 0;
	iny
	iny
	sta	[<L59+row_1],Y
;    row->render = NULL;
	ldy	#$a
	sta	[<L59+row_1],Y
	iny
	iny
	sta	[<L59+row_1],Y
;    row->rsize = 0;
	ldy	#$4
	sta	[<L59+row_1],Y
;    row->idx = at;
	lda	<L58+at_0
	sta	[<L59+row_1]
;
;    editorUpdateRow(row);
	pei	<L59+row_1+2
	pei	<L59+row_1
	jsl	~~editorUpdateRow
;	
;	//fprintf(stderr, "insert row: %d, %s, render; %s\n", at, E.row[at].chars, E.row[at].render);
;		
;    E.numrows++;
	inc	|~~E+12
;    E.dirty++;
	inc	|~~E+20
;	E.rowsavail--;
	dec	|~~E+118
;	
;	//debugf("E.numrows:%d \n", (size_t)E.numrows);
;}
	brl	L61
L58	equ	26
L59	equ	17
	ends
	efunc
;
;/* free row's heap allocated stuff. */
;void editorfreeRow(erow *row) {
	code
	xdef	~~editorfreeRow
	func
~~editorfreeRow:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L65
	tcs
	phd
	tcd
row_0	set	4
;    free(row->render);
	ldy	#$c
	lda	[<L65+row_0],Y
	pha
	dey
	dey
	lda	[<L65+row_0],Y
	pha
	jsl	~~free
;	if (row->render != row->chars)
;		free(row->chars);
	ldy	#$a
	lda	[<L65+row_0],Y
	ldy	#$6
	cmp	[<L65+row_0],Y
	bne	L67
	ldy	#$c
	lda	[<L65+row_0],Y
	ldy	#$8
	cmp	[<L65+row_0],Y
L67:
	beq	L10053
	ldy	#$8
	lda	[<L65+row_0],Y
	pha
	dey
	dey
	lda	[<L65+row_0],Y
	pha
	jsl	~~free
;    free(row->hl);
L10053:
	ldy	#$10
	lda	[<L65+row_0],Y
	pha
	dey
	dey
	lda	[<L65+row_0],Y
	pha
	jsl	~~free
;}
	lda	<L65+2
	sta	<L65+2+4
	lda	<L65+1
	sta	<L65+1+4
	pld
	tsc
	clc
	adc	#L65+4
	tcs
	rtl
L65	equ	0
L66	equ	1
	ends
	efunc
;
;/* Remove the row at the specified position, shifting the remainign on the
; * top. */
;void editorDelRow(int at) {
	code
	xdef	~~editorDelRow
	func
~~editorDelRow:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L70
	tcs
	phd
	tcd
at_0	set	4
;    erow *row;
;    int j;
;    
;    if (at >= E.numrows) return;
row_1	set	0
j_1	set	4
	lda	<L70+at_0
	cmp	|~~E+12
	bcc	L10054
L73:
	lda	<L70+2
	sta	<L70+2+2
	lda	<L70+1
	sta	<L70+1+2
	pld
	tsc
	clc
	adc	#L70+2
	tcs
	rtl
;    row = E.row+at;
L10054:
	ldy	#$0
	lda	<L70+at_0
	bpl	L74
	dey
L74:
	sta	<R0
	sty	<R0+2
	pea	#^$14
	pea	#<$14
	pei	<R0+2
	pei	<R0
	xref	~~~lmul
	jsl	~~~lmul
	sta	<R0
	stx	<R0+2
	lda	|~~E+16
	clc
	adc	<R0
	sta	<L71+row_1
	lda	|~~E+16+2
	adc	<R0+2
	sta	<L71+row_1+2
;    editorfreeRow(row);
	pha
	pei	<L71+row_1
	jsl	~~editorfreeRow
;    memmove(E.row+at,E.row+at+1,sizeof(E.row[0])*(E.numrows-at-1));
	sec
	lda	|~~E+12
	sbc	<L70+at_0
	clc
	adc	#$ffff
	sta	<R0
	stz	<R0+2
	pea	#^$14
	pea	#<$14
	pei	<R0+2
	pei	<R0
	xref	~~~lmul
	jsl	~~~lmul
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	ldy	#$0
	lda	<L70+at_0
	bpl	L75
	dey
L75:
	sta	<R1
	sty	<R1+2
	pea	#^$14
	pea	#<$14
	pei	<R1+2
	pei	<R1
	xref	~~~lmul
	jsl	~~~lmul
	sta	<R1
	stx	<R1+2
	lda	#$14
	clc
	adc	<R1
	sta	<R2
	lda	#$0
	adc	<R1+2
	sta	<R2+2
	lda	|~~E+16
	clc
	adc	<R2
	sta	<R1
	lda	|~~E+16+2
	adc	<R2+2
	pha
	pei	<R1
	ldy	#$0
	lda	<L70+at_0
	bpl	L76
	dey
L76:
	sta	<R3
	sty	<R3+2
	pea	#^$14
	pea	#<$14
	pei	<R3+2
	pei	<R3
	xref	~~~lmul
	jsl	~~~lmul
	sta	<R3
	stx	<R3+2
	lda	|~~E+16
	clc
	adc	<R3
	sta	<17
	lda	|~~E+16+2
	adc	<R3+2
	sta	<17+2
	pha
	pei	<17
	jsl	~~memmove
;    for (j = at; j < E.numrows-1; j++) E.row[j].idx++;
	lda	<L70+at_0
	sta	<L71+j_1
	bra	L10058
L10057:
	ldy	#$0
	lda	<L71+j_1
	bpl	L77
	dey
L77:
	sta	<R0
	sty	<R0+2
	pea	#^$14
	pea	#<$14
	pei	<R0+2
	pei	<R0
	xref	~~~lmul
	jsl	~~~lmul
	sta	<R0
	stx	<R0+2
	lda	|~~E+16
	clc
	adc	<R0
	sta	<R1
	lda	|~~E+16+2
	adc	<R0+2
	sta	<R1+2
	lda	[<R1]
	ina
	sta	[<R1]
	inc	<L71+j_1
L10058:
	lda	#$ffff
	clc
	adc	|~~E+12
	sta	<R0
	lda	<L71+j_1
	cmp	<R0
	bcc	L10057
;    E.numrows--;
	dec	|~~E+12
;    E.dirty++;
	inc	|~~E+20
;}
	brl	L73
L70	equ	26
L71	equ	21
	ends
	efunc
;
;void editorfreeAllRows() {
	code
	xdef	~~editorfreeAllRows
	func
~~editorfreeAllRows:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L79
	tcs
	phd
	tcd
;	int j;
;	erow *row;
;	
;	row = E.row;
j_1	set	0
row_1	set	2
	lda	|~~E+16
	sta	<L80+row_1
	lda	|~~E+16+2
	sta	<L80+row_1+2
;    for (j = 0; j < E.numrows; j++) {
	stz	<L80+j_1
	bra	L10062
L10061:
;		editorfreeRow(row);
	pei	<L80+row_1+2
	pei	<L80+row_1
	jsl	~~editorfreeRow
;		row++;
	lda	#$14
	clc
	adc	<L80+row_1
	sta	<L80+row_1
	bcc	L81
	inc	<L80+row_1+2
L81:
;		E.rowsavail++;
	inc	|~~E+118
;	}	
	inc	<L80+j_1
L10062:
	lda	<L80+j_1
	cmp	|~~E+12
	bcc	L10061
;}
	pld
	tsc
	clc
	adc	#L79
	tcs
	rtl
L79	equ	6
L80	equ	1
	ends
	efunc
;
;/* Turn the editor rows into a single heap-allocated string.
; * Returns the pointer to the heap-allocated string and populate the
; * integer pointed by 'buflen' with the size of the string, escluding
; * the final nulterm. */
;char *editorRowsToString(size_t *buflen) {
	code
	xdef	~~editorRowsToString
	func
~~editorRowsToString:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L84
	tcs
	phd
	tcd
buflen_0	set	4
;    char *buf, *p;
;    size_t totlen;
;    int j;
;
;	totlen = 0;
buf_1	set	0
p_1	set	4
totlen_1	set	8
j_1	set	12
	stz	<L85+totlen_1
	stz	<L85+totlen_1+2
;	
;    /* Compute count of bytes */
;    for (j = 0; j < E.numrows; j++)
	stz	<L85+j_1
	bra	L10066
L10065:
;        totlen += E.row[j].size+1; /* +1 is for "\n" at end of every row */
	ldy	#$0
	lda	<L85+j_1
	bpl	L86
	dey
L86:
	sta	<R0
	sty	<R0+2
	pea	#^$14
	pea	#<$14
	pei	<R0+2
	pei	<R0
	xref	~~~lmul
	jsl	~~~lmul
	sta	<R0
	stx	<R0+2
	lda	#$2
	clc
	adc	|~~E+16
	sta	<R1
	lda	#$0
	adc	|~~E+16+2
	sta	<R1+2
	lda	<R1
	clc
	adc	<R0
	sta	<R2
	lda	<R1+2
	adc	<R0+2
	sta	<R2+2
	lda	[<R2]
	ina
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L87
	dey
L87:
	sta	<R0
	sty	<R0+2
	lda	<R0
	clc
	adc	<L85+totlen_1
	sta	<L85+totlen_1
	lda	<R0+2
	adc	<L85+totlen_1+2
	sta	<L85+totlen_1+2
	inc	<L85+j_1
L10066:
	lda	<L85+j_1
	cmp	|~~E+12
	bcc	L10065
;    *buflen = totlen;
	lda	<L85+totlen_1
	sta	[<L84+buflen_0]
	lda	<L85+totlen_1+2
	ldy	#$2
	sta	[<L84+buflen_0],Y
;    totlen++; /* Also make space for nulterm */
	inc	<L85+totlen_1
	bne	L89
	inc	<L85+totlen_1+2
L89:
;
;    p = buf = malloc(totlen);
	pei	<L85+totlen_1+2
	pei	<L85+totlen_1
	jsl	~~malloc
	sta	<L85+buf_1
	stx	<L85+buf_1+2
	sta	<L85+p_1
	lda	<L85+buf_1+2
	sta	<L85+p_1+2
;    for (j = 0; j < E.numrows; j++) {
	stz	<L85+j_1
	brl	L10070
L10069:
;        memcpy(p,E.row[j].chars,E.row[j].size);
	ldy	#$0
	lda	<L85+j_1
	bpl	L90
	dey
L90:
	sta	<R0
	sty	<R0+2
	pea	#^$14
	pea	#<$14
	pei	<R0+2
	pei	<R0
	xref	~~~lmul
	jsl	~~~lmul
	sta	<R0
	stx	<R0+2
	lda	#$2
	clc
	adc	|~~E+16
	sta	<R1
	lda	#$0
	adc	|~~E+16+2
	sta	<R1+2
	lda	<R1
	clc
	adc	<R0
	sta	<R2
	lda	<R1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	[<R2]
	bpl	L91
	dey
L91:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	ldy	#$0
	lda	<L85+j_1
	bpl	L92
	dey
L92:
	sta	<R1
	sty	<R1+2
	pea	#^$14
	pea	#<$14
	pei	<R1+2
	pei	<R1
	xref	~~~lmul
	jsl	~~~lmul
	sta	<R1
	stx	<R1+2
	lda	#$6
	clc
	adc	|~~E+16
	sta	<R2
	lda	#$0
	adc	|~~E+16+2
	sta	<R2+2
	lda	<R2
	clc
	adc	<R1
	sta	<R3
	lda	<R2+2
	adc	<R1+2
	sta	<R3+2
	ldy	#$2
	lda	[<R3],Y
	pha
	lda	[<R3]
	pha
	pei	<L85+p_1+2
	pei	<L85+p_1
	jsl	~~memcpy
;        p += E.row[j].size;
	ldy	#$0
	lda	<L85+j_1
	bpl	L93
	dey
L93:
	sta	<R0
	sty	<R0+2
	pea	#^$14
	pea	#<$14
	pei	<R0+2
	pei	<R0
	xref	~~~lmul
	jsl	~~~lmul
	sta	<R0
	stx	<R0+2
	lda	#$2
	clc
	adc	|~~E+16
	sta	<R1
	lda	#$0
	adc	|~~E+16+2
	sta	<R1+2
	lda	<R1
	clc
	adc	<R0
	sta	<R2
	lda	<R1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$0
	lda	[<R2]
	bpl	L94
	dey
L94:
	sta	<R0
	sty	<R0+2
	lda	<L85+p_1
	clc
	adc	<R0
	sta	<L85+p_1
	lda	<L85+p_1+2
	adc	<R0+2
	sta	<L85+p_1+2
;        *p = '\n';
	sep	#$20
	longa	off
	lda	#$a
	sta	[<L85+p_1]
	rep	#$20
	longa	on
;        p++;
	inc	<L85+p_1
	bne	L10067
	inc	<L85+p_1+2
;    }
L10067:
	inc	<L85+j_1
L10070:
	lda	<L85+j_1
	cmp	|~~E+12
	bcs	*+5
	brl	L10069
;    *p = '\0';
	sep	#$20
	longa	off
	lda	#$0
	sta	[<L85+p_1]
	rep	#$20
	longa	on
;    return buf;
	ldx	<L85+buf_1+2
	lda	<L85+buf_1
	tay
	lda	<L84+2
	sta	<L84+2+4
	lda	<L84+1
	sta	<L84+1+4
	pld
	tsc
	clc
	adc	#L84+4
	tcs
	tya
	rtl
;}
L84	equ	30
L85	equ	17
	ends
	efunc
;
;/* Insert a character at the specified position in a row, moving the remaining
; * chars on the right if needed. */
;void editorRowInsertChar(erow *row, int at, int c) {
	code
	xdef	~~editorRowInsertChar
	func
~~editorRowInsertChar:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L98
	tcs
	phd
	tcd
row_0	set	4
at_0	set	8
c_0	set	10
;    int padlen;
;    
;	
;	//fprintf(stderr, "RowInsertChar %08lX, at: %u, size: %u, c: %c \n", row, at, row->size, c);
;	
;    if (at > row->size) {
padlen_1	set	0
	sec
	ldy	#$2
	lda	[<L98+row_0],Y
	sbc	<L98+at_0
	bvs	L100
	eor	#$8000
L100:
	bpl	*+5
	brl	L10071
;        /* Pad the string with spaces if the insert location is outside the
;         * current length by more than a single character. */
;        padlen = at-row->size;
	sec
	lda	<L98+at_0
	ldy	#$2
	sbc	[<L98+row_0],Y
	sta	<L99+padlen_1
	clc
	adc	[<L98+row_0],Y
	clc
	adc	#$2
	sta	<R1
	dey
	dey
	lda	<R1
	bpl	L102
	dey
L102:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	ldy	#$8
	lda	[<L98+row_0],Y
	pha
	dey
	dey
	lda	[<L98+row_0],Y
	pha
	jsl	~~realloc
	stx	<R1+2
	ldy	#$6
	sta	[<L98+row_0],Y
	lda	<R1+2
	iny
	iny
	sta	[<L98+row_0],Y
;        memset(row->chars+row->size,' ',padlen);
	ldy	#$0
	lda	<L99+padlen_1
	bpl	L103
	dey
L103:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pea	#<$20
	ldy	#$0
	phy
	iny
	iny
	lda	[<L98+row_0],Y
	ply
	rol	A
	ror	A
	bpl	L104
	dey
L104:
	sta	<R1
	sty	<R1+2
	clc
	ldy	#$6
	lda	[<L98+row_0],Y
	adc	<R1
	sta	<R2
	iny
	iny
	lda	[<L98+row_0],Y
	adc	<R1+2
	pha
	pei	<R2
	jsl	~~memset
;        row->chars[row->size+padlen+1] = '\0';
	clc
	ldy	#$2
	lda	[<L98+row_0],Y
	adc	<L99+padlen_1
	ina
	sta	<R1
	ldy	#$6
	lda	[<L98+row_0],Y
	sta	<R0
	iny
	iny
	lda	[<L98+row_0],Y
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$0
	ldy	<R1
	sta	[<R0],Y
	rep	#$20
	longa	on
;        row->size += padlen+1;
	lda	#$2
	clc
	adc	<L98+row_0
	sta	<R0
	lda	#$0
	adc	<L98+row_0+2
	sta	<R0+2
	lda	[<R0]
	clc
	adc	<L99+padlen_1
	ina
	sta	[<R0]
;    } else {
	brl	L10072
L10071:
;        /* If we are in the middle of the string just make space for 1 new
;         * char plus the (already existing) null term. */
;		//fprintf(stderr, "RowInsertChar %08lX %08lX \n", row->chars, (size_t)row->size+2);
;		
;        row->chars = realloc(row->chars,row->size+2);
	clc
	lda	#$2
	tay
	adc	[<L98+row_0],Y
	sta	<R0
	dey
	dey
	lda	<R0
	bpl	L105
	dey
L105:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	ldy	#$8
	lda	[<L98+row_0],Y
	pha
	dey
	dey
	lda	[<L98+row_0],Y
	pha
	jsl	~~realloc
	stx	<R1+2
	ldy	#$6
	sta	[<L98+row_0],Y
	lda	<R1+2
	iny
	iny
	sta	[<L98+row_0],Y
;		
;		//fprintf(stderr, "RowInsertChar %08lX \n", row->chars);
;
;        memmove(row->chars+at+1,row->chars+at,row->size-at+1);
	sec
	ldy	#$2
	lda	[<L98+row_0],Y
	sbc	<L98+at_0
	ina
	sta	<R1
	dey
	dey
	lda	<R1
	bpl	L106
	dey
L106:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	ldy	#$0
	lda	<L98+at_0
	bpl	L107
	dey
L107:
	sta	<R1
	sty	<R1+2
	clc
	ldy	#$6
	lda	[<L98+row_0],Y
	adc	<R1
	sta	<R2
	iny
	iny
	lda	[<L98+row_0],Y
	adc	<R1+2
	pha
	pei	<R2
	ldy	#$0
	lda	<L98+at_0
	bpl	L108
	dey
L108:
	sta	<R1
	sty	<R1+2
	lda	#$1
	clc
	adc	<R1
	sta	<R3
	lda	#$0
	adc	<R1+2
	sta	<R3+2
	clc
	ldy	#$6
	lda	[<L98+row_0],Y
	adc	<R3
	sta	<R1
	iny
	iny
	lda	[<L98+row_0],Y
	adc	<R3+2
	pha
	pei	<R1
	jsl	~~memmove
;        row->size++;
	ldy	#$2
	lda	[<L98+row_0],Y
	ina
	sta	[<L98+row_0],Y
;    }
L10072:
;    row->chars[at] = c;
	ldy	#$6
	lda	[<L98+row_0],Y
	sta	<R0
	iny
	iny
	lda	[<L98+row_0],Y
	sta	<R0+2
	sep	#$20
	longa	off
	lda	<L98+c_0
	ldy	<L98+at_0
	sta	[<R0],Y
	rep	#$20
	longa	on
;    editorUpdateRow(row);
	pei	<L98+row_0+2
	pei	<L98+row_0
	jsl	~~editorUpdateRow
;    E.dirty++;
	inc	|~~E+20
;}
	lda	<L98+2
	sta	<L98+2+8
	lda	<L98+1
	sta	<L98+1+8
	pld
	tsc
	clc
	adc	#L98+8
	tcs
	rtl
L98	equ	18
L99	equ	17
	ends
	efunc
;
;/* Append the string 's' at the end of a row */
;void editorRowAppendString(erow *row, char *s, size_t len) {
	code
	xdef	~~editorRowAppendString
	func
~~editorRowAppendString:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L110
	tcs
	phd
	tcd
row_0	set	4
s_0	set	8
len_0	set	12
;    row->chars = realloc(row->chars,row->size+len+1);
	ldy	#$0
	phy
	iny
	iny
	lda	[<L110+row_0],Y
	ply
	rol	A
	ror	A
	bpl	L112
	dey
L112:
	sta	<R0
	sty	<R0+2
	lda	<R0
	clc
	adc	<L110+len_0
	sta	<R1
	lda	<R0+2
	adc	<L110+len_0+2
	sta	<R1+2
	lda	#$1
	clc
	adc	<R1
	sta	<R0
	lda	#$0
	adc	<R1+2
	pha
	pei	<R0
	ldy	#$8
	lda	[<L110+row_0],Y
	pha
	dey
	dey
	lda	[<L110+row_0],Y
	pha
	jsl	~~realloc
	stx	<R1+2
	ldy	#$6
	sta	[<L110+row_0],Y
	lda	<R1+2
	iny
	iny
	sta	[<L110+row_0],Y
;    memcpy(row->chars+row->size,s,len);
	pei	<L110+len_0+2
	pei	<L110+len_0
	pei	<L110+s_0+2
	pei	<L110+s_0
	ldy	#$0
	phy
	iny
	iny
	lda	[<L110+row_0],Y
	ply
	rol	A
	ror	A
	bpl	L113
	dey
L113:
	sta	<R0
	sty	<R0+2
	clc
	ldy	#$6
	lda	[<L110+row_0],Y
	adc	<R0
	sta	<R1
	iny
	iny
	lda	[<L110+row_0],Y
	adc	<R0+2
	pha
	pei	<R1
	jsl	~~memcpy
;    row->size += len;
	lda	#$2
	clc
	adc	<L110+row_0
	sta	<R0
	lda	#$0
	adc	<L110+row_0+2
	sta	<R0+2
	ldy	#$0
	lda	[<R0]
	bpl	L114
	dey
L114:
	sta	<R1
	sty	<R1+2
	lda	<R1
	clc
	adc	<L110+len_0
	sta	<R2
	lda	<R1+2
	adc	<L110+len_0+2
	sta	<R2+2
	lda	<R2
	sta	[<R0]
;    row->chars[row->size] = '\0';
	ldy	#$2
	lda	[<L110+row_0],Y
	sta	<R0
	ldy	#$6
	lda	[<L110+row_0],Y
	sta	<R1
	iny
	iny
	lda	[<L110+row_0],Y
	sta	<R1+2
	sep	#$20
	longa	off
	lda	#$0
	ldy	<R0
	sta	[<R1],Y
	rep	#$20
	longa	on
;    editorUpdateRow(row);
	pei	<L110+row_0+2
	pei	<L110+row_0
	jsl	~~editorUpdateRow
;    E.dirty++;
	inc	|~~E+20
;}
	lda	<L110+2
	sta	<L110+2+12
	lda	<L110+1
	sta	<L110+1+12
	pld
	tsc
	clc
	adc	#L110+12
	tcs
	rtl
L110	equ	12
L111	equ	13
	ends
	efunc
;
;/* Delete the character at offset 'at' from the specified row. */
;void editorRowDelChar(erow *row, int at) {
	code
	xdef	~~editorRowDelChar
	func
~~editorRowDelChar:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L116
	tcs
	phd
	tcd
row_0	set	4
at_0	set	8
;    if (row->size <= at) return;
	sec
	lda	<L116+at_0
	ldy	#$2
	sbc	[<L116+row_0],Y
	bvs	L118
	eor	#$8000
L118:
	bpl	L10073
L120:
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
;    memmove(row->chars+at,row->chars+at+1,row->size-at);
L10073:
	sec
	ldy	#$2
	lda	[<L116+row_0],Y
	sbc	<L116+at_0
	sta	<R0
	dey
	dey
	lda	<R0
	bpl	L121
	dey
L121:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	ldy	#$0
	lda	<L116+at_0
	bpl	L122
	dey
L122:
	sta	<R1
	sty	<R1+2
	lda	#$1
	clc
	adc	<R1
	sta	<R2
	lda	#$0
	adc	<R1+2
	sta	<R2+2
	clc
	ldy	#$6
	lda	[<L116+row_0],Y
	adc	<R2
	sta	<R1
	iny
	iny
	lda	[<L116+row_0],Y
	adc	<R2+2
	pha
	pei	<R1
	ldy	#$0
	lda	<L116+at_0
	bpl	L123
	dey
L123:
	sta	<R3
	sty	<R3+2
	clc
	ldy	#$6
	lda	[<L116+row_0],Y
	adc	<R3
	sta	<17
	iny
	iny
	lda	[<L116+row_0],Y
	adc	<R3+2
	sta	<17+2
	pha
	pei	<17
	jsl	~~memmove
;    editorUpdateRow(row);
	pei	<L116+row_0+2
	pei	<L116+row_0
	jsl	~~editorUpdateRow
;    row->size--;
	clc
	lda	#$ffff
	ldy	#$2
	adc	[<L116+row_0],Y
	sta	[<L116+row_0],Y
;    E.dirty++;
	inc	|~~E+20
;}
	brl	L120
L116	equ	20
L117	equ	21
	ends
	efunc
;
;/* Insert the specified char at the current prompt position. */
;void editorInsertChar(int c) {
	code
	xdef	~~editorInsertChar
	func
~~editorInsertChar:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L124
	tcs
	phd
	tcd
c_0	set	4
;    int filerow = E.rowoff+E.cy;
;    int filecol = E.coloff+E.cx;
;    erow *row = (filerow >= E.numrows) ? NULL : &E.row[filerow];
;	
;	
;	//fprintf(stderr, "erow: %08lX \n", row);
;	
;    /* If the row where the cursor is currently located does not exist in our
;     * logical representaion of the file, add enough empty rows as needed. */
;    if (row == NULL) {
filerow_1	set	0
filecol_1	set	2
row_1	set	4
	lda	|~~E+4
	clc
	adc	|~~E+2
	sta	<L125+filerow_1
	lda	|~~E+6
	clc
	adc	|~~E
	sta	<L125+filecol_1
	lda	<L125+filerow_1
	cmp	|~~E+12
	bcc	L126
	lda	#$0
	tax
	bra	L128
L126:
	ldy	#$0
	lda	<L125+filerow_1
	bpl	L129
	dey
L129:
	sta	<R0
	sty	<R0+2
	pea	#^$14
	pea	#<$14
	pei	<R0+2
	pei	<R0
	xref	~~~lmul
	jsl	~~~lmul
	sta	<R0
	stx	<R0+2
	lda	|~~E+16
	clc
	adc	<R0
	sta	<R1
	lda	|~~E+16+2
	adc	<R0+2
	sta	<R1+2
	ldx	<R1+2
	lda	<R1
L128:
	stx	<R0+2
	sta	<L125+row_1
	lda	<R0+2
	sta	<L125+row_1+2
	lda	<L125+row_1
	ora	<L125+row_1+2
	beq	L10075
;        while(E.numrows <= filerow) {
	bra	L10074
L20008:
;			editorInsertRow(E.numrows,"",0);
	pea	#<$0
	pea	#^L1
	pea	#<L1
	lda	|~~E+12
	pha
	jsl	~~editorInsertRow
;		}
L10075:
	lda	<L125+filerow_1
	cmp	|~~E+12
	bcs	L20008
;    }
;	
;
;    row = &E.row[filerow];
L10074:
	ldy	#$0
	lda	<L125+filerow_1
	bpl	L132
	dey
L132:
	sta	<R0
	sty	<R0+2
	pea	#^$14
	pea	#<$14
	pei	<R0+2
	pei	<R0
	xref	~~~lmul
	jsl	~~~lmul
	sta	<R0
	stx	<R0+2
	lda	|~~E+16
	clc
	adc	<R0
	sta	<L125+row_1
	lda	|~~E+16+2
	adc	<R0+2
	sta	<L125+row_1+2
;	//fprintf(stderr, "erow: %08lX \n", row);
;	
;    editorRowInsertChar(row, filecol, c);
	pei	<L124+c_0
	pei	<L125+filecol_1
	pei	<L125+row_1+2
	pei	<L125+row_1
	jsl	~~editorRowInsertChar
;	
;
;    if (E.cx == E.screencols-1)
;        E.coloff++;
	lda	#$ffff
	clc
	adc	|~~E+10
	cmp	|~~E
	bne	L10077
	inc	|~~E+6
;    else
	bra	L10078
L10077:
;        E.cx++;
	inc	|~~E
L10078:
;	
;    E.dirty++;
	inc	|~~E+20
;}
	lda	<L124+2
	sta	<L124+2+2
	lda	<L124+1
	sta	<L124+1+2
	pld
	tsc
	clc
	adc	#L124+2
	tcs
	rtl
L124	equ	16
L125	equ	9
	ends
	efunc
	data
L1:
	db	$00
	ends
;
;/* Inserting a newline is slightly complex as we have to handle inserting a
; * newline in the middle of a line, splitting the line as needed. */
;void editorInsertNewline(void) {
	code
	xdef	~~editorInsertNewline
	func
~~editorInsertNewline:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L136
	tcs
	phd
	tcd
;    unsigned int filerow = E.rowoff+E.cy;
;    unsigned int filecol = E.coloff+E.cx;
;    erow *row = (filerow >= E.numrows) ? NULL : &(E.row[filerow]);
;		
;    if (!row) {
filerow_1	set	0
filecol_1	set	2
row_1	set	4
	lda	|~~E+4
	clc
	adc	|~~E+2
	sta	<L137+filerow_1
	lda	|~~E+6
	clc
	adc	|~~E
	sta	<L137+filecol_1
	lda	<L137+filerow_1
	cmp	|~~E+12
	bcc	L138
	lda	#$0
	tax
	bra	L140
L138:
	lda	<L137+filerow_1
	sta	<R0
	stz	<R0+2
	pea	#^$14
	pea	#<$14
	pei	<R0+2
	pei	<R0
	xref	~~~lmul
	jsl	~~~lmul
	sta	<R0
	stx	<R0+2
	lda	|~~E+16
	clc
	adc	<R0
	sta	<R1
	lda	|~~E+16+2
	adc	<R0+2
	sta	<R1+2
	ldx	<R1+2
	lda	<R1
L140:
	stx	<R0+2
	sta	<L137+row_1
	lda	<R0+2
	sta	<L137+row_1+2
	lda	<L137+row_1
	ora	<L137+row_1+2
	bne	L10079
;        if (filerow == E.numrows) {
	lda	<L137+filerow_1
	cmp	|~~E+12
	beq	*+5
	brl	L143
;            editorInsertRow(filerow,"",0);
	pea	#<$0
	pea	#^L135
	pea	#<L135
	bra	L20010
L20012:
;        editorInsertRow(filerow,"",0);
	pea	#<$0
	pea	#^L135+1
	pea	#<L135+1
;    } else {
L20010:
	pei	<L137+filerow_1
	jsl	~~editorInsertRow
;            goto fixcursor;
	brl	L10081
;        }
;        return;
;    }
;    /* If the cursor is over the current line size, we want to conceptually
;     * think it's just over the last character. */
;	 
;    if (filecol >= row->size) filecol = row->size;
L10079:
	lda	<L137+filecol_1
	ldy	#$2
	cmp	[<L137+row_1],Y
	bcc	L10082
	lda	[<L137+row_1],Y
	sta	<L137+filecol_1
;    if (filecol == 0) {
L10082:
	lda	<L137+filecol_1
	beq	L20012
;        /* We are in the middle of a line. Split it between two rows. */
;        editorInsertRow(filerow+1,row->chars+filecol,row->size-filecol);
	sec
	ldy	#$2
	lda	[<L137+row_1],Y
	sbc	<L137+filecol_1
	pha
	lda	<L137+filecol_1
	sta	<R0
	stz	<R0+2
	clc
	ldy	#$6
	lda	[<L137+row_1],Y
	adc	<R0
	sta	<R1
	iny
	iny
	lda	[<L137+row_1],Y
	adc	<R0+2
	pha
	pei	<R1
	lda	<L137+filerow_1
	ina
	pha
	jsl	~~editorInsertRow
;        row = &E.row[filerow];
	lda	<L137+filerow_1
	sta	<R0
	stz	<R0+2
	pea	#^$14
	pea	#<$14
	pei	<R0+2
	pei	<R0
	xref	~~~lmul
	jsl	~~~lmul
	sta	<R0
	stx	<R0+2
	lda	|~~E+16
	clc
	adc	<R0
	sta	<L137+row_1
	lda	|~~E+16+2
	adc	<R0+2
	sta	<L137+row_1+2
;        row->chars[filecol] = '\0';
	ldy	#$6
	lda	[<L137+row_1],Y
	sta	<R0
	iny
	iny
	lda	[<L137+row_1],Y
	sta	<R0+2
	sep	#$20
	longa	off
	lda	#$0
	ldy	<L137+filecol_1
	sta	[<R0],Y
	rep	#$20
	longa	on
;        row->size = filecol;
	tya
	ldy	#$2
	sta	[<L137+row_1],Y
;        editorUpdateRow(row);
	pei	<L137+row_1+2
	pei	<L137+row_1
	jsl	~~editorUpdateRow
;    }
;fixcursor:
L10081:
;
;    if (E.cy == E.screenrows-1) {
	lda	#$ffff
	clc
	adc	|~~E+8
	cmp	|~~E+2
	bne	L10085
;        E.rowoff++;
	inc	|~~E+4
;    } else {
	bra	L10086
L10085:
;        E.cy++;
	inc	|~~E+2
;    }
L10086:
;    E.cx = 0;
	stz	|~~E
;    E.coloff = 0;
	stz	|~~E+6
;}
L143:
	pld
	tsc
	clc
	adc	#L136
	tcs
	rtl
L136	equ	16
L137	equ	9
	ends
	efunc
	data
L135:
	db	$00,$00
	ends
;
;/* Delete the char at the current prompt position. */
;void editorDelChar() {
	code
	xdef	~~editorDelChar
	func
~~editorDelChar:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L148
	tcs
	phd
	tcd
;    int shift;
;    int filerow = E.rowoff+E.cy;
;    int filecol = E.coloff+E.cx;
;    erow *row = (filerow >= E.numrows) ? NULL : &E.row[filerow];
;
;	
;    if (!row || (filecol == 0 && filerow == 0)) return;
shift_1	set	0
filerow_1	set	2
filecol_1	set	4
row_1	set	6
	lda	|~~E+4
	clc
	adc	|~~E+2
	sta	<L149+filerow_1
	lda	|~~E+6
	clc
	adc	|~~E
	sta	<L149+filecol_1
	lda	<L149+filerow_1
	cmp	|~~E+12
	bcc	L150
	lda	#$0
	tax
	bra	L152
L150:
	ldy	#$0
	lda	<L149+filerow_1
	bpl	L153
	dey
L153:
	sta	<R0
	sty	<R0+2
	pea	#^$14
	pea	#<$14
	pei	<R0+2
	pei	<R0
	xref	~~~lmul
	jsl	~~~lmul
	sta	<R0
	stx	<R0+2
	lda	|~~E+16
	clc
	adc	<R0
	sta	<R1
	lda	|~~E+16+2
	adc	<R0+2
	sta	<R1+2
	ldx	<R1+2
	lda	<R1
L152:
	stx	<R0+2
	sta	<L149+row_1
	lda	<R0+2
	sta	<L149+row_1+2
	lda	<L149+row_1
	ora	<L149+row_1+2
	beq	L158
	lda	<L149+filecol_1
	bne	L10087
	lda	<L149+filerow_1
	bne	L10087
L158:
	pld
	tsc
	clc
	adc	#L148
	tcs
	rtl
;    if (filecol == 0) {
L10087:
	lda	<L149+filecol_1
	beq	*+5
	brl	L10088
;        /* Handle the case of column 0, we need to move the current line
;         * on the right of the previous one. */
;        filecol = E.row[filerow-1].size;
	lda	#$ffff
	clc
	adc	<L149+filerow_1
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L160
	dey
L160:
	sta	<R0
	sty	<R0+2
	pea	#^$14
	pea	#<$14
	pei	<R0+2
	pei	<R0
	xref	~~~lmul
	jsl	~~~lmul
	sta	<R0
	stx	<R0+2
	lda	#$2
	clc
	adc	|~~E+16
	sta	<R1
	lda	#$0
	adc	|~~E+16+2
	sta	<R1+2
	lda	<R1
	clc
	adc	<R0
	sta	<R2
	lda	<R1+2
	adc	<R0+2
	sta	<R2+2
	lda	[<R2]
	sta	<L149+filecol_1
;        editorRowAppendString(&E.row[filerow-1],row->chars,row->size);
	ldy	#$0
	phy
	iny
	iny
	lda	[<L149+row_1],Y
	ply
	rol	A
	ror	A
	bpl	L161
	dey
L161:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	ldy	#$8
	lda	[<L149+row_1],Y
	pha
	dey
	dey
	lda	[<L149+row_1],Y
	pha
	lda	#$ffff
	clc
	adc	<L149+filerow_1
	sta	<R1
	ldy	#$0
	lda	<R1
	bpl	L162
	dey
L162:
	sta	<R1
	sty	<R1+2
	pea	#^$14
	pea	#<$14
	pei	<R1+2
	pei	<R1
	xref	~~~lmul
	jsl	~~~lmul
	sta	<R1
	stx	<R1+2
	lda	|~~E+16
	clc
	adc	<R1
	sta	<R2
	lda	|~~E+16+2
	adc	<R1+2
	pha
	pei	<R2
	jsl	~~editorRowAppendString
;        editorDelRow(filerow);
	pei	<L149+filerow_1
	jsl	~~editorDelRow
;        row = NULL;
	stz	<L149+row_1
	stz	<L149+row_1+2
;        if (E.cy == 0)
;            E.rowoff--;
	lda	|~~E+2
	bne	L10089
	dec	|~~E+4
;        else
	bra	L10090
L10089:
;            E.cy--;
	dec	|~~E+2
L10090:
;        E.cx = filecol;
	lda	<L149+filecol_1
	sta	|~~E
;        if (E.cx >= E.screencols) {
	cmp	|~~E+10
	bcc	L10092
;            shift = (E.screencols-E.cx)+1;
	sec
	lda	|~~E+10
	sbc	|~~E
	ina
	sta	<L149+shift_1
;            E.cx -= shift;
	sec
	lda	|~~E
	sbc	<L149+shift_1
	sta	|~~E
;            E.coloff += shift;
	lda	|~~E+6
	clc
	adc	<L149+shift_1
	sta	|~~E+6
;        }
;    } else {
	bra	L10092
L10088:
;        editorRowDelChar(row,filecol-1);
	lda	#$ffff
	clc
	adc	<L149+filecol_1
	pha
	pei	<L149+row_1+2
	pei	<L149+row_1
	jsl	~~editorRowDelChar
;        if (E.cx == 0 && E.coloff)
;            E.coloff--;
	lda	|~~E
	bne	L10093
	lda	|~~E+6
	beq	L10093
	dec	|~~E+6
;        else
	bra	L10092
L10093:
;            E.cx--;
	dec	|~~E
;    }
L10092:
;    if (row) editorUpdateRow(row);
	lda	<L149+row_1
	ora	<L149+row_1+2
	beq	L10095
	pei	<L149+row_1+2
	pei	<L149+row_1
	jsl	~~editorUpdateRow
;    E.dirty++;
L10095:
	inc	|~~E+20
;}
	brl	L158
L148	equ	22
L149	equ	13
	ends
	efunc
;
;void int2hex(char *s, unsigned int c) {
	code
	xdef	~~int2hex
	func
~~int2hex:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L168
	tcs
	phd
	tcd
s_0	set	4
c_0	set	8
;	unsigned int n;
;	
;	n = c >> 4;
n_1	set	0
	lda	<L168+c_0
	lsr	A
	lsr	A
	lsr	A
	lsr	A
	sta	<L169+n_1
;	if (n > 9) n+=7;
	lda	#$9
	cmp	<L169+n_1
	bcs	L10096
	dea
	dea
	clc
	adc	<L169+n_1
	sta	<L169+n_1
;	*s = n + '0';
L10096:
	lda	#$30
	clc
	adc	<L169+n_1
	sep	#$20
	longa	off
	sta	[<L168+s_0]
	rep	#$20
	longa	on
;	s++;
	inc	<L168+s_0
	bne	L171
	inc	<L168+s_0+2
L171:
;	n = c & 0x0f;
	lda	<L168+c_0
	and	#<$f
	sta	<L169+n_1
;	if (n > 9) n+=7;
	lda	#$9
	cmp	<L169+n_1
	bcs	L10097
	dea
	dea
	clc
	adc	<L169+n_1
	sta	<L169+n_1
;	*s = n + '0';	
L10097:
	lda	#$30
	clc
	adc	<L169+n_1
	sep	#$20
	longa	off
	sta	[<L168+s_0]
	rep	#$20
	longa	on
;}
	lda	<L168+2
	sta	<L168+2+6
	lda	<L168+1
	sta	<L168+1+6
	pld
	tsc
	clc
	adc	#L168+6
	tcs
	rtl
L168	equ	2
L169	equ	1
	ends
	efunc
; 
;unsigned int editorGenerateHexline(size_t adr, char *line, char* data, unsigned int len) {
	code
	xdef	~~editorGenerateHexline
	func
~~editorGenerateHexline:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L174
	tcs
	phd
	tcd
adr_0	set	4
line_0	set	8
data_0	set	12
len_0	set	16
;	unsigned int i, k;
;	char *a, *lineOld;
;	
;	lineOld = line;
i_1	set	0
k_1	set	2
a_1	set	4
lineOld_1	set	8
	lda	<L174+line_0
	sta	<L175+lineOld_1
	lda	<L174+line_0+2
	sta	<L175+lineOld_1+2
;	memset(line, ' ', 80);
	pea	#^$50
	pea	#<$50
	pea	#<$20
	pei	<L174+line_0+2
	pei	<L174+line_0
	jsl	~~memset
;	
;	a = (char *)(&adr);
	clc
	tdc
	adc	#<L174+adr_0
	sta	<L175+a_1
	lda	#$0
	sta	<L175+a_1+2
;	a += 2;
	ina
	ina
	clc
	adc	<L175+a_1
	sta	<L175+a_1
	bcc	L176
	inc	<L175+a_1+2
L176:
;	int2hex(line, *a);
	lda	[<L175+a_1]
	and	#$ff
	pha
	pei	<L174+line_0+2
	pei	<L174+line_0
	jsl	~~int2hex
;	a--;
	lda	<L175+a_1
	bne	L177
	dec	<L175+a_1+2
L177:
	dec	<L175+a_1
;	line += 2;
	lda	#$2
	clc
	adc	<L174+line_0
	sta	<L174+line_0
	bcc	L178
	inc	<L174+line_0+2
L178:
;	*line = ':';
	sep	#$20
	longa	off
	lda	#$3a
	sta	[<L174+line_0]
	rep	#$20
	longa	on
;	line++;
	inc	<L174+line_0
	bne	L179
	inc	<L174+line_0+2
L179:
;	int2hex(line, *a);
	lda	[<L175+a_1]
	and	#$ff
	pha
	pei	<L174+line_0+2
	pei	<L174+line_0
	jsl	~~int2hex
;	line += 2;
	lda	#$2
	clc
	adc	<L174+line_0
	sta	<L174+line_0
	bcc	L180
	inc	<L174+line_0+2
L180:
;	a--;
	lda	<L175+a_1
	bne	L181
	dec	<L175+a_1+2
L181:
	dec	<L175+a_1
;	int2hex(line, *a);
	lda	[<L175+a_1]
	and	#$ff
	pha
	pei	<L174+line_0+2
	pei	<L174+line_0
	jsl	~~int2hex
;	line += 4;
	lda	#$4
	clc
	adc	<L174+line_0
	sta	<L174+line_0
	bcc	L182
	inc	<L174+line_0+2
L182:
;	
;	for (i = 0; i < len; i++) {
	stz	<L175+i_1
	bra	L10101
L10100:
;		int2hex(line, *data);
	lda	[<L174+data_0]
	and	#$ff
	pha
	pei	<L174+line_0+2
	pei	<L174+line_0
	jsl	~~int2hex
;		line += 3;
	lda	#$3
	clc
	adc	<L174+line_0
	sta	<L174+line_0
	bcc	L183
	inc	<L174+line_0+2
L183:
;		if (i == 7) line++;
	lda	<L175+i_1
	cmp	#<$7
	bne	L10102
	inc	<L174+line_0
	bne	L10102
	inc	<L174+line_0+2
;		data++;
L10102:
	inc	<L174+data_0
	bne	L10098
	inc	<L174+data_0+2
;	}
L10098:
	inc	<L175+i_1
L10101:
	lda	<L175+i_1
	cmp	<L174+len_0
	bcc	L10100
;	data -= len;
	lda	<L174+len_0
	sta	<R0
	stz	<R0+2
	sec
	lda	<L174+data_0
	sbc	<R0
	sta	<L174+data_0
	lda	<L174+data_0+2
	sbc	<R0+2
	sta	<L174+data_0+2
;	
;	line = lineOld + 59;
	lda	#$3b
	clc
	adc	<L175+lineOld_1
	sta	<L174+line_0
	lda	#$0
	adc	<L175+lineOld_1+2
	sta	<L174+line_0+2
;	*line = '|';
	sep	#$20
	longa	off
	lda	#$7c
	sta	[<L174+line_0]
	rep	#$20
	longa	on
;	line++;
	inc	<L174+line_0
	bne	L188
	inc	<L174+line_0+2
L188:
;	
;	for (i = 0; i < len; i++) {
	stz	<L175+i_1
	bra	L10106
L10105:
;		if (*data >= 32 && *data < 128) {
	sep	#$20
	longa	off
	lda	[<L174+data_0]
	cmp	#<$20
	rep	#$20
	longa	on
	bcc	L10107
	sep	#$20
	longa	off
	lda	[<L174+data_0]
	cmp	#<$80
	rep	#$20
	longa	on
	bcs	L10107
;			*line = *data;
	sep	#$20
	longa	off
	lda	[<L174+data_0]
	sta	[<L174+line_0]
	rep	#$20
	longa	on
;		}
;		line++;
L10107:
	inc	<L174+line_0
	bne	L191
	inc	<L174+line_0+2
L191:
;		data++;
	inc	<L174+data_0
	bne	L10103
	inc	<L174+data_0+2
;	}
L10103:
	inc	<L175+i_1
L10106:
	lda	<L175+i_1
	cmp	<L174+len_0
	bcc	L10105
;	
;	*(lineOld+76) = '|';
	sep	#$20
	longa	off
	lda	#$7c
	ldy	#$4c
	sta	[<L175+lineOld_1],Y
	rep	#$20
	longa	on
;	
;	return (77);
	lda	#$4d
	tay
	lda	<L174+2
	sta	<L174+2+14
	lda	<L174+1
	sta	<L174+1+14
	pld
	tsc
	clc
	adc	#L174+14
	tcs
	tya
	rtl
;}
L174	equ	16
L175	equ	5
	ends
	efunc
;
;/* Load the specified program in the editor memory and returns 0 on success
; * or 1 on error. */
;int editorOpen() {
	code
	xdef	~~editorOpen
	func
~~editorOpen:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L195
	tcs
	phd
	tcd
;    FILE *fp;
;    char *line;
;	char *buffer;
;	char *p;
;    unsigned int linelen, buflen, bufavail;
;	int fd;
;	size_t sum, cnt;
;	unsigned int weiter, i;
;	char hexline[80];
;	
;    fp = fopen(E.filename, "rb");
fp_1	set	0
line_1	set	4
buffer_1	set	8
p_1	set	12
linelen_1	set	16
buflen_1	set	18
bufavail_1	set	20
fd_1	set	22
sum_1	set	24
cnt_1	set	28
weiter_1	set	32
i_1	set	34
hexline_1	set	36
	pea	#^L147
	pea	#<L147
	lda	|~~E+26+2
	pha
	lda	|~~E+26
	pha
	jsl	~~fopen
	sta	<L196+fp_1
	stx	<L196+fp_1+2
;    if (!fp) {
	ora	<L196+fp_1+2
	bne	L10108
;        return FALSE;
	lda	#$0
L198:
	tay
	pld
	tsc
	clc
	adc	#L195
	tcs
	tya
	rtl
;    }
;
;	fd = fileno(fp);
L10108:
	pei	<L196+fp_1+2
	pei	<L196+fp_1
	jsl	~~fileno
	sta	<L196+fd_1
;  	
;	sum = 0;
	stz	<L196+sum_1
	stz	<L196+sum_1+2
;	buflen = 0;		
	stz	<L196+buflen_1
;	linelen = 0;
	stz	<L196+linelen_1
;	weiter = 1;
	lda	#$1
	sta	<L196+weiter_1
;	buffer = malloc(1024);
	pea	#^$400
	pea	#<$400
	jsl	~~malloc
	sta	<L196+buffer_1
	stx	<L196+buffer_1+2
;    line = NULL;
	stz	<L196+line_1
	stz	<L196+line_1+2
;	cnt = 0;
	stz	<L196+cnt_1
	stz	<L196+cnt_1+2
;		
;	while(TRUE) {
	brl	L10109
L20014:
;			
;			if (weiter == 0) {
	lda	<L196+weiter_1
	bne	*+5
	brl	L10110
;				break;
;			}
;			
;			buflen = 1024 - linelen;
	sec
	lda	#$400
	sbc	<L196+linelen_1
	sta	<L196+buflen_1
;			
;			memmove(buffer, line, linelen);
	lda	<L196+linelen_1
	sta	<R0
	stz	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L196+line_1+2
	pei	<L196+line_1
	pei	<L196+buffer_1+2
	pei	<L196+buffer_1
	jsl	~~memmove
;			
;			bufavail = read(fd, buffer + linelen, buflen);
	lda	<L196+buflen_1
	sta	<R0
	stz	<R0+2
	pei	<R0+2
	pei	<R0
	lda	<L196+linelen_1
	sta	<R1
	stz	<R1+2
	lda	<L196+buffer_1
	clc
	adc	<R1
	sta	<R2
	lda	<L196+buffer_1+2
	adc	<R1+2
	pha
	pei	<R2
	pei	<L196+fd_1
	jsl	~~read
	sta	<L196+bufavail_1
;			sum += bufavail;
	sta	<R0
	stz	<R0+2
	lda	<R0
	clc
	adc	<L196+sum_1
	sta	<L196+sum_1
	lda	<R0+2
	adc	<L196+sum_1+2
	sta	<L196+sum_1+2
;
;			if (buflen != bufavail) weiter = 0;
	lda	<L196+buflen_1
	cmp	<L196+bufavail_1
	beq	L10113
	stz	<L196+weiter_1
;			buflen = bufavail + linelen;
L10113:
	lda	<L196+bufavail_1
	clc
	adc	<L196+linelen_1
	sta	<L196+buflen_1
;
;			line = p = buffer;
	lda	<L196+buffer_1
	sta	<L196+p_1
	lda	<L196+buffer_1+2
	sta	<L196+p_1+2
	lda	<L196+buffer_1
	sta	<L196+line_1
	lda	<L196+buffer_1+2
	brl	L20019
;			linelen = 0;
;			continue;
L20017:
;				if (linelen > 0 && *(p-1) == '\r') {
	lda	#$0
	cmp	<L196+linelen_1
	bcs	L10116
	lda	#$ffff
	clc
	adc	<L196+p_1
	sta	<R0
	lda	#$ffff
	adc	<L196+p_1+2
	sta	<R0+2
	sep	#$20
	longa	off
	lda	[<R0]
	cmp	#<$d
	rep	#$20
	longa	on
	bne	L10116
;					linelen--;
	dec	<L196+linelen_1
;				}
;				
;				editorInsertRow(E.numrows, line, linelen);
L10116:
	pei	<L196+linelen_1
	pei	<L196+line_1+2
	pei	<L196+line_1
	lda	|~~E+12
	pha
	jsl	~~editorInsertRow
;	
;				p++;
	bra	L20024
;				line = p;
;				linelen = 0;
;				continue;
L10114:
;			//debugf("buflen: %d linelen: %d\n", (long)buflen, (long)linelen);
;			
;			if (linelen == 15 || (buflen == 0 && weiter == 0)) {
	lda	<L196+linelen_1
	cmp	#<$f
	beq	L207
	lda	<L196+buflen_1
	bne	L10117
	lda	<L196+weiter_1
	bne	L10117
L207:
;	
;				linelen++;
	inc	<L196+linelen_1
;
;				//editorGenerateHexline(cnt, hexline, line, linelen);
;				
;				editorInsertRow(E.numrows, hexline, editorGenerateHexline(cnt, hexline, line, linelen));
	pei	<L196+linelen_1
	pei	<L196+line_1+2
	pei	<L196+line_1
	pea	#0
	clc
	tdc
	adc	#<L196+hexline_1
	pha
	pei	<L196+cnt_1+2
	pei	<L196+cnt_1
	jsl	~~editorGenerateHexline
	pha
	pea	#0
	clc
	tdc
	adc	#<L196+hexline_1
	pha
	lda	|~~E+12
	pha
	jsl	~~editorInsertRow
;				cnt += linelen;
	lda	<L196+linelen_1
	sta	<R0
	stz	<R0+2
	lda	<R0
	clc
	adc	<L196+cnt_1
	sta	<L196+cnt_1
	lda	<R0+2
	adc	<L196+cnt_1+2
	sta	<L196+cnt_1+2
;				
;				p++;
L20024:
	inc	<L196+p_1
	bne	L211
	inc	<L196+p_1+2
L211:
;				line = p;
	lda	<L196+p_1
	sta	<L196+line_1
	lda	<L196+p_1+2
L20019:
	sta	<L196+line_1+2
;				linelen = 0;
	stz	<L196+linelen_1
;				continue;
L10109:
;		
;		if (buflen == 0) {
	lda	<L196+buflen_1
	bne	*+5
	brl	L20014
;		}
;		
;		buflen--;
	dec	<L196+buflen_1
;		
;		if (E.hex == 0) {
	lda	|~~E+24
	bne	L10114
;			if (*p == '\n') {
	sep	#$20
	longa	off
	lda	[<L196+p_1]
	cmp	#<$a
	rep	#$20
	longa	on
	bne	*+5
	brl	L20017
;			}
;		} else {
L10117:
;
;		linelen++;
	inc	<L196+linelen_1
;		p++;
	inc	<L196+p_1
	bne	L10109
	inc	<L196+p_1+2
;		
;	}
	bra	L10109
;			}
;		}
L10110:
;	
;	free(buffer);
	pei	<L196+buffer_1+2
	pei	<L196+buffer_1
	jsl	~~free
;    fclose(fp);
	pei	<L196+fp_1+2
	pei	<L196+fp_1
	jsl	~~fclose
;    E.dirty = 0;
	stz	|~~E+20
;			
;	editorSetStatusMessage("%lu bytes read", sum);
	pei	<L196+sum_1+2
	pei	<L196+sum_1
	pea	#^L147+3
	pea	#<L147+3
	pea	#10
	jsl	~~editorSetStatusMessage
;    return TRUE;
	lda	#$1
	brl	L198
;}
L195	equ	128
L196	equ	13
	ends
	efunc
	data
L147:
	db	$72,$62,$00,$25,$6C,$75,$20,$62,$79,$74,$65,$73,$20,$72,$65
	db	$61,$64,$00
	ends
;
;/* Save the current file on disk. Return 0 on success, 1 on error. */
;int editorSave(void) {
	code
	xdef	~~editorSave
	func
~~editorSave:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L214
	tcs
	phd
	tcd
;    size_t len;
;    char *buf;
;	FILE *fout;
;	int error;
;	
;	error = TRUE;
len_1	set	0
buf_1	set	4
fout_1	set	8
error_1	set	12
	lda	#$1
	sta	<L215+error_1
;	
;    buf = editorRowsToString(&len);
	pea	#0
	clc
	tdc
	adc	#<L215+len_1
	pha
	jsl	~~editorRowsToString
	sta	<L215+buf_1
	stx	<L215+buf_1+2
;	
;    fout = fopen(E.filename, "wb");
	pea	#^L213
	pea	#<L213
	lda	|~~E+26+2
	pha
	lda	|~~E+26
	pha
	jsl	~~fopen
	sta	<L215+fout_1
	stx	<L215+fout_1+2
; 	if (fout != NULL) {
	ora	<L215+fout_1+2
	beq	L10119
;		if (fwrite(buf, 1, len, fout) == len) {
	pei	<L215+fout_1+2
	pei	<L215+fout_1
	pei	<L215+len_1+2
	pei	<L215+len_1
	pea	#^$1
	pea	#<$1
	pei	<L215+buf_1+2
	pei	<L215+buf_1
	jsl	~~fwrite
	stx	<R0+2
	cmp	<L215+len_1
	bne	L217
	lda	<R0+2
	cmp	<L215+len_1+2
L217:
	bne	L10120
;			error = FALSE;
	stz	<L215+error_1
;		}
;		fclose(fout);
L10120:
	pei	<L215+fout_1+2
	pei	<L215+fout_1
	jsl	~~fclose
;	}
;	
;	free(buf);
L10119:
	pei	<L215+buf_1+2
	pei	<L215+buf_1
	jsl	~~free
;
;	if (error) {
	lda	<L215+error_1
	beq	L10121
;		return FALSE;
	lda	#$0
L220:
	tay
	pld
	tsc
	clc
	adc	#L214
	tcs
	tya
	rtl
;	}
;
;    E.dirty = 0;
L10121:
	stz	|~~E+20
;    editorSetStatusMessage("%lu bytes written", len);
	pei	<L215+len_1+2
	pei	<L215+len_1
	pea	#^L213+3
	pea	#<L213+3
	pea	#10
	jsl	~~editorSetStatusMessage
;    return TRUE;
	lda	#$1
	bra	L220
;}
L214	equ	18
L215	equ	5
	ends
	efunc
	data
L213:
	db	$77,$62,$00,$25,$6C,$75,$20,$62,$79,$74,$65,$73,$20,$77,$72
	db	$69,$74,$74,$65,$6E,$00
	ends
;
;void editorSetFileName() {
	code
	xdef	~~editorSetFileName
	func
~~editorSetFileName:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L222
	tcs
	phd
	tcd
;	char c = 0;
;	int index = 0;
;	
;	printf("%c", CLS);
c_1	set	0
index_1	set	1
	sep	#$20
	longa	off
	stz	<L223+c_1
	rep	#$20
	longa	on
	stz	<L223+index_1
	pea	#<$1
	pea	#^L221
	pea	#<L221
	bra	L20027
;	
;	while (c != EOL) {
L20025:
;		c = toupper(getchar());
	lda	|~~stdin+2
	pha
	lda	|~~stdin
	pha
	jsl	~~fgetc
	pha
	jsl	~~toupper
	sep	#$20
	longa	off
	sta	<L223+c_1
;				
;		if (c >= ' ' && index < 80) {
	cmp	#<$20
	rep	#$20
	longa	on
	bcc	L10124
	sec
	lda	<L223+index_1
	sbc	#<$50
	bvs	L226
	eor	#$8000
L226:
	bmi	L10124
;			status[index++] = c;
	sep	#$20
	longa	off
	lda	<L223+c_1
	ldx	<L223+index_1
	sta	|~~status,X
	rep	#$20
	longa	on
	inc	<L223+index_1
;			printf("%c", c);
	lda	<L223+c_1
	and	#$ff
	pha
	pea	#^L221+3
	pea	#<L221+3
	pea	#8
	jsl	~~printf
;		}
;		if (c == BACK && index > 0) {
L10124:
	sep	#$20
	longa	off
	lda	<L223+c_1
	cmp	#<$8
	rep	#$20
	longa	on
	bne	L10125
	sec
	lda	#$0
	sbc	<L223+index_1
	bvs	L229
	eor	#$8000
L229:
	bmi	L10125
;			index--;
	dec	<L223+index_1
;			printf("%c", BACK);
	pea	#<$8
	pea	#^L221+6
	pea	#<L221+6
L20027:
	pea	#8
	jsl	~~printf
;		}
;	}		
L10125:
	sep	#$20
	longa	off
	lda	<L223+c_1
	cmp	#<$a
	rep	#$20
	longa	on
	bne	L20025
;	
;	status[index] = 0;
	sep	#$20
	longa	off
	lda	#$0
	ldx	<L223+index_1
	sta	|~~status,X
	rep	#$20
	longa	on
;	free(E.filename);
	lda	|~~E+26+2
	pha
	lda	|~~E+26
	pha
	jsl	~~free
;	E.filename = strdup(status);
	lda	#<~~status
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	jsl	~~strdup
	sta	|~~E+26
	stx	|~~E+26+2
;}
	pld
	tsc
	clc
	adc	#L222
	tcs
	rtl
L222	equ	7
L223	equ	5
	ends
	efunc
	data
L221:
	db	$25,$63,$00,$25,$63,$00,$25,$63,$00
	ends
;
;void editorEmpty() {
	code
	xdef	~~editorEmpty
	func
~~editorEmpty:
	longa	on
	longi	on
;	editorfreeAllRows();
	jsl	~~editorfreeAllRows
;	E.cx = 0;
	stz	|~~E
;    E.cy = 0;
	stz	|~~E+2
;    E.rowoff = 0;
	stz	|~~E+4
;    E.coloff = 0;
	stz	|~~E+6
;    E.numrows = 0;
	stz	|~~E+12
;    E.dirty = 0;
	stz	|~~E+20
;}
	rtl
L233	equ	0
L234	equ	1
	ends
	efunc
;
;int editorLoad() {
	code
	xdef	~~editorLoad
	func
~~editorLoad:
	longa	on
	longi	on
;	editorEmpty();
	jsl	~~editorEmpty
;	editorOpen();
	jsl	~~editorOpen
;}
	rtl
L236	equ	0
L237	equ	1
	ends
	efunc
;
;void editorSetDefaultStatusMessage() {
	code
	xdef	~~editorSetDefaultStatusMessage
	func
~~editorSetDefaultStatusMessage:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L239
	tcs
	phd
	tcd
;	if (errno) {
	jsl	~~__errno_location
	sta	<R0
	stx	<R0+2
	lda	[<R0]
	beq	L242
;			editorSetStatusMessage("I/O error: %s",strerror(errno));
	jsl	~~__errno_location
	sta	<R0
	stx	<R0+2
	lda	[<R0]
	pha
	jsl	~~strerror
	sta	<R0
	stx	<R0+2
	phx
	pha
	pea	#^L232
	pea	#<L232
	pea	#10
	jsl	~~editorSetStatusMessage
;			errno = 0;
	jsl	~~__errno_location
	sta	<R0
	stx	<R0+2
	lda	#$0
	sta	[<R0]
;	}
;}
L242:
	pld
	tsc
	clc
	adc	#L239
	tcs
	rtl
L239	equ	4
L240	equ	5
	ends
	efunc
	data
L232:
	db	$49,$2F,$4F,$20,$65,$72,$72,$6F,$72,$3A,$20,$25,$73,$00
	ends
;
;void editorToggleHex() {
	code
	xdef	~~editorToggleHex
	func
~~editorToggleHex:
	longa	on
	longi	on
;	toggleHex();
	jsl	~~toggleHex
;	E.readonly = E.hex;
	lda	|~~E+24
	sta	|~~E+22
;	editorLoad();
	jsl	~~editorLoad
;}
	rtl
L244	equ	0
L245	equ	1
	ends
	efunc
;
;/* ============================= Terminal update ============================ */
;
;/* We define a very simple "append buffer" structure, that is an heap
; * allocated string where we can append to. This is useful in order to
; * write all the escape sequences in a buffer and flush them to the standard
; * output in a single call, to avoid flickering effects. */
;struct abuf {
;    char *b;
;    int len;
;	int avail;
;};
;
;#define ABUF_INIT {NULL, 0, 0}
;#define ABUF_INCREMENT 1024
;
;void abAppend(struct abuf *ab, const char *s, int len) {
	code
	xdef	~~abAppend
	func
~~abAppend:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L247
	tcs
	phd
	tcd
ab_0	set	4
s_0	set	8
len_0	set	12
;		
;	while (len > ab->avail) {
	bra	L10127
L20029:
;		ab->avail += ABUF_INCREMENT;
	lda	#$6
	clc
	adc	<L247+ab_0
	sta	<R0
	lda	#$0
	adc	<L247+ab_0+2
	sta	<R0+2
	lda	#$400
	clc
	adc	[<R0]
	sta	[<R0]
;		ab->b = realloc(ab->b, ab->len + ab->avail);
	clc
	ldy	#$4
	lda	[<L247+ab_0],Y
	iny
	iny
	adc	[<L247+ab_0],Y
	sta	<R0
	ldy	#$0
	lda	<R0
	bpl	L251
	dey
L251:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	ldy	#$2
	lda	[<L247+ab_0],Y
	pha
	lda	[<L247+ab_0]
	pha
	jsl	~~realloc
	stx	<R1+2
	sta	[<L247+ab_0]
	lda	<R1+2
	ldy	#$2
	sta	[<L247+ab_0],Y
;	}
L10127:
	sec
	ldy	#$6
	lda	[<L247+ab_0],Y
	sbc	<L247+len_0
	bvs	L249
	eor	#$8000
L249:
	bpl	L20029
;	
;    //if (new == NULL) return;
;    memcpy(ab->b + ab->len, s, len);
	ldy	#$0
	lda	<L247+len_0
	bpl	L252
	dey
L252:
	sta	<R0
	sty	<R0+2
	pei	<R0+2
	pei	<R0
	pei	<L247+s_0+2
	pei	<L247+s_0
	ldy	#$0
	phy
	ldy	#$4
	lda	[<L247+ab_0],Y
	ply
	rol	A
	ror	A
	bpl	L253
	dey
L253:
	sta	<R1
	sty	<R1+2
	lda	[<L247+ab_0]
	clc
	adc	<R1
	sta	<R2
	ldy	#$2
	lda	[<L247+ab_0],Y
	adc	<R1+2
	pha
	pei	<R2
	jsl	~~memcpy
;    //ab->b = new;
;    ab->len += len;
	lda	#$4
	clc
	adc	<L247+ab_0
	sta	<R0
	lda	#$0
	adc	<L247+ab_0+2
	sta	<R0+2
	lda	[<R0]
	clc
	adc	<L247+len_0
	sta	[<R0]
;	ab->avail -= len;
	lda	#$6
	clc
	adc	<L247+ab_0
	sta	<R0
	lda	#$0
	adc	<L247+ab_0+2
	sta	<R0+2
	sec
	lda	[<R0]
	sbc	<L247+len_0
	sta	[<R0]
;}
	lda	<L247+2
	sta	<L247+2+10
	lda	<L247+1
	sta	<L247+1+10
	pld
	tsc
	clc
	adc	#L247+10
	tcs
	rtl
L247	equ	12
L248	equ	13
	ends
	efunc
;
;void abfree(struct abuf *ab) {
	code
	xdef	~~abfree
	func
~~abfree:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L255
	tcs
	phd
	tcd
ab_0	set	4
;    free(ab->b);
	ldy	#$2
	lda	[<L255+ab_0],Y
	pha
	lda	[<L255+ab_0]
	pha
	jsl	~~free
;}
	lda	<L255+2
	sta	<L255+2+4
	lda	<L255+1
	sta	<L255+1+4
	pld
	tsc
	clc
	adc	#L255+4
	tcs
	rtl
L255	equ	0
L256	equ	1
	ends
	efunc
;
;void editorRefreshScreen(void) {
	code
	xdef	~~editorRefreshScreen
	func
~~editorRefreshScreen:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L258
	tcs
	phd
	tcd
;	unsigned int rest;
;	unsigned int size;
;	unsigned int y;
;	unsigned int len;
;	unsigned int cx;
;	unsigned int filerow;
;	erow *r;
;	char *p;
;	char *dst = (char *)SCREENADR;
;	
;    for (y = 0, r = &E.row[E.rowoff]; y < E.screenrows; y++, r++) {
rest_1	set	0
size_1	set	2
y_1	set	4
len_1	set	6
cx_1	set	8
filerow_1	set	10
r_1	set	12
p_1	set	16
dst_1	set	20
	lda	#$f000
	sta	<L259+dst_1
	lda	#$7f
	sta	<L259+dst_1+2
	stz	<L259+y_1
	lda	|~~E+4
	sta	<R0
	stz	<R0+2
	pea	#^$14
	pea	#<$14
	pei	<R0+2
	pei	<R0
	xref	~~~lmul
	jsl	~~~lmul
	sta	<R0
	stx	<R0+2
	lda	|~~E+16
	clc
	adc	<R0
	sta	<L259+r_1
	lda	|~~E+16+2
	adc	<R0+2
	sta	<L259+r_1+2
	brl	L10132
L10131:
;       
;		if (E.rowoff + y >= E.numrows) {
	lda	|~~E+4
	clc
	adc	<L259+y_1
	cmp	|~~E+12
	bcc	L10133
;			*dst++ = '~';
	sep	#$20
	longa	off
	lda	#$7e
	sta	[<L259+dst_1]
	rep	#$20
	longa	on
	inc	<L259+dst_1
	bne	L261
	inc	<L259+dst_1+2
L261:
;			for(size = E.screencols-1; size != 0; size--) {
	lda	#$ffff
	clc
	adc	|~~E+10
	sta	<L259+size_1
	bra	L10137
L10136:
;				*dst++ = ' ';
	sep	#$20
	longa	off
	lda	#$20
	sta	[<L259+dst_1]
	rep	#$20
	longa	on
	inc	<L259+dst_1
	bne	L10134
	inc	<L259+dst_1+2
;			}
L10134:
	dec	<L259+size_1
L10137:
	lda	<L259+size_1
	bne	L10136
	brl	L10129
;			continue;
;		}
;		
;        size = r->size;
L10133:
	ldy	#$2
	lda	[<L259+r_1],Y
	sta	<L259+size_1
;		p = r->chars;
	ldy	#$6
	lda	[<L259+r_1],Y
	sta	<L259+p_1
	iny
	iny
	lda	[<L259+r_1],Y
	sta	<L259+p_1+2
;		
;		len = 0;
	stz	<L259+len_1
;        while (len < E.screencols && size != 0) {
	bra	L10138
L20032:
;				*dst++ = ' ';
	sep	#$20
	longa	off
	lda	#$20
	sta	[<L259+dst_1]
	rep	#$20
	longa	on
	inc	<L259+dst_1
	bne	L267
	inc	<L259+dst_1+2
L267:
;				p++;
	inc	<L259+p_1
	bne	L10141
	inc	<L259+p_1+2
;				while( (((size_t)dst % 4) != 0) && (len < E.screencols) ) {
	bra	L10141
L20031:
	lda	<L259+len_1
	cmp	|~~E+10
	bcs	L10138
;					*dst++ = ' ';
	sep	#$20
	longa	off
	lda	#$20
	sta	[<L259+dst_1]
	rep	#$20
	longa	on
	inc	<L259+dst_1
	bne	L271
	inc	<L259+dst_1+2
L271:
;					len++;
	inc	<L259+len_1
;				}
L10141:
	lda	<L259+dst_1
	and	#<$3
	bne	L20031
	bra	L10138
L20034:
	lda	<L259+size_1
	beq	L10139
;			
;			size--;
	dec	<L259+size_1
;			len++;
	inc	<L259+len_1
;			
;			if (*p == TAB) {
	sep	#$20
	longa	off
	lda	[<L259+p_1]
	cmp	#<$9
	rep	#$20
	longa	on
	beq	L20032
;				*dst++ = *p++;
	sep	#$20
	longa	off
	lda	[<L259+p_1]
	sta	[<L259+dst_1]
	rep	#$20
	longa	on
	inc	<L259+p_1
	bne	L272
	inc	<L259+p_1+2
L272:
	inc	<L259+dst_1
	bne	L10138
	inc	<L259+dst_1+2
;			}
;		}
;			} else {
L10138:
	lda	<L259+len_1
	cmp	|~~E+10
	bcc	L20034
L10139:
;				
;		rest = E.screencols - len;
	sec
	lda	|~~E+10
	sbc	<L259+len_1
	sta	<L259+rest_1
;		
;		for(; rest != 0; rest--) {
	bra	L10147
L10146:
;			*dst++ = ' ';
	sep	#$20
	longa	off
	lda	#$20
	sta	[<L259+dst_1]
	rep	#$20
	longa	on
	inc	<L259+dst_1
	bne	L10144
	inc	<L259+dst_1+2
;		}
L10144:
	dec	<L259+rest_1
L10147:
	lda	<L259+rest_1
	bne	L10146
;	}
L10129:
	lda	#$14
	clc
	adc	<L259+r_1
	sta	<L259+r_1
	bcc	L276
	inc	<L259+r_1+2
L276:
	inc	<L259+y_1
L10132:
	lda	<L259+y_1
	cmp	|~~E+8
	bcs	*+5
	brl	L10131
;	
;	sprintf(status, "%-20.20s - % 5d lines %10s %22s % 5d/% 5d", 
;		E.filename, E.numrows, E.dirty ? "(modified)" : "", "", E.rowoff+E.cy+1, E.numrows);
	lda	|~~E+12
	pha
	lda	|~~E+4
	clc
	adc	|~~E+2
	ina
	pha
	pea	#^L243+54
	pea	#<L243+54
	lda	|~~E+20
	beq	L278
	lda	#^L243+42
	tax
	lda	#<L243+42
	bra	L280
L278:
	lda	#^L243+53
	tax
	lda	#<L243+53
L280:
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	lda	|~~E+12
	pha
	lda	|~~E+26+2
	pha
	lda	|~~E+26
	pha
	pea	#^L243
	pea	#<L243
	lda	#<~~status
	sta	<R1
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R1
	pea	#28
	jsl	~~sprintf
;	
;		
;	p = status;
	lda	#<~~status
	sta	<L259+p_1
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<L259+p_1+2
;	for (size = 80; size != 0; size--) {
	lda	#$50
	sta	<L259+size_1
L10150:
;		*dst++ = *p++;
	sep	#$20
	longa	off
	lda	[<L259+p_1]
	sta	[<L259+dst_1]
	rep	#$20
	longa	on
	inc	<L259+p_1
	bne	L281
	inc	<L259+p_1+2
L281:
	inc	<L259+dst_1
	bne	L10148
	inc	<L259+dst_1+2
;	}
L10148:
	dec	<L259+size_1
	lda	<L259+size_1
	bne	L10150
;
;	sprintf(status, "%-80s", E.statusmsg);
	lda	#<~~E+30
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	pea	#^L243+55
	pea	#<L243+55
	lda	#<~~status
	sta	<R1
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R1
	pea	#14
	jsl	~~sprintf
;	
;	
;	p = status;
	lda	#<~~status
	sta	<L259+p_1
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	sta	<L259+p_1+2
;	for (size = 80; size != 0; size--) {
	lda	#$50
	sta	<L259+size_1
L10153:
;		*dst++ = *p++;
	sep	#$20
	longa	off
	lda	[<L259+p_1]
	sta	[<L259+dst_1]
	rep	#$20
	longa	on
	inc	<L259+p_1
	bne	L284
	inc	<L259+p_1+2
L284:
	inc	<L259+dst_1
	bne	L10151
	inc	<L259+dst_1+2
;	}
L10151:
	dec	<L259+size_1
	lda	<L259+size_1
	bne	L10153
;
;	
;    cx = 0;
	stz	<L259+cx_1
;    filerow = E.rowoff+E.cy;
	lda	|~~E+4
	clc
	adc	|~~E+2
	sta	<L259+filerow_1
;    r = (filerow >= E.numrows) ? NULL : &E.row[filerow];
	cmp	|~~E+12
	bcc	L287
	lda	#$0
	tax
	bra	L289
L287:
	lda	<L259+filerow_1
	sta	<R0
	stz	<R0+2
	pea	#^$14
	pea	#<$14
	pei	<R0+2
	pei	<R0
	xref	~~~lmul
	jsl	~~~lmul
	sta	<R0
	stx	<R0+2
	lda	|~~E+16
	clc
	adc	<R0
	sta	<R1
	lda	|~~E+16+2
	adc	<R0+2
	sta	<R1+2
	ldx	<R1+2
	lda	<R1
L289:
	stx	<R0+2
	sta	<L259+r_1
	lda	<R0+2
	sta	<L259+r_1+2
;    if (r) {
	lda	<L259+r_1
	ora	<L259+r_1+2
	beq	L10154
;        for (size = E.coloff; size < (E.cx+E.coloff); size++) {
	lda	|~~E+6
	sta	<L259+size_1
	bra	L10158
L10157:
;            if (size < r->size && r->chars[size] == TAB) cx += 3-((cx)%4);
	lda	<L259+size_1
	ldy	#$2
	cmp	[<L259+r_1],Y
	bcs	L10159
	ldy	#$6
	lda	[<L259+r_1],Y
	sta	<R0
	iny
	iny
	lda	[<L259+r_1],Y
	sta	<R0+2
	sep	#$20
	longa	off
	ldy	<L259+size_1
	lda	[<R0],Y
	cmp	#<$9
	rep	#$20
	longa	on
	bne	L10159
	lda	<L259+cx_1
	and	#<$3
	sta	<R0
	sec
	lda	#$3
	sbc	<R0
	clc
	adc	<L259+cx_1
	sta	<L259+cx_1
;            cx++;
L10159:
	inc	<L259+cx_1
;        }
	inc	<L259+size_1
L10158:
	lda	|~~E
	clc
	adc	|~~E+6
	sta	<R0
	lda	<L259+size_1
	cmp	<R0
	bcc	L10157
;    }
;	
;	//debugf("filerow:%d E.numrows:%d r:%08X E.coloff:%d E.cx:%d \n", (size_t)filerow, (size_t)E.numrows, E.row, (size_t) E.coloff, (size_t) E.cx); 
;
;    setCursor(E.cy, cx);
L10154:
	pei	<L259+cx_1
	lda	|~~E+2
	pha
	jsl	~~setCursor
;}
	pld
	tsc
	clc
	adc	#L258
	tcs
	rtl
L258	equ	32
L259	equ	9
	ends
	efunc
	data
L243:
	db	$25,$2D,$32,$30,$2E,$32,$30,$73,$20,$2D,$20,$25,$20,$35,$64
	db	$20,$6C,$69,$6E,$65,$73,$20,$25,$31,$30,$73,$20,$25,$32,$32
	db	$73,$20,$25,$20,$35,$64,$2F,$25,$20,$35,$64,$00,$28,$6D,$6F
	db	$64,$69,$66,$69,$65,$64,$29,$00,$00,$00,$25,$2D,$38,$30,$73
	db	$00
	ends
;
;#if 0
;/* This function writes the whole screen using VT100 escape characters
; * starting from the logical state of the editor in the global state 'E'. */
;void editorRefreshScreen(void) {
;    static char welcome[80];
;    static char buf[32];
;    static char rstatus[80];
;
;    int welcomelen;
;    int padding;
;    unsigned int filerow;
;    int y;
;    int len, rlen;
;    int current_color;
;    erow *r;
;    char *c;
;    unsigned char *hl;
;    int j;
;    char sym;
;    int color;
;    int msglen;
;    int cx;
;    erow *row;
;    
;    struct abuf ab = ABUF_INIT;
;
;
;    //abAppend(&ab,"\x1b[?25l",6); /* Hide cursor. */
;    //abAppend(&ab,"\x1b[H",3); /* Go home. */
;//	sym = CLS;
;	
;    //abAppend(&ab, &sym, 1); /* Go home. */
;//	clearScreen();
;
;	
;    for (y = 0; y < E.screenrows; y++) {
;        filerow = E.rowoff+y;
;		
;        if (filerow >= E.numrows) {
;            if (E.numrows == 0 && y == E.screenrows/3) {
;                welcomelen = snprintf(welcome, sizeof(welcome),
;					"Kilo editor -- version %s\n", KILO_VERSION);
;                    //"Kilo editor -- verison %s\x1b[0K\n", KILO_VERSION);
;                padding = (E.screencols-welcomelen)/2;
;                if (padding) {
;                    abAppend(&ab,"~",1);
;                    padding--;
;                }
;                while(padding--) abAppend(&ab," ",1);
;                abAppend(&ab,welcome,welcomelen);
;            } else {
;                //abAppend(&ab,"~\x1b[0K\n",7);
;				abAppend(&ab,"~\n",2);
;            }
;            continue;
;        }
;
;        r = &E.row[filerow];
;
;        len = r->rsize - E.coloff;
;        current_color = -1;
;		
;        if (len > 0) {
;            if (len > E.screencols) len = E.screencols;
;            c = r->render+E.coloff;
;            hl = r->hl+E.coloff;
;
;            for (j = 0; j < len; j++) {
;				//fprintf(stderr, "frow: %d, j: %d, h[j]: %d, c: %c\n", filerow, j, hl[j], c[j]);
;//#if 0		
;                if (hl[j] == HL_NONPRINT) {
;                    //abAppend(&ab,"\x1b[7m",4);
;                    if (c[j] <= 26)
;                        sym = '@'+c[j];
;                    else
;                        sym = '?';
;                    abAppend(&ab, &sym, 1);
;                    abAppend(&ab,"\x1b[0m",4);
;                } else if (hl[j] == HL_NORMAL) {
;                    if (current_color != -1) {
;                        //abAppend(&ab,"\x1b[39m",5);
;                        current_color = -1;
;                    }
;                    abAppend(&ab,c+j,1);
;                } else {
;                    color = editorSyntaxToColor(hl[j]);
;                    if (color != current_color) {
;                        //char buf[16];
;                        int clen = snprintf(buf,sizeof(buf),"\x1b[%dm",color);
;                        current_color = color;
;                        abAppend(&ab,buf,clen);
;                    }
;                    abAppend(&ab,c+j,1);
;                }
;//#endif
;				abAppend(&ab,c+j,1);
;            }
;        }
;        //abAppend(&ab,"\x1b[39m",5);
;        //abAppend(&ab,"\x1b[0K",4);
;        abAppend(&ab,"\n",1);
;
;    }
;
;//#if 0
;    /* Create a two rows status. First row: */
;    //abAppend(&ab,"\x1b[0K",4);
;    //abAppend(&ab,"\x1b[7m",4);
;    len = snprintf(status, sizeof(status), "%.20s - %d lines %s",
;        E.filename, E.numrows, E.dirty ? "(modified)" : "");
;    rlen = snprintf(rstatus, sizeof(rstatus),
;        "%d/%d",E.rowoff+E.cy+1,E.numrows);
;    if (len > E.screencols) len = E.screencols;
;    abAppend(&ab,status,len);
;    while(len < E.screencols) {
;        if (E.screencols - len == rlen) {
;            abAppend(&ab,rstatus,rlen);
;            break;
;        } else {
;            abAppend(&ab," ",1);
;            len++;
;        }
;    }
;    //abAppend(&ab,"\x1b[0m\n",6);
;    //abAppend(&ab,"\n",1);
;//#endif
;
;    /* Second row depends on E.statusmsg and the status message update time. */
;    //abAppend(&ab,"\x1b[0K",4);
;    msglen = strlen(E.statusmsg);
;    if (msglen && time(NULL)-E.statusmsg_time < 5)
;        abAppend(&ab,E.statusmsg,msglen <= E.screencols ? msglen : E.screencols);
;
;    /* Put cursor at its current position. Note that the horizontal position
;     * at which the cursor is displayed may be different compared to 'E.cx'
;     * because of TABs. */
;    //int j;
;    cx = 1;
;    filerow = E.rowoff+E.cy;
;    row = (filerow >= E.numrows) ? NULL : &E.row[filerow];
;    if (row) {
;        for (j = E.coloff; j < (E.cx+E.coloff); j++) {
;            if (j < row->size && row->chars[j] == TAB) cx += 3-((cx)%4);
;            cx++;
;        }
;    }
;	
;	
;    //snprintf(buf,sizeof(buf),"\x1b[%d;%dH",E.cy+1,cx);
;    //abAppend(&ab,buf,strlen(buf));
;    //abAppend(&ab,"\x1b[?25h",6); /* Show cursor. */
;
;	
;    //write(STDOUT_FILENO, ab.b, ab.len);
;
;    writeScreen(ab.b, ab.len);
;    
;    setCursor(E.cy, cx);
;
;    abfree(&ab);
;}
;#endif
;
;/* Set an editor status message for the second line of the status, at the
; * end of the screen. */
;void editorSetStatusMessage(const char *fmt, ...) {
	code
	xdef	~~editorSetStatusMessage
	func
~~editorSetStatusMessage:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L296
	tcs
	phd
	tcd
fmt_0	set	6
;
;    va_list ap;
;    va_start(ap, fmt);
ap_1	set	0
	clc
	tdc
	adc	#<L296+fmt_0+4
	sta	<L297+ap_1
	lda	#$0
	sta	<L297+ap_1+2
;    vsnprintf(E.statusmsg, sizeof(E.statusmsg), fmt, ap);
	pha
	pei	<L297+ap_1
	pei	<L296+fmt_0+2
	pei	<L296+fmt_0
	pea	#^$50
	pea	#<$50
	lda	#<~~E+30
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	jsl	~~vsnprintf
;    va_end(ap);
;	
;		
;    E.statusmsg_time = time(NULL);
	pea	#^$0
	pea	#<$0
	jsl	~~time
	sta	|~~E+110
	stx	|~~E+110+2
;}
	phx
	ldx	<L296+4
	lda	<L296+2
	sta	<L296+2,X
	lda	<L296+1
	sta	<L296+1,X
	txa
	plx
	pld
	pha
	tsc
	clc
	adc	#L296+2
	adc	<1,s
	tcs
	rtl
L296	equ	8
L297	equ	5
	ends
	efunc
;
;/* =============================== Find mode ================================ */
;
;#if 0
;#define KILO_QUERY_LEN 256
;
;void editorFind(int fd) {
;    static char query[KILO_QUERY_LEN+1] = {0};
;
;    erow *row;
;    int c;
;    int diff;
;    char *match;
;    int match_offset;
;    int i, current;	    
;    int qlen = 0;
;    int last_match = -1; /* Last line where a match was found. -1 for none. */
;    int find_next = 0; /* if 1 search next, if -1 search prev. */
;    int saved_hl_line = -1;  /* No saved HL */
;    char *saved_hl = NULL;
;
;#define FIND_RESTORE_HL do { \
;    if (saved_hl) { \
;        memcpy(E.row[saved_hl_line].hl,saved_hl, E.row[saved_hl_line].rsize); \
;        saved_hl = NULL; \
;    } \
;} while (0)
;
;    /* Save the cursor position in order to restore it later. */
;    int saved_cx = E.cx, saved_cy = E.cy;
;    int saved_coloff = E.coloff, saved_rowoff = E.rowoff;
;
;    while(1) {
;        editorSetStatusMessage(
;            "Search: %s (Use ESC/Arrows/Enter)", query);
;        editorRefreshScreen();
;
;        c = editorReadKey(fd);
;		
;        if (c == DEL_KEY || c == CTRL_H || c == BACKSPACE) {
;            if (qlen != 0) query[--qlen] = '\0';
;            last_match = -1;
;        } else if (c == ESC || c == ENTER) {
;            if (c == ESC) {
;                E.cx = saved_cx; E.cy = saved_cy;
;                E.coloff = saved_coloff; E.rowoff = saved_rowoff;
;            }
;            FIND_RESTORE_HL;
;            editorSetStatusMessage("");
;            return;
;        } else if (c == ARROW_RIGHT || c == ARROW_DOWN) {
;            find_next = 1;
;        } else if (c == ARROW_LEFT || c == ARROW_UP) {
;            find_next = -1;
;        } else if (isprint(c)) {
;            if (qlen < KILO_QUERY_LEN) {
;                query[qlen++] = c;
;                query[qlen] = '\0';
;                last_match = -1;
;            }
;        }
;
;        /* Search occurrence. */
;        if (last_match == -1) find_next = 1;
;        if (find_next) {
;            match = NULL;
;            match_offset = 0;
;            current = last_match;
;
;            for (i = 0; i < E.numrows; i++) {
;                current += find_next;
;                if (current == -1) current = E.numrows-1;
;                else if (current == E.numrows) current = 0;
;                match = strstr(E.row[current].render,query);
;                if (match) {
;                    match_offset = match-E.row[current].render;
;                    break;
;                }
;            }
;            find_next = 0;
;
;            /* Highlight */
;            FIND_RESTORE_HL;
;
;            if (match) {
;                row = &E.row[current];
;                last_match = current;
;                if (row->hl) {
;                    saved_hl_line = current;
;                    saved_hl = malloc(row->rsize);
;                    memcpy(saved_hl,row->hl,row->rsize);
;                    memset(row->hl+match_offset,HL_MATCH,qlen);
;                }
;                E.cy = 0;
;                E.cx = match_offset;
;                E.rowoff = current;
;                E.coloff = 0;
;                /* Scroll horizontally as needed. */
;                if (E.cx > E.screencols) {
;                    diff = E.cx - E.screencols;
;                    E.cx -= diff;
;                    E.coloff += diff;
;                }
;            }
;        }
;    }
;}
;#endif
;
;/* ========================= Editor events handling  ======================== */
;
;/* Handle cursor position change because arrow keys were pressed. */
;void editorMoveCursor(int key) {
	code
	xdef	~~editorMoveCursor
	func
~~editorMoveCursor:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L299
	tcs
	phd
	tcd
key_0	set	4
;    unsigned int rowlen;
;    unsigned int filerow = E.rowoff+E.cy;
;    unsigned int filecol = E.coloff+E.cx;
;    erow *row = (filerow >= E.numrows) ? NULL : &E.row[filerow];
;
;    switch(key) {
rowlen_1	set	0
filerow_1	set	2
filecol_1	set	4
row_1	set	6
	lda	|~~E+4
	clc
	adc	|~~E+2
	sta	<L300+filerow_1
	lda	|~~E+6
	clc
	adc	|~~E
	sta	<L300+filecol_1
	lda	<L300+filerow_1
	cmp	|~~E+12
	bcc	L301
	lda	#$0
	tax
	bra	L303
L301:
	lda	<L300+filerow_1
	sta	<R0
	stz	<R0+2
	pea	#^$14
	pea	#<$14
	pei	<R0+2
	pei	<R0
	xref	~~~lmul
	jsl	~~~lmul
	sta	<R0
	stx	<R0+2
	lda	|~~E+16
	clc
	adc	<R0
	sta	<R1
	lda	|~~E+16+2
	adc	<R0+2
	sta	<R1+2
	ldx	<R1+2
	lda	<R1
L303:
	stx	<R0+2
	sta	<L300+row_1
	lda	<R0+2
	sta	<L300+row_1+2
	lda	<L299+key_0
	xref	~~~fsw
	jsl	~~~fsw
	dw	1000
	dw	11
	dw	L10161-1
	dw	L10162-1
	dw	L10169-1
	dw	L10177-1
	dw	L10181-1
	dw	L10161-1
	dw	L10185-1
	dw	L10189-1
	dw	L10161-1
	dw	L10161-1
	dw	L10186-1
	dw	L10187-1
;    case ARROW_LEFT:
L10162:
;        if (E.cx == 0) {
	lda	|~~E
	beq	*+5
	brl	L10163
;            if (E.coloff) {
	lda	|~~E+6
	beq	L10164
;                E.coloff--;
	dec	|~~E+6
;            } else {
	brl	L10161
L10164:
;                if (filerow > 0) {
	lda	#$0
	cmp	<L300+filerow_1
	bcc	*+5
	brl	L10161
;                    E.cy--;
	dec	|~~E+2
;                    E.cx = E.row[filerow-1].size;
	lda	#$ffff
	clc
	adc	<L300+filerow_1
	sta	<R0
	stz	<R0+2
	pea	#^$14
	pea	#<$14
	pei	<R0+2
	pei	<R0
	xref	~~~lmul
	jsl	~~~lmul
	sta	<R0
	stx	<R0+2
	lda	#$2
	clc
	adc	|~~E+16
	sta	<R1
	lda	#$0
	adc	|~~E+16+2
	sta	<R1+2
	lda	<R1
	clc
	adc	<R0
	sta	<R2
	lda	<R1+2
	adc	<R0+2
	sta	<R2+2
	lda	[<R2]
	sta	|~~E
;                    if (E.cx > E.screencols-1) {
	lda	#$ffff
	clc
	adc	|~~E+10
	cmp	|~~E
	bcc	*+5
	brl	L10161
;                        E.coloff = E.cx-E.screencols+1;
	sec
	lda	|~~E
	sbc	|~~E+10
	ina
	sta	|~~E+6
;                        E.cx = E.screencols-1;
	lda	#$ffff
	clc
	adc	|~~E+10
L20041:
	sta	|~~E
;                    }
;                }
;            }
	brl	L10161
L20036:
	lda	<L300+filerow_1
	sta	<R0
	stz	<R0+2
	pea	#^$14
	pea	#<$14
	pei	<R0+2
	pei	<R0
	xref	~~~lmul
	jsl	~~~lmul
	sta	<R0
	stx	<R0+2
	lda	|~~E+16
	clc
	adc	<R0
	sta	<R1
	lda	|~~E+16+2
	adc	<R0+2
	sta	<R1+2
	ldx	<R1+2
	lda	<R1
	brl	L321
L20038:
	lda	#$0
	brl	L324
L10163:
;            E.cx -= 1;
	dec	|~~E
;        }
;        break;
	brl	L10161
;    case ARROW_RIGHT:
L10169:
;        if (row && filecol < row->size) {
	lda	<L300+row_1
	ora	<L300+row_1+2
	beq	L10170
	lda	<L300+filecol_1
	ldy	#$2
	cmp	[<L300+row_1],Y
	bcs	L10170
;            if (E.cx == E.screencols-1) {
	lda	#$ffff
	clc
	adc	|~~E+10
	cmp	|~~E
	bne	L10171
;                E.coloff++;
	inc	|~~E+6
;            } else {
	brl	L10161
L10171:
;                E.cx += 1;
	inc	|~~E
;            }
;        } else if (row && filecol == row->size) {
	brl	L10161
L10170:
	lda	<L300+row_1
	ora	<L300+row_1+2
	bne	*+5
	brl	L10161
	lda	<L300+filecol_1
	ldy	#$2
	cmp	[<L300+row_1],Y
	bne	L10161
;            E.cx = 0;
	stz	|~~E
;            E.coloff = 0;
	stz	|~~E+6
;            if (E.cy == E.screenrows-1) {
L20047:
	lda	#$ffff
	clc
	adc	|~~E+8
	cmp	|~~E+2
	bne	L10175
;                E.rowoff++;
	inc	|~~E+4
;            } else {
	bra	L10161
L10175:
;                E.cy += 1;
	inc	|~~E+2
;            }
;        }
;        break;
	bra	L10161
;    case ARROW_UP:
L10177:
;        if (E.cy == 0) {
	lda	|~~E+2
	bne	L10178
;            if (E.rowoff) E.rowoff--;
	lda	|~~E+4
	beq	L10161
	dec	|~~E+4
;        } else {
	bra	L10161
L10178:
;            E.cy -= 1;
	dec	|~~E+2
;        }
;        break;
	bra	L10161
;    case ARROW_DOWN:
L10181:
;        if (filerow < E.numrows) {
	lda	<L300+filerow_1
	cmp	|~~E+12
	bcc	L20047
;            if (E.cy == E.screenrows-1) {
	bra	L10161
;                E.rowoff++;
;            } else {
;                E.cy += 1;
;            }
;        }
;        break;
;	case HOME_KEY:
L10185:
;		E.cy = E.cx = E.rowoff = E.coloff = 0;
	stz	|~~E+6
	stz	|~~E+4
	stz	|~~E
	stz	|~~E+2
;		break;
	bra	L10161
;	case HOME_LINE:
L10186:
;		E.cx = E.coloff = 0;
	stz	|~~E+6
	stz	|~~E
;		break;
	bra	L10161
;	case END_LINE:
L10187:
;		if (row) {
	lda	<L300+row_1
	ora	<L300+row_1+2
	beq	L10161
;			E.coloff = 0;
	stz	|~~E+6
;			E.cx = row->size;
	ldy	#$2
	lda	[<L300+row_1],Y
;		}
;		break;		
	brl	L20041
;	case END_KEY:
L10189:
;		E.cx = E.coloff = 0;
	stz	|~~E+6
	stz	|~~E
;		E.rowoff = E.numrows - E.screenrows;
	sec
	lda	|~~E+12
	sbc	|~~E+8
	sta	|~~E+4
;		E.cy = E.screenrows-1;
	lda	#$ffff
	clc
	adc	|~~E+8
	sta	|~~E+2
;		break;
;        } else {
L10161:
;		
;    /* Fix cx if the current line has not enough chars. */
;    filerow = E.rowoff+E.cy;
	lda	|~~E+4
	clc
	adc	|~~E+2
	sta	<L300+filerow_1
;    filecol = E.coloff+E.cx;
	lda	|~~E+6
	clc
	adc	|~~E
	sta	<L300+filecol_1
;    row = (filerow >= E.numrows) ? NULL : &E.row[filerow];
	lda	<L300+filerow_1
	cmp	|~~E+12
	bcs	*+5
	brl	L20036
;	}
	lda	#$0
	tax
L321:
	stx	<R0+2
	sta	<L300+row_1
	lda	<R0+2
	sta	<L300+row_1+2
;    rowlen = row ? row->size : 0;
	lda	<L300+row_1
	ora	<L300+row_1+2
	bne	*+5
	brl	L20038
	ldy	#$2
	lda	[<L300+row_1],Y
L324:
	sta	<L300+rowlen_1
;    if (filecol > rowlen) {
	cmp	<L300+filecol_1
	bcs	L327
;        E.cx -= filecol-rowlen;
	sec
	lda	<L300+filecol_1
	sbc	<L300+rowlen_1
	sta	<R0
	sec
	lda	|~~E
	sbc	<R0
	sta	|~~E
;        if (E.cx < 0) {
	cmp	#<$0
	bcs	L327
;            E.coloff += E.cx;
	lda	|~~E+6
	clc
	adc	|~~E
	sta	|~~E+6
;            E.cx = 0;
	stz	|~~E
;        }
;    }
;}
L327:
	lda	<L299+2
	sta	<L299+2+2
	lda	<L299+1
	sta	<L299+1+2
	pld
	tsc
	clc
	adc	#L299+2
	tcs
	rtl
L299	equ	22
L300	equ	13
	ends
	efunc
;
;/* Process events arriving from the standard input, which is, the user
; * is typing stuff on the terminal. */
;#define KILO_QUIT_TIMES 1
;void editorProcessKeypress(int fd) {
	code
	xdef	~~editorProcessKeypress
	func
~~editorProcessKeypress:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L328
	tcs
	phd
	tcd
fd_0	set	4
;    /* When the file is modified, requires Ctrl-q to be pressed N times
;     * before actually quitting. */
;    static int quit_times = KILO_QUIT_TIMES;
;
;    int c = editorReadKey(fd);
;	
;    switch(c) {
c_1	set	0
	pei	<L328+fd_0
	jsl	~~editorReadKey
	sta	<L329+c_1
	xref	~~~swt
	jsl	~~~swt
	dw	23
	dw	3
	dw	L10197-1
	dw	5
	dw	L10199-1
	dw	6
	dw	L10193-1
	dw	8
	dw	L10206-1
	dw	10
	dw	L10194-1
	dw	12
	dw	L10224-1
	dw	14
	dw	L10201-1
	dw	17
	dw	L10197-1
	dw	19
	dw	L10202-1
	dw	24
	dw	L10208-1
	dw	27
	dw	L10193-1
	dw	127
	dw	L10206-1
	dw	1000
	dw	L10223-1
	dw	1001
	dw	L10223-1
	dw	1002
	dw	L10223-1
	dw	1003
	dw	L10223-1
	dw	1004
	dw	L10206-1
	dw	1005
	dw	L10223-1
	dw	1006
	dw	L10223-1
	dw	1007
	dw	L10210-1
	dw	1008
	dw	L10210-1
	dw	1009
	dw	L10223-1
	dw	1010
	dw	L10223-1
	dw	L10226-1
;    case ENTER:         /* Enter */
L10194:
;		if (!E.readonly) {
	lda	|~~E+22
	bne	L10193
;			editorInsertNewline();
	jsl	~~editorInsertNewline
;		}
;        break;
L10193:
;
;    quit_times = KILO_QUIT_TIMES; /* Reset it to the original value. */
	lda	#$1
	sta	|L330
;}
	bra	L334
;    case CTRL_C:        /* Ctrl-c */
;    case CTRL_Q:        /* Ctrl-q */
L10197:
;        /* Quit if the file was already saved. */
;        if (E.dirty && quit_times) {
	lda	|~~E+20
	beq	L10198
	lda	|L330
	beq	L10198
;            editorSetStatusMessage("WARNING!!! File has unsaved changes. "
;                "Press Ctrl-Q %d more times to quit.", quit_times);
	lda	|L330
	pha
	pea	#^L295
	pea	#<L295
	pea	#8
	jsl	~~editorSetStatusMessage
;            quit_times--;
	dec	|L330
;            return;
L334:
	lda	<L328+2
	sta	<L328+2+2
	lda	<L328+1
	sta	<L328+1+2
	pld
	tsc
	clc
	adc	#L328+2
	tcs
	rtl
;        }
;		end++;
L10198:
	inc	|~~end
;        //exit(0);
;        break;
	bra	L10193
;    case CTRL_E:
L10199:
;        editorEmpty();
	jsl	~~editorEmpty
;        break;
	bra	L10193
;    case CTRL_F:
;        //editorFind(fd);
;        break;
;	case CTRL_N:
L10201:
;		editorSetFileName();
	jsl	~~editorSetFileName
;		break;
	bra	L10193
;    case CTRL_S:        /* Ctrl-s */
L10202:
;		if (!E.readonly) {
	lda	|~~E+22
	bne	L10193
;			editorSave();
	jsl	~~editorSave
;		}
;        break;
	bra	L10193
;    case BACKSPACE:     /* Backspace */
;    case CTRL_H:        /* Ctrl-h */
;    case DEL_KEY:
L10206:
;		if (!E.readonly) {
	lda	|~~E+22
	bne	L10193
;			editorDelChar();
	jsl	~~editorDelChar
;		}
;        break;
	bra	L10193
;	case CTRL_X:
L10208:
;		editorToggleHex();
	jsl	~~editorToggleHex
;		break;
	bra	L10193
;    case PAGE_UP:
;    case PAGE_DOWN:
L10210:
;        if (c == PAGE_UP && E.cy != 0)
;            E.cy = 0;
	lda	<L329+c_1
	cmp	#<$3ef
	bne	L10211
	lda	|~~E+2
	beq	L10211
	stz	|~~E+2
;        else if (c == PAGE_DOWN && E.cy != E.screenrows-1)
	bra	L10212
L10211:
;            E.cy = E.screenrows-1;
	lda	<L329+c_1
	cmp	#<$3f0
	bne	L10212
	lda	#$ffff
	clc
	adc	|~~E+8
	cmp	|~~E+2
	beq	L10212
	lda	#$ffff
	clc
	adc	|~~E+8
	sta	|~~E+2
;        {
L10212:
;        int times = E.screenrows;
;        while(times--)
times_2	set	2
	lda	|~~E+8
	sta	<L329+times_2
	bra	L10214
L20049:
;            editorMoveCursor(c == PAGE_UP ? ARROW_UP:
;                                            ARROW_DOWN);
	lda	<L329+c_1
	cmp	#<$3ef
	bne	L342
	lda	#$3ea
	bra	L344
L342:
	lda	#$3eb
L344:
	pha
	jsl	~~editorMoveCursor
L10214:
	lda	<L329+times_2
	sta	<R0
	dec	<L329+times_2
	lda	<R0
	bne	L20049
;        }
;        break;
	brl	L10193
;
;    case ARROW_UP:
;    case ARROW_DOWN:
;    case ARROW_LEFT:
;    case ARROW_RIGHT:
;	case HOME_KEY:
;	case HOME_LINE:
;	case END_LINE:
;	case END_KEY:
L10223:
;        editorMoveCursor(c);
	pei	<L329+c_1
	jsl	~~editorMoveCursor
;        break;
	brl	L10193
;    case CTRL_L: 
L10224:
;        editorLoad();
	jsl	~~editorLoad
;        break;
	brl	L10193
;    case ESC:
;        /* Nothing to do for ESC in this mode. */
;        break;
;    default:
L10226:
;		if (!E.readonly) {
	lda	|~~E+22
	beq	*+5
	brl	L10193
;			editorInsertChar(c);
	pei	<L329+c_1
	jsl	~~editorInsertChar
;		}
;        break;
	brl	L10193
;    }
L328	equ	8
L329	equ	5
	ends
	efunc
	data
L330:
	dw	$1
	ends
	data
L295:
	db	$57,$41,$52,$4E,$49,$4E,$47,$21,$21,$21,$20,$46,$69,$6C,$65
	db	$20,$68,$61,$73,$20,$75,$6E,$73,$61,$76,$65,$64,$20,$63,$68
	db	$61,$6E,$67,$65,$73,$2E,$20,$50,$72,$65,$73,$73,$20,$43,$74
	db	$72,$6C,$2D,$51,$20,$25,$64,$20,$6D,$6F,$72,$65,$20,$74,$69
	db	$6D,$65,$73,$20,$74,$6F,$20,$71,$75,$69,$74,$2E,$00
	ends
;
;int editorFileWasModified(void) {
	code
	xdef	~~editorFileWasModified
	func
~~editorFileWasModified:
	longa	on
	longi	on
;    return E.dirty;
	lda	|~~E+20
	rtl
;}
L347	equ	0
L348	equ	1
	ends
	efunc
;
;void initEditor(void) {
	code
	xdef	~~initEditor
	func
~~initEditor:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L350
	tcs
	phd
	tcd
;    E.cx = 0;
	stz	|~~E
;    E.cy = 0;
	stz	|~~E+2
;    E.rowoff = 0;
	stz	|~~E+4
;    E.coloff = 0;
	stz	|~~E+6
;    E.numrows = 0;
	stz	|~~E+12
;    E.dirty = 0;
	stz	|~~E+20
;	E.readonly = 0;
	stz	|~~E+22
;	E.hex = 0;
	stz	|~~E+24
;    E.row = NULL;
	stz	|~~E+16
	stz	|~~E+16+2
;    E.filename = NULL;
	stz	|~~E+26
	stz	|~~E+26+2
;    E.syntax = NULL;
	stz	|~~E+114
	stz	|~~E+114+2
;    if (getWindowSize(STDIN_FILENO,STDOUT_FILENO,
;                      &E.screenrows, &E.screencols) == -1)
;    {
	lda	#<~~E+10
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	lda	#<~~E+8
	sta	<R1
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R1
	pea	#<$1
	pea	#<$0
	jsl	~~getWindowSize
	cmp	#<$ffffffff
	bne	L10228
;        perror("Unable to query the screen for size (columns / rows)");
	pea	#^L346
	pea	#<L346
	jsl	~~perror
;        exit(1);
	pea	#<$1
	jsl	~~exit
;    }
;    E.screenrows -= 2; /* Get room for status bar. */
L10228:
	dec	|~~E+8
	dec	|~~E+8
;	E.rowsavail = 0;
	stz	|~~E+118
;	
;}
	pld
	tsc
	clc
	adc	#L350
	tcs
	rtl
L350	equ	12
L351	equ	13
	ends
	efunc
	data
L346:
	db	$55,$6E,$61,$62,$6C,$65,$20,$74,$6F,$20,$71,$75,$65,$72,$79
	db	$20,$74,$68,$65,$20,$73,$63,$72,$65,$65,$6E,$20,$66,$6F,$72
	db	$20,$73,$69,$7A,$65,$20,$28,$63,$6F,$6C,$75,$6D,$6E,$73,$20
	db	$2F,$20,$72,$6F,$77,$73,$29,$00
	ends
;
;int main(int argc, char **argv) {
	code
	xdef	~~main
	func
~~main:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L355
	tcs
	phd
	tcd
argc_0	set	4
argv_0	set	6
;	
;	end = 0;
	stz	|~~end
;	
;    initEditor();
	jsl	~~initEditor
;	
;    if (argc < 2) {
	lda	<L355+argc_0
	bmi	L357
	dea
	dea
	bpl	L10229
L357:
;		
;        //fprintf(stderr,"Usage: kilo <filename>\n");
;        //exit(1);
;		
;		E.filename = strdup("D:KILL.C");
	pea	#^L354
	pea	#<L354
	jsl	~~strdup
	bra	L20053
;    } else {
L10229:
;		E.filename = adjustFilename(argv[1], 0);
	pea	#<$0
	ldy	#$6
	lda	[<L355+argv_0],Y
	pha
	dey
	dey
	lda	[<L355+argv_0],Y
	pha
	jsl	~~adjustFilename
L20053:
	sta	|~~E+26
	stx	|~~E+26+2
;	}	
;	
;//    editorSelectSyntaxHighlight(argv[1]);
;//    editorSelectSyntaxHighlight(filename);
;
;//    editorOpen(argv[1]);
;
;    //editorOpen(filename);
;	
;	//getchar();
;	
;    enableRawMode(STDIN_FILENO);
	pea	#<$0
	jsl	~~enableRawMode
;    editorSetStatusMessage(
;     	   "HELP: Ctrl-S = save | Ctrl-Q = quit | Ctrl-F = find | CTRL-X hex");
	pea	#^L354+9
	pea	#<L354+9
	pea	#6
	jsl	~~editorSetStatusMessage
;
;    while(!end) {
	bra	L10231
L20052:
;		editorRefreshScreen();
	jsl	~~editorRefreshScreen
;		editorProcessKeypress(STDIN_FILENO);
	pea	#<$0
	jsl	~~editorProcessKeypress
;		editorSetDefaultStatusMessage();
	jsl	~~editorSetDefaultStatusMessage
;    }
L10231:
	lda	|~~end
	beq	L20052
;	
;	printf("%c", CLS);
	pea	#<$1
	pea	#^L354+74
	pea	#<L354+74
	pea	#8
	jsl	~~printf
;/*
;	aclose(0);
;	aopen(0, "E:", 12, 0);
;	aclose(1);
;
;	editorfreeAllRows();
;	free(E.row);
;	free(E.filename);
;*/	
;    return 0;
	lda	#$0
	tay
	lda	<L355+2
	sta	<L355+2+6
	lda	<L355+1
	sta	<L355+1+6
	pld
	tsc
	clc
	adc	#L355+6
	tcs
	tya
	rtl
;}
L355	equ	0
L356	equ	1
	ends
	efunc
	data
L354:
	db	$44,$3A,$4B,$49,$4C,$4C,$2E,$43,$00,$48,$45,$4C,$50,$3A,$20
	db	$43,$74,$72,$6C,$2D,$53,$20,$3D,$20,$73,$61,$76,$65,$20,$7C
	db	$20,$43,$74,$72,$6C,$2D,$51,$20,$3D,$20,$71,$75,$69,$74,$20
	db	$7C,$20,$43,$74,$72,$6C,$2D,$46,$20,$3D,$20,$66,$69,$6E,$64
	db	$20,$7C,$20,$43,$54,$52,$4C,$2D,$58,$20,$68,$65,$78,$00,$25
	db	$63,$00
	ends
;
	xref	~~toupper
	xref	~~adjustFilename
	xref	~~read
	xref	~~__errno_location
	xref	~~strerror
	xref	~~strdup
	xref	~~memcpy
	xref	~~memset
	xref	~~memmove
	xref	~~realloc
	xref	~~free
	xref	~~malloc
	xref	~~perror
	xref	~~fileno
	xref	~~fclose
	xref	~~fwrite
	xref	~~fgetc
	xref	~~vsnprintf
	xref	~~sprintf
	xref	~~printf
	xref	~~fopen
	udata
~~status
	ds	81
	ends
	udata
~~end
	ds	2
	ends
	udata
~~E
	ds	120
	ends
	xref	~~stdin
