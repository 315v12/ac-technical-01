terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    okta = {
      source  = "okta/okta"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "okta" {
  org_name  = "test-org"
  base_url  = "okta.com"
  api_token = "dummy-token"
}

module "ec2" {
  source = "../../modules/ec2"

  ami_id        = "ami-12345678"
  instance_type = "t2.micro"
  env           = "dev"
}
