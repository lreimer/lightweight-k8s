data "aws_vpc" "default" {
    default = true
}

data "aws_subnet_ids" "all" {
    vpc_id = "${data.aws_vpc.default.id}"
}

resource "aws_key_pair" "microk8s" {
    key_name   = "microk8s"
    public_key = "${file(var.public_key_path)}"
}

resource "aws_security_group" "microk8s" {
    name        = "MicroK8s SSH"
    vpc_id = "${data.aws_vpc.default.id}"
 
    // Communicate freely within members of the security group
    ingress {
        from_port = 0
        to_port = 0
        protocol = -1
        self = true
    }
 
    // SSH
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
    }
    
    // allow all outbound traffic
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
 
    tags = {
        Name = "MicroK8s SSH"
    }
}