MASTER_IP = 192.168.178.5
CHANNEL = stable

.PHONY: info

info:
	@echo "K3s Demo on miniNodes Raspberry Pi CoM3"

k3s:
	k3sup install --ip $(MASTER_IP) --k3s-channel $(CHANNEL) --k3s-extra-args '--write-kubeconfig-mode 644 --disable traefik --no-deploy traefik --node-label arch=armv7l' --user pi --context mininodes
	@echo ""
	k3sup join --ip 192.168.178.6 --k3s-channel $(CHANNEL) --server-ip $(MASTER_IP) --user pi --k3s-extra-args '--node-label arch=armv7l'
	k3sup join --ip 192.168.178.7 --k3s-channel $(CHANNEL) --server-ip $(MASTER_IP) --user pi --k3s-extra-args '--node-label arch=armv7l'
	k3sup join --ip 192.168.178.8 --k3s-channel $(CHANNEL) --server-ip $(MASTER_IP) --user pi --k3s-extra-args '--node-label arch=armv7l'
	k3sup join --ip 192.168.178.9 --k3s-channel $(CHANNEL) --server-ip $(MASTER_IP) --user pi --k3s-extra-args '--node-label arch=armv7l'
	@echo ""
	@echo "export KUBECONFIG=`pwd`/kubeconfig"
	KUBECONFIG=`pwd`/kubeconfig kubectl get nodes
