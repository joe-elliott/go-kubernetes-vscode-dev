package main

import (
	"os"

	"github.com/golang/glog"

	"k8s.io/client-go/kubernetes"
	"k8s.io/client-go/rest"
)

func main() {
	glog.Info("Debug Application Staring")

	// creates the in-cluster config
	config, err := rest.InClusterConfig()
	if err != nil {
		glog.Fatal("rest.InClusterConfig failed: ", err)
		os.Exit(1)
	}
	// creates the clientset
	clientset, err := kubernetes.NewForConfig(config)
	if err != nil {
		glog.Fatal("kubernetes.NewForConfig failed: ", err)
		os.Exit(1)
	}

	glog.Info("clientset: ", clientset)
}
