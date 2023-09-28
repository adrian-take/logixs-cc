##
## A module to create the application's sso services
##

provider "aws" {
  region = var.region
}

data "aws_region" "current" {}

##
## Local configuration for the SSO module
##

locals {
  pool_name        = "sso-pool-${var.region}"
  pub_client_name  = "public-web"
  priv_client_name = "private-server"
  apigw_name       = "sso"
  apigw_auth_name  = "sso-auth"
}

##
## Definition of the Cognito User Pool for SSO services
##

resource "aws_cognito_user_pool" "pool" {
  name                     = local.pool_name
  username_attributes      = ["email"]
  auto_verified_attributes = ["email"]
  
  schema {
    name                     = "email"
    attribute_data_type      = "String"
    required                 = true
    developer_only_attribute = false
    mutable                  = true

    string_attribute_constraints {
      min_length = 1
      max_length = 2048
    }
  }
  
  verification_message_template {
    default_email_option = "CONFIRM_WITH_LINK"
  }

  tags = var.tags
}

resource "aws_cognito_user_pool_client" "pub_client" {
  name         = local.pub_client_name
  user_pool_id = aws_cognito_user_pool.pool.id

  generate_secret     = false
  explicit_auth_flows = ["ALLOW_USER_PASSWORD_AUTH","ALLOW_USER_SRP_AUTH","ALLOW_REFRESH_TOKEN_AUTH"]
}

resource "aws_cognito_user_pool_client" "priv_client" {
  name         = local.priv_client_name
  user_pool_id = aws_cognito_user_pool.pool.id

  generate_secret     = true
  explicit_auth_flows = ["ALLOW_ADMIN_USER_PASSWORD_AUTH","ALLOW_USER_PASSWORD_AUTH","ALLOW_USER_SRP_AUTH","ALLOW_REFRESH_TOKEN_AUTH"]
}

##
## Definition of the API Gateway for SSO services
##

module "api" {
  source     = "../aws/apigw"
  apigw_name = local.apigw_name
  tags       = var.tags
}

resource "aws_api_gateway_authorizer" "apigw_auth" {
  name          = local.apigw_auth_name
  rest_api_id   = module.api.apigw_id
  type          = "COGNITO_USER_POOLS"
  provider_arns = aws_cognito_user_pools.pool.arns
}