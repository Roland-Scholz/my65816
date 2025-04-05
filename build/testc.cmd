@echo off
rem ***************************************************
rem * compile-precedure for Calypsi 65816 compiler
rem ***************************************************

PATH=%PATH%;C:\github\atari-tools\calypsi-65816-5.9\bin
set HOME=C:\github\my65816
set SRC=%HOME%\src
set REL=%HOME%\release
set OBJ=%REL%\obj
set LST=%REL%\lst

echo ***
echo *** assemble 
echo ***
as65816 --code-model compact --data-model medium --list-file %LST%\mystartup.lst -IC:\github\atari-tools\calypsi-65816-5.9\src\lib\lowlevel -o %OBJ%\mystartup.o %SRC%\mystartup.s 
rem echo %ERRORLEVEL%

echo ***
echo *** compile
echo ***
cc65816 --code-model compact --data-model medium -o %OBJ%\testc.o --list-file %LST%\testc.lst %SRC%\testc.c

echo ***
echo *** link 
echo ***
ln65816 --list-file %LST%\testc.lin --output-format intel-hex --output-file %REL%\testc.elf %OBJ%\mystartup.o %OBJ%\testc.o clib-cc-md-1.a %SRC%\testc.scm