resource aws_security_group_rule allow_vpn {
  description       = "AllowVPN"
  type              = "ingress"
  from_port   = 443
  to_port     = 443
  protocol    = "TCP"
  cidr_blocks       = var.allowed_eks_cluster_endpoint_cidr_blocks
  security_group_id = local.cluster_security_group_id
}

resource aws_security_group_rule allow_vpn_all {
  description       = "AllowVPNAll"
  type              = "ingress"
  from_port   = 0
  to_port     = 0
  protocol    = -1
  cidr_blocks       = var.allowed_eks_cluster_endpoint_cidr_blocks
  security_group_id = local.cluster_security_group_id
}

resource aws_security_group_rule allow_pod_dns_tcp {
  description              = "AllowPodDNSTCP"
  type                     = "ingress"
  from_port                = 53
  to_port                  = 53
  protocol                 = "TCP"
  source_security_group_id = aws_security_group.eks_cluster_default_access.id
  security_group_id        = local.cluster_security_group_id
}

resource aws_security_group_rule allow_pod_dns_udp {
  description              = "AllowPodDNSUDP"
  type                     = "ingress"
  from_port                = 53
  to_port                  = 53
  protocol                 = "UDP"
  source_security_group_id = aws_security_group.eks_cluster_default_access.id
  security_group_id        = local.cluster_security_group_id
}

resource aws_security_group_rule allow_pod_dns_tcp_self {
  description              = "AllowPodDNSTCP"
  type                     = "ingress"
  from_port                = 53
  to_port                  = 53
  protocol                 = "TCP"
  source_security_group_id = local.cluster_security_group_id
  security_group_id        = local.cluster_security_group_id
}

resource aws_security_group_rule allow_pod_dns_udp_self {
  description              = "AllowPodDNSUDP"
  type                     = "ingress"
  from_port                = 53
  to_port                  = 53
  protocol                 = "UDP"
  source_security_group_id = local.cluster_security_group_id
  security_group_id        = local.cluster_security_group_id
}

resource aws_security_group_rule allow_api_access {
  description              = "AllowPodAPIAccess"
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "TCP"
  source_security_group_id = aws_security_group.eks_cluster_api_access.id
  security_group_id        = local.cluster_security_group_id
}

# Default Security Group applied to all pods
resource aws_security_group eks_cluster_default_access {
  name   = "EKSClusterDefaultAccess"
  vpc_id = var.vpc_id

  ingress {
    from_port       = 0
    to_port         = 65535
    protocol        = "tcp"
    security_groups = [local.cluster_security_group_id]
    description     = "Allow kubelet probes and Node Port for cert-manager acme solvers"
  }

  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    self        = true
    description = "Allow DNS TCP against CoreDNS"
  }

  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    self        = true
    description = "Allow DNS UDP against CoreDNS"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({
    Name                                          = "EKSClusterDefaultAccess",
    "kubernetes.io/cluster/${local.cluster_name}" = "owned"
    },
    local.global_tags
  )
}

resource aws_security_group eks_cluster_api_access {
  name   = "EKSClusterAPIAccess"
  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({
    Name = "EKSClusterAPIAccess"
    },
    local.global_tags
  )
}
