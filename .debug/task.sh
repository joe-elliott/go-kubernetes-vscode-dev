#!/bin/bash

# uncomment the below if you want to auto start minikube if it's not running

#minikube ip > /dev/null
#if [ $? -ne 0 ]; then
#  echo "***Launching Minikube***"
#  echo "  One time process.  This may take a bit..."
#  minikube start
#fi

echo "*** Writing to Pipe ***"

pipe=.debug/tmp-pipe

if [[ ! -p $pipe ]]; then
    echo "telepresenceBackground not running.  Go to the Terminal and run .debug/background.sh"
    exit 1
fi

echo "run" >$pipe

echo "*** Waiting ***"
echo " Telepresence requires sudo and may be waiting for you to type your password.  Check the terminal."

# read the pipe until background.sh writes "running" to it
line="notrunning"
until [ "$line" == 'running' ]; do read line <$pipe; done

echo "*** Running ***"
echo " Switch to the terminal to see application output."
