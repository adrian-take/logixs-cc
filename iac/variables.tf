############################
########## GLOBAL ##########
############################

variable "project_name" {
  description = "Name of the project"
  default     = "DEFAULT_PROJECT"
  type        = string
}

variable "region" {
  description = "Region: Europe (London)"
  default     = "europe-west2"
  type        = string
}

variable "bucket_region" {
    description = "Name of the bucket region."
    type        = string
}

variable "prefix" {
  description = "Naming prefix for all resources"
  type        = string
}

variable "tags" {
  description = "Tags for all resources"
  type        = map(string)
}

##################################
########## FILE-STORAGE ##########
##################################

variable "c3d_bucket_name" {
    description = "Name of the C3D file bucket."
    type        = string
}

variable "json_bucket_name" {
    description = "Name of the JSON file bucket."
    type        = string
}

variable "c3d_pubsub_topic_name" {
    description = "Name of the Pub/Sub topic for C3D parsing."
    type        = string
}

###############################
########## FUNCTIONS ##########
###############################

variable "deploy_bucket_name" {
    description = "Name of the Deployment bucket."
    type        = string
}

variable "c3d_parse_api_function_name" {
    description = "Name of the C3D Parse API function."
    type        = string
}

variable "c3d_upload_api_function_name" {
    description = "Name of the C3D Upload API function."
    type        = string
}

variable "json_getter_api_function_name" {
    description = "Name of the JSON Getter API function."
    type        = string
}

#########################
########## API ##########
#########################

variable "apigw_name" {
    description = "Name of the API Gateway."
    type        = string
}

variable "apigw_config_name" {
    description = "Name of the API Gateway configuration."
    type        = string
}

variable "apigw_gateway_name" {
    description = "Name of the API Gateway gateway."
    type        = string
}

##############################
########## FRONTEND ##########
##############################