#!/bin/bash

set -o pipefail +x

ARG_ARRAY=()

get_short_term_credentials() {
    AWS_ACCESS_KEY=$(grep -A6 "\[${SHORT_AWS_PROFILE}\]" ~/.aws/credentials | grep aws_access_key_id | awk '{print $NF}')
    AWS_SECRET_KEY=$(grep -A6 "\[${SHORT_AWS_PROFILE}\]" ~/.aws/credentials | grep aws_secret_access_key | awk '{print $NF}')
    AWS_SECURITY_TOKEN=$(grep -A6 "\[${SHORT_AWS_PROFILE}\]" ~/.aws/credentials | grep aws_session_token | awk '{print $NF}')
    AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY
    AWS_SECRET_ACCESS_KEY=$AWS_SECRET_KEY
    AWS_SESSION_TOKEN=$AWS_SECURITY_TOKEN
    export AWS_ACCESS_KEY AWS_SECRET_KEY AWS_SECURITY_TOKEN AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN
    # write_credentials "terraform/tffiles/deployercredentials" "faodeployer" "${AWS_ACCESS_KEY}" "${AWS_SECRET_KEY}" "${AWS_SECURITY_TOKEN}"
}

get_long_term_credentials() {
    AWS_ACCESS_KEY=$(grep -A2 "\[${LONG_AWS_PROFILE}\]" ~/.aws/credentials | grep aws_access_key_id | awk '{print $NF}')
    AWS_SECRET_KEY=$(grep -A2 "\[${LONG_AWS_PROFILE}\]" ~/.aws/credentials | grep aws_secret_access_key | awk '{print $NF}')
    AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY
    AWS_SECRET_ACCESS_KEY=$AWS_SECRET_KEY
    export AWS_ACCESS_KEY AWS_SECRET_KEY AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY
    # write_credentials "terraform/tffiles/deployercredentials" "faodeployer" "${AWS_ACCESS_KEY}" "${AWS_SECRET_KEY}" "${AWS_SECURITY_TOKEN}"
}

write_credentials()
{
  local credentials_file=$1
  local credentials_profile=$2
  local credentials_access_key=$3
  local credentials_secret_key=$4
  local credentials_token=$5

  cat >"${credentials_file}"<<EOF
[${credentials_profile}]
aws_access_key_id = ${credentials_access_key}
aws_secret_access_key = ${credentials_secret_key}
aws_session_token = ${credentials_token}
EOF
}

assume_backend_role() {
    echo "Calling assume_backend_role"
    local BACKEND_AWS_ACCOUNT=networkaccount
    local BACKEND_PROFILE="$1"
    local AWS_ACCOUNT_ID=$(aws ssm get-parameter --region us-west-2 --profile "${BACKEND_PROFILE}" --name /target/account/${BACKEND_AWS_ACCOUNT} --query "Parameter.Value" --output text)
    echo "Using $AWS_ACCOUNT_ID AWS Account ID for backend"
    local AWS_ROLE_TO_ASSUME=FAODeployerRole

    local ROLE_ARN_TO_ASSUME="arn:aws:iam::${AWS_ACCOUNT_ID}:role/${AWS_ROLE_TO_ASSUME}"
    local IDENTITY_SESSION=$(aws sts get-caller-identity | jq -r '.Arn' | awk -F'/' '{print $NF}')
    local ROLE_SESSION_NAME="${IDENTITY_SESSION}@$(date +%s)"

    local ASSUMED_CREDENTIALS=$(aws sts assume-role --profile "${BACKEND_PROFILE}" --region us-east-1 \
        --role-arn "${ROLE_ARN_TO_ASSUME}" \
        --role-session-name "${ROLE_SESSION_NAME}")

    # Terraform backend
    TF_VAR_backend_access_key=$(echo ${ASSUMED_CREDENTIALS} | jq -r '.Credentials.AccessKeyId')
    TF_VAR_backend_secret_key=$(echo ${ASSUMED_CREDENTIALS} | jq -r '.Credentials.SecretAccessKey')
    TF_VAR_backend_token=$(echo ${ASSUMED_CREDENTIALS} | jq -r '.Credentials.SessionToken')
    export TF_VAR_backend_access_key TF_VAR_backend_secret_key TF_VAR_backend_token

    # write_credentials "terraform/tffiles/backendcredentials" "faobackend" "${TF_VAR_backend_access_key}" "${TF_VAR_backend_secret_key}" "${TF_VAR_backend_token}"
}

