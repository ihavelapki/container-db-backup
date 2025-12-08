make_backup_container() {
    start_time=$(date +%s.%N)

    CONTAINER=$1 && echo ${CONTAINER}
    CURRDATE=$(date +%Y%m%d)
    CURRTIME=$(date +%H%M)
    if [[ "${CONTAINER}" != "" ]]; then
        RESP=$(docker container ls --filter "status=running" | grep -o ${CONTAINER})
        if [[ "${RESP}" == "${CONTAINER}" ]]; then
            BCKPDIR=/opt/rtl/archive/backup/${CURRDATE}/${CONTAINER}
            mkdir -p ${BCKPDIR}
            DBNAME=$(docker exec -i ${CONTAINER} printenv | grep POSTGRES_DB | cut -d '=' -f2)
            USERNAME=$$(docker exec -i ${CONTAINER} printenv | grep POSTGRES_USER | cut -d '=' -f2)
        else
            echo "container ${CONTAINER} is not running" &>2
            exit 1
        fi
        echo "container name is empty" &>2
        exit 1
    fi
    docker exec -it ${CONTAINER} pg_dump --dbname=${DBNAME} --username=${USERNAME} -F p -f /tmp/backup.sql
    docker cp ${CONTAINER}:/tmp/backup.sql ${BCKPDIR}/${CURRDATE}-${CURRTIME}-dump.sql
    echo "backup db for ${CONTAINER} has been made"

    end_time=$(date +%s.%N)
    elapsed=$(echo "($end_time - $start_time) * 1000" | bc)
    echo "spent time is: $elapsed"
}

get_container_name() {
    start_time=$(date +%s.%N)

    CONTAINERDIR=$1 && echo ${CONTAINERDIR}
    CURRDATE=$(date +%Y%m%d)
    CURRTIME=$(date +%H%M)
    if [[ -d "${CONTAINERDIR}" ]]; then
        if [[ -f "${CONTAINERDIR}/docker-compose.yml" ]]; then
            NAME=$(cat ${CONTAINERDIR}/docker-compose.yml | grep -w -E "container_name: *[A-Za-z0-9._-]*db$" | cut -d ":" -f2 | cut -d " " -f2)

        else
            echo ""
            exit 1
        fi
        echo "" &>2
        exit 1
    fi
    end_time=$(date +%s.%N)
    elapsed=$(echo "($end_time - $start_time) * 1000" | bc)
    echo "spent time is: $elapsed"
}