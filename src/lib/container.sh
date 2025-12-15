make_bckp() {
    start_time=$(date +%s.%N)

    BCKPDIR="$1";
    CONTAINER="$2";

    if [[ "${CONTAINER}" != "" ]]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] [INFO] [make_bckp] choosen the next container: ${CONTAINER}";
        if [[ "$(docker inspect -f '{{.State.Running}}' ${CONTAINER} 2>/dev/null)" = "true" ]]; then
            echo "[$(date '+%Y-%m-%d %H:%M:%S')] [INFO] [make_bckp] the next container is running: ${CONTAINER}";
            mkdir -p ${BCKPDIR};
            DBNAME="$(docker exec -i ${CONTAINER} printenv | grep POSTGRES_DB | cut -d '=' -f2 2>/dev/null)";
            USERNAME="$(docker exec -i ${CONTAINER} printenv | grep POSTGRES_USER | cut -d '=' -f2 2>/dev/null)";
            docker exec -i ${CONTAINER} pg_dump --dbname=${DBNAME} --username=${USERNAME} -F p -f /tmp/backup.sql 2>/dev/null;
            docker cp ${CONTAINER}:/tmp/backup.sql ${BCKPDIR}/${CONTAINER}-dump.sql 2>/dev/null;
            echo "[$(date '+%Y-%m-%d %H:%M:%S')] [INFO] [make_bckp] backup has been made for: ${CONTAINER}";

            xz ${BCKPDIR}/${CONTAINER}-dump.sql

            echo "[$(date '+%Y-%m-%d %H:%M:%S')] [INFO] [make_bckp] backup has been compressed";
        else
            echo "[$(date '+%Y-%m-%d %H:%M:%S')] [ERROR] [make_bckp] the next container is not running: ${CONTAINER}" &>2;
#            exit 1
        fi
    else
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] [ERROR] [make_bckp] container name is empty" &>2;
#        exit 1
    fi

    end_time=$(date +%s.%N);
    elapsed=$(echo "($end_time - $start_time) * 1000" | bc);
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [INFO] [make_bckp] spent time is: $elapsed";
}

get_cnt_name() {
    start_time=$(date +%s.%N);
    
    CONTAINERDIR="$1";
    
    if [[ -d "${CONTAINERDIR}" ]]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] [INFO] [get_cnt_name] choosen the next dir: ${CONTAINERDIR}";
        if [[ -f "${CONTAINERDIR}/docker-compose.yml" ]]; then
            NAME=$(grep -E 'container_name: *"?[^"]*db"?' ${CONTAINERDIR}/docker-compose.yml | cut -d ":" -f2 | cut -d " " -f2 2>/dev/null);
            echo "[$(date '+%Y-%m-%d %H:%M:%S')] [INFO] [get_cnt_name] container name is: ${NAME}";
        else
            echo "[$(date '+%Y-%m-%d %H:%M:%S')] [ERROR] [get_cnt_name] there is no such file: ${CONTAINERDIR}/docker-compose.yml" &>2
#            exit 1
        fi
    else
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] [ERROR] [get_cnt_name] there is no such directory: ${CONTAINERDIR}" &>2
#        exit 1
    fi

    export CNTNAME=${NAME};

    end_time=$(date +%s.%N);
    elapsed=$(echo "($end_time - $start_time) * 1000" | bc);
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [INFO] [get_cnt_name] spent time is: $elapsed";
}