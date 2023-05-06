terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">=1.2.0"
  # backend "s3" {
  # TODO: Use S3 bucket to store state
  # }
}

provider "aws" {
  alias  = "ap-southeast"
  region = "ap-southeast-2"
}