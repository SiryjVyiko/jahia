#!/bin/bash

USER=$1
ENVIRONMENT=$2
BACKUP=$3

if [ -f /backups/${USER}/${ENVIRONMENT}/${BACKUP}/variables/jahia_version ]; 
then 
    JAHIA_VERSION=$(cat /backups/${USER}/${ENVIRONMENT}/${BACKUP}/variables/jahia_version )
else
    JAHIA_VERSION="7.2.1.1"
fi

OUTPUT_JSON="{\"result\": 0, \"version\": $JAHIA_VERSION }"

echo $OUTPUT_JSON
