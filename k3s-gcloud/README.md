# K3s Demo on GCP

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