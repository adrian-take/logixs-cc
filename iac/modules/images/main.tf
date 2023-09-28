##
## A module to create the application's images services
##

provider "aws" {
  region = var.region
}

data "aws_region" "current" {}

##
## Local configuration for the images module
##

locals {
  upload_bucket_name  = "images-upload-${var.region}"
  storage_bucket_name = "images-storage-${var.region}"
  queue_name          = "images-queue-${var.region}"
}

##
## Create the upload and storage buckets for the images
##

module "upload_bucket" {
  source      = "../aws/s3"
  bucket_name = local.upload_bucket_name
  tags        = var.tags
}

module "storage_bucket" {
  source      = "../aws/s3"
  bucket_name = local.storage_bucket_name
  tags        = var.tags
}

##
## Create the image processing queue
##

module "images_queue" {
  source     = "../aws/sqs"
  queue_name = local.queue_name
  tags       = var.tags
}

##
## Bind the upload bucket to the images queue
##

resource "aws_s3_bucket_notification" "upload_notification" {
  bucket = module.upload_bucket.bucket_id

  queue {
    queue_arn     = module.images_queue.queue_arn
    events        = ["s3:ObjectCreated:*"]
  }
}