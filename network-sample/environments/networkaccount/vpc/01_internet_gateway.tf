
module "internet_gateway" {

  # source = "github.com/harisfauzi/shared-terraform-aws.git//modules/aws/vpc/aws_internet_gateway?ref=develop"
  source = "../../../modules/aws/vpc/aws_internet_gateway"

  name   = "terraform-mainvpc"
  vpc_id = module.vpc.id

  tags = {
    Owner       = "Haris"
    Environment = "dev"
  }

  depends_on = [
    module.vpc
  ]

}

module "egress_only_internet_gateway" {

  source = "../../../modules/aws/vpc/aws_egress_only_internet_gateway"

  name   = "terraform-mainvpc"
  vpc_id = module.vpc.id

  tags = {
    Owner       = "Haris"
    Environment = "dev"
  }

  depends_on = [
    module.vpc
  ]

}
