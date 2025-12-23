include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "https://github.com/jhoammoralesc/poc-galicia-terraform-modules.git//aws-amplify"
}

}

dependency "apprunner" {
  config_path = "../apprunner"
  
  mock_outputs = {
    service_url = "https://mock-api.us-east-1.awsapprunner.com"
  }
}

locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("../dev/env-free.hcl"))
}

inputs = {
  app_name              = "poc-galicia-free"
  github_repository     = local.environment_vars.locals.AMPLIFY_GIT_SOURCE
  github_access_token   = local.environment_vars.locals.AMPLIFY_GIT_TOKEN
  branch_name          = local.environment_vars.locals.AMPLIFY_BRANCH
  
  environment_variables = merge(
    local.environment_vars.locals.AMPLIFY_VARIABLES,
    {
      REACT_APP_API_URL = dependency.apprunner.outputs.service_url
    }
  )
}
