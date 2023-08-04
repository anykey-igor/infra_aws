#----------------------------------------------------
# Create ALB
#----------------------------------------------------
resource "aws_alb" "alb" {
  name               = "${lower(var.project)}-alb-${lower(var.orchestration)}-${lower(var.environment)}"
  security_groups    = var.alb_sg_list
  load_balancer_type = "application"
  subnets            = var.subnets
  access_logs {
    enabled = true
    bucket  = "dev-s3-elb-logs-eu-central-1"
  }
}

#----------------------------------------------------
# Create ALB listener 80
#----------------------------------------------------
resource "aws_alb_listener" "listener80" {
  load_balancer_arn = aws_alb.alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_alb_target_group.tg.arn
    type             = "forward"
  }
}

#----------------------------------------------------
# Create ALB listener 443
#----------------------------------------------------
resource "aws_alb_listener" "listener443" {
  load_balancer_arn = aws_alb.alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = var.certificate_backend
  default_action {
    target_group_arn = aws_alb_target_group.tg.arn
    type             = "forward"
  }
}

#----------------------------------------------------
# Create ALB target group
#----------------------------------------------------
resource "aws_alb_target_group" "tg" {
  name        = "${lower(var.project)}-alb-tg-${lower(var.orchestration)}-${lower(var.environment)}"
  vpc_id      = var.vpc_id
  port        = 8080
  protocol    = "HTTP"
  target_type = "ip"
  health_check {
    enabled             = true
    interval            = 30
    path                = "/actuator/health"
    timeout             = 5
    matcher             = "200"
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
  stickiness {
    type = "lb_cookie"
  }
}

#----------------------------------------------------
# Associate the SSL certificate with the ALB listener
#----------------------------------------------------
resource "aws_lb_listener_certificate" "my-certificate" {
  listener_arn    = aws_alb_listener.listener443.arn
  certificate_arn = var.certificate_backend
}