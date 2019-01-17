variable "domain_name" {
  description = "Name of the domain"
}

variable "access_policies" {
  description = "IAM policy document specifying the access policies for the domain"
  default     = ""
}

variable "advanced_options" {
  description = "Key-value string pairs to specify advanced configuration options."
  default     = {}
}

variable "ebs_volume_type" {
  description = "The type of EBS volumes attached to data nodes."
  default     = "gp2"
}

variable "ebs_volume_size" {
  description = "The size of EBS volumes attached to data nodes (in GB)"
  default     = 0
}

variable "ebs_iops" {
  description = "The baseline input/output (I/O) performance of EBS volumes attached to data nodes"
  default     = 0
}

variable "enabled_encrypt_at_rest" {
  description = "Whether to enable encryption at rest."
  default     = false
}

variable "kms_key_id" {
  description = "The KMS key id to encrypt the Elasticsearch domain with"
  default     = ""
}

variable "node_to_node_encryption" {
  description = "Whether to enable node-to-node encryption"
  default     = false
}

variable "instance_type" {
  description = "(Optional) Instance type of data nodes in the cluster."
  default     = "t2.small.elasticsearch"
}

variable "instance_count" {
  description = "(Optional) Number of instances in the cluster."
  default     = 1
}

variable "dedicated_master_enabled" {
  description = "(Optional) Indicates whether dedicated master nodes are enabled for the cluster."
  default     = false
}

variable "dedicated_master_type" {
  description = "(Optional) Instance type of the dedicated master nodes in the cluster."
  default     = ""
}

variable "dedicated_master_count" {
  description = "(Optional) Number of dedicated master nodes in the cluster"
  default     = 0
}

variable "zone_awareness_enabled" {
  description = "(Optional) Indicates whether zone awareness is enabled."
  default     = false
}

variable "automated_snapshot_start_hour" {
  description = "Hour during which the service takes an automated daily snapshot of the indices in the domain"
  default     = 23
}

variable "security_group_ids" {
  description = "(Optional) List of VPC Security Group IDs to be applied to the Elasticsearch domain endpoints"
  type        = "list"
  default     = []
}

variable "subnet_ids" {
  description = "(Required) List of VPC Subnet IDs for the Elasticsearch domain endpoints to be created in."
  type        = "list"
  default     = []
}

variable "log_type" {
  description = "A type of Elasticsearch log."
  default     = "INDEX_SLOW_LOGS"
}

variable "cloudwatch_log_group_arn" {
  description = "ARN of the Cloudwatch log group to which log needs to be published"
  default     = ""
}

variable "enable_log_publishing" {
  description = "Specifies whether given log publishing option is enabled "
  default     = true
}

variable "elasticsearch_version" {}

variable "tags" {
  type        = "map"
  default     = {}
  description = "Additional resource tags "
}

variable "cidr_blocks" {
  type = "list"
}
