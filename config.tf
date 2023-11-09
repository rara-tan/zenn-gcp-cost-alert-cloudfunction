terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.81.0"
    }
  }
}

provider "google" {
  region                = "asia-northeast1"
  user_project_override = true
  billing_project       = var.project_id
}

variable "project_id" {
  description = "GCP Project ID"
}
variable "project_number" {
  description = "gcp project number"
}
variable "billing_account" {
  description = "billing account"
}
