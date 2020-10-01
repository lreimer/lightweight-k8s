# K3s on NUC Cloudkoffer

## Cloudkoffer Installation

The case consists of 5 NUCs. All need to be pre-installed with the latest CentOS 7.x linux distribution.
- Download the latest ISO image from https://www.centos.org/download/
- Use Win32 Disk Image (https://sourceforge.net/projects/win32diskimager/) to put the ISO on a USB stick.
- Boot each NUC from the USB stick and perform installation.

Make sure to setup the same root password and admin user account with same password on all machines. This makes the K3s setup on all machines a lot easier later on.

| Node          | IP (static)    | DNS | Gateway | Packages  |
| ------------- |----------------| --- | ------- | --------- |
| k3s-master.cloudkoffer | 192.168.178.10 | 8.8.8.8 | 192.168.178.1 | Server with GUI, Remote Tools and Java |
| k3s-minion-1.cloudkoffer | 192.168.178.20 | 8.8.8.8 | 192.168.178.1 | Computation node with Remote Tools |
| k3s-minion-2.cloudkoffer | 192.168.178.30 | 8.8.8.8 | 192.168.178.1 | Computation node with Remote Tools |
| k3s-minion-3.cloudkoffer | 192.168.178.40 | 8.8.8.8 | 192.168.178.1 | Computation node with Remote Tools |
| k3s-minion-4.cloudkoffer | 192.168.178.50 | 8.8.8.8 | 192.168.178.1 | Computation node with Remote Tools |

Edit the `/etc/hosts` file on each machine, and add the IPs and hostnames of all the Cloudkoffer cluster nodes.
```
192.168.178.10  k3s-master.cloudkoffer k3s-master
192.168.178.20  k3s-minion-1.cloudkoffer k3s-minion-1
192.168.178.30  k3s-minion-2.cloudkoffer k3s-minion-2
192.168.178.40  k3s-minion-2.cloudkoffer k3s-minion-3
192.168.178.50  k3s-minion-4.cloudkoffer k3s-minion-4
```

Enable SSH login without password on all the minions from the master. Create a keypair and copy the SSH ID to all the nodes. Basically, follow the instructions given here: http://www.thegeekstuff.com/2008/11/3-steps-to-perform-ssh-login-without-password-using-ssh-keygen-ssh-copy-id

Disable the firewall (or add appropriate rules).
```sh
systemctl disable firewalld
```
Make sure you have the package `policycoreutils-python` installed. It is required for k3s.

## Official K3s Installation

The official installation is already pretty straight forward and simple to follow: https://rancher.com/docs/k3s/latest/en/quick-start/

Issue the following commands in a terminal on the `k3s-master` NUC. Make sure you have followed the setup instructions so that you can SSH login to all minion NUCs.

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

## K3s Installation using k3sup

The second option is to use `k3sup` by Alex Ellis. The installation can be performed remotely, e.g. from my Mac being directly connected to the Cloudkoffer LAN.

```
$ curl -sLS https://get.k3sup.dev | sh
$ sudo install k3sup /usr/local/bin/
$ k3sup --help

$ export MASTER_IP=192.168.178.10
$ k3sup install --ip $MASTER_IP --user root --k3s-extra-args '--write-kubeconfig-mode 644 --disable traefik --no-deploy traefik' --context cloudkoffer

$ export KUBECONFIG=`pwd`/kubeconfig

$ k3sup join --ip 192.168.178.20 --server-ip $MASTER_IP --user root
$ k3sup join --ip 192.168.178.30 --server-ip $MASTER_IP --user root
$ k3sup join --ip 192.168.178.40 --server-ip $MASTER_IP --user root
$ k3sup join --ip 192.168.178.50 --server-ip $MASTER_IP --user root
```