	module	startup_task
	
	code
	xdef	~~startup_task
	func
	
	XREF	~~task
	
~~startup_task:	
	phk				;save program bank
	plb				;get data bank = program-bank 	
	jmp	~~task			;long jump in case not bank 0
		
	ends
	efunc
	endmod
	
	data
