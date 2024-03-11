terraform {
    
  backend "s3" {
    bucket         = "terraform-s3-remote-bucket"
    key            = "terraform.tfstate"
    region         = "us-east-2"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  
}

provider "aws" {
  region = "us-east-2"
}


