module "label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  namespace   = var.namespace
  stage       = var.stage
  environment = var.environment
  delimiter   = "-"
  label_order = ["stage", "namespace", "environment", "name", "attributes"]

}