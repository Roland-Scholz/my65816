#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include "FreeRTOS.h"
#include "task.h"
#include <homebrew.h>

#define DISASS24	$E052
#define	DISSADRLO	*((unsigned int *) 0x2)
#define	DISSADRBANK	*((char *) 0x4)


int main(int argc, char **argv) {
	
	char *p, c;
	int x, y;

	for (;;) {
		printf("disass address>");
		
		if (argc >= 2) {
			p = (char *)str2hex(argv[1]);
			printf("%s",argv[1]);
			argc = 1;
		} else {	
			p = (char *)getHex8();
		}
		
		printf("\n");	
		
		DISSADRLO = (unsigned int)((size_t)p);
		DISSADRBANK = (size_t)p >> 16;
		
		asm{jsl $e052;}

		if (getchar() == 'x') {
			break;
		}
	}
}
