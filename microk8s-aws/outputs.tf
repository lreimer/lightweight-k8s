output "master-ip" {
    value = "${aws_instance.microk8s.public_ip}"
}