ca65 -l xmodem.a65 -I \ATARI\cc65\asminc
ld65 -t none xmodem.o -o xmodem
bin2hex xmodem xmodem.hex -o 0400
pause