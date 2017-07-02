#!/bin/bash

# this command assumes it will be run in the root of your project.
#  note the pathing on the location of the runDelve.sh script

pipe=.debug/telepresence-debug
teleout=.debug/tele.out

trap "rm -f $pipe" EXIT

if [[ ! -p $pipe ]]; then
    mkfifo $pipe
fi

echo "*** Pipe open press F5 to debug ***"

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

        rm $teleout
        telepresence --method=inject-tcp --expose=2345 --run .debug/runDelve.sh | tee /dev/tty > $teleout &

        until cat $teleout | grep "API server listening at:" > /dev/null; do sleep 1; done

        echo "*** debugger live ***"
    fi
done

rm -f $pipe