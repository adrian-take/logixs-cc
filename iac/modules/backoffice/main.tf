##
## A module to create the application's backoffice
##

provider "aws" {
  region = var.region
}

provider "aws" {
  alias = "aws_global"
  region = "us-east-1"
}

##
## Local configuration for the backoffice module
##

locals {
  bucket_name        = "adminapp-frontend-${var.region}"
  cdn_price_class    = "PriceClass_100"
  cdn_s3_origin_name = "web.admin.app"
}

##
## Definition of the backoffice's frontend bucket
##

module "frontend_bucket" {
  source      = "../aws/s3"
  bucket_name = local.bucket_name
  tags        = var.tags
}

##
## Definition of the backoffice's cdn
##

#data "aws_acm_certificate" "acm_cert" {
#  provider = aws.aws_global
#  domain   = var.cert_domain
#}

resource "aws_cloudfront_distribution" "cdn" {
  provider    = aws.aws_global
  comment     = var.cdn_name
  enabled     = true
  price_class = local.cdn_price_class

  is_ipv6_enabled     = true
  default_root_object = "index.html"
  #aliases            = [var.cdn_cname]

  origin {
    domain_name              = module.frontend_bucket.bucket_id
    origin_access_control_id = aws_cloudfront_origin_access_control.default.id
    origin_id                = local.cdn_s3_origin_name
  }

  logging_config {
    include_cookies = false
    #bucket          = "mylogs.s3.amazonaws.com"
    bucket          = var.cdn_log_bucket
    prefix          = "cdn/admin/"
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.cdn_s3_origin_name

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  #viewer_certificate {
  #  acm_certificate_arn      = data.aws_acm_certificate.acm_cert.arn
  #  minimum_protocol_version = "TLSv1.2_2021"
  #  ssl_support_method       = "sni-only"
  #}

  tags = var.tags
}