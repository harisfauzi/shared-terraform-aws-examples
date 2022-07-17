variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "us-east-2"
}

variable "subnet_cidr_block" {
  description = "A map of predefined subnets"
  type        = map(any)
}

variable "aws_assume_role_arn_networkaccount" {
  description = "The IAM Role ARN to assume for target account deployment"
  type        = string
  default     = null
}