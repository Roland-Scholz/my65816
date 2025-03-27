@echo off

rem call compile_task adler32 c
rem call compile_task crc32	c
rem call compile_task tinflate c
call compile_task puff c

set TOOLS=C:\atarigit\Tools
set CC65=%TOOLS%\wdc\tools\bin
set REL=..\release
set OBJ=%REL%\obj


rem %CC65%\WDCLIB.exe -D %REL%\helper.lib %OBJ%\inffast.o
rem %CC65%\WDCLIB.exe -D %REL%\helper.lib %OBJ%\inflate.o
rem %CC65%\WDCLIB.exe -D %REL%\helper.lib %OBJ%\zutil.o
rem %CC65%\WDCLIB.exe -D %REL%\helper.lib %OBJ%\inftrees.o

%CC65%\WDCLIB.exe -D %REL%\helper.lib %OBJ%\adler32.o
%CC65%\WDCLIB.exe -D %REL%\helper.lib %OBJ%\crc32.o
%CC65%\WDCLIB.exe -D %REL%\helper.lib %OBJ%\tinflate.o
%CC65%\WDCLIB.exe -D %REL%\helper.lib %OBJ%\puff.o

rem %CC65%\WDCLIB.exe -A %REL%\helper.lib %OBJ%\adler32.o
rem %CC65%\WDCLIB.exe -A %REL%\helper.lib %OBJ%\crc32.o
rem %CC65%\WDCLIB.exe -A %REL%\helper.lib %OBJ%\tinflate.o
%CC65%\WDCLIB.exe -A %REL%\helper.lib %OBJ%\puff.o

%CC65%\WDCLIB.exe -l %REL%\helper.lib 

pause