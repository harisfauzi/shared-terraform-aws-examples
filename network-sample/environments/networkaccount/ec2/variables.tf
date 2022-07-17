variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "us-east-2"
}

variable "subnet_cidr_block" {
  description = "A map of predefined subnets"
  type        = map(any)
}