###
### GLOBAL
###

environment = "dev"
tfstate_bucket_name = "terraform"
tfstate_region = "eu-west-1"
region = "eu-central-1"
tags = {
  "application"      = "incidentreporter"
  "code-app"         = "CC"
  "owner"            = "arch@logixs.com"
  "environment"      = "dev"
  "avilability"      = "12x5"
  "power-management" = "12x5-es"
  "cost-center"      = "logixs-cloud"
}

###
### BACKOFFICE
###

cdn_name = dev-admin-app