@echo off

set PROG=main

set TOOLS=C:\atarigit\Tools
set CC65=%TOOLS%\wdc\tools\bin
set SRC=..\src
set RTOSSRC=%SRC%\brandy-1.0.19
set BIN=..\bin
set REL=..\release
set OBJ=%REL%\obj
set WDC_LIB=%CC65%\..\lib;%REL%
set RES=..\res
set WDC_INC_65816=.;..\libc\include;..\inc
set JAVA_OPTS=-cp %TOOLS%\Linker\bin
rem set JAVA_OPTS=%JAVA_OPTS% -Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005

call :compileBrandy

pushd %REL%
%CC65%\wdclib -x brandy.lib brandy.o
popd

copy ..\res\rtos.def %REL%
java %JAVA_OPTS% Linker %OBJ%\startup_task.o %REL%\brandy.o -a rtos.def -l brandy.lib -l helper.lib -l libc.lib -l cl.lib -l ml.lib -o %REL%\%1.exe

rem if not %ERRORLEVEL%==0 goto eof

pause
goto eof

:compileBrandy

	pushd %RTOSSRC%

	del /S /Q asm > nul 2> nul
	del /S /Q lst > nul 2> nul
	del /S /Q obj > nul 2> nul
	
	mkdir asm > nul 2> nul
	mkdir lst > nul 2> nul
	mkdir obj > nul 2> nul

	del *.asm > nul 2> nul
	del *.opt > nul 2> nul
	del *.lst > nul 2> nul

	@echo on
	del ..\%REL%\brandy.lib
	@echo off
	rem > nul 2> nul

	for %%V in (*.c) do (
		echo %%V

		%CC65%\WDC816CC.exe -D__OpenBSD__ -D__65816__ -D__STRICT_ANSI__ -DRTOS -SO0S -ML -A  %%V
		if ERRORLEVEL 1 goto :eof
		
		%CC65%\WDC816OP.exe %%~nV.asm
		
		rem java -cp %TOOLS%\codeAdjust\bin codeAdjust.codeAdjust %%~nV.opt %%~nV.asm ..\%RES%\rtos.def

		%CC65%\WDC816AS.exe -O %%~nV.o -L %%~nV.asm
		%CC65%\WDCLIB.exe -A ..\%REL%\brandy.lib %%~nV.o
		
		move %%~nV.o obj
		rem del %%~nV.o > nul 2> nul
	)

	move *.lst lst > nul 2> nul
	move *.opt asm > nul 2> nul
	move *.asm asm > nul 2> nul
	

	popd

goto eof

:eof