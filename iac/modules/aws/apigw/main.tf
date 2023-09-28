##
## A module to create an API Gateway
##

provider "aws" {}

data "aws_region" "current" {}

data "template_file" "api" {
  template = file("./api.yml")
}

##
## The API Gateway
##

resource "aws_api_gateway_rest_api" "apigw" {
  name        = var.apigw_name
  description = "API Gateway for ${var.apigw_name}"
  endpoint_configuration {
    types = [var.var.apigw_type]
  }
  api_key_source = "HEADER"

  body = data.template_file.api.rendered
  tags = var.tags

  lifecycle {
    ignore_changes = [
      body
    ]
  }
}