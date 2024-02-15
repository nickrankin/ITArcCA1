terraform {
  required_providers {
    # https://registry.terraform.io/providers/hashicorp/aws/latest
    aws = {
      source = "hashicorp/aws"
      version = "5.36.0"
    }
  }
}


provider "aws" {
    access_key = var.ACCESS_KEY
    secret_key = var.SECRET_KEY
	token = var.TOKEN
    region = var.REGION
}