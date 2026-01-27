module "workspaces" {
  for_each = {
    for workspace_name in var.workspace_names
    : workspace_name => true
  }
  source                              = "./modules/tfe/workspace"
  name                                = each.key
  project_id                          = data.tfe_project.main.id
  vcs_repo_github_app_installation_id = data.tfe_github_app_installation.main.id
}
