
resource "google_compute_network" "vpc_network" {
  name                    = var.network_name
  auto_create_subnetworks = false
  mtu                     = 1460
}

# Configure subnet
resource "google_compute_subnetwork" "default" {
  name          = var.subnet_name
  ip_cidr_range = "10.128.0.0/9"
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

# Allow ssh and 8888
resource "google_compute_firewall" "ingress-rules" {
  name = "allow-ingress"
  allow {
    protocol = "tcp"
    ports    = [22, 8888]
  }
  direction     = "INGRESS"
  network       = google_compute_network.vpc_network.id
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh", "jupyter"]
}

resource "google_compute_firewall" "internal-ingress" {
  name = "allow-internal-ingress"
  allow {
    protocol = "tcp"
    ports    = [0, 65535]
  }
  allow {
    protocol = "udp"
    ports    = [0, 65535]
  }
  allow {
    protocol = "icmp"
  }
  direction     = "INGRESS"
  network       = google_compute_network.vpc_network.id
  priority      = 65534
  source_ranges = ["10.128.0.0/9"]
}
