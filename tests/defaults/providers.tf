terraform {
  required_version = ">=0.13.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 3.9.0, < 5.0.0"
    }
  }
}
provider "google" {
  project = var.project_id
  credentials = "/Users/andrewchasin/Documents/service-account-keys/tagging-project-378519-021a361dc396.json"
}