terraform {
  required_version = "~> 1.16.0"

  required_providers {
    github = {
      source = "integrations/github"
    }
    local = {
      source = "hashicorp/local"
    }
  }
}
