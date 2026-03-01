terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.11.1"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.7.0"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.74.0"
    }
  }
}

provider "github" {
  # This block is purposely empty
}

provider "tfe" {
  # This block is purposely empty
}

provider "local" {
  # This block is purposely empty
}
