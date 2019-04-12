module "consul_sofia" {
  source = "github.com/chavo1/aws-consul-terraform"

  consul_version = "${var.ami[var.consul_version]}"
  access_key     = "${var.access_key}"
  secret_key     = "${var.secret_key}"
  key_name       = "${var.key_name}"
  subnet         = "${var.subnet[0]}"
  dc_net         = "${var.dc_net["dc1"]}"
  dcname         = "${var.dcname["dc1"]}"
}
