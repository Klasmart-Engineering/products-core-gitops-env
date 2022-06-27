terraform {
  required_version = ">= 1.0.0"
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = ">= 0.30.2"
    }
    argocd = {
      source  = "oboukili/argocd"
      version = ">= 3.0.1"
    }
  }
}
