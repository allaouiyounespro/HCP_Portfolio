# ─────────────────────────────────────────────
#  SNS – Notifications for cloudwatch alarm
# ─────────────────────────────────────────────

# Topic SNS
resource "aws_sns_topic" "alerts" {
  name = "cloudfront-alerts"
}

# Abonnement email
resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}
