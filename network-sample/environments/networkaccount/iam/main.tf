provider "aws" {
  region = local.region
  assume_role {
    # This is networkaccount
    role_arn     = var.aws_assume_role_arn_networkaccount
    session_name = "terraform"
  }
}

locals {
  region = var.aws_region # "us-east-2"
}
