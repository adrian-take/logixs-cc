###
### GLOBAL VARS
###


variable "environment" {
    description = ""
    type        = string
    default     = "dev"
}


variable "tfstate_bucket_name" {
    description = ""
    type        = string
    default     = "terraform"
}


variable "tfstate_region" {
    description = ""
    type        = string
    default     = "eu-west-1"
}


variable "region" {
  description = "The region for the deployment of the resources. Prod: eu-west-1, Dev: eu-central-1"
  type        = string
  default     = "eu-central-1"
}


variable "tags" {
  description = "The tags for the resources. Contributes to cost and operations management."
  type = map(string)
}


###
### BACKOFFICE
###

variable "cdn_name" {
  description = "The name for the CloudFront resource."
  type = string
  default = "dev-admin-app"
}