@echo off 

title "Package GSA-ADS scripts"

call ./setenv.cmd
call %GIT_HOME%/bin/bash %BRANCH_HOME%/bin/package.sh