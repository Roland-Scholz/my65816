#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include "homebrew.h"

static char iorc, s[80], dir[30];
static char prefix[] = "D:";
static char nl[] = "\n";

void toUpper(char s[]) {
	
	while (*s != 0) {
		if (*s >= 'a' && *s <= 'z') *s -= 32;
		s++;
	}
	
	return;
}

char changeDir(char channel, char *path) {

	char *p;
	
	while (*path != 0) {
		p = strstr(path+1, "/");
	
		if (p != NULL) {
			*p = 0;
		}

		strcpy(dir, prefix);
		strcat(dir, path);
		strcat(dir, nl);
		toUpper(dir);

//		putrec(0, dir);
		
		iorc = callCIOV(channel, IOCB_CHDIR_MYDOS, dir, 80);
		
		if (p == NULL || iorc >= 128) break;
		path = p+1;
	}
		
	return iorc;
}

char loadExec(char *dir) {
	
	char *start, *end, loop = true; 
	int len;


//	Open the file in the current directory	
//
	iorc = aopen(1, dir, 4, 0);
	if (iorc != 1) return iorc;

	
//	Read first 2 bytes and check for 0xFFFF, if not, error
//
	iorc = getchr(1, &start, 2);
	if (iorc != SUCCES) return iorc;
	if (start != (char *)(0xffff)) return BRKABT;


//	Read datachunks optionally preceded by 0xFFFF
//	1st 2-bytes = start address
//	2nd 2-bytes = end address
//	
	while (loop) {
	
		iorc = getchr(1, &start, 4);
		if (iorc != SUCCES) {
			if (iorc == EOFERR) iorc = SUCCES;
			break;
		}
		
		if (start == (char *)(0xffff)) {
			start = end;
			iorc = getchr(1, &end, 2);
			if (iorc != SUCCES) break;

		}
		
		len = (int)(end - start) + 1;

		
		sprintf(s, "%04X %04X %04X\n", start, end, len);
		putrec(0, s);
		
		

		iorc = getchr(1, start, len);
		if (iorc != SUCCES) break;
	}
	
	aclose(1);

	return iorc;
}

void getCommandLine() {
	putchr(0, "\n", 1);
	putchr(0, ">", 1);
	
	memset(FNAME, 0, 128);
	getrec(0, FNAME);
}

void executeCommand() {

	int olddir = DIRCLUS;
	int len;
	char *p;
	
	iorc = changeDir(1, "/DOS\n");
	if (iorc != 1) {
		printErr(iorc);
		return;
	}	
	
	len = strlen(FNAME);
	p = strstr(FNAME, " ");
	if (p == NULL) p = strstr(FNAME, "\n");
	if (p == NULL) return;
	*p = 0;
/*	
	parms(FNAME);
*/
	
	strcpy(dir, prefix);
	strcat(dir, FNAME);
	strcat(dir, nl);	
	toUpper(dir);
	
	iorc = loadExec(dir);
	
	DIRCLUS = olddir;
	
	if (iorc != 1) {
		strcpy(dir, prefix);
		strcat(dir, FNAME);
 		sprintf(s, "%s %s (%d)", dir, getErrorString(iorc), iorc);
		putrec(0, s);
	} else {
		(FNAME)[len-1] = '\n';
#asm
		ldx #0
		sep #$30
		jsr ($025a,x)
		rep #$30
#endasm
	}
	
}

int main(int argc, char **argv) {
	
	int olddir;

	while (true) {
		getCommandLine();
		
		if (! strcmp(FNAME, "exit\n")) break;
		
		executeCommand();		
	}
}