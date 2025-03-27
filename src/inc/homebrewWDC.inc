;
; PLATFORM  equ 0 : Homebrew - FPGA
; PLATFORM  equ 1 : Homebrew - Hardware
; PLATFORM  equ 2 : Atari XL/XE
;
IO		 equ $FFFF00
ROMSTART	 equ $E000		;$8000 

;--------------------------------------------------------------
; Kernel jumptable
;--------------------------------------------------------------
jkernel		 equ ROMSTART
jchrin		 equ ROMSTART+$3
jchrout		 equ ROMSTART+$6
jprint		 equ ROMSTART+$9
jprinthex	 equ ROMSTART+$C
jgetupper	 equ ROMSTART+$F
jgethex		 equ ROMSTART+$12
jgetadr		 equ ROMSTART+$15
jnewline	 equ ROMSTART+$18
jspace		 equ ROMSTART+$1B
jhexdownload	 equ ROMSTART+$1E
jmemdump	 equ ROMSTART+$21
jinputhex	 equ ROMSTART+$24
jchangemem	 equ ROMSTART+$27
jfillmem	 equ ROMSTART+$2A
jfill		 equ ROMSTART+$2D
jnmin		 equ ROMSTART+$30
jirqn		 equ ROMSTART+$33
jbrk		 equ ROMSTART+$36
jtime		 equ ROMSTART+$39
jmenu		 equ ROMSTART+$3C
jdisass		 equ ROMSTART+$3F
jdisone		 equ ROMSTART+$42
jrs232v		 equ ROMSTART+$45
jsetaddress	 equ ROMSTART+$48
jmemdump16	 equ ROMSTART+$4B
jkgbirq		 equ ROMSTART+$4E	;(4-bytes !!)
jdisass24	 equ ROMSTART+$52
jcopn		 equ ROMSTART+$55

;
; Dummy vectors
;
jcope		 equ ROMSTART+$30
jaborte		 equ ROMSTART+$30
jabortn		 equ ROMSTART+$30
jirqe		 equ ROMSTART+$30
jnmie		 equ ROMSTART+$30


;--------------------------------------------------------------
; SD CARD constants
;--------------------------------------------------------------
CMD0		 equ $40+0	;GO_IDLE_STATE	0x40, 64
CMD1		 equ $40+1	;reset
CMD8		 equ $40+8	;SEND_IF_COND	0x48, 72
CMD9		 equ $40+9	;SEND_CSD	0x49, 73
CMD13		 equ $40+13	;get_status	0x4D, 77
CMD17		 equ $40+17	;read  sector 	0x51, 81
CMD24		 equ $40+24	;write sector 	0x58, 88
CMD41		 equ $40+41	;SEND_OP_COND	0x69, 105 (leave idle state)
CMD55		 equ $40+55	;ACMD 		0x77, 119
CMD58		 equ $40+58	;READ_OCR	0x7A, 122

DATA_START_BLOCK	 equ $FE
DATA_RES_MASK		 equ $1F
DATA_RES_ACCEPTED	 equ $05

CMD0CHK		 equ $95
CMD1CHK		 equ $F9
CMD8CHK		 equ $87

R1_IDLE_STATE	 equ 1
R1_ILLEGAL_COMMAND  equ 4

;--------------------------------------------------------------
; MISC constants
;--------------------------------------------------------------	

NEGATIVE	 equ $80
OVERFLOW	 equ $40		; 
M		 equ $20		; Accu 8/16-bit
IX		 equ $10		; Index 8/16-bit
DECIMAL_FLAG	 equ $08		; Decimal Flag
ID		 equ $04		; IRQ disable
ZERO		 equ $02		; zero flag
CARRY		 equ $01		; Carry

CHARS40		 equ 40
CHARS80		 equ 80
NUMROWS		 equ 25

;	special key scan-codes
ALTGR		 equ $11	;extended!
ALR		 equ $11
CLSHIFT		 equ $12
CLSTRG		 equ $14
CRSHIFT		 equ $59
CCAPS		 equ $58

CCHARLINE	 equ 80	;80 chars per line

	.if PLATFORM  equ 0
