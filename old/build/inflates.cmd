@echo off

echo "*****************************************************"
echo compiling inflate.s

if "%2"=="" (set COMP=y) else (set COMP=%2)
set TOOLS=C:\atarigit\Tools
set CC65=%TOOLS%\wdc\tools\bin
set FATFS=%TOOLS%\fatfs\debug
set SRC=..\src
set BIN=..\bin
set REL=..\release
set OBJ=%REL%\obj
set WDC_LIB=%REL%;%CC65%\..\lib
set RES=..\res
set WDC_INC_65816=%SRC%\inc;%SRC%\libc\include;%SRC%\RTOS\include
set JAVA_OPTS=-cp %TOOLS%\Linker\bin

rem set JAVA_OPTS=%JAVA_OPTS% -Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005

rem copy %RES%\*.def %REL% > nul


%CC65%\WDC816AS.exe -O %OBJ%\inflate.o -S -W -L %SRC%\inflate.s
move %SRC%\inflate.lst %REL%\lst

%CC65%\WDCLIB.exe -D %REL%\helper.lib %OBJ%\inflate.o
%CC65%\WDCLIB.exe -A %REL%\helper.lib %OBJ%\inflate.o
%CC65%\WDCLIB.exe -l %REL%\helper.lib 
pause