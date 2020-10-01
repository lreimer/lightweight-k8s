# MicroK8s Demo on AWS

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