resource aws_security_group elasticache_access {
  name   = "ElasticacheAccess"
  vpc_id = data.aws_subnet.cache_subnet.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({
    Name = "ElasticacheAccess"
    },
    local.global_tags
  )
}

resource aws_security_group elasticache {
  name   = "Elasticache"
  vpc_id = data.aws_subnet.cache_subnet.vpc_id

  ingress {
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    security_groups = [aws_security_group.elasticache_access.id]
  }

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({
    Name = "Elasticache"
    },
    local.global_tags
  )
}
