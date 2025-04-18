		$NOMOD51
		$INCLUDE (89S52.MCU)
		$INCLUDE (PAULMON.INC)

WRITEREG	EQU	P3.2
REGA		EQU	P3.3
REGB		EQU	P3.4
WRITERAM	EQU	P3.5
	
dpl		EQU	dp0l
dph		EQU	dp0h
	
LOCAT		EQU	08000h
		
;		ORG	8000h

		ORG    LOCAT
		DB     0A5H,0E5H,0E0H,0A5H     ;SIGNITURE BYTES
		DB     35,0,0,0                ;ID (35=PROG), id (253=startup)
		DB     0,0,0,0                 ;PROMPT CODE VECTOR
		DB     0,0,0,0                 ;RESERVED
		DB     0,0,0,0                 ;RESERVED
		DB     0,0,0,0                 ;RESERVED
		DB     0,0,0,0                 ;USER DEFINED
		DB     255,255,255,255         ;LENGTH AND CHECKSUM (255=UNUSED)
		DB     "Eprom Simulator 8k",0  ;MAX 31 CHARACTERS, PLUS THE ZERO

		ORG    LOCAT+64                ;EXECUTABLE CODE BEGINS HERE
		
		ACALL	INITPORTS
		
MENU:		MOV	DPTR,#MSGMENU
		CALL	PSTR
MENULOOP:	CALL	CIN
MENUD:		CJNE	A,#"d",MENUX
		ACALL	WRITEHEX
		AJMP	MENU	
MENUX:		CJNE	A,#"x",MENULOOP
		RET
		
INITPORTS:	MOV	P3,#255
		ACALL	ESIMENABLE
		
		CLR	A
		ACALL	WRITEADRLO
		ACALL	WRITEADRHI
		ACALL	WRITEDATA
		ACALL	WRITE
		ACALL	ESIMDISABLE		
		RET

WRITEADRHI:	CLR	REGA
		CLR	REGB
		AJMP	REGSTROBE		

WRITEADRLO:	SETB	REGA
		CLR	REGB
		AJMP	REGSTROBE		

WRITEDATA:	CLR	REGA
		SETB	REGB
		AJMP	REGSTROBE

WRITE:		CLR	WRITERAM
		NOP
		NOP
		SETB	WRITERAM		
		RET
		
ESIMDISABLE:	CLR	A
		AJMP	ESIMENABLE1

ESIMENABLE:	MOV	A,#1
ESIMENABLE1:	SETB	REGA
		SETB	REGB

REGSTROBE:	MOV	P1,A
		CLR	WRITEREG
		NOP
		NOP
		SETB	WRITEREG
		RET

WRITEHEX:	ACALL	ESIMENABLE
		ACALL	dnld
		AJMP	ESIMDISABLE
		
dnld:	
		mov	dptr, #dnlds1		 
		call	pcstr_h		   ;"begin sending file <ESC> to abort"
		acall	dnld_init

	  ;look for begining of line marker ':'
dnld1:		call	cin
		cjne	a, #27, dnld2	;Test for escape
		ajmp	dnld_esc

dnld2:		cjne	a, #':', dnld2b
		sjmp	dnld2d
dnld2b:	  ;check to see if it's a hex digit, error if it is
		call	asc2hex
		jc	dnld1
		mov	r1, #6
		acall	dnld_inc
		sjmp	dnld1

dnld_now: ;entry point for main menu detecting ":" character
		mov	a, #'^'
		call	cout
		acall	dnld_init

dnld2d:		mov	r1, #0
		acall	dnld_inc

	  ;begin taking in the line of data
dnld3:		mov	a, #'.'
		call	cout
		mov	r4, #0		;r4 will count up checksum
		acall	dnld_ghex
		mov	r0, a		;R0 = # of data bytes
;	mov	a, #'.'
;	acall	cout
		acall	dnld_ghex
dnld3_b:	mov	dp0h, a		;High byte of load address
		acall	dnld_ghex
		mov	dp0l, a		;Low byte of load address
		acall	dnld_ghex	;Record type
		cjne	a, #1, dnld4	;End record?
		sjmp	dnld_end
dnld4:		jnz	dnld_unknown	;is it a unknown record type???
dnld5:		mov	a, r0
		jz	dnld_get_cksum
		acall	dnld_ghex	;Get data byte
		mov	r2, a
		mov	r1, #1
		acall	dnld_inc	;count total data bytes received
		mov	a, r2

		;lcall	smart_wr	;c=1 if an error writing
		ACALL	WRITEDATA
		MOV	A, dp0l	
		ACALL	WRITEADRLO
		MOV	A, dp0h
		ACALL	WRITEADRHI
		ACALL	WRITE

		clr	a
		addc	a, #2
		mov	r1, a
