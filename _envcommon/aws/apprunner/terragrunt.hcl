terraform {
  source = "${get_parent_terragrunt_dir()}/../infrastructure-iac-terraform-modules//aws-apprunner"
}

inputs = {
  app_name                 = local.app_name
  branch_name             = "main"
  runtime                 = "DOCKER"
  build_command           = "docker build -t galicia-api ."
  start_command           = "docker run -p 8080:8080 galicia-api"
  port                    = "8080"
  cpu                     = "0.25 vCPU"
  memory                  = "0.5 GB"
  health_check_path       = "/health"
  auto_deployments_enabled = true
  
  environment_variables = {
    ASPNETCORE_ENVIRONMENT = "Production"
    ASPNETCORE_URLS       = "http://+:8080"
    DATABASE_URL          = dependency.rds.outputs.cluster_endpoint
  }
  
  tags = local.common_tags
}

dependency "rds" {
  config_path = "../rds"
  
  mock_outputs = {
    cluster_endpoint = "mock-cluster.cluster-xyz.us-east-1.rds.amazonaws.com"
  }
}
