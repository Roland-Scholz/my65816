#ifndef _HOMEBREW_H
#define _HOMEBREW_H

#define EOL	10

#define SUCCES	1	/* successful operation				*/

#define BRKABT	128	/* BREAK key abort                              */
#define PRVOPN	129	/* IOCB already open error			*/
#define NONDEV	130	/* nonexistent device error			*/
#define WRONLY	131	/* IOCB opened for write only error		*/
#define NVALID	132	/* invalid command error			*/
#define NOTOPN	133	/* device/file not open error			*/
#define BADIOC	134	/* invalid IOCB index error			*/
#define RDONLY	135	/* IOCB opened for read only error		*/
#define EOFERR	136	/* end of file error				*/
#define TRNRCD	137	/* truncated record error			*/
#define TIMOUT	138	/* peripheral device timeout error		*/
#define DNACK	139	/* device does not acknowledge command error	*/
#define FRMERR	140	/* serial bus framing error			*/
#define CRSROR	141	/* cursor overrange error			*/
#define OVRRUN	142	/* serial bus data overrun error		*/
#define CHKERR	143	/* serial bus checksum error			*/
#define DERROR	144	/* device done (operation incomplete) error	*/
#define BADMOD	145	/* bad screen mode number error			*/
#define FNCNOT	146	/* function not implemented in handler error	*/
#define SCRMEM	147	/* insufficient memory for screen mode error	*/
#define NOTFND	170	/* file or directory not found                  */

#define CCHM 0x1C
#define CCBT 0x1D
#define CCLM 0x1E
#define CCRM 0x1F

#define BACK	0x08	//backspace
//#define EOL	 	0x0A	//$9B	//end of line (RETURN)

#define ESC	 	0x1B	//escape key
#define LBRACK		0x5B
#define CCUP	0x1C	//cursor up
#define CCDN	0x1D	//cursor down
#define CCLF	0x1E	//cursor left
#define CCRT	0x1F	//cursor right
#define CSPACE	0x20	//space
#define CLS	0x01	//clear screen
#define TABU	0x7F	//tabulator
#define CILN	0x9D	//insert line
#define CDCH	0xFE	//delete character
#define CICH	0xFF	//insert character

#define HELP	0x11	//key code for HELP
#define CNTLF1	0x83	//key code for CTRL-F1
#define CNTLF2	0x84	//key code for CTRL-F2
#define CNTLF3	0x93	//key code for CTRL-F3
#define CNTLF4	0x94	//key code for CTRL-F4
#define CNTL1	0x9F	//key code for CTRL-1
#define CPGUP	0x95	//key code for page-up
#define CPGDN	0x96	//key code for page-down

/* I/O control block */
struct __iocb {
    unsigned char handler;    /* handler index number (0xff free) */
    unsigned char drive;      /* device number (drive) */
    unsigned char command;    /* command */
    unsigned char status;     /* status of last operation */
    unsigned int  buffer;     /* pointer to buffer */
    unsigned char bufferBank;
    unsigned int  buflen;     /* length of buffer */
    unsigned char buflenBank;
    unsigned char aux1;       /* 1st auxiliary byte */
    unsigned char aux2;       /* 2nd auxiliary byte */
    unsigned char aux3;       /* 3rd auxiliary byte */
    unsigned char aux4;       /* 4th auxiliary byte */
    unsigned char aux5;       /* 5th auxiliary byte */
    unsigned char spare;      /* spare byte */
};

typedef	struct __iocb iocb_t;

#define ZIOCB (*(struct __iocb *)0x20)  /* zero page IOCB */
#define IOCB (*(struct __iocb *)0x280)  /* system IOCB buffers */

/* IOCB Command Codes */
#define IOCB_OPEN        0x03  /* open */
#define IOCB_GETREC      0x05  /* get record */
#define IOCB_GETCHR      0x07  /* get character(s) */
#define IOCB_PUTREC      0x09  /* put record */
#define IOCB_PUTCHR      0x0B  /* put character(s) */
#define IOCB_CLOSE       0x0C  /* close */
#define IOCB_STATIS      0x0D  /* status */
#define IOCB_SPECIL      0x0E  /* special */
#define IOCB_DRAWLN      0x11  /* draw line */
#define IOCB_FILLIN      0x12  /* draw line with right fill */
#define IOCB_RENAME      0x20  /* rename disk file */
#define IOCB_DELETE      0x21  /* delete disk file */
#define IOCB_CREDIR	 0x22  /* create directory SRO*/
#define IOCB_LOCKFL      0x23  /* lock file (set to read-only) */
#define IOCB_UNLOCK      0x24  /* unlock file */
#define IOCB_POINT       0x25  /* point sector */
#define IOCB_NOTE        0x26  /* note sector */
#define IOCB_GETFL       0x27  /* get file length */
#define IOCB_STAT	 0x28  /* get stat */ 
#define IOCB_CHDIR_MYDOS 0x29  /* change directory (MyDOS) */
#define IOCB_MKDIR       0x2A  /* make directory (MyDOS/SpartaDOS) */
#define IOCB_RMDIR       0x2B  /* remove directory (SpartaDOS) */
#define IOCB_CHDIR_SPDOS 0x2C  /* change directory (SpartaDOS) */
#define IOCB_GETCWD      0x30  /* get current directory (MyDOS/SpartaDOS) */
#define IOCB_FORMAT      0xFE  /* format */


#define MYOS	0xC000
#define CIOV 	0xC00F

#define IOCBSTRT 	((char *)0x0280)

#define FNAME		((char *)0x0380)
//#define MODBASE (*(unsigned int *)0x035D)

