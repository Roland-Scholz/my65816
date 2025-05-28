#include <stdio.h>
#include <stdlib.h>
#include "FreeRTOS.h"

typedef struct A_BLOCK_LINK
{
    struct A_BLOCK_LINK * pxNextFreeBlock; /**< The next free block in the list. */
    uint32_t xBlockSize;                     /**< The size of the free block. */
} BlockLink_t;

void *ucHeap = (void *)0x010000;

//void *far_heap_start = (void * )0x030000, *far_heap_end = (void * )0x04ffff;

void do_main();


void main() {
	#asm
		php
		rep #$30
	#endasm
		do_main();
	#asm
		plp
		rtl
	#endasm
}

void xTaskResumeAll( ) {
}

void vTaskSuspendAll( ) {
}

/*
void *malloc (uint32_t size) {
	pvPortMalloc(size);
}*/

int close(int fd) {
    return 0;
}

/*
int isatty(int i) {
	return 1;
}*/

void writec(char c) {
#asm 
	sep #$20
	lda %%c
	sta $d800
	rep #$20 
#endasm
}

void nibble(char c) {
	c += '0';
	if (c > '9') c += 7;
	writec(c);
}

void byte2hex(char c) {
	nibble(c >> 4);
	nibble(c & 15);

}

void debug(void *p) {

	char *p0 = (char *)&p;
	uint16_t i;

	p0 +=3;
	for (i = 0; i < 4; i++) {
		byte2hex(*p0);
		p0--;
	}
	writec('\n');
}

/*
int open(const char * _name, int _mode) {
	printf("open: %s,mode: %d \n", _name, _mode);
}
*/


size_t write(int fd, void* buf, size_t len) {
	char *b = (char *)buf;
	
	//writec('W');

	for(;len > 0; len--) {
		writec(*b);
		b++;
	}
	return 1;	
}


char readc() {
#asm
	sep #$20
	lda $d900
	rep #$20
	and #$00ff
#endasm 
}

size_t read(int fd, void* buf, size_t len) {	
	char *b = (char *)buf;
	size_t size;

	for (size = 0; len > 0; len--) {
		*b = readc();
		b++;
		size++;
	}

	return size;	
}

int unlink(const char *pathname) {
}

long lseek(int fd, long offset, int whence) {
	//debugf("lseek fd:%d, offset:%d, whence:%d off_t:%d\n", (long)fd, offset, (long)whence, (long)sizeof(off_t));

	//printf("lseek: fd:%d, offset: %lu, whence %d\n", fd, offset, whence);
	return 0;
}

void *get_beg_udata() {
	#asm
		xref _BEG_UDATA
		ldx #^_BEG_UDATA
		lda #<_BEG_UDATA
	#endasm
	}
	
void *get_beg_data() {
#asm
	xref _BEG_DATA
	ldx #^_BEG_DATA
	lda #<_BEG_DATA
#endasm
}

void *get_beg_code() {
	#asm
		xref _BEG_CODE
		ldx #^_BEG_CODE
		lda #<_BEG_CODE
	#endasm
	}
	
/*
void print_iobs() {
	unsigned int i;
	FILE *io;
	
	io = _iob;

	for (i = 0; i < 10; i++) {
		printf("iob: %d %p\n", i, io);
		printf("io->_bp      :%p\n", io->_bp);
		printf("io->_bend    :%p\n", io->_bend);
		printf("io->_buff    :%p\n", io->_buff);
		printf("io->_flags   :%d\n", io->_flags);
		printf("io->_unit    :%d\n", io->_unit);
		printf("io->_bytebuf :%c\n", io->_bytbuf);
		printf("io->_buflen  :%d\n", io->_buflen);
		printf("io->_tmpnum  :%d\n", io->_tmpnum);
		printf("\n\n");
		io++;
	}
}
*/

void printHeapStats() {
	HeapStats_t hs;
	vPortGetHeapStats(&hs);
	
	printf("xSizeOfLargestFreeBlockInBytes : %lu\n", hs.xSizeOfLargestFreeBlockInBytes);
	printf("xSizeOfSmallestFreeBlockInBytes: %lu\n", hs.xSizeOfSmallestFreeBlockInBytes);
	printf("xNumberOfFreeBlocks            : %lu\n", hs.xNumberOfFreeBlocks);
	printf("xMinimumEverFreeBytesRemaining : %lu\n", hs.xMinimumEverFreeBytesRemaining);
	printf("xNumberOfSuccessfulAllocations : %lu\n", hs.xNumberOfSuccessfulAllocations);
	printf("xNumberOfSuccessfulFrees       : %lu\n", hs.xNumberOfSuccessfulFrees);
	
}

void do_main() {
	char *ptr;
	char c;
	FILE *f;

	
	setvbuf(stdin, NULL, _IONBF, 0);
	setvbuf(stdout, NULL, _IONBF, 0);
	setvbuf(stderr, NULL, _IONBF, 0);

	
	printf("\n");
	printf("Hallo Welt!\n");	
//printf(stderr, "Hallo Welt!\n");	

	printf("Begin Code : %p\n", get_beg_code());
	printf("Begin Data : %p\n", get_beg_data());
	printf("Begin UData: %p\n", get_beg_udata());
	printf("length size_t: %d\n", sizeof(size_t));
	printf("length portPOINTER_SIZE_TYPE: %d\n", sizeof(portPOINTER_SIZE_TYPE));
	printf("configTOTAL_HEAP_SIZE %p\n", (void *)configTOTAL_HEAP_SIZE);
	printf("length BlockLink_t %d\n", sizeof(BlockLink_t));
	printf("length uint32_t %d\n", sizeof(uint32_t));
	printf("length ptr      %d\n", sizeof(ptr));

	ptr = (void *) 0xcafebabe;
	debug(ptr);

	heapInit();
/*	
	for(;;) {
//		c = getchar();
//		ptr = malloc(4*1024);
//		if (c == 'x') break;
		ptr = malloc(4*1024);
		printf("ptr        : %p\n", ptr);
		printHeapStats();
		ptr = malloc(4*1024);
		printf("ptr        : %p\n", ptr);
		printHeapStats();
		break;
		if (ptr == NULL) break;
	}
*/
//	print_iobs();

}