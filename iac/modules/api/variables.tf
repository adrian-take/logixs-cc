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

variable "tags" {
  description = "Tags for all resources"
  type        = map(string)
}

variable "prefix" {
  description = "Naming prefix for all resources"
  type        = string 
}