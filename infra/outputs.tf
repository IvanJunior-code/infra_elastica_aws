output "access_load_balancer_address" {
  value = var.prod ? "http://${aws_lb.load_balancer[0].dns_name}" : ""
}


data "aws_instances" "instances" {
  filter {
    name   = "tag:aws:autoscaling:groupName"
    values = [ aws_autoscaling_group.autoscaling_maquinas.name ]
  }
  filter {
    name   = "instance-type"
    values = [aws_launch_template.template_maquina.instance_type]
  }
}

output "ssh_string_connection" {
  value = var.prod ? [] : [for instance in data.aws_instances.instances.public_ips : "ssh -i ${var.path_key}${var.key_name}.pem ubuntu@${instance}"]
}