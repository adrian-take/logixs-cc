variable "bucket_region" {
    description = "Name of the bucket region."
    type        = string
}

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

variable "tags" {
  description = "Tags for all resources"
  type        = map(string)
}

variable "prefix" {
  description = "Naming prefix for all resources"
  type        = string 
}