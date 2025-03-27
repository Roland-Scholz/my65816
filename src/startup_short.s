;STACK	EQU	$01FF			;CHANGE THIS FOR YOUR SYSTEM
;FNAME	EQU 	$0380
;EOL	EQU	$0A
;ARGC	EQU	$033b			;2-byte number of args
;ARGV	EQU	$033d			;8*2-bytes pointer to arg strings

	module	startup
	
;	include hombrewWDC.inc

	code
	xdef	__startup
	func
	
	XREF	~~main

__startup:	
	php				;save processor flags (M/X)
	phb				;save data bank
	phd				;save direct
	
	phk				;save program bank
	plb				;get data bank = program-bank 
	
	REP 	#$30			;16 bit registers
	LONGI	ON
	LONGA	ON
	
	pea	#0
	pea	#0
	pea	#0
	jsl	~~main			;long jump in case not bank 0
		
ENDE:
	pld
	plb
	plp
	rtl

	ends
	efunc
	endmod
	
	data
