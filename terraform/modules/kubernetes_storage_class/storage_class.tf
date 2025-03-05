resource "kubernetes_storage_class" "class" {
  metadata {
    name = var.name
    annotations = {
      "storageclass.kubernetes.io/is-default-class": "true"
    }
  }
  reclaim_policy = var.reclaim_policy
  storage_provisioner = "kubernetes.io/aws-ebs"
  parameters = {
    type = "gp2"
  }
  allow_volume_expansion = true
  mount_options = var.mount_options
}