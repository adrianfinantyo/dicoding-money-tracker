resource "google_sql_database_instance" "main" {
    name             = var.cloud_sql_db_instance_name
    database_version = "MYSQL_5_7"
    region           = var.cloud_sql_db_instance_region
    deletion_protection = false

    settings {
    tier = "db-f1-micro"
    }
}

resource "google_sql_user" "sql_admin" {
    name     = var.cloud_sql_db_user
    instance = google_sql_database_instance.main.name
    password = var.cloud_sql_db_password
}

resource "google_sql_database" "sql_db" {
    name     = var.cloud_sql_db_name
    instance = google_sql_database_instance.main.name
}