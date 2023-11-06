terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.4.0"
    }
  }
}

provider "google" {
    project = var.project_id
    region  = var.region
    credentials = file("../credentials.json")
}

module "bucket" {
    source = "./modules/bucket"
    bucket_name = "${var.project_id}-bucket"
    location_id = "us-central1"
}

module "vm_instance" {
    source = "./modules/vm-instance"
    project_id = var.project_id
    region = var.region
    zone = var.zone
}