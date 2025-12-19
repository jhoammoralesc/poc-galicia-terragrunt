include "root" {
  path = find_in_parent_folders()
}

include "envcommon" {
  path   = "${dirname(find_in_parent_folders())}/_envcommon/aws/rds/rds-serverless.hcl"
  expose = true
}

dependency "vpc" {
  config_path = "../vpc"
  
  mock_outputs = {
    private_subnet_ids = ["subnet-12345678", "subnet-87654321"]
  }
}

dependency "security_group" {
  config_path = "../security-group"
  
  mock_outputs = {
    rds_security_group_id = "sg-12345678"
  }
}

locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

inputs = {
  app_name           = "poc-galicia-${local.environment_vars.locals.environment}"
  subnet_ids         = dependency.vpc.outputs.private_subnet_ids
  security_group_ids = [dependency.security_group.outputs.rds_security_group_id]
}
