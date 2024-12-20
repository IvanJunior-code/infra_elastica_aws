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
  default_tags {
    tags = local.management_tags
  }
}

resource "aws_launch_template" "template_maquina" {
  name                 = "Template_de_Maquina_${var.environment}"
  image_id             = var.image_id
  instance_type        = var.instance_type
  key_name             = var.key_name
  security_group_names = [ aws_security_group.security_group.name ]

  user_data = var.prod ? base64encode(<<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y nginx
              echo "${file("index.html")}" | sudo tee /var/www/html/index.html
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF
  ) : ""

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "Máquina ${var.environment}-${timestamp()}}"
    }
  }

  tags = {
    Name = "Máquina ${var.environment}"
  }
}

resource "aws_autoscaling_group" "autoscaling_maquinas" {
  name               = "Autoscaling_maquinas_${var.environment}"
  availability_zones = ["${var.regiao}a", "${var.regiao}b"]
  min_size           = var.min_size
  max_size           = var.max_size

  launch_template {
    id      = aws_launch_template.template_maquina.id
    version = "$Latest"
  }

  target_group_arns = var.prod ? [aws_lb_target_group.target_group[0].arn] : []

}

resource "aws_lb" "load_balancer" {
  count    = var.prod ? 1 : 0
  name     = "LoadBalancer"
  internal = false
  subnets  = [aws_default_subnet.subnet1.id, aws_default_subnet.subnet2.id]

  tags = {
    Name = "Load Balancer ${var.environment}"
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
  count    = var.prod ? 1 : 0
  name     = "TargetGroup${var.environment}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_default_vpc.default_vpc.id

  tags = {
    Name = "Target Group ${var.environment}"
  }
}

resource "aws_lb_listener" "load_balancer_listener" {
  count             = var.prod ? 1 : 0
  load_balancer_arn = aws_lb.load_balancer[0].arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group[0].arn
  }

  tags = {
    Name = "Load Balancer Listener ${var.environment}"
  }
}

resource "aws_autoscaling_policy" "autoscaling_policy" {
  count                  = var.prod ? 1 : 0
  name                   = "AutoscalingPolicy${var.environment}"
  autoscaling_group_name = aws_autoscaling_group.autoscaling_maquinas.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 25.0
  }
}