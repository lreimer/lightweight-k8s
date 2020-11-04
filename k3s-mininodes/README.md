# K3s Demo on miniNodes Raspberry Pi CoM3

## Mininodes Cluster Installation

This showcase is using a miniNodes Raspberry Pi 3 Computer on Module (CoM) 5-node Carrier Board (https://www.mininodes.com).

For each of the 5 Raspi CoM cards repeat the following steps:
- Donwload the latest Raspberry Pi OS (32-bit) Lite from https://www.raspberrypi.org/downloads/raspberry-pi-os/
- Flash the image to the Raspberry Pi 3 Computer on Module using Edger or similar.
- Create a `ssh` file in the `/boot` partition
- Append `cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory` to the `/boot/cmdline.txt` file.
- Boot the module.

- Copy SSH key via `ssh-copy-id -i ~/.ssh/id_rsa pi@raspberrypi.local`
- Connect via SSH to Raspberry PI via `ssh pi@raspberrypi.local`
- Run `sudo raspi-config` to
  - change the root password
  - change hostname
  - enable predictable network interfaces names
  - expand filesystem
  - change memory split for graphics card to 16MB
- Enable legacy iptables following these instructions https://rancher.com/docs/k3s/latest/en/advanced/#enabling-legacy-iptables-on-raspbian-buster
- Reboot

## K3s Installation using k3sup

```bash
$ k3sup install --ip 192.168.178.5 --k3s-channel stable --k3s-extra-args '--write-kubeconfig-mode 644 --disable traefik --no-deploy traefik --node-label arch=armv7l' --user pi --context mininodes

$ export KUBECONFIG=`pwd`/kubeconfig

# for each of the other nodes
$ k3sup join --ip 192.168.178.6 --k3s-channel stable --server-ip 192.168.178.5 --user pi --k3s-extra-args '--node-label arch=armv7l'
$ k3sup join --ip 192.168.178.7 --k3s-channel stable --server-ip 192.168.178.5 --user pi --k3s-extra-args '--node-label arch=armv7l'
$ k3sup join --ip 192.168.178.8 --k3s-channel stable --server-ip 192.168.178.5 --user pi --k3s-extra-args '--node-label arch=armv7l'
$ k3sup join --ip 192.168.178.9 --k3s-channel stable --server-ip 192.168.178.5 --user pi --k3s-extra-args '--node-label arch=armv7l'
```

## Install Kubernetes Dashboard

```bash
$ arkade install kubernetes-dashboard

# follow the instructions on the console to create admin-user account

$ kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user-token | awk '{print $1}')
$ open http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/login
$ kubectl proxy
```