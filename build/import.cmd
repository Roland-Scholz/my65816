@echo off
set TOOLS=C:\atarigit\Tools
set FATFS=%TOOLS%\fatfs\debug

%FATFS%\FatFs.exe -c ..\..\My6502Emu\test.dat ..\src\kilo.c
pause
