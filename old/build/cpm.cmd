@echo off
pushd ..\..\z80emu\build
call comp.cmd
popd
call compile_task %~n0