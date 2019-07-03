resource "google_compute_forwarding_rule" "puma-forwarding-rule" {
  name       = "puma-lb"
  target     = "${google_compute_target_pool.puma-pool.self_link}"
  port_range = "9292"
}

resource "google_compute_target_pool" "puma-pool" {
  name = "puma-pool"

  instances = [
    "${google_compute_instance.app.*.self_link}",
  ]

  health_checks = ["${google_compute_http_health_check.puma-healthcheck.self_link}"]
}

resource "google_compute_http_health_check" "puma-healthcheck" {
  name               = "puma-healthcheck"
  check_interval_sec = 5
  timeout_sec        = 5
  port               = "9292"
}
