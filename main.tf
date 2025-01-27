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

resource "dbtcloud_project" "example_project" {
  name        = "My Terraform Project"
  description = "Project created via Terraform"
}

resource "dbtcloud_job" "example_job" {
  name        = "Example Job"
  project_id  = dbtcloud_project.example_project.id
  execute_steps = [
    "dbt run",
    "dbt test"
  ]
}

output "dbt_cloud_job_id" {
  value = dbtcloud_job.example_job.id
}
