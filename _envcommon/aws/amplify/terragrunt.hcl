terraform {
  source = "${get_parent_terragrunt_dir()}/../infrastructure-iac-terraform-modules//aws-amplify"
}

inputs = {
  app_name          = "${local.app_name}-frontend"
  branch_name       = "main"
  
  environment_variables = {
    REACT_APP_API_URL = dependency.apprunner.outputs.service_url
  }
  
  tags = local.common_tags
}

dependency "apprunner" {
  config_path = "../apprunner"
  
  mock_outputs = {
    service_url = "https://mock-api.us-east-1.awsapprunner.com"
  }
}
