#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include "homebrew.h"


static int loop;
static int open;
static char rs232[] = "R:";

static char iorc;
static char s[80];
static char cmdStr[80];
static char buf[512];

void error(char *str, char iorc) {
	sprintf(s, "%s %s (%d) \n", str, getErrorString(iorc), iorc);
	putrec(0, s);
}
	
void doCommand() {
	char *fname;
	char *integer;
	unsigned int flength;
	unsigned int len;
	
	if (!memcmp(cmdStr, "close", 5)) {
		
		aclose(2);
		open = false;
		return;
	}
	
	if (!memcmp(cmdStr, "open", 4)) {
		
		fname = &(cmdStr[5]);
		integer = fname;
		while (*integer != ' ') {
			integer++;
		}
		*integer = 0;
		integer++;
		
		flength = atoi(integer);
		
		sprintf(s, "\nopen %s length: %d\n", fname, flength);
		putchr(0, s, strlen(s));
		
		iorc = aopen(2, fname, 8, 0);
		if (iorc != 1) {
			putchr(1, "ERROR", 5);
			error(fname, iorc);
			flength = 0;
		}

		putchr(1, "OK", 2);
		
		len = 512;

		while(flength) {
			//sprintf(s, "flength: %d\n", flength);
			//putrec(0, s);
			
			if (len > flength) {
				len = flength;
			}
			getchr(1, buf, len);
			putchr(2, buf, len);
			flength -= len;
		}
		
		aclose(2);
		
		return;
	}
	
	if (!memcmp(cmdStr, "exit", 4)) {
		loop = false;
		return;
	}
}

int main(int argc, char **argv) {
	char iorc;
	
	iorc = aopen(1, rs232, 12, 0);
	if (iorc != 1) {
		error(rs232, iorc);
	}
	
	loop = true;
	open = false;
	
	while (loop) {
		getrec(1, cmdStr);
		
		doCommand();
	}
	
	aclose(1);
	aclose(2);
}