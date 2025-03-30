#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include "FreeRTOS.h"
#include "task.h"
#include <homebrew.h>


int main(int argc, char**argv) {
	
	ptrconv_t p;
	size_t input;
	char c;
	
	printf("change address>");
	
	if (argc >= 2) {
		p.ptr = (char *)str2hex(argv[1]);
		printf("%s",argv[1]);
	} else {	
		p.ptr = (char *)getHex8();
	}
	
	printf("\n");

	for (;;) {	
		printf("%02X:%04X %02X >", p.adrBank.ptrBank, p.adrBank.ptr16, *(char *)p.ptr);

		input = getHex8();
		*(char *)p.ptr = (char)input;
		
		c = toupper(getchar());
		if (c == 'X') {
			printf("\n");
			break;
		}
		printf("\n");
	}

}

