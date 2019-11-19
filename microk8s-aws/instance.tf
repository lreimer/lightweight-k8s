data "aws_ami" "ubuntu18" {
    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
    }

    owners = ["099720109477"] # Canonical
}

resource "aws_instance" "microk8s" {
    ami = "${data.aws_ami.ubuntu18.id}"
    instance_type = "t2.micro"

    subnet_id = "${element(tolist(data.aws_subnet_ids.all.ids), 0)}"
    key_name = "${aws_key_pair.microk8s.id}"
    vpc_security_group_ids = ["${aws_security_group.microk8s.id}"]
    associate_public_ip_address = true

    tags = {
        Name = "MicroK8s Instance"
    }

    connection {
        # The default username for our AMI
        user = "ubuntu"
        host = "${self.public_ip}"
        agent = true
    } 

    provisioner "remote-exec" {
        inline = [
            "sudo snap wait system seed.loaded",
            "sudo snap install microk8s --classic --channel=1.16/stable",
            "sudo usermod -a -G microk8s ubuntu",
            "sudo microk8s.start",
            "sudo microk8s.status"
        ]
    }
}