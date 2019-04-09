variable "access_key" {}
variable "secret_key" {}

variable "server_count" {
  default = 3
}

variable "subnet" {
  type    = "list"
  default = []
}

variable "dcname" {
  type = "map"

  default = {
    dc1 = "sofia"
    dc2 = "varna"
  }
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami" {
  type = "map"

  default = {}
}

variable "key_name" {}

variable "dc_net" {
  type = "map"

  default = {
    dc1 = "16"
    dc2 = "32"
  }
}

variable "region" {
  default = "us-east-1"
}

variable "create" {
  description = "Create Module, defaults to true."
  default     = true
}

variable "name" {
  description = "Name for resources, defaults to \"consul-auto-join-instance-role-aws\"."
  default     = "consul-auto-join-aws"
}
