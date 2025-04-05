@echo off
rem set PLATFORM=0
rem set SOFTDISK=0
set SUFFIX=%PLATFORM%%SOFTDISK%

set KERNEL=kernelstart_%SUFFIX%.hex

set COMMON=..\..\atari-common
set FAT16=..\..\atari-fat16
set TOOLS=..\..\atari-tools

set CC65=%TOOLS%\WDC\bin
set WDC=%TOOLS%\WDC\bin
set WDC_LIB=%REL%;%CC65%\..\lib
set WDC_INC_65816=%CC65%\..\include

set SRC=..\src
set BIN=..\bin
set REL=..\release
set RES=..\res
set OBJ=%REL%\obj

call :compile_module wdcinfo
if NOT %result%==0 goto error

pushd %REL%

mkdir obj > nul 2> nul
mkdir lst > nul 2> nul

move *.lst lst > nul 2> nul
move *.o obj > nul 2> nul

%CC65%\WDCLN.exe -V -C0400 -HI -O %REL%\wdcinfo.hex %OBJ%\wdcinfo.o -LCC



popd

pause
goto :eof

:error
pause
goto :eof

rem ------------------------------------------------------------
rem
rem ------------------------------------------------------------
:docopy

  echo %file%
  for /F %%i in (%file%) do (
    if NOT %%i==:00000001FF  echo %%i >> %KERNEL%
  )
  
  goto :eof
  

rem ------------------------------------------------------------
rem
rem ------------------------------------------------------------
:compile_module

  echo ***
  echo *** compiling %1.c
  echo ***

  %CC65%\WDC816CC.exe -D__65816__ -D__STRICT_ANSI__ -SO0S -MC -A -O %REL%\%1.s %SRC%\%1.c
 	%CC65%\WDC816OP.exe %REL%\%1.s
  move .opt %REL%\%1.s
 	%CC65%\WDC816AS.exe -O %REL%\%1.o -L %REL%\%1.s

set result=%ERRORLEVEL%