SCRSTRT		 equ $F800
SCRBANK		 equ $7F
	.else
SCRSTRT		 equ $C000
	.endif
charset		 equ $F800

jusermenu	 equ $0400
juserkeys	 equ $0403

;--------------------------------------------------------------
; ATARI constants
;--------------------------------------------------------------
LEDGE	 equ 	0	;left edge

MAXDEV	 equ	33	;offset to last possible entry of HATABS

IOCBSZ	 equ	16	;length of IOCB
IOCFRE	 equ	$FF	;IOCB free indicator

SEIOCB	 equ	0*IOCBSZ	;screen editor IOCB index
MAXIOC	 equ	8*IOCBSZ	;first invalid IOCB index

;--------------------------------------------------------------
;	Device Code equates
;--------------------------------------------------------------
CASSET	 equ	'C'	;cassette
DISK	 equ	'D'	;disk
SCREDT	 equ	'E'	;screen editor
KBD	 equ	'K'	;keyboard
PRINTR	 equ	'P'	;printer
DISPLY	 equ	'S'	;screen display
RS232D	 equ	'R'	;RS232 serial interface

;--------------------------------------------------------------
;	IOCB Command Code equates
;--------------------------------------------------------------
OPEN	 equ	$03	;open
GETREC	 equ	$05	;get record
GETCHR	 equ	$07	;get character(s) (binary)
PUTREC	 equ	$09	;put record
PUTCHR	 equ	$0B	;put character(s)
CLOSE	 equ	$0C	;close
STATUS	 equ	$0D	;status
SPECIL	 equ	$0E	;special

CXIO36	 equ 	36
CXIO38	 equ	38
CXIO40	 equ	40

;--------------------------------------------------------------
;	Character and Key Code equates
;--------------------------------------------------------------
			;SUPERF <>  0
			
CCHM	 equ	$1C	;move cursor home
CCBT	 equ	$1D	;move cursor to bottom
CCLM	 equ	$1E	;move cursor to left margin
CCRM	 equ	$1F	;move cursor to right margin

			;SUPERF  equ 0
BACK	 equ	$08	;backspace
EOL	 equ	$0A	;$9B	;end of line (RETURN)
ESC	 equ	$1B	;escape key
CCUP	 equ	$1C	;cursor up
CCDN	 equ	$1D	;cursor down
CCLF	 equ	$1E	;cursor left
CCRT	 equ	$1F	;cursor right
CSPACE	 equ	$20	;space
CLS	 equ	$7D	;clear screen
TABU	 equ	$7F	;tabulator
CILN	 equ	$9D	;insert line
CDCH	 equ	$FE	;delete character
CICH	 equ	$FF	;insert character

HELP	 equ	$11	;key code for HELP
CNTLF1	 equ	$83	;key code for CTRL-F1
CNTLF2	 equ	$84	;key code for CTRL-F2
CNTLF3	 equ	$93	;key code for CTRL-F3
CNTLF4	 equ	$94	;key code for CTRL-F4
CNTL1	 equ	$9F	;key code for CTRL-1

;--------------------------------------------------------------
;	Status Code equates
;--------------------------------------------------------------
SUCCES	 equ	1	;successful operation

BRKABT	 equ	128	;BREAK key abort
PRVOPN	 equ	129	;IOCB already open error
NONDEV	 equ	130	;nonexistent device error
WRONLY	 equ	131	;IOCB opened for write only error
NVALID	 equ	132	;invalid command error
NOTOPN	 equ	133	;device/file not open error
BADIOC	 equ	134	;invalid IOCB index error
RDONLY	 equ	135	;IOCB opened for read only error
EOFERR	 equ	136	;end of file error
TRNRCD	 equ	137	;truncated record error
TIMOUT	 equ	138	;peripheral device timeout error
DNACK	 equ	139	;device does not acknowledge command error
FRMERR	 equ	140	;serial bus framing error
CRSROR	 equ	141	;cursor overrange error
OVRRUN	 equ	142	;serial bus data overrun error
CHKERR	 equ	143	;serial bus checksum error
DERROR	 equ	144	;device done (operation incomplete) error
BADMOD	 equ	145	;bad screen mode number error
FNCNOT	 equ	146	;function not implemented in handler error
SCRMEM	 equ	147	;insufficient memory for screen mode error

