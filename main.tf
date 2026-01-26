data "tfe_organization" "main" {
  # This block is purposely empty
}

data "tfe_project" "main" {
  name = var.project_name
}

data "tfe_workspace" "main" {
  name = var.workspace_name
}
