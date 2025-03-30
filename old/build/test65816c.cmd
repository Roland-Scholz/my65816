@echo off

set TOOLS=C:\atarigit\Tools
set CC65=%TOOLS%\wdc\tools\bin
set SRC=..\src
set BIN=..\bin
set REL=..\release
set OBJ=%REL%\obj
set WDC_LIB=%REL%;%CC65%\..\lib
set RES=..\res
set WDC_INC_65816=%SRC%\inc;%SRC%\libc\include;%SRC%\RTOS\include

set JAVA_OPTS=-cp %TOOLS%\Linker\bin
rem set JAVA_OPTS=%JAVA_OPTS% -Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005

rem rmdir /S /Q %REL%
rem mkdir %REL%

call :compile_module test65816 1000
if NOT %result%==0 goto ende

del *.obj > nul 2> nul
move *.txt %REL%\lst > nul 2> nul

cd %REL%

rem mkdir obj
rem mkdir lst

move %REL%\*.s lst > nul
move %REL%\*.lst lst > nul
move *.o obj > nul 2> nul
move *.a obj > nul 2> nul

copy ..\res\*.hex . > nul
rem copy %REL%\test65816.exe %REL%\TEST816.EXE
rem copy %REL%\test65816.exe D:\TEST816.EXE

:ende

pause
goto eof


:compile_module

	echo "startup_task.s"
	%CC65%\WDC816AS.exe -O %OBJ%\startup_task.o -L %SRC%\startup_task.s
	move %SRC%\startup_task.lst %REL%
	
	echo %1
	%CC65%\WDC816CC.exe -D__65816__ -D__STRICT_ANSI__ -SO0S -ML -A -O %REL%\%1.s %SRC%\%1.c

	set result=%ERRORLEVEL%
	if not %result%==0 goto eof
rem	pause
	%CC65%\WDC816OP.exe %REL%\%1.s
	move .opt %REL%\%1.s
rem	pause

	
	%CC65%\WDC816AS.exe -O %OBJ%\%1.o -L %REL%\%1.s
	
	java %JAVA_OPTS% Linker %OBJ%\startup_task.o %OBJ%\%1.o -a rtos.def -l rtos.lib -l libc.lib -l cl.lib -o %REL%\TST65816.exe
rem -l cl.lib
:eof