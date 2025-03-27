#include <stdio.h>
#include <dietstdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <unistd.h>
#include <dirent.h>
#include "FreeRTOS.h"
#include "task.h"
#include "semphr.h"
#include <homebrew.h>

typedef struct A_BLOCK_LINK
{
	struct A_BLOCK_LINK *pxNextFreeBlock;	/*<< The next free block in the list. */
	unsigned long xBlockSize;						/*<< The size of the free block. */
} BlockLink_t;

extern BlockLink_t xStart;
extern BlockLink_t *pxEnd, *pxEnd16;
extern SemaphoreHandle_t iocbSemaphore;

unsigned char *ucHeap16 = (unsigned char *)0x001000;
unsigned char *ucHeap = (unsigned char *)0x020000;
extern unsigned char fd2iocb[8];


static char s[80];
static r816Header_t header;
static symbol_t *symbols;
static char *base[5];

static char shellpath[80];
static char exepath[80] = "/";

static DIR dir_fd[8];
static struct dirent dirent[8];


/*
char* type2section(unsigned int type) {
	switch(type) {
	case 0:		return "PAGE0 ";		
	case 1:		return "CODE  ";
	case 2:		return "KDATA ";
	case 3:		return "DATA  ";
	case 4:		return "UDATA ";
	default:	return "UNKOWN";
	}
}
*/

/*
DIR *opendir(const char *path) {
	unsigned int fd;
	unsigned char iocb, rc;
	DIR *dfd;
	unsigned char *p;
	
	for(fd = 0; fd < 8; fd++) {
		if (fd2iocb[fd] >= 8) break;
	}
	
	debugf("opendir fd:%d \n", (size_t)fd);
	
	if (fd >= 8) return NULL;
	
	iocb = getFreeIocb();
	if (iocb >= 8) return NULL;

	debugf("opendir iocb:%d \n", (size_t)iocb);

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

	debugf("opendir rc:%d \n", (size_t)rc);
	
	if (rc >= 128) {
		close(fd);
		return NULL;
	}	
	
	fd2iocb[fd] = iocb;

	dir_fd[fd] = fd;
	dfd = &dir_fd[fd];
	
	return dfd;
}

int closedir (DIR *__dirp) {
	close(__dirp->fd);
}

struct dirent *readdir (DIR *__dirp) {
	struct dirent *d;
	unsigned char rc;
		
	d = &dirent[__dirp->fd];
	memset(d->d_name, 0, sizeof(d->d_name));
	//strcpy(d->d_name, "TEST");
	//*(d->d_name) = 0;
	
	printf("readdir calling...\n", rc);
	
	rc = agetrec(fd2iocb[__dirp->fd], d->d_name);
	
	printf("readdir rc: %d\n", rc);
		
	if (rc >= 128) {
		close(__dirp->fd);
		return NULL;
	}
	
	d->d_reclen = strlen(d->d_name);
		
	return d;
}
*/

void debugTaskControl(taskControl_t *tc) {
	debugf("taskControl     :\n");
	debugf("cmdLine         : %08X\n", tc->cmdLine);
	debugf("argc            : %04X\n", (long)tc->argc);
	debugf("argv            : %08X\n", tc->argv);
	debugf("callerTaskHandle: %08X\n", tc->callerTaskHandle);
	debugf("taskHandle      : %08X\n", tc->taskHandle);
	debugf("codePtr         : %08X\n", tc->codePtr);
	debugf("udataPtr        : %08X\n", tc->udataPtr);
	debugf("dataPtr         : %08X\n", tc->dataPtr);
	debugf("rc              : %04X\n", (long)tc->rc);
	debugf("heap            : %08X\n", tc->heap);
	debugf("heapNext        : %08X\n", tc->heapNext);
	debugf("heapAvailable   : %04X\n", (long)tc->heapAvailable);
	debugf("heapSize        : %04X\n", (long)tc->heapSize);
	debugf("background      : %04X\n", (long)tc->background);	
}

void printHeap(BlockLink_t *e, BlockLink_t *end) {
	for(;e != end;) {
		debugf("e: %08X, nextFreeBlock: %08X, length: %08X \n", e, e->pxNextFreeBlock, e->xBlockSize);
		e = (BlockLink_t *)((char *)e + (e->xBlockSize & 0x7fffffff));
	}
}	
void checkHeap(char *str) {
	debugf("%s\n", str);
	printHeap((BlockLink_t *)ucHeap16, pxEnd16);
	debugf("------------------------------------------------------\n");
	printHeap((BlockLink_t *)ucHeap, pxEnd);
}

