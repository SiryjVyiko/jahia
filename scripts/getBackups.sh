#!/bin/bash

USER=$1

ENV_LIST=$(ls -Qm /backups/${USER})

BACKUP_EXCLUDE_LIST=""

OUTPUT_JSON="{\"result\": 0, \"envs\": [${ENV_LIST}], \"backups\": {"

if [ -n "$ENV_LIST" ]; then

    for i in $(ls /backups/${USER})
    do
        FULL_LIST=$(ls /backups/${USER}/${i})
        for backup_dir in ${FULL_LIST}
        do
            FILE_NUMBER=$(find /backups/${USER}/${i}/${backup_dir} -maxdepth 1 -type f|wc -l)
            if [ "${FILE_NUMBER}" -lt 3 ]; then
                BACKUP_EXCLUDE_LIST="${BACKUP_EXCLUDE_LIST} --ignore=${backup_dir}"
            fi 
        done
        DIRECTORY_LIST=$(ls -Qm /backups/${USER}/${i} ${BACKUP_EXCLUDE_LIST})
        OUTPUT_JSON="${OUTPUT_JSON}\"${i}\":[${DIRECTORY_LIST}],"
    done

    OUTPUT_JSON=${OUTPUT_JSON::-1}
fi

echo $OUTPUT_JSON}}
