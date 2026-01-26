data "tfe_organization" "main" {
  # This block is purposely empty
}

data "tfe_workspace" "main" {
  name         = var.workspace_name
  organization = data.tfe_organization.main.name
}
