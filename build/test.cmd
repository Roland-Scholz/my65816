@echo off
rem set PLATFORM=0
rem set SOFTDISK=0
set SUFFIX=%PLATFORM%%SOFTDISK%

set KERNEL=kernelstart_%SUFFIX%.hex

set COMMON=..\..\atari-common
set FAT16=..\..\atari-fat16
set TOOLS=..\..\atari-tools

set CC65=%TOOLS%\cc65\bin
set WDC=%TOOLS%\WDC\bin

set SRC=..\src
set BIN=..\bin
set REL=..\release
set RES=..\res

set MODULE=test

call :compile_module %MODULE%
if NOT %result%==0 goto error

pushd %REL%
mkdir obj > nul 2> nul
mkdir lst > nul 2> nul

move %SRC%\*.lst lst > nul
move %SRC%\*.obj obj > nul

%WDC%\wdcln -O %MODULE%.hex -HI obj\%MODULE%

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

%WDC%\wdc816as -DTARGET=2 -W -L %SRC%\%1.asm

set result=%ERRORLEVEL%


