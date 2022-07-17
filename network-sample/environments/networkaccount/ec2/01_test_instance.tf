data "aws_ami" "latest_az2_ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.?.????????.?-x86_64-ebs"]
  }
}

data "aws_iam_instance_profile" "generic_profile" {
  name = "tf-GenericInstance"
}

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

data "aws_security_group" "generic_instance_sg" {
  filter {
    name   = "tag:Name"
    values = ["tf-sg-generic-instance"]
  }
}


module "test_ec2_instance" {
  # source = "github.com/harisfauzi/shared-terraform-aws.git//modules/aws/vpc/aws_network_acl?ref=develop"
  source = "../../../modules/aws/ec2/aws_instance"

  name                        = "terraform-test-ec2-instance"
  ami                         = data.aws_ami.latest_az2_ami.id
  associate_public_ip_address = false
  iam_instance_profile        = data.aws_iam_instance_profile.generic_profile.name
  instance_type               = "t3a.micro"
  # key_name                    = "haris@fauzi.org-key"
  source_dest_check           = true
  subnet_id                   = data.aws_subnet.private_b.id
  user_data                   = <<EOT
#!/bin/bash

# Yum package routine
yum install -y https://s3.us-east-2.amazonaws.com/amazon-ssm-us-east-2/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y jq
yum -y upgrade

# Install cron
/root/crontab-reboot.sh
EOT
  vpc_security_group_ids = [
    data.aws_security_group.generic_instance_sg.id
  ]

  tags = {
    Owner       = "Haris"
    Environment = "dev"
  }
}
