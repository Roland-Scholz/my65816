#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include "FreeRTOS.h"
#include "task.h"
#include <homebrew.h>

static void back(char *p, unsigned int len) {
	
	int i;
	
	for (i = len-1; i >= 0; i--) {
		if (p[i] == '/') {
			if (i == 0) i++;
			p[i] = 0;
			break;
		}
	}
}
	
static void adjustShellPath(char *path, char *shellpath) {
	
	unsigned int len;
	
	len = strlen(shellpath);
	
	if (path[0] == '.' && path[1] == '.') {
		back(shellpath, len);
		return;
	}
	
	if (path[0] == '.') return;
	
	if (!(shellpath[len -1] == '/' || path[0] == '/')) {
		strcat(shellpath, "/");
	}
	
	strcat(shellpath, path);
}

static unsigned int parsedir(char *path, char *shellpath) {
	
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
		strcpy(shellpath, "/");
		p++;
	}
	
	for (p0 = p; !end; p0++) {
		if (*p0 == 0) end = 1;
		
		if (*p0 == '/' || *p0 == 0) {
			*p0 = 0;
			//if (*p == '*') break;
			rc = chdir(p);
			//printf("parsedir rc=%d\n", rc);
			if (rc == -1) break;
			adjustShellPath(p, shellpath);
			p = p0 + 1;
			index = (size_t)p - (size_t)pathcopy;
			//printf("parsedir index=%d\n", index);
		}
	}
	
	//printf("parsedir index=%d\n", index);
	
	free(pathcopy);
	
	return index;
}

int main(int argc, char**argv) {
	
	char *p, c;
	unsigned int len;
	int rc;
	
	if (argc != 2) {
		return 8;
	} 
	
	p = getShellpath();
	rc = chdir(p);
	
	if (rc == -1) {
		strcpy(p, "/");
		rc = chdir(p);
		return 0;
	}
	
	parsedir(argv[1], p);
	
	//printf("shellpath: %s\n", p);
	
	return 0;
}

