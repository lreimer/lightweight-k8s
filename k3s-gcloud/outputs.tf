output "master-ip" {
    value = "${google_compute_instance.k3s-master.network_interface.0.access_config.0.nat_ip}"
}

output "node-ip" {
    value = "${google_compute_instance.k3s-node-1.network_interface.0.access_config.0.nat_ip}"
}