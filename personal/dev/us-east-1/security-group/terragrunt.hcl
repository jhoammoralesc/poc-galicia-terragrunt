include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../../infrastructure-iac-terraform-modules//aws-security-group"
}

dependency "vpc" {
  config_path = "../vpc"
  
  mock_outputs = {
    vpc_id         = "vpc-12345678"
    vpc_cidr_block = "10.0.0.0/16"
  }
}

locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

inputs = {
  app_name = "poc-galicia-${local.environment_vars.locals.environment}"
  vpc_id   = dependency.vpc.outputs.vpc_id
  vpc_cidr = dependency.vpc.outputs.vpc_cidr_block
}
