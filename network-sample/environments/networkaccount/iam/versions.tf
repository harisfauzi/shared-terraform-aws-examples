terraform {
  required_version = ">= 0.13.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.63"
    }
  }

  # backend "local" {
  #   path = "local/terraform.tfstate"
  # }

  backend "s3" {
    bucket = "networkaccount-terraform-artifacts-us-west-2"
    key    = "networkaccount/iam/region-0.tfstate"
    region = "us-west-2"
    # assume_role = {
    role_arn = "arn:aws:iam::897322816589:role/FAODeployerRole" # IAM Role in networkaccount
    # }
  }
}
