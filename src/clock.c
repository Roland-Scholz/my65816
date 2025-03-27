#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <errno.h>
#include <unistd.h>
#include <dirent.h>

#include "freeRTOS.h"
#include "task.h"
#include <homebrew.h>


static unsigned int i, sec, min, hour;
static char s[10];

int main(int argc, char **argv) {

	const TickType_t xDelay = 200;
	char *screen = (char *)0x7FF800+72;
	unsigned int i;
	
	sec = min = hour = 0;
	
	hour = atoi(argv[1]);
	min = atoi(argv[2]);
	
	for(;;) {
		sec++;
		if (sec == 60) {
			sec = 0;
			min++;
			if (min == 60) {
				min = 0;
				hour++;
				if (hour == 24) hour = 0;
			}
		}
		
		sprintf(s, "%02d:%02d:%02d", hour, min, sec);
		//memcpy(screen, s, 8);
		for (i = 0; i < 8; i++) {
			screen[i] = s[i];
		}
		vTaskDelay(xDelay);
	}
}
