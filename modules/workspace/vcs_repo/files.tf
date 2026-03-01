data "local_file" "static" {
  for_each = {
    for filename in fileset("${path.module}/static", "**")
    : filename => true
  }
  filename = each.key
}

resource "github_repository_file" "static" {
  for_each       = data.local_file.static
  repository     = github_repository.main.name
  branch         = data.github_branch.main.branch
  file           = each.key
  content        = each.value.content
  commit_message = "chore: add ${each.key}"
}
