#!/bin/bash

K8S_SA_PATH=/var/run/secrets/kubernetes.io/serviceaccount

mkdir -p $K8S_SA_PATH
cp $TELEPRESENCE_ROOT$K8S_SA_PATH/* $K8S_SA_PATH

dlv debug --listen=0.0.0.0:2345 --headless=true --api-version 2