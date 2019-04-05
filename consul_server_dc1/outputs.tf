output "public_dns_servers_sofia" {
  value = "${module.consul_sofia.public_dns_servers}"
}

output "subnet_id" {
  value = "${module.consul_sofia.subnet_id}"
}

output "instance_type" {
  value = "${module.consul_sofia.instance_type}"
}

output "availability_zone" {
  value = "${module.consul_sofia.availability_zone}"
}

output "key_name" {
  value = "${module.consul_sofia.key_name}"
}

output "aws_iam_instance_profile" {
  value = "${module.consul_sofia.aws_iam_instance_profile}"
}

output "ami_id" {
  value = "${module.consul_sofia.ami_id}"
}
