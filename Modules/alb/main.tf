resource "aws_lb" "alb" {
  name                       = "${var.environment}-${var.app_name}-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = ["${var.sg}"]
  subnets                    = [for subnet in var.subnets : subnet]
  enable_deletion_protection = false
}

# creating listernes 

resource "aws_lb_listener" "alb_listner" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}

# creating target group 
resource "aws_lb_target_group" "alb_tg" {
  name        = "${var.environment}-${var.app_name}-alb-tg"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    interval            = 5
    port                = 8080
    path                = "/"
    protocol            = "HTTP"
    timeout             = 2
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
}

