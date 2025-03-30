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


static unsigned int parsedir(char *path) {
	
	char *p, *p0, *pathcopy;
	int end;
	int rc;
	unsigned int index;
	
	pathcopy = p = strdup(path);
	
	rc = -1;
	end = 0;
	index = 0;
	
	if (*p == '/'){
		rc = chdir("/");
		p++;
	}
	
	for (p0 = p; !end; p0++) {
		if (*p0 == 0) end = 1;
		
		if (*p0 == '/' || *p0 == 0) {
			*p0 = 0;
			if (*p == '*') break;
			rc = chdir(p);
			//printf("parsedir rc=%d\n", rc);
			if (rc == -1) break;
			p = p0 + 1;
			index = (size_t)p - (size_t)pathcopy;
			//printf("parsedir index=%d\n", index);
		}
	}
	
	//printf("parsedir index=%d\n", index);
	
	free(pathcopy);
	
	return index;
}

int main(int argc, char **argv) {
	DIR *dir;
	struct dirent *dirent;
	char *s, *s0;
	char *shellpath;
	unsigned int len, cnt, c;

	s = calloc(1, 80);
	
	if (argc >= 2) {
		strcpy(s, argv[1]);
		strupper(s);
	}
	
	shellpath = getShellpath();
	chdir(shellpath);

	len = parsedir(s);
	//printf("dir s=%s len=%d\n", s, len);
	
	s0 = s + len;
	len = strlen(s0);
	
	//printf("dir s=%s len=%d\n", s0, len);
	if (len == 0) {
		s0 = s;
		strcpy(s0, "D:*.*");
	}
	//printf("dir s=%s len=%d\n", s0, strlen(s0));
	
	dir = opendir(s0);
	
	//printf("opendir dir=%p\n", dir);
	
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
	
	//getchar();
}
