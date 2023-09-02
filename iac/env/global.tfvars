############################
########## GLOBAL ##########
############################

project_name  = "MOVESHELF-CE"
region        = "europe-west2"
bucket_region = "EU"
prefix        = "ms"
tags = {
  "owner"            = "architecture@moveshelf.com"
  "application-code" = "MSCE"
  "cost-center"      = "hiring"
  "application"      = "Cloud Engineering"
  "description"      = "Hiring assignment for Cloud Engineering"
  "power-management" = "12x5-uk"
  "environment"      = "dev"
}

##################################
########## FILE-STORAGE ##########
##################################

c3d_bucket_name             = "cs-c3d-storage"
json_bucket_name            = "cs-json-storage"
c3d_pubsub_topic_name       = "pubsub-c3d-topic"

###############################
########## FUNCTIONS ##########
###############################

deploy_bucket_name            = "cs-deployments"
c3d_parse_api_function_name   = "function-c3d-parse-api"
c3d_upload_api_function_name  = "function-c3d-upload-api"
json_getter_api_function_name = "function-json-getter-api"

#########################
########## API ##########
#########################

apigw_name         = "apigw-internal"
apigw_config_name  = "apigw-internal-config"
apigw_gateway_name = "apigw-internal-gateway"

##############################
########## FRONTEND ##########
##############################