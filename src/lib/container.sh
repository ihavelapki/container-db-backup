make_backup_container() {
    start_time=$(date +%s.%N)

    CONTAINER="$1";
    echo "[make backup] ${CONTAINER}-test";
    CURRDATE=$(date +%Y%m%d);
    CURRTIME=$(date +%H%M);
    BCKPDIR=/opt/rtl/archive/backup/${CURRDATE}/${CONTAINER};

    if [[ "${CONTAINER}" != "" ]]; then
        echo "[make backup] container name: ${CONTAINER}";
        if [[ "$(docker inspect -f '{{.State.Running}}' ${CONTAINER} 2>/dev/null)" = "true" ]]; then
            echo "[make backup] container ${CONTAINER} is running";
            mkdir -p ${BCKPDIR};
            DBNAME="$(docker exec -i ${CONTAINER} printenv | grep POSTGRES_DB | cut -d '=' -f2 2>/dev/null)";
            USERNAME="$(docker exec -i ${CONTAINER} printenv | grep POSTGRES_USER | cut -d '=' -f2 2>/dev/null)";
            docker exec -i ${CONTAINER} pg_dump --dbname=${DBNAME} --username=${USERNAME} -F p -f /tmp/backup.sql 2>/dev/null;
            docker cp ${CONTAINER}:/tmp/backup.sql ${BCKPDIR}/${CURRDATE}-${CURRTIME}-dump.sql 2>/dev/null;
            echo "backup db for ${CONTAINER} has been made";
        else
            echo "container ${CONTAINER} is not running";
#            exit 1
        fi
    else
        echo "container name is empty";
#        exit 1
    fi

    end_time=$(date +%s.%N);
    elapsed=$(echo "($end_time - $start_time) * 1000" | bc);
    echo "spent time is: $elapsed";
}

get_container_name() {
    # start_time=$(date +%s.%N);

    CONTAINERDIR="$1";
    CURRDATE=$(date +%Y%m%d);
    CURRTIME=$(date +%H%M);
    if [[ -d "${CONTAINERDIR}" ]]; then
        echo "${CONTAINERDIR}";
        if [[ -f "${CONTAINERDIR}/docker-compose.yml" ]]; then
#	    echo "${CONTAINERDIR}/docker-compose.yml"
#	    cat ${CONTAINERDIR}/docker-compose.yml
#	    echo "check container name"
            NAME=$(grep -E 'container_name: *"?[^"]*db"?' ${CONTAINERDIR}/docker-compose.yml | cut -d ":" -f2 | cut -d " " -f2 2>/dev/null);
            echo "${NAME}-kek";
        else
            echo "keka";
#            echo "kek" &>2
#            exit 1
        fi
    else
        echo "lola";
#        echo "lol" &>2
#        exit 1
    fi

    export CNTNAME=${NAME};

    # end_time=$(date +%s.%N);
    # elapsed=$(echo "($end_time - $start_time) * 1000" | bc);
    # echo "spent time is: $elapsed";
}