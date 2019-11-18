resource "random_id" "instance_id" {
    byte_length = 8
}

resource "google_compute_instance" "microk8s" {
    name         = "microk8s-vm-${random_id.instance_id.hex}"
    machine_type = "n1-standard-1"
    zone         = "europe-west3-a"

    boot_disk {
        initialize_params {
            image = "ubuntu-1804-bionic-v20191113"
        }
    }

    metadata_startup_script = "sudo snap install microk8s --classic --channel=1.16/stable; sudo usermod -a -G microk8s ubuntu; sudo microk8s.enable dns registry dashboard ingress; sudo microk8s.start"

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