variable "aws_region" {
    description = "AWS region to launch servers."
    default     = "eu-central-1"
}

variable "public_key_path" {
    description = "Path to the SSH public key. Ensure this keypair is added to your local SSH agent."
    default = "~/.ssh/id_rsa.pub"
}
