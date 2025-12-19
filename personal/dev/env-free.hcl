locals {
  environment = "dev"
  owner_vars  = read_terragrunt_config(find_in_parent_folders("owner.hcl"))
  tags        = merge(local.owner_vars.locals.tags, { environment = local.environment })
  
  # VARIABLES - FREE TIER VERSION
  ENV = "dev"
  
  /* --------------------------- Amplify vars start --------------------------- */
  AMPLIFY_GIT_TOKEN   = get_env("GITHUB_ACCESS_TOKEN")
  AMPLIFY_GIT_SOURCE  = "https://github.com/jhoammoralesc/poc-galicia-frontend"
  AMPLIFY_BRANCH      = "main"
  AMPLIFY_VARIABLES = {
    REACT_APP_API_URL   = "https://api.poc.galicia.com"
    REACT_APP_ENV       = "dev"
    REACT_APP_VERSION   = "1.0.0"
  }
  /* ---------------------------- Amplify vars end ---------------------------- */
  
  /* --------------------------- App Runner vars start --------------------------- */
  APPRUNNER_GIT_SOURCE = "https://github.com/jhoammoralesc/poc-galicia-backend"
  APPRUNNER_BRANCH     = "main"
  APPRUNNER_CPU        = "0.25 vCPU"  # Free tier
  APPRUNNER_MEMORY     = "0.5 GB"     # Free tier
  /* ---------------------------- App Runner vars end ---------------------------- */
  
  /* --------------------------- RDS vars start --------------------------- */
  # Using RDS Free Tier instead of Aurora Serverless
  DB_INSTANCE_CLASS    = "db.t3.micro"  # Free tier
  DB_ALLOCATED_STORAGE = 20              # Free tier (20GB)
  DB_ENGINE           = "mysql"
  DB_ENGINE_VERSION   = "8.0"
  DB_NAME             = "galicia"
  DB_USERNAME         = "admin"
  DB_PASSWORD         = get_env("DB_PASSWORD", "TempPassword123!")
  /* ---------------------------- RDS vars end ---------------------------- */
}
