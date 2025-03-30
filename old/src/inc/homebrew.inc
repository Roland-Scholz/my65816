;
; PLATFORM = 0 : Homebrew - FPGA	(deprecated)
; PLATFORM = 1 : Homebrew - Hardware	(deprecated)
; PLATFORM = 2 : Atari XL/XE
; PLATFORM = 3 : 65816 FPGA-Computer
;
IO		= $FFFF00
ROMSTART	= $E000		;$8000 = Test, $E000 = Prod

;--------------------------------------------------------------
; Kernel jumptable
;--------------------------------------------------------------
jkernel		= ROMSTART
jchrin		= ROMSTART + $3
jchrout		= ROMSTART + $6
jprint		= ROMSTART + $9
jprinthex	= ROMSTART + $C
jgetupper	= ROMSTART + $F
jgethex		= ROMSTART + $12
jgetadr		= ROMSTART + $15
jnewline	= ROMSTART + $18
jspace		= ROMSTART + $1B
jhexdownload	= ROMSTART + $1E
jmemdump	= ROMSTART + $21
jinputhex	= ROMSTART + $24
jchangemem	= ROMSTART + $27
jfillmem	= ROMSTART + $2A
jfill		= ROMSTART + $2D
jnmin		= ROMSTART + $30
jirqn		= ROMSTART + $33
jbrk		= ROMSTART + $36
jtime		= ROMSTART + $39
jmenu		= ROMSTART + $3C
jdisass		= ROMSTART + $3F
jdisone		= ROMSTART + $42
jrs232v		= ROMSTART + $45
jsetaddress	= ROMSTART + $48
jmemdump16	= ROMSTART + $4B
jkgbirq		= ROMSTART + $4E	;(4-bytes !!)
jdisass24	= ROMSTART + $52	
jcopn		= ROMSTART + $55

;
; Dummy vectors
;
jcope		= ROMSTART + $30
jaborte		= ROMSTART + $30
jabortn		= ROMSTART + $30
jirqe		= ROMSTART + $30
jnmie		= ROMSTART + $30


;--------------------------------------------------------------
; SD CARD constants
;--------------------------------------------------------------
CMD0		= $40 +  0	;GO_IDLE_STATE	0x40, 64
CMD1		= $40 +  1	;reset
CMD8		= $40 +  8	;SEND_IF_COND	0x48, 72
CMD9		= $40 +  9	;SEND_CSD	0x49, 73
CMD13		= $40 + 13	;get_status	0x4D, 77
CMD17		= $40 + 17	;read  sector 	0x51, 81
CMD24		= $40 + 24	;write sector 	0x58, 88
CMD41		= $40 + 41	;SEND_OP_COND	0x69, 105 (leave idle state)
CMD55		= $40 + 55	;ACMD 		0x77, 119	
CMD58		= $40 + 58	;READ_OCR	0x7A, 122

DATA_START_BLOCK	= $FE
DATA_RES_MASK		= $1F
DATA_RES_ACCEPTED	= $05

CMD0CHK		= $95
CMD1CHK		= $F9
CMD8CHK		= $87

R1_IDLE_STATE	= 1
R1_ILLEGAL_COMMAND = 4

;--------------------------------------------------------------
; MISC constants
;--------------------------------------------------------------	

NEGATIVE	= $80
OVERFLOW	= $40		; 
M		= $20		; Accu 8/16-bit
IX		= $10		; Index 8/16-bit
DECIMAL_FLAG	= $08		; Decimal Flag
ID		= $04		; IRQ disable
ZERO		= $02		; zero flag
CARRY		= $01		; Carry

CHARS40		= 40
CHARS80		= 80
NUMROWS		= 25

;	special key scan-codes
ALTGR		= $11	;extended!
ALR		= $11
CLSHIFT		= $12
CLSTRG		= $14
CRSHIFT		= $59
CCAPS		= $58

CCHARLINE	= 80	;80 chars per line

	.if PLATFORM = 0
