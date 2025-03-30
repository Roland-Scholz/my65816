#include <stdio.h>
#include <stdbool.h>
#include <fcntl.h>
#include "homebrew.h"

char getFreeIocb() {
	char *p = IOCBSTRT;
	char i;
	
	for(i = 0; i < 8; i++, p += 16) {
		if (*p == 0xff) break;
	}

	return i;
}


int isatty(int fd) {
	
/*	
	strcpy(s, "isatty:                   ");
	hex4(s+8, fd);
	hex(s+13, c2iocb[fd].isatty);
	
	s[15] = '\n';
	putrec(0, s);
*/	
	return c2iocb[fd].isatty;
}

int creat(const char *_name, int _mode) {
	
//	sprintf(s, "creat %04X %d\n", _name, _mode);
//	putrec(0, s);
	
	return true;
}

size_t read(int fd, void *p, size_t len) {
	
	size_t len0, len1;
	char iocb = c2iocb[fd].iocb;
	
	
	if (c2iocb[fd].isatty) {
		len = 1;
	}

	getchr(iocb, p, len);

/*
	len0 = ZIOCB.buflen;
	len1 = (&IOCB)[iocb].buflen;
	
	memset(debug, 32, 32);
	strcpy (debug, "read");
	hex4(debug+6, fd);
	hex4(debug+11, (unsigned int)(p));
	hex4(debug+16, (unsigned int)(len));
	hex4(debug+21, (unsigned int)(len0));
	hex4(debug+26, (unsigned int)(len1));
	debug[30] = '\n';
	
	putrec(0, debug);
*/
	
	return (&IOCB)[iocb].buflen;
}


int unlink(const char *p) {
	
//	sprintf(s, "unlink %04X\n", p);
//	putrec(0, s);
	
	return true;
}

size_t write(int fd, void *p, size_t len) {
	
	/*
	memset(s, 0, 32);
	strcpy (s, "write ");
	hex4(s+6, fd);
	hex4(s+11, (unsigned int)(p));
	hex4(s+16, (unsigned int) (len));
	s[20] = '\n',
	*/
	putchr(c2iocb[fd].iocb, p, len);
	
	return len;
}

long lseek(int i, long j, int k) {
	
//	sprintf(s, "lseek %d %d %d\n", i, j, k);
//	putrec(0, s);

	return true;
}

int close(int fd) {
	
	if (fd > 2) aclose(c2iocb[fd].iocb);
		
	return 0;
}


int open(const char *fname, int mode) {
	char iorc;
	char iocb;
	char isatty;
	char *piob;
	int fd;
	
	piob = _getiob();
	fd = (piob - (char *) (_iob)) / 14;
	
	isatty = false;
	if (*fname == 'E' || *fname == 'R' || *fname == 'K') isatty = true;
	
	switch(fd) {
		case 0:
			iocb = 7;
			break;
		case 1:
		case 2:
			iocb = 0;
			break;
		default:
			iocb = getFreeIocb();
			if (iocb >= 8) return -1;
	}
	
	if (fd != 0 && fd != 2) {
		aclose(iocb);
		iorc = aopen(iocb, (char *)fname, 12, 0);
		if (iorc >= 128) return -1;	
	}

/*
	sprintf(s, "open: %s mode:%d fd:%04X iob: %04X iocb: %02X\n", fname, mode, fd, piob, iocb);	
	putrec(0, s);
*/

	c2iocb[fd].iocb = iocb;
	c2iocb[fd].isatty = isatty;
	
	return fd;
}


char* getErrorString(char iorc) {
	switch (iorc) {
		case SUCCES: return "successful operation";
		case BRKABT: return "BREAK key abort";                   
		case PRVOPN: return "IOCB already open error"; 			
		case NONDEV: return "nonexistent device error"; 			
		case WRONLY: return "IOCB opened for write only error"; 		
		case NVALID: return "invalid command error"; 			
		case NOTOPN: return "device/file not open error"; 			
		case BADIOC: return "invalid IOCB index error"; 			
		case RDONLY: return "IOCB opened for read only error"; 		
		case EOFERR: return "end of file error"; 			
		case TRNRCD: return "truncated record error"; 			
		case TIMOUT: return "peripheral device timeout error"; 		
		case DNACK : return "device does not acknowledge command error"; 
		case FRMERR: return "serial bus framing error"; 			
		case CRSROR: return "cursor overrange error"; 			
		case OVRRUN: return "serial bus data overrun error"; 		
		case CHKERR: return "serial bus checksum error"; 			
		case DERROR: return "device done (operation incomplete) error"; 
		case BADMOD: return "bad screen mode number error"; 		
		case FNCNOT: return "function not implemented in handler error"; 
		case SCRMEM: return "insufficient memory for screen mode error"; 
		case NOTFND: return "file or directory not found";		
		default:     return "unknown error";
	}
}

void printErr(char iorc) {
	char *s = getErrorString(iorc);
	putchr(0, s, strlen(s));
}
