;--------------------------------------------------------------
; PLATFORM = 0 : Homebrew - FPGA
; PLATFORM = 1 : Homebrew - Hardware
; PLATFORM = 2 : Atari XL/XE
;--------------------------------------------------------------

IO		equ $FFFF00
ROMSTART	equ $E000	;$8000 = Test, $E000 = Prod

;--------------------------------------------------------------
; Kernel jumptable
;--------------------------------------------------------------
jkernel		equ ROMSTART
jchrin		set ROMSTART+$3
jchrout		set ROMSTART+$6
jprint		set ROMSTART+$9
jprinthex	set ROMSTART+$C
jgetupper	set ROMSTART+$F
jgethex		set ROMSTART+$12
jgetadr		set ROMSTART+$15
jnewline	set ROMSTART+$18
jspace		set ROMSTART+$1B
jhexdownload	set ROMSTART+$1E
jmemdump	set ROMSTART+$21
jinputhex	set ROMSTART+$24
jchangemem	set ROMSTART+$27
jfillmem	set ROMSTART+$2A
jfill		set ROMSTART+$2D
jnmin		set ROMSTART+$30
jirqn		set ROMSTART+$33
jbrk		set ROMSTART+$36
jtime		set ROMSTART+$39
jmenu		set ROMSTART+$3C
jdisass		set ROMSTART+$3F
jdisone		set ROMSTART+$42
jrs232v		set ROMSTART+$45
jsetaddress	set ROMSTART+$48
jmemdump16	set ROMSTART+$4B
jkgbirq		set ROMSTART+$4E

;--------------------------------------------------------------
;	IOCB equates
;--------------------------------------------------------------
ICSTAZ		equ	$0023
IOCBSTRT	equ	$0280		
IOCB		set	IOCBSTRT+$0
ICHID		set	IOCBSTRT+$0
ICDNO		set	IOCBSTRT+$1
ICCOM		set	IOCBSTRT+$2
ICSTA		set	IOCBSTRT+$3
ICBAL		set	IOCBSTRT+$4
ICBAH		set	IOCBSTRT+$5
ICPTL		set	IOCBSTRT+$6
ICPTH		set	IOCBSTRT+$7
ICBLL		set	IOCBSTRT+$8
ICBLH		set	IOCBSTRT+$9
ICAX1		set	IOCBSTRT+$A
ICAX2		set	IOCBSTRT+$B
ICSPR		set	IOCBSTRT+$C
	
;--------------------------------------------------------------
;	IOCB Command Code equates
;--------------------------------------------------------------
OPEN		equ	$03	;open
GETREC		equ	$05	;get record
GETCHR		equ	$07	;get character(s) (binary)
PUTREC		equ	$09	;put record
PUTCHR		equ	$0B	;put character(s)
CLOSE		equ	$0C	;close
STATIS		equ	$0D	;status
SPECIL		equ	$0E	;special

;--------------------------------------------------------------
;	processor flags
;--------------------------------------------------------------
M		equ	$20
IX		equ	$10
CARRY		equ	1

;--------------------------------------------------------------
;	page 2
;--------------------------------------------------------------
IRQVEC		equ	$0249	;2-byte
JSLOP		equ	$025E	;1-byte JSL-opcode
JSLADR		equ	$025F	;3-byte JSL address
JSLRTS		equ	$0262	;1-byte RTS-opcode
JMLOP		equ	$0263	;1-byte JML-opcode
JMLADR		equ	$0264	;3-byte JML address

;--------------------------------------------------------------
; Homebrew PS2-keyboard and SD-Card 
;--------------------------------------------------------------
PS2DATA		equ $BFD0		; keyboard scancode
PS2STATUS	equ $BFD1		; read: Bit0 = 0 scancode available 
SPIDATA		equ $BFD2		; read: Bit0 serial data in, write: Bit7 serial data out 
SPIMOSI		equ $BFD3		; write: Bit0: 1 = Mosi always 1, Bit1: write: CS of SDCard

;--------------------------------------------------------------
; Homebrew MC68681 double serial card
;--------------------------------------------------------------
SB		equ $BFF0

MODEA		equ 0
STATA		equ 1
CLOCKA		equ 1
COMMA		equ 2
RECA		equ 3
TRANSA		equ 3
IPCHANGE	equ 4
AUXCTRL		equ 4
ISR		equ 5
IMR		equ 5
CNTMSB		equ 6
CNTLSB		equ 7
MODEB		equ 8
STATB		equ 9
CLOCKB		equ 9
COMMB		equ 10
RECB		equ 11
TRANSB		equ 11
IVR		equ 12
INPORT		equ 13
OPCTRL		equ 13
STRTCNT		equ 14
OPSET		equ 14
STOPCNT		equ 15
OPRES		equ 15


;--------------------------------------------------------------
; FPGA display device
;--------------------------------------------------------------
LED542			set IO+$80		;BIT7=Reset, Bit 210=LED542	
TIMERLO 		set IO+$81
TIMERHI			set IO+$82 	
TIMERST			set IO+$83
MULINAL			set IO+$84
MULINAH			set IO+$86
MULINBL			set IO+$88
MULINBH			set IO+$8A
MULOUTL			set IO+$8C
MULOUTH			set IO+$8E
CONST5MS		equ 55466
;--------------------------------------------------------------
; FPGA SPI device
;--------------------------------------------------------------
SPI			set IO+$90
SPICNTL			set SPI
SPISS			set SPI+1
SPIDAT			set SPI+2
SPISTAT			set SPI+3

;--------------------------------------------------------------
; FPGA display device
;--------------------------------------------------------------
DISP			set $FFFE00
colorBorderLo		set DISP+0		
colorBorderHi		set DISP+1
colorBackgroundLo	set DISP+2
colorBackgroundHi	set DISP+3
color00Lo		set DISP+4		
color00Hi		set DISP+5
screenBaseLo		set DISP+6
screenBaseHi		set DISP+7
screenBaseBank		set DISP+8
control			set DISP+9
;Bit 0 - 0: Text 640x200, 1: HiRes 640x200
;Bit 1 - 0: see above, 1: LoRes 320x200 8/9 bit color-depth
;Bit 2 - 0: cursor off, 1: cursorn on
;Bit 3 - 0: palette color, 1: 8-bit color (bbgggrrr)
cursorLo		set DISP+$A
cursorHi		set DISP+$B	
rasterLo		set DISP+$C
rasterHi		set DISP+$D
dispStatus		set DISP+$E

;--------------------------------------------------------------
; FPGA 16540 UART device
;--------------------------------------------------------------
ACIA0			set IO+$E0;
RBR0			set ACIA0;
THR0			set ACIA0;
IER0			set ACIA0+1
IIR0			set ACIA0+2
LCR0			set ACIA0+3
MCR0			set ACIA0+4
LSR0			set ACIA0+5
MSR0			set ACIA0+6
SCR0			set ACIA0+7
DLL0			set ACIA0;
DLM0			set ACIA0+1