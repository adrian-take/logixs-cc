resource "google_storage_bucket" "c3d-bucket" {
  name     = ("${var.prefix}-${var.c3d_bucket_name}")
  location = var.bucket_region
  tags     = var.tags
}

resource "google_storage_bucket_object" "c3d-example" {
  name   = "/2023/09/01/example_file.c3d"
  source = "../../../resources/example_file.c3d"
  bucket = google_storage_bucket.c3d-bucket.name
}

resource "google_storage_bucket" "json-bucket" {
  name     = ("${var.prefix}-${var.json_bucket_name}")
  location = var.bucket_region
  tags     = var.tags
}

resource "google_pubsub_topic" "c3d-pubsub-topic" {
  name = ("${var.prefix}-${var.c3d_pubsub_topic_name}")
  message_retention_duration = "86600s"
}