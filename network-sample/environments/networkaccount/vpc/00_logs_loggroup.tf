module "aws_cloudwatch_log_group_vpc" {
  source = "../../../modules/aws/cloudwatch_logs/aws_cloudwatch_log_group"

  name              = "vpcflowlog"
  retention_in_days = 1

  tags = {
    Owner       = "ACME"
    Environment = "dev"
  }
}
