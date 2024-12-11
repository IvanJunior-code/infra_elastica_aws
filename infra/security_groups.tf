resource "aws_security_group" "security_group" {
  name = var.grupoSeguranca
}

resource "aws_vpc_security_group_ingress_rule" "ingress_rule_enable_all" {
  security_group_id = aws_security_group.security_group.id

  cidr_ipv4 = "0.0.0.0/0"
  #cidr_ipv6   = "::/0"
  #from_port   = 0
  ip_protocol = "-1"
  #to_port     = 0

  tags = {
    Name = "Ingress Rule"
  }
}

resource "aws_vpc_security_group_egress_rule" "egress_rule_enable_all" {
  security_group_id = aws_security_group.security_group.id

  cidr_ipv4 = "0.0.0.0/0"
  #cidr_ipv6   = "::/0"
  #from_port   = 0
  ip_protocol = "-1"
  #to_port     = 0

  tags = {
    Name = "Egress Rule"
  }
}