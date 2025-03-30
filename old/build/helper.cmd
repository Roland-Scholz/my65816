@echo off

set PROG=main

set TOOLS=C:\atarigit\Tools
set CC65=%TOOLS%\wdc\tools\bin
set SRC=..\src
set RTOSSRC=%SRC%
set BIN=..\bin
set REL=..\release
set OBJ=%REL%\obj
set WDC_LIB=%CC65%\..\lib;%REL%
set RES=..\res
set WDC_INC_65816=.\libc\include;.\inc;.\rtos\include
set JAVA_OPTS=-cp %TOOLS%\Linker\bin
rem set JAVA_OPTS=%JAVA_OPTS% -Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005

call :compileHelper

pause
goto eof

:compileHelper

	pushd %RTOSSRC%

	rem del %REL%\helper.lib > nul 2> nul

	for %%V in (helper*.c) do (
		echo %%V

		%CC65%\WDC816CC.exe -D__65816__ -D__STRICT_ANSI__ -DRTOS -SO0S -ML -MO -A  %%V
		if ERRORLEVEL 1 goto :eof
		
		%CC65%\WDC816OP.exe %%~nV.asm
		%CC65%\WDC816AS.exe -O %OBJ%\%%~nV.o -L %%~nV.opt

		%CC65%\WDCLIB.exe -D %REL%\helper.lib %OBJ%\%%~nV.o
		%CC65%\WDCLIB.exe -A %REL%\helper.lib %OBJ%\%%~nV.o
		del ..\%OBJ%\%%~nV.o > nul 2> nul
	)

	move *.lst %REL%\lst > nul 2> nul
	move *.opt %REL%\asm > nul 2> nul
	move *.asm %REL%\asm > nul 2> nul

	popd

goto eof

:eof