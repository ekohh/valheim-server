#!/bin/bash

####################
# Backup Variables #
####################

# Number of local backups retained
BACKUP_DAYS=25

# Valheim Server Directory
VAL_WORLD_DIR="/home/steam/.config/unity3d/IronGate/Valheim"

# Backup Directory
VAL_BACKUP_DIR="/backup/valheim_worlds"

######################
# Main Backup Script #
######################

# Backup Date
VAL_BACKUP_DATE="$(date +'%m-%d-%Y')"

# Ensure backup directory exists
if [[ ! -d $VAL_BACKUP_DIR ]]
    then
    echo "Backup directory missing, creating now"
    mkdir -pv $VAL_BACKUP_DIR
fi

# Backup Today
CUR_BACKUP_DIR="${VAL_BACKUP_DIR}/${VAL_BACKUP_DATE}"
mkdir -pv $CUR_BACKUP_DIR
tar -cvf ${CUR_BACKUP_DIR}/world-backup-${VAL_BACKUP_DATE}.tgz -C $VAL_WORLD_DIR

# Cleaup old backups if more than 25
CUR_BACKUPS=$(find $VAL_BACKUP_DIR -mindepth 1 -maxdepth 1 -type d | wc -l)
if [[ CUR_BACKUPS -gt 25 ]]
    then
    echo "More than 25 local backups found...removing oldest backups"
    RETAIN=$(($BACKUP_DAYS + 1))
    find $VAL_BACKUP_DIR -mindepth 1 -maxdepth 1 -type d -mtime $RETAIN -exec /bin/rm -rfv {} \;
fi

# Error Handling
exit_status=$?
if [ $exit_status -eq 0 ]; then
  echo "World save file successfully saved at $(date +'%m-%d-%Y %H:%M:%S %Z')"
elif [ $exit_status -ge 1 ]; then
  echo "There was an error with the backup script"
fi