void freetaskControl(taskControl_t *tc) {
	char **heapEntry;
	unsigned int i;
	
	heapEntry = tc->heap;
	if (heapEntry != NULL) {
		for (i = tc->heapSize; i != 0; i--, heapEntry++) {
			if (*heapEntry != NULL) {
				//debugf("nofree tc:%08X p:%08X\n", tc, *heapEntry);
				vPortFree(*heapEntry);
			}
		}
	}
	
	vPortFree(tc->cmdLine);
	vPortFree(tc->codePtr);
	vPortFree(tc->dataPtr);
	vPortFree(tc->argv);
	vPortFree(tc->heap);
	vPortFree(tc);
}

static void removeTask(taskControl_t *tc) {
	vTaskDelete(tc->taskHandle);
	freetaskControl(tc);	
}

static void removeTaskTask(void *tc) {
	removeTask((taskControl_t *) tc);
	vTaskDelete(NULL);
}

void vTaskRemove(taskControl_t *tc) {
	if (tc->background) {
		xTaskCreate(removeTaskTask, "remove", 256, tc, 0, NULL);
	} else {
		removeTask(tc);
		checkHeap("after");
	}
}


char *getShellpath() {
	return shellpath;
}

int hex2int(char c) {
	int val = -1;
	
	c = toupper(c);
	
	if (c >= '0' && c <= '9') {
		val = c - '0';
	}
	if (c >= 'A' && c <= 'F') {
		val = c - 'A' + 10;
	}
	
	return val;
}

size_t str2hex(char *s) {
	size_t val = 0;
	int i;
	
	while(*s != 0) {
		//printf("val: %l08X, %c\n", val, *s);

		i = hex2int(*s);
		
		if (i >= 0) {			
			val <<= 4;
			val += i;
		}
		
		s++;
	}

	return val;
}

void strupper(char *str) {
	while(*str != 0) {
		*str = toupper(*str);
		str++;
	}
}

static void formatLine(char* text, size_t data) {
	
	printf("%s: %l8X %l8d\n", text, data, data);
	
}


// R   8  1  6 : 65816 (magic number)
// ee ee ee ee : offset to __main (entry)
// cc cc cc cc : length of CODE section
// dd dd dd dd : length of DATA section
// ud ud ud ud : length of UDATA section
// sy sy sy sy : #entries of symbol table
// rl rl rl rl : #entries of expression table

static void evaluateExpression() {
	char *p, *p1;
	expression_t *ex;
	symbol_t *sym;
	int itemType, i, section, symNum;
	size_t value0, value1;
	
	ex = (expression_t *)s;

	value0 = value1 = 0;
	
	p = s + sizeof(expression_t);
	
	for(i = sizeof(expression_t)-1; i < ex->len;) {
		
		itemType = *p++;
		i++;
		
		//printf("start itemType:%02X value0:%l08X value1:%l08X\n", itemType, value0, value1);
		if (itemType >= 20) {
			
			//printf("op: %d\n", itemType);
			
			switch (itemType) {
				case OP_MUL:				
					value0 = value1 * value0;
					break;
				case OP_DIV:
					value0 = value1 / value0;
					break;
				case OP_MOD:
					value0 = value1 % value0;
					break;
				case OP_SHR:
					value0 = value1 >> value0;
					break;
				case OP_SHL:
					value0 = value1 << value0;
					break;
				case OP_ADD:
					value0 = value1 + value0;
					break;
				case OP_SUB:
					value0 = value1 - value0;
					break;
				case OP_AND:
					value0 = value1 & value0;
					break;
				case OP_OR:
					value0 = value1 | value0;
					break;
				case OP_XOR:
					value0 = value1 ^ value0;
					break;
				default:
					break;
			}
			
			//printf("end   itemType:%02X value0:%l08X value1:%l08X\n", itemType, value0, value1);
			continue;
		}
		
		value1 = value0;
		
		switch (itemType) {
			case OP_SYM:
				//printf("OP_SYM\n");
				symNum = *((unsigned int *)p);
				sym = &symbols[symNum];
				value0 = (size_t)(base[sym->section]) + sym->offset;
				
				i += 2;
				p += 2;
				
				//printf("Symbol #:%04X section:%02X offset:%l08X \n", symNum, sym->section, sym->offset);
				break;
			case OP_VAL:
				//printf("OP_VAL\n");
				value0 = *((size_t *)p);
				i += 4;
				p += 4;
				break;
			case OP_LOC:
				//printf("OP_LOC\n");

				section = *p++;
				i++;
				
				value0 = (size_t)(base[section]) + *((size_t *)p);				

				i += 4;
				p += 4;
				break;
			default:
				printf("Unknown itemType: %d\n", itemType);
		}		
		//printf("end   itemType:%02X value0:%l08X value1:%l08X\n", itemType, value0, value1);
	}

	p = (char *)(base[ex->tSection] + ex->tOffset);
	p1 = (char *)(&value0);
	
	//printf("tOffset:%l08X value: %l08X len:%08X ", p, value0, ex->codeLen);
	
	for(i = 0; i < ex->codeLen; i++) {
		//printf("%02X ", *p1);
		*p++ = *p1++;
	}
	//printf("\n");
	
	//getchar();
}
            