SCRSTRT		= $F000
SCRBANK		= $7F
	.else
SCRSTRT		= $C000
	.endif
charset		= $F800

jusermenu	= $0400
juserkeys	= $0403

;--------------------------------------------------------------
; ATARI constants
;--------------------------------------------------------------
LEDGE	= 	0	;left edge

MAXDEV	=	33	;offset to last possible entry of HATABS

IOCBSZ	=	16	;length of IOCB
IOCFRE	=	$FF	;IOCB free indicator

SEIOCB	=	0*IOCBSZ	;screen editor IOCB index
MAXIOC	=	8*IOCBSZ	;first invalid IOCB index

;--------------------------------------------------------------
;	Device Code equates
;--------------------------------------------------------------
CASSET	=	'C'	;cassette
DISK	=	'D'	;disk
SCREDT	=	'E'	;screen editor
KBD	=	'K'	;keyboard
PRINTR	=	'P'	;printer
DISPLY	=	'S'	;screen display
RS232D	=	'R'	;RS232 serial interface

;--------------------------------------------------------------
;	IOCB Command Code equates
;--------------------------------------------------------------
OPEN	=	$03	;open
GETREC	=	$05	;get record
GETCHR	=	$07	;get character(s) (binary)
PUTREC	=	$09	;put record
PUTCHR	=	$0B	;put character(s)
CLOSE	=	$0C	;close
STATUS	=	$0D	;status
SPECIL	=	$0E	;special

CXIO36	= 	36
CXIO38	=	38
CXIO40	=	40

;--------------------------------------------------------------
;	Character and Key Code equates
;--------------------------------------------------------------
			;SUPERF <>  0
			
CCHM	=	$1C	;move cursor home
CCBT	=	$1D	;move cursor to bottom
CCLM	=	$1E	;move cursor to left margin
CCRM	=	$1F	;move cursor to right margin

			;SUPERF = 0
			
CLS	=	$01	;clear screen
BACK	=	$08	;backspace
EOL	=	$0A	;$9B	;end of line (RETURN)
ESC	=	$1B	;escape key
CCUP	=	$1C	;cursor up
CCDN	=	$1D	;cursor down
CCLF	=	$1E	;cursor left
CCRT	=	$1F	;cursor right
CSPACE	=	$20	;space
TABU	=	$7F	;tabulator
CILN	=	$9D	;insert line
CDCH	=	$FE	;delete character
CICH	=	$FF	;insert character

HELP	=	$11	;key code for HELP
CNTLF1	=	$83	;key code for CTRL-F1
CNTLF2	=	$84	;key code for CTRL-F2
CNTLF3	=	$93	;key code for CTRL-F3
CNTLF4	=	$94	;key code for CTRL-F4
CNTL1	=	$9F	;key code for CTRL-1

;--------------------------------------------------------------
;	Status Code equates
;--------------------------------------------------------------
SUCCES	=	1	;successful operation

BRKABT	=	128	;BREAK key abort
PRVOPN	=	129	;IOCB already open error
NONDEV	=	130	;nonexistent device error
WRONLY	=	131	;IOCB opened for write only error
NVALID	=	132	;invalid command error
NOTOPN	=	133	;device/file not open error
BADIOC	=	134	;invalid IOCB index error
RDONLY	=	135	;IOCB opened for read only error
EOFERR	=	136	;end of file error
TRNRCD	=	137	;truncated record error
TIMOUT	=	138	;peripheral device timeout error
DNACK	=	139	;device does not acknowledge command error
FRMERR	=	140	;serial bus framing error
CRSROR	=	141	;cursor overrange error
OVRRUN	=	142	;serial bus data overrun error
CHKERR	=	143	;serial bus checksum error
DERROR	=	144	;device done (operation incomplete) error
BADMOD	=	145	;bad screen mode number error
FNCNOT	=	146	;function not implemented in handler error
SCRMEM	=	147	;insufficient memory for screen mode error

