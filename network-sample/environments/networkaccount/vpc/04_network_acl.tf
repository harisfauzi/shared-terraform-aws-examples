module "network_acl_public" {
  source = "../../../modules/aws/vpc/aws_network_acl"

  name   = "terraform-public-nacl"
  vpc_id = module.vpc.id

  tags = {
    Owner       = "ACME"
    Environment = "network"
  }

  depends_on = [
    module.vpc
  ]
}

module "network_acl_private" {
  source = "../../../modules/aws/vpc/aws_network_acl"

  name   = "terraform-private-nacl"
  vpc_id = module.vpc.id

  tags = {
    Owner       = "ACME"
    Environment = "network"
  }

  depends_on = [
    module.vpc
  ]
}

module "network_acl_isolated" {
  source = "../../../modules/aws/vpc/aws_network_acl"

  name   = "terraform-isolated-nacl"
  vpc_id = module.vpc.id

  tags = {
    Owner       = "ACME"
    Environment = "network"
  }

  depends_on = [
    module.vpc
  ]
}

module "network_acl_privatelink" {
  source = "../../../modules/aws/vpc/aws_network_acl"

  name   = "terraform-privatelink-nacl"
  vpc_id = module.vpc.id

  tags = {
    Owner       = "ACME"
    Environment = "network"
  }

  depends_on = [
    module.vpc
  ]
}