;     2 = bytes written
;     3 = bytes unable to write
		acall	dnld_inc
		inc	dptr
		djnz	r0, dnld5
dnld_get_cksum:
		acall	dnld_ghex	;get checksum
		mov	a, r4
		jz	dnld1		;should always add to zero
dnld_sumerr:
		CALL	PHEX
		mov	r1, #4
		acall	dnld_inc	;all we can do it count # of cksum errors
		sjmp	dnld1

dnld_unknown:	;handle unknown line type
		mov	a, r0
		jz	dnld_get_cksum	;skip data if size is zero
dnld_ukn2:
		acall	dnld_ghex	;consume all of unknown data
		djnz	r0, dnld_ukn2
		sjmp	dnld_get_cksum

dnld_end:   ;handles the proper end-of-download marker
		mov	a, r0
		jz	dnld_end_3	;should usually be zero
dnld_end_2:
		acall	dnld_ghex	;consume all of useless data
		djnz	r0, dnld_ukn2
dnld_end_3:
		acall	dnld_ghex	;get the last checksum
		mov	a, r4
		jnz	dnld_sumerr
		acall	dnld_dly
		mov	dptr, #dnlds3
		call	pcstr_h		   ;"download went ok..."
	;consume any cr or lf character that may have been
	;on the end of the last line
		jb	ri, dnld_end_4
		ajmp	dnld_sum
dnld_end_4:
		call	cin
		sjmp	dnld_sum



dnld_esc:   ;handle esc received in the download stream
		acall	dnld_dly
		mov	dptr, #dnlds2	 
		call	pcstr_h		   ;"download aborted."
		sjmp	dnld_sum

dnld_dly:   ;a short delay since most terminal emulation programs
	    ;won't be ready to receive anything immediately after
	    ;they've transmitted a file... even on a fast Pentium(tm)
	    ;machine with 16550 uarts!
		mov	R0,#0
dnlddly2:	mov	R1,#0
		djnz	r1, $		;roughly 128k cycles, appox 0.1 sec
		djnz	r0, dnlddly2
		ret

dnld_inc:     ;increment parameter specified by R1
	      ;note, values in Acc and R1 are destroyed
		mov	a, r1
		anl	a, #00000111b	;just in case
		rl	a
		add	a, #dnld_parm
		mov	r1, a		;now r1 points to lsb
		inc	@r1
		mov	a, @r1
		jnz	dnldin2
		inc	r1
		inc	@r1
dnldin2:	ret

dnld_gp:     ;get parameter, and inc to next one (@r1)
	     ;carry clear if parameter is zero.
	     ;16 bit value returned in dptr
		setb	c
		mov	dp0l, @r1
		inc	r1
		mov	dp0h, @r1
		inc	r1
		mov	a, dp0l
		jnz	dnldgp2
		mov	a, dph
		jnz	dnldgp2
		clr	c
dnldgp2:	ret

;a spacial version of ghex just for the download.  Does not
;look for carriage return or backspace.	 Handles ESC key by
;poping the return address (I know, nasty, but it saves many
;bytes of code in this 4k ROM) and then jumps to the esc
;key handling.	This ghex doesn't echo characters, and if it
;sees ':', it pops the return and jumps to an error handler
;for ':' in the middle of a line.  Non-hex digits also jump
;to error handlers, depending on which digit.
	  
dnld_ghex:
dnldgh1:	call	cin
		call	upper
		cjne	a, #27, dnldgh3
dnldgh2:	pop	acc
		pop	acc
		sjmp	dnld_esc
dnldgh3:	cjne	a, #':', dnldgh5
dnldgh4:	mov	r1, #5		;handle unexpected beginning of line
		acall	dnld_inc
		pop	acc
		pop	acc
		ajmp	dnld3		;and now we're on a new line!
dnldgh5:	call	asc2hex
		jnc	dnldgh6
		mov	r1, #7
		acall	dnld_inc
		sjmp	dnldgh1
dnldgh6:	mov	r2, a		;keep first digit in r2
dnldgh7:	call	cin
		call	upper
		cjne	a, #27, dnldgh8
		sjmp	dnldgh2
dnldgh8:	cjne	a, #':', dnldgh9
		sjmp	dnldgh4
