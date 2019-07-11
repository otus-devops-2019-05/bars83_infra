variable public_key_path {
  description = "Path to the public key used to connect to instance"
}

variable zone {
  description = "Zone"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}

variable private_key_path {
  # Описание переменной
  description = "Path to the private key used for provisioning ssh access"
}

variable "with_provisioning" {
  default = "true"
}

variable "db_external_ip" {
  default = "127.0.0.1"
}