resource "aws_security_group" "security_group" {
  name = "SecurityGroup${var.environment}"
}

resource "aws_vpc_security_group_ingress_rule" "ingress_rule_dev_ssh" {
  count             = var.prod ? 0 : 1
  security_group_id = aws_security_group.security_group.id

  cidr_ipv4 = "0.0.0.0/0"
  #cidr_ipv6   = "::/0"
  from_port   = 22
  ip_protocol = "TCP"
  to_port     = 22

  tags = {
    Name = "Ingress Rule SSH ${var.environment}"
  }
}

resource "aws_vpc_security_group_egress_rule" "egress_rule_enable_all" {
  security_group_id = aws_security_group.security_group.id

  cidr_ipv4 = "0.0.0.0/0"
  #cidr_ipv6   = "::/0"
  ip_protocol = "-1"

  tags = {
    Name = "Egress Rule ${var.environment}"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ingress_rule_prod_http" {
  count             = var.prod ? 1 : 0
  security_group_id = aws_security_group.security_group.id

  cidr_ipv4 = "0.0.0.0/0"
  #cidr_ipv6   = "::/0"
  from_port   = 80
  ip_protocol = "TCP"
  to_port     = 80

  tags = {
    Name = "Ingress Rule HTTP ${var.environment}"
  }
}