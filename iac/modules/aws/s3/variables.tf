variable "bucket_name" {
  description = "The name of the bucket."
  type = string
}


variable "acl_policy" {
  description = "The ACL policy for the bucket."
  type = string
  default = "private"
}


variable "tags" {
  description = "The tags for the resources. Contributes to cost and operations management."
  type = map(string)
}