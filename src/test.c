#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <errno.h>
#include <unistd.h>
#include <dirent.h>
#include <sys/stat.h>

#include "freeRTOS.h"
#include "task.h"
#include <homebrew.h>

int main(int argc, char **argv) {

	unsigned int uix, uiy;
	int ix, iy;
	unsigned long ulx, uly;
	long lx, ly;
	
	int  iret;
	long ret;
	
	ix = -1;
	iy = -1;
	uix = 2;
	uiy = 2;
	
	ly = 5;
	
	printf("ix * iy = %d\n", ix * iy);
	printf("uix * uiy = %d\n", uix * uiy);
	printf("uix * iy = %d\n", uix * iy);
		
	printf("17 * ly: %lu\n", 17 * ly);
	printf("ly << 5: %d\n", ly << 5);
}
