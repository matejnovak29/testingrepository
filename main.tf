terraform {
  required_providers {
    dbtcloud = {
      source  = "dbt-labs/dbtcloud"
      version = "~> 0.3"
    }
  }
}

provider "dbtcloud" {
  api_token  = var.dbt_cloud_api_token
  account_id = var.dbt_cloud_account_id
  host_url   = "https://cloud.getdbt.com/api"
}

resource "dbtcloud_project" "example_project" {
  name        = "My Terraform Project"
  description = "Project created via Terraform"
}

resource "dbtcloud_environment" "example_environment" {
  name        = "Production"
  type        = "deployment" # Can also be "development" based on your need
  project_id  = dbtcloud_project.example_project.id
  dbt_version = "1.4.0"
}

resource "dbtcloud_job" "example_job" {
  name         = "Example Job"
  project_id   = dbtcloud_project.example_project.id
  environment_id = dbtcloud_environment.example_environment.id # Link to the environment
  dbt_version  = "1.4.0"
  execute_steps = [
    "dbt run",
    "dbt test"
  ]

  # Schedule trigger
  triggers {
    schedule {
      cron      = "0 12 * * *" # Daily at 12:00 UTC
      timezone  = "UTC"
    }
  }
}

output "dbt_cloud_job_id" {
  value = dbtcloud_job.example_job.id
}
