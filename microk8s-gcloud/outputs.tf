output "master-ip" {
    value = google_compute_instance.microk8s-master.network_interface.0.access_config.0.nat_ip
}

output "node-ip" {
    value = google_compute_instance.microk8s-node.network_interface.0.access_config.0.nat_ip
}