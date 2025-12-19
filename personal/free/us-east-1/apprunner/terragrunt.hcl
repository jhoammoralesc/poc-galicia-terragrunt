include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../../infrastructure-iac-terraform-modules//aws-apprunner-free"
}

locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("../dev/env-free.hcl"))
}

inputs = {
  app_name          = "poc-galicia-free"
  github_repository = local.environment_vars.locals.APPRUNNER_GIT_SOURCE
  branch_name       = local.environment_vars.locals.APPRUNNER_BRANCH
  cpu               = local.environment_vars.locals.APPRUNNER_CPU
  memory            = local.environment_vars.locals.APPRUNNER_MEMORY
}
