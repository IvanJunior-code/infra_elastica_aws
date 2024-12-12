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
  min_size = var.min_size
  max_size = var.max_size
  
  launch_template {
    id      = aws_launch_template.template_maquina.id
    version = "$Latest"
  }

  target_group_arns = [ aws_lb_target_group.target_group.arn ]

}

resource "aws_lb" "load_balancer" {
  name     = "LoadBalancer"
  internal = false
  subnets  = [aws_default_subnet.subnet1.id, aws_default_subnet.subnet2.id]

  tags = {
    Name = "Load Balancer"
  }
}

resource "aws_default_vpc" "default_vpc" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_default_subnet" "subnet1" {
  availability_zone = "${var.regiao}a"

  tags = {
    Name = "Subnet Default 1"
  }
}

resource "aws_default_subnet" "subnet2" {
  availability_zone = "${var.regiao}b"

  tags = {
    Name = "Subnet Default 2"
  }
}

resource "aws_lb_target_group" "target_group" {
  name     = "TargetGroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_default_vpc.default_vpc.id

  tags = {
    Name = "Target Group"
  }
}

resource "aws_lb_listener" "load_balancer_listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }

  tags = {
    Name = "Load Balancer Listener"
  }
}
