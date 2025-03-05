resource aws_security_group rds_database_access {
  name = "RDSDatabaseAccess"
  #TODO: pass vpc id to not force replacement
  vpc_id = data.aws_subnet.db_subnet.vpc_id

  ingress {
    from_port = 5432
    to_port   = 5432
    protocol  = "tcp"
    self      = true
  }

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "RDSDatabaseAccess"
  }

  lifecycle {
    ignore_changes = [vpc_id]
  }
}
