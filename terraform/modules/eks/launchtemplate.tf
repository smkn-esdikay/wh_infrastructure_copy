# eks default launch template is used as a transparent base, and a copy of this template
# of the provided launch template is merged with the default, so we don't need to
# specify user_data here (unless we provide our own ami)
# https://docs.aws.amazon.com/eks/latest/userguide/launch-templates.html

resource "aws_launch_template" "default" {
  name_prefix            = "${local.cluster_name}-"
  description            = "Launch-Template"
  update_default_version = true
  instance_type          = var.node_group_instance_types[0]
  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = var.node_group_disk_size
      volume_type           = "gp2"
      delete_on_termination = true
      encrypted             = true
      kms_key_id            = aws_kms_key.eks.arn
    }
  }

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = false
    delete_on_termination       = true
    #security_groups             = [local.cluster_security_group_id]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_template" "gpu" {
  name_prefix            = "${local.cluster_name}-gpu"
  description            = "Launch-Template (GPU)"
  update_default_version = true
  instance_type          = var.gpu_node_group_instance_types[0]
  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = var.gpu_node_group_disk_size
      volume_type           = "gp2"
      delete_on_termination = true
      encrypted             = true
      kms_key_id            = aws_kms_key.eks.arn
    }
  }

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = false
    delete_on_termination       = true
    #security_groups             = [local.cluster_security_group_id]
  }

  lifecycle {
    create_before_destroy = true
  }
}
