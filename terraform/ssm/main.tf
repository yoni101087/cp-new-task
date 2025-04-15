resource "aws_ssm_parameter" "token" {
  name        = "token"
  description = "Token for app authentication"
  type        = "SecureString"
  value       = random_password.token.result
}
