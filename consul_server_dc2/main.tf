module "consul_varna" {
  source = "github.com/chavo1/aws-consul-terraform"

  consul_version = "${var.ami[var.consul_version]}"
  access_key     = "${var.access_key}"
  secret_key     = "${var.secret_key}"
  key_name       = "${var.key_name}"
  subnet         = "${var.subnet[1]}"
  dc_net         = "${var.dc_net["dc2"]}"
  dcname         = "${var.dcname["dc2"]}"
}
