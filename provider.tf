terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket         = "agitask02-remote-state-bucket"
    key            = "terraform/state/agitask02.tfstate"
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "agitask02-lock-table"
  }
}


# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}



