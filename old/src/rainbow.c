/*
<!-- präsentiert von kostenlose-javascripts.de -->
<script type='text/javascript'>
<!--
var nachricht = "Mein bunter bunter Regenbogentext"; // Dein Text
var groesse   = 30; // Größe des Textes
var geschwindigkeit = 50; // Geschwindigkeit der Farbveränderung in Millisekunden

// an hier nichts mehr ändern
document.write('<span id="regenbogentext" style="font-size: ' + groesse + 'px;">' + nachricht + '</span>');
var meinelement = document.getElementById("regenbogentext");


var hex = new Array("00","14","28","3C","50","64","78","8C","A0","B4","C8","DC","F0");
var r = 1;
var g = 1;
var b = 1;
var seq = 1;
function textaendern(){
	farbe = "#" + hex[r] + hex[g] + hex[b];
	meinelement.style.color = farbe;
}
function aendern(){
	switch (seq) {
		case 6: b--; if ( b == 0 ) seq = 1; break;
		case 5: r++; if ( r == 12 ) seq = 6; break;
		case 4: g--; if ( g == 0 ) seq = 5; break;
		case 3: b++; if ( b == 12 ) seq = 4; break;
		case 2: r--; if ( r == 0 ) seq = 3; break;
		case 1: g++; if ( g == 12 ) seq = 2; break;
	}
	textaendern();
}
function initregenbogen(){
	setInterval("aendern()", geschwindigkeit);
}
//-->
</script>
<br />
JavaScript von <a href="http://www.kostenlose-javascripts.de/javascripts/texteffekte/regenbogentext/" target="_blank">kostenlose-javascripts.de</a>
<br />
<script type="text/javascript">initregenbogen();</script>
<!-- präsentiert von kostenlose-javascripts.de -->
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include "FreeRTOS.h"
#include "task.h"
#include <homebrew.h>

int main(int argc, char**argv) {
	unsigned int r,g,b,color,seq;
		
	r = g = b = seq = 0;

	for(;;) {	
		//getchar();
		vTaskDelay(25);
		switch(seq) {
			case 0:
				r++;
				if (r == 7) seq = 1;
				break;
			case 1:
				g++;
				if (g == 7) seq = 2;
				break;
			case 2:
				r--;
				if (r == 0) seq = 3;
				break;
			case 3:
				b++;
				if (b == 7) seq = 4;
				break;
			case 4:
				g--;
				if (g == 0) seq = 5;
				break;
			case 5:
				r++;
				if (r > 7) {
					b = r = seq = 0;
					vTaskDelay(100);
				}
				break;
		}
		color = (b << 6) | (g << 3) | r;
		//printf("r:%d, g:%d, b:%d, color:%d\n", r, g, b, color);
		COLORBORDERLO = COLORBACKGROUNDLO = color;
		COLORBORDERHI = COLORBACKGROUNDHI = color >> 8;
		
	}
	
	//COLORBACKGROUNDLO = backLo;
	//COLORBACKGROUNDHI = backHi;
}