;--------------------------------------------------------------
; Homebrew variables Zero page
;--------------------------------------------------------------
ptr		= $00	;2-byte misc. pointer
memptr		= $02	;3-byte pointer

PCREG		= $02   ;3-byte redefine for disassembler
PCREGH		= PCREG+1
PCREGB		= PCREGH+1 
 
chksum		= $05	;1-byte checksum

FATPTRS_	= $06	;2-byte FAT source pointer
FATPTRD_	= $08	;2-byte FAT destination pointer
PTRDUP		= $0A	;2-byte misc. pointer DUP
SECPTR		= $0C	;2-byte sector pointer
CHRPTR		= $0E	;2-byte sector pointer hi-res char handling
DEVICNO		= $10	;1-byte stdout device (0=RS232, 1=CRT)
TEMP		= $11	;3-byte pointer for debug16
TEMPH		= $12
TEMPB		= $13
PREG		= $14	;1-byte P STATUS REGISTER
gethex_A	= $15	;1-byte save accu


;--------------------------------------------------------------
; ATARI zeropage
;--------------------------------------------------------------
ZIOCB	=	$0020	;address of page zero IOCB
IOCBAS	=	$0020	;16-byte page zero IOCB
ICHIDZ	=	$0020	;1-byte handler ID ($FF = IOCB free)
ICDNOZ	=	$0021	;1-byte device number
ICCOMZ	=	$0022	;1-byte command code
ICSTAZ	=	$0023	;1-byte status of last action
ICBALZ	=	$0024	;1-byte buffer address low
ICBAHZ	=	$0025	;1-byte buffer address high
ICBABZ	=	$0026	;1-byte buffer address bank
ICBLLZ	=	$0027	;1-byte buffer length low
ICBLHZ	=	$0028	;1-byte buffer length high
ICBLBZ	=	$0029	;1-byte buffer length bank
ICAX1Z	=	$002A	;1-byte first auxiliary information
ICAX2Z	=	$002B	;1-byte second auxiliary information
ICSPRZ	=	$002C	;4-byte spares
;ENTVEC	=	$002C	;2-byte (not used)
ICIDNO	=	$002E	;1-byte IOCB index (IOCB number times IOCBSZ)
CIOCHR	=	$002F	;1-byte character for current CIO operation
;ICPTLZ	=	$0026	;1-byte low PUT-BYTE routine address-1
;ICPTHZ	=	$0027	;1-byte high PUT-BYTE routine address-1
	
BRKKEY	=	$0030	;1-byte BREAK key flag (0 = no BREAK)
ICCOMT	=	$0031	;1-byte CIO command table index
DSTAT	=	$0032	;1-byte display status
TMPCHR	=	$0033	;1-byte	temporary character
HOLD1	=	$0034	;1-byte	temporary
LMARGN	=	$0035	;1-byte text column left margin
RMARGN	=	$0036	;1-byte text column right margin
ROWCRS	=	$0037	;1-byte cursor row
COLCRS	=	$0038	;2-byte cursor column
ALTACT	=	$003A	;1-byte ALRGR active --display mode
SAVMSC	=	$003B	;2-byte saved memory scan counter
OLDROW	=	$003D	;1-byte prior row
OLDCOL	=	$003E	;2-byte prior column
OLDCHR	=	$0040	;1-byte saved character under cursor
OLDADR	=	$0041	;3-byte saved cursor memory address

LOGCOL	=	$0044	;1-byte logical line cursor column

;DUMMY	=	$0044	;2-byte temporary address

;MLTTMP	=	$0046	;1-byte temporary
;OPNTMP	=	$0046	;1-byte open temporary
TOADR	=	$0045	;3-byte destination address

SAVADR	=	$0048	;3-byte saved address
FRMADR	=	$0048	;3-byte source address

