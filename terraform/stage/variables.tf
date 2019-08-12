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

# variable count {
#   description = "Count of reddit-app instances"
#   default     = 1
# }

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}

variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
}

variable source_ranges {
  description = "IP from allowed SSH access"
  default     = "0.0.0.0/0"
}