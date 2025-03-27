#ifndef IO_MOUSE_H
#define IO_MOUSE_H

/*
 * Kestrel 2 Baseline Emulator
 * Release 1p1
 *
 * Copyright (c) 2006 Samuel A. Falvo II
 * All Rights Reserved
 *
 * Mouse controller, 16450 Uart
 */

#include <lib65816/cpu.h>


#define IOBASE_MOUSE	0xFFFFA0
#define IOMASK_MOUSE	0xFFFFF0

#define RBR1 		0
#define THR1 		0
#define IER1 		1
#define IIR1 		2
#define LCR1 		3
#define MCR1 		4
#define LSR1 		5
#define MSR1 		6
#define SCR1 		7
#define DLL1 		0
#define DLM1 		1


struct IO_MOUSE
{
	byte regs[16];
};

typedef struct IO_MOUSE  IO_MOUSE;

int
mouse_initialize( void );

void
mouse_expunge( void );

byte
mouse_read( word32 address, word32 timestamp );

void
mouse_write( word32 address, byte b, word32 timestamp );

void
mouse_write( word32 address, byte b, word32 timestamp );

void
mouse_update( word32 timestamp );

void
mouse_start(SDL_Event *evt);

void
mouse_state();

#endif

