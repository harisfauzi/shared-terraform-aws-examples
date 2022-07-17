data "aws_ami" "latest_az2_ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.?.????????.?-x86_64-ebs"]
  }
}

data "aws_iam_instance_profile" "nat_profile" {
  name = "tf-NATInstance"
}

data "aws_subnet" "public_a" {
  filter {
    name   = "tag:Name"
    values = ["terraform-public-subnet-a"]
  }
}

data "aws_subnet" "public_b" {
  filter {
    name   = "tag:Name"
    values = ["terraform-public-subnet-b"]
  }
}

data "aws_security_group" "nat_instance_sg" {
  filter {
    name   = "tag:Name"
    values = ["tf-sg-nat-instance"]
  }
}

module "nat_ec2_instance_a" {
  source = "../../../modules/aws/ec2/aws_instance"

  name                        = "terraform-nat-ec2-instance-a"
  ami                         = data.aws_ami.latest_az2_ami.id
  associate_public_ip_address = true
  iam_instance_profile        = data.aws_iam_instance_profile.nat_profile.name
  instance_type               = "t3a.nano"
  source_dest_check           = false
  subnet_id                   = data.aws_subnet.public_a.id
  user_data                   = <<EOT
#!/bin/bash
# NAT routine
echo 1 > /proc/sys/net/ipv4/ip_forward
echo 0 > /proc/sys/net/ipv4/conf/eth0/send_redirects
/sbin/iptables -t nat -A POSTROUTING -o eth0 -s 0.0.0.0/0 -j MASQUERADE
/sbin/iptables-save > /etc/sysconfig/iptables
mkdir -p /etc/sysctl.d/
cat <<EOF > /etc/sysctl.d/nat.conf
net.ipv4.ip_forward = 1
net.ipv4.conf.eth0.send_redirects = 0
EOF

# Cleanup scripts
cat <<EOF > /root/cleanup.sh
package-cleanup --oldkernels --count=1 -y
/sbin/iptables-restore < /etc/sysconfig/iptables
EOF
chmod +x /root/cleanup.sh

# Cron install script
cat <<EOF > /root/crontab-reboot.sh
echo "@reboot /root/cleanup.sh" | crontab -
EOF
chmod +x /root/crontab-reboot.sh

# Yum package routine
yum install -y https://s3.us-east-2.amazonaws.com/amazon-ssm-us-east-2/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y jq
yum -y upgrade

# Install cron
/root/crontab-reboot.sh

# Restart
shutdown -r now
EOT
  vpc_security_group_ids = [
    data.aws_security_group.nat_instance_sg.id
  ]

  tags = {
    Owner       = "ACME"
    Environment = "dev"
  }
}


module "nat_ec2_instance_b" {
  source = "../../../modules/aws/ec2/aws_instance"

  name                        = "terraform-nat-ec2-instance-b"
  ami                         = data.aws_ami.latest_az2_ami.id
  associate_public_ip_address = true
  iam_instance_profile        = data.aws_iam_instance_profile.nat_profile.name
  instance_type               = "t3a.nano"
  source_dest_check           = false
  subnet_id                   = data.aws_subnet.public_b.id
  user_data                   = <<EOT
#!/bin/bash
# NAT routine
echo 1 > /proc/sys/net/ipv4/ip_forward
echo 0 > /proc/sys/net/ipv4/conf/eth0/send_redirects
/sbin/iptables -t nat -A POSTROUTING -o eth0 -s 0.0.0.0/0 -j MASQUERADE
/sbin/iptables-save > /etc/sysconfig/iptables
mkdir -p /etc/sysctl.d/
cat <<EOF > /etc/sysctl.d/nat.conf
net.ipv4.ip_forward = 1
net.ipv4.conf.eth0.send_redirects = 0
EOF

# Cleanup scripts
cat <<EOF > /root/cleanup.sh
package-cleanup --oldkernels --count=1 -y
/sbin/iptables-restore < /etc/sysconfig/iptables
EOF
chmod +x /root/cleanup.sh

# Cron install script
cat <<EOF > /root/crontab-reboot.sh
echo "@reboot /root/cleanup.sh" | crontab -
EOF
chmod +x /root/crontab-reboot.sh

# Yum package routine
yum install -y https://s3.us-east-2.amazonaws.com/amazon-ssm-us-east-2/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y jq
yum -y upgrade

# Install cron
/root/crontab-reboot.sh

# Restart
shutdown -r now
EOT
  vpc_security_group_ids = [
    data.aws_security_group.nat_instance_sg.id
  ]

  tags = {
    Owner       = "ACME"
    Environment = "dev"
  }
}
