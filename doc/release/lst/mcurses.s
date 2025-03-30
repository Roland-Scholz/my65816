;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * mcurses.c - mcurses lib
; *
; * Copyright (c) 2011-2015 Frank Meyer - frank(at)fli4l.de
; *
; * This program is free software; you can redistribute it and/or modify
; * it under the terms of the GNU General Public License as published by
; * the Free Software Foundation; either version 2 of the License, or
; * (at your option) any later version.
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;#define unix
;
;#include <stdio.h>
;#include <stdlib.h>
;#include <string.h>
;
;#ifdef unix
;#include <termio.h>
;#include <fcntl.h>
	code
	func
~~__cmsg_nxthdr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
__ctl_0	set	4
__size_0	set	8
__cmsg_0	set	12
__ptr_1	set	0
	lda	#$3
	clc
	adc	[<L2+__cmsg_0]
	sta	<R0
	lda	#$0
	ldy	#$2
	adc	[<L2+__cmsg_0],Y
	sta	<R0+2
	lda	<R0
	and	#<$fffffffc
	sta	<R1
	lda	<R0+2
	sta	<R1+2
	lda	<L2+__cmsg_0
	clc
	adc	<R1
	sta	<L3+__ptr_1
	lda	<L2+__cmsg_0+2
	adc	<R1+2
	sta	<L3+__ptr_1+2
	lda	#$8
	clc
	adc	<L3+__ptr_1
	sta	<R0
	lda	#$0
	adc	<L3+__ptr_1+2
	sta	<R0+2
	sec
	lda	<R0
	sbc	<L2+__ctl_0
	sta	<R1
	lda	<R0+2
	sbc	<L2+__ctl_0+2
	sta	<R1+2
	lda	<L2+__size_0
	cmp	<R1
	lda	<L2+__size_0+2
	sbc	<R1+2
	bcs	L10001
	lda	#$0
	tax
L5:
	tay
	lda	<L2+2
	sta	<L2+2+12
	lda	<L2+1
	sta	<L2+1+12
	pld
	tsc
	clc
	adc	#L2+12
	tcs
	tya
	rtl
L10001:
	ldx	<L3+__ptr_1+2
	lda	<L3+__ptr_1
	bra	L5
L2	equ	12
L3	equ	9
	ends
	efunc
	code
	func
~~cmsg_nxthdr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L6
	tcs
	phd
	tcd
__msg_0	set	4
__cmsg_0	set	8
	pei	<L6+__cmsg_0+2
	pei	<L6+__cmsg_0
	ldy	#$14
	lda	[<L6+__msg_0],Y
	pha
	dey
	dey
	lda	[<L6+__msg_0],Y
	pha
	dey
	dey
	lda	[<L6+__msg_0],Y
	pha
	dey
	dey
	lda	[<L6+__msg_0],Y
	pha
	jsl	~~__cmsg_nxthdr
	sta	<R0
	stx	<R0+2
	ldx	<R0+2
	lda	<R0
	tay
	lda	<L6+2
	sta	<L6+2+8
	lda	<L6+1
	sta	<L6+1+8
	pld
	tsc
	clc
	adc	#L6+8
	tcs
	tya
	rtl
L6	equ	4
L7	equ	5
	ends
	efunc
;#define PROGMEM
;#define PSTR(x)                                 (x)
;#define pgm_read_byte(s)                        (*s)
;#elif (defined __SDCC_z80)
;#define PROGMEM
;#define PSTR(x)                                 (x)
;#define pgm_read_byte(s)                        (*s)
;
;#elif (defined STM32F4XX)
;#ifndef HSE_VALUE
;#define HSE_VALUE                               ((uint32_t)8000000)         /* STM32F4 discovery uses a 8Mhz external crystal */
;#endif
;#include "stm32f4xx.h"
;#include "stm32f4xx_gpio.h"
;#include "stm32f4xx_usart.h"
;#include "stm32f4xx_rcc.h"
;#include "misc.h"
;#define PROGMEM
;#define PSTR(x)                                 (x)
;#define pgm_read_byte(s)                        (*s)
;
;#elif (defined STM32F10X)
;#ifndef HSE_VALUE
;#define HSE_VALUE                               ((uint32_t)8000000)         /* STM32F4 discovery uses a 8Mhz external crystal */
;#endif
;#include "stm32f10x.h"
;#include "stm32f10x_gpio.h"
;#include "stm32f10x_usart.h"
;#include "stm32f10x_rcc.h"
;#include "misc.h"
;#define PROGMEM
;#define PSTR(x)                                 (x)
;#define pgm_read_byte(s)                        (*s)
;
;#else // AVR
;#include <avr/io.h>
;#include <avr/pgmspace.h>
;#include <avr/interrupt.h>
;#endif
;
;#include "mcurses.h"
;
;#define SEQ_CSI                                 PSTR("\033[")                   // code introducer
;#define SEQ_CLEAR                               PSTR("\033[2J")                 // clear screen
;#define SEQ_CLRTOBOT                            PSTR("\033[J")                  // clear to bottom
;#define SEQ_CLRTOEOL                            PSTR("\033[K")                  // clear to end of line
;#define SEQ_DELCH                               PSTR("\033[P")                  // delete character
;#define SEQ_NEXTLINE                            PSTR("\033E")                   // goto next line (scroll up at end of scrolling region)
;#define SEQ_INSERTLINE                          PSTR("\033[L")                  // insert line
;#define SEQ_DELETELINE                          PSTR("\033[M")                  // delete line
;#define SEQ_ATTRSET                             PSTR("\033[0")                  // set attributes, e.g. "\033[0;7;1m"
;#define SEQ_ATTRSET_REVERSE                     PSTR(";7")                      // reverse
;#define SEQ_ATTRSET_UNDERLINE                   PSTR(";4")                      // underline
;#define SEQ_ATTRSET_BLINK                       PSTR(";5")                      // blink
;#define SEQ_ATTRSET_BOLD                        PSTR(";1")                      // bold
;#define SEQ_ATTRSET_DIM                         PSTR(";2")                      // dim
;#define SEQ_ATTRSET_FCOLOR                      PSTR(";3")                      // forground color
;#define SEQ_ATTRSET_BCOLOR                      PSTR(";4")                      // background color
;#define SEQ_INSERT_MODE                         PSTR("\033[4h")                 // set insert mode
;#define SEQ_REPLACE_MODE                        PSTR("\033[4l")                 // set replace mode
;#define SEQ_RESET_SCRREG                        PSTR("\033[r")                  // reset scrolling region
;#define SEQ_LOAD_G1                             PSTR("\033)0")                  // load G1 character set
;#define SEQ_CURSOR_VIS                          PSTR("\033[?25")                // set cursor visible/not visible
;
;static uint_fast8_t                             mcurses_scrl_start = 0;         // start of scrolling region, default is 0
	data
~~mcurses_scrl_start:
	db	$0
	ends
;static uint_fast8_t                             mcurses_scrl_end = LINES - 1;   // end of scrolling region, default is last line
	data
~~mcurses_scrl_end:
	db	$18
	ends
;static uint_fast8_t                             mcurses_nodelay;                // nodelay flag
;static uint_fast8_t                             mcurses_halfdelay;              // halfdelay value, in tenths of a second
;
;uint_fast8_t                                    mcurses_is_up = 0;              // flag: mcurses is up
	data
	xdef	~~mcurses_is_up
~~mcurses_is_up:
	db	$0
	ends
;uint_fast8_t                                    mcurses_cury = 0xff;            // current y position of cursor, public (getyx())
	data
	xdef	~~mcurses_cury
~~mcurses_cury:
	db	$FF
	ends
;uint_fast8_t                                    mcurses_curx = 0xff;            // current x position of cursor, public (getyx())
	data
	xdef	~~mcurses_curx
~~mcurses_curx:
	db	$FF
	ends
;
;static void                                     mcurses_puts_P (const char *);
;
;#if defined(unix)
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: init, done, putc, getc, nodelay, halfdelay, flush for UNIX or LINUX
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;static struct termio                            mcurses_oldmode;
;static struct termio                            mcurses_newmode;
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: init (unix/linux)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;static uint_fast8_t
;mcurses_phyio_init (void)
;{
	code
	func
~~mcurses_phyio_init:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L9
	tcs
	phd
	tcd
;    uint_fast8_t    rtc = 0;
;    int             fd;
;
;    fd = fileno (stdin);
rtc_1	set	0
fd_1	set	1
	sep	#$20
	longa	off
	stz	<L10+rtc_1
	rep	#$20
	longa	on
	lda	|~~stdin+2
	pha
	lda	|~~stdin
	pha
	jsl	~~fileno
	sta	<L10+fd_1
;
;    if (ioctl (fd, TCGETA, &mcurses_oldmode) >= 0 || ioctl (fd, TCGETA, &mcurses_newmode) >= 0)
;    {
	lda	#<~~mcurses_oldmode
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	pea	#^$5405
	pea	#<$5405
	pei	<L10+fd_1
	pea	#12
	jsl	~~ioctl
	sta	<R1
	lda	<R1
	bpl	L11
	lda	#<~~mcurses_newmode
	sta	<R1
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R1
	pea	#^$5405
	pea	#<$5405
	pei	<L10+fd_1
	pea	#12
	jsl	~~ioctl
	sta	<R2
	lda	<R2
	bmi	L10002
L11:
;        mcurses_newmode.c_lflag &= ~ICANON;                                         // switch off canonical input
	lda	#$2
	trb	|~~mcurses_newmode+6
;        mcurses_newmode.c_lflag &= ~ECHO;                                           // switch off echo
	lda	#$8
	trb	|~~mcurses_newmode+6
;        mcurses_newmode.c_iflag &= ~ICRNL;                                          // switch off CR->NL mapping
	lda	#$100
	trb	|~~mcurses_newmode
;        mcurses_newmode.c_oflag &= ~TAB3;                                           // switch off TAB conversion
	lda	#$1800
	trb	|~~mcurses_newmode+2
;        mcurses_newmode.c_cc[VINTR] = '\377';                                       // disable VINTR VQUIT
	sep	#$20
	longa	off
	lda	#$ff
	sta	|~~mcurses_newmode+9
;        mcurses_newmode.c_cc[VQUIT] = '\377';                                       // but don't touch VSWTCH
	sta	|~~mcurses_newmode+10
;        mcurses_newmode.c_cc[VMIN] = 1;                                             // block input:
	lda	#$1
	sta	|~~mcurses_newmode+15
;        mcurses_newmode.c_cc[VTIME] = 0;                                            // one character
	stz	|~~mcurses_newmode+14
	rep	#$20
	longa	on
;
;        if (ioctl (fd, TCSETAW, &mcurses_newmode) >= 0)
;        {
	lda	#<~~mcurses_newmode
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	pea	#^$5407
	pea	#<$5407
	pei	<L10+fd_1
	pea	#12
	jsl	~~ioctl
	sta	<R1
	lda	<R1
	bmi	L10002
;            rtc = 1;
	sep	#$20
	longa	off
	lda	#$1
	sta	<L10+rtc_1
	rep	#$20
	longa	on
;        }
;    }
;
;    return rtc;
L10002:
	lda	<L10+rtc_1
	and	#$ff
	tay
	pld
	tsc
	clc
	adc	#L9
	tcs
	tya
	rtl
;}
L9	equ	15
L10	equ	13
	ends
	efunc
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: done (unix/linux)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;static void
;mcurses_phyio_done (void)
;{
	code
	func
~~mcurses_phyio_done:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L16
	tcs
	phd
	tcd
;    int     fd;
;
;    fd = fileno (stdin);
fd_1	set	0
	lda	|~~stdin+2
	pha
	lda	|~~stdin
	pha
	jsl	~~fileno
	sta	<L17+fd_1
;
;    (void) ioctl (fd, TCSETAW, &mcurses_oldmode);
	lda	#<~~mcurses_oldmode
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	pea	#^$5407
	pea	#<$5407
	pei	<L17+fd_1
	pea	#12
	jsl	~~ioctl
;}
	pld
	tsc
	clc
	adc	#L16
	tcs
	rtl
L16	equ	10
L17	equ	9
	ends
	efunc
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: putc (unix/linux)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;static void
;mcurses_phyio_putc (uint_fast8_t ch)
;{
	code
	func
~~mcurses_phyio_putc:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L19
	tcs
	phd
	tcd
ch_0	set	4
;    putchar (ch);
	lda	|~~stdout+2
	pha
	lda	|~~stdout
	pha
	lda	<L19+ch_0
	and	#$ff
	pha
	jsl	~~fputc
;}
	lda	<L19+2
	sta	<L19+2+2
	lda	<L19+1
	sta	<L19+1+2
	pld
	tsc
	clc
	adc	#L19+2
	tcs
	rtl
