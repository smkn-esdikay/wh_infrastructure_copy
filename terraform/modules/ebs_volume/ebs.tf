resource "aws_ebs_volume" "example" {
  availability_zone = var.availability_zone
  size              = 40

  tags = {
    Environment = var.environment
  }
}