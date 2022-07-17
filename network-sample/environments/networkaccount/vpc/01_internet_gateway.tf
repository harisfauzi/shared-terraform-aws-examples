
module "internet_gateway" {

  source = "../../../modules/aws/vpc/aws_internet_gateway"

  name   = "terraform-mainvpc"
  vpc_id = module.vpc.id

  tags = {
    Owner       = "ACME"
    Environment = "network"
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
    Owner       = "ACME"
    Environment = "network"
  }

  depends_on = [
    module.vpc
  ]

}
