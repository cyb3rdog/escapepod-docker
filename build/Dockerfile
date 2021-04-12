FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get clean -y
RUN apt-get update -y
RUN apt-get install -y qemu-user qemu-user-static gcc-aarch64-linux-gnu binutils-aarch64-linux-gnu binutils-aarch64-linux-gnu-dbg build-essential

COPY .root_fs/ .
RUN chmod 600 /etc/mongod.key

EXPOSE 27017
EXPOSE 80
EXPOSE 8084
EXPOSE 8085
EXPOSE 8086
EXPOSE 65533

WORKDIR /home/ubuntu
CMD /home/ubuntu/start_escape-pod.sh
