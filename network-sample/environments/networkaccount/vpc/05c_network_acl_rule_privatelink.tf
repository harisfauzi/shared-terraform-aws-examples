
module "network_acl_rule_privatelink_ipv4_ingress_19990" {
  source = "../../../modules/aws/vpc/aws_network_acl_rule"

  network_acl_id = module.network_acl_privatelink.id
  rule_number    = 19990
  rule_action    = "allow"
  protocol       = -1 # all
  direction      = "ingress"
  cidr_block     = "0.0.0.0/0"
}

module "network_acl_rule_privatelink_ipv6_ingress_19996" {
  source = "../../../modules/aws/vpc/aws_network_acl_rule"

  network_acl_id  = module.network_acl_privatelink.id
  rule_number     = 19996
  rule_action     = "allow"
  protocol        = -1 # all
  direction       = "ingress"
  ipv6_cidr_block = "::/0"
}

module "network_acl_rule_privatelink_ipv4_egress_31990" {
  source = "../../../modules/aws/vpc/aws_network_acl_rule"

  network_acl_id = module.network_acl_privatelink.id
  rule_number    = 31990
  rule_action    = "allow"
  protocol       = -1 # All
  direction      = "egress"
  cidr_block     = "0.0.0.0/0"
}

module "network_acl_rule_privatelink_ipv4_egress_31996" {
  source = "../../../modules/aws/vpc/aws_network_acl_rule"

  network_acl_id  = module.network_acl_privatelink.id
  rule_number     = 31996
  rule_action     = "allow"
  protocol        = -1 # All
  direction       = "egress"
  ipv6_cidr_block = "::/0"
}
