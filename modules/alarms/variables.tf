variable "aws_sns_topic_arn" {}

variable "thresholds" {
  type = "map"
}

variable "domain_name" {}

variable "storage_space_evaluation_periods" {
  default = 1
}

variable "cluster_index_writes_blocked" {
  default = 1
}
