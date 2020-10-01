MASTER_IP = 192.168.178.5

.PHONY: info

info:
	@echo "K3s Demo on miniNodes Raspberry Pi CoM3"

k3s:
	k3sup install --ip $(MASTER_IP) --k3s-extra-args '--write-kubeconfig-mode 644 --disable traefik --no-deploy traefik' --user pi --context mininodes
	@echo ""
	k3sup join --ip 192.168.178.6 --server-ip $(MASTER_IP) --user pi
	k3sup join --ip 192.168.178.7 --server-ip $(MASTER_IP) --user pi
	k3sup join --ip 192.168.178.8 --server-ip $(MASTER_IP) --user pi
	k3sup join --ip 192.168.178.9 --server-ip $(MASTER_IP) --user pi
	@echo ""
	@echo "export KUBECONFIG=`pwd`/kubeconfig"
	KUBECONFIG=`pwd`/kubeconfig kubectl get nodes
