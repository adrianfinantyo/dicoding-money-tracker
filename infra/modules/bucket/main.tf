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

resource "google_storage_bucket_iam_member" "member" {
  provider = google
  bucket   = google_storage_bucket.bucket.name
  role     = "roles/storage.objectViewer"
  member   = "allUsers"
}