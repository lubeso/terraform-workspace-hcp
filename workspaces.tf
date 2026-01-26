locals {
  workspaces = {
    "cloudflare" = {}
  }
}

resource "tfe_workspace" "all" {
  for_each   = local.workspaces
  name       = each.key
  project_id = data.tfe_project.main.id
  vcs_repo {
    identifier                 = "${data.github_user.main.username}/${github_repository.workspaces[each.key].name}"
    github_app_installation_id = data.tfe_github_app_installation.main.id
  }
}

resource "tfe_workspace_settings" "all" {
  for_each     = local.workspaces
  workspace_id = tfe_workspace.all[each.key].id
}

resource "github_repository" "workspaces" {
  for_each            = local.workspaces
  name                = "terraform-workspace-${each.key}"
  allow_merge_commit  = false
  allow_squash_merge  = false
  allow_update_branch = true
  has_discussions     = false
  has_issues          = false
  has_projects        = false
  has_wiki            = false
}

resource "github_repository_ruleset" "workspaces" {
  for_each    = local.workspaces
  name        = "default"
  repository  = github_repository.workspaces[each.key].name
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
