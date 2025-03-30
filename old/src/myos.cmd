@echo off

echo %1 %2

rem del k.hex 

ca65 -DPLATFORM=1 -l myos.a65 -I \ATARI\cc65\asminc 
ld65 -t none myos.o -o myos
bin2hex myos myos.hex -o 8000

rem set file=kernel.hex
rem call :docopy
rem set file=font.hex
rem call :docopy
rem set file=start.hex
rem call :docopy

rem echo :00000001FF >> k.hex

pause

goto :EOF

:docopy

  echo %file%
  for /F %%i in (%file%) do (
    if NOT %%i==:00000001FF  echo %%i >> k.hex
  )
  goto :EOF