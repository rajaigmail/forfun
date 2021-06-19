terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"


    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "2.21.0"
    }

  }

  required_version = ">= 0.12"
  backend "s3" {

  }
}


provider "aws" {
  region = "ap-south-1"
}
