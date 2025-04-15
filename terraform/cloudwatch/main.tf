resource "aws_cloudwatch_log_group" "app1" {
  name              = "/ecs/app1"
  retention_in_days = var.retention_in_days
}

resource "aws_cloudwatch_log_group" "app2" {
  name              = "/ecs/app2"
  retention_in_days = var.retention_in_days
}

