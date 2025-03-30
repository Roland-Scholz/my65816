#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <errno.h>
#include <unistd.h>
#include <dirent.h>

#include "freeRTOS.h"
#include "task.h"
#include <homebrew.h>
#include <sys/stat.h>    /* LINUX/UNIX     */
#include <sys/types.h>   /* LINUX/UNIX     */

static char buffer[32] = "D:KILO.C";
static char line[100];

int main(int argc, char **argv) {
		
	char rc;
	struct stat st;
	FILE *fin;
	
	unsigned int len;
	
	printf("stat \n");

	rc = stat(buffer, &st);
	
//		dump((char *)0x20, 16, 0);
//		dump(IOCBSTRT, 128, 0);
//		dump((char *)0x500, 256, 0);
	
	//printf("stat rc: %d, len: %lu\n", rc, st.st_size);

	return 0;
	fin = fopen(buffer, "rb");
	fread(line, 100, 1, fin);
	fseek(fin, 123, SEEK_SET);
	
	printf("line: %s\n", line);
	fclose(fin);
}
