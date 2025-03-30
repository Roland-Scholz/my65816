#include <stdio.h>
#include <stdlib.h>
#include "FreeRTOS.h"
#include "task.h"
#include "homebrew.h"

#define debugout(x,y) {if(dev) printf(x,y); else debugf(x,y);} 
	
void dump(char *p, unsigned int len, unsigned int dev) {
	
	unsigned int cnt, x, y, c;
	
	cnt = 0;
	
	for (y = 0; cnt < len; y++) {
		
		debugout("%02X:", (size_t)p >> 16);
		debugout("%04X  ", p);
		
		for (x = 0; x < 16; x++, cnt++) {
			if (x == 8) debugout("%c", ' ');
			c = *p++;
			debugout("%02X ", (size_t)c);
		}
		debugout("%s", " |");
		
		p -= 16;

		for (x = 0; x < 16; x++) {
			c = *p++;
			if (! (c >= 32 && c < 125 && c != 0x9d && c < 254) ) {
				c = '.';
			}
			debugout("%c", c);
		}
		
		debugout("%s", "|\n");
	}
		
}

FILE *getStdin() {
	asm XREF ~~stdin;
	
	asm phb;
	asm phk;
	asm plb;
	asm ldx	|~~stdin+2;
	asm lda	|~~stdin;
	asm plb;
}

FILE *getStdout() {
	asm XREF ~~stdout;
	
	asm phb;
	asm phk;
	asm plb;
	asm ldx	|~~stdout+2;
	asm lda	|~~stdout;
	asm plb;
}
FILE *getStderr() {
	asm XREF ~~stderr;

	asm phb;
	asm phk;
	asm plb;
	asm ldx	|~~stderr+2;
	asm lda	|~~stderr;
	asm plb;
}

void dumpTaskControl(taskControl_t *tc) {

	unsigned int i;
	
	debugf("callerTaskHandle:%p\n", tc->callerTaskHandle);
	debugf("taskHandle      :%p\n", tc->taskHandle);
	debugf("codePtr         :%p\n", tc->codePtr);
	debugf("udataPt         :%p\n", tc->udataPtr);
	debugf("dataPtr         :%p\n", tc->dataPtr);

	debugf("argc      :%d\n", tc->argc);

	for(i = 0; i < tc->argc; i++) {
		debugf("parm %2d:%s\n", i, tc->argv[i]); 
	}
}


void dumpDataBank(char *s) {
	unsigned int bank;

	asm phb;
	asm phb;
	asm pla;
	asm and #$FF;
	asm sta %%bank;
	
	debugf("%s DataBank: %d\n", s, (size_t)bank);
}
