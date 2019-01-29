data "aws_vpc" "mod" {
  tags = "${var.vpc_tags}"
}

resource "aws_security_group" "mod" {
  name        = "${format("elasticsearch-%s-sg", var.domain_name)}"
  description = "Elasticsearch security groups"
  vpc_id      = "${data.aws_vpc.mod.id}"

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = [
      "${concat(data.aws_vpc.mod.cidr_blocks, var.cidr_blocks)}",
    ]
  }
}

resource "aws_elasticsearch_domain" "mod" {
  domain_name     = "${var.domain_name}"
  access_policies = "${var.access_policies}"

  vpc_options {
    subnet_ids             = ["${var.subnet_ids ? var.subnet_ids : data.aws_vpc.mod.ids}"]
    aws_security_group_ids = ["${aws_cloudwatch_log_group.mod.id}"]
  }

  advanced_options = "${var.advanced_options}"

  ebs_options {
    ebs_enabled = "${var.ebs_volume_size > 0 ? true : false}"
    volume_type = "${var.ebs_volume_type}"
    volume_size = "${var.ebs_volume_size}"
    iops        = "${var.ebs_iops}"
  }

  encrypt_at_rest {
    enabled    = "${var.enabled_encrypt_at_rest}"
    kms_key_id = "${var.enabled_encrypt_at_rest ? var.kms_key_id: ""}"
  }

  node_to_node_encryption {
    enabled = "${var.node_to_node_encryption}"
  }

  cluster_config {
    instance_type            = "${var.instance_type}"
    instance_count           = "${var.instance_count}"
    dedicated_master_enabled = "${var.dedicated_master_enabled}"
    dedicated_master_type    = "${var.dedicated_master_enabled ? var.dedicated_master_type : "" }"
    dedicated_master_count   = "${var.dedicated_master_enabled ? var.dedicated_master_count : 0 }"
    zone_awareness_enabled   = "${var.zone_awareness_enabled}"
  }

  snapshot_options {
    automated_snapshot_start_hour = "${var.automated_snapshot_start_hour}"
  }

  log_publishing_options {
    log_type                 = "${var.log_type}"
    cloudwatch_log_group_arn = "${var.enable_log_publishing ? aws_cloudwatch_log_group.mod.arn : ""}"
    enabled                  = "${var.enable_log_publishing}"
  }

  elasticsearch_version = "${var.elasticsearch_version}"
  tags                  = "${merge(var.tags, map("Name", var.domain_name))}"
}

resource "aws_elasticsearch_domain_policy" "mod" {
  domain_name = "${aws_elasticsearch_domain.mod.domain_name}"

  access_policies = <<POLICIES
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "es:*"
      ],
      "Condition": {
        "IpAddress": {
          "aws:SourceIp": ["${join("\",\"", var.cidr_blocks)}"]
        }
      },
      "Resource": "${aws_elasticsearch_domain.mod.arn}/*"
    }
  ]
}
POLICIES
}

# cloudwatch logs

resource "aws_cloudwatch_log_group" "mod" {
  name  = "${format("%s-cloudwatch-log-group", var.domain_name)}"
  count = "${var.enable_log_publishing ? 1: 0}"
}

resource "aws_cloudwatch_log_resource_policy" "mod" {
  policy_name = "${format("%s-cloudwatch-log-policy", var.domain_name)}"
  count       = "${var.enable_log_publishing ? 1: 0}"

  policy_document = <<CONFIG
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "es.amazonaws.com"
      },
      "Action": [
        "logs:PutLogEvents",
        "logs:PutLogEventsBatch",
        "logs:CreateLogStream"
      ],
      "Resource": "arn:aws:logs:*"
    }
  ]
}
CONFIG
}
