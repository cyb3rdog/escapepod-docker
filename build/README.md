# ESCAPE POD DOCKER IMAGE BUILD SCRIPT

## Prerequisites

### **Before building the EscapePod Docker image, all Escape-Pod related files necessary for this build must be copied into the ```.root_fs/``` sub-directory.**

These files can be obtained and extracted manually either from the official escape pod rpi image, or from your raspberry pi, in case you have it deployed already.
The script ```escapepod-img-mount.sh``` can automatically download and mount the original image to your linux file system, so you should be able to extract all the necessary distribution files.

## FileSystem

There are following 4 directories of the concern, that has to contain the files from the original escapepod image, or your RPI:
Each of those directories contain the ```.files``` file with a short description of what files should be copied into that specific directory

### *.root_fs/usr/local/escapepod*

Whole directory with the all the escapepod binaries, Web UI, and distributed OTA image files
```
/usr/local/escapepod -> .root_fs/usr/local/escapepod
```

### *.root_fs/usr/local/bin*

Selected MongoDB binaries 
```
/usr/bin -> .root_fs/usr/local/bin
```

### *.root_fs/usr/local/aarch64-linux-gnu/lib*

Aarch64 libraries used to run the escapepod and mongo db binaries
(Hey DDL, we're still waiting for the arm64 escapepod binary build, so we can get rid of all this)
```
- /usr/lib                      -> .root_fs/usr/local/aarch64-linux-gnu/lib
- /usr/lib/aarch64-linux-gnu/   -> .root_fs/usr/local/aarch64-linux-gnu/lib
```

### *.root_fs/var/lib/mongodb*

Mongo DB database containing the intents, configuration, licence keys, etc..
```
/var/lib/mongodb -> .root_fs/var/lib/mongodb
```

- In case your will be copying these files from the distribution image, you will create a docker image with 'blank' distribution database,
- For the scenario, where you will extract your files from your already deployed and configured raspberry pi, the result Docker image will be actually clon of your rpi, and will be already set up, with all your custom intents, your licence keys etc.

## Building the Docker Image

Once all the required escape pod files have been copied into the ```.root_fs``` directory, the image can be built with following scripts:

- For Windows - use the ```escapepod-build.bat``` file
- For Linux - use the ```escapepod-build.sh``` file

Both scripts will eventually call the *docker build* command which composes the image from the ```Dockerfile```
```
docker build -t escapepod .
```

Once the image is built, the script will create a new contrainer and start it up:
```
docker run -it --rm --name escapepod -h escapepod -p 80:80 -p 8084:8084 -p 8085:8085 -p 8086:8086 -p 65533:65533 -d escapepod
```

Your dockerized EscapePod will run from the container, so you can access it using the docker virtual machine's ip address, and you can 'ssh' in using following command:
```
docker exec -it -u root escapepod /bin/bash
```

### Enjoy!
