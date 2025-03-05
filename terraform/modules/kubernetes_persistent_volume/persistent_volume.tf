resource "kubernetes_persistent_volume_v1" "pv" {
  metadata {
    name = var.name
  }
  spec {
    storage_class_name = var.storage_class_name
    capacity = {
      storage = var.capacity
    }
    persistent_volume_reclaim_policy = "Delete"
    access_modes = ["ReadWriteMany"]
    persistent_volume_source {
      csi {
        driver = "ebs.csi.aws.com"
        volume_handle = var.name
      }
    }
  }
}