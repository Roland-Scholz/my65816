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

int inflate(char *inBuf, char *outBuf, long *outLen);

char* loadFile(char *fname, long *flenout) {
	FILE *fin;
	size_t flen;
	struct stat st;
	char *buf;
	
	if (stat(fname, &st) == -1) {
		return NULL;
	}
	*flenout = st.st_size;
	
	fin = fopen(fname, "rb");
	
	if (fin == NULL) {
		printf("can't read file %s\n", fname);
		return NULL;
	}
	
//	vbuf = malloc(1024);
//	setvbuf(fin, vbuf, _IOFBF, 1024);

	buf = malloc(st.st_size);
	//printf("loading %s, length: %lu\n", fname, st.st_size);
	
	flen = fread(buf, 1, st.st_size, fin);
	
	//printf("%lu bytes loaded @ %p\n", flen, buf);
	
	fclose(fin);
	
	return buf;
}

int gunzip(char *comprData, long flen) {
	int flag, rc;
	char *inBuf;
	char *filename, *outBuf, *vbuf;
	long *origLen, outLen;
	FILE *fout;
	
	filename = NULL;
	
	if (! (comprData[0] == 0x1f && comprData[1] == 0x8b)) {
		return -1;
	}
	
	/*
		bit 0   FTEXT
		bit 1   FHCRC
		bit 2   FEXTRA
		bit 3   FNAME
		bit 4   FCOMMENT
	*/	   
	flag = comprData[3];
	//printf("flag: %d\n", flag);
		
	inBuf = comprData+10;
	
	//skip comment
	if (flag & 0x10) {
		while(*inBuf++);
	}
	//skip filename
	if (flag & 0x08) {
		filename = inBuf;
		while(*inBuf++);
	}
	if (flag & 0x02) {
		inBuf += 2;
	}

	if (filename)
		printf("filename: %s\n", filename);
	
	origLen = (long *)&(comprData[flen-4]);
	//printf("origLen: %lu\n", *origLen);
	
	outBuf = malloc(*origLen);
	//printf("inBuf: %p, outBuf: %p\n", inBuf, outBuf);
	
	rc = inflate(inBuf, outBuf, &outLen);
	//printf("rc:%d\n", rc);
	
	if (rc != 0) {
		printf("inflate: unsupported compression algorithm\n");
		return -1;
	}
	
	if (*origLen != outLen) {
		printf("error originalLength != outputLength (%lu != %lu)\n", *origLen, outLen);
		return -1;
	}

	if (filename) {
		filename = adjustFilename(filename, 0);
		
		fout = fopen(filename, "wb");
		//vbuf = malloc(1024);
		//setvbuf(fout, vbuf, _IOFBF, 1024);
		if (fout) {
			fwrite(outBuf, 1, *origLen, fout);
			fclose(fout);
		}
	}
	return 0;
}

int main(int argc, char **argv) {
	char *fname;
	char *comprData;
	int rc;
	long flen;
	
	if (argc < 2) {
		fname = adjustFilename("z*.gz", 0);
		//printf("png <filename.png>\n");
		//return 0;
	} else {
		fname = adjustFilename(argv[1], 0);
	}
	
	comprData = loadFile(fname, &flen);
	
	if (comprData) {
		rc = gunzip(comprData, flen);
		//printf("rc=%d\n", rc);
	}
}
