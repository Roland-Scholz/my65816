@echo off

set PROG=main

set TOOLS=C:\atarigit\Tools
set CC65=%TOOLS%\wdc\tools\bin
set SRC=..\src
set RTOSSRC=%SRC%\RTOS
set BIN=..\bin
set REL=..\release
set OBJ=%REL%\obj
set WDC_LIB=%CC65%\..\lib;%REL%
set RES=..\res
set WDC_INC_65816=.\include;..\libc\include;..\inc
set JAVA_OPTS=-cp %TOOLS%\Linker\bin
rem set JAVA_OPTS=%JAVA_OPTS% -Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005

call :compileRTOS

pause
goto eof

:compileRTOS

	pushd %RTOSSRC%

	del /S /Q asm > nul 2> nul
	del /S /Q lst > nul 2> nul
	mkdir asm > nul 2> nul
	mkdir lst > nul 2> nul

	del *.asm > nul 2> nul
	del *.opt > nul 2> nul
	del *.lst > nul 2> nul
	rem del ..\%REL%\rtos.lib > nul 2> nul

	for %%V in (heap32.c) do (
		echo %%V

		%CC65%\WDC816CC.exe -D__65816__ -D__STRICT_ANSI__ -SO0S -ML -A  %%V
		if ERRORLEVEL 1 goto :eof
		
		%CC65%\WDC816OP.exe %%~nV.asm
		
		java -cp %TOOLS%\codeAdjust\bin codeAdjust.codeAdjust %%~nV.opt %%~nV.asm ..\%RES%\rtos.def

		%CC65%\WDC816AS.exe -O ..\%OBJ%\%%~nV.o -L %%~nV.asm
		%CC65%\WDCLIB.exe -D ..\%REL%\rtos.lib ..\%OBJ%\%%~nV.o
		%CC65%\WDCLIB.exe -A ..\%REL%\rtos.lib ..\%OBJ%\%%~nV.o
		del ..\%OBJ%\%%~nV.o > nul 2> nul
	)

	echo port65816.s
	%CC65%\WDC816AS.exe -DPLATFORM=0 -O ..\%OBJ%\port65816.o -L port65816.s
	%CC65%\WDCLIB.exe -D ..\%REL%\rtos.lib ..\%OBJ%\port65816.o
	%CC65%\WDCLIB.exe -A ..\%REL%\rtos.lib ..\%OBJ%\port65816.o

	move *.lst lst > nul 2> nul
	move *.opt asm > nul 2> nul
	move *.asm asm > nul 2> nul
	

	popd

goto eof

:eof