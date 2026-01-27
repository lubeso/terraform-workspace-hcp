resource "github_repository" "main" {
  name                = var.name
  allow_merge_commit  = false
  allow_squash_merge  = false
  allow_update_branch = true
  auto_init           = true
  has_discussions     = false
  has_issues          = false
  has_projects        = false
  has_wiki            = false
}

resource "github_repository_ruleset" "default_branch" {
  name        = "default-branch"
  repository  = github_repository.main.name
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
