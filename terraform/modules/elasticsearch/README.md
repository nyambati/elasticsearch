# AWS Elasticsearch

## Module Input Variables

- `domain_name` - Name of the domain"
- `access_policies` - IAM policy document specifying the access policies for the domain
- `advanced_options` - Key-value string pairs to specify advanced configuration options.
- `ebs_enabled` - Whether EBS volumes are attached to data nodes in the domain
- `ebs_volume_type` - The type of EBS volumes attached to data nodes.
- `ebs_volume_size` - The size of EBS volumes attached to data nodes (in GB)
- `ebs_iops` - The baseline input/output (I/O) performance of EBS volumes attached to data nodes
- `enabled_encrypt_at_rest` - Whether to enable encryption at rest.
- `kms_key_id` - The KMS key id to encrypt the Elasticsearch domain with.
- `node_to_node_encryption` - Whether to enable node-to-node encryption.
- `instance_type` - (Optional) Instance type of data nodes in the cluster.
- `instance_count` - (Optional) Number of instances in the cluster.
- `dedicated_master_enabled` - (Optional) Indicates whether dedicated master nodes are enabled for the cluster.
- `dedicated_master_type` - (Optional) Instance type of the dedicated master nodes in the cluster.
- `dedicated_master_count` - (Optional) Number of dedicated master nodes in the cluster
- `zone_awareness_enabled` - (Optional) Indicates whether zone awareness is enabled
- `automated_snapshot_start_hour` -
- `security_group_ids` - (Optional) List of VPC Security Group IDs to be applied to the Elasticsearch domain endpoints.
- `subnet_ids` - (Required) List of VPC Subnet IDs for the Elasticsearch domain endpoints to be created in.
- `log_type` - A type of Elasticsearch log.
- `cloudwatch_log_group_arn` - ARN of the Cloudwatch log group to which log needs to be published
- `enable_log_publishing` - pecifies whether given log publishing option is enabled
- `elasticsearch_version` -
- `vpc_tags` - Tags to be used to filter VPC
- `subnet_ids` - Subnet Ids to launch Es Cluster in, if not provided all VPC subnets will be used
- `tags` - Additional resource tags

## Usage

```hcl
module "es" {
  source                = "modules/elasticsearch"
  domain_name           = "bandwagon-es"
  ebs_volume_size       = 10
  elasticsearch_version = "5.1"
  cidr_blocks           = "${var.access_ip_cirdr_blocks}"
}

```

## Outputs

- `arn` - Amazon Resource Name (ARN) of the domain.
- `domain_id` - Unique identifier for the domain.
- `domain_name` - The name of the Elasticsearch domain.
- `endpoint` - Domain-specific endpoint used to submit index, search, and data upload requests.
- `kibana_endpoint` - Domain-specific endpoint for kibana without https scheme.
