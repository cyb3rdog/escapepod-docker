#!/bin/bash

export $(cat /etc/escape-pod.conf | xargs)
qemu-aarch64 -L /usr/local/aarch64-linux-gnu /usr/local/escapepod/bin/escape-pod