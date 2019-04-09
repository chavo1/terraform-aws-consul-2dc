module "consul_varna" {
  source = "github.com/chavo1/aws-consul-terraform"

  ami        = "${var.ami}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  key_name   = "${var.key_name}"
  subnet     = "${var.subnet[1]}"
  dc_net     = "${var.dc_net["dc2"]}"
  dcname     = "${var.dcname["dc2"]}"
}