static void loadExec(char *filename, taskControl_t *taskControl) {
	
	ssize_t bRead;
	size_t cnt;
	size_t bytesMalloc;
	size_t bytes2Read;
	FILE *fin;
	int fno;
	
	//char *test;
	//char *ptr;
	
	taskControl->codePtr = NULL;
	taskControl->dataPtr = NULL;
	taskControl->udataPtr = NULL;
	
//	Open the file in the current directory	
//	printf("loading prog  : %s\n", filename);
	fin = fopen(filename, "rb");
	
	//printf("fopen pointer: %p \n", fin);
	if (fin == NULL) return;
	fno = fileno(fin);
		
//	Read header bytes and check for "R816", if not, error
//	bRead = fread (&header, 1, sizeof(r816Header_t), fin);
	bRead = read (fno, &header, sizeof(r816Header_t));
	if (bRead != sizeof(r816Header_t)) return;
	if (header.magic != 0x36313852) return;
	
//	printf("1\n");
	bytesMalloc = header.codeLen + header.uDataLen;
	taskControl->codePtr = (char *)malloc(bytesMalloc);
	if (taskControl->codePtr == NULL) return;
//	printf("2\n");

//  read CODE into memory
//	bRead = fread(taskControl->codePtr, 1, header.codeLen, fin);
	bRead = read(fno, taskControl->codePtr, header.codeLen);
	if (bRead != header.codeLen) return;
//	printf("3:%d \n", header.dataLen);

//  compute uDataBase
	taskControl->udataPtr = taskControl->codePtr + header.codeLen;

//	alloc memory for DATA
	if (header.dataLen) {
		taskControl->dataPtr = (char *)malloc(header.dataLen);
		if (taskControl->dataPtr == NULL) return;
		
//		bRead = fread(taskControl->dataPtr, 1, header.dataLen, fin);
		bRead = read(fno, taskControl->dataPtr, header.dataLen);
		if (bRead != header.dataLen) return;
	}
	
//	printf("4\n");
	
//  read DATA into memory

//	printf("5\n");

	base[SECT_PAGE0] = 0;
	base[SECT_CODE]  = taskControl->codePtr;
	base[SECT_KDATA] = 0;
	base[SECT_DATA]  = taskControl->dataPtr;
	base[SECT_UDATA] = taskControl->udataPtr;

	//printf("R816 loader\n");
	formatLine("Module base   ", (size_t)(taskControl->codePtr));
	formatLine("Data base     ", (size_t)(taskControl->dataPtr));
	formatLine("UData base    ", (size_t)(taskControl->udataPtr));
	formatLine("Offset to main", header.mainOffset);
	formatLine("Code length   ", header.codeLen);
	formatLine("Data length   ", header.dataLen);
	formatLine("UData length  ", header.uDataLen);
	formatLine("Total length  ", bytesMalloc);	
	formatLine("#symbols      ", header.numSymbols);	
	formatLine("#expressions  ", header.numExpressions);


	//load symbols into memory
	bytesMalloc = sizeof(symbol_t) * header.numSymbols;
	symbols = malloc(bytesMalloc);
//	fread(symbols, 1, bytesMalloc, fin);
	read(fno, symbols, bytesMalloc);
	
	//dump symbols
	/*
	for(cnt = 0; cnt < header.numSymbols; cnt++) {
		ptr = (char *)&symbols[cnt];
		for (i = 0; i < sizeof(symbol_t); i++) {
			printf("%02X ", *ptr++);
		}
		printf("\n");
	}
	getchar();
	*/
	
	//process expressions
	for (cnt = 0; cnt < header.numExpressions; cnt++) {
		bRead = fread(s, 1, 1, fin);
		bytes2Read = *s;
		bRead = fread(s+1, 1, bytes2Read, fin);
		
		/*
		for (i = 0; i <= bytes2Read; i++) {
			printf("%02X ", s[i]);
		}
		printf("\n");
		*/
		
		evaluateExpression();
		
		/*
		test = (char *)0x201f8;
		if (*test == 0) {
			printf("ex #%ld\n", cnt);
			getchar();
		}*/
	}
	
	//getchar();

	free(symbols);
	
	fclose(fin);
}

