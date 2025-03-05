resource "kubernetes_persistent_volume_claim_v1" "claim" {
  metadata {
    name = var.pvc_name
  }
  spec {
    storage_class_name = var.storage_class_name
    access_modes = ["ReadWriteMany"]
    resources {
      requests = {
        storage = var.capacity
      }
    }
    volume_name = "${kubernetes_persistent_volume_v1.pv.metadata.0.name}"
  }
}