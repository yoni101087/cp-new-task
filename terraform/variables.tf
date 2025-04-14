variable "token_value" {
  description = "The token value to store in SSM Parameter Store"
  type        = string
  sensitive   = true
  default     = null
}


variable "allowed_inbound_cidr" {
  description = "The CIDR block allowed to access the ALB (e.g., 0.0.0.0/0 for public access)"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "aws_region" {
  description = "The AWS region where resources will be created"
  type        = string
  default     = "us-west-2"
}

variable "alarm_sns_topic_arns" {
  description = "List of SNS Topic ARNs to notify when CloudWatch alarms trigger"
  type        = list(string)
  default     = []
}