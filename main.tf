resource "google_billing_budget" "this" {
  billing_account = var.billing_account
  display_name    = "Monthly Cost"
  budget_filter {
    credit_types_treatment = "INCLUDE_ALL_CREDITS"
    projects               = ["projects/${var.project_number}"]
  }

  amount {
    specified_amount {
      units = "100"
    }
  }

  threshold_rules {
    threshold_percent = 0.5
  }

  threshold_rules {
    threshold_percent = 1.0
  }

  all_updates_rule {
    pubsub_topic = "projects/${var.project_id}/topics/${google_pubsub_topic.this.name}"
  }

  depends_on = [
    google_pubsub_topic.this
  ]
}

resource "google_pubsub_topic" "this" {
  project = var.project_id
  name    = "billing-alerts"
}
