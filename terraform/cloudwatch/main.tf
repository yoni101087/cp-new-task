resource "aws_cloudwatch_log_group" "app1" {
  name              = "/ecs/app1"
  retention_in_days = var.retention_in_days
}

resource "aws_cloudwatch_log_group" "app2" {
  name              = "/ecs/app2"
  retention_in_days = var.retention_in_days
}

output "app1_log_group_name" {
  description = "CloudWatch Log Group name for app1"
  value       = aws_cloudwatch_log_group.app1.name
}

output "app2_log_group_name" {
  description = "CloudWatch Log Group name for app2"
  value       = aws_cloudwatch_log_group.app2.name
}
