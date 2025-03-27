#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include "FreeRTOS.h"
#include "task.h"
#include <homebrew.h>
#include <errno.h>


int main(int argc, char**argv) {
	
	char *p, c;
	
	printf("dump address>");
	
	if (argc >= 2) {
		p = (char *)str2hex(argv[1]);
		printf("%s",argv[1]);
	} else {	
		p = (char *)getHex8();
	}
	
	printf("\n");

	for (;;) {		
		dump(p, 256, 1);
		c = toupper(getchar());
		if (c == 'X') break;
		p += 256;
	}

}