assume_role() {
    # Remove previous credentials
    unset AWS_ACCESS_KEY AWS_SECRET_KEY AWS_SECURITY_TOKEN
    unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN
    echo "Calling assume_role"
    local AWS_ACCOUNT_ID=$(aws ssm get-parameter --region us-west-2 --name /target/account/${AWS_ACCOUNT} --query "Parameter.Value" --output text)
    echo "Using $AWS_ACCOUNT_ID AWS Account ID"
    local AWS_ROLE_TO_ASSUME=FAODeployerRole

    local ROLE_ARN_TO_ASSUME="arn:aws:iam::${AWS_ACCOUNT_ID}:role/${AWS_ROLE_TO_ASSUME}"
    local IDENTITY_SESSION=$(aws sts get-caller-identity | jq -r '.Arn' | awk -F'/' '{print $NF}')
    local ROLE_SESSION_NAME="${IDENTITY_SESSION}@$(date +%s)"
    local LOCAL_PROFILE=()
    if [ "z${LONG_AWS_PROFILE}" != "z" ]; then
      LOCAL_PROFILE+=("--profile")
      LOCAL_PROFILE+=("${LONG_AWS_PROFILE}")
    fi
    local ASSUMED_CREDENTIALS=$(aws sts assume-role ${LOCAL_PROFILE[@]} --region us-east-1 \
        --role-arn "${ROLE_ARN_TO_ASSUME}" \
        --role-session-name "${ROLE_SESSION_NAME}")

    # Ansible
    AWS_ACCESS_KEY=$(echo ${ASSUMED_CREDENTIALS} | jq -r '.Credentials.AccessKeyId')
    AWS_SECRET_KEY=$(echo ${ASSUMED_CREDENTIALS} | jq -r '.Credentials.SecretAccessKey')
    AWS_SECURITY_TOKEN=$(echo ${ASSUMED_CREDENTIALS} | jq -r '.Credentials.SessionToken')
    export AWS_ACCESS_KEY AWS_SECRET_KEY AWS_SECURITY_TOKEN
    # AWS CLI
    AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY
    AWS_SECRET_ACCESS_KEY=$AWS_SECRET_KEY
    AWS_SESSION_TOKEN=$AWS_SECURITY_TOKEN
    export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN
    echo "Assumed AWS_ACCESS_KEY is $AWS_ACCESS_KEY"

    # write_credentials "terraform/tffiles/deployercredentials" "faodeployer" "${AWS_ACCESS_KEY}" "${AWS_SECRET_KEY}" "${AWS_SECURITY_TOKEN}"
}

launch() {
    local SCRIPT_ACTION=$1
    local TF_CONFIG=$2
    local DOCKER_IMAGE=hashicorp/terraform
    local SOURCE_REPO_FULL_URL=$(git remote get-url origin | cut -d':' -f2)
    local SOURCE_REPO_URL
    local workspace_name=""
    if [ "z$(echo ${SOURCE_REPO_FULL_URL} | cut -d':' -f1)" == "zhttps" ]; then
      # This is https URL. Need to remove the username password from the URL https://username:password@fqdn/path
      SOURCE_REPO_URL="https://$(echo ${SOURCE_REPO_FULL_URL} | cut -d'@' -f2)"
    else
      # This is git ssh URL, pass it as it is to SOURCE_REPO_URL
      SOURCE_REPO_URL="${SOURCE_REPO_FULL_URL}"
    fi
    local SOURCE_REPO_BRANCH=$(git branch| grep -e '^*' | awk '{print $2}')

    cd "terraform/environments/${TF_CONFIG}"
    if [ "z${SCRIPT_ACTION}" == "zdeploy" ]; then
        ACTION=("apply" "tfplan")
        PLAN_ACTION=("plan")
    elif [ "z${SCRIPT_ACTION}" == "zdestroy" ]; then
        ACTION=("apply" "-destroy")
        PLAN_ACTION=("plan" "-destroy")
    else
      echo "Invalid action. You need to define action as"
      echo "$0 -n <action>"
      echo "Where valid actions are choice of deploy, destroy"
    fi

    TF_PLUGIN_CACHE_DIR="${HOME}/.terraform_cache"
    export TF_PLUGIN_CACHE_DIR
    # Dir check
    [ ! -d "${TF_PLUGIN_CACHE_DIR}" ] && mkdir -p "${TF_PLUGIN_CACHE_DIR}"
    # echo "Calling"
    # echo "terraform init"
    # terraform init -reconfigure
    # Switch terraform workspace
    workspace_name=$(echo "${TF_CONFIG}-${AWS_DEFAULT_REGION}" |sed 's,/,-,g')
    # Check if workspace exists
    local workspace_count=$(terraform workspace list | grep "${workspace_name}" | wc -l)
    if [ "${workspace_count}" == "0" ]; then
      echo "Calling"
      echo "terraform workspace new \"${workspace_name}\""
      terraform workspace new "${workspace_name}"
    else
      echo "Calling"
      echo "terraform workspace select \"${workspace_name}\""
      terraform workspace select "${workspace_name}"
    fi

    # Run terraform init
    echo "Run terraform init"
    terraform init -backend-config="../../../backend.tf" -migrate-state
    # terraform init -migrate-state
    # terraform init -reconfigure

    # Run terraform plan
    terraform "${PLAN_ACTION[@]}" -input=false -out=tfplan \
      -var-file="../../../variables/main.tfvars" \
      -var-file="../../../variables/main-${AWS_DEFAULT_REGION}.tfvars" \
      -var aws_region="${AWS_DEFAULT_REGION}" \
      -compact-warnings \
      "${ARG_ARRAY[@]}"
    # terraform "${PLAN_ACTION[@]}" -input=false -out=tfplan \
    #    -var-file="variables/${AWS_ACCOUNT}/${AWS_DEFAULT_REGION}.tfvars" \
    #    -var aws_region="${AWS_DEFAULT_REGION}"
    # Run terraform apply
    if [ "z${DRY_RUN}" == "z" -o "z${DRY_RUN}" == "zfalse" ]; then
      terraform apply tfplan
    fi
    EXIT_STATUS=$?
    cd ../
    exit ${EXIT_STATUS}

}

