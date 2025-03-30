;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
;#include <stdio.h>
;#include <stdlib.h>
;#include <string.h>
;#include <stdbool.h>
;#include "FreeRTOS.h"
;#include "task.h"
;#include <homebrew.h>
;
;
;int main(int argc, char **argv) {
	code
	xdef	~~main
	func
~~main:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
argc_0	set	4
argv_0	set	6
;	
;	UBaseType_t uxArraySize, x, taskNo;
;	TaskStatus_t *pxTaskStatusArray;	
;	
;	
;	uxArraySize = uxTaskGetNumberOfTasks();
uxArraySize_1	set	0
x_1	set	2
taskNo_1	set	4
pxTaskStatusArray_1	set	6
	jsl	~~uxTaskGetNumberOfTasks
	sta	<L3+uxArraySize_1
;	
;	//printf("number of tasks: %d\n", (long)uxArraySize);
;	
;	pxTaskStatusArray = malloc( uxArraySize * sizeof( TaskStatus_t ) );
	sta	<R0
	stz	<R0+2
	pea	#^$1a
	pea	#<$1a
	pei	<R0+2
	pei	<R0
	xref	~~~lmul
	jsl	~~~lmul
	sta	<R0
	stx	<R0+2
	pei	<R0+2
	pei	<R0
	jsl	~~malloc
	sta	<L3+pxTaskStatusArray_1
	stx	<L3+pxTaskStatusArray_1+2
;	
;	taskNo = 0;
	stz	<L3+taskNo_1
;	if (argc > 1) {
	sec
	lda	#$1
	sbc	<L2+argc_0
	bvs	L4
	eor	#$8000
L4:
	bmi	L10001
;		taskNo = atoi(argv[1]);
	ldy	#$6
	lda	[<L2+argv_0],Y
	pha
	dey
	dey
	lda	[<L2+argv_0],Y
	pha
	jsl	~~atoi
	sta	<L3+taskNo_1
;	}
;	
;	if( pxTaskStatusArray != NULL && taskNo > 1)
L10001:
;	{
	lda	<L3+pxTaskStatusArray_1
	ora	<L3+pxTaskStatusArray_1+2
	bne	*+5
	brl	L10
	lda	#$1
	cmp	<L3+taskNo_1
	bcc	*+5
	brl	L10
;		/* Generate raw status information about each task. */
;		uxArraySize = uxTaskGetSystemState( pxTaskStatusArray,
;											uxArraySize,
;											NULL );
	pea	#^$0
	pea	#<$0
	pei	<L3+uxArraySize_1
	pei	<L3+pxTaskStatusArray_1+2
	pei	<L3+pxTaskStatusArray_1
	jsl	~~uxTaskGetSystemState
	sta	<L3+uxArraySize_1
;											
;		for( x = 0; x < uxArraySize; x++) {
	stz	<L3+x_1
	brl	L10006
L10005:
;			if (taskNo == pxTaskStatusArray[x].xTaskNumber) {
	lda	<L3+x_1
	sta	<R0
	stz	<R0+2
	pea	#^$1a
	pea	#<$1a
	pei	<R0+2
	pei	<R0
	xref	~~~lmul
	jsl	~~~lmul
	sta	<R0
	stx	<R0+2
	lda	#$8
	clc
	adc	<L3+pxTaskStatusArray_1
	sta	<R1
	lda	#$0
	adc	<L3+pxTaskStatusArray_1+2
	sta	<R1+2
	lda	<R1
	clc
	adc	<R0
	sta	<R2
	lda	<R1+2
	adc	<R0+2
	sta	<R2+2
	lda	[<R2]
	cmp	<L3+taskNo_1
	beq	*+5
	brl	L10003
;				vTaskRemove(xTaskGetApplicationTaskTag(pxTaskStatusArray[x].xHandle));
	lda	<L3+x_1
	sta	<R0
	stz	<R0+2
	pea	#^$1a
	pea	#<$1a
	pei	<R0+2
	pei	<R0
	xref	~~~lmul
	jsl	~~~lmul
	sta	<R0
	stx	<R0+2
	lda	<L3+pxTaskStatusArray_1
	clc
	adc	<R0
	sta	<R1
	lda	<L3+pxTaskStatusArray_1+2
	adc	<R0+2
	sta	<R1+2
	ldy	#$2
	lda	[<R1],Y
	pha
	lda	[<R1]
	pha
	jsl	~~xTaskGetApplicationTaskTag
	sta	<R0
	stx	<R0+2
	phx
	pha
	jsl	~~vTaskRemove
;				printf("task #%d %s killed.\n", taskNo, pxTaskStatusArray[x].pcTaskName);
	lda	<L3+x_1
	sta	<R0
	stz	<R0+2
	pea	#^$1a
	pea	#<$1a
	pei	<R0+2
	pei	<R0
	xref	~~~lmul
	jsl	~~~lmul
	sta	<R0
	stx	<R0+2
	lda	#$4
	clc
	adc	<L3+pxTaskStatusArray_1
	sta	<R1
	lda	#$0
	adc	<L3+pxTaskStatusArray_1+2
	sta	<R1+2
	lda	<R1
	clc
	adc	<R0
	sta	<R2
	lda	<R1+2
	adc	<R0+2
	sta	<R2+2
	ldy	#$2
	lda	[<R2],Y
	pha
	lda	[<R2]
	pha
	pei	<L3+taskNo_1
	pea	#^L1
	pea	#<L1
	pea	#12
	jsl	~~printf
;			}
;		}			
L10003:
	inc	<L3+x_1
L10006:
	lda	<L3+x_1
	cmp	<L3+uxArraySize_1
	bcs	*+5
	brl	L10005
;   }
;}
L10:
	tay
	lda	<L2+2
	sta	<L2+2+6
	lda	<L2+1
	sta	<L2+1+6
	pld
	tsc
	clc
	adc	#L2+6
	tcs
	tya
	rtl
L2	equ	22
L3	equ	13
	ends
	efunc
	data
L1:
	db	$74,$61,$73,$6B,$20,$23,$25,$64,$20,$25,$73,$20,$6B,$69,$6C
	db	$6C,$65,$64,$2E,$0A,$00
	ends
;
	xref	~~vTaskRemove
	xref	~~uxTaskGetSystemState
	xref	~~xTaskGetApplicationTaskTag
	xref	~~uxTaskGetNumberOfTasks
	xref	~~atoi
	xref	~~malloc
	xref	~~printf
