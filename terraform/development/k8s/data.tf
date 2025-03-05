data "terraform_remote_state" "bootstrap" {
  backend = "s3"

  config = {
    bucket  = "pintv-development-tfstate"
    key     = "development/bootstrap/terraform.tfstate"
    region  = "us-east-1"
    profile = "pintv-development-infra"
  }
}
