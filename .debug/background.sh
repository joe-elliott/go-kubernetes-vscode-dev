#!/bin/bash

# this command assumes it will be run in the root of your project.
#  note the pathing on the location of the runDelve.sh script

pipe=.debug/tmp-pipe
teleout=.debug/tmp-tele.out
k8sdeploy=vscode-go-debug

if [ ! -d ".debug" ]; then
  echo "This script expects to be run in the root directory of the project."
  exit 1
fi

trap "rm -f $pipe" EXIT
trap "kubectl delete deploy $k8sdeploy" EXIT

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

        pkill -f $PWD/debug
        pkill -f "runDelve.sh"

        echo "*** running new ***"

        rm $teleout

        kubectl get deploy $k8sdeploy
        if [ $? -eq 0 ]; then
            telepresence --deployment $k8sdeploy --method=inject-tcp --expose=2345 --run .debug/runDelve.sh | tee /dev/tty > $teleout &
        else
            telepresence --new-deployment $k8sdeploy --method=inject-tcp --expose=2345 --run .debug/runDelve.sh | tee /dev/tty > $teleout &
        fi

        until cat $teleout | grep "API server listening at:" > /dev/null; do sleep 1; done

        echo "*** debugger live ***"

        # tell task.sh that we're ready to go
        echo "running" >$pipe
        sleep 2
    fi
done
