###
### GLOBAL
###

environment = "prod"
tfstate_bucket_name = "terraform"
tfstate_region = "eu-west-1"
region = "eu-west-1"
tags = {
  "application"      = "incidentreporter"
  "code-app"         = "CC"
  "owner"            = "arch@logixs.com"
  "environment"      = "prod"
  "avilability"      = "24x7"
  "power-management" = "24x7-es"
  "cost-center"      = "logixs-cloud"
}

###
### BACKOFFICE
###

cdn_name = live-admin-app