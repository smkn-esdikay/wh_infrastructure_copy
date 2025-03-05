terraform {
  backend "s3" {
    bucket  = "pintv-production-tfstate"
    key     = "production/k8s/terraform.tfstate"
    encrypt = true
    region  = "us-east-1"
    profile = "pintv-production-infra"
  }
}
