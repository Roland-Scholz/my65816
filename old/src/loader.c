#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#include <homebrew.h>

#define BUFSIZE	4096

#ifdef RTOS
#include "FreeRTOS.h"
#include "task.h"
#include "semphr.h"
#endif

//unsigned char *ucHeap16 = (unsigned char *)0x009000;
//unsigned char *ucHeap = (unsigned char *)0x020000;

void *heap_start = ( void * )0x8000;
void *heap_end = (void * )0xbfff;

static char buffer[BUFSIZE];

extern unsigned char fd2iocb[8];

void strupper(char *str) {
	while(*str != 0) {
		*str = toupper(*str);
		str++;
	}
}

void loaderTask()
{
	FILE *fin;
	size_t r;
	char *p;
	unsigned int i;
	int fd;
	struct stat *stats;
	
	p = (char *)0x010000;
	
	//setvbuf(stdin, NULL, _IONBF, 1);
	
	printf("loading rtest.a\n");

	if(stat("D:RTEST.A", stats) != -1) {
		printf("length: %lu\n", stats->st_size); 
		//printf("length: %lx\n", (unsigned long)0xCafebabe); 
	}
	
	fin = fopen("D:RTEST.A", "r");
	if (fin == NULL) {
		printf("can't load\n");
		return;
	}

	fd = fileno(fin);
	
	for(i = 0; i < 16; i++){
		//r = fread(buffer, 1, BUFSIZE, fin);
		r = read(fd, buffer, BUFSIZE);
		//printf("%d dummy bytes read\n", r);
	}
	
	
	for(;;) {
		//r = fread(p, 1, BUFSIZE, fin);
		r = read(fd, p, BUFSIZE);
		printf("%d bytes read @ %p\n", r, p);
		p += r;
		if (r != BUFSIZE) break;
	}
	
	fclose(fin);
}	


int main(int argc, char **argv) {
	
	int rc;
	
	//asm {wdm 7;};
	
    fd2iocb[0] = 0;
    fd2iocb[1] = 0;
    fd2iocb[2] = 0;
    fd2iocb[3] = 0xff;
    fd2iocb[4] = 0xff;
    fd2iocb[5] = 0xff;
    fd2iocb[6] = 0xff;
    fd2iocb[7] = 0xff;

	//printf("Hallo\n");
	loaderTask();
	return 0;
}