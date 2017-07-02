#!/bin/bash

# uncomment the below if you want to auto start minikube if it's not running

#minikube ip > /dev/null
#if [ $? -ne 0 ]; then
#  echo "***Launching Minikube***"
#  echo "  One time process.  This may take a bit..."
#  minikube start
#fi

echo "*** Writing to Pipe ***"

pipe=/tmp/telepresence-debug

if [[ ! -p $pipe ]]; then
    echo "telepresenceBackground not running"
    exit 1
fi

echo "run" >$pipe

echo "*** Waiting ***"

sleep 15

echo "*** Exiting ***"

#until kubectl logs go-debug | grep "API server listening at:" > /dev/null; do sleep 1; done