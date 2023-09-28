##
## A module to create the application's infrastructure
##

provider "aws" {
  region = var.region
}

provider "aws" {
  alias  = "aws_global"
  region = "us-east-1"
}

##
## Definition of the TF-State S3 bucket
##

#terraform {
#  backend "s3" {}
#}

##
## Definition of the different modules and resources composing the application
##

module "log_bucket" {
  source      = "./modules/aws/s3"
  bucket_name = var.service_log_bucket_name
  tags        = var.tags
}

#resource "aws_api_gateway_domain_name" "apigw_domain" {
#  certificate_arn = aws_acm_certificate_validation.example.certificate_arn
#  domain_name     = "api.app.com"
#}

module "api" {
  source     = "./modules/aws/apigw"
  apigw_name = "ir"
  tags       = var.tags
}

module "database" {
  source = "./modules/database"
  region = var.region
  tags   = var.tags
}

module "images" {
  source = "./modules/images"
  region = var.region
  tags   = var.tags
}

module "notifications" {
  source = "./modules/notifications"
  region = var.region
  tags   = var.tags
}

module "sso" {
  source = "./modules/sso"
  region = var.region
  tags   = var.tags
}

module "backoffice" {
  source         = "./modules/backoffice"
  cdn_name       = var.cdn_name
  cdn_log_bucket = module.log_bucket.bucket_url
  region         = var.region
  tags           = var.tags
}