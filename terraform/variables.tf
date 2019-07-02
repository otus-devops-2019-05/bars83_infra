variable project {
  description = "Project ID"
}

variable region {
  description = "Region"

  # Значение по умолчанию
  default = "us-central1"
}

variable public_key_path {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}

variable project_public_key_path {
  # Описание переменной
  description = "Path to the public key used for wide project ssh access"
}

variable private_key_path {
  # Описание переменной
  description = "Path to the private key used for provisioning ssh access"
}

variable disk_image {
  description = "Disk image"
}

variable zone {
  description = "VM zone name"
  default     = "us-central1-c"
}

variable name {
  description = "Name for the forwarding rule and prefix for supporting resources"
}

variable count {
  description = "Count of reddit-app instances"
  default     = 1
}
