terraform {
  required_providers {
    dbtcloud = {
      source  = "dbt-labs/dbtcloud"
      version = "~> 0.3" # Use the latest compatible version
    }
  }

  required_version = ">= 1.3.0"
}

provider "dbtcloud" {
  api_token = var.dbt_cloud_api_token # API token securely passed
  account_id = var.dbt_cloud_account_id
  host_url  = var.dbt_cloud_host_url
}

# Define the dbt Cloud Project
resource "dbtcloud_project" "example_project" {
  name        = "My Terraform Project"
  description = "This project is managed via Terraform"
}

# Define a dbt Cloud Job inside the Project
resource "dbtcloud_job" "example_job" {
  name              = "Example Job"
  project_id        = dbtcloud_project.example_project.id
  execute_steps     = ["dbt run", "dbt test"]
  timeout_seconds   = 3600 # 1-hour timeout
}
