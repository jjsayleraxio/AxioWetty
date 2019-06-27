#!/bin/bash

groupadd users

useradd wetty -d /home/wetty -g 100 -u 1001 -m -s /bin/bash -G users
echo "wetty:change" | chpasswd