dnldgh9:	call	asc2hex
		jnc	dnldghA
		mov	r1, #7
		acall	dnld_inc
		sjmp	dnldgh7
dnldghA:	xch	a, r2
		swap	a
		orl	a, r2
		mov	r2, a
		add	a, r4		;add into checksum
		mov	r4, a
		mov	a, r2		;return value in acc
		ret

;dnlds4 =  "Summary:"
;dnlds5 =  " lines received"
;dnlds6a = " bytes received"
;dnlds6b = " bytes written"

dnld_sum:    ;print out download summary
		mov	a, r6
		push	acc
		mov	a, r7
		push	acc
		mov	dptr, #dnlds4
		call	pcstr_h
		mov	r1, #dnld_parm
		mov	r6, #LOW dnlds5
		mov	r7, #HIGH dnlds5
		acall	dnld_i0
		mov	r6, #LOW dnlds6a
		mov	r7, #HIGH dnlds6a
		acall	dnld_i0
		mov	r6, #LOW dnlds6b
		mov	r7, #HIGH dnlds6b
		acall	dnld_i0

dnld_err:    ;now print out error summary
		mov	r2, #5
dnlder2:	acall	dnld_gp
		jc	dnlder3		;any errors?
		djnz	r2, dnlder2
	 ;no errors, so we print the nice message
		mov	dptr, #dnlds13
		call	pcstr_h
		sjmp	dlnd_sum_done

dnlder3:  ;there were errors, so now we print 'em
		mov	dptr, #dnlds7
		call	pcstr_h
	  ;but let's not be nasty... only print if necessary
		mov	r1, #(dnld_parm+6)
		mov	r6, #LOW dnlds8
		mov	r7, #HIGH dnlds8
		acall	dnld_item
		mov	r6, #LOW dnlds9
		mov	r7, #HIGH dnlds9
		acall	dnld_item
		mov	r6, #LOW dnlds10
		mov	r7, #HIGH dnlds10
		acall	dnld_item
		mov	r6, #LOW dnlds11
		mov	r7, #HIGH dnlds11
		acall	dnld_item
		mov	r6, #LOW dnlds12
		mov	r7, #HIGH dnlds12
		acall	dnld_item
dlnd_sum_done:
		pop	acc
		mov	r7, a
		pop	acc
		mov	r6, a
		jmp	newline

dnld_item:
		acall	dnld_gp		;error conditions
		jnc	dnld_i3
dnld_i2:call	space
		lcall	pint16u
		acall	r6r7todptr
		call	pcstr_h
dnld_i3:	ret

dnld_i0:	acall	dnld_gp		;non-error conditions
		sjmp	dnld_i2


dnld_init:
	;init all dnld parms to zero.
		mov	r0, #dnld_parm
dnld0:		mov	@r0, #0
		inc	r0
		cjne	r0, #dnld_parm + 16, dnld0
		ret

space:		mov	a, #' '
		JMP	COUT
	
r6r7todptr:
		mov	dpl, r6
		mov	dph, r7
		ret
		

TIME35MS:	MOV	R6,#0
TIME35MS2:	MOV	R7,#0
TIME35MS1:	DJNZ	R7,TIME35MS1
		DJNZ	R6,TIME35MS1
		RET

TIME5MS:	MOV	R6,#18
		AJMP	TIME35MS2

MSGMENU:	DB	13,10,"ESIM 8k - Menu",13,10
		DB	"D - Download Intel-Hex to RAM",13,10
		DB	"X - Exit"		
		DB	13, 10, 0

dnlds1: 	db	13,13,31,159," ascii",249,150,31,152,132,137
		db	",",149,140,128,160,13,14
dnlds2: 	db	13,31,138,160,"ed",13,14
dnlds3: 	DB	13,31,138,193,"d",13,14
dnlds4: 	DB	"Summary:",14
dnlds5: 	DB	" ",198,"s",145,"d",14
dnlds6a:	DB	" ",139,145,"d",14
dnlds6b:	DB	" ",139," written",14
dnlds7: 	DB	31,155,":",14
dnlds8: 	DB	" ",139," unable",128," write",14
dnlds9: 	DB	32,32,"bad",245,"s",14
dnlds10:	DB	" ",133,159,150,198,14
dnlds11:	DB	" ",133,132,157,14
dnlds12:	DB	" ",133," non",132,157,14
dnlds13:	DB	31,151,155," detected",13,14

TEMP		EQU	127
dnld_parm	EQU	236

		END