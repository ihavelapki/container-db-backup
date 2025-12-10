#!/bin/bash

set -e
source /usr/local/lib/testrctl/backup/lib/container.sh

BASES=("orchestrator" "keycloak" "db")

for base in "${BASES[@]}"; do
  echo $base
  get_container_name "/opt/rtl/platform/${base}"
  echo "[backup.sh] container name: ${CNTNAME}EOR"
  sleep 5s
  echo "start backup ---------------------------------------"
  make_backup_container "${CNTNAME}" 
  echo "end ------------------------------------------------"

done