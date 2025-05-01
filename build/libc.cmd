@echo off

set COMMON=..\..\atari-common
set FAT16=..\..\atari-fat16
set TOOLS=..\..\atari-tools

set CC65=%TOOLS%\WDC\bin
set WDC=%TOOLS%\WDC\bin

set SRC=..\src\libc\
set BIN=..\bin
set REL=..\release
set RES=..\res
set OBJ=%REL%\obj
set ASM=%REL%\asm
set LIB=%REL%\lib

set WDC_LIB=%REL%;%CC65%\..\lib
set WDC_INC_65816=%SRC%;%SRC%\include;%CC65%\..\include;%SRC%\..\FreeRTOS\Source;%SRC%\..\FreeRTOS\Source\include
set OPTS=-D__STRICT_ANSI__ -D__65816__

set MODEL=C


mkdir obj > nul 2> nul
mkdir lst > nul 2> nul
mkdir asm > nul 2> nul
mkdir lib > nul 2> nul

del %LIB%\libc.lib

for %%i in (%SRC%\*.c) do (
	call :compile_module %%~ni
rem	if NOT %result%==0 goto error
)


pushd %REL%

move %ASM%\*.lst lst > nul 2> nul
rem move *.o obj > nul 2> nul

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

  echo *********************************************************
  echo *** compiling %1.c
  echo *********************************************************

  %CC65%\WDC816CC.exe %OPTS% -SO0S -M%MODEL% -A -O %ASM%\%1.s %SRC%\%1.c
  set RESULT=%ERRORLEVEL%

  %CC65%\WDC816OP.exe %ASM%\%1.s

  move .opt %ASM%\%1.opt.s > nul 2> nul
  
  %CC65%\WDC816AS.exe -O %OBJ%\%1.o -LW %ASM%\%1.opt.s
  %CC65%\WDCLIB.exe -A %LIB%\libc.lib %OBJ%\%1.o
