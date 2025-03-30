#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <dirent.h>
#include <sys/stat.h>

#include "FreeRTOS.h"
#include "task.h"
#include "semphr.h"
#include "homebrew.h"

#define O_RDONLY	     00
#define O_WRONLY	     01
#define O_RDWR		     02
#define O_CREAT		   0100	/* not fcntl */
#define O_APPEND	  02000


DIR dir_fd[8];
struct dirent dirent[8];
//char path[80];

union iocb {
	struct {
		unsigned int iocbLo;
		unsigned int iocbHi;
	} iocbWord;
	iocb_t *iocb;
};

/*
union ptrconv {
	struct {
		unsigned int ptr16;
		unsigned char ptrBank;
		unsigned char ptrUnused;
	} adrBank;
	void *ptr;
	size_t ul;
};
typedef union ptrconv ptrconv_t;
*/

typedef union iocb iocb_ut;

unsigned char fd2iocb[8];
SemaphoreHandle_t iocbSemaphore;

char getFreeIocb() {
	char *p = IOCBSTRT;
	unsigned int i;
	
	for(i = 0; i < 8; i++, p += 16) {
		if (*p == 0xff) break;
	}

	return i;
}

unsigned char callCIO(char channel, char cmd, char *buffer, size_t len, char aux1, char aux2) {
	iocb_ut iocb;
	ptrconv_t p;
	char status;
	
	
	iocb.iocbWord.iocbHi = 0;
	iocb.iocbWord.iocbLo = channel << 4;
#asm 
	tax
#endasm
	iocb.iocbWord.iocbLo += (unsigned int)(0x0280);

	if (cmd == IOCB_OPEN) {
		iocb.iocb->aux1 = aux1;
		iocb.iocb->aux2 = aux2;	
	} 
	//else if (cmd == IOCB_CLOSE && !iocb.iocb->handler) {
	//	return SUCCES;
	//}
	
	iocb.iocb->command = cmd;
	
	p.ptr = buffer;
	iocb.iocb->buffer = p.adrBank.ptr16;
	iocb.iocb->bufferBank = p.adrBank.ptrBank;
	
	p.ul = len;
	iocb.iocb->buflen = p.adrBank.ptr16;
	iocb.iocb->buflenBank = p.adrBank.ptrBank;
	
#asm
	jsl $C021
#endasm
	errno = 0;
	status = iocb.iocb->status;
	
	if (status != 1) errno = ENOENT;
	
	/*
	if (cmd == IOCB_GETCHR) {
		printf("IOCB:%d, buffer:%p, cmd:%d, rc:%d \n", channel, buffer, cmd, iocb.iocb->status);
	}
	*/
		
	return status;
}

unsigned char aclose(char channel) {
	return callCIO(channel, IOCB_CLOSE, NULL, 0ul, 0, 0);	
}

unsigned char agetrec(char channel, char *buffer) {
	return callCIO(channel, IOCB_GETREC, buffer, 256ul, 0, 0);	
}

unsigned char aputrec(char channel, char *buffer) {
	return callCIO(channel, IOCB_PUTREC, buffer, 256ul, 0, 0);	
}

unsigned char agetchr(char channel, char *buffer, size_t len) {
	return callCIO(channel, IOCB_GETCHR, buffer, len, 0, 0);	
}

unsigned char aputchr(char channel, char *buffer, size_t len) {
	return callCIO(channel, IOCB_PUTCHR, buffer, len, 0, 0);	
}

unsigned char aopen(unsigned char channel, char *buffer, char aux1, char aux2) {
	return callCIO(channel, IOCB_OPEN, buffer, 256ul, aux1, aux2);	
}

unsigned char achdir(unsigned char channel, char *buffer) {
	return callCIO(channel, IOCB_CHDIR_MYDOS, buffer, 0, 0, 0);	
}

unsigned char astat(unsigned char channel, struct stat *buffer) {
	return callCIO(channel, IOCB_STAT, (char *)buffer, sizeof(struct stat), 0, 0);	
}

ssize_t returnSize(int fd, int rc) {
	iocb_ut iocb;
	ptrconv_t p;
	
	if (rc != SUCCES && rc != EOFERR)
		return -1;

	iocb.iocbWord.iocbHi = 0;
	iocb.iocbWord.iocbLo = (fd2iocb[fd] << 4) + 0x280;
	p.adrBank.ptr16 = iocb.iocb->buflen;
	p.adrBank.ptrBank = iocb.iocb->buflenBank;
	p.adrBank.ptrUnused = 0;

	return p.ul;	
}

