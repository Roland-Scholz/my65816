@echo off

set TOOLS=..\..\Tools
set FATFS=%TOOLS%\fatfs\debug
set CC65=%TOOLS%\cc65\bin
set SRC=..\src
set BIN=..\bin
set REL=..\release
set RES=..\res

rem rmdir /S /Q %REL%
mkdir %REL% > nul 2> nul

call :compile_module test 0A00 65816 1FE4
if NOT %result%==0 goto ende

cd %REL%

mkdir obj > nul 2> nul
mkdir lst > nul 2> nul

move %REL%\*.lst lst > nul
move *.o obj > nul
move *.a obj > nul

copy ..\res\*.hex .
copy ..\..\FAT16\release\*.hex .

:ende

pause
goto eof

rem ------------------------------------------------------------
rem
rem ------------------------------------------------------------
:docopy

  echo %file%
  
  for /F %%i in (%file%) do (
    if NOT %%i==:00000001FF  echo %%i >> kernelFPGA.hex
  )
  
  goto :eof
  

rem ------------------------------------------------------------
rem
rem ------------------------------------------------------------
:compile_module

%CC65%\ca65 --cpu %3 -DPLATFORM=0 -DSOFTDISK=0 -l %REL%\%1.lst %SRC%\%1.a65 -I %SRC%\inc -o %REL%\%1.o
set result=%ERRORLEVEL%

if %result%==0 (

	%CC65%\ld65 -C homebrew.cfg %REL%\%1.o -o %REL%\%1.a
	%CC65%\bin2hex %REL%\%1.a %REL%\%1.hex -o %2
	java -jar %TOOLS%\Obj2Com\jar\ObjUtil.jar Obj2Com %REL%\%1.a %2
rem	java -jar %TOOLS%\Obj2Com\jar\ObjUtil.jar ObjFill %REL%\%1.a %4

	echo *****************************************************************
	echo copy %1.exe into FatFs
	echo *****************************************************************
	%FATFS%\FatFs.exe -c ..\..\My6502Emu\test.dat %REL%\%1.com
	%FATFS%\FatFs.exe -d ..\..\My6502Emu\test.dat
)

:eof