terraform {
  required_version = "<=1.14.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.30.0"
    }
  }

  backend "s3" {
    bucket = "terraform-bucket-jonathan"
    key    = "production.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region
}

