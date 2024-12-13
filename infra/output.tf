output "access_load_balancer_address" {
  value = "http://${aws_lb.load_balancer.dns_name}"
}