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
	
	char *p, *ncode;
	int x, y;

	ncode = (char *)0x34d;
	for (;;) {
		printf("break address>");
		
		if (argc >= 2) {
			p = (char *)str2hex(argv[1]);
			printf("%s",argv[1]);
			argc = 1;
		} else {	
			p = (char *)getHex8();
		}
		
		printf("\n");	
		*ncode = *p;
		*p = 0;
	}
}
