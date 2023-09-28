bucket         = "terraform"
key            = "terraform/state/incidentreporter.tfstate"
dynamodb_table = "tfstate-lock"
region         = "eu-west-1"
encrypt        = true
