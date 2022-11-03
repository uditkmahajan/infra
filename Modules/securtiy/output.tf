output "jump_sg_id" {
  value = aws_security_group.jump-sg.id
}

output "alb_sg_id" {
  value = aws_security_group.alb-sg.id
}

output "lt_sg_id" {
  value = aws_security_group.asg-ec2-sg.id
}

output "db_sg_id" {
  value = aws_security_group.db-sg.id
}

output "db_sg_for_ec2_id" {
  value = aws_security_group.db_sg_for_ec2.id
}