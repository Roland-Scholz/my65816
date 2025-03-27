@echo off
call rtos.cmd
call helper
pushd .
call rtest.cmd
popd
call comp_user_progs.cmd
rem call import.cmd
call loader.cmd
