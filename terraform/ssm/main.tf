resource "aws_ssm_parameter" "token" {
  name        = "${var.environment}-token"
  description = "Token for Microservice authentication"
  type        = "SecureString"
  value       = var.token_value

}