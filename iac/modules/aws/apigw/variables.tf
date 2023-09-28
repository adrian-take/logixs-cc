variable "apigw_name" {
  description = "The name of the API Gateway."
  type = string
}


variable "apigw_type" {
  description = "The type of the API Gateway."
  type = string
  default = "REGIONAL"
}


variable "tags" {
  description = "The tags for the resources. Contributes to cost and operations management."
  type = map(string)
}