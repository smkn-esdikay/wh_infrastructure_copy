resource "aws_acm_certificate" "server" {
  private_key       = tls_private_key.server.private_key_pem
  certificate_body  = tls_locally_signed_cert.server.cert_pem
  certificate_chain = tls_self_signed_cert.ca.cert_pem
  tags = {
    Name    = "VPN_SERVER_CERT",
    Managed = "stackoverdrive"
  }

  lifecycle {
    ignore_changes = all
  }
}

resource "aws_acm_certificate" "client" {
  private_key       = tls_private_key.client.private_key_pem
  certificate_body  = tls_locally_signed_cert.client.cert_pem
  certificate_chain = tls_self_signed_cert.ca.cert_pem
  tags = {
    Name    = "VPN_CLIENT_CERT",
    Managed = "stackoverdrive"
  }

  lifecycle {
    ignore_changes = all
  }
}

# CA cert

resource "tls_private_key" "ca" {
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "ca" {
  private_key_pem   = tls_private_key.ca.private_key_pem
  is_ca_certificate = true

  subject {
    common_name  = "${var.common_name}.vpn.ca"
    organization = var.organization_name
  }

  validity_period_hours = (24 * 365 * 10)

  allowed_uses = [
    "cert_signing",
    "crl_signing",
  ]
  lifecycle {
    ignore_changes = [private_key_pem]
  }
}

# Server cert

resource "tls_private_key" "server" {
  algorithm = "RSA"
}

resource "tls_cert_request" "server" {
  private_key_pem = tls_private_key.server.private_key_pem

  subject {
    common_name  = "${var.common_name}.vpn.server"
    organization = var.organization_name
  }
  lifecycle {
    ignore_changes = [private_key_pem]
  }
}

resource "tls_locally_signed_cert" "server" {
  cert_request_pem   = tls_cert_request.server.cert_request_pem
  ca_private_key_pem = tls_private_key.ca.private_key_pem
  ca_cert_pem        = tls_self_signed_cert.ca.cert_pem

  validity_period_hours = (24 * 365 * 10)

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
  lifecycle {
    ignore_changes = [ca_private_key_pem]
  }
}

# Shared client cert

resource "tls_private_key" "client" {
  algorithm = "RSA"
}

resource "tls_cert_request" "client" {
  private_key_pem = tls_private_key.client.private_key_pem

  subject {
    common_name  = "${var.common_name}.vpn.client"
    organization = var.organization_name
  }

  lifecycle {
    ignore_changes = [private_key_pem]
  }
}

resource "tls_locally_signed_cert" "client" {
  cert_request_pem   = tls_cert_request.client.cert_request_pem
  ca_private_key_pem = tls_private_key.ca.private_key_pem
  ca_cert_pem        = tls_self_signed_cert.ca.cert_pem

  validity_period_hours = (24 * 365 * 10)

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "client_auth",
  ]
  lifecycle {
    ignore_changes = [ca_private_key_pem]
  }
}

# Per-client cert

resource "tls_private_key" "per_client" {
  for_each  = toset(var.iam_users)
  algorithm = "RSA"
}

resource "tls_cert_request" "per_client" {
  for_each        = tls_private_key.per_client
  private_key_pem = each.value.private_key_pem

  subject {
    common_name  = "${each.key}.${var.common_name}.vpn.client"
    organization = var.organization_name
  }
  lifecycle {
    ignore_changes = [private_key_pem]
  }
}

resource "tls_locally_signed_cert" "per_client" {
  for_each           = tls_cert_request.per_client
  cert_request_pem   = each.value.cert_request_pem
  ca_private_key_pem = tls_private_key.ca.private_key_pem
  ca_cert_pem        = tls_self_signed_cert.ca.cert_pem

  validity_period_hours = (24 * 365 * 10)

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "client_auth",
  ]
  lifecycle {
    ignore_changes = [ca_private_key_pem]
  }
}
