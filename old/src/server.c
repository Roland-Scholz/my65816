#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#include <homebrew.h>

#define BUFSIZE	512

#ifdef RTOS
#include "FreeRTOS.h"
#include "task.h"
#include "semphr.h"
#endif

void *heap_start = ( void * )0x8000;
void *heap_end = (void * )0xafff;

static char buffer[BUFSIZE];
static char fname[16];

extern unsigned char fd2iocb[8];

static char inbyte() {
	while (!(LSR0 & 0x01));
	return RBR0;
}

static void outbyte(int c) {
	while (!(LSR0 & 0x40));
	THR0 = c;
}

int receiveFile() {
	
	unsigned int i, bytes;
	char c[4];
	FILE *f;
	
	//printf("receiving file...\n");
	outbyte('A');
	
	i = 2;
	fname[0] = 'D';
	fname[1] = ':';
	
	while (i < 16) {

		fname[i] = inbyte();
		
		if (fname[i] == 0) break;
		if (fname[i] == 0x0A) {
			fname[i] = 0;
			break;
		}
		i++;
	}
	
	printf("receiving file: '%s'\n", fname);
	
	f = fopen(fname, "wb");
	if (f == NULL) {
		outbyte('E');
		printf("error: %d\n", errno);
	} else {
		bytes = 1;
		while (bytes != 0) {
			
			//for (i = 0; i < 100; i++);
			
			outbyte('A');
			
			for (i = 0; i < 3; i++) {
				c[i] = inbyte();
			}

			c[3] = 0;
			
			bytes = atoi(c);
			//printf("receiving bytes: %s %d\n", c, bytes);
			outbyte('A');
			
			for (i = 0; i < bytes; i++) {
				buffer[i] = inbyte();
			}
			//printf("received \n");
			
			if (bytes) {
				fwrite(buffer, 1, bytes, f);
			}
			//printf("written \n");
		}
		fclose(f);
		outbyte('C');
	}
	
	return 1;
}

int sendFile() {
}

void server() {
	char c;
		
	c = 0;
	
	while (c != 'X') {
		printf("R - receive file\n");
		printf("S - send file\n");
		printf("X - exit\n");
		
		c = inbyte();
		if (c == 'R') {
			receiveFile();
		}
		if (c == 'S') {
			sendFile();
		}
	}
	
}

int main(int argc, char **argv) {
	
	int rc;
	
    fd2iocb[0] = 0;
    fd2iocb[1] = 0;
    fd2iocb[2] = 0;
    fd2iocb[3] = 0xff;
    fd2iocb[4] = 0xff;
    fd2iocb[5] = 0xff;
    fd2iocb[6] = 0xff;
    fd2iocb[7] = 0xff;
	
	server();
	return 0;
}