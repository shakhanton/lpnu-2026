locals {
  # Naming convention
  resource_name = "name-from-local"

}


module "label_dynamodb" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  context = module.label.context

  name = "GameScores"

}



