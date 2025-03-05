resource "aws_instance" "public" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.nano"

  tags = {
    Name = "public-for-testing"
  }

  subnet_id                   = var.public_subnet_id
  associate_public_ip_address = true
  key_name                    = aws_key_pair.infra_testing.key_name
}

resource "aws_instance" "private" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.nano"

  tags = {
    Name = "private-for-testing"
  }

  subnet_id                   = var.private_subnet_id
  associate_public_ip_address = false
  key_name                    = aws_key_pair.infra_testing.key_name
}
