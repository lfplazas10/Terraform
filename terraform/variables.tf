variable "gcp_project_id" {
  description = "GCP project ID"
  default     = "cloudweekend-ab33b7e5" // replace with your GCP project id
}

variable "gcp_region" {
  description = "GCP region, e.g. europe-west1"
  default     = "europe-west1"
}

variable "gcp_zone" {
  description = "GCP zone, e.g. europe-west2-d (which must be in gcp_region)"
  default     = "europe-west1-d"
}

variable "gcp_additional_zones" {
  description = "List of additional GCP zones, e.g. europe-west1-c"
  type        = "list"
  default     = ["europe-west1-c", "europe-west1-b"]
}

variable "cluster_name" {
  description = "Name of the K8s cluster"
  default     = "cloudweekend"
}

variable "initial_node_count" {
  description = "Number of worker VMs to initially create"
  default     = 1
}

variable "cloudfare_email" {
  description = "Cloudfare email"
  default     = "cloudweekend@kiwi.com"
}

variable "cloudfare_token" {
  description = "Cloudfare token"
  default     = "35dc179e718884621288a63d44ecf1bcf18c6"
}

variable "my_domains" {
  description = "my domains."
  type        = "list"

  default = [
    "luis-plazas",
    "luis-plazas-canary",
  ]
}
