resource "aws_cloudwatch_log_group" "log-group" {
  name              = "${var.environment}-${var.app_name}-log-group"
  retention_in_days = 0

  tags = {
    Environment = "production"
    Application = "${var.app_name}"
  }
}