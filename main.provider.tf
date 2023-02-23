terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  required_version = ">= 1.0.0, < 2.0.0"
}

provider "aws" {
  assume_role { 
    role_arn = "arn:aws:iam::565934367826:role/Admin"
  }

  region = "us-east-1"
}