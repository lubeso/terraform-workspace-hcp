resource "tfe_workspace" "cloudflare" {
  name       = "cloudflare"
  project_id = data.tfe_project.main.id
  vcs_repo {
    identifier                 = "${data.github_user.main.username}/${github_repository.cloudflare.name}"
    github_app_installation_id = data.tfe_github_app_installation.main.installation_id
  }
  depends_on = [github_repository_ruleset.cloudflare]
}

resource "tfe_workspace_settings" "cloudflare" {
  workspace_id = tfe_workspace.cloudflare.id
}

resource "github_repository" "cloudflare" {
  name                = "terraform-workspace-cloudflare"
  allow_merge_commit  = false
  allow_squash_merge  = false
  allow_update_branch = true
  has_discussions     = false
  has_issues          = false
  has_projects        = false
  has_wiki            = false
}

resource "github_repository_ruleset" "cloudflare" {
  name        = "default"
  repository  = github_repository.cloudflare.name
  target      = "branch"
  enforcement = "active"
  bypass_actors {
    actor_id    = 5
    actor_type  = "RepositoryRole"
    bypass_mode = "always"
  }
  conditions {
    ref_name {
      exclude = []
      include = ["~DEFAULT_BRANCH"]
    }
  }
  rules {
    creation                = true
    update                  = true
    deletion                = true
    required_linear_history = true
    required_signatures     = true
    pull_request {
      dismiss_stale_reviews_on_push   = true
      require_last_push_approval      = true
      required_approving_review_count = 1
      allowed_merge_methods           = ["rebase"]
    }
    non_fast_forward = true
  }
}
