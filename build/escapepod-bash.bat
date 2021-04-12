@echo off

SET MACHINE=escapepod-build
SET SW_NAME=escapepod

REM ------ VARIABLES ------
:Variables
ECHO Setting Enviroment Variables for User '%USERNAME%'...

SETLOCAL ENABLEDELAYEDEXPANSION
FOR /f "tokens=*" %%i IN ('docker-machine env %MACHINE%') DO %%i

REM ------ SHELL ------
ECHO.
ECHO Logging into the machine '%MACHINE%'...
ECHO Type 'docker exec -it -u root %SW_NAME% /bin/bash' to shell container
ECHO Type 'exit' to quit the shell.
ECHO.

ansicon -p
docker-machine ssh %MACHINE%
REM docker exec -it -u root %SW_NAME% /bin/bash