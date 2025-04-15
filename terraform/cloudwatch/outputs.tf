output "app1_log_group_name" {
  value = aws_cloudwatch_log_group.app1.name
}

output "app2_log_group_name" {
  value = aws_cloudwatch_log_group.app2.name
}
