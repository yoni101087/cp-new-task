resource "aws_ssm_parameter" "token" {
  name        = "token"
  description = "Token for Microservice authentication"
  type        = "SecureString"
  value       = var.token_value

}