RAMTOP	=	$004B	;1-byte RAM size
BUFCNT	=	$004C	;1-byte buffer count (logical line size)
BUFSTR	=	$004D	;2-byte buffer start pointer
BITMSK	=	$004F	;1-byte bit mask for bit map operation
;SHFAMT	=	$004F	;1-byte shift amount for pixel justification
ROWAC	=	$0050	;2-byte draw working row
COLAC	=	$0052	;2-byte draw working column
ENDPT	=	$0054	;2-byte end point
DELTAR	=	$0056	;1-byte row difference
DELTAC	=	$0057	;2-byte column difference
SWPFLG	=	$0059	;1-byte split screen swap flag (0 = not swapped)
INSDAT	=	$005A	;1-byte temporary
COUNTR	=	$005B	;2-byte draw iteration count
ADRESS	=	$005D	;3-byte temporary address



XREG	= ADRESS+3       ; X REGISTER
XREGH 	= XREG+1

YREG	= XREGH+1        ; Y REGISTER
YREGH	= YREG+1

AREG	= YREGH+1        ; ACCUMULATOR
AREGH	= AREG+1

STACK	= AREGH+1        ; STACK POINTER
STACKH	= STACK+1	

;--------------------------------------------------------------
; page 2
;--------------------------------------------------------------
TXTROW	=	$0200	;1-byte split screen text cursor row
TXTCOL	=	$0201	;2-byte split screen text cursor column
TINDEX	=	$0203	;1-byte split scree text mode
TXTMSC	=	$0204	;2-byte split screen memory scan counter
TXTOLD	=	$0206	;6-byte OLDROW, OLDCOL, OLDCHR, OLDADR for text
HOLD3	=	$020C	;1-byte temporary
SUBTMP	=	$020D	;1-byte temporary
HOLD2	=	$020E	;1-byte (not used)
;DMASK	=	$020F	;1-byte display (pixel location) mask
;TMPLBT	=	$0210	;1-byte (not used)
RASVEC	=	$020F	;raster interrupt vector
ESCFLG	=	$0211	;1-byte escape flag ($80 = ESC detected)
TABMAP	=	$0212	;15-byte (120-bit) tab stop bit map
LOGMAP	=	$0221	;8-byte (32-bit) logical line bit map
CLSFLG	=	$0229	;1-byte clear screen flag
FILFLG	=	$022A	;1-byte right fill flag (0 = no fill)
TMPROW	=	$022B	;1-byte temporary row
TMPCOL	=	$022C	;2-byte temporary column
SCRFLG	=	$022E	;1-byte scroll occurence flag (0 = not occurred)
HOLD4	=	$022F	;1-byte temporary
DRETRY	=	$0230	;1-byte number of device retries
SHFLOK	=	$0231	;1-byte shift/control lock flags
BOTSCR	=	$0232	;1-byte screen bottom (24 = normal, 4 = split)

DVSTAT	=	$0233	;4-byte device status buffer
CRSINH	=	$0237	;1-byte cursor inhibit (0 = cursor on)
DUMMY00	=	$0238	;1-byte key debounce delay timer
CH1	=	$0239	;1-byte prior keyboard character

NEWROW	=	$023A	;1-byte draw destination row
NEWCOL	=	$023B	;2-byte draw destination column
ROWINC	=	$023D	;1-byte draw row increment
COLINC	=	$023E	;1-byte	draw column increment

CHAR	=	$023F	;1-byte internal character
ATACHR	=	$0240	;1-byte ATASCII character or plot point
FILDAT	=	$0241	;1-byte right fill data
DSPFLG	=	$0242	;1-byte control character display flag (0 = no)
SSFLAG	=	$0243	;1-byte start/stop flag (0 = not stopped)

SUPERF	=	$0244	;1-byte editor super function flag :
;DERRF	=	$0245	;1-byte screen OPEN error flag (0 = not)

skipone	=	$0246	;1-byte
extended=	$0247	;1-byte
ADRCNT	=	$0248	;1-byte counter for setaddress

