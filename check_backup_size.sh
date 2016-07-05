#!/bin/bash

TARSNAP=${TARSNAP:-tarsnap}

cd /etc/backup.d || exit
for f in *; do
    unset DIRS
    unset PRE

    . ./$f

    if [ ${#PRE[@]} -gt 0 ]; then
        for P in ${PRE[@]}; do
            eval $P
        done
    fi

    echo "# Size of $f:"
    du -hs ${DIRS[@]}
    echo ""
done
