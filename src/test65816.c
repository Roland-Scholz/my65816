#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <homebrew.h>
#include "FreeRTOS.h"
#include "task.h"


#define POSTCODE asm phk; asm plb;
#define rtos_printf(x) printf x; POSTCODE

int debugf(const char *format, ...);

//extern unsigned char fd2iocb[8];


void task(void *parameter) {
	char *str = "Hallo Welt!\n";
	unsigned long i;
/*
	void *p;
	
	p = malloc(1024);
	printf("Pointer: %08Xl \n", p);
	free(p);
    fd2iocb[0] = 0;
    fd2iocb[1] = 0;
    fd2iocb[2] = 0;
    fd2iocb[3] = 0xff;
    fd2iocb[4] = 0xff;
    fd2iocb[5] = 0xff;
    fd2iocb[6] = 0xff;
    fd2iocb[7] = 0xff;
*/
	i = 0xBABE;

	//fd2iocb[0] = 0;

	printf("Tach: %s", str);
	xTaskNotifyGive(parameter);
	vTaskSuspend(NULL);

	//debugf("%s", "Hallo Welt!\n");
	//goto loop;
}

