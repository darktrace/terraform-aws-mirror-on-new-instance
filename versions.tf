terraform {
  required_version = ">= 1.6"
  required_providers {
    aws = {
      version = ">= 5.23"
    }
    archive = {
      version = "~> 2.4.2"
    }
  }
}
