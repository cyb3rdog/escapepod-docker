@echo off
REM -------------------------------------------------------------------------------
REM --- The minimal pre-requisities to use this Script "as is" are:             ---
REM ---  * DockerToolbox                                                        ---
REM ---  * Oracle VirtualBox                                                    ---
REM -------------------------------------------------------------------------------
REM --- This Script does everything automaticaly, including creation of the     ---
REM --- Virtual Machine, if that does not exist, creating and setting up the    ---
REM --- Docker Container, enabling it for remote connections on specified port  ---
ECHO -------------------------------------------------------------------------------
ECHO --- Script Optional Parameters:                                             ---
ECHO ---   %%1 - Docker Virtual Machine Name                                     ---
ECHO ---   %%2 - Docker Container Name                                           ---
ECHO ---   %%3 - Host Name                                                       ---
ECHO ---   %%4 - Port                                                            ---
ECHO -------------------------------------------------------------------------------


SET VM_MEMORY=4086
SET VM_DISK_SIZE=15000
SET VM_DRIVER=virtualbox
SET VM_NIC_MODE=deny

SET MACHINE=ESCAPEPOD
SET HOST_NAME=escapepod

SET SW_PORT=80
SET SW_NAME=escapepod
SET SW_IMAGE=cyb3rdog/escapepod:latest

SET HOSTS_FILE=%WINDIR%\system32\drivers\etc\hosts

IF NOT "%1"=="" SET MACHINE=%1
IF NOT "%2"=="" SET SW_NAME=%2
IF NOT "%3"=="" SET HOST_NAME=%3
IF NOT "%4"=="" SET SW_PORT=%4


REM ------ Machine ------
:Machine
ECHO.
ECHO Searching for Docker Virtual Machine '%MACHINE%'...
FOR /F "USEBACKQ tokens=1" %%i IN (`docker-machine ls`) DO (
  IF %%i==%MACHINE% SET DOCKER_MACHINE_NAME=%%i
)
IF "%DOCKER_MACHINE_NAME%"=="%MACHINE%" GOTO Boot

ECHO Docker Virtual Machine '%MACHINE%' not Found!
ECHO Creating New Virtual Machine '%MACHINE%'...
ECHO.

docker-machine create --driver %VM_DRIVER% --virtualbox-memory %VM_MEMORY% --virtualbox-disk-size %VM_DISK_SIZE% --virtualbox-host-dns-resolver --virtualbox-hostonly-nicpromisc %VM_NIC_MODE% %MACHINE%
REM docker network create --driver=bridge --subnet=192.168.0.0/24 --gateway=192.168.0.1 network
GOTO Variables


REM ------ BOOT ------
:Boot
ECHO Done.
ECHO.
ECHO Checking State of Docker Virtual Machine '%MACHINE%'...
SETLOCAL ENABLEDELAYEDEXPANSION
FOR /F "tokens=* USEBACKQ" %%F IN (`docker-machine status %MACHINE%`) DO (
  SET DOCKER_MACHINE_STATUS=%%F
)
IF "%DOCKER_MACHINE_STATUS%"=="Running" GOTO Variables

ECHO Done.
ECHO.
ECHO Booting Up Docker Virtual Machine '%MACHINE%'...
REM "c:\Program Files\Oracle\VirtualBox\VBoxManage.exe" sharedfolder add %MACHINE% --name "%SHARE_NAME%" --hostpath %cd%\%SHARE_SUB_DIR%
docker-machine start %MACHINE%


REM ------ VARIABLES ------
:Variables
ECHO Done.
ECHO.
ECHO Setting Enviroment Variables for User '%USERNAME%'...

SETLOCAL ENABLEDELAYEDEXPANSION
FOR /f "tokens=*" %%i IN ('docker-machine env %MACHINE%') DO %%i
FOR /f "tokens=*" %%i IN ('docker-machine env %MACHINE%') DO ECHO %%i
FOR /F "USEBACKQ tokens=1" %%i IN (`docker-machine ip %MACHINE%`) DO SET HOST_IP=%%i
FOR /F "USEBACKQ tokens=1" %%i IN (`docker-machine active`) DO SET MACHINE_ACTIVE=%%i

ECHO.
ECHO - Active Machine: '%MACHINE_ACTIVE%'
ECHO - Active IP: '%HOST_IP%'


REM ------ REGENERATE ------
GOTO Remove
ECHO Done.
ECHO.
ECHO Regenerating '%MACHINE%'...
CHOICE /M "- Regenerate certificates? :"
IF ERRORLEVEL 2 GOTO Remove
docker-machine regenerate-certs %MACHINE% --force


REM ------ REMOVE ------
:Remove
ECHO Done.
ECHO.
ECHO Checking Existing Docker Containers...
SETLOCAL ENABLEDELAYEDEXPANSION
FOR /F "tokens=* USEBACKQ" %%F IN (`docker ps -a -q -f name^="%SW_NAME%"`) DO SET DOCKER_SW_CID=%%F

IF "%DOCKER_SW_CID%"=="" GOTO Build
docker stop %DOCKER_SW_CID%
docker rm -f %DOCKER_SW_CID%


REM ------ BUILD ------
:Build
ECHO Done.
ECHO.
ECHO Creating container '%SW_NAME%' from '%SW_IMAGE%'...

docker run -it --rm --name %SW_NAME% -h "%HOST_NAME%" -p 80:%SW_PORT% -p 8084:8084 -p 8085:8085 -p 8086:8086 -p 65533:65533 -d %SW_IMAGE%

REM ------ START ------
:Start
ECHO Done.
ECHO.
ECHO Starting Containers...
docker start %SW_NAME%


REM ------ FINISH ------
:Finish
ECHO Done.
ECHO.
ECHO Server Info :
ECHO Server		= 	%HOST_IP%
ECHO Web		=	http://%HOST_IP%:80/
ECHO.

start "" http://%HOST_IP%:80/

CHOICE /M "Do you want to ssh into '%MACHINE%': "
IF ERRORLEVEL 2 GOTO Exit


REM ------ SHELL ------
ECHO.
ECHO Logging into the machine '%MACHINE%'...
ECHO Type 'docker exec -it -u root %SW_NAME% /bin/bash' to shell into container
ECHO Type 'exit' to quit.
ECHO.
REM docker exec -it -u root %SW_NAME% /bin/bash
docker-machine ssh %MACHINE%


REM ------ EXIT ------
:Exit
ECHO.
ECHO Finished. Press any key to quit.
pause > nul