L19	equ	0
L20	equ	1
	ends
	efunc
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: getc (unix/linux)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;static uint_fast8_t
;mcurses_phyio_getc (void)
;{
	code
	func
~~mcurses_phyio_getc:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L22
	tcs
	phd
	tcd
;    uint_fast8_t ch;
;
;    ch = getchar ();
ch_1	set	0
	lda	|~~stdin+2
	pha
	lda	|~~stdin
	pha
	jsl	~~fgetc
	sep	#$20
	longa	off
	sta	<L23+ch_1
	rep	#$20
	longa	on
;
;    return (ch);
	lda	<L23+ch_1
	and	#$ff
	tay
	pld
	tsc
	clc
	adc	#L22
	tcs
	tya
	rtl
;}
L22	equ	1
L23	equ	1
	ends
	efunc
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: set/reset nodelay (unix/linux)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;static void
;mcurses_phyio_nodelay (uint_fast8_t flag)
;{
	code
	func
~~mcurses_phyio_nodelay:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L25
	tcs
	phd
	tcd
flag_0	set	4
;    int     fd;
;    int     fl;
;
;    fd = fileno (stdin);
fd_1	set	0
fl_1	set	2
	lda	|~~stdin+2
	pha
	lda	|~~stdin
	pha
	jsl	~~fileno
	sta	<L26+fd_1
;
;    if ((fl = fcntl (fd, F_GETFL, 0)) >= 0)
;    {
	pea	#<$0
	pea	#<$3
	pei	<L26+fd_1
	pea	#8
	jsl	~~fcntl
	sta	<L26+fl_1
	lda	<L26+fl_1
	bmi	L29
;        if (flag)
;        {
	lda	<L25+flag_0
	and	#$ff
	beq	L10005
;            fl |= O_NDELAY;
	lda	#$800
	tsb	<L26+fl_1
;        }
;        else
	bra	L10006
L10005:
;        {
;            fl &= ~O_NDELAY;
	lda	#$800
	trb	<L26+fl_1
;        }
L10006:
;        (void) fcntl (fd, F_SETFL, fl);
	pei	<L26+fl_1
	pea	#<$4
	pei	<L26+fd_1
	pea	#8
	jsl	~~fcntl
;        mcurses_nodelay = flag;
	sep	#$20
	longa	off
	lda	<L25+flag_0
	sta	|~~mcurses_nodelay
	rep	#$20
	longa	on
;    }
;}
L29:
	lda	<L25+2
	sta	<L25+2+2
	lda	<L25+1
	sta	<L25+1+2
	pld
	tsc
	clc
	adc	#L25+2
	tcs
	rtl
L25	equ	8
L26	equ	5
	ends
	efunc
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: set/reset halfdelay (unix/linux)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;static void
;mcurses_phyio_halfdelay (uint_fast8_t tenths)
;{
	code
	func
~~mcurses_phyio_halfdelay:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L30
	tcs
	phd
	tcd
tenths_0	set	4
;    if (tenths == 0)
;    {
	lda	<L30+tenths_0
	and	#$ff
	bne	L10007
;        mcurses_newmode.c_cc[VMIN] = 1;                        /* block input:     */
	sep	#$20
	longa	off
	lda	#$1
	sta	|~~mcurses_newmode+15
;        mcurses_newmode.c_cc[VTIME] = 0;                       /* one character    */
	stz	|~~mcurses_newmode+14
	rep	#$20
	longa	on
;    }
;    else
	bra	L10008
L10007:
;    {
;        mcurses_newmode.c_cc[VMIN] = 0;                        /* set timeout      */
	sep	#$20
	longa	off
	stz	|~~mcurses_newmode+15
;        mcurses_newmode.c_cc[VTIME] = tenths;                  /* in tenths of sec */
	lda	<L30+tenths_0
	sta	|~~mcurses_newmode+14
	rep	#$20
	longa	on
;    }
L10008:
;
;    mcurses_halfdelay = tenths;
	sep	#$20
	longa	off
	lda	<L30+tenths_0
	sta	|~~mcurses_halfdelay
	rep	#$20
	longa	on
;
;    (void) ioctl (0, TCSETAW, &mcurses_newmode);
	lda	#<~~mcurses_newmode
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	pea	#^$5407
	pea	#<$5407
	pea	#<$0
	pea	#12
	jsl	~~ioctl
;}
	lda	<L30+2
	sta	<L30+2+2
	lda	<L30+1
	sta	<L30+1+2
	pld
	tsc
	clc
	adc	#L30+2
	tcs
	rtl
L30	equ	8
L31	equ	9
	ends
	efunc
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: flush output (unix/linux)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;static void
;mcurses_phyio_flush_output ()
;{
	code
	func
~~mcurses_phyio_flush_output:
	longa	on
	longi	on
;    fflush (stdout);
	lda	|~~stdout+2
	pha
	lda	|~~stdout
	pha
	jsl	~~fflush
;}
	rtl
L34	equ	0
L35	equ	1
	ends
	efunc
