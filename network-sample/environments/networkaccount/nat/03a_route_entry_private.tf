
data "aws_subnet" "private_a" {
  filter {
    name   = "tag:Name"
    values = ["terraform-private-subnet-a"]
  }
}

data "aws_subnet" "private_b" {
  filter {
    name   = "tag:Name"
    values = ["terraform-private-subnet-b"]
  }
}

data "aws_route_table" "route_table_private_a" {
  subnet_id = data.aws_subnet.private_a.id
}

data "aws_route_table" "route_table_private_b" {
  subnet_id = data.aws_subnet.private_b.id
}

module "route_entry_private_a_ipv4_default" {
  source = "../../../modules/aws/vpc/aws_route_entry"

  route_table_id         = data.aws_route_table.route_table_private_a.id
  destination_cidr_block = "0.0.0.0/0"
  instance_id            = module.nat_ec2_instance_a.id
}

module "route_entry_private_b_ipv4_default" {
  source = "../../../modules/aws/vpc/aws_route_entry"

  route_table_id         = data.aws_route_table.route_table_private_b.id
  destination_cidr_block = "0.0.0.0/0"
  instance_id            = module.nat_ec2_instance_b.id
}

module "route_entry_private_a_ipv6_default" {
  source = "../../../modules/aws/vpc/aws_route_entry"

  route_table_id              = data.aws_route_table.route_table_private_a.id
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = data.aws_internet_gateway.main_internet_gateway.id
}

module "route_entry_private_b_ipv6_default" {
  source = "../../../modules/aws/vpc/aws_route_entry"

  route_table_id              = data.aws_route_table.route_table_private_b.id
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = data.aws_internet_gateway.main_internet_gateway.id
}
