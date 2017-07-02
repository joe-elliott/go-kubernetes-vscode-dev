#!/bin/bash

# this command assumes it will be run in the root of your project.
#  note the pathing on the location of the runDelve.sh script

pipe=/tmp/telepresence-debug

trap "rm -f $pipe" EXIT

if [[ ! -p $pipe ]]; then
    mkfifo $pipe
fi

while true
do
    if read line <$pipe; then
        if [[ "$line" == 'quit' ]]; then
            break
        fi

        echo "*** killing old ***"

        pkill -f telepresence
        pkill -f dlv
        
        echo "*** running new ***"

        telepresence --method=inject-tcp \
                     --expose=2345 \
                     --run .debug/runDelve.sh &

    fi
done

rm -f $pipe