provider "aws" {
  region = local.region
  assume_role {
    # This is networkaccount
    role_arn     = "arn:aws:iam::897322816589:role/FAODeployerRole"
    session_name = "terraform"
  }
}

locals {
  region = var.aws_region # "us-east-2"
}
