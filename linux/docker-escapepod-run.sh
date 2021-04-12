#!/bin/bash

VAR_HOSTNAME="escapepod"
VAR_SW_NAME="escapepod"
VAR_IMAGE="cyb3rdog/escapepod:latest"

docker run -it --rm --name $VAR_SW_NAME -h $VAR_HOSTNAME -p 80:80 -p 8084:8084 -p 8085:8085 -p 8086:8086 -d $VAR_IMAGE