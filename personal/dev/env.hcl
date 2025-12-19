locals {
  environment = "dev"
  owner_vars  = read_terragrunt_config(find_in_parent_folders("owner.hcl"))
  tags        = merge(local.owner_vars.locals.tags, { environment = local.environment })
  
  # VARIABLES
  ENV = "dev"
  
  /* --------------------------- Network vars start --------------------------- */
  VPC_CIDR = "10.0.0.0/16"
  AVAILABILITY_ZONES = ["us-east-1a", "us-east-1b"]
  PUBLIC_SUBNET_CIDRS = ["10.0.1.0/24", "10.0.2.0/24"]
  PRIVATE_SUBNET_CIDRS = ["10.0.10.0/24", "10.0.20.0/24"]
  /* ---------------------------- Network vars end ---------------------------- */
  
  /* --------------------------- Amplify vars start --------------------------- */
  AMPLIFY_GIT_TOKEN   = get_env("GITHUB_ACCESS_TOKEN")
  AMPLIFY_GIT_SOURCE  = "https://github.com/jhoammoralesc/poc-galicia-frontend"
  AMPLIFY_BRANCH      = "main"
  AMPLIFY_DNS         = "app.poc.galicia.com"
  AMPLIFY_VARIABLES = {
    REACT_APP_API_URL   = "https://api.poc.galicia.com"
    REACT_APP_ENV       = "dev"
    REACT_APP_VERSION   = "1.0.0"
  }
  /* ---------------------------- Amplify vars end ---------------------------- */
  
  /* --------------------------- App Runner vars start --------------------------- */
  APPRUNNER_GIT_SOURCE = "https://github.com/jhoammoralesc/poc-galicia-backend"
  APPRUNNER_BRANCH     = "main"
  APPRUNNER_CPU        = "0.25 vCPU"
  APPRUNNER_MEMORY     = "0.5 GB"
  /* ---------------------------- App Runner vars end ---------------------------- */
  
  /* --------------------------- RDS vars start --------------------------- */
  DB_NAME     = "galicia"
  DB_USERNAME = "admin"
  DB_PASSWORD = get_env("DB_PASSWORD", "TempPassword123!")
  DB_MIN_CAPACITY = 0.5
  DB_MAX_CAPACITY = 1
  /* ---------------------------- RDS vars end ---------------------------- */
}
