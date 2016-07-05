#!/bin/bash

TARSNAP=${TARSNAP:-tarsnap}

d=$(date +%Y%m%d)

cd /etc/backup.d

for f in *; do
    unset DIRS
    unset PRE

    . ./$f

    if [ ${#PRE[@]} -gt 0 ]; then
        for P in ${PRE[@]}; do
            eval $P
        done
    fi

    echo "$(date '+%F %r') Starting backup for $f: $(eval echo \$$v)"
    ${TARSNAP} -c -f ${f}-${d} ${DIRS[@]}
    echo "$(date '+%F %r') Back complete for $f"
    echo ""
done
