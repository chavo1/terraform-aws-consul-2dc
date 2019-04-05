module "consul_sofia" {
  source = "github.com/chavo1/aws-consul-terraform"

  access_key    = "${var.access_key}"
  secret_key    = "${var.secret_key}"
  region        = "${var.region}"
  server_count  = "${var.server_count}"
  instance_type = "${var.instance_type}"
  key_name      = "${var.key_name}"
  subnet        = "${var.subnet[0]}"
  dc_net        = "${var.dc_net["dc1"]}"
  dcname        = "${var.dcname["dc1"]}"
}
