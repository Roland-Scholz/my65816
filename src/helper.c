#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "FreeRTOS.h"
#include "task.h"
#include "homebrew.h"

FILE *stdin, *stdout, *stderr;

int input(char *s, int maxlen) {
	int c, cnt;
	
	cnt = 0;
	maxlen -= 1;
	
	while(1) {
		c = getchar();
		if (c >= 32 && c < 127) {
			if (cnt < maxlen) {
				fputc(c, stdout);
				fflush(stdout);
				s[cnt] = c;
				cnt++;
			}
		}
		if (c == 8) {
			if (cnt > 0) {
				fputc(c, stdout);
				fflush(stdout);
				cnt--;
			}
		}
		if (c == 10) {
			s[cnt] = 0;
			return strlen(s);
		}
		
	}
}


char int2hex(int c) {
	if(c < 10) return '0' + c;
	else return 'A' + c - 10;
	
}

void printhex(char c) {
	printchar(int2hex(c >> 4));
	printchar(int2hex(c & 0xf));
}

void printchar(char c) {
	while(!(LSR0 & 0x40));
	THR0 = c;
}

void strupper(char *str) {
	while(*str != 0) {
		*str = toupper(*str);
		str++;
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
	
	if (!(out[0] == 'D' && out[1] == ':')) {
		memmove(out+2, out, strlen(out)+1);
		out[0] = 'D';
		out[1] = ':';
	}
	
	//printf("len: %d, out: %s\n", len, out);
	
	return out;
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

size_t getHex8() {
	size_t val;
	int c, cnt, i;
	//FILE *stdin;
	
	val = 0;
	
	//stdin = getStdin();
	
	for(cnt = 0; cnt < 8;) {
	
		c = getchar();

		i = hex2int(c);
		if (i >= 0) {
			printf("%c", c);
			val <<= 4;
			val += i;
			cnt++;
			continue;
		}
				
		if (c == 8) {
			if (cnt > 0) {
				printf("%c", c);
				val >>= 4;
				cnt--;
			}
		}
		
		if (c == 10) break;
	}
	
	//printf("val: %l08X %ld\n", val, val);

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

void task(taskControl_t *tc) {
		
	//debugf("task start tc:%08X\n", tc);

	vTaskSetApplicationTaskTag(NULL, (void *)tc);

	stdin = getStdin();
	stdout = getStdout();
	stderr = getStderr();
	
	tc->rc = main(tc->argc, tc->argv);
	
	//debugf("task end  tc:%08X\n", tc);

	if (! tc->background) {
		xTaskNotifyGive(tc->callerTaskHandle);		
	} else {
		//debugf("task remove tc:%08X\n", tc);
		vTaskRemove(tc);
	}
	vTaskSuspend(NULL);
}