IRQVEC	=	$0249	;2-byte
NMIVEC	=	$024B	;2-byte
jmpind	=	$024D	;1-byte $4C = JMP
jmpptr	=	$024E	;2-byte
DBUFLO	=	$0250	;2-byte ;2-byte adr of 512-byte buffer for SD CARD read/Write
sdcmd	=	$0252	;1-byte SD card command
sdadr	=	$0253	;4-byte SD card address
sdchk	=	$0257	;1-byte SD card checksum
sdres	=	$0258	;1-byte SD card R1 result
sddebug =	$0259	;1-byte SD card debug flag
FVEC	=	$025A	;2-byte executable file start vector
FINIT	=	$025C	;2-byte executable file init vector
JSLOP	=	$025E	;1-byte JSL-opcode
JSLADR	=	$025F	;3-byte JSL address
JSLRTS	=	$0262	;1-byte RTS-opcode
JMLOP	=	$0263	;1-byte JML-opcode
JMLADR	=	$0264	;3-byte JML address
DEVSTAT	=	$0269	;4-byte device status
SERCNT0	= 	$026D	;1-byte RS232 0 control bits
SERCNT1	= 	$026E	;1-byte RS232 1 control bits
CONST5MS=	$026F	;2-byte timer const
MSTATE	=	$0270	;1-byte state of mouse protocol (0,1,2)
MPOSX	=	$0271	;2-byte mouse x-pos
MPOSY	=	$0273	;2-byte mouse y-pos
MDXDY	=	$0275	;1-byte mouse 1st byte of protocol 
MONACT	=	$027B	;4-byte break-monitor active flags

IOCBSTRT=	$0280		;start of IOCB
IOCB	=	IOCBSTRT + $0	;128-byte I/O control blocks area
ICHID	=	IOCBSTRT + $0	;1-byte handler ID ($FF = free)
ICDNO	=	IOCBSTRT + $1	;1-byte device number
ICCOM	=	IOCBSTRT + $2	;1-byte command code
ICSTA	=	IOCBSTRT + $3	;1-byte status of last action
ICBAL	=	IOCBSTRT + $4	;1-byte low buffer address
ICBAH	=	IOCBSTRT + $5	;1-byte high buffer address
ICBAB	=	IOCBSTRT + $6	;1-byte bank buffer address
ICBLL	=	IOCBSTRT + $7	;1-byte low buffer length
ICBLH	=	IOCBSTRT + $8	;1-byte high buffer length
ICBLB	=	IOCBSTRT + $9	;1-byte bank buffer length
ICAX1	=	IOCBSTRT + $A	;1-byte first auxiliary information
ICAX2	=	IOCBSTRT + $B	;1-byte second auxiliary information
ICSPR	=	IOCBSTRT + $C	;4-byte work area
;ICPTL	=	IOCBSTRT + $6	;1-byte low PUT-BYTE routine address-1
;ICPTH	=	IOCBSTRT + $7	;1-byte high PUT-BYTE routine address-1
;--------------------------------------------------------------
; page 3
;--------------------------------------------------------------
HATABS	=	$0300	;12 * 3-byte entries for HATABS
;MONTAB	=	$0324	;8-byte break-monitor pointer
flags	=	$032C	;1-byte processor flags during IRQ
IRQPS2S	=	$032D	;1-byte PS2-status from IRQ
IRQPS2D =	$032E	;1-byte PS2-data from IRQ
DEVICS	=	$032F	;1-byte DEVICENO SAVE
BRKBRA	=	$0330	;1-byte branch opcode
BRKOFF	=	$0331	;1-byte branch offset (always 3)
BRKNOT	=	$0332	;1-byte jmp branch not taken (always $4c)
BRKJMP0	=	$0333	;2-byte jmp address branch not taken
BRKTAK	=	$0335	;1-byte jmp branch taken (always $4c)
BRKJMP1	=	$0336	;2-byte jmp address branch taken
BRKVEC	=	$0338	;2-byte BRK vector (65816)
WARMFLAG=	$033A	;1-byte Warmstart = $CA
ARGC	=	$033B	;2-byte number of args
ARGV	=	$033D	;8*2-bytes pointer to arg strings
NCODE	= 	$034D	;1-byte NEXT CODE TO BE TRACED
OPCREG	=	$034E	;3-byte OLD PROGRAM COUNTER VALUE
OPCREGH	=	$034F	
OPCREGB	=	$0350
CODE	=	$0351	;1-byte CURRENT CODE TO BE TRACED
OPRNDL	=	$0352	;3-byte OPERANDS OF CURRENT INSTRUCTION
OPRNDH	=	$0353 
OPRNDB	=	$0354
ADDRMODE=	$0355	; ADDRESS MODE OF CURRENT OPCODE

