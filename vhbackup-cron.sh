#!/bin/sh

# Run valheim world backup nightly
5 0 * * * /bin/bash /root/bin/vhbackup.sh >> /var/log/vhbackup.log 2>&1