#!/bin/bash

set -o nounset
set -o pipefail

LAST_SCAN_LOG_FILENAME='/var/log/clamav/lastscan.log'
LAST_DETECTION_FILENAME='/var/log/clamav/last_detection'

# scan the entire system and write to the log
clamscan --infected --log=${LAST_SCAN_LOG_FILENAME} --recursive --exclude-dir=/dev --exclude-dir=/sys --exclude-dir=/proc /

# if any infections are found, touch the detection file
if ! grep -q "^Infected files: 0$" ${LAST_SCAN_LOG_FILENAME}
then
    touch ${LAST_DETECTION_FILENAME}
fi
