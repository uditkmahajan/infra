output "target_id" {
  value = aws_lb_target_group.alb_tg.id
}

output "alb_dns" {
  value = aws_lb.alb.dns_name
}