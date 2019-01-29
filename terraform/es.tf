module "es" {
  source                = "modules/elasticsearch"
  domain_name           = "bandwagon-es"
  ebs_volume_size       = 10
  elasticsearch_version = "5.1"
  cidr_blocks           = "${var.access_ip_cirdr_blocks}"

  vpc_tags {
    Name = "sandbox-vpc"
  }
}
