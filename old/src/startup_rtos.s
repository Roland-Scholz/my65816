CALL	MACRO label
	XREF label
	jmp 	label
	MACEND

CALL_MAIN MACRO label
	XREF label
	jmp	label
	MACEND
	
	
STACK	EQU	$01FF			;CHANGE THIS FOR YOUR SYSTEM
FNAME	EQU 	$0380
EOL	EQU	$0A
ARGC	EQU	$033b			;2-byte number of args
ARGV	EQU	$033d			;8*2-bytes pointer to arg strings


	module	startup
	
M	EQU	$20

;	include hombrewWDC.inc

	code
	xdef	startup_main
	func
	
	xref	~~main
	
	CALL_MAIN	startup_main

	CALL	~~malloc
	CALL	~~free
	CALL	~~realloc
	CALL	~~memcpy
	CALL	~~memcmp
	CALL	~~memset
	
	CALL	~~pvPortMalloc
	CALL	~~vPortFree

	CALL	~~xTaskCreate
	CALL	~~vTaskDelete
	CALL	~~vTaskDelay
	CALL	~~vTaskDelayUntil
	CALL	~~uxTaskPriorityGet
	CALL	~~vTaskPrioritySet
	CALL	~~vTaskSuspend
	CALL	~~vTaskResume
	CALL	~~xTaskResumeFromISR
	CALL	~~xTaskAbortDelay
	CALL	~~uxTaskGetSystemState
	CALL	~~vTaskGetInfo
	CALL	~~xTaskGetCurrentTaskHandle
	CALL	~~xTaskGetIdleTaskHandle
	CALL	~~uxTaskGetStackHighWaterMark
	CALL	~~eTaskGetState
	CALL	~~pcTaskGetName
	CALL	~~xTaskGetHandle
	CALL	~~xTaskGetTickCount
	CALL	~~xTaskGetTickCountFromISR
	CALL	~~xTaskGetSchedulerState
	CALL	~~uxTaskGetNumberOfTasks
	CALL	~~vTaskList
	CALL	~~vTaskSetApplicationTaskTag
	CALL	~~xTaskGetApplicationTaskTag
	CALL	~~xTaskCallApplicationTaskHook
	CALL	~~pvTaskGetThreadLocalStoragePointer
	CALL	~~vTaskSetThreadLocalStoragePointer
	CALL	~~vTaskSetTimeOutState
	CALL	~~xTaskCheckForTimeOut
	CALL	~~xTaskGenericNotify
	CALL	~~vTaskNotifyGiveFromISR
	CALL	~~ulTaskNotifyTake
	CALL	~~xTaskNotifyWait
	CALL	~~xTaskNotifyStateClear
	
	CALL	~~vQueueDelete
	CALL	~~xQueueReceive
	CALL	~~xQueueReceiveFromISR
	CALL	~~uxQueueMessagesWaiting
	CALL	~~uxQueueMessagesWaitingFromISR
	CALL	~~uxQueueSpacesAvailable
	CALL	~~xQueuePeek
	CALL	~~xQueuePeekFromISR
	CALL	~~vQueueAddToRegistry
	CALL	~~pcQueueGetName
	CALL	~~vQueueUnregisterQueue
	CALL	~~xQueueIsQueueEmptyFromISR
	CALL	~~xQueueIsQueueFullFromISR
	CALL	~~xQueueGenericCreate
	CALL	~~xQueueGenericSend
	CALL	~~xQueueGenericSendFromISR
	CALL	~~xQueueGenericReset
	
	CALL	~~xStreamBufferGenericCreate
	CALL	~~xStreamBufferSend
	CALL	~~xStreamBufferSendFromISR
	CALL	~~xStreamBufferReceive
	CALL	~~xStreamBufferReceiveFromISR
	CALL	~~vStreamBufferDelete
	CALL	~~xStreamBufferBytesAvailable
	CALL	~~xStreamBufferSpacesAvailable
	CALL	~~xStreamBufferSetTriggerLevel
	CALL	~~xStreamBufferReset
	CALL	~~xStreamBufferIsEmpty
	CALL	~~xStreamBufferIsFull
	
	CALL	~~printf
	CALL	~~sprintf
	CALL	~~fgetc
	CALL	~~fread
	CALL	~~fwrite
	CALL	~~read
	CALL	~~write
	CALL	~~fopen
	CALL	~~fclose
	CALL	~~getStdin
	CALL	~~getStdout
	CALL	~~getStderr
	CALL	~~vsnprintf
	CALL	~~calloc
	CALL	~~opendir
	CALL	~~readdir
	CALL	~~closedir
	CALL	~~fflush
	CALL	~~lseek
	CALL	~~chdir
	CALL	~~getShellpath
	CALL	~~freetaskControl
	CALL	~~vTaskRemove
	CALL	~~strdup
	CALL	~~strcpy
	CALL	~~strlen
	CALL	~~toupper
	CALL	~~setvbuf
	CALL	~~memmove
	CALL	~~stat
	CALL	~~fstat
	CALL	~~fseek
	CALL	~~fgets
	CALL	~~fscanf
	CALL	~~fputc
	CALL	~~dump
	CALL	~~open
	CALL	~~close
	CALL	~~unlink
		
startup_main:	
	php				;save processor flags (M/X)
	phb				;save data bank
	phd				;save direct
	phk				;save program bank
	
	REP 	#$30			;16 bit registers
	LONGI	ON
	LONGA	ON

	plb				;get data bank = program-bank 
	
	pea	#0
	pea	#0
	pea	#0
	jsl	~~main			;long jump in case not bank 0
		
ENDE:
	pld
	plb
	plp
	rtl

	ends
	efunc

	endmod