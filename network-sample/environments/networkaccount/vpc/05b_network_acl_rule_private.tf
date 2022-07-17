module "network_acl_rule_private_ipv4_ingress_00100" {
  source = "../../../modules/aws/vpc/aws_network_acl_rule"

  network_acl_id = module.network_acl_private.id
  rule_number    = 100
  rule_action    = "allow"
  protocol       = 6 # TCP
  direction      = "ingress"
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}

module "network_acl_rule_private_ipv6_ingress_00106" {
  source = "../../../modules/aws/vpc/aws_network_acl_rule"

  network_acl_id  = module.network_acl_private.id
  rule_number     = 106
  rule_action     = "allow"
  protocol        = 6 # TCP
  direction       = "ingress"
  ipv6_cidr_block = "::/0"
  from_port       = 1024
  to_port         = 65535
}

module "network_acl_rule_private_ipv4_ingress_00110" {
  source = "../../../modules/aws/vpc/aws_network_acl_rule"

  network_acl_id = module.network_acl_private.id
  rule_number    = 110
  rule_action    = "allow"
  protocol       = 17 # UDP
  direction      = "ingress"
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}

module "network_acl_rule_private_ipv6_ingress_00116" {
  source = "../../../modules/aws/vpc/aws_network_acl_rule"

  network_acl_id  = module.network_acl_private.id
  rule_number     = 116
  rule_action     = "allow"
  protocol        = 17 # UDP
  direction       = "ingress"
  ipv6_cidr_block = "::/0"
  from_port       = 1024
  to_port         = 65535
}

module "network_acl_rule_private_ipv4_ingress_00120" {
  source = "../../../modules/aws/vpc/aws_network_acl_rule"

  network_acl_id = module.network_acl_private.id
  rule_number    = 120
  rule_action    = "allow"
  protocol       = 1 # ICMP
  direction      = "ingress"
  cidr_block     = "0.0.0.0/0"
  icmp_type      = 0
  icmp_code      = 0
}

module "network_acl_rule_private_ipv6_ingress_00126" {
  source = "../../../modules/aws/vpc/aws_network_acl_rule"

  network_acl_id  = module.network_acl_private.id
  rule_number     = 126
  rule_action     = "allow"
  protocol        = 1 # ICMP
  direction       = "ingress"
  ipv6_cidr_block = "::/0"
  icmp_type       = 0
  icmp_code       = 0
}

module "network_acl_rule_private_ipv4_ingress_00130" {
  source = "../../../modules/aws/vpc/aws_network_acl_rule"

  network_acl_id = module.network_acl_private.id
  rule_number    = 130
  rule_action    = "allow"
  protocol       = 1 # ICMP
  direction      = "ingress"
  cidr_block     = "0.0.0.0/0"
  icmp_type      = 8
  icmp_code      = 0
}

module "network_acl_rule_private_ipv6_ingress_00136" {
  source = "../../../modules/aws/vpc/aws_network_acl_rule"

  network_acl_id  = module.network_acl_private.id
  rule_number     = 136
  rule_action     = "allow"
  protocol        = 1 # ICMP
  direction       = "ingress"
  ipv6_cidr_block = "::/0"
  icmp_type       = 8
  icmp_code       = 0
}

module "network_acl_rule_private_ipv4_egress_25000" {
  source = "../../../modules/aws/vpc/aws_network_acl_rule"

  network_acl_id = module.network_acl_private.id
  rule_number    = 25000
  rule_action    = "allow"
  protocol       = 6 # TCP
  direction      = "egress"
  cidr_block     = "10.0.0.0/8"
  from_port      = 53
  to_port        = 53
}

module "network_acl_rule_private_ipv4_egress_25010" {
  source = "../../../modules/aws/vpc/aws_network_acl_rule"

  network_acl_id = module.network_acl_private.id
  rule_number    = 25010
  rule_action    = "allow"
  protocol       = 17 # UDP
  direction      = "egress"
  cidr_block     = "10.0.0.0/8"
  from_port      = 53
  to_port        = 53
}

module "network_acl_rule_private_ipv4_egress_25020" {
  source = "../../../modules/aws/vpc/aws_network_acl_rule"

  network_acl_id = module.network_acl_private.id
  rule_number    = 25020
  rule_action    = "allow"
  protocol       = 6 # TCP
  direction      = "egress"
  cidr_block     = "172.16.0.0/12"
  from_port      = 53
  to_port        = 53
}

module "network_acl_rule_private_ipv4_egress_25030" {
  source = "../../../modules/aws/vpc/aws_network_acl_rule"

  network_acl_id = module.network_acl_private.id
  rule_number    = 25030
  rule_action    = "allow"
  protocol       = 17 # UDP
  direction      = "egress"
  cidr_block     = "172.16.0.0/12"
  from_port      = 53
  to_port        = 53
}

module "network_acl_rule_private_ipv4_egress_25040" {
  source = "../../../modules/aws/vpc/aws_network_acl_rule"

  network_acl_id = module.network_acl_private.id
  rule_number    = 25040
  rule_action    = "allow"
  protocol       = 6 # TCP
  direction      = "egress"
  cidr_block     = "192.168.0.0/16"
  from_port      = 53
  to_port        = 53
}

