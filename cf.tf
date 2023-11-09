data "archive_file" "this" {
  type        = "zip"
  source_dir  = "./sources"
  output_path = "./sources/functions.zip"
}

resource "google_storage_bucket" "this" {
  project = var.project_id
  name          = "my-bucket-for-test-cost-alert"
  location      = "ASIA"
  storage_class = "STANDARD"
}

resource "google_storage_bucket_object" "this" {
  name   = "packages/functions.${data.archive_file.this.output_md5}.zip"
  bucket = google_storage_bucket.this.name
  source = data.archive_file.this.output_path
}

resource "google_cloudfunctions_function" "this" {
  project = var.project_id
  name                  = "cost-alert"
  runtime               = "nodejs18"
  source_archive_bucket = google_storage_bucket.this.name
  source_archive_object = google_storage_bucket_object.this.name
  available_memory_mb   = 256
  event_trigger {
    event_type = "providers/cloud.pubsub/eventTypes/topic.publish"
    resource   = google_pubsub_topic.this.name
  }
  entry_point           = "notifySlack"

  environment_variables = {
    BOT_ACCESS_TOKEN = ""
    SLACK_CHANNEL = ""
  }
}
