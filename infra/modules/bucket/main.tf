resource "google_storage_bucket" "bucket" {
    name = var.bucket_name
    location = var.location_id

    force_destroy = true

    uniform_bucket_level_access = true

    lifecycle_rule {
        condition {
            age = 30
        }
        action {
            type = "Delete"
        }
    }
}