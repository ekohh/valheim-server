#!/bin/bash

# Options
LOGFILE="/var/log/steam/valheim/vhupdate.log"
STEAMCMD="/home/steam/steamcmd.sh"
VALHEIM_INSTALL_DIR="/home/steam/.steam/steamapps/common/valheim"

# Update
START="$(date +'%m-%d-%Y %H:%M:%S')"
echo "${START} UPDATE: Starting update" >> $LOGFILE 2>&1
su - steam -c "${STEAMCMD} +login anonymous +force_install_dir ${VALHEIM_INSTALL_DIR} +app_update 896660 validate +exit" >> $LOGFILE 2>&1 \
    && echo "UPDATE: Update completed successfully" >> $LOGFILE 2>&1 \
    || echo "UPDATE: Update failed" >> $LOGFILE 2>&1

RESTART="$(date +'%m-%d-%Y %H:%M:%S')"
echo "${RESTART} RESTART: Restarting Valheim service" >> $LOGFILE 2>&1
systemctl restart valheim >> $LOGFILE 2>&1 \
    && echo "RESTART: Restart completed successfully" >> $LOGFILE 2>&1 \
    || echo "RESTART: Restart failed" >> $LOGFILE 2>&1