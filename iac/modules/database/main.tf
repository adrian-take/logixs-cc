##
## A module to create the application's database
##

provider "aws" {}

data "aws_region" "current" {}

resource "random_pet" "this" {
  length = 2
}

##
## Local configuration for the database module
##

locals {
  communities_table_name = "community-${random_pet.this.id}"
  incidents_table_name   = "incident-${random_pet.this.id}"
}

##
## Create the database tables schemas
##

module "communities_table" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "3.3.0"

  name                        = local.communities_table_name
  hash_key                    = "id"
  range_key                   = "title"
  table_class                 = "STANDARD"
  deletion_protection_enabled = false

  attributes = [
    {
      name = "id"
      type = "S"
    },
    {
      name = "title"
      type = "S"
    },
    {
      name = "address"
      type = "S"
    },
    {
      name = "contact_phone"
      type = "S"
    },
    {
      name = "contact_email"
      type = "S"
    }
  ]

  global_secondary_indexes = [
    {
      name               = "TitleIndex"
      hash_key           = "title"
      range_key          = "contact_email"
      projection_type    = "INCLUDE"
      non_key_attributes = ["id"]
    }
  ]

  tags = var.tags
}

module "incidents_table" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "3.3.0"

  name                        = local.incidents_table_name
  hash_key                    = "id"
  range_key                   = "community"
  table_class                 = "STANDARD"
  deletion_protection_enabled = false

  attributes = [
    {
      name = "id"
      type = "S"
    },
    {
      name = "community"
      type = "S"
    },
    {
      name = "description"
      type = "S"
    },
    {
      name = "status"
      type = "S"
    },
    {
      name = "date_reported"
      type = "S"
    },
    {
      name = "date_solved"
      type = "S"
    },
    {
      name = "reported_by"
      type = "S"
    }
  ]

  global_secondary_indexes = [
    {
      name               = "CommunityIndex"
      hash_key           = "community"
      range_key          = "reported_by"
      projection_type    = "INCLUDE"
      non_key_attributes = ["id"]
    }
  ]

  tags = var.tags
}