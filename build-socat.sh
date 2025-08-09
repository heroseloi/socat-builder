#!/bin/bash
cd /tmp/socat-1.7.3.2
./configure LDFLAGS="-static" CFLAGS="-O2"
make