static void prependDevname(char *s) {
	
	if (!(s[0] == 'D' && s[1] == ':')) {
		memmove(s+2, s, strlen(s)+1);
		s[0] = 'D';
		s[1] = ':';
	}
}

char *adjustFilename(char *s, int exe) {
	char *p;
	char *out;
	unsigned int len;
	
	len = strlen(s);
	out = (char *)malloc(len + 10);
	
	strcpy(out, s);
	strupper(out);

	return out;
}

char *adjustExe(char *s) {
	char *p;
	char *out;
	unsigned int len;
	
	len = strlen(s);
	out = (char *)malloc(len + 10);
	
	strcpy(out, s);
	strupper(out);
	
	prependDevname(out);
	
	p = out + strlen(out);
	while (p >= out) {
		if (*p == '.') break;
		p--;
	}
	
	if (p < out) {
		out = strcat(out, ".EXE");
	}		
		
	return out;
}



taskControl_t *getParams() {
	
	taskControl_t *tc;
	char **p, *str;
	
	unsigned int i, j, len, cnt;
	
	str = (char *)calloc(1, 81);
	
	printf("%s>", shellpath);

/*	
	debugf("xStart.pxNextFreeBlock: %08X\n", xStart.pxNextFreeBlock);
	debugf("xStart.xBlockSize     : %08X\n", xStart.xBlockSize);
	debugf("xStart.pxNextFreeBlock->pxNextFreeBlock: %08X\n", xStart.pxNextFreeBlock->pxNextFreeBlock);
	debugf("xStart.pxNextFreeBlock->xBlockSize: %08X\n", xStart.pxNextFreeBlock->xBlockSize);
	debugf("pxEnd: %08X\n", pxEnd);
*/

	//fclose(stdin);fopen("K:","r");
	fgets(str, 80, stdin);
	
	//printf("str:%s \n", str);
		
	tc = (taskControl_t *)calloc(1, sizeof(taskControl_t));
	
	tc->cmdLine = str;
	
	len = strlen(str);
	
	for (cnt = 0, i = 0; i < len; i++) {
		if (str[i] == 0) break;
		if (str[i] == ' ' || str[i] == '\n') {
			str[i] = 0;
			cnt++;
		}
	}
	
	//printf("argc:%d \n", cnt);
	//getchar();
	
	tc->argc = cnt;
	
	tc->argv = (char **)malloc(cnt * sizeof(char *));

	p = tc->argv;
	
	for (i = 0, j = 0; j < cnt; i++) {
		//printf("p%d:%s\n", j, str + i);
		*p = str + i;
		p++;
		j++;
		while(str[i] != 0) {
			i++;
		}
	}
	
	//getchar();
	
	return tc;
}


