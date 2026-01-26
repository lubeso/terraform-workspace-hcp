terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.73.0"
    }
  }
}

provider "tfe" {
  # This block is purposely empty
}
