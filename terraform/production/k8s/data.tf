data "terraform_remote_state" "bootstrap" {
  backend = "s3"

  config = {
    bucket  = "pintv-production-tfstate"
    key     = "production/bootstrap/terraform.tfstate"
    region  = "us-east-1"
    profile = "pintv-production-infra"
  }
}
