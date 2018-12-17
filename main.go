package main

import (
	"os"

	logging "github.com/op/go-logging"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"

	"k8s.io/client-go/kubernetes"
	"k8s.io/client-go/rest"
)

var (
	_log       = logging.MustGetLogger("prometheus-autoscaler")
	_logFormat = logging.MustStringFormatter(
		`%{time:15:04:05.000} %{level:.4s} %{message}`,
	)
)

func init() {
	backend := logging.NewLogBackend(os.Stdout, "", 0)
	backendFormatted := logging.NewBackendFormatter(backend, _logFormat)

	logging.SetBackend(backendFormatted)
}

func main() {
	_log.Infof("Application Starting")

	// creates the in-cluster config
	config, err := rest.InClusterConfig()
	if err != nil {
		_log.Fatalf("rest.InClusterConfig failed: %v", err)
	}
	// creates the clientset
	clientset, err := kubernetes.NewForConfig(config)
	if err != nil {
		_log.Fatalf("kubernetes.NewForConfig failed: %v", err)
	}

	pods, err := clientset.CoreV1().Pods("").List(metav1.ListOptions{})
	if err != nil {
		_log.Fatalf("list pods failed: %v", err)
	}

	_log.Infof("There are %d pods in the cluster", len(pods.Items))
}