;
;#elif defined (__SDCC_z80)
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: init (SDCC Z80)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;static uint_fast8_t
;mcurses_phyio_init (void)
;{
;    return 1;
;}
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: done (SDCC Z80)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;static void
;mcurses_phyio_done (void)
;{
;}
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: putc (SDCC Z80)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;static void
;mcurses_phyio_putc (uint_fast8_t ch)
;{
;    putchar (ch);
;}
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: getc (SDCC Z80)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;static uint_fast8_t
;mcurses_phyio_getc (void)
;{
;    uint_fast8_t    ch;
;
;    ch = getchar ();
;    return (ch);
;}
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: set/reset nodelay (SDCC Z80)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;static void
;mcurses_phyio_nodelay (uint_fast8_t flag)
;{
;    mcurses_nodelay = flag;
;}
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: set/reset halfdelay (SDCC Z80)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;static void
;mcurses_phyio_halfdelay (uint_fast8_t tenths)
;{
;    mcurses_halfdelay = tenths;
;}
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: flush output (SDCC Z80)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;static void
;mcurses_phyio_flush_output ()
;{
;}
;
;#elif defined(STM32F4XX) || defined(STM32F10X)
;
;#if MCURSES_UART_NUMBER == 0        // USB
;
;#include "stm32f4xx_exti.h"
;#include "usbd_cdc_core.h"
;#include "usbd_usr.h"
;#include "usbd_desc.h"
;#include "usbd_cdc_vcp.h"
;#include "usb_dcd_int.h"
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: init, done, putc, getc, nodelay, halfdelay, flush for STM32F4XX USB
; *
; * The USB data must be 4 byte aligned if DMA is enabled. This macro handles
; * the alignment, if necessary (it's actually magic, but don't tell anyone).
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;__ALIGN_BEGIN USB_OTG_CORE_HANDLE  USB_OTG_dev __ALIGN_END;
;
;void SysTick_Handler(void);
;void NMI_Handler(void);
;void HardFault_Handler(void);
;void MemManage_Handler(void);
;void BusFault_Handler(void);
;void UsageFault_Handler(void);
;void SVC_Handler(void);
;void DebugMon_Handler(void);
;void PendSV_Handler(void);
;void OTG_FS_IRQHandler(void);
;void OTG_FS_WKUP_IRQHandler(void);
;
;static volatile uint32_t halfdelay_counter;
;
;void SysTick_Handler(void)
;{
;    if (halfdelay_counter > 0)
;    {
;        halfdelay_counter--;
;    }
;}
;
;static void
;die(void)
;{
;    while (1)
;    {
;        ;
;    }
;}
;
;void NMI_Handler(void)       {}
;void HardFault_Handler(void) { die(); }
;void MemManage_Handler(void) { die(); }
;void BusFault_Handler(void)  { die(); }
;void UsageFault_Handler(void){ die(); }
;void SVC_Handler(void)       {}
;void DebugMon_Handler(void)  {}
;void PendSV_Handler(void)    {}
;
;void OTG_FS_IRQHandler(void)
;{
;    USBD_OTG_ISR_Handler (&USB_OTG_dev);
;}
;
;void OTG_FS_WKUP_IRQHandler(void)
;{
;    if(USB_OTG_dev.cfg.low_power)
;    {
;        *(uint32_t *)(0xE000ED10) &= 0xFFFFFFF9 ;
;        SystemInit();
;        USB_OTG_UngateClock(&USB_OTG_dev);
;    }
;    EXTI_ClearITPendingBit(EXTI_Line18);
;}
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: init (STM32F4XX USB)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;static uint_fast8_t
;mcurses_phyio_init (void)
;{
;    static uint_fast8_t already_called = 0;
;    uint_fast8_t        rtc = 1;
;    uint_fast8_t        cnt = 0;
;    uint8_t             ch;
;
;    if (! already_called)
;    {
;        SysTick_Config(SystemCoreClock / 1000);
;        USBD_Init(&USB_OTG_dev, USB_OTG_FS_CORE_ID, &USR_desc, &USBD_CDC_cb, &USR_cb);
;        already_called = 1;
;    }
;
;    halfdelay_counter = 1000;
;
;    while (! VCP_get_char (&ch))                                // wait until character available
;    {
;        if (halfdelay_counter == 0)
;        {
;            mcurses_puts_P ("Press any key to start...\r\n");
;
;            cnt++;
;
;            if (cnt > 10)                                           // after 10 seconds timeout
;            {
;                rtc = 0;
;                break;
;            }
;
;            halfdelay_counter = 1000;
;        }
;    }
;
;    halfdelay_counter = 0;
;    return rtc;
;}
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: done (STM32F4XX USB)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;static void
;mcurses_phyio_done (void)
;{
;}
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: putc (STM32F4XX USB)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;static void
;mcurses_phyio_putc (uint_fast8_t ch)
;{
;    VCP_put_char(ch);
;}
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: getc (STM32F4XX USB)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;static uint_fast8_t
;mcurses_phyio_getc (void)
;{
;    uint8_t ch;
;
;    if (mcurses_halfdelay)
;    {
;        halfdelay_counter = 100 * mcurses_halfdelay;
;    }
;
;    while (! VCP_get_char (&ch))                                // wait until character available
;    {
;        if (mcurses_nodelay)
;        {                                                       // if nodelay set, return ERR
;            return (ERR);
;        }
;
;        if (mcurses_halfdelay && halfdelay_counter == 0)
;        {
;            return (ERR);
;        }
;    }
;
;    return ch;
;}
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: set/reset nodelay (STM32F4XX USB)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;static void
;mcurses_phyio_nodelay (uint_fast8_t flag)
;{
;    mcurses_nodelay = flag;
;}
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: set/reset halfdelay (STM32FXX USB)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;static void
;mcurses_phyio_halfdelay (uint_fast8_t tenths)
;{
;    mcurses_halfdelay = tenths;
;}
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: flush output (STM32F4XX USB)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;static void
;mcurses_phyio_flush_output ()
;{
;}
;
;#else // MCURSES_UART_NUMBER != 0
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: init, done, putc, getc, nodelay, halfdelay, flush for STM32F4XX UART
; *
; *            UART1 : TX:[PA9,PB6] RX:[PA10,PB7]
; *            UART2 : TX:[PA2,PD5] RX:[PA3,PD6]
; *            UART3 : TX:[PB10,PC10,PD8] RX:[PB11,PC11,PD9]
; *            UART4 : TX:[PA0,PC10] RX:[PA1,PC11]
; *            UART5 : TX:[PC12] RX:[PD2]
; *            UART6 : TX:[PC6,PG14] RX:[PC7,PG9]
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;
;
;#define UART_TXBUFLEN                           64                              // 64 Bytes ringbuffer for UART
;#define UART_RXBUFLEN                           16                              // 16 Bytes ringbuffer for UART
;
;static volatile uint_fast8_t    uart_txbuf[UART_TXBUFLEN];                      // tx ringbuffer
;static volatile uint_fast8_t    uart_txsize = 0;                                // tx size
;static volatile uint_fast8_t    uart_rxbuf[UART_RXBUFLEN];                      // rx ringbuffer
;static volatile uint_fast8_t    uart_rxsize = 0;                                // rx size
;
;#define UART_NUMBER             MCURSES_UART_NUMBER
;#define BAUD                    MCURSES_BAUD
;
;#define _CONCAT(a,b)            a##b
;#define CONCAT(a,b)             _CONCAT(a,b)
;
;#if defined(STM32F4XX)
;
;#if UART_NUMBER == 1
;
;#define UART_TX_PORT_LETTER         A       // A9/A10 or B6/B7
;#define UART_TX_PIN_NUMBER          9
;#define UART_RX_PORT_LETTER         A
;#define UART_RX_PIN_NUMBER          10
;#define UART_GPIO_CLOCK_CMD         RCC_AHB2PeriphClockCmd
;#define UART_GPIO                   RCC_AHB2Periph_GPIO
;
;#define UART_NAME                   USART1
;#define UART_USART_CLOCK_CMD        RCC_APB2PeriphClockCmd
;#define UART_USART_CLOCK            RCC_APB2Periph_USART1
;#define UART_GPIO_AF_UART           GPIO_AF_USART1
;#define UART_IRQ_HANDLER            USART1_IRQHandler
;#define UART_IRQ_CHANNEL            USART1_IRQn
;
;#elif UART_NUMBER == 2
;
;#define UART_TX_PORT_LETTER         A       // A2/A3 or D5/D6
;#define UART_TX_PIN_NUMBER          2
;#define UART_RX_PORT_LETTER         A
;#define UART_RX_PIN_NUMBER          3
;#define UART_GPIO_CLOCK_CMD         RCC_AHB1PeriphClockCmd
;#define UART_GPIO                   RCC_AHB1Periph_GPIO
;
;#define UART_NAME                   USART2
;#define UART_USART_CLOCK_CMD        RCC_APB1PeriphClockCmd
;#define UART_USART_CLOCK            RCC_APB1Periph_USART2
;#define UART_GPIO_AF_UART           GPIO_AF_USART2
;#define UART_IRQ_HANDLER            USART2_IRQHandler
;#define UART_IRQ_CHANNEL            USART2_IRQn
;
;#elif UART_NUMBER == 3
;
;#define UART_TX_PORT_LETTER         D       // D8/D9 or B10/B11 or C10/C11
;#define UART_TX_PIN_NUMBER          8
;#define UART_RX_PORT_LETTER         D
;#define UART_RX_PIN_NUMBER          9
;#define UART_GPIO_CLOCK_CMD         RCC_AHB1PeriphClockCmd
;#define UART_GPIO                   RCC_AHB1Periph_GPIO
;
;#define UART_NAME                   USART3
;#define UART_USART_CLOCK_CMD        RCC_APB1PeriphClockCmd
;#define UART_USART_CLOCK            RCC_APB1Periph_USART3
;#define UART_GPIO_AF_UART           GPIO_AF_USART3
;#define UART_IRQ_HANDLER            USART3_IRQHandler
;#define UART_IRQ_CHANNEL            USART3_IRQn
;
;#elif UART_NUMBER == 4
;
;#define UART_TX_PORT_LETTER         A       // A0/A1 or C10/C11
;#define UART_TX_PIN_NUMBER          0
;#define UART_RX_PORT_LETTER         A
;#define UART_RX_PIN_NUMBER          1
;#define UART_GPIO_CLOCK_CMD         RCC_AHB1PeriphClockCmd
;#define UART_GPIO                   RCC_AHB1Periph_GPIO
;
;#define UART_NAME                   USART4
;#define UART_USART_CLOCK_CMD        RCC_APB1PeriphClockCmd
;#define UART_USART_CLOCK            RCC_APB1Periph_USART4
;#define UART_GPIO_AF_UART           GPIO_AF_USART4
;#define UART_IRQ_HANDLER            USART4_IRQHandler
;#define UART_IRQ_CHANNEL            USART4_IRQn
;
;#elif UART_NUMBER == 5
;
;#define UART_TX_PORT_LETTER         C       // C12/D2
;#define UART_TX_PIN_NUMBER          12
;#define UART_RX_PORT_LETTER         D
;#define UART_RX_PIN_NUMBER          2
;#define UART_GPIO_CLOCK_CMD         RCC_AHB1PeriphClockCmd
;#define UART_GPIO                   RCC_AHB1Periph_GPIO
;
;#define UART_NAME                   USART5
;#define UART_USART_CLOCK_CMD        RCC_APB1PeriphClockCmd
;#define UART_USART_CLOCK            RCC_APB1Periph_USART5
;#define UART_GPIO_AF_UART           GPIO_AF_USART5
;#define UART_IRQ_HANDLER            USART5_IRQHandler
;#define UART_IRQ_CHANNEL            USART5_IRQn
;
;#elif UART_NUMBER == 6
;
;#define UART_TX_PORT_LETTER         C       // C6/C7 or G14/G9
;#define UART_TX_PIN_NUMBER          6
;#define UART_RX_PORT_LETTER         C
;#define UART_RX_PIN_NUMBER          7
;#define UART_GPIO_CLOCK_CMD         RCC_AHB2PeriphClockCmd
;#define UART_GPIO                   RCC_AHB2Periph_GPIO
;
;#define UART_NAME                   USART6
;#define UART_USART_CLOCK_CMD        RCC_APB2PeriphClockCmd
;#define UART_USART_CLOCK            RCC_APB2Periph_USART6
;#define UART_GPIO_AF_UART           GPIO_AF_USART6
;#define UART_IRQ_HANDLER            USART6_IRQHandler
;#define UART_IRQ_CHANNEL            USART6_IRQn
;
;#else
;#error wrong number for UART_NUMBER, choose 1-6
;#endif
;
;#elif defined(STM32F10X)
;
;#if UART_NUMBER == 1
;
;#define UART_TX_PORT_LETTER     A
;#define UART_TX_PIN_NUMBER      9
;#define UART_RX_PORT_LETTER     A
;#define UART_RX_PIN_NUMBER      10
;#define UART_GPIO_CLOCK_CMD     RCC_APB2PeriphClockCmd
;#define UART_GPIO               RCC_APB2Periph_GPIO
;
;#define UART_NAME               USART1
;#define UART_USART_CLOCK_CMD    RCC_APB2PeriphClockCmd
;#define UART_USART_CLOCK        RCC_APB2Periph_USART1
;#define UART_GPIO_AF_UART       GPIO_AF_USART1
;#define UART_IRQ_HANDLER        USART1_IRQHandler
;#define UART_IRQ_CHANNEL        USART1_IRQn
;
;#elif UART_NUMBER == 2
;
;#define UART_TX_PORT_LETTER     A
;#define UART_TX_PIN_NUMBER      2
;#define UART_RX_PORT_LETTER     A
;#define UART_RX_PIN_NUMBER      3
;#define UART_GPIO_CLOCK_CMD     RCC_APB2PeriphClockCmd
;#define UART_GPIO               RCC_APB2Periph_GPIO
;
;#define UART_NAME               USART2
;#define UART_USART_CLOCK_CMD    RCC_APB1PeriphClockCmd
;#define UART_USART_CLOCK        RCC_APB1Periph_USART2
;#define UART_GPIO_AF_UART       GPIO_AF_USART2
;#define UART_IRQ_HANDLER        USART2_IRQHandler
;#define UART_IRQ_CHANNEL        USART2_IRQn
;
;#elif UART_NUMBER == 3
;
;#define UART_TX_PORT_LETTER     B
;#define UART_TX_PIN_NUMBER      10
;#define UART_RX_PORT_LETTER     B
;#define UART_RX_PIN_NUMBER      11
;#define UART_GPIO_CLOCK_CMD     RCC_APB2PeriphClockCmd
;#define UART_GPIO               RCC_APB2Periph_GPIO
;
;#define UART_NAME               USART3
;#define UART_USART_CLOCK_CMD    RCC_APB1PeriphClockCmd
;#define UART_USART_CLOCK        RCC_APB1Periph_USART3
;#define UART_GPIO_AF_UART       GPIO_AF_USART3
;#define UART_IRQ_HANDLER        USART3_IRQHandler
;#define UART_IRQ_CHANNEL        USART3_IRQn
;
;#else
;#error wrong number for UART_NUMBER, choose 1-3
;#endif
;
;#endif
;
;#define UART_TX_PORT                CONCAT(GPIO, UART_TX_PORT_LETTER)
;#define UART_TX_GPIO_CLOCK          CONCAT(UART_GPIO, UART_TX_PORT_LETTER)
;#define UART_TX_PIN                 CONCAT(GPIO_Pin_, UART_TX_PIN_NUMBER)
;#define UART_TX_PINSOURCE           CONCAT(GPIO_PinSource,  UART_TX_PIN_NUMBER)
;#define UART_RX_PORT                CONCAT(GPIO, UART_RX_PORT_LETTER)
;#define UART_RX_GPIO_CLOCK          CONCAT(UART_GPIO, UART_RX_PORT_LETTER)
;#define UART_RX_PIN                 CONCAT(GPIO_Pin_, UART_RX_PIN_NUMBER)
;#define UART_RX_PINSOURCE           CONCAT(GPIO_PinSource, UART_RX_PIN_NUMBER)
;
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: init (STM32F4XX UART)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;static uint_fast8_t
;mcurses_phyio_init (void)
;{
;    static uint_fast8_t already_called = 0;
;
;    if (! already_called)
;    {
;        already_called = 1;
;
;        GPIO_InitTypeDef    gpio;
;        USART_InitTypeDef   uart;
;        NVIC_InitTypeDef    nvic;
;
;        UART_GPIO_CLOCK_CMD (UART_TX_GPIO_CLOCK, ENABLE);
;        UART_GPIO_CLOCK_CMD (UART_RX_GPIO_CLOCK, ENABLE);
;
;        UART_USART_CLOCK_CMD (UART_USART_CLOCK, ENABLE);
;
;        // connect UART functions with IO-Pins
;#if defined (STM32F4XX)
;        GPIO_PinAFConfig (UART_TX_PORT, UART_TX_PINSOURCE, UART_GPIO_AF_UART);      // TX
;        GPIO_PinAFConfig (UART_RX_PORT, UART_RX_PINSOURCE, UART_GPIO_AF_UART);      // RX
;
;        // UART as alternate function with PushPull
;        gpio.GPIO_Mode  = GPIO_Mode_AF;
;        gpio.GPIO_Speed = GPIO_Speed_100MHz;
;        gpio.GPIO_OType = GPIO_OType_PP;
;        gpio.GPIO_PuPd  = GPIO_PuPd_UP;                                             // fm: perhaps better: GPIO_PuPd_NOPULL
;
;        gpio.GPIO_Pin = UART_TX_PIN;
;        GPIO_Init(UART_TX_PORT, &gpio);
;
;        gpio.GPIO_Pin = UART_RX_PIN;
;        GPIO_Init(UART_RX_PORT, &gpio);
;
;#elif defined (STM32F10X)
;
;        /* TX Pin */
;        gpio.GPIO_Pin = UART_TX_PIN;
;        gpio.GPIO_Mode = GPIO_Mode_AF_PP;
;        gpio.GPIO_Speed = GPIO_Speed_50MHz;
;        GPIO_Init(GPIOA, &gpio);
;
;        /* RX Pin */
;        gpio.GPIO_Pin = UART_RX_PIN;
;        gpio.GPIO_Mode = GPIO_Mode_IPU;
;        gpio.GPIO_Speed = GPIO_Speed_50MHz;
;        GPIO_Init(GPIOA, &gpio);
;
;#endif
;
;        USART_OverSampling8Cmd(UART_NAME, ENABLE);
;
;        // 8 bits, 1 stop bit, no parity, no RTS+CTS
;        uart.USART_BaudRate             = MCURSES_BAUD;
;        uart.USART_WordLength           = USART_WordLength_8b;
;        uart.USART_StopBits             = USART_StopBits_1;
;        uart.USART_Parity               = USART_Parity_No;
;        uart.USART_HardwareFlowControl  = USART_HardwareFlowControl_None;
;        uart.USART_Mode                 = USART_Mode_Rx | USART_Mode_Tx;
;
;        USART_Init(UART_NAME, &uart);
;
;        // UART enable
;        USART_Cmd(UART_NAME, ENABLE);
;
;        // RX-Interrupt enable
;        USART_ITConfig(UART_NAME, USART_IT_RXNE, ENABLE);
;
;        // enable UART Interrupt-Vector
;        nvic.NVIC_IRQChannel                    = UART_IRQ_CHANNEL;
;        nvic.NVIC_IRQChannelPreemptionPriority  = 0;
;        nvic.NVIC_IRQChannelSubPriority         = 0;
;        nvic.NVIC_IRQChannelCmd                 = ENABLE;
;        NVIC_Init (&nvic);
;    }
;    return 1;
;}
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: done (STM32F4XX UART)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;static void
;mcurses_phyio_done (void)
;{
;}
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: putc (STM32F4XX UART)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;static void
;mcurses_phyio_putc (uint_fast8_t ch)
;{
;    static uint_fast8_t uart_txstop  = 0;                                       // tail
;
;    while (uart_txsize >= UART_TXBUFLEN)                                        // buffer full?
;    {                                                                           // yes
;        ;                                                                       // wait
;    }
;
;    uart_txbuf[uart_txstop++] = ch;                                             // store character
;
;    if (uart_txstop >= UART_TXBUFLEN)                                           // at end of ringbuffer?
;    {                                                                           // yes
;        uart_txstop = 0;                                                        // reset to beginning
;    }
;
;    __disable_irq();
;    uart_txsize++;                                                              // increment used size
;    __enable_irq();
;
;    USART_ITConfig(UART_NAME, USART_IT_TXE, ENABLE);                           // enable TXE interrupt
;}
;
;#if 0
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: putc - non-interrupt version (STM32F4XX UART)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;static void
;mcurses_phyio_putc (uint_fast8_t ch)
;{
;    while (USART_GetFlagStatus(UART_NAME, USART_FLAG_TXE) == RESET)
;    {
;         ;
;    }
;    USART_SendData(UART_NAME, ch);
;}
;#endif
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: getc (STM32F4XX UART)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;static uint_fast8_t
;mcurses_phyio_getc (void)
;{
;    static uint_fast8_t  uart_rxstart = 0;                                      // head
;    uint_fast8_t         ch;
;
;    while (uart_rxsize == 0)                                                    // rx buffer empty?
;    {                                                                           // yes, wait
;        if (mcurses_nodelay)
;        {                                                                       // or if nodelay set, return ERR
;            return (ERR);
;        }
;    }
;
;    ch = uart_rxbuf[uart_rxstart++];                                            // get character from ringbuffer
;
;    if (uart_rxstart == UART_RXBUFLEN)                                          // at end of rx buffer?
;    {                                                                           // yes
;        uart_rxstart = 0;                                                       // reset to beginning
;    }
;
;    __disable_irq();
;    uart_rxsize--;                                                              // decrement size
;    __enable_irq();
;
;    return (ch);
;}
;
;#if 0
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: getc - non-interrupt version (STM32F4XX UART)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;static uint_fast8_t
;mcurses_phyio_getc (void)
;{
;    uint_fast8_t ch;
;
;    while (USART_GetFlagStatus(UART_NAME, USART_FLAG_RXNE) == RESET)            // wait until character available
;    {
;        if (mcurses_nodelay)
;        {                                                                       // if nodelay set, return ERR
;            return (ERR);
;        }
;    }
;    ch = USART_ReceiveData(USART1);
;    return ch;
;}
;#endif
;
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: set/reset nodelay (STM32F4XX UART)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;static void
;mcurses_phyio_nodelay (uint_fast8_t flag)
;{
;    mcurses_nodelay = flag;
;}
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: set/reset halfdelay (STM32FXX UART)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;static void
;mcurses_phyio_halfdelay (uint_fast8_t tenths)
;{
;    mcurses_halfdelay = tenths;
;}
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: flush output (STM32F4XX UART)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;static void
;mcurses_phyio_flush_output ()
;{
;    while (uart_txsize > 0)                                                     // tx buffer empty?
;    {
;        ;                                                                       // no, wait
;    }
;}
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: UART RX/TX interrupt (STM32F4XX UART)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;void UART_IRQ_HANDLER (void)
;{
;    static uint_fast8_t     uart_rxstop  = 0;                                   // tail
;    uint16_t                value;
;    uint_fast8_t            ch;
;
;    if (USART_GetITStatus (UART_NAME, USART_IT_RXNE) != RESET)
;    {
;        USART_ClearITPendingBit (UART_NAME, USART_IT_RXNE);
;        value = USART_ReceiveData (UART_NAME);
;
;        ch = value & 0xFF;
;
;        if (uart_rxsize < UART_RXBUFLEN)                                        // buffer full?
;        {                                                                       // no
;            uart_rxbuf[uart_rxstop++] = ch;                                     // store character
;
;            if (uart_rxstop >= UART_RXBUFLEN)                                   // at end of ringbuffer?
;            {                                                                   // yes
;                uart_rxstop = 0;                                                // reset to beginning
;            }
;
;            uart_rxsize++;                                                      // increment used size
;        }
;    }
;
;    if (USART_GetITStatus (UART_NAME, USART_IT_TXE) != RESET)
;    {
;        static uint_fast8_t  uart_txstart = 0;                                  // head
;        uint_fast8_t         ch;
;
;        USART_ClearITPendingBit (UART_NAME, USART_IT_TXE);
;
;        if (uart_txsize > 0)                                                    // tx buffer empty?
;        {                                                                       // no
;            ch = uart_txbuf[uart_txstart++];                                    // get character to send, increment offset
;
;            if (uart_txstart == UART_TXBUFLEN)                                  // at end of tx buffer?
;            {                                                                   // yes
;                uart_txstart = 0;                                               // reset to beginning
;            }
;
;            uart_txsize--;                                                      // decrement size
;
;            USART_SendData(UART_NAME, ch);
;        }
;        else
;        {
;            USART_ITConfig(UART_NAME, USART_IT_TXE, DISABLE);                   // disable TXE interrupt
;        }
;    }
;    else
;    {
;        ;
;    }
;USART_ITConfig(UART_NAME, USART_IT_RXNE, ENABLE);
;}
;#endif // UART_NUMBER == 0
;
;#else // AVR
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: init, done, putc, getc for AVR
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;
;#define BAUD                                    MCURSES_BAUD
;#include <util/setbaud.h>
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * Newer ATmegas, e.g. ATmega88, ATmega168
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;#ifdef UBRR0H
;
;#define UART0_UBRRH                             UBRR0H
;#define UART0_UBRRL                             UBRR0L
;#define UART0_UCSRA                             UCSR0A
;#define UART0_UCSRB                             UCSR0B
;#define UART0_UCSRC                             UCSR0C
;#define UART0_UDRE_BIT_VALUE                    (1<<UDRE0)
;#define UART0_UCSZ1_BIT_VALUE                   (1<<UCSZ01)
;#define UART0_UCSZ0_BIT_VALUE                   (1<<UCSZ00)
;#ifdef URSEL0
;#define UART0_URSEL_BIT_VALUE                   (1<<URSEL0)
;#else
;#define UART0_URSEL_BIT_VALUE                   (0)
;#endif
;#define UART0_TXEN_BIT_VALUE                    (1<<TXEN0)
;#define UART0_RXEN_BIT_VALUE                    (1<<RXEN0)
;#define UART0_RXCIE_BIT_VALUE                   (1<<RXCIE0)
;#define UART0_UDR                               UDR0
;#define UART0_U2X                               U2X0
;#define UART0_RXC                               RXC0
;
;#ifdef USART0_TXC_vect                                                  // e.g. ATmega162 with 2 UARTs
;#define UART0_TXC_vect                          USART0_TXC_vect
;#define UART0_RXC_vect                          USART0_RXC_vect
;#define UART0_UDRE_vect                         USART0_UDRE_vect
;#elif defined(USART0_TX_vect)                                           // e.g. ATmega644 with 2 UARTs
;#define UART0_TXC_vect                          USART0_TX_vect
;#define UART0_RXC_vect                          USART0_RX_vect
;#define UART0_UDRE_vect                         USART0_UDRE_vect
;#else                                                                   // e.g. ATmega168 with 1 UART
;#define UART0_TXC_vect                          USART_TX_vect
;#define UART0_RXC_vect                          USART_RX_vect
;#define UART0_UDRE_vect                         USART_UDRE_vect
;#endif
;
;#define UART0_UDRIE                             UDRIE0
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * ATmegas with 2nd UART, e.g. ATmega162
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;#ifdef UBRR1H
;#define UART1_UBRRH                             UBRR1H
;#define UART1_UBRRL                             UBRR1L
;#define UART1_UCSRA                             UCSR1A
;#define UART1_UCSRB                             UCSR1B
;#define UART1_UCSRC                             UCSR1C
;#define UART1_UDRE_BIT_VALUE                    (1<<UDRE1)
;#define UART1_UCSZ1_BIT_VALUE                   (1<<UCSZ11)
;#define UART1_UCSZ0_BIT_VALUE                   (1<<UCSZ10)
;#ifdef URSEL1
;#define UART1_URSEL_BIT_VALUE                   (1<<URSEL1)
;#else
;#define UART1_URSEL_BIT_VALUE                   (0)
;#endif
;#define UART1_TXEN_BIT_VALUE                    (1<<TXEN1)
;#define UART1_RXEN_BIT_VALUE                    (1<<RXEN1)
;#define UART1_RXCIE_BIT_VALUE                   (1<<RXCIE1)
;#define UART1_UDR                               UDR1
;#define UART1_U2X                               U2X1
;#define UART1_RXC                               RXC1
;
;#ifdef USART1_TXC_vect                                                  // e.g. ATmega162 with 2 UARTs
;#define UART1_TXC_vect                          USART1_TXC_vect
;#define UART1_RXC_vect                          USART1_RXC_vect
;#define UART1_UDRE_vect                         USART1_UDRE_vect
;#else                                                                   // e.g. ATmega644 with 2 UARTs
;#define UART1_TXC_vect                          USART1_TX_vect
;#define UART1_RXC_vect                          USART1_RX_vect
;#define UART1_UDRE_vect                         USART1_UDRE_vect
;#endif
;
;#define UART1_UDRIE                             UDRIE1
;#endif // UBRR1H
;
;#else
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * older ATmegas, e.g. ATmega8, ATmega16
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;#define UART0_UBRRH                             UBRRH
;#define UART0_UBRRL                             UBRRL
;#define UART0_UCSRA                             UCSRA
;#define UART0_UCSRB                             UCSRB
;#define UART0_UCSRC                             UCSRC
;#define UART0_UDRE_BIT_VALUE                    (1<<UDRE)
;#define UART0_UCSZ1_BIT_VALUE                   (1<<UCSZ1)
;#define UART0_UCSZ0_BIT_VALUE                   (1<<UCSZ0)
;#ifdef URSEL
;#define UART0_URSEL_BIT_VALUE                   (1<<URSEL)
;#else
;#define UART0_URSEL_BIT_VALUE                   (0)
;#endif
;#define UART0_TXEN_BIT_VALUE                    (1<<TXEN)
;#define UART0_RXEN_BIT_VALUE                    (1<<RXEN)
;#define UART0_RXCIE_BIT_VALUE                   (1<<RXCIE)
;#define UART0_UDR                               UDR
;#define UART0_U2X                               U2X
;#define UART0_RXC                               RXC
;#define UART0_UDRE_vect                         USART_UDRE_vect
;#define UART0_TXC_vect                          USART_TXC_vect
;#define UART0_RXC_vect                          USART_RXC_vect
;#define UART0_UDRIE                             UDRIE
;
;#endif
;
;#define UART_TXBUFLEN                           64                              // 64 Bytes ringbuffer for UART
;#define UART_RXBUFLEN                           16                              // 16 Bytes ringbuffer for UART
;
;static volatile uint_fast8_t uart_txbuf[UART_TXBUFLEN];                         // tx ringbuffer
;static volatile uint_fast8_t uart_txsize = 0;                                   // tx size
;static volatile uint_fast8_t uart_rxbuf[UART_RXBUFLEN];                         // rx ringbuffer
;static volatile uint_fast8_t uart_rxsize = 0;                                   // rx size
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: init (AVR)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;static uint_fast8_t
;mcurses_phyio_init (void)
;{
;    UART0_UBRRH = UBRRH_VALUE;                                                  // set baud rate
;    UART0_UBRRL = UBRRL_VALUE;
;
;#if USE_2X
;    UART0_UCSRA |= (1<<UART0_U2X);
;#else
;    UART0_UCSRA &= ~(1<<UART0_U2X);
;#endif
;
;    UART0_UCSRC = UART0_UCSZ1_BIT_VALUE | UART0_UCSZ0_BIT_VALUE | UART0_URSEL_BIT_VALUE;    // 8 bit, no parity
;    UART0_UCSRB |= UART0_TXEN_BIT_VALUE | UART0_RXEN_BIT_VALUE | UART0_RXCIE_BIT_VALUE;     // enable UART TX, RX, and RX interrupt
;
;    return 1;
;}
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: done (AVR)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;static void
;mcurses_phyio_done (void)
;{
;}
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: putc (AVR)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;static void
;mcurses_phyio_putc (uint_fast8_t ch)
;{
;    static uint_fast8_t uart_txstop  = 0;                                       // tail
;
;    while (uart_txsize >= UART_TXBUFLEN)                                        // buffer full?
;    {                                                                           // yes
;        ;                                                                       // wait
;    }
;
;    uart_txbuf[uart_txstop++] = ch;                                             // store character
;
;    if (uart_txstop >= UART_TXBUFLEN)                                           // at end of ringbuffer?
;    {                                                                           // yes
;        uart_txstop = 0;                                                        // reset to beginning
;    }
;
;    cli();
;    uart_txsize++;                                                              // increment used size
;    sei();
;
;    UART0_UCSRB |= (1 << UART0_UDRIE);                                          // enable UDRE interrupt
;
;#if 0
;    while (!(UART0_UCSRA & UART0_UDRE_BIT_VALUE))
;    {
;        ;
;    }
;
;    UART0_UDR = ch;
;#endif
;}
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: getc (AVR)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;static uint_fast8_t
;mcurses_phyio_getc (void)
;{
;    static uint_fast8_t  uart_rxstart = 0;                                      // head
;    uint_fast8_t         ch;
;
;    while (uart_rxsize == 0)                                                    // rx buffer empty?
;    {                                                                           // yes, wait
;        if (mcurses_nodelay)
;        {                                                                       // or if nodelay set, return ERR
;            return (ERR);
;        }
;    }
;
;    ch = uart_rxbuf[uart_rxstart++];                                            // get character from ringbuffer
;
;    if (uart_rxstart == UART_RXBUFLEN)                                          // at end of rx buffer?
;    {                                                                           // yes
;        uart_rxstart = 0;                                                       // reset to beginning
;    }
;
;    cli();
;    uart_rxsize--;                                                              // decrement size
;    sei();
;
;#if 0
;    while (!(UART0_UCSRA & (1<<UART0_RXC)))                                     // character available?
;    {                                                                           // no
;        if (mcurses_nodelay)
;        {                                                                       // if nodelay set, return ERR
;            return (ERR);
;        }
;    }
;
;    ch = UART0_UDR;                                                             // read character from UDRx
;#endif
;    return (ch);
;}
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: set/reset nodelay (AVR)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;static void
;mcurses_phyio_nodelay (uint_fast8_t flag)
;{
;    mcurses_nodelay = flag;
;}
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: set/reset halfdelay (AVR)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;static void
;mcurses_phyio_halfdelay (uint_fast8_t tenths)
;{
;    mcurses_halfdelay = tenths;
;}
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: flush output (AVR)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;static void
;mcurses_phyio_flush_output ()
;{
;    while (uart_txsize > 0)                                                     // tx buffer empty?
;    {
;        ;                                                                       // no, wait
;    }
;}
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: UART interrupt handler, called if UART has received a character (AVR)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;ISR(UART0_RXC_vect)
;{
;    static uint_fast8_t  uart_rxstop  = 0;                                      // tail
;    uint_fast8_t         ch;
;
;    ch = UART0_UDR;
;
;    if (uart_rxsize < UART_RXBUFLEN)                                            // buffer full?
;    {                                                                           // no
;        uart_rxbuf[uart_rxstop++] = ch;                                         // store character
;
;        if (uart_rxstop >= UART_RXBUFLEN)                                       // at end of ringbuffer?
;        {                                                                       // yes
;            uart_rxstop = 0;                                                    // reset to beginning
;        }
;
;        uart_rxsize++;                                                          // increment used size
;    }
;}
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * PHYIO: UART interrupt handler, called if UART is ready to send a character (AVR)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;ISR(UART0_UDRE_vect)
;{
;    static uint_fast8_t  uart_txstart = 0;                                      // head
;    uint_fast8_t         ch;
;
;    if (uart_txsize > 0)                                                        // tx buffer empty?
;    {                                                                           // no
;        ch = uart_txbuf[uart_txstart++];                                        // get character to send, increment offset
;
;        if (uart_txstart == UART_TXBUFLEN)                                      // at end of tx buffer?
;        {                                                                       // yes
;            uart_txstart = 0;                                                   // reset to beginning
;        }
;
;        uart_txsize--;                                                          // decrement size
;
;        UART0_UDR = ch;                                                         // write character, don't wait
;    }
;    else
;    {
;        UART0_UCSRB &= ~(1 << UART0_UDRIE);                                     // tx buffer empty, disable UDRE interrupt
;    }
;}
;
;#endif // !unix
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * INTERN: put a character (raw)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;static void
;mcurses_putc (uint_fast8_t ch)
;{
	code
	func
~~mcurses_putc:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L37
	tcs
	phd
	tcd
ch_0	set	4
;    mcurses_phyio_putc (ch);
	pei	<L37+ch_0
	jsl	~~mcurses_phyio_putc
;}
	lda	<L37+2
	sta	<L37+2+2
	lda	<L37+1
	sta	<L37+1+2
	pld
	tsc
	clc
	adc	#L37+2
	tcs
	rtl
