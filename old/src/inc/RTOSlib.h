#define RTOS_BASE	(0x00010000)

void *malloc(size_t size) {
	asm JML $00010003;
}

void free(void *p) {
	asm JML $00010005;
}

/*
void *(*malloc)(size_t) 					= (* malloc)0x00010003;
void (*free(void *)) 						= 0x00010005;
	
void * pvPortMalloc 					= (void *) (RTOS_BASE + (001 * 3));
void * vPortFree 					= (void *) (RTOS_BASE + (002 * 3));	
*/
/*
void * xTaskCreate 					= RTOS_BASE + (001 * 3);
void * vTaskDelete 					= RTOS_BASE + (001 * 3);
void * vTaskDelay 					= RTOS_BASE + (001 * 3);
void * vTaskDelayUntil 					= RTOS_BASE + (001 * 3);
void * uxTaskPriorityGet 					= RTOS_BASE + (001 * 3);
void * vTaskPrioritySet 					= RTOS_BASE + (001 * 3);
void * vTaskSuspend 					= RTOS_BASE + (001 * 3);
void * vTaskResume 					= RTOS_BASE + (001 * 3);
void * xTaskResumeFromISR 					= RTOS_BASE + (001 * 3);
void * xTaskAbortDelay 					= RTOS_BASE + (001 * 3);
void * uxTaskGetSystemState 					= RTOS_BASE + (001 * 3);
void * vTaskGetInfo 					= RTOS_BASE + (001 * 3);
void * xTaskGetCurrentTaskHandle 					= RTOS_BASE + (001 * 3);
void * xTaskGetIdleTaskHandle 					= RTOS_BASE + (001 * 3);
void * uxTaskGetStackHighWaterMark 					= RTOS_BASE + (001 * 3);
void * eTaskGetState 					= RTOS_BASE + (001 * 3);
void * pcTaskGetName 					= RTOS_BASE + (001 * 3);
void * xTaskGetHandle 					= RTOS_BASE + (001 * 3);
void * xTaskGetTickCount 					= RTOS_BASE + (001 * 3);
void * xTaskGetTickCountFromISR 					= RTOS_BASE + (001 * 3);
void * xTaskGetSchedulerState 					= RTOS_BASE + (001 * 3);
void * uxTaskGetNumberOfTasks 					= RTOS_BASE + (001 * 3);
void * vTaskList 					= RTOS_BASE + (001 * 3);
void * vTaskSetApplicationTaskTag 					= RTOS_BASE + (001 * 3);
void * xTaskGetApplicationTaskTag 					= RTOS_BASE + (001 * 3);
void * xTaskCallApplicationTaskHook 					= RTOS_BASE + (001 * 3);
void * pvTaskGetThreadLocalStoragePointer 					= RTOS_BASE + (001 * 3);
void * vTaskSetThreadLocalStoragePointer 					= RTOS_BASE + (001 * 3);
void * vTaskSetTimeOutState 					= RTOS_BASE + (001 * 3);
void * xTaskCheckForTimeOut 					= RTOS_BASE + (001 * 3);
*/
/*
void * xTaskGenericNotify
void * vTaskNotifyGiveFromISR
void * ulTaskNotifyTake
void * xTaskNotifyWait
void * xTaskNotifyStateClear

void * vQueueDelete
void * xQueueReceive
void * xQueueReceiveFromISR
void * uxQueueMessagesWaiting
void * uxQueueMessagesWaitingFromISR
void * uxQueueSpacesAvailable
void * xQueuePeek
void * xQueuePeekFromISR
void * vQueueAddToRegistry
void * pcQueueGetName
void * vQueueUnregisterQueue
void * xQueueIsQueueEmptyFromISR
void * xQueueIsQueueFullFromISR
void * xQueueGenericCreate
void * xQueueGenericSend
void * xQueueGenericSendFromISR
void * xQueueGenericReset

void * xStreamBufferGenericCreate
void * xStreamBufferSend
void * xStreamBufferSendFromISR
void * xStreamBufferReceive
void * xStreamBufferReceiveFromISR
void * vStreamBufferDelete
void * xStreamBufferBytesAvailable
void * xStreamBufferSpacesAvailable
void * xStreamBufferSetTriggerLevel
void * xStreamBufferReset
void * xStreamBufferIsEmpty
void * xStreamBufferIsFull
*/