resource aws_security_group pintv_application {
  count  = var.environment == "management" ? 0 : 1
  name   = "pintvApplication"
  vpc_id = var.vpc_id

  ingress {
    from_port = 3000
    to_port   = 3000
    protocol  = "tcp"
    security_groups = [
      aws_security_group.ingress_alb[count.index].id,
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({
    Name = "pintvApplication"
    },
    local.global_tags
  )
}

resource aws_security_group prometheus_non_management {
  count  = var.environment == "management" ? 0 : 1
  name   = "Prometheus"
  vpc_id = var.vpc_id

  ingress {
    from_port = 9090
    to_port   = 9090
    protocol  = "tcp"
    security_groups = [
      aws_security_group.ingress_nginx_internal[count.index].id,
    ]
  }

  ingress {
    from_port = 9090
    to_port   = 9090
    protocol  = "tcp"
    self      = true
  }

  ingress {
    from_port = 9100
    to_port   = 9100
    protocol  = "tcp"
    self      = true
  }

  ingress {
    from_port = 8080
    to_port   = 8080
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
    Name = "Prometheus"
    },
    local.global_tags
  )
}
