#!/bin/bash

VAR_MACHINE="escapepod"
VAR_SW_NAME="escapepod"

# ------ SHELL ------
echo "Logging into the machine '$VAR_MACHINE'..."
echo "Type 'docker exec -it -u root $VAR_SW_NAME /bin/bash' to shell container"
echo "Type 'exit' to quit the shell."
echo ""

docker-machine ssh $VAR_MACHINE
# docker exec -it -u root $VAR_SW_NAME /bin/bash