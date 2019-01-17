output "arn" {
  value = "${aws_elasticsearch_domain.mod.arn}"
}

output "domain_id" {
  value = "${aws_elasticsearch_domain.mod.domain_id}"
}

output "domain_name" {
  value = "${aws_elasticsearch_domain.mod.domain_name}"
}

output "endpoint" {
  value = "${aws_elasticsearch_domain.mod.endpoint}"
}

output "kibana_endpoint" {
  value = "${aws_elasticsearch_domain.mod.kibana_endpoint}"
}
