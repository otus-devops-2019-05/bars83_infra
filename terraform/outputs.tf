output "apps_external_ip" {
  value = "${google_compute_instance.app.*.network_interface.0.access_config.0.nat_ip}"
}

output "lb_external_ip" {
  value = "${google_compute_forwarding_rule.puma-forwarding-rule.ip_address}"
}
