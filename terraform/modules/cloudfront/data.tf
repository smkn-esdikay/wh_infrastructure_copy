data "terraform_remote_state" "route53" {
  backend = "s3"

  config = {
    bucket  = "terraform-state-pintv-staging"
    key     = "${var.environment}/route53/terraform.tfstate"
    region  = "us-east-1"
    profile = "pintv-staging-infra"
  }
}
