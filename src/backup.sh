#!/bin/bash

set -e
source /usr/local/lib/testrctl/backup/lib/info.sh
source /usr/local/lib/testrctl/backup/lib/container.sh

DT=$(date '+%Y%m%d-%H%M')
BASES=("orchestrator" "keycloak" "db")
BASEDIR=/opt/rtl/platform
BCKPDIR=/opt/rtl/archive/backup/${DT}
mkdir -p ${BCKPDIR}
touch ${BCKPDIR}/README.md 

for base in "${BASES[@]}"; do
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] [INFO] [backup.sh] folder name: $base"
  
  get_cnt_name "${BASEDIR}/${base}"
  
  make_bckp ${BCKPDIR} ${CNTNAME} 

  hash_bckp "${BCKPDIR}/${CNTNAME}-dump.sql"

  echo "${CNTNAME}|${BCKPHASH}" >> ${BCKPDIR}/README.md  
done

tar -cf ${BCKPDIR}/backup.tar ${BCKPDIR}/*-dump.sql 2>/dev/null
TOTALHASH=$(md5sum ${BCKPDIR}/backup.tar | awk '{print $1}')
echo "TOTAL_BACKUP_HASH|${TOTALHASH}" >> ${BCKPDIR}/README.md

mv ${BCKPDIR}/backup.tar ${BCKPDIR}/${DT}-${TOTALHASH}.tar

echo "[$(date '+%Y-%m-%d %H:%M:%S')] [INFO] [backup.sh] backup name: ${DT}-${TOTALHASH}.tar"