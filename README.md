# go-kubernetes-vscode-dev

This repo is a template to get started writing golang applications designed to run in Kubernetes.  It requires access to an existing kubernetes cluster.

If you do not have access to a Kubernetes cluster than I'd recommend trying minikube (https://kubernetes.io/docs/setup/minikube/).

### Dependencies

- VSCode/Go Extensions: https://code.visualstudio.com/docs/languages/go
- Telepresence: http://www.telepresence.io/

### How to use

1. Make sure that kubectl is pointed to the environment you want to debug in.  Telepresence will create a deployment in the cluster you are pointed at.  Be aware.
2. Type some Go
3. In the Terminal window run `.debug/debug.sh`.  Your applications output will show up in this window.  You only need to do this once.
4. When you see `API server listening at: [::]:2345` in the terminal window Delve is ready.
5. Smack F5 in VSCode to connect to Delve on port `2345`.
6. After debugging you will be presented with a prompt to either start a new debug session or exit the container.

Alternatively you can run `.debug/debug.sh --manual`.  This will start the Telepresence container and leave you at a command prompt.  From here you can debug Kubernetes networking issues, manage dependencies (`dep`), manually trigger a debug session (`.debug/runDelve.sh`), etc.

### Caveats

- Telepresence mounts the actual container's file system at `$TELEPRESENCE_ROOT`.  Note that `runDelve.sh` copies the service account information from this mounted filesystem into an expected spot in the telepresence container.  There is probably a better solution somewhere, but this works just for simple Kubernetes development.
  - Telepresence's documentation on how to deal with this issue: http://www.telepresence.io/howto/volumes.html.
- The Telepresence `--docker-run` parameter does not provide a way to set the service account.  If you want to access the Kubernetes API you will need to setup the default service account in a way that allows you to make the queries you would like.
- Other documented limitations here:  http://www.telepresence.io/reference/limitations.html

### Previous Iteration

Previously this project used a unix pipe to pass commands back and forth between two different shell scripts.  It was complicated and didn't work sometimes, but it made for a nice UX when it did.  This has been scrapped in favor of the above approach.  If you are interested in the way things used to be done:  

https://github.com/number101010/go-kubernetes-vscode-dev/tree/a296d80d84bf4ff4297b0bffe32dd1b852be7a0c