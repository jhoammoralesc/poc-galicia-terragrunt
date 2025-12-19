# ---------------------------------------------------------------------------------------------------------------------
# COMMON TERRAGRUNT CONFIGURATION
# This is the common component configuration for VPC network. The common variables for each environment to
# deploy VPC network are defined here. This configuration will be merged into the environment configuration
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
  base_source_url = "../../../../../infrastructure-iac-terraform-modules//aws-vpc-network"
}

# ---------------------------------------------------------------------------------------------------------------------
# MODULE PARAMETERS
# These are the variables we have to pass in to use the module. This defines the parameters that are common across all
# environments.
# ---------------------------------------------------------------------------------------------------------------------
inputs = {
  vpc_cidr             = local.environment_vars.locals.VPC_CIDR
  availability_zones   = local.environment_vars.locals.AVAILABILITY_ZONES
  public_subnet_cidrs  = local.environment_vars.locals.PUBLIC_SUBNET_CIDRS
  private_subnet_cidrs = local.environment_vars.locals.PRIVATE_SUBNET_CIDRS
}
