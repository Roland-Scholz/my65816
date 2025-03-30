@echo off
echo %1 %2

del k.hex 

ca65 --cpu 65816 -l my65816.a65 -I \ATARI\cc65\asminc
ld65 -t none my65816.o -o my65816
bin2hex my65816 my65816.hex -o e000

set file=my65816.hex
call :docopy
set file=start.hex
call :docopy

echo :00000001FF >> k.hex

pause

goto :EOF

:docopy

  echo %file%
  for /F %%i in (%file%) do (
    if NOT %%i==:00000001FF  echo %%i >> k.hex
  )
  goto :EOF