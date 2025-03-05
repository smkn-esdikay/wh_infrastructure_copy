variable name {
  type = string
}

variable reclaim_policy {
  type = string
  default = "Retain"
}

variable mount_options {
  type        = list(string)
  default     = []
}
