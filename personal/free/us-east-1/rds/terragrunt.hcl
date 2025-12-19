include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../../infrastructure-iac-terraform-modules//aws-rds-free"
}

locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("../dev/env-free.hcl"))
}

inputs = {
  app_name          = "poc-galicia-free"
  engine            = local.environment_vars.locals.DB_ENGINE
  engine_version    = local.environment_vars.locals.DB_ENGINE_VERSION
  instance_class    = local.environment_vars.locals.DB_INSTANCE_CLASS
  allocated_storage = local.environment_vars.locals.DB_ALLOCATED_STORAGE
  database_name     = local.environment_vars.locals.DB_NAME
  master_username   = local.environment_vars.locals.DB_USERNAME
  master_password   = local.environment_vars.locals.DB_PASSWORD
}
