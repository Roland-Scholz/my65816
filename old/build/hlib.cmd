@echo off

set TOOLS=C:\atarigit\Tools
set CC65=%TOOLS%\wdc\tools\bin
set SRC=..\src
set BIN=..\bin
set REL=..\release
rem set CCTEMP=%REL%\
set WDC_LIB=%CC65%\..\lib
set RES=..\res
set WDC_INC_65816=%CC65%\..\include;%SRC%\inc

rem rmdir /S /Q %REL%
rem mkdir %REL%

call :compile_module hlib
if NOT %result%==0 goto ende

cd %REL%

rem mkdir obj
rem mkdir lst

move %REL%\*.s lst > nul
move %REL%\*.lst lst > nul
move *.o obj > nul
rem move *.a obj > nul

copy ..\res\*.hex .

:ende

pause
goto eof


:compile_module
	
	%CC65%\WDC816CC.exe -MO -SO -MS -A -O %REL%\%1.s %SRC%\%1.c
	set result=%ERRORLEVEL%
	if not %result%==0 goto eof
rem	pause
	%CC65%\WDC816OP.exe %REL%\%1.s
	move .opt %REL%\%1.s
rem	pause

	%CC65%\WDC816AS.exe -DPLATFORM=0 -O %REL%\callciov.o -L %SRC%\callciov.s
	move %SRC%\callciov.lst %REL%
	
	%CC65%\WDC816AS.exe -O %REL%\%1.o -L %REL%\%1.s
	del %REL%\%1.lib
	%CC65%\WDCLIB.exe -A %REL%\%1.lib %REL%\%1.o
	%CC65%\WDCLIB.exe -A %REL%\%1.lib %REL%\callciov.o

:eof