ssize_t write(int fd, const void* buf, size_t len) {
	unsigned char rc;
	ssize_t size;
	
	//debugf("write fd:%d, buf:%08X, len: %d, iocb %d\n", (long)fd, buf, len, (long)fd2iocb[fd]);
	
	xSemaphoreTake( iocbSemaphore , portMAX_DELAY);
	
	rc = aputchr(fd2iocb[fd], (char *)buf, len);
	
	size = returnSize(fd, rc);
	
	xSemaphoreGive( iocbSemaphore );
	
	//debugf("write fd %d, size: %08X\n", (long)fd, size);
	
	return size;	
}

ssize_t read(int fd, const void* buf, size_t len) {	
	unsigned char rc;
	ssize_t size;
	
	//debugf("read fd:%d, buf:%08X, len: %d, iocb %d\n", (long)fd, buf, len, (long)fd2iocb[fd]);
	
	xSemaphoreTake( iocbSemaphore , portMAX_DELAY);
	
	rc = agetchr(fd2iocb[fd], (char *)buf, len);
		
	size = returnSize(fd, rc);
	
	xSemaphoreGive( iocbSemaphore );
	
	//debugf("read size: %08X\n", size);
	
	return size;	
}


int ioctl(int fd, long reqs, void *term) {
	return 0;
}

int fstat(int fd, struct stat *buf) {
	int rc;
	
	//rc = astat(fd2iocb[fd], buf);
	
	//if (rc >= 128) rc = -1;
	//else rc = 0;
	rc = 0;
	return rc;
}

int close(int fd) {
	xSemaphoreTake( iocbSemaphore , portMAX_DELAY);

	//debugf("close fd:%d\n", (long)fd);
	
	aclose(fd2iocb[fd]);
	fd2iocb[fd] = 0xff;
	
	xSemaphoreGive( iocbSemaphore );
	
	return 0;
}


int open(int parmbytes, const char *path, int flags, int permissions) {
	unsigned int fd;
	unsigned char iocb, rc, mode;
	//char hex[5];
	
	//aputchr(0, (char *)path, strlen(path));
	//sprintf(hex, "%04X", flags);
	//aputchr(0, hex, sizeof(hex));
	//aputchr(0, "\n", 1ul);

/*
	if (*path == 'W') {
		return w_open(path+2, flags);
	}
*/	
	xSemaphoreTake( iocbSemaphore , portMAX_DELAY);
	
	for(fd = 0; fd < 8; fd++) {
		if (fd2iocb[fd] >= 8) break;
	}
	
	//debugf("open fd:%d \n", (size_t)fd);
	
	if (fd >= 8) {
		fd = -1; 
		goto open_exit;
	}
		
	iocb = getFreeIocb();
	if (iocb >= 8) {
		fd = -1; 
		goto open_exit;
	}
	
	//debugf("open iocb:%d \n", (size_t)iocb);
	
	mode = 0;
	if ((flags & (O_RDONLY | O_RDWR)) || !flags) mode += 4;
	if (flags & (O_WRONLY | O_CREAT | O_RDWR)) mode += 8;
	if (flags & O_APPEND) mode += 1;
	
	//sprintf(hex, "%04X", mode);
	//aputchr(0, hex, sizeof(hex));
	//aputchr(0, "\n", 1ul);

	//debugf("open, before aopen\n");
	//dump((char *)0x500, 256, 0);
	rc = aopen(iocb, (char *)path, mode, 0);

	//debugf("open fd:%d, iocb:%d, rc:%d \n", (size_t)fd, (size_t)iocb, (size_t)rc);
	//dump((char *)0x500, 256, 0);
	//debugf("\n");
	
	if (rc >= 128) {
		aclose(iocb);
		fd2iocb[fd] = 0xff;
		fd = -1;
		goto open_exit;
	}	
	
	fd2iocb[fd] = iocb;
	
open_exit:
	xSemaphoreGive( iocbSemaphore );
	
	return fd;
}

int stat(const char *filename, struct stat *buf) {
	int fd, rc;
	
	buf->st_size = 0;
	
	fd = open(0, filename, O_RDONLY, 0);
	
	if (fd == -1) {
		rc = -1;
		goto stat_exit;
	}

	//debugf("stat before aopen\n");
	//dump((char *)0x500, 256, 0);
	
	xSemaphoreTake( iocbSemaphore , portMAX_DELAY);
	rc = astat(fd2iocb[fd], buf);
	xSemaphoreGive( iocbSemaphore );
	
	//debugf("stat iocb:%d \n", (size_t)fd2iocb[fd]);
	//debugf("stat fd: %d, rc: %d\n", (long)fd, (long)rc);

	if (rc >= 128) rc = -1;
	
stat_exit:
	//debugf("stat before close\n");
	//dump((char *)0x500, 256, 0);
	
	if (!(rc == -1)) 
		close(fd);
	
	//debugf("stat fd: %d, rc: %d\n", (long)fd, (long)rc);
	//dump((char *)0x500, 256, 0);
	
	return rc;
}

