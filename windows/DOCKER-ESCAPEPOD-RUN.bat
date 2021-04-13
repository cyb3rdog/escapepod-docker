
SET MACHINE=ESCAPEPOD
SET HOST_NAME=escapepod

SET SW_PORT=80
SET SW_NAME=escapepod
SET SW_IMAGE=cyb3rdog/escapepod:latest


REM ------ VARIABLES ------
:Variables
ECHO Setting Enviroment Variables for User '%USERNAME%'...

SETLOCAL ENABLEDELAYEDEXPANSION
FOR /f "tokens=*" %%i IN ('docker-machine env %MACHINE%') DO %%i


REM ------ LAUNCH ------
docker run -it --rm --name %SW_NAME% -h "%HOST_NAME%" -p 80:%SW_PORT% -p 8084:8084 -p 8085:8085 -p 8086:8086 -p 65533:65533 -d %SW_IMAGE%
