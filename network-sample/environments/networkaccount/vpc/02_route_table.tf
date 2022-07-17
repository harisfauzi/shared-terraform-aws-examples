module "route_table_public" {
  # source = "github.com/harisfauzi/shared-terraform-aws.git//modules/aws/vpc/aws_route_table?ref=develop"
  source = "../../../modules/aws/vpc/aws_route_table"

  name   = "terraform-public-rt"
  vpc_id = module.vpc.id

  tags = {
    Owner       = "Haris"
    Environment = "dev"
  }

  depends_on = [
    module.vpc
  ]
}

module "route_table_private_a" {
  # source = "github.com/harisfauzi/shared-terraform-aws.git//modules/aws/vpc/aws_route_table?ref=develop"
  source = "../../../modules/aws/vpc/aws_route_table"

  name   = "terraform-private-rt-a"
  vpc_id = module.vpc.id

  tags = {
    Owner       = "Haris"
    Environment = "dev"
  }

  depends_on = [
    module.vpc
  ]
}

module "route_table_private_b" {
  # source = "github.com/harisfauzi/shared-terraform-aws.git//modules/aws/vpc/aws_route_table?ref=develop"
  source = "../../../modules/aws/vpc/aws_route_table"

  name   = "terraform-private-rt-b"
  vpc_id = module.vpc.id

  tags = {
    Owner       = "Haris"
    Environment = "dev"
  }

  depends_on = [
    module.vpc
  ]
}

module "route_table_isolated_a" {
  # source = "github.com/harisfauzi/shared-terraform-aws.git//modules/aws/vpc/aws_route_table?ref=develop"
  source = "../../../modules/aws/vpc/aws_route_table"

  name   = "terraform-isolated-rt-a"
  vpc_id = module.vpc.id

  tags = {
    Owner       = "Haris"
    Environment = "dev"
  }

  depends_on = [
    module.vpc
  ]
}

module "route_table_isolated_b" {
  source = "../../../modules/aws/vpc/aws_route_table"

  name   = "terraform-isolated-rt-b"
  vpc_id = module.vpc.id

  tags = {
    Owner       = "Haris"
    Environment = "dev"
  }

  depends_on = [
    module.vpc
  ]
}

module "route_table_privatelink_a" {
  # source = "github.com/harisfauzi/shared-terraform-aws.git//modules/aws/vpc/aws_route_table?ref=develop"
  source = "../../../modules/aws/vpc/aws_route_table"

  name   = "terraform-privatelink-rt-a"
  vpc_id = module.vpc.id

  tags = {
    Owner       = "Haris"
    Environment = "dev"
  }

  depends_on = [
    module.vpc
  ]
}

module "route_table_privatelink_b" {
  # source = "github.com/harisfauzi/shared-terraform-aws.git//modules/aws/vpc/aws_route_table?ref=develop"
  source = "../../../modules/aws/vpc/aws_route_table"

  name   = "terraform-privatelink-rt-b"
  vpc_id = module.vpc.id

  tags = {
    Owner       = "Haris"
    Environment = "dev"
  }

  depends_on = [
    module.vpc
  ]
}