;--------------------------------------------------------------
; Homebrew variables Zero page
;--------------------------------------------------------------
ptr		 equ $00	;2-byte misc. pointer
memptr		 equ $02	;3-byte pointer

PCREG		 equ $02   ;3-byte redefine for disassembler
PCREGH		 equ PCREG+1
PCREGB		 equ PCREGH+1
 
chksum		 equ $05	;1-byte checksum

FATPTRS_	 equ $06	;2-byte FAT source pointer
FATPTRD_	 equ $08	;2-byte FAT destination pointer
PTRDUP		 equ $0A	;2-byte misc. pointer DUP
SECPTR		 equ $0C	;2-byte sector pointer
CHRPTR		 equ $0E	;2-byte sector pointer hi-res char handling
DEVICNO		 equ $10	;1-byte stdout device (0
TEMP		 equ $11	;3-byte pointer for debug16
TEMPH		 equ $12
TEMPB		 equ $13
PREG		 equ $14	;1-byte P STATUS REGISTER
gethex_A	 equ $15	;1-byte save accu


;--------------------------------------------------------------
; ATARI zeropage
;--------------------------------------------------------------
ZIOCB	 equ	$0020	;address of page zero IOCB
IOCBAS	 equ	$0020	;16-byte page zero IOCB
ICHIDZ	 equ	$0020	;1-byte handler ID ($FF 
ICDNOZ	 equ	$0021	;1-byte device number
ICCOMZ	 equ	$0022	;1-byte command code
ICSTAZ	 equ	$0023	;1-byte status of last action
ICBALZ	 equ	$0024	;1-byte buffer address low
ICBAHZ	 equ	$0025	;1-byte buffer address high
ICBABZ	 equ	$0026	;1-byte buffer address bank
ICBLLZ	 equ	$0027	;1-byte buffer length low
ICBLHZ	 equ	$0028	;1-byte buffer length high
ICBLBZ	 equ	$0029	;1-byte buffer length bank
ICAX1Z	 equ	$002A	;1-byte first auxiliary information
ICAX2Z	 equ	$002B	;1-byte second auxiliary information
ICSPRZ	 equ	$002C	;4-byte spares
;ENTVEC	 equ	$002C	;2-byte (not used)
ICIDNO	 equ	$002E	;1-byte IOCB index (IOCB number times IOCBSZ)
CIOCHR	 equ	$002F	;1-byte character for current CIO operation
;ICPTLZ	 equ	$0026	;1-byte low PUT-BYTE routine address-1
;ICPTHZ	 equ	$0027	;1-byte high PUT-BYTE routine address-1
	
BRKKEY	 equ	$0030	;1-byte BREAK key flag (0 
ICCOMT	 equ	$0031	;1-byte CIO command table index
DSTAT	 equ	$0032	;1-byte display status
TMPCHR	 equ	$0033	;1-byte	temporary character
HOLD1	 equ	$0034	;1-byte	temporary
LMARGN	 equ	$0035	;1-byte text column left margin
RMARGN	 equ	$0036	;1-byte text column right margin
ROWCRS	 equ	$0037	;1-byte cursor row
COLCRS	 equ	$0038	;2-byte cursor column
ALTACT	 equ	$003A	;1-byte ALRGR active --display mode
SAVMSC	 equ	$003B	;2-byte saved memory scan counter
OLDROW	 equ	$003D	;1-byte prior row
OLDCOL	 equ	$003E	;2-byte prior column
OLDCHR	 equ	$0040	;1-byte saved character under cursor
OLDADR	 equ	$0041	;3-byte saved cursor memory address

LOGCOL	 equ	$0044	;1-byte logical line cursor column

;DUMMY	 equ	$0044	;2-byte temporary address

;MLTTMP	 equ	$0046	;1-byte temporary
;OPNTMP	 equ	$0046	;1-byte open temporary
TOADR	 equ	$0045	;3-byte destination address

SAVADR	 equ	$0048	;3-byte saved address
FRMADR	 equ	$0048	;3-byte source address

RAMTOP	 equ	$004B	;1-byte RAM size
BUFCNT	 equ	$004C	;1-byte buffer count (logical line size)
BUFSTR	 equ	$004D	;2-byte buffer start pointer
BITMSK	 equ	$004F	;1-byte bit mask for bit map operation
;SHFAMT	 equ	$004F	;1-byte shift amount for pixel justification
ROWAC	 equ	$0050	;2-byte draw working row
COLAC	 equ	$0052	;2-byte draw working column
ENDPT	 equ	$0054	;2-byte end point
DELTAR	 equ	$0056	;1-byte row difference
DELTAC	 equ	$0057	;2-byte column difference
SWPFLG	 equ	$0059	;1-byte split screen swap flag (0 
INSDAT	 equ	$005A	;1-byte temporary
COUNTR	 equ	$005B	;2-byte draw iteration count
ADRESS	 equ	$005D	;3-byte temporary address



XREG	 equ ADRESS+3       ; X REGISTER
XREGH 	 equ XREG+1

YREG  equ XREGH+1         ; Y REGISTER
YREGH  equ YREG+1

AREG  equ YREGH+1         ; ACCUMULATOR
AREGH  equ AREG+1

STACK  equ AREGH+1        ; STACK POINTER
STACKH  equ STACK+1

;--------------------------------------------------------------
; page 2
;--------------------------------------------------------------
TXTROW	 equ	$0200	;1-byte split screen text cursor row
TXTCOL	 equ	$0201	;2-byte split screen text cursor column
TINDEX	 equ	$0203	;1-byte split scree text mode
TXTMSC	 equ	$0204	;2-byte split screen memory scan counter
TXTOLD	 equ	$0206	;6-byte OLDROW, OLDCOL, OLDCHR, OLDADR for text
HOLD3	 equ	$020C	;1-byte temporary
SUBTMP	 equ	$020D	;1-byte temporary
HOLD2	 equ	$020E	;1-byte (not used)
;DMASK	 equ	$020F	;1-byte display (pixel location) mask
;TMPLBT	 equ	$0210	;1-byte (not used)
RASVEC	 equ	$020F	;raster interrupt vector
ESCFLG	 equ	$0211	;1-byte escape flag ($80 
TABMAP	 equ	$0212	;15-byte (120-bit) tab stop bit map
LOGMAP	 equ	$0221	;8-byte (32-bit) logical line bit map
CLSFLG	 equ	$0229	;1-byte clear screen flag
FILFLG	 equ	$022A	;1-byte right fill flag (0 
TMPROW	 equ	$022B	;1-byte temporary row
TMPCOL	 equ	$022C	;2-byte temporary column
SCRFLG	 equ	$022E	;1-byte scroll occurence flag (0 
HOLD4	 equ	$022F	;1-byte temporary
DRETRY	 equ	$0230	;1-byte number of device retries
SHFLOK	 equ	$0231	;1-byte shift/control lock flags
BOTSCR	 equ	$0232	;1-byte screen bottom (24 

DVSTAT	 equ	$0233	;4-byte device status buffer
CRSINH	 equ	$0237	;1-byte cursor inhibit (0 
DUMMY00	 equ	$0238	;1-byte key debounce delay timer
CH1	 equ	$0239	;1-byte prior keyboard character

NEWROW	 equ	$023A	;1-byte draw destination row
NEWCOL	 equ	$023B	;2-byte draw destination column
ROWINC	 equ	$023D	;1-byte draw row increment
COLINC	 equ	$023E	;1-byte	draw column increment

CHAR	 equ	$023F	;1-byte internal character
ATACHR	 equ	$0240	;1-byte ATASCII character or plot point
FILDAT	 equ	$0241	;1-byte right fill data
DSPFLG	 equ	$0242	;1-byte control character display flag (0 
SSFLAG	 equ	$0243	;1-byte start/stop flag (0 

SUPERF	 equ	$0244	;1-byte editor super function flag :
;DERRF	 equ	$0245	;1-byte screen OPEN error flag (0 

skipone	 equ	$0246	;1-byte
extended equ	$0247	;1-byte
ADRCNT	 equ	$0248	;1-byte counter for setaddress

IRQVEC	 equ	$0249	;2-byte
NMIVEC	 equ	$024B	;2-byte
jmpind	 equ	$024D	;1-byte $4C 
jmpptr	 equ	$024E	;2-byte
DBUFLO	 equ	$0250	;2-byte ;2-byte adr of 512-byte buffer for SD CARD read/Write
sdcmd	 equ	$0252	;1-byte SD card command
sdadr	 equ	$0253	;4-byte SD card address
sdchk	 equ	$0257	;1-byte SD card checksum
sdres	 equ	$0258	;1-byte SD card R1 result
sddebug  equ	$0259	;1-byte SD card debug flag
FVEC	 equ	$025A	;2-byte executable file start vector
FINIT	 equ	$025C	;2-byte executable file init vector
JSLOP	 equ	$025E	;1-byte JSL-opcode
JSLADR	 equ	$025F	;3-byte JSL address
JSLRTS	 equ	$0262	;1-byte RTS-opcode
JMLOP	 equ	$0263	;1-byte JML-opcode
JMLADR	 equ	$0264	;3-byte JML address
DEVSTAT	 equ	$0269	;4-byte device status
SERCNT0	 equ 	$026D	;1-byte RS232 0 control bits
SERCNT1	 equ 	$026E	;1-byte RS232 1 control bits
CONST5MS equ	$026F	;2-byte timer const
;FSTART	 equ	$0271	;2-byte file load start vector save
;FEND	 equ	$0273	;2-byte file load end vector save
;FSTARTS	 equ	$0275	;2-byte file load start vector save
;FENDS	 equ	$0277	;2-byte file load end vector save
;FDIFF	 equ	$0279	;2-byte into difference save
MONACT	 equ	$027B	;4-byte break-monitor active flags

IOCBSTRT equ	$0280		;start of IOCB
IOCB	 equ	IOCBSTRT+$0	;128-byte I/O control blocks area
ICHID	 equ	IOCBSTRT+$0	;1-byte handler ID ($FF 
ICDNO	 equ	IOCBSTRT+$1	;1-byte device number
ICCOM	 equ	IOCBSTRT+$2	;1-byte command code
ICSTA	 equ	IOCBSTRT+$3	;1-byte status of last action
ICBAL	 equ	IOCBSTRT+$4	;1-byte low buffer address
ICBAH	 equ	IOCBSTRT+$5	;1-byte high buffer address
ICBAB	 equ	IOCBSTRT+$6	;1-byte bank buffer address
ICBLL	 equ	IOCBSTRT+$7	;1-byte low buffer length
ICBLH	 equ	IOCBSTRT+$8	;1-byte high buffer length
ICBLB	 equ	IOCBSTRT+$9	;1-byte bank buffer length
ICAX1	 equ	IOCBSTRT+$A	;1-byte first auxiliary information
ICAX2	 equ	IOCBSTRT+$B	;1-byte second auxiliary information
ICSPR	 equ	IOCBSTRT+$C	;4-byte work area
;ICPTL	 equ	IOCBSTRT+$6	;1-byte low PUT-BYTE routine address-1
;ICPTH	 equ	IOCBSTRT+$7	;1-byte high PUT-BYTE routine address-1
;--------------------------------------------------------------
; page 3
;--------------------------------------------------------------
HATABS	 equ	$0300	;12 * 3-byte entries for HATABS
;MONTAB	 equ	$0324	;8-byte break-monitor pointer
flags	 equ	$032C	;1-byte processor flags during IRQ
IRQPS2S	 equ	$032D	;1-byte PS2-status from IRQ
IRQPS2D  equ	$032E	;1-byte PS2-data from IRQ
DEVICS	 equ	$032F	;1-byte DEVICENO SAVE
BRKBRA	 equ	$0330	;1-byte branch opcode
BRKOFF	 equ	$0331	;1-byte branch offset (always 3)
BRKNOT	 equ	$0332	;1-byte jmp branch not taken (always $4c)
BRKJMP0	 equ	$0333	;2-byte jmp address branch not taken
BRKTAK	 equ	$0335	;1-byte jmp branch taken (always $4c)
BRKJMP1	 equ	$0336	;2-byte jmp address branch taken
BRKVEC	 equ	$0338	;2-byte BRK vector (65816)
WARMFLAG equ	$033A	;1-byte Warmstart 
ARGC	 equ	$033B	;2-byte number of args
ARGV	 equ	$033D	;8*2-bytes pointer to arg strings
NCODE	 equ 	$034D	;1-byte NEXT CODE TO BE TRACED
OPCREG	 equ	$034E	;3-byte OLD PROGRAM COUNTER VALUE
OPCREGH	 equ	$034F	
OPCREGB	 equ	$0350
CODE	 equ	$0351	;1-byte CURRENT CODE TO BE TRACED
OPRNDL	 equ	$0352	;3-byte OPERANDS OF CURRENT INSTRUCTION
OPRNDH	 equ	$0353 
OPRNDB	 equ	$0354
ADDRMODE equ	$0355	; ADDRESS MODE OF CURRENT OPCODE

MNX	 equ	$0356 	;2-byte MNEMONIC INDEX
                        ; FROM ATTRIBUTE TABLE
OPLEN 	 equ	$0358   ;1-byte LENGTH OF OPERATION,
                        ; INCLUDING INSTRUCTION
MOVENEG	 equ	$0359	;4-byte MVP+operands
MOVEBNK	 equ	$035A
MOVERTS	 equ	$035C	;RTS

MODBASE	 equ	$035D	;2-byte base for next module to be loaded

MONTAB	 equ	$0360	;4*4-byte break-monitor pointer

COLCNT	 equ	$0370	;
COPVEC	 equ	$0371	;2-byte COP vector
NEXTFRE	 equ	$0373	;

FNAME	 equ 	$0380	;128-byte buffer for line
;--------------------------------------------------------------
; page 4
;--------------------------------------------------------------

;--------------------------------------------------------------
; Homebrew MC6845 graphics
;--------------------------------------------------------------
crtadr		 equ $B800
crtdata		 equ $B801

crtcol0		 equ $B880
crtcol1		 equ $B881
crtcol2		 equ $B882
crtcol3		 equ $B883
crtcolb		 equ crtcol3

crtcntl		 equ $B8C0
crtirq		 equ $B8C1

;--------------------------------------------------------------
; Homebrew MOS6551 serial card
;--------------------------------------------------------------
;data6551	 equ $DB00
;status6551	 equ $DB01
;command6551	 equ $DB02
;control6551	 equ $DB03

;--------------------------------------------------------------
; Homebrew YM2612 registers
;--------------------------------------------------------------
YMADR0		 equ $BFB0
YMDAT0		 equ $BFB1
YMADR1		 equ $BFB2
YMDAT1		 equ $BFB3

;--------------------------------------------------------------
; Homebrew	Memory Control 
;--------------------------------------------------------------
MEMCNTL		 equ $BFC0

;--------------------------------------------------------------
; Homebrew PS2-keyboard and SD-Card 
;--------------------------------------------------------------
PS2		 equ IO+$D0
PS2DATA		 equ PS2+0	; keyboard scancode
PS2STATUS	 equ PS2+1	; read: Bit0 
SPIDATA		 equ PS2+2	; read: Bit0 serial data in, write: Bit7 serial data out
SPIMOSI		 equ PS2+3	; write: Bit0: 1 

;--------------------------------------------------------------
; Homebrew Centronics 8-bit latch
;--------------------------------------------------------------
CENTRONICS	 equ $BFE0

;--------------------------------------------------------------
; Homebrew MC68681 double serial card
;--------------------------------------------------------------
SB		 equ $BFF0

MODEA		 equ 0
STATA		 equ 1
CLOCKA		 equ 1
COMMA		 equ 2
RECA		 equ 3
TRANSA		 equ 3
IPCHANGE	 equ 4
AUXCTRL		 equ 4
ISR		 equ 5
IMR		 equ 5
CNTMSB		 equ 6
CNTLSB		 equ 7
MODEB		 equ 8
STATB		 equ 9
CLOCKB		 equ 9
COMMB		 equ 10
RECB		 equ 11
TRANSB		 equ 11
IVR		 equ 12
INPORT		 equ 13
OPCTRL		 equ 13
STRTCNT		 equ 14
OPSET		 equ 14
STOPCNT		 equ 15
OPRES		 equ 15

;--------------------------------------------------------------
; 6502 CPU vectors
;--------------------------------------------------------------
NMI		 equ $FFFA
RESET		 equ $FFFC  
IRQ		 equ $FFFE

;--------------------------------------------------------------
; FPGA misc. stuff
;--------------------------------------------------------------
		
;--------------------------------------------------------------
; RESET, TIMER, HARDWARE MULT.
;--------------------------------------------------------------
SOFTRESET	 equ IO+$80
TIMERLO 	 equ IO+$81
TIMERHI		 equ IO+$82
TIMERST		 equ IO+$83
WORDLO		 equ IO+$84
WORDHI		 equ IO+$85
DOTS		 equ IO+$86

CCONST5MS	 equ 55466
;--------------------------------------------------------------
; SPI SD-card interface
;--------------------------------------------------------------
SPI		 equ IO+$90
SPICNTL		 equ SPI
SPISS		 equ SPI+1
SPIDAT		 equ SPI+2
SPISTAT		 equ SPI+3

;--------------------------------------------------------------
; graphics system
;--------------------------------------------------------------
DISP			 equ $FFFE00
colorBorderLo		 equ DISP+0
colorBorderHi		 equ DISP+1
colorBackgroundLo	 equ DISP+2
colorBackgroundHi	 equ DISP+3
color00Lo		 equ DISP+4
color00Hi		 equ DISP+5
screenBaseLo		 equ DISP+6
screenBaseHi		 equ DISP+7
screenBaseBank		 equ DISP+8
control			 equ DISP+9
cursorLo		 equ DISP+10
cursorHi		 equ DISP+11
rasterLo		 equ DISP+12
rasterHi		 equ DISP+13
dispStatus		 equ DISP+14
vcountLo		 equ DISP+15
vcountHi		 equ DISP+16
;spriteBaseLo		 equ DISP+17
;spriteBaseHi		 equ DISP+18
spriteBaseBank		 equ DISP+19
spriteCntl		 equ DISP+20
sprite0addr		 equ DISP+21
sprite1addr              equ DISP+22
sprite2addr              equ DISP+23
sprite3addr              equ DISP+24
sprite4addr              equ DISP+25
sprite5addr              equ DISP+26
sprite6addr              equ DISP+27
sprite7addr              equ DISP+28
xpos0			 equ DISP+32
xpos1			 equ DISP+33
xpos2			 equ DISP+34
xpos3			 equ DISP+35
xpos4			 equ DISP+36
xpos5			 equ DISP+37
xpos6			 equ DISP+38
xpos7			 equ DISP+39
xposHi			 equ DISP+40

palette 		 equ $FFFC00
spritePalette		 equ $FFFE40
sprite0			 equ $7E0000

;--------------------------------------------------------------
; 16450 ACIA registers
;--------------------------------------------------------------
ACIA0		 equ IO+$E0
RBR0		 equ ACIA0
THR0		 equ ACIA0
IER0		 equ ACIA0+1
IIR0		 equ ACIA0+2
LCR0		 equ ACIA0+3
MCR0		 equ ACIA0+4
LSR0		 equ ACIA0+5
MSR0		 equ ACIA0+6
SCR0		 equ ACIA0+7
DLL0		 equ ACIA0
DLM0		 equ ACIA0+1

SECPTRLO	 equ ACIA0+8
SECPTRHI	 equ ACIA0+9
READWRITE	 equ ACIA0+10
BUFPTRLO	 equ ACIA0+11
BUFPTRHI	 equ ACIA0+12

