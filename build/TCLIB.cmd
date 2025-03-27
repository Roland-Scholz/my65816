@echo off

set PROG=main

set TOOLS=C:\atarigit\Tools
set CC65=%TOOLS%\wdc\tools\bin
set SRC=..\src
set CLIBSRC=%SRC%\tlibc
set BIN=..\bin
set REL=..\release
set OBJ=%REL%\obj
set WDC_LIB=%CC65%\..\lib;%REL%
set RES=..\res
set WDC_INC_65816=%CC65%\..\include;%SRC%\inc;.\include;..\inc
set JAVA_OPTS=-cp %TOOLS%\Linker\bin
rem set JAVA_OPTS=%JAVA_OPTS% -Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005

call :compileCLIB

pause
goto eof

:compileCLIB

	pushd %CLIBSRC%

	del /S /Q asm > nul 2> nul
	del /S /Q lst > nul 2> nul
	mkdir asm > nul 2> nul
	mkdir lst > nul 2> nul
	
	del *.asm > nul 2> nul
	del *.opt > nul 2> nul
	del *.lst > nul 2> nul
	del ..\%REL%\clib.lib > nul 2> nul

	for %%V in (*.cpp) do (
		echo %%V

		%CC65%\WDC816CC.exe -SO0S -ML -A  %%V
		if ERRORLEVEL 1 goto :eof
		
		%CC65%\WDC816OP.exe %%~nV.asm
		%CC65%\WDC816AS.exe -O ..\%OBJ%\%%~nV.o -L %%~nV.opt
		%CC65%\WDCLIB.exe -A ..\%REL%\clib.lib ..\%OBJ%\%%~nV.o
		del ..\%OBJ%\%%~nV.o > nul 2> nul
	)

	move *.lst lst > nul 2> nul
	move *.opt asm > nul 2> nul
	move *.asm asm > nul 2> nul

	popd

goto eof

:eof