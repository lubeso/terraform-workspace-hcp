module "vcs_repo" {
  source = "./vcs_repo"
  name   = "terraform-workspace-${var.name}"
}

resource "tfe_workspace" "main" {
  depends_on = [module.vcs_repo]
  name       = var.name
  project_id = var.project_id
  vcs_repo {
    identifier                 = module.vcs_repo.identifier
    github_app_installation_id = var.vcs_repo_github_app_installation_id
    ingress_submodules         = var.vcs_repo_ingress_submodules
  }
}

resource "tfe_workspace_settings" "main" {
  workspace_id = tfe_workspace.main.id
}
