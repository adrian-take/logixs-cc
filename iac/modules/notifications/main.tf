##
## A module to create the application's notification services
##

provider "aws" {
  region = var.region
}

data "aws_region" "current" {}

##
## Local configuration for the notifications module
##

locals {
  queue_name = "notif-queue-${var.region}"
}

##
## Create the notification queue
##

module "notif_queue" {
  source     = "../aws/sqs"
  queue_name = local.queue_name
  tags       = var.tags
}

##
## Create the SES email identity
##

resource "aws_ses_email_identity" "email_identity" {
  email = var.sender_email
}