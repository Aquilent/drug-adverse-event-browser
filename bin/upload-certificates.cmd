@echo off

setlocal enabledelayedexpansion

call ./setenv.cmd

set KEYS_HOME=%1
set BASTION_KEY=%2
set BASTION_HOST=%3

echo --- Building certificate list from %KEYS_HOME% 
set KEYS=
for %%i in (%KEYS_HOME%\*.pem) do (
	echo     Including certificate %%i
	REM set KEYS=!KEYS! "%KEYS_HOME:\=/%/%%i"
    set KEYS=!KEYS! "%%i"
)
set KEYS=%KEYS:\=/%
echo --- Copying certificate list to the Bastion Server at %BASTION_HOST%

%GIT_HOME%/bin/scp -i "%KEYS_HOME:\=/%/%BASTION_KEY:.ppk=.pem%" -q  ^
	-oStrictHostKeyChecking=no !KEYS! %BASTION_USERNAME%@%BASTION_HOST%:~/.ssh/

echo --- Restricting access to certificates on %BASTION_HOST%
%GIT_HOME%/bin/ssh -i "%KEYS_HOME:\=/%/%BASTION_KEY:.ppk=.pem%" ^
  	-oStrictHostKeyChecking=no %BASTION_USERNAME%@%BASTION_HOST% "chmod 600 .ssh/*.pem" 

if "%4" == "--pause" ( 
	pause 
)