exit
@echo off

set TOOLS=..\..\Tools
set CC65=%TOOLS%\cc65\bin
set SRC=..\src
set BIN=..\bin
set REL=..\release
set RES=..\res

rmdir /S /Q %REL%
mkdir %REL%

call :compile_module myos 8000 65816 2000
if NOT %result%==0 goto ende

cd %REL%

mkdir obj
mkdir lst

move %REL%\*.lst lst > nul
move *.o obj > nul
move *.a obj > nul

copy ..\res\*.hex .

:ende

pause
goto eof

rem ------------------------------------------------------------
rem
rem ------------------------------------------------------------
:docopy

  echo %file%
  for /F %%i in (%file%) do (
    if NOT %%i==:00000001FF  echo %%i >> k.hex
  )
  
  goto :eof
  

rem ------------------------------------------------------------
rem
rem ------------------------------------------------------------
:compile_module

%CC65%\ca65 --cpu %3 -DPLATFORM=1 -l %REL%\%1.lst %SRC%\%1.a65 -I %SRC%\inc -o %REL%\%1.o
set result=%ERRORLEVEL%

if %result%==0 (

	%CC65%\ld65 -C homebrew.cfg %REL%\%1.o -o %REL%\%1.a
	%CC65%\bin2hex %REL%\%1.a %REL%\%1.hex -o %2
	java -jar %TOOLS%\Obj2Com\bin\ObjUtil.jar Obj2Com %REL%\%1.a %2
	java -jar %TOOLS%\Obj2Com\bin\ObjUtil.jar ObjFill %REL%\%1.a %4
)

:eof