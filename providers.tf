terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.10.2"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.6.1"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.73.0"
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
