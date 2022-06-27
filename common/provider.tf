provider "tfe" {}

# ArgoCD Layer
provider "argocd" {
  port_forward                = true
  port_forward_with_namespace = "argocd"
  plain_text                  = true
  kubernetes {
    host                   = local.tools_cluster_endpoint
    cluster_ca_certificate = base64decode(local.tools_kubeconfig_certificate_authority_data)
    token                  = var.tools_cluster_tfc_sa_token
  }
}