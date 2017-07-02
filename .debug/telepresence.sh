#!/bin/bash

# uncomment the below if you want to auto start minikube if it's not running

# if minikube isn't running, start it
minikube ip > /dev/null
if [ $? -ne 0 ]; then
  echo "***Launching Minikube***"
  echo "  One time process.  This may take a bit..."
  minikube start
fi

echo "*** running new ***"

pipe=/tmp/telepresence-debug

if [[ ! -p $pipe ]]; then
    echo "telepresenceBackground not running"
    exit 1
fi

echo "run" >$pipe

echo "*** sleeping ***"

sleep 15

echo "*** exiting ***"


#until kubectl logs go-debug | grep "API server listening at:" > /dev/null; do sleep 1; done