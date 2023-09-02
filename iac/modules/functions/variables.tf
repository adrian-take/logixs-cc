variable "bucket_region" {
    description = "Name of the bucket region."
    type        = string
}

variable "deploy_bucket_name" {
    description = "Name of the Deployment bucket."
    type        = string
}

variable "c3d_pubsub_topic_name" {
    description = "Name of the Pub/Sub topic for C3D parsing."
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

variable "tags" {
  description = "Tags for all resources"
  type        = map(string)
}

variable "prefix" {
  description = "Naming prefix for all resources"
  type        = string 
}