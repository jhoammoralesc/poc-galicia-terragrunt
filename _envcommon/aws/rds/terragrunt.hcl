terraform {
  source = "${get_parent_terragrunt_dir()}/../infrastructure-iac-terraform-modules//aws-rds-serverless"
}

inputs = {
  app_name                = local.app_name
  database_name          = "galicia"
  master_username        = "admin"
  master_password        = get_env("POC_GALICIA_DB_PASSWORD", "TempPassword123!")
  backup_retention_period = 1
  skip_final_snapshot    = true
  auto_pause            = true
  max_capacity          = 2
  min_capacity          = 1
  seconds_until_auto_pause = 300
  
  tags = local.common_tags
}
