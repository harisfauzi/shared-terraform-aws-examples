module "iam_instance_profile_nat_instance" {
  source = "../../../modules/aws/iam/aws_iam_instance_profile"

  name = "tf-NATInstance"
  role = module.iam_role_nat_instance.id

  tags = {
    Owner       = "ACME"
    Environment = "network"
  }
}

module "iam_instance_profile_generic_instance" {
  source = "../../../modules/aws/iam/aws_iam_instance_profile"

  name = "tf-GenericInstance"
  role = module.iam_role_generic_instance.id

  tags = {
    Owner       = "ACME"
    Environment = "network"
  }
}
