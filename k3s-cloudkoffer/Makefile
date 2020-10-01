MASTER_IP = 192.168.178.10

.PHONY: info

info:
	@echo "K3s Demo on NUC Cloudkoffer"

k3s:
	k3sup install --ip $(MASTER_IP) --user root --k3s-extra-args '--write-kubeconfig-mode 644 --disable traefik --no-deploy traefik' --context cloudkoffer
	@echo ""
	k3sup join --ip 192.168.178.20 --server-ip $(MASTER_IP) --user root
	k3sup join --ip 192.168.178.30 --server-ip $(MASTER_IP) --user root
	k3sup join --ip 192.168.178.40 --server-ip $(MASTER_IP) --user root
	k3sup join --ip 192.168.178.50 --server-ip $(MASTER_IP) --user root
	@echo ""
	@echo "export KUBECONFIG=`pwd`/kubeconfig"
	KUBECONFIG=`pwd`/kubeconfig kubectl get nodes
	