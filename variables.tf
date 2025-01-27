variable "dbt_cloud_api_token" {
  description = "The API token for dbt Cloud authentication"
  type        = string
  sensitive   = true
}

variable "dbt_cloud_account_id" {
  description = "The account ID for dbt Cloud"
  type        = number
}

variable "dbt_cloud_host_url" {
  description = "The base URL for the dbt Cloud API"
  type        = string
  default     = "https://cloud.getdbt.com/api"
}
