locals {
  management_tags = {
    CreatedBy   = "Terraform"
    Environment = var.environment
    Project     = "Terraform Load Balancer Test Project"
    Owner       = "Ivan"
  }
}