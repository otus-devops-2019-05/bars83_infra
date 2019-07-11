variable project {
  description = "Project ID"
}

variable region {
  description = "Region"

  # Значение по умолчанию
  default = "us-central1"
}

variable project_public_key_path {
  # Описание переменной
  description = "Path to the public key used for wide project ssh access"
}