variable "vpc_id" {
  description = "The VPC ID where the ALB will be deployed"
  type        = string
}


variable "allowed_inbound_cidr" {
  description = "The CIDR blocks allowed to access the ALB"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "public_subnets" {
  description = "Public subnets for the ALB"
  type        = list(string)
}
