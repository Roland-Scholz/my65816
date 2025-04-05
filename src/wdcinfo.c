#include <stdio.h>

void *heap_start = (void * )0x010000, *heap_end = (void * )0x01ffff;

int close(int fd) {
    return 0;
}

int isatty(int i) {
	return 1;
}

void writec(char c) {
#asm 
	sep #$20
	lda %%c
	sta $d800
	rep #$20; 
#endasm
}

size_t write(int fd, void* buf, size_t len) {
	char *b = (char *)buf;
	for(;len > 0; len--) {
		writec(*b);
		b++;
	}
	return 1;	
}

size_t read(int fd, void* buf, size_t len) {	
	unsigned char rc;
	size_t size;
	
    size = 1;
	
	return size;	
}

int unlink(const char *pathname) {
}

long lseek(int fd, long offset, int whence) {
	//debugf("lseek fd:%d, offset:%d, whence:%d off_t:%d\n", (long)fd, offset, (long)whence, (long)sizeof(off_t));

	//printf("lseek: fd:%d, offset: %lu, whence %d\n", fd, offset, whence);
	return 0;
}


void main() {
    printf("Hallo Welt!\n");
}