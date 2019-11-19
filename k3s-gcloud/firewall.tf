resource "google_compute_firewall" "k3s-https" {
    name    = "k3s-https"
    network = "${data.google_compute_network.default.name}"

    allow {
        protocol = "tcp"
        ports    = ["443", "6443"]
    }
}

resource "google_compute_firewall" "k3s-http" {
    name    = "k3s-http"
    network = "${data.google_compute_network.default.name}"

    allow {
        protocol = "tcp"
        ports    = ["80"]
    }
}

data "google_compute_network" "default" {
    name = "default"
}