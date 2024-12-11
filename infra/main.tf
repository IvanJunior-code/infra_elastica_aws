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

resource "aws_launch_template" "template_maquina" {
  name                 = "Template_de_Maquina"
  image_id             = var.image_id
  instance_type        = var.instance_type
  key_name             = var.key_name
  security_group_names = [var.grupoSeguranca]

  tags = {
    Name = "Template de Máquina"
  }
}

resource "aws_autoscaling_group" "autoscaling_maquinas" {
  name               = "Autoscaling_maquinas"
  availability_zones = ["${var.regiao}a"]
  launch_template {
    id      = aws_launch_template.template_maquina.id
    version = "$Latest"
  }
  min_size = var.min_size
  max_size = var.max_size
}