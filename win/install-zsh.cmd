@echo off
set MSYSTEM=MINGW64
set MSYS=winsymlinks:nativestrict
set MSYS2_PATH_TYPE=inherit
set CHERE_INVOKING=1
D:/tools/msys64/usr/bin/bash.exe --login -c /d/Developer/gui-configs/win/init-msys2.sh --cd=/d/Developer/gui-configs/win
cmd \k run-zsh.cmd