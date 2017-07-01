#!/bin/bash

# if minikube isn't running, start it
minikube ip > /dev/null
if [ $? -ne 0 ]; then
  echo "***Launching Minikube***"
  echo "  One time process.  This may take a bit..."
  minikube start
fi

# build application
echo "***Building Go Application***"
#export GO=CGO_ENABLED=0 
#export GOOS=linux 
#export GOARCH=amd64
#go build -o main main.go 

# sets the docker env to point at minikube so the images we build will be available in minikube
echo "***Configuring Docker to Use Minikube***"
eval $(minikube docker-env)

# build the debug image
echo "***Building Image***"
docker build . -t go-app:debug -f ./.debug/debug.Dockerfile

# delete old stuff
echo "***Cleaning Up Old Service/Pod***"
kubectl delete po go-debug --ignore-not-found=true
kubectl delete svc go-debug-svc --ignore-not-found=true

#wait for stuff to be deleted
while kubectl get po go-debug > /dev/null; do :; done
while kubectl get svc go-debug-svc > /dev/null; do :; done

# make the new stuff
echo "***Installing New Service/Pod***"
kubectl create -f ./.debug/debug.podspec.yml

# display to the user the endpoints to put in launch.json

echo "***Printing Port Info***"
echo " - 30080 is mapped to 8080 in your container and is useful only if your application provides a service on a port.  Adjust the podspec as necessary to expose other ports or hide this one."
echo " - 32345 is necessary for vscode to connect to the dlv debugger.  You may need to adjust the IP in launch.json if the below doesn't match."

minikube service go-debug-svc --url

echo "***Waiting for Build to Finish***"

until kubectl logs go-debug | grep "API server listening at:" > /dev/null; do sleep 1; done