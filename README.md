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

### Caveats

Using telepresence this project does a really good job of mimicing the in-cluster environment.  The one exception to this rule is that you app will not have access to the in container file system.  For instance, if you attempt to use the kubernetes go client you will receive the following error:

`open /var/run/secrets/kubernetes.io/serviceaccount/token: no such file or directory`

Options:
- Do something like this project: https://github.com/number101010/go-minikube-vscode-dev.  It's way slower and bug prone but it literally runs your application in the cluster.
- In the case of the go client I was able to `docker cp` the `/var/run/secrets` directory to my local machine and use it.  Gorpy but functional.  Do what you will.