L37	equ	0
L38	equ	1
	ends
	efunc
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * INTERN: put a string from flash (raw)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;static void
;mcurses_puts_P (const char * str)
;{
	code
	func
~~mcurses_puts_P:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L40
	tcs
	phd
	tcd
str_0	set	4
;    uint_fast8_t ch;
;
;    while ((ch = pgm_read_byte(str)) != '\0')
ch_1	set	0
	bra	L10009
L20001:
;    {
;        mcurses_putc (ch);
	pei	<L41+ch_1
	jsl	~~mcurses_putc
;        str++;
	inc	<L40+str_0
	bne	L10009
	inc	<L40+str_0+2
;    }
L10009:
	sep	#$20
	longa	off
	lda	[<L40+str_0]
	sta	<L41+ch_1
	rep	#$20
	longa	on
	lda	<L41+ch_1
	and	#$ff
	bne	L20001
;}
	lda	<L40+2
	sta	<L40+2+4
	lda	<L40+1
	sta	<L40+1+4
	pld
	tsc
	clc
	adc	#L40+4
	tcs
	rtl
L40	equ	1
L41	equ	1
	ends
	efunc
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * INTERN: put a 3/2/1 digit integer number (raw)
; *
; * Here we don't want to use sprintf (too big on AVR/Z80) or itoa (not available on Z80)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;static void
;mcurses_puti (uint_fast8_t i)
;{
	code
	func
~~mcurses_puti:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L45
	tcs
	phd
	tcd
i_0	set	4
;    uint_fast8_t ii;
;
;    if (i >= 10)
ii_1	set	0
;    {
	sep	#$20
	longa	off
	lda	<L45+i_0
	cmp	#<$a
	rep	#$20
	longa	on
	bcs	*+5
	brl	L10011
;        if (i >= 100)
;        {
	sep	#$20
	longa	off
	lda	<L45+i_0
	cmp	#<$64
	rep	#$20
	longa	on
	bcc	L10012
;            ii = i / 100;
	lda	<L45+i_0
	and	#$ff
	ldx	#<$64
	xref	~~~div
	jsl	~~~div
	sep	#$20
	longa	off
	sta	<L46+ii_1
	rep	#$20
	longa	on
;            mcurses_putc (ii + '0');
	lda	<L46+ii_1
	and	#$ff
	clc
	adc	#$30
	pha
	jsl	~~mcurses_putc
;            i -= 100 * ii;
	lda	<L46+ii_1
	and	#$ff
	ldx	#<$64
	xref	~~~mul
	jsl	~~~mul
	sta	<R0
	lda	<L45+i_0
	and	#$ff
	sec
	sbc	<R0
	sep	#$20
	longa	off
	sta	<L45+i_0
	rep	#$20
	longa	on
;        }
;
;        ii = i / 10;
L10012:
	lda	<L45+i_0
	and	#$ff
	ldx	#<$a
	xref	~~~div
	jsl	~~~div
	sep	#$20
	longa	off
	sta	<L46+ii_1
	rep	#$20
	longa	on
;        mcurses_putc (ii + '0');
	lda	<L46+ii_1
	and	#$ff
	clc
	adc	#$30
	pha
	jsl	~~mcurses_putc
;        i -= 10 * ii;
	lda	<L46+ii_1
	and	#$ff
	sta	<R0
	asl	A
	asl	A
	adc	<R0
	asl	A
	sta	<R0
	lda	<L45+i_0
	and	#$ff
	sec
	sbc	<R0
	sep	#$20
	longa	off
	sta	<L45+i_0
	rep	#$20
	longa	on
;    }
;
;    mcurses_putc (i + '0');
L10011:
	lda	<L45+i_0
	and	#$ff
	clc
	adc	#$30
	pha
	jsl	~~mcurses_putc
;}
	lda	<L45+2
	sta	<L45+2+2
	lda	<L45+1
	sta	<L45+1+2
	pld
	tsc
	clc
	adc	#L45+2
	tcs
	rtl
