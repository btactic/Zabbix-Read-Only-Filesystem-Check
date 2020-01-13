#!/bin/bash

# Author: Joshua Cagle
# Organization: The University of Oregon

# This script checks for filesystems that are read only. This will
# be used in conjuction with the Zabbix monitoring and alerting system.
# If the script returns 0 then the filesystem in read only mode.
# This script uses a non-exhaustive case statment of potential mount paths,
# yet they are common in our environment.

# In order to use this a Zabbix configuration fragment will have to be made.
# It should look like this:
# UserParameter=checkro[*],/etc/zabbix/scripts/checkro.sh $1
mountPoint=$1

# Ensures that one parameter is used while using script.
[ "$#" -eq 1 ] || { echo "usage: checkro.sh <mountPoint> "; exit 1; }

# Checks /proc/mounts for regular expressions that match mounted filesystems.
# Then checks to see if found string has read/write (rw) enabled. If read/write
# is enabled then the script returns a 1, if not it returns a 0. I will create
# an item and trigger in Zabbix to trigger on a 0.
if grep -E '^.*\s'"${mountPoint}"'\s' /proc/mounts | grep -E '\srw' > /dev/null
        then
            	echo 1
        else
            	echo 0
fi


