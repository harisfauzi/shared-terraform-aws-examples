module "iam_role_nat_instance" {
  source = "../../../modules/aws/iam/aws_iam_role"

  name = "tf-NATInstance"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  description = "IAM Role for NAT Instance"
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  ]
  inline_policies = [
    {
      name = "policy-NATInstance"
      policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Action = [
              "ec2:DescribeAccountAttributes",
              "ec2:CreateRoute",
              "ec2:ReplaceRoute",
              "ec2:StartInstances",
              "ec2:StopInstances",
              "ec2:DescribeRouteTables",
            ]
            Effect   = "Allow"
            Resource = "*"
          },
        ]
      })
    }
  ]

  tags = {
    Owner       = "Haris"
    Environment = "dev"
  }
}

# module "iam_role_policy_nat_instance" {
#   source      = "../../../modules/aws/iam/aws_iam_role_policy"

#   name = "policy-NATInstance"
#   role = module.iam_role_nat_instance.id

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = [
#           "ec2:DescribeAccountAttributes",
#           "ec2:CreateRoute",
#           "ec2:ReplaceRoute",
#           "ec2:StartInstances",
#           "ec2:StopInstances",
#           "ec2:DescribeRouteTables",
#         ]
#         Effect   = "Allow"
#         Resource = "*"
#       },
#     ]
#   })
# }

module "iam_role_flowlog" {
  source = "../../../modules/aws/iam/aws_iam_role"

  name = "tf-FlowLog"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "vpc-flow-logs.amazonaws.com"
        }
      },
    ]
  })
  description = "IAM Role for VPC FlowLog"
  inline_policies = [
    {
      name = "policy-FlowLog"
      policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Action = [
              "logs:CreateLogGroup",
              "logs:CreateLogStream",
              "logs:PutLogEvents",
              "logs:DescribeLogGroups",
              "logs:DescribeLogStreams",
            ]
            Effect   = "Allow"
            Resource = "*"
          },
        ]
      })
    }
  ]

  tags = {
    Owner       = "Haris"
    Environment = "dev"
  }
}

module "iam_role_generic_instance" {
  source = "../../../modules/aws/iam/aws_iam_role"

  name = "tf-GenericInstance"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  description = "IAM Role for Generic EC2 Instance"
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  ]
  inline_policies = [
    {
      name = "policy-S3access"
      policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Action = [
              "s3:ListBucket",
              "s3:ListBucketMultipartUploads",
            ]
            Effect   = "Allow"
            Resource = "*"
          },
          {
            Action = [
              "s3:PutObject",
              "s3:PutObjectAcl",
              "s3:PutObjectRetention",
              "s3:PutObjectTagging",
              "s3:PutObjectVersionAcl",
              "s3:PutObjectVersionTagging",
              "s3:DeleteObject",
              "s3:DeleteObjectTagging",
              "s3:DeleteObjectVersion",
              "s3:DeleteObjectVersionTagging",
              "s3:GetObject",
              "s3:GetObjectAcl",
              "s3:GetObjectTagging",
              "s3:GetObjectVersion",
              "s3:GetObjectVersionAcl",
              "s3:GetObjectVersionTagging",
              "s3:ListMultipartUploadParts",
              "s3:AbortMultipartUpload",
            ]
            Effect   = "Allow"
            Resource = "*"
          },
        ]
      })
      max_session_duration = 7200
    }
  ]

  tags = {
    Owner       = "Haris"
    Environment = "dev"
  }
}

