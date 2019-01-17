# ClusterStatus.green
# ClusterStatus.red
# CPUUtilization
# JVMMemoryPressure
data "aws_caller_identity" "default" {}

resource "aws_cloudwatch_metric_alarm" "cluster_status_is_red" {
  alarm_name          = "ElasticSearchClusterStatusIsRed"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "ClusterStatus.red"
  namespace           = "AWS/ES"
  period              = "60"
  statistic           = "Average"
  threshold           = "1"
  alarm_description   = "Average elasticsearch cluster status is in red over last 5 minutes"
  alarm_actions       = ["${var.aws_sns_topic_arn}"]
  ok_actions          = ["${var.aws_sns_topic_arn}"]

  dimensions {
    DomainName = "${var.domain_name}"
    ClientId   = "${data.aws_caller_identity.default.account_id}"
  }
}

resource "aws_cloudwatch_metric_alarm" "free_storage_space_too_low" {
  alarm_name          = "ElasticSearch-FreeStorageSpaceTooLow"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "${var.storage_space_evaluation_periods}"
  metric_name         = "FreeStorageSpace"
  namespace           = "AWS/ES"
  period              = "60"
  statistic           = "Average"
  threshold           = "${lookup(var.thresholds,"FreeStorageSpaceThreshold")}"
  alarm_description   = "Average elasticsearch free storage space over last 1 minutes is too low"
  alarm_actions       = ["${var.aws_sns_topic_arn}"]
  ok_actions          = ["${var.aws_sns_topic_arn}"]

  dimensions {
    DomainName = "${var.domain_name}"
    ClientId   = "${data.aws_caller_identity.default.account_id}"
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_utilization_too_high" {
  alarm_name          = "ElasticSearchCPUUtilizationTooHigh"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ES"
  period              = "60"
  statistic           = "Average"
  threshold           = "${lookup(var.thresholds, "CPUUtilizationThreshold")}"
  alarm_description   = "Average elasticsearch cluster CPU utilization is too high"
  alarm_actions       = ["${var.aws_sns_topic_arn}"]
  ok_actions          = ["${var.aws_sns_topic_arn}"]

  dimensions {
    DomainName = "${var.domain_name}"
    ClientId   = "${data.aws_caller_identity.default.account_id}"
  }
}

resource "aws_cloudwatch_metric_alarm" "cluster_index_writes_blocked" {
  alarm_name          = "ElasticSearch-ClusterIndexWritesBlocked"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "${var.cluster_index_writes_blocked}"
  metric_name         = "ClusterIndexWritesBlocked"
  namespace           = "AWS/ES"
  period              = "300"
  statistic           = "Average"
  threshold           = "1"
  alarm_description   = "Elasticsearch index writes being blocked"
  alarm_actions       = ["${var.aws_sns_topic_arn}"]
  ok_actions          = ["${var.aws_sns_topic_arn}"]

  dimensions {
    DomainName = "${var.domain_name}"
    ClientId   = "${data.aws_caller_identity.default.account_id}"
  }
}

resource "aws_cloudwatch_metric_alarm" "automated_snapshot_failure" {
  alarm_name          = "ElasticSearch-AutomatedSnapshotFailure"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "AutomatedSnapshotFailure"
  namespace           = "AWS/ES"
  period              = "600"
  statistic           = "Maximum"
  threshold           = "1"
  alarm_description   = "Elasticsearch automated snapshot failed"
  alarm_actions       = ["${var.aws_sns_topic_arn}"]
  ok_actions          = ["${var.aws_sns_topic_arn}"]

  dimensions {
    DomainName = "${var.domain_name}"
    ClientId   = "${data.aws_caller_identity.default.account_id}"
  }
}
