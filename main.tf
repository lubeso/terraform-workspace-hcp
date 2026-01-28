data "tfe_organization" "main" {
  # This block is purposely empty
}

data "tfe_project" "main" {
  name = var.project_name
}

data "tfe_workspace" "main" {
  name = var.workspace_name
}

data "tfe_github_app_installation" "main" {
  installation_id = var.github_app_installation_id
}

module "workspaces" {
  for_each = {
    for workspace_name in var.workspace_names
    : workspace_name => true
  }
  source                              = "./modules/workspace"
  name                                = each.key
  project_id                          = data.tfe_project.main.id
  vcs_repo_github_app_installation_id = data.tfe_github_app_installation.main.id
}
