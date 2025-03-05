variable "name" {
  type = string
}

variable "pvc_name" {
  type = string
}

variable "capacity" {
  type = string
  default = "2Gi"
}

variable "path" {
  type = string
  default = "/mnt/data"
}

variable "storage_class_name" {
  type = string
}