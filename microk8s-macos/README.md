# Running MicroK8s on MacOS

```bash
# install multipass from https://multipass.run
$ brew install ubuntu/microk8s/microk8s

$ microk8s install
$ microk8s --help

$ microk8s start
$ microk8s status --wait-ready 
$ microk8s enable ingress

$ microk8s kubectl get all --all-namespaces
$ microk8s config > kubeconfig
$ export KUBECONFIG=`pwd`/kubeconfig
$ kubectl get all --all-namespaces

$ kubectl create deployment hello-node --image=k8s.gcr.io/echoserver:1.4

$ microk8s stop
```
