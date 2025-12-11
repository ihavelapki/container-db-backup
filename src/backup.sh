#!/bin/bash

set -e
source /usr/local/lib/testrctl/backup/lib/info.sh
source /usr/local/lib/testrctl/backup/lib/container.sh

DT=$(date '+%Y%m%d-%H%M')
BASES=("orchestrator" "keycloak" "db")
BASEDIR=/opt/rtl/platform
BCKPDIR=/opt/rtl/archive/backup/${DT}

for base in "${BASES[@]}"; do
  echo "[backup.sh] folder name: $base"
  get_cnt_name "${BASEDIR}/${base}"
  echo "[backup.sh] container name: ${CNTNAME}"


  echo "[backup.sh] start backup ---------------------------------------"
  make_bckp ${BCKPDIR} ${CNTNAME} 
  echo "[backup.sh] end ------------------------------------------------"


  hash_bckp "${BCKPDIR}/${CNTNAME}-dump.sql"

  echo "${CNTNAME}|{$BCKPHASH}" >> ${BCKPDIR}/README.md  
done