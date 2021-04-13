# VECTOR's ESCAPE-POD [DOCKER IMAGE](https://hub.docker.com/r/cyb3rdog/escapepod)

Unofficial Docker image wrapping the Escape Pod for Anki/DDL Vector Robot.
Escape Pod allows your favorite robot companion to function independent of DDL cloud servers while also enabling the customization of voice commands and improving response times.

## Docker Hub repository:
#### **[https://hub.docker.com/r/cyb3rdog/escapepod](https://hub.docker.com/r/cyb3rdog/escapepod)**

## Getting Started

These instructions will cover usage information of this docker image

### Prerequisites

In order to run this container you'll need to have **docker** installed.

* [Windows](https://docs.docker.com/windows/started)
* [OS X](https://docs.docker.com/mac/started/)
* [Linux](https://docs.docker.com/linux/started/)

## Usage

The easiest way to run the docker container, is to execute following docker command:

```shell
docker run -it --rm --name escapepod -h escapepod -p 80:80 -p 8084:8084 -p 8085:8085 -p 8086:8086 -p 65533:65533 -d cyb3rdog/escapepod:latest
```

This command will download the image and start the container with the Vector's EscapePod forwarded to port 80 of your virtual machine.
Once this command is finished, the EscapePod should be fully online within next 5 seconds.


### EscapePod IP address 

**Depending on the type of your setup, you will most likelly need to configure your docker's virtual machine network adapter mode to 'bridged' so that the virtual machine will in fact get its ip adress directly from your router, and all devices on your local network including Vector will be able to connect to it.**
The default setting for docker vm adapters is a subnet with the host the virtual machine runs from, so in that scenario, your other devices in your local area network and your vector will be unable to reach it.

1) To check the IP address of your docker virtual machine, you'll need to know the machine name (ie. 'default')

```shell
docker-machine active
```

2) Use the retieved machine_name to query the IP address, by replacing the \<machine_name\> with the actual name in following command:

```shell
docker-machine ip <machine_name>
```

3) After that, most prefferably, let your local pc know about the EscapePod's IP address, by changing the ***hosts*** file:
Open the hosts file in your favorite text editor:
* Windows: *c:\Windows\System32\drivers\etc\hosts* (make sure your file does not have read-only, and system attributes)
* Linux: */etc/hosts*

Add the following record into the hosts file, where instead of 0.0.0.0 below, enter your EscapePod IP address from step 2.

```shell
0.0.0.0 escapepod.local
```

Save the file.

4) Finally, use either this IP address, or directly the 'escapepod.local' address in the url address bar of your web browser:

```shell
http://<ip_address>:80/
or
http://escapepod.local/
```

### Container Parameters

List of the parameters available to the container

... nothing here so far ...


### Environment Variables

* `PORT` - escapepod web ui port exposed from within the container (default 80)

## Authors

* **cyb3rdog** - (https://github.com/cyb3rdog)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.


