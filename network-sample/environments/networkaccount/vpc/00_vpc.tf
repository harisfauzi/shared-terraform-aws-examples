
################################################################################
# VPC Module
################################################################################

module "vpc" {
  # source = "github.com/harisfauzi/shared-terraform-aws.git//modules/aws/vpc/aws_vpc?ref=develop"
  source = "../../../modules/aws/vpc/aws_vpc"

  name        = "terraform-mainvpc"
  cidr_block  = var.subnet_cidr_block.networkaccount.vpc
  enable_ipv6 = true

  tags = {
    Owner       = "Haris"
    Environment = "dev"
  }
}