module "network_acl_rule_private_ipv4_egress_25050" {
  source = "../../../modules/aws/vpc/aws_network_acl_rule"

  network_acl_id = module.network_acl_private.id
  rule_number    = 25050
  rule_action    = "allow"
  protocol       = 17 # UDP
  direction      = "egress"
  cidr_block     = "192.168.0.0/16"
  from_port      = 53
  to_port        = 53
}

module "network_acl_rule_private_ipv4_egress_25060" {
  source = "../../../modules/aws/vpc/aws_network_acl_rule"

  network_acl_id = module.network_acl_private.id
  rule_number    = 25060
  rule_action    = "allow"
  protocol       = 17 # UDP
  direction      = "egress"
  cidr_block     = "192.168.0.0/16"
  from_port      = 123
  to_port        = 123
}

module "network_acl_rule_private_ipv4_egress_25070" {
  source = "../../../modules/aws/vpc/aws_network_acl_rule"

  network_acl_id = module.network_acl_private.id
  rule_number    = 25070
  rule_action    = "allow"
  protocol       = 6 # TCP
  direction      = "egress"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}

module "network_acl_rule_private_ipv4_egress_25076" {
  source = "../../../modules/aws/vpc/aws_network_acl_rule"

  network_acl_id  = module.network_acl_private.id
  rule_number     = 25076
  rule_action     = "allow"
  protocol        = 6 # TCP
  direction       = "egress"
  ipv6_cidr_block = "::/0"
  from_port       = 80
  to_port         = 80
}

module "network_acl_rule_private_ipv4_egress_25080" {
  source = "../../../modules/aws/vpc/aws_network_acl_rule"

  network_acl_id = module.network_acl_private.id
  rule_number    = 25080
  rule_action    = "allow"
  protocol       = 6 # TCP
  direction      = "egress"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}

module "network_acl_rule_private_ipv4_egress_25086" {
  source = "../../../modules/aws/vpc/aws_network_acl_rule"

  network_acl_id  = module.network_acl_private.id
  rule_number     = 25086
  rule_action     = "allow"
  protocol        = 6 # TCP
  direction       = "egress"
  ipv6_cidr_block = "::/0"
  from_port       = 443
  to_port         = 443
}

module "network_acl_rule_private_ipv4_egress_25090" {
  source = "../../../modules/aws/vpc/aws_network_acl_rule"

  network_acl_id = module.network_acl_private.id
  rule_number    = 25090
  rule_action    = "allow"
  protocol       = 1 # ICMP
  direction      = "egress"
  cidr_block     = "0.0.0.0/0"
  icmp_type      = 0
  icmp_code      = 0
}

module "network_acl_rule_private_ipv4_egress_25096" {
  source = "../../../modules/aws/vpc/aws_network_acl_rule"

  network_acl_id  = module.network_acl_private.id
  rule_number     = 25096
  rule_action     = "allow"
  protocol        = 1 # ICMP
  direction       = "egress"
  ipv6_cidr_block = "::/0"
  icmp_type       = 0
  icmp_code       = 0
}

module "network_acl_rule_private_ipv4_egress_25100" {
  source = "../../../modules/aws/vpc/aws_network_acl_rule"

  network_acl_id = module.network_acl_private.id
  rule_number    = 25100
  rule_action    = "allow"
  protocol       = 1 # ICMP
  direction      = "egress"
  cidr_block     = "0.0.0.0/0"
  icmp_type      = 8
  icmp_code      = 0
}

module "network_acl_rule_private_ipv4_egress_25106" {
  source = "../../../modules/aws/vpc/aws_network_acl_rule"

  network_acl_id  = module.network_acl_private.id
  rule_number     = 25106
  rule_action     = "allow"
  protocol        = 1 # ICMP
  direction       = "egress"
  ipv6_cidr_block = "::/0"
  icmp_type       = 8
  icmp_code       = 0
}

# module "network_acl_rule_private_ipv4_egress_30110" {
#   source      = "../../../modules/aws/vpc/aws_network_acl_rule"

#   network_acl_id  = module.network_acl_private.id
#   rule_number     = 30110
#   rule_action     = "allow"
#   protocol        = 17  # UDP
#   direction       = "egress"
#   cidr_block      = "0.0.0.0/0"
# }

# module "network_acl_rule_private_ipv4_egress_30106" {
#   source      = "../../../modules/aws/vpc/aws_network_acl_rule"

#   network_acl_id  = module.network_acl_private.id
#   rule_number     = 30106
#   rule_action     = "allow"
#   protocol        = 6  # TCP
#   direction       = "egress"
#   ipv6_cidr_block = "::/0"
# }

# module "network_acl_rule_private_ipv4_egress_30116" {
#   source      = "../../../modules/aws/vpc/aws_network_acl_rule"

#   network_acl_id  = module.network_acl_private.id
#   rule_number     = 30116
#   rule_action     = "allow"
#   protocol        = 17  # UDP
#   direction       = "egress"
#   ipv6_cidr_block = "::/0"
# }
