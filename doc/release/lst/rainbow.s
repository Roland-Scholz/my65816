;:ts=8
R0	equ	1
R1	equ	5
R2	equ	9
R3	equ	13
;/*
;<!-- präsentiert von kostenlose-javascripts.de -->
;<script type='text/javascript'>
;<!--
;var nachricht = "Mein bunter bunter Regenbogentext"; // Dein Text
;var groesse   = 30; // Größe des Textes
;var geschwindigkeit = 50; // Geschwindigkeit der Farbveränderung in Millisekunden
;
;// an hier nichts mehr ändern
;document.write('<span id="regenbogentext" style="font-size: ' + groesse + 'px;">' + nachricht + '</span>');
;var meinelement = document.getElementById("regenbogentext");
;
;
;var hex = new Array("00","14","28","3C","50","64","78","8C","A0","B4","C8","DC","F0");
;var r = 1;
;var g = 1;
;var b = 1;
;var seq = 1;
;function textaendern(){
;	farbe = "#" + hex[r] + hex[g] + hex[b];
;	meinelement.style.color = farbe;
;}
;function aendern(){
;	switch (seq) {
;		case 6: b--; if ( b == 0 ) seq = 1; break;
;		case 5: r++; if ( r == 12 ) seq = 6; break;
;		case 4: g--; if ( g == 0 ) seq = 5; break;
;		case 3: b++; if ( b == 12 ) seq = 4; break;
;		case 2: r--; if ( r == 0 ) seq = 3; break;
;		case 1: g++; if ( g == 12 ) seq = 2; break;
;	}
;	textaendern();
;}
;function initregenbogen(){
;	setInterval("aendern()", geschwindigkeit);
;}
;//-->
;</script>
;<br />
;JavaScript von <a href="http://www.kostenlose-javascripts.de/javascripts/texteffekte/regenbogentext/" target="_blank">kostenlose-javascripts.de</a>
;<br />
;<script type="text/javascript">initregenbogen();</script>
;<!-- präsentiert von kostenlose-javascripts.de -->
;*/
;
;#include <stdio.h>
;#include <stdlib.h>
;#include <string.h>
;#include <stdbool.h>
;#include "FreeRTOS.h"
;#include "task.h"
;#include <homebrew.h>
;
;int main(int argc, char**argv) {
	code
	xdef	~~main
	func
~~main:
	longa	on
	longi	on
	tsc
	sec
	sbc	#L2
	tcs
	phd
	tcd
argc_0	set	4
argv_0	set	6
;	unsigned int r,g,b,color,seq;
;		
;	r = g = b = seq = 0;
r_1	set	0
g_1	set	2
b_1	set	4
color_1	set	6
seq_1	set	8
	stz	<L3+seq_1
	stz	<L3+b_1
	stz	<L3+g_1
	stz	<L3+r_1
;
;	for(;;) {	
L10003:
;		//getchar();
;		vTaskDelay(25);
	pea	#<$19
	jsl	~~vTaskDelay
;		switch(seq) {
	lda	<L3+seq_1
	xref	~~~fsw
	jsl	~~~fsw
	dw	0
	dw	6
	dw	L10005-1
	dw	L10006-1
	dw	L10008-1
	dw	L10010-1
	dw	L10012-1
	dw	L10014-1
	dw	L10016-1
;			case 0:
L10006:
;				r++;
	inc	<L3+r_1
;				if (r == 7) seq = 1;
	lda	<L3+r_1
	cmp	#<$7
	bne	L10005
	lda	#$1
L20000:
	sta	<L3+seq_1
;				break;
L10005:
;		color = (b << 6) | (g << 3) | r;
	lda	<L3+b_1
	ldx	#<$6
	xref	~~~asl
	jsl	~~~asl
	sta	<R0
	lda	<L3+g_1
	asl	A
	asl	A
	asl	A
	ora	<R0
	sta	<R2
	lda	<L3+r_1
	ora	<R2
	sta	<L3+color_1
;		//printf("r:%d, g:%d, b:%d, color:%d\n", r, g, b, color);
;		COLORBORDERLO = COLORBACKGROUNDLO = color;
	sep	#$20
	longa	off
	sta	>16776706
	sta	>16776704
	rep	#$20
	longa	on
;		COLORBORDERHI = COLORBACKGROUNDHI = color >> 8;
	lda	<L3+color_1
	xba
	and	#$00ff
	sep	#$20
	longa	off
	sta	>16776707
	sta	>16776705
	rep	#$20
	longa	on
;		
;	}
	bra	L10003
;			case 1:
L10008:
;				g++;
	inc	<L3+g_1
;				if (g == 7) seq = 2;
	lda	<L3+g_1
	cmp	#<$7
	bne	L10005
	lda	#$2
	bra	L20000
;				break;
;			case 2:
L10010:
;				r--;
	dec	<L3+r_1
;				if (r == 0) seq = 3;
	lda	<L3+r_1
	bne	L10005
	lda	#$3
	bra	L20000
;				break;
;			case 3:
L10012:
;				b++;
	inc	<L3+b_1
;				if (b == 7) seq = 4;
	lda	<L3+b_1
	cmp	#<$7
	bne	L10005
	lda	#$4
	bra	L20000
;				break;
;			case 4:
L10014:
;				g--;
	dec	<L3+g_1
;				if (g == 0) seq = 5;
	lda	<L3+g_1
	bne	L10005
	lda	#$5
	bra	L20000
;				break;
;			case 5:
L10016:
;				r++;
	inc	<L3+r_1
;				if (r > 7) {
	lda	#$7
	cmp	<L3+r_1
	bcs	L10005
;					b = r = seq = 0;
	stz	<L3+seq_1
	stz	<L3+r_1
	stz	<L3+b_1
;					vTaskDelay(100);
	pea	#<$64
	jsl	~~vTaskDelay
;				}
;				break;
	brl	L10005
;		}
;	
;	//COLORBACKGROUNDLO = backLo;
;	//COLORBACKGROUNDHI = backHi;
;}
L2	equ	22
L3	equ	13
	ends
	efunc
;
	xref	~~vTaskDelay
