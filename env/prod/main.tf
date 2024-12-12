module "aws-prod" {
    source = "../../infra"
    key_name = var.key_name
    path_key = var.path_key
    grupoSeguranca = "producao"
    max_size = 10
    min_size = 2
}