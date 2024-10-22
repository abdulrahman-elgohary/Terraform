output "nlb_public_dns" {
  value = aws_lb.public_nlb.dns_name
}