#define NCODE		(*(char *)0x034D)

#define DIRCLUS (*(unsigend int *)0x0441)

//#define COLOR0	(*(char *)0xB880)
//#define COLOR1	(*(char *)0xB881)
//#define COLOR2	(*(char *)0xB882)
//#define COLOR3	(*(char *)0xB883)

#define IO		(0xFFFF00)

#define SCREEN		((char *)0x7ff000)

//=======================================================
#define PALETTE		((char *)0xFFFC00)
//=======================================================
#define DISPLAY (0xFFFE00)

#define COLORBORDER		(*(unsigned int *)(DISPLAY+0))
#define COLORBORDERLO		(*(char *)(DISPLAY+0))
#define COLORBORDERHI		(*(char *)(DISPLAY+1))
#define COLORBACKGROUNDLO	(*(char *)(DISPLAY+2))
#define COLORBACKGROUNDHI	(*(char *)(DISPLAY+3))
#define COLOR00LO		(*(char *)(DISPLAY+4))
#define COLOR00HI		(*(char *)(DISPLAY+5))
#define SCREENBASELO		(*(char *)(DISPLAY+6))
#define SCREENBASEHI		(*(char *)(DISPLAY+7))
#define SCREENBASEBANK		(*(char *)(DISPLAY+8))
#define CONTROL 		(*(char *)(DISPLAY+9))
#define CURSOR  		(*(unsigned int *)(DISPLAY+10))
//=======================================================
#define STATA	(*(char *)0xBFF1)
#define TRANSA	(*(char *)0xBFF3)

//--------------------------------------------------------------
// 16450 ACIA registers
//--------------------------------------------------------------
#define THR0	(*(char *)0xFFFFE0)
#define	RBR0	(*(char *)0xFFFFE0)
#define LSR0	(*(char *)0xFFFFE5)


struct c2iocb {
	char iocb;
	char isatty;
};

union ptrconv {
	struct {
		unsigned int ptr16;
		unsigned char ptrBank;
		unsigned char ptrUnused;
	} adrBank;
	void *ptr;
	unsigned long ul;
};

typedef union ptrconv ptrconv_t;
typedef struct c2iocb t_c2iocb;

extern char* _mem_start;
extern void* _heap_top;
extern t_c2iocb c2iocb[];

char* getErrorString(char iorc);
void printErr(char iorc);
char *_getiob();
char getFreeIocb();
char putrec(char channel, char *s);
unsigned char getrec(char channel, char *s);
char getchr(char channel, char *s, int len);
unsigned char aclose(char channel);
unsigned char aopen(unsigned char channel, char *s, char aux1, char aux2);
char callCIOV(char channel, char cmd, const char *s, int len);
char xio(char channel, char cmd, const char *s, int len, int aux1, int aux2);
void hex(char *buf, char b);
void hex4(char *buf, unsigned int i);
void hex8(char *buf, unsigned long l);
void printchar(char c) ;
void printhex(char c) ;


/************************************************/
/* RTOS task definitions     			*/
/************************************************/

#define POSTCODE asm phk; asm plb;


enum {SECT_PAGE0, SECT_CODE, SECT_KDATA, SECT_DATA, SECT_UDATA };
enum {
		OP_END=0,					/* end of expression */
		OP_SYM,						/* ref to extern symbol */
		OP_VAL,						/* constant value */
		OP_LOC,						/* ref to offset from start of section */

		OP_UNA=10,
		OP_NOT=10,
		OP_NEG,
		OP_FLP,

		OP_BIN=20,
			OP_EXP=20, OP_MUL, OP_DIV, OP_MOD, OP_SHR,
			OP_SHL, OP_ADD, OP_SUB, OP_AND, OP_OR,
			OP_XOR, OP_EQ, OP_GT, OP_LT, OP_UGT,
			OP_ULT,
			OP_LAST
};

struct r816Header {
	size_t magic;
	size_t mainOffset;
	size_t codeLen;
	size_t dataLen;
	size_t uDataLen;
	size_t numSymbols;
	size_t numExpressions;	
};
typedef struct r816Header r816Header_t;

struct expression {
	char			len;
	char			codeLen;
	char			tSection;
	size_t	tOffset;
};
typedef struct expression expression_t;

struct symbol {
	char			linkage;
	char			section;
	size_t	offset;
};
typedef struct symbol symbol_t;


#ifdef RTOS
#include "freeRTOS.h"
#include "task.h"

//if changed, rtest.c, and heap32.c must be recompiled
#define HEAP_INCREMENT 256

struct taskControl {
	char *cmdLine;
	unsigned int argc;
	char **argv;
	TaskHandle_t callerTaskHandle;
	TaskHandle_t taskHandle;
	char *codePtr;
	char *udataPtr;
	char *dataPtr;
	int rc;
	char **heap;
	char **heapNext;
	unsigned int heapAvailable;
	unsigned int heapSize;
	unsigned int background;
};
typedef struct taskControl taskControl_t;

void vTaskRemove(taskControl_t *);
#else
struct stat {
	unsigned short	st_mode;
	unsigned long	st_size;
};
#endif

FILE *getStdin( void );
FILE *getStdout( void );
FILE *getStderr( void );
int debugf(const char *format, ...);
size_t getHex8( void );
int hex2int(char c);
size_t str2hex(char *s);
void strupper(char *str);
char *adjustFilename(char *s, int exe);
int hex2int(char c);
char *getShellpath( void );
void dump(char *p, unsigned int len, unsigned int dev);
void printhex(char c);
void printchar(char c);
int input(char *s, int maxlen);

/************************************************/
/* End of homebrew.h */
#endif