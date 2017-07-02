# go-minikube-vscode-dev

This repo is a template to get started writing golang applications designed to run in Kubernetes.  It requires that minikube (https://github.com/kubernetes/minikube) is already installed.

### Dependencies

- VSCode/Go Extensions: https://code.visualstudio.com/docs/languages/go
- Delve: https://github.com/derekparker/delve
- Telepresence: http://www.telepresence.io/
- Minikube (Optional): https://kubernetes.io/docs/getting-started-guides/minikube/

### How to use

1. Make sure that kubectl is pointed to the environment you want to debug in.  Uncomment lines in `./debug/task.sh` to have the script auto start minikube if desired.
2. Type some Go
3. In the Terminal window run `.debug/background.sh`.  Your applications output will show up in this window.  You only need to do this once.
  Remove `--log=true` to reduce debugger spam
4. F5
5. Application output will show up in the "Output" tab. 

### How it works

- The "Kubernetes/Telepresence" launch configuration has `deployToTelepresence` setup as a prelaunch task
- `deployToTelepresence` runs `./debug/task.sh`
- `task.sh` writes to a unix pipe
- `background.sh` reads from the pipe and runs telepresence
- The vscode Go extension will connect to localhost on 2345.

### Issues/Improvements

- Windows support
- Try to reduce complexity/remove background.sh
- Find a way to watch stdout of background.sh instead of just `sleep 10`
- Application is unable to see container filesystem