
resource aws_security_group ingress_nginx_internal {
  count  = 1
  name   = "IngressNginxInternal"
  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({
    Name = "IngressNginxInternal"
    },
    local.global_tags
  )
}

resource aws_security_group letsencrypt_acme_solver {
  count  = 1
  name   = "LetsEncryptAcmeSolver"
  vpc_id = var.vpc_id

  ingress {
    from_port = 8089
    to_port   = 8089
    protocol  = "tcp"
    security_groups = [
      aws_security_group.ingress_nginx_external[count.index].id,
    ]
  }

  tags = merge({
    Name = "LetsEncryptAcmeSolver"
    },
    local.global_tags
  )
}

resource aws_security_group ingress_nginx_external {
  count  = 1
  name   = "IngressNginxExternal"
  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({
    Name = "IngressNginxExternal"
    },
    local.global_tags
  )
}

resource aws_security_group ingress_alb {
  count  = 1
  name   = "IngressAlb"
  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({
    Name = "IngressAlb"
    },
    local.global_tags
  )
}


resource aws_security_group autocert {
  # if in mgmt, no pintv_application to add
  count  = 1
  name   = "AutoCert"
  vpc_id = var.vpc_id

  ingress {
    from_port = 4443
    to_port   = 4443
    protocol  = "tcp"
    security_groups = concat([
      aws_security_group.ingress_nginx_internal[count.index].id,
      aws_security_group.ingress_nginx_external[count.index].id,
      aws_security_group.ingress_alb[count.index].id,
      ],
    var.environment == "management" ? [] : [aws_security_group.pintv_application[count.index].id])
  }

  ingress {
    from_port = 9000
    to_port   = 9000
    protocol  = "tcp"
    security_groups = concat([
      aws_security_group.ingress_nginx_internal[count.index].id,
      aws_security_group.ingress_nginx_external[count.index].id,
      aws_security_group.ingress_alb[count.index].id,
      ],
    var.environment == "management" ? [] : [aws_security_group.pintv_application[count.index].id])
  }

  ingress {
    description = "autocert step certificates"
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    self        = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({
    Name = "AutoCert"
    },
    local.global_tags
  )
}

resource aws_security_group flux {
  count  = 1
  name   = "Flux"
  vpc_id = var.vpc_id

  ingress {
    description = "flux memcache"
    from_port   = 11211
    to_port     = 11211
    protocol    = "tcp"
    self        = true
  }

  ingress {
    description = "metrics"
    from_port   = 3030
    to_port     = 3030
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({
    Name = "Flux"
    },
    local.global_tags
  )
}

resource aws_security_group fluentd {
  count  = 1
  name   = "Fluentd"
  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({
    Name = "Fluentd"
    },
    local.global_tags
  )
}

resource aws_security_group cert_manager {
  count  = 1
  name   = "CertManager"
  vpc_id = var.vpc_id

  ingress {
    from_port = 9402
    to_port   = 9402
    protocol  = "tcp"
    self      = true
  }

  ingress {
    from_port = 10250
    to_port   = 10250
    protocol  = "tcp"
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({
    Name = "CertManager"
    },
    local.global_tags
  )
}
