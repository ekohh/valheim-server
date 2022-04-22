#!/bin/bash

# AWS CLI
AWS_CLI="/usr/local/bin/aws"

# Backups to sync
BUP_SRC="/backup/valheim_worlds"

# Destination s3 bucket
BUP_BUCKET="vhbackups"

# Backup
echo "$(date +'%m-%d-%Y %H:%M:%S'): Started syncing backups to s3 bucket $BUP_BUCKET"

$AWS_CLI s3 sync "${BUP_SRC}/" "s3://${BUP_BUCKET}/"
STATUS=$?

if [[ $STATUS -eq 0 ]];
  then
    echo "$(date +'%m-%d-%Y %H:%M:%S'): Completed syncing backups to s3 bucket $BUP_BUCKET"
  else
    echo "$(date +'%m-%d-%Y %H:%M:%S'): Failed syncing backups to s3 bucket $BUP_BUCKET"
fi