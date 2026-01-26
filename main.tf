data "tfe_organization" "main" {
  # This block is purposely empty
}

data "tfe_project" "main" {
  name         = var.project.name
  organization = data.tfe_organization.main.name
}
