output "public_dns_servers_varna" {
  value = "${module.consul_varna.public_dns_servers}"
}

output "subnet_id" {
  value = "${module.consul_varna.subnet_id}"
}

output "instance_type" {
  value = "${module.consul_varna.instance_type}"
}

output "availability_zone" {
  value = "${module.consul_varna.availability_zone}"
}

output "key_name" {
  value = "${module.consul_varna.key_name}"
}

output "aws_iam_instance_profile" {
  value = "${module.consul_varna.aws_iam_instance_profile}"
}

output "ami_id" {
  value = "${module.consul_varna.ami_id}"
}

output "private_ip" {
  value = "${module.consul_varna.private_ip}"
}
