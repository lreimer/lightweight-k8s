resource "random_id" "master_id" {
    byte_length = 8
}

resource "google_compute_instance" "k3s-master" {
    name         = "k3s-master-${random_id.master_id.hex}"
    machine_type = "n1-standard-1"
    zone         = "europe-west3-a"

    boot_disk {
        initialize_params {
            image = "ubuntu-1804-bionic-v20191113"
        }
    }

    network_interface {
        network = "default"

        access_config {
            // Include this section to give the VM an external ip address
        }
    }

    metadata = {
        ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
    }
}

resource "random_id" "node_id" {
    byte_length = 8
}

resource "google_compute_instance" "k3s-node-1" {
    name         = "k3s-node-${random_id.node_id.hex}"
    machine_type = "n1-standard-1"
    zone         = "europe-west3-a"

    boot_disk {
        initialize_params {
            image = "ubuntu-1804-bionic-v20191113"
        }
    }

    network_interface {
        network = "default"

        access_config {
            // Include this section to give the VM an external ip address
        }
    }

    metadata = {
        ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
    }
}