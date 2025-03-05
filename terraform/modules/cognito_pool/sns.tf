resource "aws_sns_topic" "user_updates" {
  name = "${var.project}-email-topic"
}