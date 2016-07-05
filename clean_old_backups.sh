#!/bin/bash

TARSNAP=${TARSNAP:-tarsnap}
numkeep=5

items=( $(ls /etc/backup.d) )
entire_list=( $(${TARSNAP} --list-archives) )
for item in ${items[@]}; do
	list=( $(printf "%s\n" ${entire_list[@]} | grep ${item} | sort) )
    num=${#list[@]}
	num=$(( $num - $numkeep ))
	if [ ${num} -gt 0 ]; then
		del_list=( $(printf "%s\n" ${list[@]} | head -n ${num}) )
		for entry in ${del_list[@]}; do
			echo "Deleting ${entry}"
			${TARSNAP} -d -f "${entry}"
		done
	fi
done

