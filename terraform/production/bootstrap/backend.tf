terraform {
  backend "s3" {
    bucket  = "pintv-production-tfstate"
    key     = "production/bootstrap/terraform.tfstate"
    encrypt = true
    region  = "us-east-1"
    profile = "pintv-production-infra"
  }
}
