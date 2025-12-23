# ---------------------------------------------------------------------------------------------------------------------
# COMMON TERRAGRUNT CONFIGURATION
# This is the common component configuration for Amplify. The common variables for each environment to
# deploy Amplify are defined here. This configuration will be merged into the environment configuration
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
  base_source_url = "https://github.com/jhoammoralesc/poc-galicia-terraform-modules.git//aws-amplify"
}

# ---------------------------------------------------------------------------------------------------------------------
# MODULE PARAMETERS
# These are the variables we have to pass in to use the module. This defines the parameters that are common across all
# environments.
# ---------------------------------------------------------------------------------------------------------------------
inputs = {
  github_repository     = local.environment_vars.locals.AMPLIFY_GIT_SOURCE
  github_access_token   = local.environment_vars.locals.AMPLIFY_GIT_TOKEN
  branch_name          = local.environment_vars.locals.AMPLIFY_BRANCH
  custom_domain        = local.environment_vars.locals.AMPLIFY_DNS
  environment_variables = local.environment_vars.locals.AMPLIFY_VARIABLES
}
