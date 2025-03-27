/*
 * Kestrel 2 Baseline Emulator
 * Release 1p1
 *
 * Copyright (c) 2006 Samuel A. Falvo II
 * All Rights Reserved
 *
 * Keyboard Input and MOuse controller
 */

#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <string.h>

#include "lib65816/cpu.h"
#include "lib65816/cpuevent.h"
#include "io.h"
#include "SDL.h"
#include "kimo.h"
#include "rom.h"
#include "ram.h"
#include "display.h"
#include "mouse.h"

#define DISKSIZE	(32*1024*1024)
static IO_KIMO kimo;
extern byte *ram;

static CPUEvent kimoCheckEvent;
static byte *disk = NULL;
static int shift = 0;
static int shiftlock = 0;
static int strg = 0;
static int altgr = 0;

static byte upperArrayFrom[] = { '1', '2', '3', '4', '5', '6', '7', '8', '9',
		'0', 'ß', '´', '+', '#', '<', ',', '.', '-' };
static byte upperArrayTo[] = { '!', '"', '§', '$', '%', '&', '/', '(', ')', '=',
		'?', '`', '*', '\'', '>', ';', ':', '_' };
static int disksize;

void kimo_expunge(void) {
	/* does nothing for the time being */
}

word16 ramWord(word16 adr) {
	return (ram[adr] + (ram[adr + 1] << 8));
}

word16 toWord(byte lo, byte hi) {
	return (lo + (hi << 8));
}

void loadDiskImage() {

	if (disk != NULL) {
		free(disk);
	}

	FILE *f = fopen("test.dat", "rb");
	disk = malloc(DISKSIZE);

	if (f != NULL) {
		printf("disk read: %d\n", disksize = fread(disk, 1, DISKSIZE, f));
		fflush(stdout);
		fclose(f);
	}
}

static void saveDiskImage() {

	if (disk != NULL) {
		FILE *f = fopen("test.dat", "wb");
		if (f != NULL) {
			printf("disk write: %d\n", fwrite(disk, 1, disksize, f));
			fflush(stdout);
			fclose(f);
		}
	}
}

void compute_mul() {
	int res, a, b;

	a = kimo.mula0 + (kimo.mula1 << 8) + (kimo.mula2 << 16)
			+ (kimo.mula3 << 24);
	b = kimo.mulb0 + (kimo.mulb1 << 8) + (kimo.mulb2 << 16)
			+ (kimo.mulb3 << 24);

	res = a * b;

	kimo.mulout0 = res & 0xff;
	kimo.mulout1 = (res >> 8) & 0xff;
	kimo.mulout2 = (res >> 16) & 0xff;
	kimo.mulout3 = (res >> 24);
}

byte timer_read(word32 address, word32 timestamp) {
	switch (address & 0x0f) {
	case TIMERST:
		return kimo.timerstatus;
	case MULINA0:
		return kimo.mula0;
	case MULINA1:
		return kimo.mula1;
	case MULINA2:
		return kimo.mula2;
	case MULINA3:
		return kimo.mula3;
	case MULINB0:
		return kimo.mulb0;
	case MULINB1:
		return kimo.mulb1;
	case MULINB2:
		return kimo.mulb2;
	case MULINB3:
		return kimo.mulb3;
	case MULOUT0:
		compute_mul();
		return kimo.mulout0;
	case MULOUT1:
		//compute_mul();
		return kimo.mulout1;
	case MULOUT2:
		compute_mul();
		return kimo.mulout2;
	case MULOUT3:
		//compute_mul();
		return kimo.mulout3;
	default:
		return 0;
	}
}

byte kimo_read(word32 address, word32 timestamp) {
	switch (address & 0x0f) {
	case RBR0:
		kimo.kbmost = 0;
		return LOBYTE(kimo.kbda);
	case LSR0:
		return LOBYTE(kimo.kbmost) | 64;
	case SECPTRLO:
		return kimo.secptrlo;
	case SECPTRHI:
		return kimo.secptrhi;
	case READWRITE:
		//SDL_Log("SD read sector: %d, buffer: %d", ramWord(kimo.secptr), kimo.bufptr);
		memcpy(&(ram[kimo.bufptr]), &(disk[ramWord(kimo.secptr) << 9]), 512);
		//CPU_setTrace(1);
		return kimo.readwrite;
	case BUFPTRLO:
		return kimo.bufptrlo;
	case BUFPTRHI:
		return kimo.bufptrhi;
	default:
		return 0;
	}
}

void timer_write(word32 address, byte b, word32 timestamp) {
	switch (address & 0x0f) {
	case TIMERST:
		kimo.timerstatus = b;
		break;
	case MULINA0:
		kimo.mula0 = b;
		kimo.mula2 = kimo.mula3 = 0;
		break;
	case MULINA1:
		kimo.mula1 = b;
		kimo.mula2 = kimo.mula3 = 0;
		break;
	case MULINA2:
		kimo.mula2 = b;
		break;
	case MULINA3:
		kimo.mula3 = b;
		break;
	case MULINB0:
		kimo.mulb0 = b;
		kimo.mulb2 = kimo.mulb3 = 0;
		break;
	case MULINB1:
		kimo.mulb1 = b;
		kimo.mulb2 = kimo.mulb3 = 0;
		break;
	case MULINB2:
		kimo.mulb2 = b;
		break;
	case MULINB3:
		kimo.mulb3 = b;
		break;
	case MULOUT0:
		kimo.mulout0 = b;
		break;
	case MULOUT1:
		kimo.mulout1 = b;
		break;
	case MULOUT2:
		kimo.mulout2 = b;
		break;
	case MULOUT3:
		kimo.mulout3 = b;
		break;
	default:
		break;
	}
}

