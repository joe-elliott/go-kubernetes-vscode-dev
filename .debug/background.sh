#!/bin/bash

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
                     --run bash -c unset DYLD_INSERT_LIBRARIES && dlv debug --listen=0.0.0.0:2345 --headless=true --log=true &

    fi
done

rm -f $pipe