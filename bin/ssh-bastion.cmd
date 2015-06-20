@echo off

if exist ./setenv.cmd (
    call ./setenv.cmd
) else (
    echo No branch-specific configuration found
)

set KEY_FILE=%KEYS_HOME%\%BASTION_KEY%

set USE_PUTTY=
if "%PUTTY_HOME%" == "" (
    echo "PUTTY_HOME not set. Using Git SSH"
) else (    
    if NOT "%PUTTY_SESSION_NAME%" == "" (
        echo --- Opening on %BASTION_HOST% in PuTTY with session "%PUTTY_SESSION_NAME%"
        CMD /C %PUTTY_HOME%/putty -ssh -load "%PUTTY_SESSION_NAME%" %BASTION_HOST%
        set USE_PUTTY="true"
    ) else (
        echo "PUTTY_SESSION_NAME not set. Using Git SSH"
    )
)

if "%USE_PUTTY%" == "" (
    if "%KEYS_HOME%" == "" (
        echo "Path to key files not given. Please set variable KEYS_HOME"
    ) else if "%BASTION_KEY%" == "" (
        echo "Bastion server key file not given. Please set variable BASTION_KEY"
    ) else (
        if exist %KEY_FILE% (
            echo --- Opening on %BASTION_HOST% using SSH with key %KEY_FILE%
            echo call %GIT_HOME%/bin/ssh -i %KEY_FILE% %BASTION_USERNAME%@%BASTION_HOST%
            call %GIT_HOME%/bin/ssh -i %KEY_FILE% %BASTION_USERNAME%@%BASTION_HOST%
        ) else (
            echo "Bastion server key file '%KEY_FILE%' does not exist"
        )
    )
)

