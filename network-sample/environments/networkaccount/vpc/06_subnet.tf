module "subnet_public_a" {
  source = "../../../modules/aws/vpc/aws_subnet"

  name              = "terraform-public-subnet-a"
  vpc_id            = module.vpc.id
  availability_zone = format("%sa", var.aws_region)
  cidr_block        = var.subnet_cidr_block.networkaccount.public_a
  ipv6_cidr_block   = cidrsubnet(module.vpc.ipv6_cidr_block, 8, 0)
  network_acl_id    = module.network_acl_public.id
  route_table_id    = module.route_table_public.id

  tags = {
    Owner       = "ACME"
    Environment = "dev"
  }

  depends_on = [
    module.network_acl_public,
    module.route_table_public
  ]
}

module "subnet_public_b" {
  source = "../../../modules/aws/vpc/aws_subnet"

  name              = "terraform-public-subnet-b"
  vpc_id            = module.vpc.id
  availability_zone = format("%sb", var.aws_region)
  cidr_block        = var.subnet_cidr_block.networkaccount.public_b
  ipv6_cidr_block   = cidrsubnet(module.vpc.ipv6_cidr_block, 8, 1)
  network_acl_id    = module.network_acl_public.id
  route_table_id    = module.route_table_public.id

  tags = {
    Owner       = "ACME"
    Environment = "dev"
  }

  depends_on = [
    module.network_acl_public,
    module.route_table_public
  ]
}

module "subnet_private_a" {
  source = "../../../modules/aws/vpc/aws_subnet"

  name              = "terraform-private-subnet-a"
  vpc_id            = module.vpc.id
  availability_zone = format("%sa", var.aws_region)
  cidr_block        = var.subnet_cidr_block.networkaccount.private_a
  ipv6_cidr_block   = cidrsubnet(module.vpc.ipv6_cidr_block, 8, 2)
  network_acl_id    = module.network_acl_private.id
  route_table_id    = module.route_table_private_a.id

  tags = {
    Owner       = "ACME"
    Environment = "dev"
  }

  depends_on = [
    module.network_acl_private,
    module.route_table_private_a
  ]
}

module "subnet_private_b" {
  source = "../../../modules/aws/vpc/aws_subnet"

  name              = "terraform-private-subnet-b"
  vpc_id            = module.vpc.id
  availability_zone = format("%sb", var.aws_region)
  cidr_block        = var.subnet_cidr_block.networkaccount.private_b
  ipv6_cidr_block   = cidrsubnet(module.vpc.ipv6_cidr_block, 8, 3)
  network_acl_id    = module.network_acl_private.id
  route_table_id    = module.route_table_private_b.id

  tags = {
    Owner       = "ACME"
    Environment = "dev"
  }

  depends_on = [
    module.network_acl_private,
    module.route_table_private_b
  ]
}

module "subnet_isolated_a" {
  source = "../../../modules/aws/vpc/aws_subnet"

  name              = "terraform-isolated-subnet-a"
  vpc_id            = module.vpc.id
  availability_zone = format("%sa", var.aws_region)
  cidr_block        = var.subnet_cidr_block.networkaccount.isolated_a
  ipv6_cidr_block   = cidrsubnet(module.vpc.ipv6_cidr_block, 8, 5)
  network_acl_id    = module.network_acl_isolated.id
  route_table_id    = module.route_table_isolated_a.id

  tags = {
    Owner       = "ACME"
    Environment = "dev"
  }

  depends_on = [
    module.network_acl_isolated,
    module.route_table_isolated_a
  ]
}

module "subnet_isolated_b" {
  source = "../../../modules/aws/vpc/aws_subnet"

  name              = "terraform-isolated-subnet-b"
  vpc_id            = module.vpc.id
  availability_zone = format("%sb", var.aws_region)
  cidr_block        = var.subnet_cidr_block.networkaccount.isolated_b
  ipv6_cidr_block   = cidrsubnet(module.vpc.ipv6_cidr_block, 8, 6)
  network_acl_id    = module.network_acl_isolated.id
  route_table_id    = module.route_table_isolated_b.id

  tags = {
    Owner       = "ACME"
    Environment = "dev"
  }

  depends_on = [
    module.network_acl_isolated,
    module.route_table_isolated_b
  ]
}

module "subnet_privatelink_a" {
  source = "../../../modules/aws/vpc/aws_subnet"

  name              = "terraform-privatelink-subnet-a"
  vpc_id            = module.vpc.id
  availability_zone = format("%sa", var.aws_region)
  cidr_block        = var.subnet_cidr_block.networkaccount.privatelink_a
  ipv6_cidr_block   = cidrsubnet(module.vpc.ipv6_cidr_block, 8, 7)
  network_acl_id    = module.network_acl_privatelink.id
  route_table_id    = module.route_table_privatelink_a.id

  tags = {
    Owner       = "ACME"
    Environment = "dev"
  }

  depends_on = [
    module.network_acl_privatelink,
    module.route_table_privatelink_a
  ]
}

module "subnet_privatelink_b" {
  source = "../../../modules/aws/vpc/aws_subnet"

  name              = "terraform-privatelink-subnet-b"
  vpc_id            = module.vpc.id
  availability_zone = format("%sb", var.aws_region)
  cidr_block        = var.subnet_cidr_block.networkaccount.privatelink_b
  ipv6_cidr_block   = cidrsubnet(module.vpc.ipv6_cidr_block, 8, 8)
  network_acl_id    = module.network_acl_privatelink.id
  route_table_id    = module.route_table_privatelink_b.id

  tags = {
    Owner       = "ACME"
    Environment = "dev"
  }

  depends_on = [
    module.network_acl_privatelink,
    module.route_table_privatelink_b
  ]
}
