resource "random_password" "token" {
  length  = 32
  special = true
}

resource "aws_ssm_parameter" "token" {
  name        = "token"
  description = "Token for app authentication"
  type        = "SecureString"
  value       = var.token_value != null ? var.token_value : random_password.token.result
}
