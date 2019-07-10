resource "google_compute_project_metadata" "default" {
  metadata = {
    # путь до публичного ключа
    ssh-keys = "appuser1:${file(var.project_public_key_path)}appuser2:${file(var.project_public_key_path)}"
  }
}
