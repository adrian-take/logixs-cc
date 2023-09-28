##
## A module to create a S3 bucket
##

provider "aws" {}

data "aws_region" "current" {}

##
## The bucket
##

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  tags   = var.tags
}

##
## The bucket policy
##

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.bucket.id
  acl    = var.acl_policy
}