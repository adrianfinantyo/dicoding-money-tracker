resource "google_compute_instance" "vm_instance_frontend" {
    name = "vm-instance-frontend"
    project = var.project_id
    zone = var.zone
    machine_type = var.machine_type

    network_interface {
        network = google_compute_network.vpc_network.name
        subnetwork = google_compute_subnetwork.public_subnetwork.name
        access_config {
            nat_ip = google_compute_address.frontend_static_ip.address
        }
    }
    
    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-11"
        }
    }
}

resource "google_compute_instance" "backend_vm_instance" {
    name = "vm-instance-backend"
    project = var.project_id
    zone = var.zone
    machine_type = var.machine_type

    network_interface {
        network = google_compute_network.vpc_network.name
        subnetwork = google_compute_subnetwork.private_subnetwork.name
    }
    
    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-11"
        }
    }
}

resource "google_compute_address" "frontend_static_ip" {
    name = "frontend-static-ip"
    project = var.project_id
    region = var.region
    address_type = "EXTERNAL"
}

resource "google_compute_network" "vpc_network" {
    name = "vpc-network"
    auto_create_subnetworks = false
    project = var.project_id
}

resource "google_compute_subnetwork" "public_subnetwork" {
    name          = "public-subnetwork"
    ip_cidr_range = "10.0.1.0/24"
    network       = google_compute_network.vpc_network.name
    private_ip_google_access = false
}

resource "google_compute_subnetwork" "private_subnetwork" {
    name          = "private-subnetwork"
    ip_cidr_range = "10.0.2.0/24"
    network       = google_compute_network.vpc_network.name
    private_ip_google_access = true
}

resource "google_compute_firewall" "allow_http_https" {
    name    = "allow-http"
    network = google_compute_network.vpc_network.name

    allow {
        protocol = "tcp"
        ports    = ["80", "443"]
    }

    source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_ssh" {
    name    = "allow-ssh"
    network = google_compute_network.vpc_network.name

    allow {
        protocol = "tcp"
        ports    = ["22"]
    }

    source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_icmp" {
    name    = "allow-icmp"
    network = google_compute_network.vpc_network.name

    allow {
        protocol = "icmp"
    }

    source_ranges = ["0.0.0.0/0"]
}