#!/bin/bash

# uncomment the below if you want to auto start minikube if it's not running

# if minikube isn't running, start it
minikube ip > /dev/null
if [ $? -ne 0 ]; then
  echo "***Launching Minikube***"
  echo "  One time process.  This may take a bit..."
  minikube start
fi

telepresence --method=inject-tcp \
             --expose=2345 \
             --new-deployment go-debug-telepresence \
             --run bash -c unset DYLD_INSERT_LIBRARIES && dlv debug --listen=0.0.0.0:2345 --headless=true --log=true &

sleep 30

#until kubectl logs go-debug | grep "API server listening at:" > /dev/null; do sleep 1; done