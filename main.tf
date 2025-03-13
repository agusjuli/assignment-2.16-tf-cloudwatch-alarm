resource "aws_cloudwatch_metric_alarm" "info_log_alarm" {
  alarm_name          = "agusjuli-info-count-breach"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "info-count"
  namespace           = "/moviedb-api/agusjuli"
  period              = 60  # Evaluate over 1 minute
  statistic           = "Sum"
  threshold           = 10  # Change this to your desired threshold
  alarm_description   = "Alarm triggers when INFO logs exceed the threshold"
  alarm_actions       = [aws_sns_topic.log_alarm_notification.arn]

  treat_missing_data = "notBreaching"
}

resource "aws_sns_topic" "log_alarm_notification" {
  name = "agusjuli-alert-topic"
}

resource "aws_sns_topic_subscription" "email_notification" {
  topic_arn = aws_sns_topic.log_alarm_notification.arn
  protocol  = "email"
  endpoint  = "agusjuli@yahoo.com.sg"  # Change this to the recipient's email
}