L45	equ	13
L46	equ	13
	ends
	efunc
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * INTERN: addch or insch a character
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;#define CHARSET_G0      0
;#define CHARSET_G1      1
;
;static void
;mcurses_addch_or_insch (uint_fast8_t ch, uint_fast8_t insert)
;{
	code
	func
~~mcurses_addch_or_insch:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L50
	tcs
	phd
	tcd
ch_0	set	4
insert_0	set	6
;    static uint_fast8_t  charset = 0xff;
;    static uint_fast8_t  insert_mode = FALSE;
;
;    if (ch >= 0x80 && ch <= 0x9F)
;    {
	sep	#$20
	longa	off
	lda	<L50+ch_0
	cmp	#<$80
	rep	#$20
	longa	on
	bcc	L10013
	sep	#$20
	longa	off
	lda	#$9f
	cmp	<L50+ch_0
	rep	#$20
	longa	on
	bcc	L10013
;        if (charset != CHARSET_G1)
;        {
	sep	#$20
	longa	off
	lda	|L52
	cmp	#<$1
	rep	#$20
	longa	on
	beq	L10014
;            mcurses_putc ('\016');                                              // switch to G1 set
	pea	#<$e
	jsl	~~mcurses_putc
;            charset = CHARSET_G1;
	sep	#$20
	longa	off
	lda	#$1
	sta	|L52
	rep	#$20
	longa	on
;        }
;        ch -= 0x20;                                                             // subtract offset to G1 characters
L10014:
	lda	<L50+ch_0
	and	#$ff
	clc
	adc	#$ffe0
	sep	#$20
	longa	off
	sta	<L50+ch_0
	rep	#$20
	longa	on
;    }
;    else
	bra	L10015
L10013:
;    {
;        if (charset != CHARSET_G0)
;        {
	lda	|L52
	and	#$ff
	beq	L10015
;            mcurses_putc ('\017');                                              // switch to G0 set
	pea	#<$f
	jsl	~~mcurses_putc
;            charset = CHARSET_G0;
	sep	#$20
	longa	off
	stz	|L52
	rep	#$20
	longa	on
;        }
;    }
L10015:
;
;    if (insert)
;    {
	lda	<L50+insert_0
	and	#$ff
	beq	L10017
;        if (! insert_mode)
;        {
	lda	|L53
	and	#$ff
	bne	L10019
;            mcurses_puts_P (SEQ_INSERT_MODE);
	pea	#^L1
	pea	#<L1
	jsl	~~mcurses_puts_P
;            insert_mode = TRUE;
	sep	#$20
	longa	off
	lda	#$1
	sta	|L53
	rep	#$20
	longa	on
;        }
;    }
;    else
	bra	L10019
L10017:
;    {
;        if (insert_mode)
;        {
	lda	|L53
	and	#$ff
	beq	L10019
;            mcurses_puts_P (SEQ_REPLACE_MODE);
	pea	#^L1+5
	pea	#<L1+5
	jsl	~~mcurses_puts_P
;            insert_mode = FALSE;
	sep	#$20
	longa	off
	stz	|L53
	rep	#$20
	longa	on
;        }
;    }
L10019:
;
;    mcurses_putc (ch);
	pei	<L50+ch_0
	jsl	~~mcurses_putc
;    mcurses_curx++;
	sep	#$20
	longa	off
	inc	|~~mcurses_curx
	rep	#$20
	longa	on
;}
	lda	<L50+2
	sta	<L50+2+4
	lda	<L50+1
	sta	<L50+1+4
	pld
	tsc
	clc
	adc	#L50+4
	tcs
	rtl
L50	equ	8
L51	equ	9
	ends
	efunc
	data
L52:
	db	$FF
	ends
	data
L53:
	db	$0
	ends
	data
L1:
	db	$1B,$5B,$34,$68,$00,$1B,$5B,$34,$6C,$00
	ends
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * INTERN: set scrolling region (raw)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;static void
;mysetscrreg (uint_fast8_t top, uint_fast8_t bottom)
;{
	code
	func
~~mysetscrreg:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L63
	tcs
	phd
	tcd
top_0	set	4
bottom_0	set	6
;    if (top == bottom)
;    {
	sep	#$20
	longa	off
	lda	<L63+top_0
	cmp	<L63+bottom_0
	rep	#$20
	longa	on
	bne	L10021
;        mcurses_puts_P (SEQ_RESET_SCRREG);                                      // reset scrolling region
	pea	#^L62
	pea	#<L62
	jsl	~~mcurses_puts_P
;    }
;    else
	bra	L66
L10021:
;    {
;        mcurses_puts_P (SEQ_CSI);
	pea	#^L62+4
	pea	#<L62+4
	jsl	~~mcurses_puts_P
;        mcurses_puti (top + 1);
	lda	<L63+top_0
	and	#$ff
	ina
	pha
	jsl	~~mcurses_puti
;        mcurses_putc (';');
	pea	#<$3b
	jsl	~~mcurses_putc
;        mcurses_puti (bottom + 1);
	lda	<L63+bottom_0
	and	#$ff
	ina
	pha
	jsl	~~mcurses_puti
;        mcurses_putc ('r');
	pea	#<$72
	jsl	~~mcurses_putc
;    }
;}
L66:
	lda	<L63+2
	sta	<L63+2+4
	lda	<L63+1
	sta	<L63+1+4
	pld
	tsc
	clc
	adc	#L63+4
	tcs
	rtl
L63	equ	4
L64	equ	5
	ends
	efunc
	data
L62:
	db	$1B,$5B,$72,$00,$1B,$5B,$00
	ends
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * move cursor (raw)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;static void
;mymove (uint_fast8_t y, uint_fast8_t x)
;{
	code
	func
~~mymove:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L68
	tcs
	phd
	tcd
y_0	set	4
x_0	set	6
;    mcurses_puts_P (SEQ_CSI);
	pea	#^L67
	pea	#<L67
	jsl	~~mcurses_puts_P
;    mcurses_puti (y + 1);
	lda	<L68+y_0
	and	#$ff
	ina
	pha
	jsl	~~mcurses_puti
;    mcurses_putc (';');
	pea	#<$3b
	jsl	~~mcurses_putc
;    mcurses_puti (x + 1);
	lda	<L68+x_0
	and	#$ff
	ina
	pha
	jsl	~~mcurses_puti
;    mcurses_putc ('H');
	pea	#<$48
	jsl	~~mcurses_putc
;}
	lda	<L68+2
	sta	<L68+2+4
	lda	<L68+1
	sta	<L68+1+4
	pld
	tsc
	clc
	adc	#L68+4
	tcs
	rtl
L68	equ	4
L69	equ	5
	ends
	efunc
	data
L67:
	db	$1B,$5B,$00
	ends
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * MCURSES: initialize
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;uint_fast8_t
;initscr (void)
;{
	code
	xdef	~~initscr
	func
~~initscr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L72
	tcs
	phd
	tcd
;    uint_fast8_t rtc;
;
;    if (mcurses_phyio_init ())
rtc_1	set	0
;    {
	jsl	~~mcurses_phyio_init
	and	#$ff
	beq	L10023
;        mcurses_puts_P (SEQ_LOAD_G1);                                               // load graphic charset into G1
	pea	#^L71
	pea	#<L71
	jsl	~~mcurses_puts_P
;        attrset (A_NORMAL);
	pea	#^$0
	pea	#<$0
	jsl	~~attrset
;        clear ();
	jsl	~~clear
;        move (0, 0);
	pea	#<$0
	pea	#<$0
	jsl	~~move
;        mcurses_is_up = 1;
	sep	#$20
	longa	off
	lda	#$1
	sta	|~~mcurses_is_up
;        rtc = OK;
	stz	<L73+rtc_1
	rep	#$20
	longa	on
;    }
;    else
	bra	L10024
L10023:
;    {
;        rtc = ERR;
	sep	#$20
	longa	off
	lda	#$ff
	sta	<L73+rtc_1
	rep	#$20
	longa	on
;    }
L10024:
;    return rtc;
	lda	<L73+rtc_1
	and	#$ff
	tay
	pld
	tsc
	clc
	adc	#L72
	tcs
	tya
	rtl
;}
L72	equ	1
L73	equ	1
	ends
	efunc
	data
L71:
	db	$1B,$29,$30,$00
	ends
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * MCURSES: add character
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;void
;addch (uint_fast8_t ch)
;{
	code
	xdef	~~addch
	func
~~addch:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L77
	tcs
	phd
	tcd
ch_0	set	4
;    mcurses_addch_or_insch (ch, FALSE);
	pea	#<$0
	pei	<L77+ch_0
	jsl	~~mcurses_addch_or_insch
;}
	lda	<L77+2
	sta	<L77+2+2
	lda	<L77+1
	sta	<L77+1+2
	pld
	tsc
	clc
	adc	#L77+2
	tcs
	rtl
L77	equ	0
L78	equ	1
	ends
	efunc
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * MCURSES: add string
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;void
;addstr (const char * str)
;{
	code
	xdef	~~addstr
	func
~~addstr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L80
	tcs
	phd
	tcd
str_0	set	4
;    while (*str)
	bra	L10025
L20003:
;    {
;        mcurses_addch_or_insch (*str++, FALSE);
	pea	#<$0
	lda	<L80+str_0
	sta	<R0
	lda	<L80+str_0+2
	sta	<R0+2
	inc	<L80+str_0
	bne	L83
	inc	<L80+str_0+2
L83:
	lda	[<R0]
	pha
	jsl	~~mcurses_addch_or_insch
;    }
L10025:
	lda	[<L80+str_0]
	and	#$ff
	bne	L20003
;}
	lda	<L80+2
	sta	<L80+2+4
	lda	<L80+1
	sta	<L80+1+4
	pld
	tsc
	clc
	adc	#L80+4
	tcs
	rtl
