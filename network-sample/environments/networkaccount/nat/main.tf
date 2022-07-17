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

data "aws_internet_gateway" "main_internet_gateway" {
  filter {
    name   = "tag:Name"
    values = ["terraform-mainvpc"]
  }
}
