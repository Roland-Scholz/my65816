#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include "FreeRTOS.h"
#include "task.h"
#include <homebrew.h>


int main(int argc, char **argv) {
	
	char *str = malloc(8 * 1024);

	vTaskList(str);
	printf("%s", str);
	free(str);
}
