#!/bin/bash

ERR_MSG="FTP user is not set"

USER=${1?$ERR_MSG}

ENV_LIST=$(ls -Qm /backups/${USER} 2>/dev/null)

BACKUP_EXCLUDE_LIST=""

BACKUP_FILES_NUMBER="3"

OUTPUT_JSON="{\"result\": 0, \"envs\": [${ENV_LIST}], \"backups\": {"

if [ -n "$ENV_LIST" ]; then

    for i in $(ls /backups/${USER} 2>/dev/null)
    do
        FULL_LIST=$(ls /backups/${USER}/${i}) 2>/dev/null
        for backup_dir in ${FULL_LIST}
        do
            FILE_NUMBER=$(find /backups/${USER}/${i}/${backup_dir} -maxdepth 1 -type f|wc -l)
            if [ "${FILE_NUMBER}" -lt "${BACKUP_FILES_NUMBER}" ]; then
                BACKUP_EXCLUDE_LIST="${BACKUP_EXCLUDE_LIST} --ignore=${backup_dir}"
            fi 
        done
        DIRECTORY_LIST=$(ls -Qm /backups/${USER}/${i} ${BACKUP_EXCLUDE_LIST} 2>/dev/null)
        OUTPUT_JSON="${OUTPUT_JSON}\"${i}\":[${DIRECTORY_LIST}],"
    done

    OUTPUT_JSON=${OUTPUT_JSON::-1}
fi

echo $OUTPUT_JSON}}