void shellTask( void *pvParameters )
{
	TaskHandle_t taskHandle;
	BaseType_t rc;
	char c;
	taskControl_t *tc;
	char **p;
	char *fname, *breakpoint;
	unsigned int callTask;
	
	/* As per most tasks, this task is implemented in an infinite loop. */

	iocbSemaphore = xSemaphoreCreateMutex();
	debugf("iocbSemaphore created: %08X\n", iocbSemaphore);

	vTaskSetApplicationTaskTag(NULL, NULL);
	debugf("vTaskSetApplicationTaskTag\n");

	//asm {sei; wdm 7;}
	
	setvbuf(stdin, NULL, _IONBF, 1);
	//debugf("setvbuf");
	
	printf("\n");
	//debugf("printf");
	
	strcpy(shellpath, "/");
	//debugf("shellpath");
	
	chdir(shellpath);
	//debugf("shellpath\n");
	
	for( ;; ) {

		fd2iocb[0] = 0;
		
		tc = getParams();
		
		/*
		printf("argc: %d\n", tc->argc);
		p = tc->argv;
		for(c = 0; c < tc->argc; c++) {
			printf("parm %d:%s\n", c, *p);
			p++;
		}
		//getchar();
		*/
		
		p = tc->argv;
		fname = adjustExe(*p);

		chdir("/");
		
		fd2iocb[0] = 7;
		
		taskENTER_CRITICAL();	
		loadExec(fname, tc);
		taskEXIT_CRITICAL();
		
		free(fname);
				
		if (tc->codePtr == NULL) {
			printf("Error loading %s\n", fname);
			freetaskControl(tc);
			continue;
		}
		
		callTask = 1;
		breakpoint = NULL;
		if (tc->argc > 1) {

			c = *(tc->argv[tc->argc - 1]);
			
			if (c == '#') {
				callTask = 0;
			}
			
			if (c == '&') {
				tc->background = 1;
			}
			
			if (c == '!') {
				breakpoint = tc->codePtr + str2hex(tc->argv[tc->argc - 1] + 1);
				NCODE = *(breakpoint);
				*(breakpoint) = 0;
			}
		}
		
		
		if (callTask) {
			
			printf("calling @%l08X", tc->codePtr);
			if (breakpoint) {
				printf("%c %l08X\n", c, breakpoint);
			}
			printf("\n");
			//getchar();
			
			tc->callerTaskHandle = xTaskGetCurrentTaskHandle();
	
			//getchar();
			//asm jml $e000;
			
			rc = xTaskCreate((void *)tc->codePtr, tc->argv[0], 2048, tc, 0, &(tc->taskHandle));
			
			/*
			vTaskSuspendAll();
			debugTaskControl(tc);
			xTaskResumeAll();
			*/
			
			//vTaskDelay(xDelay);
	
			if (! tc->background) {
				//printf("waitung for notification...\n");
				ulTaskNotifyTake( pdTRUE, portMAX_DELAY );
				//printf("got notification...\n");

				//checkHeap("before");
				vTaskRemove(tc);
			}
		}
			//getchar();
	}
		
//		c = getchar();
//		if (c == 'x') {
//			asm JML $e000;
//		}
//	}
}

int main(int argc, char **argv) {
	
	BaseType_t rc;
	DIR *dir;
	unsigned int cnt, c;
	struct dirent *dirent;
	
	//asm {wdm 6;};
	
	vInitRTOS();
	
    fd2iocb[0] = 0;
    fd2iocb[1] = 0;
    fd2iocb[2] = 0;
    fd2iocb[3] = 0xff;
    fd2iocb[4] = 0xff;
    fd2iocb[5] = 0xff;
    fd2iocb[6] = 0xff;
    fd2iocb[7] = 0xff;
	
	iocbSemaphore = NULL;
	stdin->flags = BUFINPUT|BUFLINEWISE|STATICBUF|CANREAD;

/*
	dir = opendir("D:*.*");
	cnt = 0;
	
	while (dir && (dirent = readdir(dir))) {
		printf("%s", dirent->d_name);
		cnt++;
		if (cnt >= 20) {
			cnt = 0;
			c = toupper(getchar());
			if (c == 'X') break;
		}	
	}
*/


	rc = xTaskCreate( shellTask, "SHELL", 512, NULL, 0, NULL);
	if (rc != pdPASS) {
		printf("shell could not be created rc: %d\n", rc);
		return pdPASS;
	}

	/* Start the scheduler so the tasks start executing. */

	vTaskStartScheduler();

	/* If all is well then main() will never reach here as the scheduler will
	now be running the tasks. If main() does reach here then it is likely that
	there was insufficient heap memory available for the idle task to be created.
	Chapter 2 provides more information on heap memory management. */
	printf("Error starting RTOS scheduler\n");

	return pdFAIL;
}