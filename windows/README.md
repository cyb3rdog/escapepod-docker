
# Windows Scripts for EscapePod Docker Image

This folder contain various Windows batch scripts to help you use the EscapePod Docker Image in your Windows environment.

## DOCKER-ESCAPEPOD-START.bat 

This is a fully automated script which creates a dedicated Docker Virtual machine named 'ESCAPEPOD', pull the image, and run the container.
The advantage od this approach is that the EscapePod container is not contained in your 'default' Docker's machine, where you already 
may have another containers using the required ports, but is contained in its own virtual machine.

This script will:
- create a new 'ESCAPEPOD' virtual machine if it does not exist
- start the 'ESCAPEPOD' virtual machine if it is not running already
- set the machine related enviroment variables
- create a 'escapepod' container with all necessary ports exposed
- opens a browser with the virtual machine ip address in url
- prompt you if you want to ssh into the docker virtual machine

## DOCKER-ESCAPEPOD-REMOVE.bat 

This script deletes the 'ESCAPEPOD' virtual machine, and its virtual disks, so you can start over.

## DOCKER-ESCAPEPOD-BASH.bat 

This script SSH you into the 'ESCAPEPOD' virtual machine.
To SSH further into the container itself, call this command:

```
docker exec -it -u root escapepod /bin/bash
```

In case you will need to copy some data to the container use the ```docker cp``` command:
```
docker cp your_dir_or_file escapepod:/home/ubuntu/.
```
This example copies a file named *your_dir_or_file* into the */home/ubuntu/* folder in the container.

## DOCKER-ESCAPEPOD-CMD.bat 

This scripts set's up your enviroment to use the docker related commands for the 'ESCAPEPOD' machine.


### Enjoy!

