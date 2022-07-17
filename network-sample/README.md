# README

## TL;DR

Check [Requirements](#requirements).

Deploy the AWS resources defined in this repo by following these instructions:

 1. Logon to your AWS account using CLI (this depends on your setup,
 so you are on your own).

 2. Set your AWS environment variables, with the minimum of `AWS_PROFILE` and
 `AWS_DEFAULT_REGION`. See [Environment variables to configure the AWS CLI](https://docs.aws.amazon.com/cli/v1/userguide/cli-configure-envvars.html)
 for reference. Pick AWS region that suits your needs, e.g. `us-east-2`.

 3. Clone/download this repo, and change to `network-sample` directory, e.g.:

    ```bash
    git clone git@github.com:harisfauzi/shared-terraform-aws-examples.git
    cd shared-terraform-aws-examples/network-sample
    ```

 4. In this example we will assume your AWS account will be called networkaccount and
    the corresponding code for that AWS account is placed under
    `environments/networkaccount`. Setup the following variable to link them together:

    ```bash
    AWS_ACCOUNT=networkaccount
    ```

 5. The script `deploy-terraform.sh` was written to help you quickly deploy various modules.
    First you need to deploy the IAM resources:

    ```bash
    ./deploy-terraform.sh \
      --account ${AWS_ACCOUNT} \
      --action deploy \
      --item ${AWS_ACCOUNT}/iam \
      --dry-run false
    ```

 6. Deploy the VPC resources. Unfortunately terraform is not smart enough to automatically
    linked nested dependencies, so we need to deploy the modules in stages.
    First stage, deploy targeted modules:

    ```bash
    ./deploy-terraform.sh \
      --account ${AWS_ACCOUNT} \
      --action deploy \
      --item ${AWS_ACCOUNT}/vpc \
      --dry-run false \
      --target "module.route_table_public" \
      --target "module.route_table_private_a" \
      --target "module.route_table_private_b" \
      --target "module.route_table_isolated_a" \
      --target "module.route_table_isolated_b" \
      --target "module.route_table_privatelink_a" \
      --target "module.route_table_privatelink_b" \
      --target "module.network_acl_public" \
      --target "module.network_acl_private" \
      --target "module.network_acl_isolated" \
      --target "module.network_acl_privatelink"
    ```

    Second stage, deploy the rest of the modules:

    ```bash
    ./deploy-terraform.sh \
      --account ${AWS_ACCOUNT} \
      --action deploy \
      --item ${AWS_ACCOUNT}/vpc \
      --dry-run false
    ```

 7. Deploy the NAT instances:

    ```bash
    ./deploy-terraform.sh \
      --account ${AWS_ACCOUNT} \
      --action deploy \
      --item ${AWS_ACCOUNT}/nat \
      --dry-run false
    ```

 8. Deploy the test EC2 instance:

    ```bash
    ./deploy-terraform.sh \
      --account ${AWS_ACCOUNT} \
      --action deploy \
      --item ${AWS_ACCOUNT}/ec2 \
      --dry-run false
    ```

After deploying the test EC2 instance, you should be able to connect to it using
AWS System Manager Session Manager (wait for a couple of minutes before it is ready).
The instance Name should be `terraform-test-ec2-instance`. Refer to
[AWS Systems Manager Session Manager](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager.html)
on how to use Session Manager.

By successfully connecting to the test EC2 instance that proves that there is
network connectivity from the test EC2 instance --- which should be deployed in
private subnet whose no direct access to the Internet --- to the NAT instance
--- which should be deployed in public subnet -- and traffic from the test EC2
instance is masquareded by the NAT instance using Linux IP NAT translation.

## Destroy All Resources from this Repo

Change the `--action` flag to `destroy` and do it in reverse order:

 1. Destroy the EC2 instance:

    ```bash
    ./deploy-terraform.sh \
      --account ${AWS_ACCOUNT} \
      --action destroy \
      --item ${AWS_ACCOUNT}/ec2 \
      --dry-run false
    ```

 2. Destroy the NAT instances:

    ```bash
    ./deploy-terraform.sh \
      --account ${AWS_ACCOUNT} \
      --action destroy \
      --item ${AWS_ACCOUNT}/nat \
      --dry-run false
    ```

 3. Destroy the VPC resources:

    ```bash
    ./deploy-terraform.sh \
      --account ${AWS_ACCOUNT} \
      --action destroy \
      --item ${AWS_ACCOUNT}/vpc \
      --dry-run false
    ```

 4. Destroy the IAM resources:

    ```bash
    ./deploy-terraform.sh \
      --account ${AWS_ACCOUNT} \
      --action destroy \
      --item ${AWS_ACCOUNT}/iam \
      --dry-run false
    ```


## Requirements

This repo was written in Linux environment to be used with `terraform` command.
Minimum requirements:

- Linux
- [Terraform](https://www.terraform.io/downloads) CLI