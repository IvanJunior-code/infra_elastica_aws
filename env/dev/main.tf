module "aws-dev" {
  source         = "../../infra"
  key_name       = var.key_name
  path_key       = var.path_key
  grupoSeguranca = "dev"
  max_size       = 2
  min_size       = 0
}