terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

resource "google_compute_instance" "terraform_website" {
  name         = "terraform-website"
  machine_type = "f1-micro"
  zone         = "us-central1-a"

  network_interface {
    network = "default"
    access_config {
      network_tier = "STANDARD"
    }
  }

  tags = ["allow-http", "allow-https"]  # Include both HTTP and HTTPS tags

  boot_disk {
    initialize_params {
      image = "debian-12-bookworm-v20240312"
      size  = 10
      type  = "pd-standard"
    }
  }

  metadata = {
    startup-script = <<-EOT
      #!/bin/bash
      sudo apt update
      sudo apt -y install apache2
      sudo apt -y install git
      sudo systemctl start apache2
      git clone https://github.com/kurtsprague/terraform_website.git
      sudo cp ./terraform_website/website_resources/* /var/www/html/
      sudo systemctl restart apache2
    EOT
  }
}

# Firewall rule for HTTP (Port 80)
resource "google_compute_firewall" "allow_http" {
  name    = "allow-http-rule"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]  # Allow traffic from anywhere
  target_tags   = ["allow-http"]
  priority      = 1000
}

# Firewall rule for HTTPS (Port 443)
resource "google_compute_firewall" "allow_https" {
  name    = "allow-https-rule"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = ["0.0.0.0/0"]  # Allow traffic from anywhere
  target_tags   = ["allow-https"]
  priority      = 1000
}
