data "terraform_remote_state" "server" {
  backend = "local"

  config {
    path = "../consul_server_dc1/terraform.tfstate"
  }
}

provider "aws" {
  region = "us-east-1"
}

# Terraform <= 0.11
resource "aws_instance" "server" {
  ami                  = "${data.terraform_remote_state.server.ami_id[0]}"
  subnet_id            = "subnet-022ebfb6489c888e0"
  instance_type        = "${data.terraform_remote_state.server.instance_type[0]}"
  private_ip           = "172.31.32.${count.index + 11}"
  key_name             = "${data.terraform_remote_state.server.key_name[0]}"
  iam_instance_profile = "${data.terraform_remote_state.server.aws_iam_instance_profile[0]}"


  // consul tag consul = "app" is important for AWS Consul Auto-Join
  tags {
    Name   = "consul-server0${count.index + 1}"
    consul = "app"
    consul_wan = "wan_app"
  }
  // Our private key needed for connection to the servers 
  connection {
    user        = "ubuntu"
    private_key = "${file("~/.ssh/id_rsa")}"
  }
  // Copying needed scripts on the instance 
  provisioner "file" {
    source      = "scripts/"
    destination = "/tmp/"
  }
  // This is our provisioning scripts
  provisioner "remote-exec" {
    inline = [
      "sudo bash /tmp/consul.sh varna",
    ]
  }
}

output "public_dns_servers_varna" {
  value = "${aws_instance.server.*.public_dns}"
}
output "subnet_id" {
  value = "${aws_instance.server.*.subnet_id}"
}

output "instance_type" {
  value = "${aws_instance.server.*.instance_type}"
}

output "key_name" {
  value = "${aws_instance.server.*.key_name}"
}

output "aws_iam_instance_profile" {
  value = "${data.terraform_remote_state.server.aws_iam_instance_profile}"
}