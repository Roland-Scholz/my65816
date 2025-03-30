/*
 * Kestrel 2 Baseline Emulator
 * Release 1p1
 *
 * Copyright (c) 2006 Samuel A. Falvo II
 * All Rights Reserved
 */

#include <lib65816/cpu.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "ram.h"

static byte *memory = NULL;

/* The Kestrel 2 Baseline employs only 32KB of ROM to hold its kernel.
 * Real hardware will *likely* use the Xess board's Flash ROM to hold
 * larger software images, but the ROM will be bank switched in 16KB
 * chunks.  For now, however, ROM consumes a single 32K chunk of RAM.
 */

#define MEMSIZE (8 * 1024)
#define ROMFILESIZE (64 * 1024)

int rom_initialize(void)
{
    FILE *romfile;
    char *romfilename = "C:/github/my65816/release/kernelWDC.bin";
    byte *romfiledata = NULL;

    if (memory == NULL)
    {
        memory = (byte *)(malloc(MEMSIZE));
        if (memory == 0)
            goto no_memory;
    }

    if (romfiledata == NULL)
    {
        romfiledata = (byte *)(malloc(ROMFILESIZE));
        if (romfiledata == 0)
            goto no_memory;
    }

    romfile = fopen(romfilename, "rb");
    if (romfile == 0)
        goto no_file;

    printf("%s read: %d\n", romfilename, fread(romfiledata, 1, ROMFILESIZE, romfile));

    fclose(romfile);

    memcpy(memory, romfiledata + (ROMFILESIZE - MEMSIZE), MEMSIZE);

    return 1;

no_file:
    fprintf(stderr, "Error trying to read ROMFILE\n");
    free(memory);

no_memory:
    fprintf(stderr, "Error initializing ROM\n");
    return 0;
}

void rom_expunge(void)
{
    if (memory)
        free(memory);
    memory = 0;
}

byte rom_read(word32 address, word32 unusedTimestamp)
{
    address &= 0x00001FFF;

    return (byte)(memory[address]);
}

void rom_write(word32 address, byte b, word32 timestamp)
{
    ram_write(address, b, timestamp); /* RAM write-through */
}
