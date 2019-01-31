variable "region" {
  default = "us-east-1"
}

variable "profile" {}

variable "access_ip_cirdr_blocks" {
  type    = "list"
  default = []
}
