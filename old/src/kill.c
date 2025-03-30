#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include "FreeRTOS.h"
#include "task.h"
#include <homebrew.h>


int main(int argc, char **argv) {
	
	UBaseType_t uxArraySize, x, taskNo;
	TaskStatus_t *pxTaskStatusArray;	
	
	
	uxArraySize = uxTaskGetNumberOfTasks();
	
	//printf("number of tasks: %d\n", (long)uxArraySize);
	
	pxTaskStatusArray = malloc( uxArraySize * sizeof( TaskStatus_t ) );
	
	taskNo = 0;
	if (argc > 1) {
		taskNo = atoi(argv[1]);
	}
	
	if( pxTaskStatusArray != NULL && taskNo > 1)
	{
		/* Generate raw status information about each task. */
		uxArraySize = uxTaskGetSystemState( pxTaskStatusArray,
											uxArraySize,
											NULL );
											
		for( x = 0; x < uxArraySize; x++) {
			if (taskNo == pxTaskStatusArray[x].xTaskNumber) {
				vTaskRemove(xTaskGetApplicationTaskTag(pxTaskStatusArray[x].xHandle));
				printf("task #%d %s killed.\n", taskNo, pxTaskStatusArray[x].pcTaskName);
			}
		}			
   }
}
