#!/bin/bash

set -e
source /usr/local/lib/container-db-backup/info.sh
source /usr/local/lib/container-db-backup/container.sh

DT=$(date '+%Y%m%d-%H%M')
BASES=("keycloak" "db")
BASEDIR=/opt/kek/
BCKPDIR=/opt/kek/archive/backup/${DT}


mkdir -p ${BCKPDIR}
touch ${BCKPDIR}/README.md 

for base in "${BASES[@]}"; do
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] [INFO] [backup.sh] folder name: $base"
  
  get_cnt_name "${BASEDIR}/${base}"
  
  make_bckp ${BCKPDIR} ${CNTNAME} 

  hash_bckp "${BCKPDIR}/${CNTNAME}-dump.sql.xz"

  echo "${CNTNAME}|${BCKPHASH}" >> ${BCKPDIR}/README.md  
done

tar -cf ${BCKPDIR}/backup.tar ${BCKPDIR}/*-dump.sql.xz 2>/dev/null
TOTALHASH=$(md5sum ${BCKPDIR}/backup.tar | awk '{print $1}')
echo "TOTAL_BACKUP_HASH|${TOTALHASH}" >> ${BCKPDIR}/README.md

mv ${BCKPDIR}/backup.tar ${BCKPDIR}/${DT}-${TOTALHASH}.tar

echo "[$(date '+%Y-%m-%d %H:%M:%S')] [INFO] [backup.sh] backup name: ${DT}-${TOTALHASH}.tar"