MNX	=	$0356 	;2-byte MNEMONIC INDEX
                        ; FROM ATTRIBUTE TABLE
OPLEN 	=	$0358   ;1-byte LENGTH OF OPERATION,
                        ; INCLUDING INSTRUCTION
MOVENEG	=	$0359	;4-byte MVP + operands + RTS
MOVEBNK	=	$035A
MOVERTS	=	$035C	;RTS

MODBASE	=	$035D	;2-byte base for next module to be loaded

MONTAB	=	$0360	;4*4-byte break-monitor pointer

COLCNT	=	$0370	;
COPVEC	=	$0371	;2-byte COP vector

MOUSEX	=	$0373	;2-byte Mouse-X
MOUSEY	=	$0375	;2-byte Mouse-Y
MOUBUT	=	$0377	;Mouse-Button Bit7:links, Bit6:rechts

NEXTFRE	=	$0378	;

FNAME	= 	$0380	;128-byte buffer for line
;--------------------------------------------------------------
; page 4
;--------------------------------------------------------------

;--------------------------------------------------------------
; Homebrew MC6845 graphics
;--------------------------------------------------------------
crtadr		= $B800
crtdata		= $B801

crtcol0		= $B880
crtcol1		= $B881
crtcol2		= $B882
crtcol3		= $B883
crtcolb		= crtcol3

crtcntl		= $B8C0
crtirq		= $B8C1

;--------------------------------------------------------------
; Homebrew MOS6551 serial card
;--------------------------------------------------------------
;data6551	= $DB00
;status6551	= $DB01
;command6551	= $DB02
;control6551	= $DB03

;--------------------------------------------------------------
; Homebrew YM2612 registers
;--------------------------------------------------------------
YMADR0		= $BFB0
YMDAT0		= $BFB1
YMADR1		= $BFB2
YMDAT1		= $BFB3

;--------------------------------------------------------------
; Homebrew	Memory Control 
;--------------------------------------------------------------
MEMCNTL		= $BFC0

;--------------------------------------------------------------
; Homebrew PS2-keyboard and SD-Card 
;--------------------------------------------------------------
PS2		= IO + $D0
PS2DATA		= PS2 + 0	; keyboard scancode
PS2STATUS	= PS2 + 1	; read: Bit0 = 0 scancode available 
SPIDATA		= PS2 + 2	; read: Bit0 serial data in, write: Bit7 serial data out 
SPIMOSI		= PS2 + 3	; write: Bit0: 1 = Mosi always 1, Bit1: write: CS of SDCard

;--------------------------------------------------------------
; Homebrew Centronics 8-bit latch
;--------------------------------------------------------------
CENTRONICS	= $BFE0

;--------------------------------------------------------------
; Homebrew MC68681 double serial card
;--------------------------------------------------------------
SB		= $BFF0

MODEA		= 0
STATA		= 1
CLOCKA		= 1
COMMA		= 2
RECA		= 3
TRANSA		= 3
IPCHANGE	= 4
AUXCTRL		= 4
ISR		= 5
IMR		= 5
CNTMSB		= 6
CNTLSB		= 7
MODEB		= 8
STATB		= 9
CLOCKB		= 9
COMMB		= 10
RECB		= 11
TRANSB		= 11
IVR		= 12
INPORT		= 13
OPCTRL		= 13
STRTCNT		= 14
OPSET		= 14
STOPCNT		= 15
OPRES		= 15

