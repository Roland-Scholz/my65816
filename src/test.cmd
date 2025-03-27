
ca65 -l test.a65 -I \ATARI\cc65\asminc
ld65 -t none test.o -o test
bin2hex test test.hex -o 0400

bin2hex Bm437_IBM_BIOS1.bin font.hex -o F700
pause