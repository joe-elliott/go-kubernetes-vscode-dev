# go-minikube-vscode-dev

This repo is a template to get started writing golang applications designed to run in Kubernetes.  It requires that minikube (https://github.com/kubernetes/minikube) is already installed.

### Dependencies

- VSCode/Go Extensions: https://code.visualstudio.com/docs/languages/go
- Delve: https://github.com/derekparker/delve
- Telepresence: http://www.telepresence.io/
- Minikube (Optional): https://kubernetes.io/docs/getting-started-guides/minikube/

### How to use

1. Make sure that kubectl is pointed to the environment you want to debug in.  Uncomment lines in `./debug/telepresence.sh` to have the script auto start minikube if desired.
2. Type some Go
3. F5
4. Application output will show up in the "Output" tab. 

### How it works

- The "Kubernetes/Telepresence" launch configuration has `deployToTelepresence` setup as a prelaunch task
- `deployToTelepresence` runs `./debug/telepresence.sh`
- Telepresence is magic
- The vscode Go extension will connect to localhost on 2345.

### Issues/Improvements

- Windows support
- Instead of waiting 30 seconds.  Watch stdout in telepresence.sh