L80	equ	4
L81	equ	5
	ends
	efunc
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * MCURSES: add string
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;void
;addstr_P (const char * str)
;{
	code
	xdef	~~addstr_P
	func
~~addstr_P:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L85
	tcs
	phd
	tcd
str_0	set	4
;    uint_fast8_t ch;
;
;    while ((ch = pgm_read_byte(str)) != '\0')
ch_1	set	0
	bra	L10027
L20005:
;    {
;        mcurses_addch_or_insch (ch, FALSE);
	pea	#<$0
	pei	<L86+ch_1
	jsl	~~mcurses_addch_or_insch
;        str++;
	inc	<L85+str_0
	bne	L10027
	inc	<L85+str_0+2
;    }
L10027:
	sep	#$20
	longa	off
	lda	[<L85+str_0]
	sta	<L86+ch_1
	rep	#$20
	longa	on
	lda	<L86+ch_1
	and	#$ff
	bne	L20005
;}
	lda	<L85+2
	sta	<L85+2+4
	lda	<L85+1
	sta	<L85+1+4
	pld
	tsc
	clc
	adc	#L85+4
	tcs
	rtl
L85	equ	1
L86	equ	1
	ends
	efunc
;
;#if defined(unix) || defined(STM32F4XX) || defined(STM32F10X)
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; *  MCURSES: add formatted string (va_list)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;void
;vprintw (const char * fmt, va_list ap)
;{
	code
	xdef	~~vprintw
	func
~~vprintw:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L90
	tcs
	phd
	tcd
fmt_0	set	4
ap_0	set	8
;    static char str_buf[256];
;
;    (void) vsprintf ((char *) str_buf, fmt, ap);
	pei	<L90+ap_0+2
	pei	<L90+ap_0
	pei	<L90+fmt_0+2
	pei	<L90+fmt_0
	lda	#<L10029
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	jsl	~~vsprintf
;    (void) addstr (str_buf);
	lda	#<L10029
	sta	<R0
	xref	_BEG_DATA
	lda	#_BEG_DATA>>16
	pha
	pei	<R0
	jsl	~~addstr
;} /* vprintw (fmt, ap) */
	lda	<L90+2
	sta	<L90+2+8
	lda	<L90+1
	sta	<L90+1+8
	pld
	tsc
	clc
	adc	#L90+8
	tcs
	rtl
L90	equ	8
L91	equ	9
	ends
	efunc
	udata
L10029:
	ds	256
	ends
;
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; *  MCURSES: add formatted string (variable number of arguments)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;void
;printw (const char * fmt, ...)
;{
	code
	xdef	~~printw
	func
~~printw:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L93
	tcs
	phd
	tcd
fmt_0	set	6
;    va_list ap;
;
;    va_start (ap, fmt);
ap_1	set	0
	clc
	tdc
	adc	#<L93+fmt_0+4
	sta	<L94+ap_1
	lda	#$0
	sta	<L94+ap_1+2
;    vprintw (fmt, ap);
	pha
	pei	<L94+ap_1
	pei	<L93+fmt_0+2
	pei	<L93+fmt_0
	jsl	~~vprintw
;    va_end (ap);
;} /* printw (fmt, ...) */
	phx
	ldx	<L93+4
	lda	<L93+2
	sta	<L93+2,X
	lda	<L93+1
	sta	<L93+1,X
	txa
	plx
	pld
	pha
	tsc
	clc
	adc	#L93+2
	adc	<1,s
	tcs
	rtl
L93	equ	4
L94	equ	1
	ends
	efunc
;
;#if defined(STM32F4XX)
;// (v)sprintf needs it
;caddr_t _sbrk(int increment)
;{
;    extern char end asm("end");
;    register char * pStack asm("sp");
;    static char *   s_pHeapEnd;
;
;    if (!s_pHeapEnd)
;    {
;        s_pHeapEnd = &end;
;    }
;
;    if (s_pHeapEnd + increment > pStack)
;    {
;        return (caddr_t) -1;
;    }
;
;    char * pOldHeapEnd = s_pHeapEnd;
;    s_pHeapEnd += increment;
;    return (caddr_t) pOldHeapEnd;
;}
;#endif
;#endif
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * MCURSES: set attribute(s)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;void
;attrset (uint_fast16_t attr)
;{
	code
	xdef	~~attrset
	func
~~attrset:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L96
	tcs
	phd
	tcd
attr_0	set	4
;    static uint_fast8_t mcurses_attr = 0xff;                    // current attributes
;    uint_fast8_t        idx;
;
;    if (attr != mcurses_attr)
idx_1	set	0
;    {
	lda	|L98
	and	#$ff
	sta	<R0
	stz	<R0+2
	lda	<R0
	cmp	<L96+attr_0
	bne	L99
	lda	<R0+2
	cmp	<L96+attr_0+2
L99:
	bne	*+5
	brl	L110
;        mcurses_puts_P (SEQ_ATTRSET);
	pea	#^L76
	pea	#<L76
	jsl	~~mcurses_puts_P
;
;        idx = (attr & F_COLOR) >> 8;
	lda	<L96+attr_0
	and	#<$f00
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$8
	xref	~~~llsr
	jsl	~~~llsr
	sta	<R0
	stx	<R0+2
	sep	#$20
	longa	off
	lda	<R0
	sta	<L97+idx_1
;
;        if (idx >= 1 && idx <= 8)
;        {
	cmp	#<$1
	rep	#$20
	longa	on
	bcc	L10031
	sep	#$20
	longa	off
	lda	#$8
	cmp	<L97+idx_1
	rep	#$20
	longa	on
	bcc	L10031
;            mcurses_puts_P (SEQ_ATTRSET_FCOLOR);
	pea	#^L76+4
	pea	#<L76+4
	jsl	~~mcurses_puts_P
;            mcurses_putc (idx - 1 + '0');
	lda	<L97+idx_1
	and	#$ff
	clc
	adc	#$2f
	pha
	jsl	~~mcurses_putc
;        }
;
;        idx = (attr & B_COLOR) >> 12;
L10031:
	lda	<L96+attr_0
	and	#<$f000
	sta	<R1
	stz	<R1+2
	pei	<R1+2
	pei	<R1
	lda	#$c
	xref	~~~llsr
	jsl	~~~llsr
	sta	<R0
	stx	<R0+2
	sep	#$20
	longa	off
	lda	<R0
	sta	<L97+idx_1
;
;        if (idx >= 1 && idx <= 8)
;        {
	cmp	#<$1
	rep	#$20
	longa	on
	bcc	L10032
	sep	#$20
	longa	off
	lda	#$8
	cmp	<L97+idx_1
	rep	#$20
	longa	on
	bcc	L10032
;            mcurses_puts_P (SEQ_ATTRSET_BCOLOR);
	pea	#^L76+7
	pea	#<L76+7
	jsl	~~mcurses_puts_P
;            mcurses_putc (idx - 1 + '0');
	lda	<L97+idx_1
	and	#$ff
	clc
	adc	#$2f
	pha
	jsl	~~mcurses_putc
;        }
;
;        if (attr & A_REVERSE)
L10032:
;        {
	lda	<L96+attr_0
	and	#<$2
	beq	L10033
;            mcurses_puts_P (SEQ_ATTRSET_REVERSE);
	pea	#^L76+10
	pea	#<L76+10
	jsl	~~mcurses_puts_P
;        }
;        if (attr & A_UNDERLINE)
L10033:
;        {
	lda	<L96+attr_0
	and	#<$1
	beq	L10034
;            mcurses_puts_P (SEQ_ATTRSET_UNDERLINE);
	pea	#^L76+13
	pea	#<L76+13
	jsl	~~mcurses_puts_P
;        }
;        if (attr & A_BLINK)
L10034:
;        {
	lda	<L96+attr_0
	and	#<$4
	beq	L10035
;            mcurses_puts_P (SEQ_ATTRSET_BLINK);
	pea	#^L76+16
	pea	#<L76+16
	jsl	~~mcurses_puts_P
;        }
;        if (attr & A_BOLD)
L10035:
;        {
	lda	<L96+attr_0
	and	#<$8
	beq	L10036
;            mcurses_puts_P (SEQ_ATTRSET_BOLD);
	pea	#^L76+19
	pea	#<L76+19
	jsl	~~mcurses_puts_P
;        }
;        if (attr & A_DIM)
L10036:
;        {
	lda	<L96+attr_0
	and	#<$10
	beq	L10037
;            mcurses_puts_P (SEQ_ATTRSET_DIM);
	pea	#^L76+22
	pea	#<L76+22
	jsl	~~mcurses_puts_P
;        }
;        mcurses_putc ('m');
L10037:
	pea	#<$6d
	jsl	~~mcurses_putc
;        mcurses_attr = attr;
	sep	#$20
	longa	off
	lda	<L96+attr_0
	sta	|L98
	rep	#$20
	longa	on
;    }
;}
L110:
	lda	<L96+2
	sta	<L96+2+4
	lda	<L96+1
	sta	<L96+1+4
	pld
	tsc
	clc
	adc	#L96+4
	tcs
	rtl
L96	equ	9
L97	equ	9
	ends
	efunc
	data
L98:
	db	$FF
	ends
	data
L76:
	db	$1B,$5B,$30,$00,$3B,$33,$00,$3B,$34,$00,$3B,$37,$00,$3B,$34
	db	$00,$3B,$35,$00,$3B,$31,$00,$3B,$32,$00
	ends
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * MCURSES: move cursor
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;void
;move (uint_fast8_t y, uint_fast8_t x)
;{
	code
	xdef	~~move
	func
~~move:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L112
	tcs
	phd
	tcd
y_0	set	4
x_0	set	6
;    if (mcurses_cury != y || mcurses_curx != x)
;    {
	sep	#$20
	longa	off
	lda	|~~mcurses_cury
	cmp	<L112+y_0
	rep	#$20
	longa	on
	bne	L114
	sep	#$20
	longa	off
	lda	|~~mcurses_curx
	cmp	<L112+x_0
	rep	#$20
	longa	on
	beq	L117
L114:
;        mcurses_cury = y;
	sep	#$20
	longa	off
	lda	<L112+y_0
	sta	|~~mcurses_cury
;        mcurses_curx = x;
	lda	<L112+x_0
	sta	|~~mcurses_curx
	rep	#$20
	longa	on
;        mymove (y, x);
	pei	<L112+x_0
	pei	<L112+y_0
	jsl	~~mymove
;    }
;}
L117:
	lda	<L112+2
	sta	<L112+2+4
	lda	<L112+1
	sta	<L112+1+4
	pld
	tsc
	clc
	adc	#L112+4
	tcs
	rtl
L112	equ	0
L113	equ	1
	ends
	efunc
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * MCURSES: delete line
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;void
;deleteln (void)
;{
	code
	xdef	~~deleteln
	func
~~deleteln:
	longa	on
	longi	on
;    mysetscrreg (mcurses_scrl_start, mcurses_scrl_end);                         // set scrolling region
	lda	|~~mcurses_scrl_end
	pha
	lda	|~~mcurses_scrl_start
	pha
	jsl	~~mysetscrreg
;    mymove (mcurses_cury, 0);                                                   // goto to current line
	pea	#<$0
	lda	|~~mcurses_cury
	pha
	jsl	~~mymove
;    mcurses_puts_P (SEQ_DELETELINE);                                            // delete line
	pea	#^L111
	pea	#<L111
	jsl	~~mcurses_puts_P
;    mysetscrreg (0, 0);                                                         // reset scrolling region
	pea	#<$0
	pea	#<$0
	jsl	~~mysetscrreg
;    mymove (mcurses_cury, mcurses_curx);                                        // restore position
	lda	|~~mcurses_curx
	pha
	lda	|~~mcurses_cury
	pha
	jsl	~~mymove
;}
	rtl
L118	equ	0
L119	equ	1
	ends
	efunc
	data
L111:
	db	$1B,$5B,$4D,$00
	ends
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * MCURSES: insert line
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;void
;insertln (void)
;{
	code
	xdef	~~insertln
	func
~~insertln:
	longa	on
	longi	on
;    mysetscrreg (mcurses_cury, mcurses_scrl_end);                               // set scrolling region
	lda	|~~mcurses_scrl_end
	pha
	lda	|~~mcurses_cury
	pha
	jsl	~~mysetscrreg
;    mymove (mcurses_cury, 0);                                                   // goto to current line
	pea	#<$0
	lda	|~~mcurses_cury
	pha
	jsl	~~mymove
;    mcurses_puts_P (SEQ_INSERTLINE);                                            // insert line
	pea	#^L121
	pea	#<L121
	jsl	~~mcurses_puts_P
;    mysetscrreg (0, 0);                                                         // reset scrolling region
	pea	#<$0
	pea	#<$0
	jsl	~~mysetscrreg
;    mymove (mcurses_cury, mcurses_curx);                                        // restore position
	lda	|~~mcurses_curx
	pha
	lda	|~~mcurses_cury
	pha
	jsl	~~mymove
;}
	rtl
L122	equ	0
L123	equ	1
	ends
	efunc
	data
