resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "g1-small"
  zone         = "${var.zone}"
  tags         = ["reddit-app"]

  #count = "${var.count}"

  # параметры подключения provisioners
  connection {
    type  = "ssh"
    user  = "appuser"
    agent = false

    # путь до приватного ключа
    private_key = "${file(var.private_key_path)}"
  }
  # определение загрузочного диска
  boot_disk {
    initialize_params {
      image = "${var.app_disk_image}"
    }
  }
  metadata {
    # путь до публичного ключа
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
  # определение сетевого интерфейса
  network_interface {
    # сеть, к которой присоединить данный интерфейс
    network = "default"

    access_config = {
      nat_ip = "${google_compute_address.app_ip.address}"
    }
  }
  ## provisioners
  # provisioner "file" {
  #   source      = "${path.module}/files/puma.service"
  #   destination = "/tmp/puma.service"
  # }
  # provisioner "file" {
  #   source      = "${path.module}/files/deploy.sh"
  #   destination = "/tmp/deploy.sh"
  # }
  # provisioner "remote-exec" {
  #   inline = [
  #     "${var.with_provisioning == true ? local.with_provisioning : local.without_provisioning}",
  #   ]
  # }
}

locals {
  with_provisioning    = "echo Environment='DATABASE_URL=${var.db_external_ip}:27017' >> '/tmp/puma.service' && sh /tmp/deploy.sh"
  without_provisioning = "echo Application wouldn't be installed due to withProvisioning variable set to false"
}

resource "google_compute_address" "app_ip" {
  name = "reddit-app-ip"
}

resource "google_compute_firewall" "firewall_puma" {
  name = "allow-puma-default"

  # Название сети, в которой действует правило
  network = "default"

  # Какой доступ разрешить
  allow {
    protocol = "tcp"
    ports    = ["9292", "80"]
  }

  # Каким адресам разрешаем доступ
  source_ranges = ["0.0.0.0/0"]

  # Правило применимо для инстансов с перечисленными тэгами
  target_tags = ["reddit-app"]
}
