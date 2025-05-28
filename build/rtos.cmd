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
set MODEL=C

set SRC=..\src\FreeRTOS\Source
set BIN=..\bin
set REL=..\release
set RES=..\res
set OBJ=%REL%\obj

set WDC_INC_65816=%SRC%;%SRC%\include;%SRC%\..\..\libc\include;%CC65%\..\include
set OPTS=-D__STRICT_ANSI__ -D__65816__ -SO0S -A -LT

call :compile_module tasks
call :compile_module heap32
call :compile_module heap16

if NOT %result%==0 goto error

pushd %REL%

mkdir obj > nul 2> nul
mkdir lst > nul 2> nul

move *.lst lst > nul 2> nul
move *.o obj > nul 2> nul

rem %CC65%\WDCLN.exe -V -C0400 -HI -O %REL%\wdcinfo.hex %OBJ%\wdcinfo.o -LC%MODEL%
rem %CC65%\WDCLN.exe -V -C0400 -HB -O %REL%\wdcinfo.bin %OBJ%\wdcinfo.o -LC%MODEL%



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

  %CC65%\WDC816CC.exe %OPTS% -M%MODEL% -O %REL%\%1.s %SRC%\%1.c
  set result=%ERRORLEVEL%
  
  %CC65%\WDC816OP.exe %REL%\%1.s
  move %REL%\%1.s %REL%\%1.asm
  move .opt %REL%\%1.s
  
  %CC65%\WDC816AS.exe -O %REL%\%1.o -LW %REL%\%1.s
  echo %result%


