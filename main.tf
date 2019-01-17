provider "aws" {
  profile = "${var.profile}"
  region  = "${var.region}"
}

terraform {}

data "aws_vpc" "default" {
  id = "${var.vpc_id}"
}

data "aws_availability_zones" "available" {
  state = "available"
}
