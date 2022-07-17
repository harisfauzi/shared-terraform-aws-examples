# module "network_acl_rule_public_ipv4_ingress_00100" {
#   source      = "../../../modules/aws/vpc/aws_network_acl_rule"

#   network_acl_id  = module.network_acl_public.id
#   rule_number     = 100
#   rule_action     = "allow"
#   protocol        = 6  # TCP
#   direction       = "ingress"
#   cidr_block      = "0.0.0.0/0"
#   from_port       = 1024
#   to_port         = 65535
# }

# module "network_acl_rule_public_ipv6_ingress_00106" {
#   source      = "../../../modules/aws/vpc/aws_network_acl_rule"

#   network_acl_id  = module.network_acl_public.id
#   rule_number     = 106
#   rule_action     = "allow"
#   protocol        = 6  # TCP
#   direction       = "ingress"
#   ipv6_cidr_block = "::/0"
#   from_port       = 1024
#   to_port         = 65535
# }

# module "network_acl_rule_public_ipv4_ingress_00110" {
#   source      = "../../../modules/aws/vpc/aws_network_acl_rule"

#   network_acl_id  = module.network_acl_public.id
#   rule_number     = 110
#   rule_action     = "allow"
#   protocol        = 17  # UDP
#   direction       = "ingress"
#   cidr_block      = "0.0.0.0/0"
#   from_port       = 1024
#   to_port         = 65535
# }

# module "network_acl_rule_public_ipv6_ingress_00116" {
#   source      = "../../../modules/aws/vpc/aws_network_acl_rule"

#   network_acl_id  = module.network_acl_public.id
#   rule_number     = 116
#   rule_action     = "allow"
#   protocol        = 17  # UDP
#   direction       = "ingress"
#   ipv6_cidr_block = "::/0"
#   from_port       = 1024
#   to_port         = 65535
# }

module "network_acl_rule_public_ipv4_ingress_10010" {
  source = "../../../modules/aws/vpc/aws_network_acl_rule"

  network_acl_id = module.network_acl_public.id
  rule_number    = 10010
  rule_action    = "allow"
  protocol       = 6 # tcp
  direction      = "ingress"
  cidr_block     = "193.116.124.175/32"
  from_port      = 22
  to_port        = 22
}

module "network_acl_rule_public_ipv4_ingress_10020" {
  source = "../../../modules/aws/vpc/aws_network_acl_rule"

  network_acl_id = module.network_acl_public.id
  rule_number    = 10020
  rule_action    = "deny"
  protocol       = 6 # tcp
  direction      = "ingress"
  cidr_block     = "0.0.0.0/0"
  from_port      = 22
  to_port        = 22
}

module "network_acl_rule_public_ipv4_ingress_19990" {
  source = "../../../modules/aws/vpc/aws_network_acl_rule"

  network_acl_id = module.network_acl_public.id
  rule_number    = 19990
  rule_action    = "allow"
  protocol       = -1 # all
  direction      = "ingress"
  cidr_block     = "0.0.0.0/0"
}

module "network_acl_rule_public_ipv6_ingress_19996" {
  source = "../../../modules/aws/vpc/aws_network_acl_rule"

  network_acl_id  = module.network_acl_public.id
  rule_number     = 19996
  rule_action     = "allow"
  protocol        = -1 # all
  direction       = "ingress"
  ipv6_cidr_block = "::/0"
}

# module "network_acl_rule_public_ipv4_egress_30100" {
#   source      = "../../../modules/aws/vpc/aws_network_acl_rule"

#   network_acl_id  = module.network_acl_public.id
#   rule_number     = 30100
#   rule_action     = "allow"
#   protocol        = 6  # TCP
#   direction       = "egress"
#   cidr_block      = "0.0.0.0/0"
# }

# module "network_acl_rule_public_ipv4_egress_30110" {
#   source      = "../../../modules/aws/vpc/aws_network_acl_rule"

#   network_acl_id  = module.network_acl_public.id
#   rule_number     = 30110
#   rule_action     = "allow"
#   protocol        = 17  # UDP
#   direction       = "egress"
#   cidr_block      = "0.0.0.0/0"
# }

# module "network_acl_rule_public_ipv4_egress_30106" {
#   source      = "../../../modules/aws/vpc/aws_network_acl_rule"

#   network_acl_id  = module.network_acl_public.id
#   rule_number     = 30106
#   rule_action     = "allow"
#   protocol        = 6  # TCP
#   direction       = "egress"
#   ipv6_cidr_block = "::/0"
# }

# module "network_acl_rule_public_ipv4_egress_30116" {
#   source      = "../../../modules/aws/vpc/aws_network_acl_rule"

#   network_acl_id  = module.network_acl_public.id
#   rule_number     = 30116
#   rule_action     = "allow"
#   protocol        = 17  # UDP
#   direction       = "egress"
#   ipv6_cidr_block = "::/0"
# }

module "network_acl_rule_public_ipv4_egress_31990" {
  source = "../../../modules/aws/vpc/aws_network_acl_rule"

  network_acl_id = module.network_acl_public.id
  rule_number    = 31990
  rule_action    = "allow"
  protocol       = -1 # All
  direction      = "egress"
  cidr_block     = "0.0.0.0/0"
}

module "network_acl_rule_public_ipv4_egress_31996" {
  source = "../../../modules/aws/vpc/aws_network_acl_rule"

  network_acl_id  = module.network_acl_public.id
  rule_number     = 31996
  rule_action     = "allow"
  protocol        = -1 # All
  direction       = "egress"
  ipv6_cidr_block = "::/0"
}