L121:
	db	$1B,$5B,$4C,$00
	ends
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * MCURSES: scroll
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;void
;scroll (void)
;{
	code
	xdef	~~scroll
	func
~~scroll:
	longa	on
	longi	on
;    mysetscrreg (mcurses_scrl_start, mcurses_scrl_end);                         // set scrolling region
	lda	|~~mcurses_scrl_end
	pha
	lda	|~~mcurses_scrl_start
	pha
	jsl	~~mysetscrreg
;    mymove (mcurses_scrl_end, 0);                                               // goto to last line of scrolling region
	pea	#<$0
	lda	|~~mcurses_scrl_end
	pha
	jsl	~~mymove
;    mcurses_puts_P (SEQ_NEXTLINE);                                              // next line
	pea	#^L125
	pea	#<L125
	jsl	~~mcurses_puts_P
;    mysetscrreg (0, 0);                                                         // reset scrolling region
	pea	#<$0
	pea	#<$0
	jsl	~~mysetscrreg
;    mymove (mcurses_cury, mcurses_curx);                                        // restore position
	lda	|~~mcurses_curx
	pha
	lda	|~~mcurses_cury
	pha
	jsl	~~mymove
;}
	rtl
L126	equ	0
L127	equ	1
	ends
	efunc
	data
L125:
	db	$1B,$45,$00
	ends
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * MCURSES: clear
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;void
;clear (void)
;{
	code
	xdef	~~clear
	func
~~clear:
	longa	on
	longi	on
;    mcurses_puts_P (SEQ_CLEAR);
	pea	#^L129
	pea	#<L129
	jsl	~~mcurses_puts_P
;}
	rtl
L130	equ	0
L131	equ	1
	ends
	efunc
	data
L129:
	db	$1B,$5B,$32,$4A,$00
	ends
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * MCURSES: clear to bottom of screen
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;void
;clrtobot (void)
;{
	code
	xdef	~~clrtobot
	func
~~clrtobot:
	longa	on
	longi	on
;    mcurses_puts_P (SEQ_CLRTOBOT);
	pea	#^L133
	pea	#<L133
	jsl	~~mcurses_puts_P
;}
	rtl
L134	equ	0
L135	equ	1
	ends
	efunc
	data
L133:
	db	$1B,$5B,$4A,$00
	ends
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * MCURSES: clear to end of line
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;void
;clrtoeol (void)
;{
	code
	xdef	~~clrtoeol
	func
~~clrtoeol:
	longa	on
	longi	on
;    mcurses_puts_P (SEQ_CLRTOEOL);
	pea	#^L137
	pea	#<L137
	jsl	~~mcurses_puts_P
;}
	rtl
L138	equ	0
L139	equ	1
	ends
	efunc
	data
L137:
	db	$1B,$5B,$4B,$00
	ends
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * MCURSES: delete character at cursor position
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;void
;delch (void)
;{
	code
	xdef	~~delch
	func
~~delch:
	longa	on
	longi	on
;    mcurses_puts_P (SEQ_DELCH);
	pea	#^L141
	pea	#<L141
	jsl	~~mcurses_puts_P
;}
	rtl
L142	equ	0
L143	equ	1
	ends
	efunc
	data
L141:
	db	$1B,$5B,$50,$00
	ends
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * MCURSES: insert character
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;void
;insch (uint_fast8_t ch)
;{
	code
	xdef	~~insch
	func
~~insch:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L146
	tcs
	phd
	tcd
ch_0	set	4
;    mcurses_addch_or_insch (ch, TRUE);
	pea	#<$1
	pei	<L146+ch_0
	jsl	~~mcurses_addch_or_insch
;}
	lda	<L146+2
	sta	<L146+2+2
	lda	<L146+1
	sta	<L146+1+2
	pld
	tsc
	clc
	adc	#L146+2
	tcs
	rtl
L146	equ	0
L147	equ	1
	ends
	efunc
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * MCURSES: set scrolling region
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;void
;setscrreg (uint_fast8_t t, uint_fast8_t b)
;{
	code
	xdef	~~setscrreg
	func
~~setscrreg:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L149
	tcs
	phd
	tcd
t_0	set	4
b_0	set	6
;    mcurses_scrl_start = t;
	sep	#$20
	longa	off
	lda	<L149+t_0
	sta	|~~mcurses_scrl_start
;    mcurses_scrl_end = b;
	lda	<L149+b_0
	sta	|~~mcurses_scrl_end
	rep	#$20
	longa	on
;}
	lda	<L149+2
	sta	<L149+2+4
	lda	<L149+1
	sta	<L149+1+4
	pld
	tsc
	clc
	adc	#L149+4
	tcs
	rtl
L149	equ	0
L150	equ	1
	ends
	efunc
;
;void
;curs_set (uint_fast8_t visibility)
;{
	code
	xdef	~~curs_set
	func
~~curs_set:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L152
	tcs
	phd
	tcd
visibility_0	set	4
;    mcurses_puts_P (SEQ_CURSOR_VIS);
	pea	#^L145
	pea	#<L145
	jsl	~~mcurses_puts_P
;
;    if (visibility == 0)
;    {
	lda	<L152+visibility_0
	and	#$ff
	bne	L10039
;        mcurses_putc ('l');
	pea	#<$6c
	bra	L20006
;    }
;    else
L10039:
;    {
;        mcurses_putc ('h');
	pea	#<$68
L20006:
	jsl	~~mcurses_putc
;    }
;}
	lda	<L152+2
	sta	<L152+2+2
	lda	<L152+1
	sta	<L152+1+2
	pld
	tsc
	clc
	adc	#L152+2
	tcs
	rtl
L152	equ	0
L153	equ	1
	ends
	efunc
	data
L145:
	db	$1B,$5B,$3F,$32,$35,$00
	ends
;
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * MCURSES: refresh: flush output
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;void
;refresh (void)
;{
	code
	xdef	~~refresh
	func
~~refresh:
	longa	on
	longi	on
;    mcurses_phyio_flush_output ();
	jsl	~~mcurses_phyio_flush_output
;}
	rtl
L157	equ	0
L158	equ	1
	ends
	efunc
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * MCURSES: set/reset nodelay
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;void
;nodelay (uint_fast8_t flag)
;{
	code
	xdef	~~nodelay
	func
~~nodelay:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L160
	tcs
	phd
	tcd
flag_0	set	4
;    if (mcurses_nodelay != flag)
;    {
	sep	#$20
	longa	off
	lda	|~~mcurses_nodelay
	cmp	<L160+flag_0
	rep	#$20
	longa	on
	beq	L163
;        mcurses_phyio_nodelay (flag);
	pei	<L160+flag_0
	jsl	~~mcurses_phyio_nodelay
;    }
;}
L163:
	lda	<L160+2
	sta	<L160+2+2
	lda	<L160+1
	sta	<L160+1+2
	pld
	tsc
	clc
	adc	#L160+2
	tcs
	rtl
L160	equ	0
L161	equ	1
	ends
	efunc
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * MCURSES: set/reset halfdelay
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;void
;halfdelay (uint_fast8_t tenths)
;{
	code
	xdef	~~halfdelay
	func
~~halfdelay:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L164
	tcs
	phd
	tcd
tenths_0	set	4
;    mcurses_phyio_halfdelay (tenths);
	pei	<L164+tenths_0
	jsl	~~mcurses_phyio_halfdelay
;}
	lda	<L164+2
	sta	<L164+2+2
	lda	<L164+1
	sta	<L164+1+2
	pld
	tsc
	clc
	adc	#L164+2
	tcs
	rtl
L164	equ	0
L165	equ	1
	ends
	efunc
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * MCURSES: read key
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;#define MAX_KEYS                ((KEY_F1 + 12) - 0x80)
;
;static const char * function_keys[MAX_KEYS] =
	data
~~function_keys:
;{
;    "B",                        // KEY_DOWN                 0x80                // Down arrow key
	dl	L156+0
;    "A",                        // KEY_UP                   0x81                // Up arrow key
	dl	L156+2
;    "D",                        // KEY_LEFT                 0x82                // Left arrow key
	dl	L156+4
;    "C",                        // KEY_RIGHT                0x83                // Right arrow key
	dl	L156+6
;    "1~",                       // KEY_HOME                 0x84                // Home key
	dl	L156+8
;    "3~",                       // KEY_DC                   0x85                // Delete character key
	dl	L156+11
;    "2~",                       // KEY_IC                   0x86                // Ins char/toggle ins mode key
	dl	L156+14
;    "6~",                       // KEY_NPAGE                0x87                // Next-page key
	dl	L156+17
;    "5~",                       // KEY_PPAGE                0x88                // Previous-page key
	dl	L156+20
;    "4~",                       // KEY_END                  0x89                // End key
	dl	L156+23
;    "Z",                        // KEY_BTAB                 0x8A                // Back tab key
	dl	L156+26
;#if 0 // VT400:
;    "11~",                      // KEY_F(1)                 0x8B                // Function key F1
;    "12~",                      // KEY_F(2)                 0x8C                // Function key F2
;    "13~",                      // KEY_F(3)                 0x8D                // Function key F3
;    "14~",                      // KEY_F(4)                 0x8E                // Function key F4
;    "15~",                      // KEY_F(5)                 0x8F                // Function key F5
;#else // Linux console
;    "[A",                       // KEY_F(1)                 0x8B                // Function key F1
	dl	L156+28
;    "[B",                       // KEY_F(2)                 0x8C                // Function key F2
	dl	L156+31
;    "[C",                       // KEY_F(3)                 0x8D                // Function key F3
	dl	L156+34
;    "[D",                       // KEY_F(4)                 0x8E                // Function key F4
	dl	L156+37
;    "[E",                       // KEY_F(5)                 0x8F                // Function key F5
	dl	L156+40
;#endif
;    "17~",                      // KEY_F(6)                 0x90                // Function key F6
	dl	L156+43
;    "18~",                      // KEY_F(7)                 0x91                // Function key F7
	dl	L156+47
;    "19~",                      // KEY_F(8)                 0x92                // Function key F8
	dl	L156+51
;    "20~",                      // KEY_F(9)                 0x93                // Function key F9
	dl	L156+55
;    "21~",                      // KEY_F(10)                0x94                // Function key F10
	dl	L156+59
;    "23~",                      // KEY_F(11)                0x95                // Function key F11
	dl	L156+63
;    "24~"                       // KEY_F(12)                0x96                // Function key F12
;};
	dl	L156+67
	ends
	data
L156:
	db	$42,$00,$41,$00,$44,$00,$43,$00,$31,$7E,$00,$33,$7E,$00,$32
	db	$7E,$00,$36,$7E,$00,$35,$7E,$00,$34,$7E,$00,$5A,$00,$5B,$41
	db	$00,$5B,$42,$00,$5B,$43,$00,$5B,$44,$00,$5B,$45,$00,$31,$37
	db	$7E,$00,$31,$38,$7E,$00,$31,$39,$7E,$00,$32,$30,$7E,$00,$32
	db	$31,$7E,$00,$32,$33,$7E,$00,$32,$34,$7E,$00
	ends
