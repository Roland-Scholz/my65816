/*
 * FreeRTOS Kernel V10.2.1
 * Copyright (C) 2019 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * http://www.FreeRTOS.org
 * http://aws.amazon.com/freertos
 *
 * 1 tab == 4 spaces!
 */

/*
 * Instead of the normal single demo application, the PIC18F demo is split
 * into several smaller programs of which this is the first.  This enables the
 * demo's to be executed on the RAM limited 40 pin devices.  The 64 and 80 pin
 * devices require a more costly development platform and are not so readily
 * available.
 *
 * The RTOSDemo1 project is configured for a PIC18F452 device.  Main1.c starts 5
 * tasks (including the idle task).
 *
 * The first task runs at the idle priority.  It repeatedly performs a 32bit
 * calculation and checks it's result against the expected value.  This checks
 * that the temporary storage utilised by the compiler to hold intermediate
 * results does not get corrupted when the task gets switched in and out.  See
 * demo/common/minimal/integer.c for more information.
 *
 * The second and third tasks pass an incrementing value between each other on
 * a message queue.  See demo/common/minimal/PollQ.c for more information.
 *
 * Main1.c also creates a check task.  This periodically checks that all the
 * other tasks are still running and have not experienced any unexpected
 * results.  If all the other tasks are executing correctly an LED is flashed
 * once every mainCHECK_PERIOD milliseconds.  If any of the tasks have not
 * executed, or report and error, the frequency of the LED flash will increase
 * to mainERROR_FLASH_RATE.
 *
 * On entry to main an 'X' is transmitted.  Monitoring the serial port using a
 * dumb terminal allows for verification that the device is not continuously
 * being reset (no more than one 'X' should be transmitted).
 *
 * http://www.FreeRTOS.org contains important information on the use of the
 * PIC18F port.
 */

/*
Changes from V2.0.0

	+ Delay periods are now specified using variables and constants of
	  TickType_t rather than unsigned long.
*/

/* Scheduler include files. */
#include "FreeRTOS.h"
#include "task.h"


/*-----------------------------------------------------------*/

/* Creates the tasks, then starts the scheduler. */

uint8_t ucHeap[ configTOTAL_HEAP_SIZE ];

void main( void )
{
	vTaskStartScheduler();
}
/*-----------------------------------------------------------*/

/*-----------------------------------------------------------*/


