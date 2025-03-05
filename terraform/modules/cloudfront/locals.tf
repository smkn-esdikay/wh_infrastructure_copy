locals {
  hzs       = data.terraform_remote_state.route53.outputs.external_hosted_zone
  full_name = "pintv-${var.region}-${var.environment}"
  origin    = var.environment == "production" ? "platform.pintv.systems" : "${var.environment}.pintv.systems"
}
