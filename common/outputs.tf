output "argocd_project_name" {
  description = "The name of the ArgoCD project for this product"
  value       = local.argocd_project_name
}

output "product_namespace" {
  description = "The kubernetes namespace assigned to this product product"
  value       = local.product_namespace
}