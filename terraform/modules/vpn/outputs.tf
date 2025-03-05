output certificates_kms_key_arn {
  value = aws_kms_alias.vpn_certificates.target_key_arn
}

output client_vpn_subnet_id {
  value = aws_ec2_client_vpn_network_association.default.subnet_id
}

output client_vpn_config {
  sensitive = true
  description = "OpenVPN config file"
  value = templatefile("${path.module}/config_template.ovpn.tpl", {
    endpoint_url = replace(aws_ec2_client_vpn_endpoint.default.dns_name, "*.", "vpn.")
    ca_data = tls_self_signed_cert.ca.cert_pem,
    crt_data = tls_locally_signed_cert.client.cert_pem,
    key_data = tls_private_key.client.private_key_pem,
    dns_server = join(" ", var.dns_server_ips)
    dns_domains = var.dns_domains
  })
}

output per_client_vpn_config {
  sensitive = true
  description = "OpenVPN config file (per client)"
  value = tomap({
    for k in var.iam_users : k => templatefile("${path.module}/config_template.ovpn.tpl", {
      endpoint_url = replace(aws_ec2_client_vpn_endpoint.default.dns_name, "*.", "vpn.")
      ca_data = tls_self_signed_cert.ca.cert_pem,
      crt_data = tls_locally_signed_cert.per_client[k].cert_pem,
      key_data = tls_private_key.per_client[k].private_key_pem,
      dns_server = join(" ", var.dns_server_ips)
      dns_domains = var.dns_domains
    })
  })
}
