#!/bin/bash

CONN_LOG="/var/log/steam/valheim/valheim_log.txt"
CURR_CONN="$(grep Connections /var/log/steam/valheim/valheim_log.txt | tail -n1 | cut -d' ' -f5)"

echo "Current connections: ${CURR_CONN}"

if [ $CURR_CONN != "0" ]
then
    COUNT=0
    for VIKING in $(grep "ZDOID" /var/log/steam/valheim/valheim_log.txt | cut -d' ' -f7 | tail -n ${CURR_CONN})
        do ONLINE[${COUNT}]=${VIKING} ; VIKINGS=$((${COUNT} + 1)) ; done
    echo "Logged In: ${ONLINE[*]}"
fi