@echo off

set STARTUP=startup_short
set TOOLS=C:\atarigit\Tools
set CC65=%TOOLS%\wdc\tools\bin
set SRC=..\src
set BIN=..\bin
set REL=..\release
set OBJ=%REL%\obj
set ASM=%REL%\asm
set LST=%REL%\lst
set WDC_LIB=%REL%;%CC65%\..\lib
set RES=..\res
set WDC_INC_65816=%SRC%\inc;%CC65%\..\include;%SRC%\RTOS\include
set FATFS=%TOOLS%\fatfs\debug

echo =================================================================
echo %STARTUP%
%CC65%\WDC816AS.exe -O %REL%\%STARTUP%.o -L %SRC%\%STARTUP%.s
move %SRC%\%STARTUP%.lst %REL%


call :compile_module i8080
if NOT %result%==0 goto ende

call :compile_module i8080tst
if NOT %result%==0 goto ende

call :compile_module io 
if NOT %result%==0 goto ende
set SRC=%SRC%\rtos
	
call :compile_module debug
if NOT %result%==0 goto ende

call :link_module i8080tst 0A00

cd %REL%

rem copy ..\res\*.hex .

copy i8080tst.com e:

%FATFS%\FatFs.exe -c ..\..\My6502Emu\test.dat i8080tst.com
rem %FATFS%\FatFs.exe -d ..\..\My6502Emu\test.dat

:ende

pause
goto eof


:compile_module

	echo
	echo =================================================================
	echo %1
	%CC65%\WDC816CC.exe -D__65816__ -D__STRICT_ANSI__ -SO0S -LT -ML -A -O %ASM%\%1.s %SRC%\%1.c
	set result=%ERRORLEVEL%
	if not %result%==0 goto eof
 	%CC65%\WDC816OP.exe %ASM%\%1.s
 	move .opt %ASM%\%1.asm
	%CC65%\WDC816AS.exe -O %OBJ%\%1.o -L %ASM%\%1.asm
	move %ASM%\%1.lst %LST%
	goto eof
	
:link_module
	echo =================================================================
rem	pause
	%CC65%\WDCLN.exe -C%2 -HI    -O %REL%\%1.hex %OBJ%\startup_short.o %OBJ%\%1.o %OBJ%\io.o %OBJ%\debug.o -LCL %3
	%CC65%\WDCLN.exe -C%2 -HZ -V -O %REL%\%1.a   %OBJ%\startup_short.o %OBJ%\%1.o %OBJ%\i8080.o %OBJ%\io.o %OBJ%\debug.o -LCL %3
	java -cp %TOOLS%\Obj2Com\bin ObjUtil Obj2Com %REL%\%1.a %2

:eof