int lseek(int fd, off_t offset, int whence) {
	debugf("lseek fd:%d, offset:%d, whence:%d off_t:%d\n", (long)fd, offset, (long)whence, (long)sizeof(off_t));

	//printf("lseek: fd:%d, offset: %lu, whence %d\n", fd, offset, whence);
	return 0;
}


int unlink(const char *pathname) {
}

int ftruncate(int fd, off_t length) {
}

static void prependDevname(char *s) {
	
	if (!(s[0] == 'D' && s[1] == ':')) {
		memmove(s+2, s, strlen(s)+1);
		s[0] = 'D';
		s[1] = ':';
	}
}

static int chOneDir(const char *s) {
	unsigned int i;
	unsigned int len;
	unsigned char iocb;
	char s0[16];
	int rc;
	
	xSemaphoreTake( iocbSemaphore , portMAX_DELAY);

	len = strlen(s);
	//int_rc = 0;
	
	if (len > 0) {
		strcpy(s0, s);
		strupper(s0);
	
		s0[len] = '\n';
		s0[len+1] = 0;

		prependDevname(s0);
		iocb = getFreeIocb();
		if (iocb < 8) {
			rc = achdir(iocb, s0);
		}

		if (iocb >= 8 || rc >= 128) {
			rc = -1;
		}
	}

	xSemaphoreGive( iocbSemaphore );
	
	return rc;
}

int chdir(const char *path) {
	
	char *p, *p0, *pSave;
	int end = 0;
	int rc;
		
	p = pSave = strdup(path);
	
	rc = -1;
	
	if (*p == '/'){
		rc = chOneDir("/");
		p++;
	}
	
	for(p0 = p; !end; p0++) {
		if (*p0 == 0) end = 1;
		
		if (*p0 == '/' || *p0 == 0) {
			*p0 = 0;
			rc = chOneDir(p);
			if (rc == -1) break;
			p = p0 + 1;
		}
	}		
	
	free(pSave);
	
	return rc;
}

DIR *opendir(const char *path) {
	unsigned int fd;
	unsigned char iocb, rc;
	DIR *dfd;
	unsigned char *p;

	xSemaphoreTake( iocbSemaphore , portMAX_DELAY);

	dfd == NULL;
	
	for(fd = 0; fd < 8; fd++) {
		if (fd2iocb[fd] >= 8) break;
	}
	
	//debugf("opendir fd:%d \n", (size_t)fd);
	
	if (fd >= 8) goto opendir_exit;
	
	iocb = getFreeIocb();
	if (iocb >= 8) goto opendir_exit;

	//debugf("opendir iocb:%d \n", (size_t)iocb);

	//p = calloc(1, strlen(path) + 10);
	p = malloc(strlen(path) + 10);
	*p = 0;
	
	if (path[0] != 'D' || path[1] != ':') {
		strcpy(p, "D:");
	}
	
	strcat(p, path);
	//strupper(p);

	rc = aopen(iocb, p, 6, 0);
	free(p);

	//debugf("opendir rc:%d \n", (size_t)rc);
	
	if (rc >= 128) {
		xSemaphoreGive( iocbSemaphore );
		close(fd);
		return NULL;
	}	
	
	fd2iocb[fd] = iocb;

	dir_fd[fd] = fd;
	dfd = &dir_fd[fd];

opendir_exit:
	xSemaphoreGive( iocbSemaphore );
	return dfd;
}

int closedir (DIR *__dirp) {
	close(__dirp->fd);
}

struct dirent *readdir (DIR *__dirp) {
	struct dirent *d;
	unsigned char rc;
		
	xSemaphoreTake( iocbSemaphore , portMAX_DELAY);
	
	d = &dirent[__dirp->fd];
	memset(d->d_name, 0, sizeof(d->d_name));
	//strcpy(d->d_name, "TEST");
	//*(d->d_name) = 0;
	
	//printf("readdir calling...\n", rc);
	
	rc = agetrec(fd2iocb[__dirp->fd], d->d_name);
	
	//printf("readdir rc: %d\n", rc);
		
	if (rc >= 128) {
		xSemaphoreGive( iocbSemaphore );
		close(__dirp->fd);
		return NULL;
	}
	
	d->d_reclen = strlen(d->d_name);
	
	xSemaphoreGive( iocbSemaphore );
		
	return d;
}