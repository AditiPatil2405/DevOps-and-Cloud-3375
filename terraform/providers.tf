terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.66.0"  # Use the latest version available
    }
  }
}

provider "aws" {
  region = var.aws_region
  # Other AWS provider configurations can be added here, such as access_key, secret_key, etc.
}
