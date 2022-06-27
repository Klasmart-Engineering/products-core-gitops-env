locals {
  terraform_organization = "kidsloop-infrastructure"

  dep_tools              = nonsensitive(data.tfe_outputs.cluster-infra-tools.values)
  dep_apifactory_account = nonsensitive(data.tfe_outputs.account-api-factory.values)
  dep_apifactory_cluster = nonsensitive(data.tfe_outputs.cluster-api-factory.values)
  dep_apifactory_meta    = nonsensitive(data.tfe_outputs.meta-api-factory.values)


  # Infra tools EKS variables (for ArgoCD / Teleport)
  tools_cluster_endpoint                      = local.dep_tools.cluster_endpoint
  tools_kubeconfig_certificate_authority_data = local.dep_tools.kubeconfig_certificate_authority_data

  tf_workspace_auto_apply = true
  argocd_project_name     = "products-core"
  argocd_namespace        = "argocd"

  product_namespace = "products-core"

  # TODO(INFRAENG-243): Pull these values from other workspace outputs
  # Used by workspaces module
  environments = {
    apifactory = {
      url                     = local.dep_apifactory_cluster.cluster_endpoint
      region                  = local.dep_apifactory_meta.region
      project_environment     = local.dep_apifactory_meta.project_environment
      project_region          = local.dep_apifactory_meta.project_region
      service_owner           = local.dep_apifactory_meta.service_owner
      workspace_name          = "${local.argocd_project_name}-${local.dep_apifactory_meta.project_environment}-${local.dep_apifactory_meta.project_region}"
      env_repo                = "KL-Engineering/${local.argocd_project_name}-gitops-env"
      domain                  = local.dep_apifactory_account.domain
      env_repo_default_branch = "main"
      working_directory       = "${local.dep_apifactory_meta.project_environment}/${local.dep_apifactory_meta.project_region}/tools"
      workspace_description   = "${local.argocd_project_name} workspace"
    }
  }

  argocd_helm_repositories = {
    # Already exists
    # terraform-base-helm = {
    #   repo = "https://raw.githubusercontent.com/KL-Engineering/terraform-base-helm/main"
    # }
  }

  argocd_project_whitelisted_repos = [
    "https://helm.releases.hashicorp.com",
    "https://raw.githubusercontent.com/kl-engineering/terraform-base-helm/main",
    "git@github.com:KL-Engineering/products-core-gitops-env.git",
  ]
}
