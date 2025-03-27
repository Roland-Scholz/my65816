@echo off
rem call rtos-io.cmd

set TOOLS=C:\atarigit\Tools
set CC65=%TOOLS%\wdc\tools\bin
set SRC=..\src
set BIN=..\bin
set REL=..\release
set OBJ=%REL%\obj
set WDC_LIB=%REL%;%CC65%\..\lib
set RES=..\res
set WDC_INC_65816=%SRC%\inc;%SRC%\libc\include;%SRC%\RTOS\include
set FATFS=%TOOLS%\fatfs\debug

rem rmdir /S /Q %REL%
rem mkdir %REL%

call :compile_module Rtest 010000
if NOT %result%==0 goto ende

cd %REL%

rem mkdir obj
rem mkdir lst

move %REL%\*.s lst > nul
move %REL%\*.lst lst > nul
move %REL%\*.asm lst > nul

move *.o obj > nul
move *.a obj > nul

copy ..\res\*.hex .

cd obj

copy Rtest.a C:\atarigit\My6502Emu
copy Rtest.a e:

%FATFS%\FatFs.exe -c ..\..\..\My6502Emu\test.dat rtest.a

:ende

pause
goto eof


:compile_module
	
	echo %1
	%CC65%\WDC816AS.exe -O %REL%\startup_rtos.o -L %SRC%\startup_rtos.s
	move %SRC%\startup_rtos.lst %REL%
	java -cp %TOOLS%\makeDef\bin makeDef.makeDef %SRC%\startup_rtos.s %RES%\rtos.def
	
	%CC65%\WDC816CC.exe -D__65816__ -D__STRICT_ANSI__ -DRTOS -SO0S -ML -A -O %REL%\%1.s %SRC%\%1.c
	set result=%ERRORLEVEL%
	if not %result%==0 goto eof

rem	pause

 	%CC65%\WDC816OP.exe %REL%\%1.s
 	move .opt %REL%\%1.s

rem	pause
	java -cp %TOOLS%\codeAdjust\bin codeAdjust.codeAdjust %REL%\%1.s %REL%\%1.asm %RES%\rtos.def

	%CC65%\WDC816AS.exe -O %REL%\%1.o -L %REL%\%1.asm
	
rem	pause
	%CC65%\WDCLN.exe -C%2 -HI    -O %REL%\%1.hex %REL%\startup_rtos.o %REL%\%1.o -Lrtos -llibc -LCL %3
	%CC65%\WDCLN.exe -C%2 -HB -V -O %REL%\%1.a   %REL%\startup_rtos.o %REL%\%1.o -Lrtos -llibc -LCL %3

	java -jar %TOOLS%\Obj2Com\jar\ObjUtil.jar Obj2Com %REL%\%1.a %2

:eof