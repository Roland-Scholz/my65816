@echo off

echo "*****************************************************"
echo compiling RTOS task: %1 %2

if "%2"=="" (set COMP=y) else (set COMP=%2)

set TOOLS=C:\atarigit\Tools
set CC65=%TOOLS%\wdc\tools\bin
set FATFS=%TOOLS%\fatfs\debug
set SRC=..\src
set BIN=..\bin
set REL=..\release
set OBJ=%REL%\obj
set WDC_LIB=%REL%;%CC65%\..\lib;..\..\z80emu\release
set RES=..\res
set WDC_INC_65816=%SRC%\inc;%SRC%\libc\include;%SRC%\RTOS\include;%SRC%;

set JAVA_OPTS=-cp %TOOLS%\Linker\bin
rem set JAVA_OPTS=%JAVA_OPTS% -Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005

copy %RES%\*.def %REL% > nul


call :compile_module %1 %COMP%

if %COMP%==c goto eof

copy %REL%\%1.exe e:

goto eofPause


:compile_module

	echo *****************************************************************
	echo assembling "startup_task.s"
	echo *****************************************************************
	%CC65%\WDC816AS.exe -O %OBJ%\startup_task.o -L %SRC%\startup_task.s
	if not %ERRORLEVEL%==0 goto eof
	move %SRC%\startup_task.lst %REL%\lst > nul 2> nul
	
	echo *****************************************************************
	echo compiling %1.c
	echo *****************************************************************
	%CC65%\WDC816CC.exe -D__65816__ -D__STRICT_ANSI__ -DRTOS -SO0S -ML -AT -O %REL%\%1.s %SRC%\%1.c
	if not %ERRORLEVEL%==0 goto eof

	echo *****************************************************************
	echo optimizing %1.s
	echo *****************************************************************
	%CC65%\WDC816OP.exe %REL%\%1.s
	rem if not %ERRORLEVEL%==0 goto eof
	move .opt %REL%\%1.s > nul 2> nul
	rem java -cp %TOOLS%\optimize\bin optimize.optimize .opt %REL%\%1.s
	
	echo *****************************************************************
	echo assembling %1.s
	echo *****************************************************************
	%CC65%\WDC816AS.exe -O %OBJ%\%1.o -L %REL%\%1.s
	if not %ERRORLEVEL%==0 goto eof
	move %REL%\%1.lst %REL%\lst > nul 2> nul
	move %REL%\%1.s %REL%\lst > nul 2> nul

	if %2==c goto eof
	echo *****************************************************************
	echo linking %1.o
	echo *****************************************************************
	java %JAVA_OPTS% Linker %OBJ%\startup_task.o %OBJ%\%1.o -a rtos.def -l z80.lib -l helper.lib -l rtos.lib -l libc.lib -l cl.lib -o %REL%\%1.exe
	if not %ERRORLEVEL%==0 goto eof
	
	echo *****************************************************************
	echo copy %1.exe into FatFs
	echo *****************************************************************
	%FATFS%\FatFs.exe -c ..\..\My6502Emu\test.dat %REL%\%1.exe
	rem %FATFS%\FatFs.exe -d ..\..\My6502Emu\test.dat
:eofPause
pause
:eof