;--------------------------------------------------------------
; 6502 CPU vectors
;--------------------------------------------------------------
NMI		= $FFFA
RESET		= $FFFC  
IRQ		= $FFFE

;--------------------------------------------------------------
; FPGA misc. stuff
;--------------------------------------------------------------
		
;--------------------------------------------------------------
; RESET, TIMER, HARDWARE MULT.
;--------------------------------------------------------------
SOFTRESET	= IO + $80		
TIMERLO 	= IO + $81
TIMERHI		= IO + $82 	
TIMERST		= IO + $83
WORDLO		= IO + $84
WORDHI		= IO + $85
DOTS		= IO + $86

CCONST5MS	= 62400-1
;--------------------------------------------------------------
; SPI SD-card interface
;--------------------------------------------------------------
SPI		= IO + $90
SPICNTL		= SPI
SPISS		= SPI + 1
SPIDAT		= SPI + 2
SPISTAT		= SPI + 3

;--------------------------------------------------------------
; 16450 ACIA registers (Uart1, Mouse)
;--------------------------------------------------------------
ACIA1		= IO + $A0
RBR1		= ACIA1
THR1		= ACIA1
IER1		= ACIA1 + 1
IIR1		= ACIA1 + 2
LCR1		= ACIA1 + 3
MCR1		= ACIA1 + 4
LSR1		= ACIA1 + 5
MSR1		= ACIA1 + 6
SCR1		= ACIA1 + 7
DLL1		= ACIA1
DLM1		= ACIA1 + 1

;--------------------------------------------------------------
; graphics system
;--------------------------------------------------------------
DISP			= $FFFE00
colorBorderLo		= DISP + 0
colorBorderHi		= DISP + 1
colorBackgroundLo	= DISP + 2
colorBackgroundHi	= DISP + 3
color00Lo		= DISP + 4
color00Hi		= DISP + 5	
screenBaseLo		= DISP + 6
screenBaseHi		= DISP + 7
screenBaseBank		= DISP + 8
control			= DISP + 9
cursorLo		= DISP + 10		
cursorHi		= DISP + 11
rasterLo		= DISP + 12
rasterHi		= DISP + 13
dispStatus		= DISP + 14
vcountLo		= DISP + 15
vcountHi		= DISP + 16
;spriteBaseLo		= DISP + 17
;spriteBaseHi		= DISP + 18
spriteBaseBank		= DISP + 19
spriteCntl		= DISP + 20
sprite0addr		= DISP + 21
sprite1addr             = DISP + 22
sprite2addr             = DISP + 23
sprite3addr             = DISP + 24
sprite4addr             = DISP + 25
sprite5addr             = DISP + 26
sprite6addr             = DISP + 27
sprite7addr             = DISP + 28                    
xpos0			= DISP + 32
xpos1			= DISP + 33
xpos2			= DISP + 34
xpos3			= DISP + 35
xpos4			= DISP + 36
xpos5			= DISP + 37
xpos6			= DISP + 38
xpos7			= DISP + 39
xposHi			= DISP + 40

palette 		= $FFFC00
spritePalette		= $FFFE40
sprite0			= $7E0000

;--------------------------------------------------------------
; 16450 ACIA registers (Uart0)
;--------------------------------------------------------------
ACIA0		= IO + $E0
RBR0		= ACIA0
THR0		= ACIA0
IER0		= ACIA0 + 1
IIR0		= ACIA0 + 2
LCR0		= ACIA0 + 3
MCR0		= ACIA0 + 4
LSR0		= ACIA0 + 5
MSR0		= ACIA0 + 6
SCR0		= ACIA0 + 7
DLL0		= ACIA0
DLM0		= ACIA0 + 1

SECPTRLO	= ACIA0 + 8
SECPTRHI	= ACIA0 + 9
READWRITE	= ACIA0 + 10
BUFPTRLO	= ACIA0 + 11
BUFPTRHI	= ACIA0 + 12

