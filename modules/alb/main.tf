resource "aws_lb" "demo_apps_lb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.lb_security_group
  subnets            = var.lb_subnets
}

resource "aws_lb_target_group" "patient_tg" {
  name     = "patient-service-tg"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"

  health_check {
    path                = "/health"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

resource "aws_lb_target_group" "appointment_tg" {
  name     = "appointment-service-tg"
  port     = 3001
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip" 

  health_check {
    path                = "/health"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.demo_apps_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "fixed-response"
    fixed_response {
      status_code   = 200
      message_body  = "Message from the ALB"
      content_type  = "text/plain"
    }
  }
}

resource "aws_lb_listener_rule" "patient_service_rule" {
  listener_arn = aws_lb_listener.http_listener.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.patient_tg.arn
  }

  condition {
    path_pattern {
      values = ["/patients"]
    }
  }
}

resource "aws_lb_listener_rule" "appointment_service_rule" {
  listener_arn = aws_lb_listener.http_listener.arn
  priority     = 2

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.appointment_tg.arn
  }

  condition {
    path_pattern {
      values = ["/appointments"]
    }
  }
}