void kimo_write(word32 address, byte b, word32 timestamp) {
	switch (address & 0x0f) {
	case THR0:
		putc(b, stdout);
		break;
	case SECPTRLO:
		kimo.secptrlo = b;
		kimo.secptr = (kimo.secptr & 0xff00) | kimo.secptrlo;
		break;
	case SECPTRHI:
		kimo.secptrhi = b;
		kimo.secptr = (kimo.secptr & 0x00ff) | (kimo.secptrhi << 8);
		break;
	case READWRITE:
		kimo.readwrite = b;
		//SDL_Log("SD write sector: %d, buffer: %d", ramWord(kimo.secptr),
		//		kimo.bufptr);
		memcpy(&(disk[ramWord(kimo.secptr) << 9]), &(ram[kimo.bufptr]), 512);

		break;
	case BUFPTRLO:
		kimo.bufptrlo = b;
		kimo.bufptr = (kimo.bufptr & 0xff00) | kimo.bufptrlo;
		break;
	case BUFPTRHI:
		kimo.bufptrhi = b;
		kimo.bufptr = (kimo.bufptr & 0x00ff) | (kimo.bufptrhi << 8);
		break;
	default:
		break;
	}
}

int kimo_timer(void *data) {

	for (;;) {
		kimo.timerstatus = 0x80;
		CPU_addIRQ(1);
		SDL_Delay(5);
	}
	return 0;
}

void kimo_update(word32 timestamp) {
	SDL_Event evt;
	byte c, superflag;


	mouse_state();

	while (SDL_PollEvent(&evt)) {

		mouse_start(&evt);

		switch (evt.type) {

		case SDL_KEYDOWN:
			c = 0;
			superflag = 0;
			//F1 = LEFT SHFT, right shift;
			//SDL_Log("key: %d %d", c, evt.key.keysym.sym);
			switch (evt.key.keysym.sym) {
			case 1073741898:	//POS1
				c = CCHM;
				superflag = 1;
				break;
			case 1073741882:	//F1 = reset
				loadDiskImage();
				rom_initialize();
				ram_initialize();
				CPU_reset();
				break;
			case 1073742049:	//left shift
			case 1073742053:	//right shift
				shift = 1;
				break;
			case 1073741881:	//shift lock
				shiftlock ^= 1;
				break;
			case 1073741904:	//cursor left
				c = CCLF;
				break;
			case 1073741903:	//cursor right
				c = CCRT;
				break;
			case 1073741906:	//cursor up
				c = CCUP;
				break;
			case 1073741905:	//cursor down
				c = CCDN;
				break;
			case 1073742048:	//left STRG
			case 1073742052:	//right STRG
				strg = 1;
				break;
			case 1073742050:	//left ALT
				break;
			case 1073742054:	//ALTGR
				altgr = 1;
				break;
			case 1073741899:	//page up
				c = CPGUP;
				break;
			case 1073741902:	//page down
				c = CPGDN;
				break;
			case 13:			//return
				c = 10;
				break;
			default:
				c = evt.key.keysym.sym;
				break;
			}

			if (c == 0) {
				break;
			}

			if (shiftlock ^ shift) {
				c = toupper(c);
				for (int i = 0; i < sizeof(upperArrayFrom); i++) {
					if (upperArrayFrom[i] == c) {
						c = upperArrayTo[i];
					}
				}
			}

			if (strg) {
				if (c == CCHM) {	//key = POS1?
					c = CLS;		//CLS
				} else {
					c = toupper(c) - 'A' + 1;
				}
			}

			if (altgr) {
				SDL_Log("key: %d %d", c, evt.key.keysym.sym);
				switch (c) {
				case 17:
					c = '@';
					break;
				case 159:
					c = '\\';
					break;
				case 235:
					c = '~';
					break;
				case 248:
					c = '[';
					break;
				case 249:
					c = ']';
					break;
				case 252:
					c = '|';
					break;
				case 247:
					c = '{';
					break;
				case 240:
					c = '}';
					break;
				}
			}

			kimo.kbda = c;
			kimo.kbmost = 1;

			ram[0x244] = superflag;
			ram[0x32E] = c;
			ram[0x32D] = 0;

			//SDL_Log("key: %d %d", c, evt.key.keysym.sym);

			break;

		case SDL_KEYUP:
			//F1 = LEFT SHFT;
			switch (evt.key.keysym.sym) {
			case 1073742049:
			case 1073742053:
				shift = 0;
				break;
			case 1073742048:	//left STRG
			case 1073742052:	//right STRG
				strg = 0;
				break;
			case 1073742054:	//ALTGR
				altgr = 0;
				break;
			default:
				break;
			}

			break;

		case SDL_QUIT:
			/* There simply has to be a better way... */
			saveDiskImage();
			exit(0);
			break;
		}
	}

	CPUEvent_schedule(&kimoCheckEvent, 100000, &kimo_update);
}

int kimo_initialize(void) {

	loadDiskImage();

	memset(&kimo, 0, sizeof(IO_KIMO));

	CPUEvent_schedule(&kimoCheckEvent, 400, &kimo_update);

	SDL_CreateThread(kimo_timer, "TimerThread", 0);

	return 1;
}
