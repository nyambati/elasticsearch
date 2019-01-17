resource "aws_sns_topic" "topic" {
  name_prefix = "es-threshold-alerts"
}

module "alarms" {
  source            = "modules/alarms"
  aws_sns_topic_arn = "${aws_sns_topic.topic.arn}"
  domain_name       = "${module.es.domain_name}"

  thresholds = {
    CPUUtilizationThreshold   = 50
    FreeStorageSpaceThreshold = 5
  }
}
