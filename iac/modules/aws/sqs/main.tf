##
## A module to create an SQS queue, along with its dead-letter queue and access policies
##

provider "aws" {}

data "aws_region" "current" {}

##
## The primary and dead-letter queues
##

resource "aws_sqs_queue" "queue" {
  name                        = var.queue_name
  message_retention_seconds   = var.retention_period
  visibility_timeout_seconds  = var.visibility_timeout
  tags                        = var.tags
  redrive_policy              = jsonencode({
                                    "deadLetterTargetArn" = aws_sqs_queue.dl_queue.arn,
                                    "maxReceiveCount" = var.receive_count
                                })
}

resource "aws_sqs_queue" "dl_queue" {
  name                        = "${var.queue_name}-dlq"
  message_retention_seconds   = var.retention_period
  visibility_timeout_seconds  = var.visibility_timeout
  tags                        = var.tags
}

##
## Managed policies that allow access to the queue
##

resource "aws_iam_policy" "consumer_policy" {
  name        = "SQS-${var.queue_name}-${data.aws_region.current.name}-consumer_policy"
  description = "Attach this policy to consumers of ${var.queue_name} SQS queue"
  policy      = data.aws_iam_policy_document.consumer_policy.json
}

data "aws_iam_policy_document" "consumer_policy" {
  statement {
    actions = [
      "sqs:ChangeMessageVisibility",
      "sqs:ChangeMessageVisibilityBatch",
      "sqs:DeleteMessage",
      "sqs:DeleteMessageBatch",
      "sqs:GetQueueAttributes",
      "sqs:GetQueueUrl",
      "sqs:ReceiveMessage"
    ]
    resources = [
      aws_sqs_queue.base_queue.arn,
      aws_sqs_queue.deadletter_queue.arn
    ]
  }
}

resource "aws_iam_policy" "producer_policy" {
  name        = "SQS-${var.queue_name}-${data.aws_region.current.name}-producer_policy"
  description = "Attach this policy to producers for ${var.queue_name} SQS queue"
  policy      = data.aws_iam_policy_document.producer_policy.json
}

data "aws_iam_policy_document" "producer_policy" {
  statement {
    actions = [
      "sqs:GetQueueAttributes",
      "sqs:GetQueueUrl",
      "sqs:SendMessage",
      "sqs:SendMessageBatch"
    ]
    resources = [
      aws_sqs_queue.base_queue.arn
    ]
  }
}