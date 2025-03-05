module grafana_storage_class {
  source = "./../../modules/kubernetes_storage_class"
  name = "loki-data"
}

module grafana_pvc {
  source = "./../../modules/kubernetes_persistent_volume"
  name = "loki-data"
  pvc_name = "loki-data"
  storage_class_name = module.grafana_storage_class.name
}