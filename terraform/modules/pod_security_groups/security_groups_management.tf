resource aws_security_group argo {
  count  = var.environment == "management" ? 1 : 0
  name   = "Argo"
  vpc_id = var.vpc_id

  ingress {
    from_port = 2746
    to_port   = 2746
    protocol  = "tcp"
    security_groups = [
      aws_security_group.ingress_nginx_internal[count.index].id,
    ]
  }

  ingress {
    from_port = 4222
    to_port   = 4222
    protocol  = "tcp"
    self      = true
  }

  ingress {
    from_port = 6222
    to_port   = 6222
    protocol  = "tcp"
    self      = true
  }

  ingress {
    from_port = 8222
    to_port   = 8222
    protocol  = "tcp"
    self      = true
  }

  ingress {
    from_port = 12000
    to_port   = 12000
    protocol  = "tcp"
    self      = true
  }

  ingress {
    from_port = 12000
    to_port   = 12000
    protocol  = "tcp"
    security_groups = [
      aws_security_group.ingress_nginx_external[count.index].id,
    ]
  }

  ingress {
    from_port = 2746
    to_port   = 2746
    protocol  = "tcp"
    self      = true
  }

  ingress {
    from_port = 2375
    to_port   = 2375
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
    Name = "Argo"
    },
    local.global_tags
  )
}


resource aws_security_group chartmuseum {
  count  = var.environment == "management" ? 1 : 0
  name   = "Chartmuseum"
  vpc_id = var.vpc_id

  ingress {
    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"
    security_groups = [
      aws_security_group.ingress_nginx_internal[count.index].id,
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({
    Name = "Chartmuseum"
    },
    local.global_tags
  )
}


resource aws_security_group prometheus_alertmanager {
  count  = var.environment == "management" ? 1 : 0
  name   = "PrometheusAlertmanager"
  vpc_id = var.vpc_id

  ingress {
    from_port = 9093
    to_port   = 9094
    protocol  = "tcp"
    security_groups = [
      aws_security_group.ingress_nginx_internal[count.index].id,
      aws_security_group.prometheus_management[count.index].id
    ]
  }

  ingress {
    from_port = 9094
    to_port   = 9094
    protocol  = "udp"
    security_groups = [
      aws_security_group.prometheus_management[count.index].id
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({
    Name = "PrometheusAlertmanager"
    },
    local.global_tags
  )
}

resource aws_security_group elasticsearch {
  count  = var.environment == "management" ? 1 : 0
  name   = "Elasticsearch"
  vpc_id = var.vpc_id

  ingress {
    from_port = 9200
    to_port   = 9200
    protocol  = "tcp"
    self      = true
    security_groups = [
      aws_security_group.ingress_nginx_internal[count.index].id,
      aws_security_group.kibana[count.index].id,
      aws_security_group.fluentd[count.index].id,
    ]
  }

  ingress {
    from_port = 9300
    to_port   = 9300
    protocol  = "tcp"
    self      = true
    security_groups = [
      aws_security_group.ingress_nginx_internal[count.index].id,
      aws_security_group.kibana[count.index].id,
    ]
  }

  ingress {
    from_port = 9108
    to_port   = 9108
    protocol  = "tcp"
    self      = true
    security_groups = [
      aws_security_group.kibana[count.index].id,
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({
    Name = "Elasticsearch"
    },
    local.global_tags
  )
}

resource aws_security_group kibana {
  count  = var.environment == "management" ? 1 : 0
  name   = "Kibana"
  vpc_id = var.vpc_id

  ingress {
    from_port = 5601
    to_port   = 5601
    protocol  = "tcp"
    security_groups = [
      aws_security_group.ingress_nginx_internal[count.index].id,
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({
    Name = "Kibana"
    },
    local.global_tags
  )
}


resource aws_security_group prometheus_management {
  count  = var.environment == "management" ? 1 : 0
  name   = "Prometheus"
  vpc_id = var.vpc_id

  ingress {
    from_port = 9100
    to_port   = 9100
    protocol  = "tcp"
    self      = true
  }

  ingress {
    from_port = 9090
    to_port   = 9090
    protocol  = "tcp"
    self      = true
    security_groups = [
      aws_security_group.ingress_nginx_internal[count.index].id,
    ]
  }

  ingress {
    from_port = 9090
    to_port   = 9090
    protocol  = "tcp"
    self      = true
    security_groups = [
      aws_security_group.prometheus_grafana[count.index].id,
    ]
  }

  ingress {
    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"
    self      = true
    security_groups = [
      aws_security_group.prometheus_grafana[count.index].id,
    ]
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

resource aws_security_group prometheus_grafana {
  count  = var.environment == "management" ? 1 : 0
  name   = "PrometheusGrafana"
  vpc_id = var.vpc_id

  ingress {
    from_port = 3000
    to_port   = 3000
    protocol  = "tcp"
    security_groups = [
      aws_security_group.ingress_nginx_internal[count.index].id,
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({
    Name = "PrometheusGrafana"
    },
    local.global_tags
  )
}
