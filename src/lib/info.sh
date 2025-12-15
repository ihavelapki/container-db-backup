hash_bckp() {
    start_time=$(date +%s.%N);
    
    FILEPATH=$1;
    BCKPHASH=""
    
    if [[ -f "${FILEPATH}" ]]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] [INFO] [hash_bckp] choosen the next file: ${FILEPATH}";
        export BCKPHASH=$(md5sum ${FILEPATH} | awk '{print $1}')
    else
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] [ERROR] [hash_bckp] there is no such file: ${FILEPATH}" &>2
#        exit 1
    fi

    end_time=$(date +%s.%N);
    elapsed=$(echo "($end_time - $start_time) * 1000" | bc);
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [INFO] [hash_bckp] spent time is: $elapsed";
} 