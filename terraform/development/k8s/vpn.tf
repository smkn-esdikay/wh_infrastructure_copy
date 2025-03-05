locals {
  vpc_dns_server_ip_us_east_1 = cidrhost(local.vpc_cidr_block_us_east_1, 2)
  vpn_certificates_key_admin_arn = data.terraform_remote_state.bootstrap.outputs.core_infra_role_arn
  vpn_certificates_dir           = "${path.module}/vpn_data"

  vpn_routes_map = {
  }

  vpn_authorized_target_network_cidr_map = merge(
    local.vpn_routes_map,
    { development-network-us-east-1       = module.networking_us_east_1.cidr_block }
  )
}

output openvpn_config {
  value = module.vpn.client_vpn_config
  sensitive = true
  description = "OpenVPN config file"
}

output openvpn_config_per_client {
  value = module.vpn.per_client_vpn_config
  sensitive = true
  description = "OpenVPN config file"
}

module vpn {
  source = "../../modules/vpn/"

  common_name                        = "pintv-${local.environment}"
  organization_name                  = "PinTV"
  vpn_certificates_key_admin_arn     = local.vpn_certificates_key_admin_arn
  public_subnet_id                   = module.networking_us_east_1.public_subnet_ids[0]
  authorized_target_network_cidr_map = local.vpn_authorized_target_network_cidr_map
  routes_map                         = local.vpn_routes_map
  dns_server_ips                     = [local.vpc_dns_server_ip_us_east_1]
  dns_domains                        = [module.private_hosted_zone.name, module.private_hosted_zone_us_east_1.name]
  iam_users                          = data.terraform_remote_state.bootstrap.outputs.iam_users
}
