@echo off

set TOOLS=C:\atarigit\Tools
set CC65=%TOOLS%\wdc\tools\bin
set SRC=..\src
set BIN=..\bin
set REL=..\release
set OBJ=%REL%\obj
rem set CCTEMP=%REL%\
set WDC_LIB=%CC65%\..\lib;%REL%\
set RES=..\res
set WDC_INC_65816=%CC65%\..\include;%SRC%\inc

rem rmdir /S /Q %REL%
rem mkdir %REL%

call :compile_module download 0A00
if NOT %result%==0 goto ende

cd %REL%

rem mkdir obj
rem mkdir lst

move %REL%\*.s lst > nul
move %REL%\*.lst lst > nul
move *.o obj > nul
move *.a obj > nul

copy ..\res\*.hex .

:ende

pause
goto eof


:compile_module
	
	echo %1
	%CC65%\WDC816AS.exe -O %REL%\startup.o -L %SRC%\startup.s
	move %SRC%\startup.lst %REL%
	%CC65%\WDC816CC.exe -SO -MS -A -O %REL%\%1.s %SRC%\%1.c
	set result=%ERRORLEVEL%
	if not %result%==0 goto eof
rem	pause
 	%CC65%\WDC816OP.exe %REL%\%1.s
 	move .opt %REL%\%1.s
rem	pause

	%CC65%\WDC816AS.exe -O %REL%\%1.o -L %REL%\%1.s
rem	pause
	%CC65%\WDCLN.exe -C%2 -HI    -O %REL%\%1.hex %REL%\startup.o %REL%\%1.o -LCS -Lhlib %3
	%CC65%\WDCLN.exe -C%2 -HZ -V -O %REL%\%1.a   %REL%\startup.o %REL%\%1.o -LCS -Lhlib %3

	java -jar %TOOLS%\Obj2Com\bin\ObjUtil.jar Obj2Com %REL%\%1.a %2

rem if %result%==0 (
rem 
rem 	%CC65%\ld65 -C homebrew.cfg %REL%\%1.o -o %REL%\%1.a
rem	%CC65%\bin2hex %REL%\%1.a %REL%\%1.hex -o %2
rem	java -jar %TOOLS%\Obj2Com\bin\Obj2Com.jar %REL%\%1.a %2
rem )

:eof