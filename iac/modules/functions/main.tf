resource "google_storage_bucket" "deploy-bucket" {
  name     = ("${var.prefix}-${var.deploy_bucket_name}")
  location = var.bucket_region
  tags     = var.tags
}

resource "google_storage_bucket_object" "deployment-c3d-parse-api-zip" {
  name   = "functions/c3d-parse-api.zip"
  bucket = google_storage_bucket.deploy-bucket.name
  source = "../../../resources/templates/python-function.zip"
}

data "google_pubsub_topic" "id-c3d-pubsub-topic" {
  name = ("${var.prefix_env}-${var.c3d_pubsub_topic_name}")
}

resource "google_cloudfunctions2_function" "c3d-parse-api" {
  name        = ("${var.prefix}-${var.c3d_parse_api_function_name}")
  location    = var.region
  description = "C3D Parsing API Function"

  build_config {
    runtime     = "python37"
    entry_point = "handler"
    source {
      storage_source {
        bucket = google_storage_bucket.deploy-bucket.name
        object = google_storage_bucket_object.deployment-c3d-parse-api-zip.name
      }
    }
  }

  service_config {
    max_instance_count = 2
    available_memory   = "256M"
    timeout_seconds    = 30
  }

  event_trigger {
    trigger_region = var.region
    event_type     = "google.cloud.pubsub.topic.v1.messagePublished"
    pubsub_topic   = google_pubsub_topic.id-c3d-pubsub-topic.id
    retry_policy   = "RETRY_POLICY_RETRY"
  }
}

resource "google_storage_bucket_object" "deployment-c3d-upload-api-zip" {
  name   = "functions/c3d-upload-api.zip"
  bucket = google_storage_bucket.deploy-bucket.name
  source = "../../../resources/templates/python-function.zip"
}

resource "google_cloudfunctions2_function" "c3d-upload-api" {
  name        = ("${var.prefix}-${var.c3d_upload_api_function_name}")
  location    = var.region
  description = "C3D Uploading API Function"

  build_config {
    runtime     = "python37"
    entry_point = "handler"
    source {
      storage_source {
        bucket = google_storage_bucket.deploy-bucket.name
        object = google_storage_bucket_object.deployment-c3d-upload-api-zip.name
      }
    }
  }

  service_config {
    max_instance_count = 2
    available_memory   = "128M"
    timeout_seconds    = 10
  }
}

resource "google_storage_bucket_object" "deployment-json-getter-api-zip" {
  name   = "functions/json-getter-api.zip"
  bucket = google_storage_bucket.deploy-bucket.name
  source = "../../../resources/templates/python-function.zip"
}

resource "google_cloudfunctions2_function" "json-getter-api" {
  name        = ("${var.prefix}-${var.json_getter_api_function_name}")
  location    = var.region
  description = "JSON Getter API Function"

  build_config {
    runtime     = "python37"
    entry_point = "handler"
    source {
      storage_source {
        bucket = google_storage_bucket.deploy-bucket.name
        object = google_storage_bucket_object.deployment-json-getter-api-zip.name
      }
    }
  }

  service_config {
    max_instance_count = 5
    available_memory   = "128M"
    timeout_seconds    = 10
  }
}