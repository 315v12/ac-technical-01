terraform {
  backend "s3" {
    bucket         = "ac-terraform-state-315v12"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
