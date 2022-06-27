module "service_instance" {
  # Module import info here
  source = "git@github.com:KL-Engineering/products-tools-terraform-svc.git?ref=v0.9.2"

  # Passthrough inputs
  region              = local.dep_meta.region
  project_environment = local.dep_meta.project_environment
  project_region      = local.dep_meta.project_region
  service_owner       = local.dep_meta.service_owner
  tags                = local.dep_meta.tags

  eks_oidc_provider_arn = local.dep_cluster.eks_oidc_provider_arn
  eks_oidc_provider_id  = local.dep_cluster.eks_oidc_provider_id

  logs_bucket_id = local.dep_account.logs_bucket_id

  # Terraform operator workspaces
  aws_target_role_arn    = local.dep_meta.aws_target_role_arn
  aws_session_name       = local.dep_meta.aws_session_name
  aws_target_external_id = local.dep_meta.aws_target_external_id
  create_terraform_operator_egress = false
  tfe_operator_access_token = var.tfe_access_token

  # Kubernetes
  kubernetes_server_url          = local.cluster_endpoint
  product_namespace              = local.product_namespace
  container_registry_credentials = local.container_registry_credentials
  # Subscription Terraform helm chart applications
  terraform_argocd_apps = []

  domain = local.domain

  # ArgoCD
  argocd_namespace = local.argocd_namespace
  argocd_project   = local.argocd_project_name
  project          = local.argocd_project_name

  gitops_repo_url = "git@github.com:KL-Engineering/products-core-gitops-env.git"
  gitops_revision = "HEAD"
  # Helm
  # The name of the app is the key and the suffix  "${var.project_environment}-${var.project_region}"
  # e.g. microgateway-apifactory-uk
  argocd_applications = ["products-core"]



  # tfe_ssh_key_id = data.tfe_ssh_key.deploy.id
  tfe_ssh_key_id = var.tfe_deploy_ssh_key_id

  providers = {
    kubernetes = kubernetes
    argocd     = argocd
  }
}
