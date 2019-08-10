terraform {
  # Версия terraform
  required_version = "~>0.11.7"
}

provider "google" {
  version = "2.0.0"
  project = "${var.project}"
  region  = "${var.region}"
}

module "app" {
  source            = "../modules/app"
  public_key_path   = "${var.public_key_path}"
  private_key_path  = "${var.private_key_path}"
  zone              = "${var.zone}"
  app_disk_image    = "${var.app_disk_image}"
  db_external_ip    = "${module.db.db_external_ip}"
  with_provisioning = "true"
}

module "db" {
  source           = "../modules/db"
  public_key_path  = "${var.public_key_path}"
  private_key_path = "${var.private_key_path}"
  zone             = "${var.zone}"
  db_disk_image    = "${var.db_disk_image}"
  app_external_ip  = "${module.app.app_external_ip}"
}

module "vpc" {
  source        = "../modules/vpc"
  source_ranges = ["${split(",", var.source_ranges)}"]
}

resource "template_file" "dynamic_inventory" {
  template = "${file("dynamic_inventory.json")}"
  vars {
    app_ext_ip = "${module.app.app_external_ip}"
    db_ext_ip = "${module.db.db_external_ip}"
  }
}