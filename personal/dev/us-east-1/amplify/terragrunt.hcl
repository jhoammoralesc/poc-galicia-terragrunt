include "root" {
  path = find_in_parent_folders()
}

include "envcommon" {
  path   = "${dirname(find_in_parent_folders())}/_envcommon/aws/amplify/amplify.hcl"
  expose = true
}

dependency "apprunner" {
  config_path = "../apprunner"
  
  mock_outputs = {
    service_url = "https://mock-api.us-east-1.awsapprunner.com"
  }
}

locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

inputs = {
  app_name = "poc-galicia-${local.environment_vars.locals.environment}"
  
  environment_variables = merge(
    local.environment_vars.locals.AMPLIFY_VARIABLES,
    {
      REACT_APP_API_URL = dependency.apprunner.outputs.service_url
    }
  )
}
