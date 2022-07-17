module "route_entry_public_ipv4_default" {
  # source = "github.com/harisfauzi/shared-terraform-aws.git//modules/aws/vpc/aws_route_entry?ref=develop"
  source = "../../../modules/aws/vpc/aws_route_entry"

  route_table_id         = module.route_table_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = module.internet_gateway.id
}

module "route_entry_public_ipv6_default" {
  # source = "github.com/harisfauzi/shared-terraform-aws.git//modules/aws/vpc/aws_route_entry?ref=develop"
  source = "../../../modules/aws/vpc/aws_route_entry"

  route_table_id              = module.route_table_public.id
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = module.internet_gateway.id
}
