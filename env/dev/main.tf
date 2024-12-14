module "aws-dev" {
  source      = "../../infra"
  key_name    = var.key_name
  path_key    = var.path_key
  environment = "dev"
  max_size    = 3
  min_size    = 1
  prod        = false
}