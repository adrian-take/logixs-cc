bucket         = "terraform"
key            = "terraform/state/incidentreporter.tfstate"
dynamodb_table = "tfstate-lock"
region         = "eu-central-1"
encrypt        = true
