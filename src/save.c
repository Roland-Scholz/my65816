#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include "FreeRTOS.h"
#include "task.h"
#include <homebrew.h>

#define	BUFLEN	32

int main(int argc, char**argv) {
	
	char *pfrom, *pto, fname[BUFLEN];	
	size_t len, slen;
	FILE *f;
	unsigned int i;
	
	printf("save from:");
	pfrom = (char *)getHex8();
	printf(" to:");
	pto = (char *)getHex8();
	
	if (pfrom < pto) {
		
		printf(" filename>");	

		input(fname, 16);	
		
		len = (size_t)(pto - pfrom) + 1;
		
		//printf("%p %p *%s*\n", pfrom, pto, fname);
		
		f = fopen(fname, "w");
		if (f) {
			slen = fwrite(pfrom, 1, len, f);
			fclose(f);
			printf("\nsaved from:%p to:%p bytes:%lu file:%s\n", pfrom, pto, slen, fname);
			if (slen != len) {
				printf("warning! %lu out of %lu bytes written!\n", slen, len);
			}
		} else {
			printf("error!\n");
		}
	}
}

