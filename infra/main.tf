terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.80.0"
    }
  }
}

provider "aws" {
  region = var.regiao
}

# resource "aws_launch_template" "foo" {
#   name = "foo"
#   image_id = "ami-test"
#   instance_type = "t2.micro"
#   key_name = "test"

#   tags = {

#   }
# }