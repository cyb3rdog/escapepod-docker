#!/bin/bash

VAR_HOSTNAME="escapepod"
VAR_SW_NAME="escapepod"
VAR_IMAGE="escapepod:latest"

# ------ BUILD ------
echo "Building new image '$VAR_IMAGE'..."

docker build -t $VAR_IMAGE .

# ------ LAUNCH ------
echo "Done."
echo ""
echo "Creating the container '$VAR_SW_NAME'..."

docker run -it --rm --name $VAR_SW_NAME -h $VAR_HOSTNAME -p 80:80 -p 8084:8084 -p 8085:8085 -p 8086:8086 -d $VAR_IMAGE
