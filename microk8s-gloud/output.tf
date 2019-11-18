output "ip" {
    value = "${google_compute_instance.microk8s.network_interface.0.access_config.0.nat_ip}"
}