FALSE	=	0
TRUE	=	1

;;
;	special key scan-codes
;
;
CLSHIFT		= $12
CRSHIFT		= $59
CCAPS		= $58
CCHARLINE	= 80	;80 chars per line

;VGC	SET	TRUE	;virtual game controllers
;RAMSYS	SET	FALSE	;not RAM based system
;LNBUG	SET	FALSE	;no LNBUG interface
;ACMI	SET	FALSE	;no asynchronous communications mod:
;	SPACE	4,10
;;	Identification =ates


IDREV	=	$02	;identification revision number
IDDAY	=	$10	;identification day
IDMON	=	$05	;identification month
IDYEAR	=	$83	;identification year
IDCPU	=	$02	;identification CPU series
IDPN1	=	'B'	;identification part number field 1
IDPN2	=	'B'	;identification part number field 2
IDPN3	=	$00	;identification part number field 3
IDPN4	=	$00	;identification part number field 4
IDPN5	=	$01	;identification part number field 5
;	SPACE	4,10
;;	Configuration =ates
;
;	NOTES
;		Problem: last byte of HATABS (as defined by:
;		overlaps first power-up validation byte.


MAXDEV	=	33	;offset to last possible entry of HATABS
IOCBSZ	=	16	;length of IOCB

SEIOCB	=	0*IOCBSZ	;screen editor IOCB index
MAXIOC	=	8*IOCBSZ	;first invalid IOCB index

DSCTSZ	=	128	;disk sector size

LEDGE	=	2	;left edge
REDGE	=	39	;right edge

INIML	=	$0700	;initial MEMLO

ICSORG	=	$CC00	;international character set origin
DCSORG	=	$E000	;domestic character set origin
;	SPACE	4,10
;;	IOCB Command Code =ates


OPEN	=	$03	;open
GETREC	=	$05	;get record
GETCHR	=	$07	;get character(s) (binary)
PUTREC	=	$09	;put record
PUTCHR	=	$0B	;put character(s)
CLOSE	=	$0C	;close
STATIS	=	$0D	;status
SPECIL	=	$0E	;special
;	SPACE	4,10
;;	Special Entry Command =ates


;	Screen Commands

DRAWLN	=	$11	;draw line
FILLIN	=	$12	;draw line with right fill
;	SPACE	4,10
;;	ICAX1 Auxiliary Byte 1 =ates


APPEND	=	$01	;open write append (D:) or screen read (E:)
DIRECT	=	$02	;open for directory access (D:)
OPNIN	=	$04	;open for input (all devices)
OPNOT	=	$08	;open for output (all devices)
MXDMOD	=	$10	;open for mixed mode (E:, S:)
INSCLR	=	$20	;open for input without clearing screen (E:, S:)
;	SPACE	4,10
;;	Device Code =ates


CASSET	=	'C'	;cassette
DISK	=	'D'	;disk
SCREDT	=	'E'	;screen editor
KBD	=	'K'	;keyboard
PRINTR	=	'P'	;printer
DISPLY	=	'S'	;screen display
;	SPACE	4,10
;;	Character and Key Code =ates


CLS	=	$7D	;clear screen
BACK	=	$7E
EOL	=	$9B	;end of line (RETURN)
CCUP	=	$1C
CCDN	=	$1D
CCLF	=	$1E
CCRT	=	$1F
CCSC	=	$7D
CDCH	=	$FE
CICH	=	$FF

HELP	=	$11	;key code for HELP
CNTLF1	=	$83	;key code for CTRL-F1
CNTLF2	=	$84	;key code for CTRL-F2
CNTLF3	=	$93	;key code for CTRL-F3
CNTLF4	=	$94	;key code for CTRL-F4
CNTL1	=	$9F	;key code for CTRL-1
;	SPACE	4,10
;;	Status Code =ates


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

;;	DCB Device Bus ID =ates


DISKID	=	$31	;disk bus ID
PDEVN	=	$40	;printer bus ID
CASET	=	$60	;cassette bus ID
;	SPACE	4,10
;;	Bus Command =ates


FOMAT	=	'!'	;format command
PUTSEC	=	'P'	;put sector command
READ	=	'R'	;read command
STATC	=	'S'	;status command
WRITE	=	'W'	;write command
;	SPACE	4,10
;;	Command Auxiliary Byte =ates


DOUBLE	=	'D'	;print 20 characters double width
NORMAL	=	'N'	;print 40 characters normally
PLOT	=	'P'	;plot
SIDWAY	=	'S'	;print 16 characters sideways
;	SPACE	4,10
;;	Bus Response =ates


ACK	=	'A'	;device acknowledged
COMPLT	=	'C'	;device successfully completed operation
ERROR	=	'E'	;device incurred error in attempted operation
NACK	=	'N'	;device did not understand
;	SPACE	4,10
;;	Floating Point Package Miscellaneous =ates


FPREC	=	6	;precision

FMPREC	=	FPREC-1	;length of mantissa
;	SPACE	4,10
;;	Cassette Record Type =ates


HDR	=	$FB	;header
DTA	=	$FC	;data record
DT1	=	$FA	;last data record
EOT	=	$FE	;end of tape (file)

TONE1	=	2	;record
TONE2	=	1	;playback
;	SPACE	4,10
;;	Cassette Timing =ates


WLEADN	=	1152	;NTSC 19.2 second WRITE file leader
RLEADN	=	576	;NTSC 9.6 second READ file leader
WIRGLN	=	180	;NTSC 3.0 second WRITE IRG
RIRGLN	=	120	;NTSC 2.0 second READ IRG
WSIRGN	=	15	;NTSC 0.25 second WRITE short IRG
RSIRGN	=	10	;NTSC 0.16 second READ short IRG
BEEPNN	=	30	;NTSC 0.5 second beep duration
BEEPFN	=	10	;NTSC 0.16 second beep separation

WLEADP	=	960	;PAL 19.2 second WRITE file leader
RLEADP	=	480	;PAL 9.6 second READ file leader
WIRGLP	=	150	;PAL 3.0 second WRITE IRG
RIRGLP	=	100	;PAL 2.0 second READ IRG
WSIRGP	=	13	;PAL 0.25 second WRITE short IRG
RSIRGP	=	8	;PAL 0.16 second READ short IRG
BEEPNP	=	25	;PAL 0.5 second beep duration
BEEPFP	=	8	;PAL 0.16 second beep separation

WIRGHI	=	0	;high WRITE IRG
RIRGHI	=	0	;high READ IRG
;	SPACE	4,10
;;	Power-up Validation Byte Value =ates


PUPVL1	=	$5C	;power-up validation value 1
PUPVL2	=	$93	;power-up validation value 2
PUPVL3	=	$25	;power-up validation value 3
;	SPACE	4,10
;;	Relocating Loader Miscellaneous =ates


DATAER	=	156	;end of record appears before END r:
MEMERR	=	157	;memory insufficient for load error
;	SPACE	4,10
;;	Miscellaneous =ates


IOCFRE	=	$FF	;IOCB free indicator

B19200	=	$0028	;19200 baud POKEY counter value
B00600	=	$05CC	;600 baud POKEY counter value

HITONE	=	$05	;FSK high freq. POKEY counter value (5326 Hz)
LOTONE	=	$07	;FSK low freq. POKEY counter value (3995 Hz)

NCOMLO	=	$34	;PIA lower NOT COMMAND line command
NCOMHI	=	$3C	;PIA raise NOT COMMAND line command

MOTRGO	=	$34	;PIA cassette motor ON command
MOTRST	=	$3C	;PIA cassette motor OFF command

NODAT	=	$00	;SIO immediate operation
GETDAT	=	$40	;SIO read data frame
PUTDAT	=	$80	;SIO write data frame

CRETRI	=	13	;number of command frame retries
DRETRI	=	1	;number of device retries
CTIM	=	2	;command frame ACK timeout

NBUFSZ	=	40	;print normal buffer size
DBUFSZ	=	20	;print double buffer size
SBUFSZ	=	29	;print sideways buffer size
;	SUBTTL	'System Address =ates'
;	SPACE	4,10
;;	Page Zero Address =ates


;LNFLG	=	$0000	;1-byte LNBUG flag (0 = not LNBUG)
;NGFLAG	=	$0001	;1-byte memory status (0 = failure)
;
;;	Not Cleared
;
;CASINI	=	$0002	;2-byte cassette program initialization address
;RAMLO	=	$0004	;2-byte RAM address for memory test
;TRAMSZ	=	$0006	;1-byte RAM size temporary
;CMCMD	=	$0007	;1-byte command communications
;
;;	Cleared upon Coldstart Only
;
;WARMST	=	$0008	;1-byte warmstart flag (0 = coldstart)
;BOOT	=	$0009	;1-byte successful boot flags
;DOSVEC	=	$000A	;2-byte disk program start vector
;DOSINI	=	$000C	;2-byte disk program initialization address
;APPMHI	=	$000E	;2-byte applications memory high limit
;
;;	Cleared upon Coldstart or Warmstart
;
;INTZBS	=	$0010	;first page zero location to clear
;
;;POKMSK	=	$0010	;1-byte IRQEN shadow
BRKKEY	=	$0011	;1-byte BREAK key flag (0 = no BREAK)
;RTCLOK	=	$0012	;3-byte real time clock (16 millisecond units)
;BUFADR	=	$0015	;2-byte disk interface buffer address

ICCOMT	=	$0017	;1-byte CIO command table index
;DSKFMS	=	$0018	;2-byte DOS File Management System pointer
;DSKUTL	=	$001A	;2-byte DOS utility pointer
;ABUFPT	=	$001C	;4-byte ACMI buffer pointer area

ZIOCB	=	$0020	;address of page zero IOCB
IOCBAS	=	$0020	;16-byte page zero IOCB
ICHIDZ	=	$0020	;1-byte handler ID ($FF = IOCB free)
ICDNOZ	=	$0021	;1-byte device number
ICCOMZ	=	$0022	;1-byte command code
ICSTAZ	=	$0023	;1-byte status of last action
ICBALZ	=	$0024	;1-byte low buffer address
ICBAHZ	=	$0025	;1-byte high buffer address
ICPTLZ	=	$0026	;1-byte low PUT-BYTE routine address-1
ICPTHZ	=	$0027	;1-byte high PUT-BYTE routine address-1
ICBLLZ	=	$0028	;1-byte low buffer length
ICBLHZ	=	$0029	;1-byte high buffer length
ICAX1Z	=	$002A	;1-byte first auxiliary information
ICAX2Z	=	$002B	;1-byte second auxiliary information
ICSPRZ	=	$002C	;4-byte spares

ENTVEC	=	$002C	;2-byte (not used)
ICIDNO	=	$002E	;1-byte IOCB index (IOCB number times IOCBSZ)
CIOCHR	=	$002F	;1-byte character for current CIO operation

STATUS	=	$0030	;1-byte SIO operation status
CHKSUM	=	$0031	;1-byte checksum (single byte sum with carry)
BUFRLO	=	$0032	;1-byte low data buffer address
BUFRHI	=	$0033	;1-byte high data buffer address
BFENLO	=	$0034	;1-byte low data buffer end address
BFENHI	=	$0035	;1-byte high data buffer end address
LTEMP	=	$0036	;2-byte relocating loader temporary
BUFRFL	=	$0038	;1-byte data buffer full flag (0 = not full)
RECVDN	=	$0039	;1-byte receive-frame done flag (0 = not done)
XMTDON	=	$003A	;1-byte transmit-frame done flag (0 = not done)
CHKSNT	=	$003B	;1-byte checksum sent flag (0 = not sent)
NOCKSM	=	$003C	;1-byte no checksum follows data flag (0 = does)
BPTR	=	$003D	;1-byte cassette buffer pointer
FTYPE	=	$003E	;1-byte cassette IRG type (neg. = continuous)
FEOF	=	$003F	;1-byte cassette EOF flag (0 = no EOF)
FREQ	=	$0040	;1-byte cassette beep counter
SOUNDR	=	$0041	;1-byte noisy I/O flag (0 = quiet)

CRITIC	=	$0042	;1-byte critical section flag (0 = not critical)

FMSZPG	=	$0043	;7-byte reserved for DOS File Management System

ZCHAIN	=	$004A	;2-byte handler linkage chain point:
DSTAT	=	$004C	;1-byte display status
ATRACT	=	$004D	;1-byte attract-mode timer and flag
DRKMSK	=	$004E	;1-byte attract-mode dark (luminance) mask
COLRSH	=	$004F	;1-byte attract-mode color shift
TMPCHR	=	$0050	;1-byte	temporary character
HOLD1	=	$0051	;1-byte	temporary
LMARGN	=	$0052	;1-byte text column left margin
RMARGN	=	$0053	;1-byte text column right margin
ROWCRS	=	$0054	;1-byte cursor row
COLCRS	=	$0055	;2-byte cursor column
DINDEX	=	$0057	;1-byte display mode
SAVMSC	=	$0058	;2-byte saved memory scan counter
OLDROW	=	$005A	;1-byte prior row
OLDCOL	=	$005B	;2-byte prior column
OLDCHR	=	$005D	;1-byte saved character under cursor
OLDADR	=	$005E	;2-byte saved cursor memory address
FKDEF	=	$0060	;2-byte function key definition tab:
PALNTS	=	$0062	;1-byte PAL/NTSC indicator (0 = NTS:
LOGCOL	=	$0063	;1-byte logical line cursor column
ADRESS	=	$0064	;2-byte temporary address

MLTTMP	=	$0066	;1-byte temporary
OPNTMP	=	$0066	;1-byte open temporary
TOADR	=	$0066	;2-byte destination address

SAVADR	=	$0068	;2-byte saved address
FRMADR	=	$0068	;2-byte source address

RAMTOP	=	$006A	;1-byte RAM size
BUFCNT	=	$006B	;1-byte buffer count (logical line size)
BUFSTR	=	$006C	;2-byte buffer start pointer
BITMSK	=	$006E	;1-byte bit mask for bit map operation
SHFAMT	=	$006F	;1-byte shift amount for pixel justification
ROWAC	=	$0070	;2-byte draw working row
COLAC	=	$0072	;2-byte draw working column
ENDPT	=	$0074	;2-byte end point
DELTAR	=	$0076	;1-byte row difference
DELTAC	=	$0077	;2-byte column difference
KEYDEF	=	$0079	;2-byte key definition table addres:
SWPFLG	=	$007B	;1-byte split screen swap flag (0 = not swapped)
HOLDCH	=	$007C	;1-byte temporary character
INSDAT	=	$007D	;1-byte temporary
COUNTR	=	$007E	;2-byte draw iteration count

;	Reserved for Application and Floating Point Package

;	=	$0080	;128 bytes reserved for application and FPP
;	SPACE	4,10
;;	Floating Point Package Page Zero Address =ates


;FR0	=	$00D4	;6-byte register 0
;FR0M	=	$00D5	;5-byte register 0 mantissa
;QTEMP	=	$00D9	;1-byte temporary
;
;FRE	=	$00DA	;6-byte (internal) register E
;
;FR1	=	$00E0	;6-byte register 1
;FR1M	=	$00E1	;5-byte register 1 mantissa
;
;FR2	=	$00E6	;6-byte (internal) register 2
;
;FRX	=	$00EC	;1-byte temporary
;
;EEXP	=	$00ED	;1-byte value of exponent
;
;FRSIGN	=	$00EE	;1-byte floating point sign
;NSIGN	=	$00EE	;1-byte sign of number
;
;PLYCNT	=	$00EF	;1-byte polynomial degree
;ESIGN	=	$00EF	;1-byte sign of exponent
;
;SGNFLG	=	$00F0	;1-byte sign flag
;FCHFLG	=	$00F0	;1-byte first character flag
;
;XFMFLG	=	$00F1	;1-byte transform flag
;DIGRT	=	$00F1	;1-byte number of digits after decimal point
;
;CIX	=	$00F2	;1-byte current input index
;INBUFF	=	$00F3	;2-byte line input buffer
;
;ZTEMP1	=	$00F5	;2-byte temporary
;ZTEMP4	=	$00F7	;2-byte temporary
;ZTEMP3	=	$00F9	;2-byte temporary
;
;FLPTR	=	$00FC	;2-byte floating point number pointer
;FPTR2	=	$00FE	;2-byte floating point number pointer
;	SPACE	4,10
;;	Page One (Stack) Address =ates


;	=	$0100	;256-byte stack
;	SPACE	4,10
;;	Page Two Address =ates


;INTABS	=	$0200	;42-byte interrupt handler table
;
;VDSLST	=	$0200	;2-byte display list NMI vector
;VPRCED	=	$0202	;2-byte serial I/O proceed line IRQ vector
;VINTER	=	$0204	;2-byte serial I/O interrupt line IRQ vector
;VBREAK	=	$0206	;2-byte BRK instruction IRQ vector
;VKEYBD	=	$0208	;2-byte keyboard IRQ vector
;VSERIN	=	$020A	;2-byte serial input ready IRQ vector
;VSEROR	=	$020C	;2-byte serial output ready IRQ vector
;VSEROC	=	$020E	;2-byte serial output complete IRQ vector
;VTIMR1	=	$0210	;2-byte POKEY timer 1 IRQ vector
;VTIMR2	=	$0212	;2-byte POKEY timer 2 IRQ vector
;VTIMR4	=	$0214	;2-byte POKEY timer 4 IRQ vector
;VIMIRQ	=	$0216	;2-byte immediate IRQ vector
;CDTMV1	=	$0218	;2-byte countdown timer 1 value
;CDTMV2	=	$021A	;2-byte countdown timer 2 value
;CDTMV3	=	$021C	;2-byte countdown timer 3 value
;CDTMV4	=	$021E	;2-byte countdown timer 4 value
;CDTMV5	=	$0220	;2-byte countdown timer 5 value
;VVBLKI	=	$0222	;2-byte immediate VBLANK NMI vector
;VVBLKD	=	$0224	;2-byte deferred VBLANK NMI vector
;CDTMA1	=	$0226	;2-byte countdown timer 1 vector
;CDTMA2	=	$0228	;2-byte countdown timer 2 vector
;
;CDTMF3	=	$022A	;1-byte countdown timer 3 flag (0 = expired)
;SRTIMR	=	$022B	;1-byte software key repeat timer
;CDTMF4	=	$022C	;1-byte countdown timer 4 flag (0 = expired)
;INTEMP	=	$022D	;1-byte temporary
;CDTMF5	=	$022E	;1-byte countdown timer 5 flag (0 = expired)
;SDMCTL	=	$022F	;1-byte DMACTL shadow
;SDLSTL	=	$0230	;1-byte DLISTL shadow
;SDLSTH	=	$0231	;1-byte DLISTH shadow
;SSKCTL	=	$0232	;1-byte SKCTL shadow
;LCOUNT	=	$0233	;1-byte relocating loader record le:
;LPENH	=	$0234	;1-byte light pen horizontal value
;LPENV	=	$0235	;1-byte light pen vertical value
;BRKKY	=	$0236	;2-byte BREAK key vector
;VPIRQ	=	$0238	;2-byte parallel device IRQ vector
;CDEVIC	=	$023A	;1-byte command frame device ID
;CCOMND	=	$023B	;1-byte command frame command
;CAUX1	=	$023C	;1-byte command auxiliary 1
;CAUX2	=	$023D	;1-byte command auxiliary 2

;TEMP	=	$023E	;1-byte temporary

;	ASSERT	low TEMP<>$FF	;may not be the last word on a page

;ERRFLG	=	$023F	;1-byte I/O error flag (0 = no error)

;	ASSERT	low ERRFLG<>$FF ;may not be the last word on a page

;DFLAGS	=	$0240	;1-byte disk flags from sector 1
;DBSECT	=	$0241	;1-byte disk boot sector count
;BOOTAD	=	$0242	;2-byte disk boot memory address
;COLDST	=	$0244	;1-byte coldstart flag (0 = complete)
;RECLEN	=	$0245	;1-byte relocating loader record le:
;DSKTIM	=	$0246	;1-byte disk format timeout
;PDVMSK	=	$0247	;1-byte parallel device selection mask
;SHPDVS	=	$0248	;1-byte PDVS (parallel device selec:
;PDIMSK	=	$0249	;1-byte parallel device IRQ selection mask
;RELADR	=	$024A	;2-byte relocating loader relative :
;PPTMPA	=	$024C	;1-byte parallel device handler tem:
;PPTMPX	=	$024D	;1-byte parallel device handler tem:

;	=	$024E	;6 bytes reserved for Atari

;	=	$0254	;23 bytes reserved for Atari

CHSALT	=	$026B	;1-byte character set alternate
VSFLAG	=	$026C	;1-byte fine vertical scroll count
KEYDIS	=	$026D	;1-byte keyboard disable
FINE	=	$026E	;1-byte fine scrolling mode
;GPRIOR	=	$026F	;1-byte PRIOR shadow

;PADDL0	=	$0270	;1-byte potentiometer 0
;PADDL1	=	$0271	;1-byte potentiometer 1
;PADDL2	=	$0272	;1-byte potentiometer 2
;PADDL3	=	$0273	;1-byte potentiometer 3
;PADDL4	=	$0274	;1-byte potentiometer 4
;PADDL5	=	$0275	;1-byte potentiometer 5
;PADDL6	=	$0276	;1-byte potentiometer 6
;PADDL7	=	$0277	;1-byte potentiometer 7
;
;STICK0	=	$0278	;1-byte joystick 0
;STICK1	=	$0279	;1-byte joystick 1
;STICK2	=	$027A	;1-byte joystick 2
;STICK3	=	$027B	;1-byte joystick 3
;
;PTRIG0	=	$027C	;1-byte paddle trigger 0
;PTRIG1	=	$027D	;1-byte paddle trigger 1
;PTRIG2	=	$027E	;1-byte paddle trigger 2
;PTRIG3	=	$027F	;1-byte paddle trigger 3
;PTRIG4	=	$0280	;1-byte paddle trigger 4
;PTRIG5	=	$0281	;1-byte paddle trigger 5
;PTRIG6	=	$0282	;1-byte paddle trigger 6
;PTRIG7	=	$0283	;1-byte paddle trigger 7
;
;STRIG0	=	$0284	;1-byte joystick trigger 0
;STRIG1	=	$0285	;1-byte joystick trigger 1
;STRIG2	=	$0286	;1-byte joystick trigger 2
;STRIG3	=	$0287	;1-byte joystick trigger 3
;
;HIBYTE	=	$0288	;1-byte relocating loader high byte:
;WMODE	=	$0289	;1-byte cassette WRITE mode ($80 = writing)
;BLIM	=	$028A	;1-byte cassette buffer limit
;IMASK	=	$028B	;1-byte (not used)
;JVECK	=	$028C	;2-byte jump vector or temporary
;NEWADR	=	$028E	;2-byte relocating address
TXTROW	=	$0290	;1-byte split screen text cursor row
TXTCOL	=	$0291	;2-byte split screen text cursor column
TINDEX	=	$0293	;1-byte split scree text mode
TXTMSC	=	$0294	;2-byte split screen memory scan counter
TXTOLD	=	$0296	;6-byte OLDROW, OLDCOL, OLDCHR, OLDADR for text
;CRETRY	=	$029C	;1-byte number of command frame ret:
HOLD3	=	$029D	;1-byte temporary
SUBTMP	=	$029E	;1-byte temporary
HOLD2	=	$029F	;1-byte (not used)
DMASK	=	$02A0	;1-byte display (pixel location) mask
TMPLBT	=	$02A1	;1-byte (not used)
ESCFLG	=	$02A2	;1-byte escape flag ($80 = ESC detected)
TABMAP	=	$02A3	;15-byte (120-bit) tab stop bit map
LOGMAP	=	$02B2	;8-byte (32-bit) logical line bit map
INVFLG	=	$02B6	;1-byte inverse video flag ($80 = inverse)
FILFLG	=	$02B7	;1-byte right fill flag (0 = no fill)
TMPROW	=	$02B8	;1-byte temporary row
TMPCOL	=	$02B9	;2-byte temporary column
SCRFLG	=	$02BB	;1-byte scroll occurence flag (0 = not occurred)
HOLD4	=	$02BC	;1-byte temporary
DRETRY	=	$02BD	;1-byte number of device retries
;SHFLOK	=	$02BE	;1-byte shift/control lock flags
BOTSCR	=	$02BF	;1-byte screen bottom (24 = normal, 4 = split)

;PCOLR0	=	$02C0	;1-byte player-missle 0 color/luminance
;PCOLR1	=	$02C1	;1-byte player-missle 1 color/luminance
;PCOLR2	=	$02C2	;1-byte player-missle 2 color/luminance
;PCOLR3	=	$02C3	;1-byte player-missle 3 color/luminance
;
;COLOR0	=	$02C4	;1-byte playfield 0 color/luminance
;COLOR1	=	$02C5	;1-byte playfield 1 color/luminance
;COLOR2	=	$02C6	;1-byte playfield 2 color/luminance
;COLOR3	=	$02C7	;1-byte playfield 3 color/luminance
;
;COLOR4	=	$02C8	;1-byte background color/luminance
;
;PARMBL	=	$02C9	;6-byte relocating loader parameter:
;RUNADR	=	$02C9	;2-byte run address
;HIUSED	=	$02CB	;2-byte highest non-zero page addre:
;ZHIUSE	=	$02CD	;2-byte highest zero page address
;
;OLDPAR	=	$02CF	;6-byte relocating loader parameter:
;GBYTEA	=	$02CF	;2-byte GET-BYTE routine address
;LOADAD	=	$02D1	;2-byte non-zero page load address
;ZLOADA	=	$02D3	;2-byte zero page load address
;
;DSCTLN	=	$02D5	;2-byte disk sector length
;ACMISR	=	$02D7	;2-byte ACMI interrupt service rout:
;KRPDEL	=	$02D9	;1-byte auto-repeat delay
;KEYREP	=	$02DA	;1-byte auto-repeat rate
;NOCLIK	=	$02DB	;1-byte key click disable
;HELPFG	=	$02DC	;1-byte HELP key flag (0 = no HELP)
;DMASAV	=	$02DD	;1-byte SDMCTL save/restore
;PBPNT	=	$02DE	;1-byte printer buffer pointer
;PBUFSZ	=	$02DF	;1-byte printer buffer size
;
;;	=	$02E0	;4 bytes reserved for DOS
;
;RAMSIZ	=	$02E4	;1-byte high RAM size
;MEMTOP	=	$02E5	;2-byte top of available user memory
;MEMLO	=	$02E7	;2-byte bottom of available user memory
;HNDLOD	=	$02E9	;1-byte user load flag (0 = no hand:
DVSTAT	=	$02EA	;4-byte device status buffer
;CBAUDL	=	$02EE	;1-byte low cassette baud rate
;CBAUDH	=	$02EF	;1-byte high cassette baud rate
CRSINH	=	$02F0	;1-byte cursor inhibit (0 = cursor on)
KEYDEL	=	$02F1	;1-byte key debounce delay timer
CH1	=	$02F2	;1-byte prior keyboard character
;CHACT	=	$02F3	;1-byte CHACTL shadow
;CHBAS	=	$02F4	;1-byte CHBASE shadow

NEWROW	=	$02F5	;1-byte draw destination row
NEWCOL	=	$02F6	;2-byte draw destination column
ROWINC	=	$02F8	;1-byte draw row increment
COLINC	=	$02F9	;1-byte	draw column increment

CHAR	=	$02FA	;1-byte internal character
ATACHR	=	$02FB	;1-byte ATASCII character or plot point
;CH	=	$02FC	;1-byte keyboard code (buffer)
FILDAT	=	$02FD	;1-byte right fill data
DSPFLG	=	$02FE	;1-byte control character display flag (0 = no)
SSFLAG	=	$02FF	;1-byte start/stop flag (0 = not stopped)
;	SPACE	4,10
;;	Page Three Address =ates


;DCB	=	$0300	;12-byte device control block
;DDEVIC	=	$0300	;1-byte unit 1 bus ID
;DUNIT	=	$0301	;1-byte unit number
;DCOMND	=	$0302	;1-byte bus command
;DSTATS	=	$0303	;1-byte command type/status return
;DBUFLO	=	$0304	;1-byte low data buffer address
;DBUFHI	=	$0305	;1-byte high data buffer address
;DTIMLO	=	$0306	;1-byte timeout (seconds)
;DUNUSE	=	$0307	;1-byte (not used)
;DBYTLO	=	$0308	;1-byte low number of bytes to transfer
;DBYTHI	=	$0309	;1-byte high number of bytes to transfer
;DAUX1	=	$030A	;1-byte first command auxiliary
;DAUX2	=	$030B	;1-byte second command auxiliary
;
;TIMER1	=	$030C	;2-byte initial baud rate timer value
;JMPERS	=	$030E	;1-byte jumper options
;CASFLG	=	$030F	;1-byte cassette I/O flag (0 = not cassette I/O)
;TIMER2	=	$0310	;2-byte final baud rate timer value
;TEMP1	=	$0312	;2-byte temporary
;TEMP2	=	$0313	;1-byte temporary
;PTIMOT	=	$0314	;1-byte printer timeout
;TEMP3	=	$0315	;1-byte temporary
;SAVIO	=	$0316	;1-byte saved serial data input indicator
;TIMFLG	=	$0317	;1-byte timeout flag (0 = timeout)
;STACKP	=	$0318	;1-byte SIO saved stack pointer
;TSTAT	=	$0319	;1-byte temporary status

;HATABS	=	$031A	;35-byte handler address table

PUPBT1	=	$033D	;1-byte power-up validation byte 1
PUPBT2	=	$033E	;1-byte power-up validation byte 2
PUPBT3	=	$033F	;1-byte power-up validation byte 3

IOCB	=	$0340	;128-byte I/O control blocks area
ICHID	=	$0340	;1-byte handler ID ($FF = free)
ICDNO	=	$0341	;1-byte device number
ICCOM	=	$0342	;1-byte command code
ICSTA	=	$0343	;1-byte status of last action
ICBAL	=	$0344	;1-byte low buffer address
ICBAH	=	$0345	;1-byte high buffer address
ICPTL	=	$0346	;1-byte low PUT-BYTE routine address-1
ICPTH	=	$0347	;1-byte high PUT-BYTE routine address-1
ICBLL	=	$0348	;1-byte low buffer length
ICBLH	=	$0349	;1-byte high buffer length
ICAX1	=	$034A	;1-byte first auxiliary information
ICAX2	=	$034B	;1-byte second auxiliary information
ICSPR	=	$034C	;4-byte work area

;PRNBUF	=	$03C0	;40-byte printer buffer
SUPERF	=	$03E8	;1-byte editor super function flag :
;CKEY	=	$03E9	;1-byte cassette boot r=est flag :
;CASSBT	=	$03EA	;1-byte cassette boot flag (0 = not:
;CARTCK	=	$03EB	;1-byte cartridge =ivalence checksum
DERRF	=	$03EC	;1-byte screen OPEN error flag (0 = not)

;	Remainder of Page Three Not Cleared upon Reset

;ACMVAR	=	$03ED	;11 bytes reserved for ACMI
;BASICF	=	$03F8	;1-byte BASIC switch flag (0 = BASIC enabled)
;MINTLK	=	$03F9	;1-byte ACMI module interlock
;GINTLK	=	$03FA	;1-byte cartridge interlock
;CHLINK	=	$03FB	;2-byte loaded handler chain link
;CASBUF	=	$03FD	;3-byte first 3 bytes of cassette buffer

skipone	=	$0400
shift	=	$0401
extended=	$0402
keyavail=	$0403

;	SPACE	4,10
;;	Page Four Address =ates


;	=	$0400	;128-byte remainder of cassette buffer

;	Reserved for Application

USAREA	=	$0480	;128 bytes reserved for application
;	SPACE	4,10
;;	Page Five Address =ates


;	Reserved for Application and Floating Point Package

;	=	$0500	;256 bytes reserved for application and FPP
;	SPACE	4,10
;;	Floating Point Package Address =ates


LBPR1	=	$057E	;1-byte LBUFF preamble
LBPR2	=	$057F	;1-byte LBUFF preamble
LBUFF	=	$0580	;128-byte line buffer

PLYARG	=	$05E0	;6-byte floating point polynomial argument
FPSCR	=	$05E6	;6-byte floating point temporary
FPSCR1	=	$05EC	;6-byte floating point temporary
;	SPACE	4,10
;;	Page Six Address =ates


;	Reserved for Application

;	=	$0600	;256 bytes reserved for application
;	SPACE	4,10
;;	LNBUG Address =ates


;	SPACE	4,10
;;	PBI Address =ates


PBI	=	$D100	;parallel bus interface area

;	Read Addresses

PDVI	=	$D1FF	;parallel device IRQ status

;	Write Addresses

PDVS	=	$D1FF	;parallel device select
;	SPACE	4,10
;;	POKEY Address =ates



;
;	SPACE	4,10
;;	PBI RAM Address =ates


PBIRAM	=	$D600	;parallel bus interface RAM area
;	SPACE	4,10
;;	ACMI Address =ates


;ACMI	IF	ACMI
;ACMI	ENDIF
;	SPACE	4,10
;;	Floating Point Package Address =ates


AFP	=	$D800	;convert ASCII to floating point
FASC	=	$D8E6	;convert floating point to ASCII
IFP	=	$D9AA	;convert integer to floating point
FPI	=	$D9D2	;convert floating point to integer
ZFR0	=	$DA44	;zero FR0
ZF1	=	$DA46	;zero floating point number
FSUB	=	$DA60	;subtract floating point numbers
FADD	=	$DA66	;add floating point numbers
FMUL	=	$DADB	;multiply floating point numbers
FDIV	=	$DB28	;divide floating point numbers
PLYEVL	=	$DD40	;evaluate floating point polynomial
FLD0R	=	$DD89	;load floating point number
FLD0P	=	$DD8D	;load floating point number
FLD1R	=	$DD98	;load floating point number
FLD1P	=	$DD9C	;load floating point number
FST0R	=	$DDA7	;store floating point number
FST0P	=	$DDAB	;store floating point number
FMOVE	=	$DDB6	;move floating point number
LOG	=	$DECD	;calculate floating point logarithm
LOG10	=	$DED1	;calculate floating point base 10 logarithm
EXP	=	$DDC0	;calculate floating point exponentiation
EXP10	=	$DDCC	;calculate floating point base 10 exponentiation
;	SPACE	4,10
;;	Parallel Device Address =ates


PDID1	=	$D803	;parallel device ID 1
PDIOV	=	$D805	;parallel device I/O vector
PDIRQV	=	$D808	;parallel device IRQ vector
PDID2	=	$D80B	;parallel device ID 2
PDVV	=	$D80D	;parallel device vector table
;	SPACE	4,10
;;	Device Handler Vector Table Address =ates


;EDITRV	=	$E400	;editor handler vector table
;SCRENV	=	$E410	;screen handler vector table
;KEYBDV	=	$E420	;keyboard handler vector table
;PRINTV	=	$E430	;printer handler vector table
;CASETV	=	$E440	;cassette handler vector table
;	SPACE	4,10
;;	Jump Vector Address =ates


DINITV	=	$E450	;vector to initialize DIO
DSKINV	=	$E453	;vector to DIO
CIOV	=	$E456	;vector to CIO
SIOV	=	$E459	;vector to SIO
SETVBV	=	$E45C	;vector to set VBLANK parameters
SYSVBV	=	$E45F	;vector to process immediate VBLANK NMI
XITVBV	=	$E462	;vector to process deferred VBLANK NMI
SIOINV	=	$E465	;vector to initialize SIO
SENDEV	=	$E468	;vector to enable SEND
INTINV	=	$E46B	;vector to initialize interrupt handler
CIOINV	=	$E46E	;vector to initialize CIO
BLKBDV	=	$E471	;vector to power-up display (formerly memo pad)
WARMSV	=	$E474	;vector to warmstart
COLDSV	=	$E477	;vector to coldstart
RBLOKV	=	$E47A	;vector to read cassette block
CSOPIV	=	$E47D	;vector to open cassette for input
PUPDIV	=	$E480	;vector to power-up display
SLFTSV	=	$E483	;vector to self-test
PHENTV	=	$E486	;vector to enter peripheral handler
PHUNLV	=	$E489	;vector to unlink peripheral handler
PHINIV	=	$E48C	;vector to initialize peripheral handler
;	SPACE	4,10
;;	Generic Parallel Device Handler Vector Table Address =ates


GPDVV	=	$E48F	;generic parallel device handler vector table
;	SUBTTL	'Miscellaneous Address =ates'
;	SPACE	4,10
;;	Self-test Page Zero Address =ates


STTIME	=	$0080	;2-byte main screen timeout timer
STAUT	=	$0082	;1-byte auto-mode flag
STJMP	=	$0083	;3-byte ANTIC jump instruction
STSEL	=	$0086	;1-byte selection
STPASS	=	$0087	;1-byte pass
STSPP	=	$0088	;1-byte SELECT previously pressed flag
;	=	$0089	;1-byte (not used)
STKST	=	$008A	;1-byte keyboard self-test flag (0 = not)
STCHK	=	$008B	;2-byte checksum
STSMM	=	$008D	;1-byte screen memory mask
STSMP	=	$008E	;1-byte screen memory pointer
ST1K	=	$008F	;1-byte current 1K of memory to test
STPAG	=	$0090	;2-byte current page to test
STPC	=	$0092	;1-byte page count
STMVAL	=	$0093	;1-byte correct value for memory test
STSKP	=	$0094	;1-byte simulated keypress index
STTMP1	=	$0095	;2-byte temporary
STVOC	=	$0097	;1-byte current voice indicator
STNOT	=	$0098	;1-byte current note counter
STCDI	=	$0099	;1-byte cleft display pointer
STCDA	=	$009A	;1-byte cleft data pointer
STTMP2	=	$009B	;2-byte temporary
STTMP3	=	$009D	;1-byte temporary
STADR1	=	$009E	;2-byte temporary address
STADR2	=	$00A0	;2-byte temporary address
STBL	=	$00A2	;1-byte blink counter
STTMP4	=	$00A3	;1-byte temporary
STLM	=	$00A4	;1-byte LED mask
STTMP5	=	$00A5	;1-byte temporary
;	SPACE	4,10
;;	Self-test Address =ates


ST3000	=	$3000	;screen memory
ST3002	=	$3002	;cleft display
ST3004	=	$3004	;"VOICE #" text display
ST300B	=	$300B	;voice number display
ST301C	=	$301C	;START key display
ST301E	=	$301E	;SELECT key display
ST3020	=	$3020	;OPTION key display, first 8K ROM display
ST3021	=	$3021	;keyboard character display
ST3022	=	$3022	;keyboard text display
ST3024	=	$3024	;second 8K ROM display
ST3028	=	$3028	;"RAM" text display
ST3038	=	$3038	;RAM display
ST303C	=	$303C	;fifth note display
ST304C	=	$304C	;"B S" text display
ST3052	=	$3052	;tab key display
ST3062	=	$3062	;cleft display
ST306D	=	$306D	;return key display
ST3072	=	$3072	;control key display
ST3092	=	$3092	;"SH" text display
ST309E	=	$309E	;sixth note display
ST30AB	=	$30AB	;"SH" text display
ST30B7	=	$30B7	;"S P A C E   B A R" text display
ST30C1	=	$30C1	;cleft display
ST30C2	=	$30C2	;cleft display
ST30C7	=	$30C7	;third note display
ST30CA	=	$30CA	;fourth note display
ST30F8	=	$30F8	;third note display
ST3100	=	$3100	;screen memory
ST3121	=	$3121	;cleft display
ST3122	=	$3122	;cleft display
ST313C	=	$313C	;fifth note display
ST3150	=	$3150	;first line of staff display
ST3154	=	$3154	;first note display
ST3181	=	$3181	;cleft display
ST3182	=	$3182	;cleft display
ST3186	=	$3186	;second note display
ST318C	=	$318C	;fifth note display
ST31B0	=	$31B0	;second line of staff display
ST31C2	=	$31C2	;cleft display
ST31CA	=	$31CA	;fourth note display
ST31EE	=	$31EE	;sixth note display
ST31F1	=	$31F1	;cleft display
ST3210	=	$3210	;third line of staff display
ST321A	=	$321A	;fourth note display
ST3248	=	$3248	;third note display
ST3270	=	$3270	;fourth line of staff display
ST32D0	=	$32D0	;fifth line of staff display