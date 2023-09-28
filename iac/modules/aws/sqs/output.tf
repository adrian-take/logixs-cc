##
## The urls of the base queue and the deadletter queue
##

output "queue_url" {
  value = aws_sqs_queue.queue.id
}

output "queue_arn" {
  value = aws_sqs_queue.queue.arn
}


output "dl_queue_url" {
  value = aws_sqs_queue.dl_queue.id
}

##
## The arn of the policies to attach for consumers and producers
##

output "consumer_policy_arn" {
  value = aws_iam_policy.consumer_policy.arn
}


output "producer_policy_arn" {
  value = aws_iam_policy.producer_policy.arn
}