resource "aws_key_pair" "infra_testing" {
  key_name   = "infra_testing"
  public_key = var.ssh_public_key
}
