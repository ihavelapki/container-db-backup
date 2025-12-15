# container-db-backup




 systemctl list-timers

 sudo systemctl daemon-reload




```
Dec 09 16:00:05 builder systemd[1]: Starting rtlbackup.service - rtl backup service...
Dec 09 16:00:05 builder backup.sh[4439]: orchestrator
Dec 09 16:00:05 builder backup.sh[4439]: /opt/rtl/platform/orchestrator
Dec 09 16:00:05 builder backup.sh[4439]: rtl-platform-orchestrator-db-kek
Dec 09 16:00:05 builder backup.sh[4439]: [backup.sh] container name: rtl-platform-orchestrator-dbEOR
Dec 09 16:00:10 builder backup.sh[4439]: start backup ---------------------------------------
Dec 09 16:00:10 builder backup.sh[4439]: [make backup] rtl-platform-orchestrator-db-test
Dec 09 16:00:10 builder backup.sh[4439]: [make backup] container name: rtl-platform-orchestrator-db
Dec 09 16:00:11 builder backup.sh[4439]: [make backup] container rtl-platform-orchestrator-db is running
Dec 09 16:00:12 builder backup.sh[4439]: backup db for rtl-platform-orchestrator-db has been made
Dec 09 16:00:12 builder backup.sh[4439]: 0
Dec 09 16:00:12 builder backup.sh[4439]: end ------------------------------------------------
Dec 09 16:00:12 builder backup.sh[4439]: keycloak
Dec 09 16:00:12 builder backup.sh[4439]: /opt/rtl/platform/keycloak
Dec 09 16:00:12 builder backup.sh[4439]: rtl-platform-keycloak-db-kek
Dec 09 16:00:12 builder backup.sh[4439]: [backup.sh] container name: rtl-platform-keycloak-dbEOR
Dec 09 16:00:17 builder backup.sh[4439]: start backup ---------------------------------------
Dec 09 16:00:17 builder backup.sh[4439]: [make backup] rtl-platform-keycloak-db-test
Dec 09 16:00:17 builder backup.sh[4439]: [make backup] container name: rtl-platform-keycloak-db
Dec 09 16:00:17 builder backup.sh[4439]: [make backup] container rtl-platform-keycloak-db is running
Dec 09 16:00:18 builder backup.sh[4439]: backup db for rtl-platform-keycloak-db has been made
Dec 09 16:00:18 builder backup.sh[4439]: 0
Dec 09 16:00:18 builder backup.sh[4439]: end ------------------------------------------------
Dec 09 16:00:18 builder backup.sh[4439]: db
Dec 09 16:00:18 builder backup.sh[4439]: /opt/rtl/platform/db
Dec 09 16:00:18 builder backup.sh[4439]: rtl-platform-db-kek
Dec 09 16:00:18 builder backup.sh[4439]: [backup.sh] container name: rtl-platform-dbEOR
Dec 09 16:00:23 builder backup.sh[4439]: start backup ---------------------------------------
Dec 09 16:00:23 builder backup.sh[4439]: [make backup] rtl-platform-db-test
Dec 09 16:00:23 builder backup.sh[4439]: [make backup] container name: rtl-platform-db
Dec 09 16:00:23 builder backup.sh[4439]: [make backup] container rtl-platform-db is running
Dec 09 16:00:24 builder backup.sh[4439]: backup db for rtl-platform-db has been made
Dec 09 16:00:24 builder backup.sh[4439]: 0
Dec 09 16:00:24 builder backup.sh[4439]: end ------------------------------------------------
Dec 09 16:00:24 builder systemd[1]: rtlbackup.service: Deactivated successfully.
Dec 09 16:00:24 builder systemd[1]: Finished rtlbackup.service - rtl backup service.
```