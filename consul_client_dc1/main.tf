data "terraform_remote_state" "client" {
  backend = "local"

  config {
    path = "../consul_server_dc1/terraform.tfstate"
  }
}

provider "aws" {
  region = "us-east-1"
}

# Terraform <= 0.11
resource "aws_instance" "client" {
  ami                  = "ami-023d06001e0e56264"
  subnet_id            = "${data.terraform_remote_state.client.subnet_id[0]}"
  instance_type        = "${data.terraform_remote_state.client.instance_type[0]}"
  private_ip           = "172.31.16.${count.index + 21}"
  key_name             = "${data.terraform_remote_state.client.key_name[0]}"
  iam_instance_profile = "${data.terraform_remote_state.client.aws_iam_instance_profile[0]}"

  tags {
    Name   = "consul-client0${count.index + 1}"
    consul = "app"
  }
  // Our private key needed for connection to the clients 
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
      "sudo bash /tmp/consul.sh sofia",
      "sudo bash /tmp/kv.sh",
      "sudo bash /tmp/consul-template.sh",
      "sudo bash /tmp/nginx.sh",
      "sudo bash /tmp/dns.sh",
    ]
  }
}

output "public_dns_clients_sofia" {
  value = "${aws_instance.client.*.public_dns}"
}
