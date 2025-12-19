# ---------------------------------------------------------------------------------------------------------------------
# COMMON TERRAGRUNT CONFIGURATION
# This is the common component configuration for App Runner. The common variables for each environment to
# deploy App Runner are defined here. This configuration will be merged into the environment configuration
# via an include block.
# ---------------------------------------------------------------------------------------------------------------------

terraform {
  source = "${local.base_source_url}"
}

# ---------------------------------------------------------------------------------------------------------------------
# Locals are named constants that are reusable within the configuration.
# ---------------------------------------------------------------------------------------------------------------------
locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Extract out common variables for reuse
  env = local.environment_vars.locals.environment

  # Expose the base source URL so different versions of the module can be deployed in different environments. This will
  # be used to construct the terraform block in the child terragrunt configurations.
  base_source_url = "../../../../../infrastructure-iac-terraform-modules//aws-apprunner"
}

# ---------------------------------------------------------------------------------------------------------------------
# MODULE PARAMETERS
# These are the variables we have to pass in to use the module. This defines the parameters that are common across all
# environments.
# ---------------------------------------------------------------------------------------------------------------------
inputs = {
  github_repository = local.environment_vars.locals.APPRUNNER_GIT_SOURCE
  branch_name      = local.environment_vars.locals.APPRUNNER_BRANCH
  cpu              = local.environment_vars.locals.APPRUNNER_CPU
  memory           = local.environment_vars.locals.APPRUNNER_MEMORY
}
