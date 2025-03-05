terraform {
  backend "s3" {
    bucket  = "pintv-production-tfstate"
    key     = "production/s3/terraform.tfstate"
    encrypt = true
    region  = "us-east-1"
    profile = "pintv-production-infra"
  }
}
