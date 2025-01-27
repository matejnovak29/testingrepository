terraform {
  required_providers {
    dbtcloud = {
      source  = "dbt-labs/dbtcloud"
      version = "~> 0.3"
    }
  }
}

provider "dbtcloud" {
  token  = var.dbt_cloud_api_token
  account_id = var.dbt_cloud_account_id
  host_url   = "https://cloud.getdbt.com/api"
}

# Define the dbt Cloud Project
resource "dbtcloud_project" "dbt_project" {
  name        = "My Terraform Project"
  description = "A simple dbt project created via Terraform"
}

# Define the dbt Cloud Environment
resource "dbtcloud_environment" "dbt_environment" {
  name        = "Development Environment"
  type        = "development" # Development environment
  project_id  = dbtcloud_project.dbt_project.id
  dbt_version = "1.4.0"
}

# Define a simple dbt Cloud Job
resource "dbtcloud_job" "simple_job" {
  name           = "Simple Job"
  project_id     = dbtcloud_project.dbt_project.id
  environment_id = dbtcloud_environment.dbt_environment.environment_id

  # Steps to execute
  execute_steps = [
    "dbt run",
    "dbt test"
  ]

  triggers = {
    "schedule" = true
  }

  # Schedule: Daily at 12:00 UTC
  schedule_days = [0, 1, 2, 3, 4, 5, 6] # All days of the week
  schedule_type = "days_of_week"
  cron          = "0 12 * * *" # Daily at 12:00 UTC
  timezone      = "UTC"
}

# Output the Job ID
output "dbt_cloud_job_id" {
  value = dbtcloud_job.simple_job.id
}
