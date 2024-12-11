module "aws-dev" {
  source   = "../../infra"
  key_name = var.key_name
  path_key = var.path_key
}