
################################################################################
# VPC Module
################################################################################

module "vpc" {
  source = "../../../modules/aws/vpc/aws_vpc"

  name        = "terraform-mainvpc"
  cidr_block  = var.subnet_cidr_block.networkaccount.vpc
  enable_ipv6 = true

  tags = {
    Owner       = "ACME"
    Environment = "network"
  }
}
