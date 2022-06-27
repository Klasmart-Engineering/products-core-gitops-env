# This is set in TFE workspace and is being consumed here
variable "tools_cluster_tfc_sa_token" {
  description = "Service account token for Kubernetes service account to connect to Tools cluster"
  type        = string
}

variable "github_repo_access_token" {
  description = "GitHub PAT for the Engineering Org - with access to repos"
  type        = string
}