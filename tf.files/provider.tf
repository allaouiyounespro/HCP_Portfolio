terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  required_version = ">= 1.5.0"
}

# Main Region
provider "aws" {
  region = var.aws_region
}

#provider required for ACM + CloudFront
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}
