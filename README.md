# Lightweight K8s

When it comes to running Kubernetes in resource constraint environments like your local developer workstation or edge and IoT devices a full-blown Kubernetes distribution is definitely not the right choice. Instead a new breed of super lightweight, certified Kubernetes distributions that (often) come as a single-binary are suited a lot better. This repository will showcase two popular choices: MicroK8s and K3s on public cloud and NUC powered Cloudkoffer.

## MicroK8s Demo on GCP

```
$ cd microk8s-gcloud/
$ terraform init

$ terraform plan
$ terraform apply

$ ssh ubuntu@`terraform output master-ip`

$ microk8s.status
$ microk8s.kubectl get all -n kube-system
$ microk8s.enable helm

$ microk8s.kubectl create deployment kubernetes-bootcamp --image=gcr.io/google-samples/kubernetes-bootcamp:v1
$ microk8s.kubectl get pods

$ microk8s.kubectl add-node

$ ssh ubuntu@`terraform output node-ip`
$ microk8s.status
$ microk8s.join <MASTER_URL>
```

## MicroK8s Demo on AWS

```
$ cd microk8s-aws/
$ terraform init

$ terraform plan
$ terraform apply

$ ssh ubuntu@`terraform output master-ip`

$ microk8s.enable dashboard
$ microk8s.kubectl get all -n kube-system

$ microk8s.kubectl create deployment kubernetes-bootcamp --image=gcr.io/google-samples/kubernetes-bootcamp:v1
$ microk8s.kubectl get pods
```

## K3s Demo on GCP

```
$ cd k3s-gcloud/
$ terraform init

$ terraform plan
$ terraform apply

$ export SERVER_IP=`terraform output master-ip`
$ export NODE_IP=`terraform output node-ip`

$ k3sup install --ip $SERVER_IP --user ubuntu --k3s-extra-args '--write-kubeconfig-mode 644'
$ export KUBECONFIG=`pwd`/kubeconfig
$ kubectl get node

$ k3sup join --ip $NODE_IP --server-ip $SERVER_IP --user ubuntu
```

## K3s Demo on NUC Cloudkoffer

The official installation is already pretty straight forward and simple to follow.
Issue the following commands in a terminal on the `k3s-master` NUC. Make sure you
have followed the setup instructions so that you can SSH login to all minion NUCs.

```
$ sudo curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--write-kubeconfig-mode 644" sh -
$ sudo cat /var/lib/rancher/k3s/server/node-token

$ ssh k3s-minion-1
$ sudo curl -sfL https://get.k3s.io | K3S_URL=https://k3s-master:6443 K3S_TOKEN=<NODE_TOKEN> sh -

$ ssh k3s-minion-2
$ sudo curl -sfL https://get.k3s.io | K3S_URL=https://k3s-master:6443 K3S_TOKEN=<NODE_TOKEN> sh -

$ ssh k3s-minion-3
$ sudo curl -sfL https://get.k3s.io | K3S_URL=https://k3s-master:6443 K3S_TOKEN=<NODE_TOKEN> sh -

$ ssh k3s-minion-4
$ sudo curl -sfL https://get.k3s.io | K3S_URL=https://k3s-master:6443 K3S_TOKEN=<NODE_TOKEN> sh -

# To remove K3s use the uninstall script
$ k3s-killall.sh
$ k3s-uninstall.sh

$ k3s-killall.sh
$ k3s-agent-uninstall.sh
```

The second option is to use `k3sup` by Alex Ellis. The installation can be performed remotely,
e.g. from my Mac being directly connected to the Cloudkoffer LAN.

```
$ curl -sLS https://get.k3sup.dev | sh
$ sudo install k3sup /usr/local/bin/
$ k3sup --help

$ export SERVER_IP=192.168.178.10
$ k3sup install --ip $SERVER_IP --user k3s --k3s-extra-args '--write-kubeconfig-mode 644' --local-path ~/.kube/config --merge --context cloudkoffer

$ k3sup join --ip 192.168.178.20 --server-ip $SERVER_IP --user k3s
$ k3sup join --ip 192.168.178.30 --server-ip $SERVER_IP --user k3s
$ k3sup join --ip 192.168.178.40 --server-ip $SERVER_IP --user k3s
$ k3sup join --ip 192.168.178.50 --server-ip $SERVER_IP --user k3s
```

## Maintainer

M.-Leander Reimer (@lreimer), <mario-leander.reimer@qaware.de>

## License

This software is provided under the MIT open source license, read the `LICENSE` file for details.