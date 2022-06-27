# Dependency for the tools-prod workspace, that has the ArgoCD cluster, to put in the provider.data
# Infra tools cluster - for API connection to ArgoCD - using PROD
data "tfe_outputs" "cluster-infra-tools" {
  organization = local.terraform_organization
  workspace    = "cluster-infra-tools-prod"
}

data "tfe_outputs" "cluster-api-factory" {
  organization = local.terraform_organization
  workspace    = "cluster-uk-apifactory"
}

data "tfe_outputs" "account-api-factory" {
  organization = local.terraform_organization
  workspace    = "account-uk-apifactory"
}

data "tfe_outputs" "meta-api-factory" {
  organization = local.terraform_organization
  workspace    = "meta-uk-apifactory"
}