module "ses" {
  source = "../../modules/ses"
  domain = data.terraform_remote_state.bootstrap.outputs.hosted_zone_name
  route53_zone_id = data.terraform_remote_state.bootstrap.outputs.public_hosted_zone_id
  project = var.project
  subdomain = "relay"
  environment = var.environment
}