
data "aws_iam_role" "role_flowlog" {
  name = "tf-FlowLog"
}

module "aws_flow_log_mainvpc" {
  source = "../../../modules/aws/vpc/aws_flow_log"

  traffic_type             = "ALL"
  iam_role_arn             = data.aws_iam_role.role_flowlog.arn
  log_destination_type     = "cloud-watch-logs"
  log_destination          = module.aws_cloudwatch_log_group_vpc.arn
  vpc_id                   = module.vpc.id
  max_aggregation_interval = 60

  tags = {
    Owner       = "Haris"
    Environment = "dev"
  }
}
