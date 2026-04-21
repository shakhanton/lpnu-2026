module "label_alarm" {
  source  = "cloudposse/label/null"
  version = "0.25.0"
  context = module.label.context
  name    = "alarm"
}

resource "aws_cloudwatch_metric_alarm" "this" {
  alarm_name          = module.label_alarm.id
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  datapoints_to_alarm = 1
  dimensions = {
    FunctionName = "dev-lpnu-2026-get-course"
    Resource     = "dev-lpnu-2026-get-course"
  }
  metric_name               = "Errors"
  namespace                 = "AWS/Lambda"
  period                    = 300
  statistic                 = "Sum"
  threshold                 = 5
  alarm_description         = "This metric monitors get course lambda function"
  insufficient_data_actions = []
  treat_missing_data        = "notBreaching"
  alarm_actions             = ["arn:aws:sns:eu-central-1:657694663228:dev-lpnu-2026-notify-slack"]

}
