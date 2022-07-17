
data "aws_subnet" "privatelink_a" {
  filter {
    name   = "tag:Name"
    values = ["terraform-privatelink-subnet-a"]
  }
}

data "aws_subnet" "privatelink_b" {
  filter {
    name   = "tag:Name"
    values = ["terraform-privatelink-subnet-b"]
  }
}

data "aws_route_table" "route_table_privatelink_a" {
  subnet_id = data.aws_subnet.privatelink_a.id
}

data "aws_route_table" "route_table_privatelink_b" {
  subnet_id = data.aws_subnet.privatelink_b.id
}

module "route_entry_privatelink_a_ipv4_default" {
  source = "../../../modules/aws/vpc/aws_route_entry"

  route_table_id         = data.aws_route_table.route_table_privatelink_a.id
  destination_cidr_block = "0.0.0.0/0"
  instance_id            = module.nat_ec2_instance_a.id
}

module "route_entry_privatelink_b_ipv4_default" {
  source = "../../../modules/aws/vpc/aws_route_entry"

  route_table_id         = data.aws_route_table.route_table_privatelink_b.id
  destination_cidr_block = "0.0.0.0/0"
  instance_id            = module.nat_ec2_instance_b.id
}

module "route_entry_privatelink_a_ipv6_default" {
  source = "../../../modules/aws/vpc/aws_route_entry"

  route_table_id              = data.aws_route_table.route_table_privatelink_a.id
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = data.aws_internet_gateway.main_internet_gateway.id
}

module "route_entry_privatelink_b_ipv6_default" {
  source = "../../../modules/aws/vpc/aws_route_entry"

  route_table_id              = data.aws_route_table.route_table_privatelink_b.id
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = data.aws_internet_gateway.main_internet_gateway.id
}
