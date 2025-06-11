resource "aws_lb" "demo_apps_lb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.lb_security_group
  subnets            = var.lb_subnets
  enable_deletion_protection = false

  tags = {
    Name        = "${var.project_name}-${var.environment}-alb"
    Environment = var.environment
  }
}

resource "aws_lb_target_group" "patient_tg" {
  name     = "patient-service-tg"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"

  health_check {
    enabled             = true
    healthy_threshold   = 2
    interval            = 30
    matcher             = "200"
    path                = "/health"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group" "appointment_tg" {
  name     = "appointment-service-tg"
  port     = 3001
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip" 

  health_check {
    enabled             = true
    healthy_threshold   = 2
    interval            = 30
    matcher             = "200"
    path                = "/health"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }
  tags = {
    Name        = "${var.project_name}-${var.environment}-appointment-tg"
    Service     = "appointment-service"
    Environment = var.environment
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
  tags = {
    Name        = "${var.project_name}-${var.environment}-alb-listener"
    Environment = var.environment
  }
}

resource "aws_lb_listener_rule" "patient_service_rule" {
  listener_arn = aws_lb_listener.http_listener.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.patient_tg.arn
  }

  condition {
    path_pattern {
      values = ["/patients*"]
    }
  }
  tags = {
    Name        = "${var.project_name}-${var.environment}-alb-listener"
    Environment = var.environment
  }
}

resource "aws_lb_listener_rule" "appointment_service_rule" {
  listener_arn = aws_lb_listener.http_listener.arn
  priority     = 200

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.appointment_tg.arn
  }

  condition {
    path_pattern {
      values = ["/appointments*"]
    }
  }
  tags = {
    Name        = "${var.project_name}-${var.environment}-appointment-rule"
    Service     = "appointment-service"
    Environment = var.environment
  }
}


# Health check rule for both services
resource "aws_lb_listener_rule" "health_check" {
  listener_arn = aws_lb_listener.main.arn
  priority     = 50

  action {
    type = "fixed-response"

    fixed_response {
      content_type = "application/json"
      message_body = "{\"status\":\"healthy\",\"services\":[\"patient-service\",\"appointment-service\"]}"
      status_code  = "200"
    }
  }

  condition {
    path_pattern {
      values = ["/health"]
    }
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-health-rule"
    Environment = var.environment
  }
}
