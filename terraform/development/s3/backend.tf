terraform {
  backend "s3" {
    bucket  = "pintv-development-tfstate"
    key     = "development/s3/terraform.tfstate"
    encrypt = true
    region  = "us-east-1"
    profile = "pintv-development-infra"
  }
}
