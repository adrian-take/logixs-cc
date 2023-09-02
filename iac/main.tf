provider "google" {
  project = var.project_name
  region  = var.region
}

provider "google-beta" {
  alias   = "api"
  project = var.project_name
  region  = var.region
}

terraform {
  backend "gcs" {
    bucket = "BUCKET_NAME"
    prefix = "terraform/state"
  }
}

module "file-storage" {
  source                = "./modules/file-storage"
  bucket_region         = var.bucket_region
  c3d_bucket_name       = var.c3d_bucket_name
  json_bucket_name      = var.json_bucket_name
  c3d_pubsub_topic_name = var.c3d_pubsub_topic_name
  prefix                = var.prefix_env
  tags                  = var.tags
}

module "functions" {
  source                        = "./modules/functions"
  bucket_region                 = var.bucket_region
  deploy_bucket_name            = var.deploy_bucket_name
  c3d_pubsub_topic_name         = var.c3d_pubsub_topic_name
  c3d_parse_api_function_name   = var.c3d_parse_api_function_name
  c3d_upload_api_function_name  = var.c3d_upload_api_function_name
  json_getter_api_function_name = var.json_getter_api_function_name
  prefix                        = var.prefix_env
  tags                          = var.tags
  depends_on                    = [ module.file-storage ]
}

module "api" {
  providers = {
    google.base = google
    google-beta.api = google-beta.api
  }
  source                        = "./modules/api"
  c3d_parse_api_function_name   = var.c3d_parse_api_function_name
  c3d_upload_api_function_name  = var.c3d_upload_api_function_name
  json_getter_api_function_name = var.json_getter_api_function_name
  apigw_name                    = var.apigw_name
  apigw_config_name             = var.apigw_config_name
  apigw_gateway_name            = var.apigw_gateway_name
  prefix                        = var.prefix_env
  tags                          = var.tags
  depends_on                    = [ module.functions ]
}

#module "frontend" {
#  source = "./modules/frontend"
#  prefix = var.prefix_env
#  tags   = var.tags
#}