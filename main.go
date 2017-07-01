package main

import (
	"log"
	"net/http"

	"github.com/golang/glog"
)

func main() {
	glog.Info("Debug Application Staring")

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte("hello debugging world"))
	})

	log.Fatalln(http.ListenAndServe(":8080", nil))
}
