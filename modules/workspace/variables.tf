variable "name" {
  type = string
}

variable "project_id" {
  type = string
}

variable "vcs_repo_github_app_installation_id" {
  type = string
}

variable "vcs_repo_ingress_submodules" {
  type    = bool
  default = true
}
