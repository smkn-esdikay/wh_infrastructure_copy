resource aws_ec2_client_vpn_endpoint default {
  description            = "terraform-managed"
  server_certificate_arn = aws_acm_certificate.server.arn
  client_cidr_block      = "172.1.0.0/16"
  split_tunnel           = true
  connection_log_options {
    enabled = false
  }
  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = aws_acm_certificate.client.arn
  }
  dns_servers = var.dns_server_ips
}

resource aws_ec2_client_vpn_network_association default {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.default.id
  subnet_id              = var.public_subnet_id
}

resource aws_ec2_client_vpn_authorization_rule default {
  for_each = var.authorized_target_network_cidr_map

  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.default.id
  target_network_cidr    = each.value
  authorize_all_groups   = true
  description            = each.key
}

resource aws_ec2_client_vpn_route default {
  for_each = var.routes_map

  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.default.id
  destination_cidr_block = each.value
  target_vpc_subnet_id   = aws_ec2_client_vpn_network_association.default.subnet_id
  description            = each.key
}
