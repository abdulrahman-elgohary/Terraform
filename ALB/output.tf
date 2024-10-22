output "alb_private_dns" {
  value = aws_lb.private_alb.dns_name
}