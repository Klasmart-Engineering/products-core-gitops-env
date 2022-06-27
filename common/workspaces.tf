module "workspaces" {
  for_each = local.environments
  source   = "git@github.com:KL-Infrastructure/terraform-tfe-ws-base.git?ref=v0.4.0"

  # Module inputs here
  region              = each.value.region
  project_environment = each.value.project_environment
  project_region      = each.value.project_region
  service_owner       = each.value.service_owner

  workspace_name          = each.value.workspace_name
  vcs_repo                = each.value.env_repo
  domain                  = each.value.domain
  vcs_repo_default_branch = each.value.env_repo_default_branch
  working_directory       = each.value.working_directory
  workspace_description   = each.value.workspace_description

  auto_apply = local.tf_workspace_auto_apply

  # RBAC settings
  tfe_team_access_permissions = {
    "Infrastructure" = "admin"
    "sso"            = "read"
  }
  # Notification settings
  notify_triggers = ["run:needs_attention", "run:applying", "run:completed", "run:errored"]
  tags = [
    "lay:product",
    "reg:${lower(each.value.region)}",
    "env:${lower(each.value.project_environment)}",
    "loc:${lower(each.value.project_region)}",
    "own:${lower(each.value.service_owner)}",
    "dom:${replace(each.value.domain, ".", "-")}",
  ]

  providers = {
    tfe = tfe
  }
}
