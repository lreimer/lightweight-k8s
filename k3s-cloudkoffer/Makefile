MASTER_IP = 192.168.178.10
CHANNEL = stable

.PHONY: info

info:
	@echo "K3s Demo on NUC Cloudkoffer"

k3s:
	k3sup install --ip $(MASTER_IP) --user root --k3s-channel $(CHANNEL) --k3s-extra-args '--write-kubeconfig-mode 644 --disable traefik --no-deploy traefik --node-label arch=x86_64' --context cloudkoffer
	@echo ""
	k3sup join --ip 192.168.178.20 --k3s-channel $(CHANNEL) --server-ip $(MASTER_IP) --user root --k3s-extra-args '--node-label arch=x86_64'
	k3sup join --ip 192.168.178.30 --k3s-channel $(CHANNEL) --server-ip $(MASTER_IP) --user root --k3s-extra-args '--node-label arch=x86_64'
	k3sup join --ip 192.168.178.40 --k3s-channel $(CHANNEL) --server-ip $(MASTER_IP) --user root --k3s-extra-args '--node-label arch=x86_64'
	k3sup join --ip 192.168.178.50 --k3s-channel $(CHANNEL) --server-ip $(MASTER_IP) --user root --k3s-extra-args '--node-label arch=x86_64'
	@echo ""
	@echo "export KUBECONFIG=`pwd`/kubeconfig"
	KUBECONFIG=`pwd`/kubeconfig kubectl get nodes
	