;
;uint_fast8_t
;getch (void)
;{
	code
	xdef	~~getch
	func
~~getch:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L168
	tcs
	phd
	tcd
;    char    buf[4];
;    uint_fast8_t ch;
;    uint_fast8_t idx;
;
;    refresh ();
buf_1	set	0
ch_1	set	4
idx_1	set	5
	jsl	~~refresh
;    ch = mcurses_phyio_getc ();
	jsl	~~mcurses_phyio_getc
	sep	#$20
	longa	off
	sta	<L169+ch_1
;
;    if (ch == 0x7F)                                                             // BACKSPACE on VT200 sends DEL char
;    {
	cmp	#<$7f
	rep	#$20
	longa	on
	bne	L10042
;        ch = KEY_BACKSPACE;                                                     // map it to '\b'
	sep	#$20
	longa	off
	lda	#$8
	sta	<L169+ch_1
	rep	#$20
	longa	on
;    }
;    else if (ch == '\033')                                                      // ESCAPE
	brl	L10043
L10042:
;    {
	sep	#$20
	longa	off
	lda	<L169+ch_1
	cmp	#<$1b
	rep	#$20
	longa	on
	beq	*+5
	brl	L10043
;        while ((ch = mcurses_phyio_getc ()) == ERR)
L10045:
	jsl	~~mcurses_phyio_getc
	sep	#$20
	longa	off
	sta	<L169+ch_1
	cmp	#<$ff
	rep	#$20
	longa	on
	beq	L10045
;        {
;            ;
;        }
;
;        if (ch == '\033')                                                       // 2 x ESCAPE
;        {
	sep	#$20
	longa	off
	lda	<L169+ch_1
	cmp	#<$1b
	rep	#$20
	longa	on
	bne	L10047
;            return KEY_ESCAPE;
	lda	#$1b
L174:
	tay
	pld
	tsc
	clc
	adc	#L168
	tcs
	tya
	rtl
;        }
;        else if (ch == '[')
L10047:
;        {
	sep	#$20
	longa	off
	lda	<L169+ch_1
	cmp	#<$5b
	rep	#$20
	longa	on
	beq	*+5
	brl	L10048
;            for (idx = 0; idx < 3; idx++)
	sep	#$20
	longa	off
	stz	<L169+idx_1
	rep	#$20
	longa	on
	bra	L10052
;            {
;                while ((ch = mcurses_phyio_getc ()) == ERR)
;                }
;            }
L10049:
	sep	#$20
	longa	off
	inc	<L169+idx_1
	rep	#$20
	longa	on
L10052:
	sep	#$20
	longa	off
	lda	<L169+idx_1
	cmp	#<$3
	rep	#$20
	longa	on
	bcs	L10050
L10053:
	jsl	~~mcurses_phyio_getc
	sep	#$20
	longa	off
	sta	<L169+ch_1
	cmp	#<$ff
	rep	#$20
	longa	on
	beq	L10053
;                {
;                    ;
;                }
;
;                buf[idx] = ch;
	lda	<L169+idx_1
	and	#$ff
	tax
	sep	#$20
	longa	off
	lda	<L169+ch_1
	sta	<L169+buf_1,X
;
;                if ((ch >= 'A' && ch <= 'Z') || ch == '~')
;                {
	lda	<L169+ch_1
	cmp	#<$41
	rep	#$20
	longa	on
	bcc	L178
	sep	#$20
	longa	off
	lda	#$5a
	cmp	<L169+ch_1
	rep	#$20
	longa	on
	bcs	L177
L178:
	sep	#$20
	longa	off
	lda	<L169+ch_1
	cmp	#<$7e
	rep	#$20
	longa	on
	bne	L10049
L177:
;                    idx++;
	sep	#$20
	longa	off
	inc	<L169+idx_1
	rep	#$20
	longa	on
;                    break;
L10050:
;
;            buf[idx] = '\0';
	lda	<L169+idx_1
	and	#$ff
	tax
	sep	#$20
	longa	off
	lda	#$0
	sta	<L169+buf_1,X
;
;            for (idx = 0; idx < MAX_KEYS; idx++)
	stz	<L169+idx_1
	rep	#$20
	longa	on
	bra	L10059
;                }
;            }
L10056:
	sep	#$20
	longa	off
	inc	<L169+idx_1
	rep	#$20
	longa	on
L10059:
	sep	#$20
	longa	off
	lda	<L169+idx_1
	cmp	#<$17
	rep	#$20
	longa	on
	bcs	L10057
;            {
;                if (! strcmp (buf, function_keys[idx]))
;                {
	lda	<L169+idx_1
	and	#$ff
	asl	A
	asl	A
	clc
	adc	#<~~function_keys
	sta	<R1
	ldy	#$2
	lda	(<R1),Y
	pha
	lda	(<R1)
	pha
	pea	#0
	clc
	tdc
	adc	#<L169+buf_1
	pha
	jsl	~~strcmp
	tax
	bne	L10056
;                    ch = idx + 0x80;
	sep	#$20
	longa	off
	lda	#$80
	clc
	adc	<L169+idx_1
	sta	<L169+ch_1
	rep	#$20
	longa	on
;                    break;
L10057:
;
;            if (idx == MAX_KEYS)
;            {
	sep	#$20
	longa	off
	lda	<L169+idx_1
	cmp	#<$17
	rep	#$20
	longa	on
	bne	L10043
;                ch = ERR;
	sep	#$20
	longa	off
	lda	#$ff
	sta	<L169+ch_1
	rep	#$20
	longa	on
;            }
;        }
;        else
	bra	L10043
L10048:
;        {
;            ch = ERR;
	sep	#$20
	longa	off
	lda	#$ff
	sta	<L169+ch_1
	rep	#$20
	longa	on
;        }
;    }
;
;    return ch;
L10043:
	lda	<L169+ch_1
	and	#$ff
	brl	L174
;}
L168	equ	14
L169	equ	9
	ends
	efunc
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * MCURSES: read string (with mini editor built-in)
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;void
;getnstr (char * str, uint_fast8_t maxlen)
;{
	code
	xdef	~~getnstr
	func
~~getnstr:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L186
	tcs
	phd
	tcd
str_0	set	4
maxlen_0	set	8
;    uint_fast8_t ch;
;    uint_fast8_t curlen = 0;
;    uint_fast8_t curpos = 0;
;    uint_fast8_t starty;
;    uint_fast8_t startx;
;    uint_fast8_t i;
;
;    maxlen--;                               // reserve one byte in order to store '\0' in last position
ch_1	set	0
curlen_1	set	1
curpos_1	set	2
starty_1	set	3
startx_1	set	4
i_1	set	5
	sep	#$20
	longa	off
	stz	<L187+curlen_1
	stz	<L187+curpos_1
	dec	<L186+maxlen_0
;    getyx (starty, startx);                 // get current cursor position
	lda	|~~mcurses_cury
	sta	<L187+starty_1
	lda	|~~mcurses_curx
	sta	<L187+startx_1
	rep	#$20
	longa	on
;
;    while ((ch = getch ()) != KEY_CR)
L10063:
	jsl	~~getch
	sep	#$20
	longa	off
	sta	<L187+ch_1
	cmp	#<$d
	rep	#$20
	longa	on
	bne	*+5
	brl	L10064
;    {
;        switch (ch)
	lda	<L187+ch_1
	and	#$ff
	xref	~~~swt
	jsl	~~~swt
	dw	6
	dw	8
	dw	L10073-1
	dw	130
	dw	L10067-1
	dw	131
	dw	L10069-1
	dw	132
	dw	L10071-1
	dw	133
	dw	L10079-1
	dw	137
	dw	L10072-1
	dw	L10085-1
;        {
;            case KEY_LEFT:
L10067:
;                if (curpos > 0)
;                {
	sep	#$20
	longa	off
	lda	#$0
	cmp	<L187+curpos_1
	rep	#$20
	longa	on
	bcs	L10066
;                    curpos--;
	sep	#$20
	longa	off
	dec	<L187+curpos_1
	rep	#$20
	longa	on
;                }
;                break;
L10066:
;        move (starty, startx + curpos);
	lda	<L187+curpos_1
	and	#$ff
	sta	<R0
	lda	<L187+startx_1
	and	#$ff
	clc
	adc	<R0
	pha
	pei	<L187+starty_1
	jsl	~~move
;    }
	bra	L10063
;            case KEY_RIGHT:
L10069:
;                if (curpos < curlen)
;                {
	sep	#$20
	longa	off
	lda	<L187+curpos_1
	cmp	<L187+curlen_1
	rep	#$20
	longa	on
	bcs	L10066
;                    curpos++;
	sep	#$20
	longa	off
	inc	<L187+curpos_1
	rep	#$20
	longa	on
;                }
;                break;
	bra	L10066
;            case KEY_HOME:
L10071:
;                curpos = 0;
	sep	#$20
	longa	off
	stz	<L187+curpos_1
	rep	#$20
	longa	on
;                break;
	bra	L10066
;            case KEY_END:
L10072:
;                curpos = curlen;
	sep	#$20
	longa	off
	lda	<L187+curlen_1
	sta	<L187+curpos_1
	rep	#$20
	longa	on
;                break;
	bra	L10066
;            case KEY_BACKSPACE:
L10073:
;                if (curpos > 0)
;                {
	sep	#$20
	longa	off
	lda	#$0
	cmp	<L187+curpos_1
	rep	#$20
	longa	on
	bcs	L10066
;                    curpos--;
	sep	#$20
	longa	off
	dec	<L187+curpos_1
;                    curlen--;
	dec	<L187+curlen_1
	rep	#$20
	longa	on
;                    move (starty, startx + curpos);
	lda	<L187+curpos_1
	and	#$ff
	sta	<R0
	lda	<L187+startx_1
	and	#$ff
	clc
	adc	<R0
	pha
	pei	<L187+starty_1
	jsl	~~move
;
;                    for (i = curpos; i < curlen; i++)
	sep	#$20
	longa	off
	lda	<L187+curpos_1
	sta	<L187+i_1
	rep	#$20
	longa	on
	bra	L10078
L10077:
;                    {
;                        str[i] = str[i + 1];
	lda	<L187+i_1
	and	#$ff
	sta	<R0
	lda	<L187+i_1
	and	#$ff
	ina
	tay
	sep	#$20
	longa	off
	lda	[<L186+str_0],Y
	ldy	<R0
	sta	[<L186+str_0],Y
;                    }
	inc	<L187+i_1
	rep	#$20
	longa	on
L10078:
	sep	#$20
	longa	off
	lda	<L187+i_1
	cmp	<L187+curlen_1
	rep	#$20
	longa	on
	bcc	L10077
;                    str[i] = '\0';
	lda	<L187+i_1
	and	#$ff
	tay
	sep	#$20
	longa	off
	lda	#$0
	sta	[<L186+str_0],Y
	rep	#$20
	longa	on
;                    delch();
L20007:
	jsl	~~delch
;                }
;                break;
	brl	L10066
;
;            case KEY_DC:
L10079:
;                if (curlen > 0)
;                {
	sep	#$20
	longa	off
	lda	#$0
	cmp	<L187+curlen_1
	rep	#$20
	longa	on
	bcc	*+5
	brl	L10066
;                    curlen--;
	sep	#$20
	longa	off
	dec	<L187+curlen_1
;                    for (i = curpos; i < curlen; i++)
	lda	<L187+curpos_1
	sta	<L187+i_1
	rep	#$20
	longa	on
	bra	L10084
L10083:
;                    {
;                        str[i] = str[i + 1];
	lda	<L187+i_1
	and	#$ff
	sta	<R0
	lda	<L187+i_1
	and	#$ff
	ina
	tay
	sep	#$20
	longa	off
	lda	[<L186+str_0],Y
	ldy	<R0
	sta	[<L186+str_0],Y
;                    }
	inc	<L187+i_1
	rep	#$20
	longa	on
L10084:
	sep	#$20
	longa	off
	lda	<L187+i_1
	cmp	<L187+curlen_1
	rep	#$20
	longa	on
	bcc	L10083
;                    str[i] = '\0';
	lda	<L187+i_1
	and	#$ff
	tay
	sep	#$20
	longa	off
	lda	#$0
	sta	[<L186+str_0],Y
	rep	#$20
	longa	on
;                    delch();
;                }
;                break;
	bra	L20007
;
;            default:
L10085:
;                if (curlen < maxlen && (ch & 0x7F) >= 32 && (ch & 0x7F) < 127)      // printable ascii 7bit or printable 8bit ISO8859
;                {
	sep	#$20
	longa	off
	lda	<L187+curlen_1
	cmp	<L186+maxlen_0
	rep	#$20
	longa	on
	bcc	*+5
	brl	L10066
	lda	<L187+ch_1
	and	#<$7f
	sec
	sbc	#<$20
	bvs	L196
	eor	#$8000
L196:
	bmi	*+5
	brl	L10066
	lda	<L187+ch_1
	and	#<$7f
	sec
	sbc	#<$7f
	bvs	L198
	eor	#$8000
L198:
	bpl	*+5
	brl	L10066
;                    for (i = curlen; i > curpos; i--)
	sep	#$20
	longa	off
	lda	<L187+curlen_1
	sta	<L187+i_1
	rep	#$20
	longa	on
	bra	L10090
L10089:
;                    {
;                        str[i] = str[i - 1];
	lda	<L187+i_1
	and	#$ff
	sta	<R0
	lda	<L187+i_1
	and	#$ff
	clc
	adc	#$ffff
	tay
	sep	#$20
	longa	off
	lda	[<L186+str_0],Y
	ldy	<R0
	sta	[<L186+str_0],Y
;                    }
	dec	<L187+i_1
	rep	#$20
	longa	on
L10090:
	sep	#$20
	longa	off
	lda	<L187+curpos_1
	cmp	<L187+i_1
	rep	#$20
	longa	on
	bcc	L10089
;                    insch (ch);
	pei	<L187+ch_1
	jsl	~~insch
;                    str[curpos] = ch;
	lda	<L187+curpos_1
	and	#$ff
	tay
	sep	#$20
	longa	off
	lda	<L187+ch_1
	sta	[<L186+str_0],Y
;                    curpos++;
	inc	<L187+curpos_1
;                    curlen++;
	inc	<L187+curlen_1
	rep	#$20
	longa	on
;                }
;        }
	brl	L10066
L10064:
;    str[curlen] = '\0';
	lda	<L187+curlen_1
	and	#$ff
	tay
	sep	#$20
	longa	off
	lda	#$0
	sta	[<L186+str_0],Y
	rep	#$20
	longa	on
;}
	lda	<L186+2
	sta	<L186+2+6
	lda	<L186+1
	sta	<L186+1+6
	pld
	tsc
	clc
	adc	#L186+6
	tcs
	rtl
L186	equ	18
L187	equ	13
	ends
	efunc
;
;/*---------------------------------------------------------------------------------------------------------------------------------------------------
; * MCURSES: endwin
; *---------------------------------------------------------------------------------------------------------------------------------------------------
; */
;void
;endwin (void)
;{
	code
	xdef	~~endwin
	func
~~endwin:
	longa	on
	longi	on
;    move (LINES - 1, 0);                                                        // move cursor to last line
	pea	#<$0
	pea	#<$18
	jsl	~~move
;    clrtoeol ();                                                                // clear this line
	jsl	~~clrtoeol
;    mcurses_putc ('\017');                                                      // switch to G0 set
	pea	#<$f
	jsl	~~mcurses_putc
;    curs_set (TRUE);                                                            // show cursor
	pea	#<$1
	jsl	~~curs_set
;    mcurses_puts_P(SEQ_REPLACE_MODE);                                           // reset insert mode
	pea	#^L167
	pea	#<L167
	jsl	~~mcurses_puts_P
;    refresh ();                                                                 // flush output
	jsl	~~refresh
;    mcurses_phyio_done ();                                                      // end of physical I/O
	jsl	~~mcurses_phyio_done
;    mcurses_is_up = 0;
	sep	#$20
	longa	off
	stz	|~~mcurses_is_up
	rep	#$20
	longa	on
;}
	rtl
L202	equ	0
L203	equ	1
	ends
	efunc
	data
L167:
	db	$1B,$5B,$34,$6C,$00
	ends
;
	xref	~~fcntl
	xref	~~ioctl
	xref	~~strcmp
	xref	~~fileno
	xref	~~fflush
	xref	~~fputc
	xref	~~fgetc
	xref	~~vsprintf
	udata
~~mcurses_newmode
	ds	17
	ends
	udata
~~mcurses_oldmode
	ds	17
	ends
	udata
~~mcurses_halfdelay
	ds	1
	ends
	udata
~~mcurses_nodelay
	ds	1
	ends
	xref	~~stdout
	xref	~~stdin
