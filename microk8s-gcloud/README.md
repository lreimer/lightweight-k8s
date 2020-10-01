# MicroK8s Demo on GCP

```
$ cd microk8s-gcloud/
$ terraform init

$ terraform plan
$ terraform apply

$ ssh ubuntu@`terraform output master-ip`

$ microk8s.status
$ microk8s.kubectl get all -n kube-system
$ microk8s.enable --help
$ microk8s.enable helm

$ microk8s.kubectl create deployment kubernetes-bootcamp --image=gcr.io/google-samples/kubernetes-bootcamp:v1
$ microk8s.kubectl get pods

$ microk8s.add-node

$ ssh ubuntu@`terraform output node-ip`
$ microk8s.status
$ microk8s.join <MASTER_URL>
```
