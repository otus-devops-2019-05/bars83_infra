variable public_key_path {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}

variable zone {
  description = "VM zone name"
  default     = "us-central1-c"
}

variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
}

variable private_key_path {
  # Описание переменной
  description = "Path to the private key used for provisioning ssh access"
}

variable "app_external_ip" {
  description = "IP of app instance to set source range in DB firewall rule"
}