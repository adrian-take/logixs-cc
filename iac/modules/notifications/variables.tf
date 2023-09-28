variable "region" {
  description = "The region for the deployment of the resources. Prod: eu-west-1, Dev: eu-central-1"
  type        = string
  default     = "eu-central-1"
}


variable "tags" {
  description = "The tags for the resources. Contributes to cost and operations management."
  type = map(string)
}


variable "sender_email" {
  description = "The sender email for the notifications service."
  type        = string
  default     = "noreply@app.com"
}