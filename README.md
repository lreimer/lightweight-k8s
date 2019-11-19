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

## Maintainer

M.-Leander Reimer (@lreimer), <mario-leander.reimer@qaware.de>

## License

This software is provided under the MIT open source license, read the `LICENSE` file for details.