parse_arguments() {
    while (( "$#" )); do
      case "$1" in
        -a|--account)
          AWS_ACCOUNT=$2
          shift 2
          ;;
        -l|--long-term-profile)
          LONG_AWS_PROFILE=$2
          # Only a user would have long term profile.
          # User would need to assume the role called user_assumerole
          AWS_ROLE_TO_ASSUME=user_assumerole
          shift 2
          ;;
        -s|--short-term-profile)
          SHORT_AWS_PROFILE=$2
          # SWITCH_ACCOUNT=0
          shift 2
          ;;
        -e|--extra-vars)
          EARG=$2
          shift 2
          ARG_ARRAY+=("-var" $EARG)
          ;;
        -f|--var-file)
          EARG=$2
          shift 2
          ARG_ARRAY+=("-var-file" "/workspace/vars/$EARG")
          ;;
        -n|--action)
          SCRIPT_ACTION=$2
          shift 2
          ;;
        -i|--item)
          TF_CONFIG=$2
          shift 2
          ;;
        -t|--target)
          ARG_ARRAY+=("-target=$2")
          shift 2
          ;;
        -m|--module)
          MODULE=$2
          shift 2
          ;;
        -d|--dry-run)
          DRY_RUN=$2
          shift 2
          ;;
        --) # end argument parsing
          shift
          break
          ;;
        -*|--*=) # unsupported flags
          echo "Error: Unsupported flag $1" >&2
          exit 1
          ;;
        *) # preserve positional arguments
          PARAMS="$PARAMS $1"
          shift
          ;;
      esac
    done
    # set positional arguments in their proper place
    eval set -- "$PARAMS"
}

get_shared_modules() {
  GIT_BRANCH=develop
  GIT_URL="https://${GIT_CREDENTIALS}@github.com/harisfauzi/shared-terraform-aws.git"
  git clone -b "${GIT_BRANCH}" --depth 1 "${GIT_URL}" shared-terraform-aws
  local CURRENT_DIR=$(pwd)
  (cd "${CURRENT_DIR}/shared-terraform-aws/modules"; tar cf - .) | (cd "${CURRENT_DIR}/terraform/modules"; tar xf -)
  rm -rf shared-terraform-aws
}

main() {

    # SWITCH_ACCOUNT=1
    parse_arguments $@

    # # Call assume_backend_role
    # if [ "z$SHORT_AWS_PROFILE" != "z" ]; then
    #     assume_backend_role "${SHORT_AWS_PROFILE}"
    # elif [ "z$LONG_AWS_PROFILE" != "z" ]; then
    #     assume_backend_role "${LONG_AWS_PROFILE}"
    # fi


    # # Call assume_role for deployment
    # if [ "z$AWS_ACCOUNT" != "z" ]; then
    #     # Call assume_role to switch AWS account
    #     # assume_role
    #     echo "No need to assume role. The assume_role is configured in main.tf"
    # elif
    if [ "z$SHORT_AWS_PROFILE" != "z" ]; then
        get_short_term_credentials
    elif [ "z$LONG_AWS_PROFILE" != "z" ]; then
        get_long_term_credentials
    fi
    get_shared_modules
    launch "${SCRIPT_ACTION}" "${TF_CONFIG}"

}

main "$@"
