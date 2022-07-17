module "security_group_nat_instance" {
  source = "../../../modules/aws/vpc/aws_security_group"

  name        = "tf-sg-nat-instance"
  vpc_id      = module.vpc.id
  description = "SG for the NAT Instance"

  tags = {
    Owner       = "ACME"
    Environment = "network"
  }

  egresses = [
    {
      description = "Allow all outgoing IPv4"
      protocol    = -1
      from_port   = 0
      to_port     = 0
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description      = "Allow all outgoing IPv6"
      protocol         = -1
      from_port        = 0
      to_port          = 0
      ipv6_cidr_blocks = ["::/0"]
    }
  ]

  ingresses = [
    {
      description = "Allow incoming access only from internal addresses"
      protocol    = -1
      from_port   = 0
      to_port     = 0
      cidr_blocks = [
        "10.0.0.0/8",
        "172.16.0.0/12",
        "192.168.0.0/16"
      ]
    },
    {
      description = "Allow SSH from home"
      protocol    = 6
      from_port   = 22
      to_port     = 22
      cidr_blocks = [
        "193.116.124.175/32"
      ]
    }
  ]
}


module "security_group_generic_instance" {
  source = "../../../modules/aws/vpc/aws_security_group"

  name        = "tf-sg-generic-instance"
  vpc_id      = module.vpc.id
  description = "SG for Generic EC2 Instance"

  tags = {
    Owner       = "ACME"
    Environment = "network"
  }

  egresses = [
    {
      description = "Allow outgoing DNS TCP:53 to RFC1918 IPv4"
      protocol    = 6
      from_port   = 53
      to_port     = 53
      cidr_blocks = [
        "10.0.0.0/8",
        "172.16.0.0/12",
        "192.168.0.0/16"
      ]
    },
    {
      description = "Allow outgoing DNS UDP:53 to RFC1918 IPv4"
      protocol    = 17
      from_port   = 53
      to_port     = 53
      cidr_blocks = [
        "10.0.0.0/8",
        "172.16.0.0/12",
        "192.168.0.0/16"
      ]
    },
    {
      description = "Allow outgoing HTTP TCP:80 to all IPv4"
      protocol    = 6
      from_port   = 80
      to_port     = 80
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "Allow outgoing HTTP TCP:443 to all IPv4"
      protocol    = 6
      from_port   = 443
      to_port     = 443
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "Allow outgoing QUIK UDP:443 to all IPv4"
      protocol    = 17
      from_port   = 443
      to_port     = 443
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "Allow outgoing ICMP echo:request (ping) to all IPv4"
      protocol    = 1
      from_port   = 0
      to_port     = 0
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "Allow outgoing ICMP echo:reply (ping) to all IPv4"
      protocol    = 1
      from_port   = 8
      to_port     = 0
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description      = "Allow outgoing HTTP TCP:80 to all IPv6"
      protocol         = 6
      from_port        = 80
      to_port          = 80
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      description      = "Allow outgoing HTTPS TCP:443 to all IPv6"
      protocol         = 6
      from_port        = 443
      to_port          = 443
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      description      = "Allow outgoing QUIK UDP:443 to all IPv6"
      protocol         = 17
      from_port        = 443
      to_port          = 443
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      description      = "Allow outgoing QUIK UDP:443 to all IPv6"
      protocol         = 17
      from_port        = 443
      to_port          = 443
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      description      = "Allow outgoing ICMP echo:request (ping) to all IPv6"
      protocol         = 1
      from_port        = 0
      to_port          = 0
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      description      = "Allow outgoing ICMP echo:reply (ping) to all IPv6"
      protocol         = 1
      from_port        = 8
      to_port          = 0
      ipv6_cidr_blocks = ["::/0"]
    }
  ]

  ingresses = [
    {
      description = "Allow incoming access only loopback address IPv4"
      protocol    = -1
      from_port   = 0
      to_port     = 0
      cidr_blocks = ["127.0.0.1/32"]
    },
    {
      description = "Allow incoming ICMP echo:request all IPv4"
      protocol    = 1
      from_port   = 0
      to_port     = 0
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "Allow incoming ICMP echo:reply all IPv4"
      protocol    = 1
      from_port   = 8
      to_port     = 0
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description      = "Allow incoming access only loopback address IPv6"
      protocol         = -1
      from_port        = 0
      to_port          = 0
      ipv6_cidr_blocks = ["::1/128"]
    },
    {
      description      = "Allow incoming ICMP echo:request all IPv6"
      protocol         = 1
      from_port        = 0
      to_port          = 0
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      description      = "Allow incoming ICMP echo:reply all IPv6"
      protocol         = 1
      from_port        = 8
      to_port          = 0
      ipv6_cidr_blocks = ["::/0"]
    }
  ]
}
