terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.35.1"
    }
  }

  required_version = ">= 1.14.6"

  backend "s3" {
    bucket       = "657694663228-2026-terraform-tfstate"
    key          = "dev/terraform.tfstate"
    region       = "eu-central-1"
    use_lockfile = true
  }
}
