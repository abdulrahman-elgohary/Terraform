# Application Load Balancer (Private)
resource "aws_lb" "private_alb" {
  name               = "private-alb"
  internal           = true  # Private ALB
  load_balancer_type = "application"
  security_groups    = [var.pub_sg_id]
  subnets            = [var.priv_sub1_id, var.priv_sub2_id]
}

# ALB Target Group (HTTP for EC2 instances in private subnets)
resource "aws_lb_target_group" "private_alb_tg" {
  name     = "private-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.myvpc_id
  target_type = "instance"
  health_check {
    port               = "80"
    protocol           = "HTTP"
    path               = "/"
    healthy_threshold  = 2
    unhealthy_threshold = 2
  }
}

# Attach Private EC2 Instances to ALB Target Group
resource "aws_lb_target_group_attachment" "web1_attachment" {
  target_group_arn = aws_lb_target_group.private_alb_tg.arn
  target_id        = var.web1_id
  port             = 80
}

resource "aws_lb_target_group_attachment" "web2_attachment" {
  target_group_arn = aws_lb_target_group.private_alb_tg.arn
  target_id        = var.web2_id
  port             = 80
}

# ALB Listener (HTTP)
resource "aws_lb_listener" "private_alb_listener" {
  load_balancer_arn = aws_lb.private_alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.private_alb_tg.arn
  }
}