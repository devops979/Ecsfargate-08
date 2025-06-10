resource "aws_ecs_cluster" "demo" {
  name = var.ecs_cluster_name
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_cloudwatch_log_group" "ecs_logs" {
  name              = "/ecs/${var.ecs_cluster_name}"
  retention_in_days = 30 
}

resource "aws_ecs_task_definition" "patient_service" {
  family                   = var.ecs_task_family-patient
  execution_role_arn       = var.ecs_execution_role_arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  cpu       = "256"
  memory    = "512"

  container_definitions = jsonencode([{
    name      = "patient-service"
    image     = var.patient_service_image
    cpu       = 256
    memory    = 512
    essential = true
    portMappings = [
      {
        containerPort = 3000 
        hostPort      = 3000
        protocol      = "tcp"
      }
    ]
    logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.ecs_logs.name
          awslogs-region        = "us-east-1"
          awslogs-stream-prefix = "patient-service"
        }
    }
  }])
}

resource "aws_ecs_task_definition" "appointment_service" {
  family                   = var.ecs_task_family-appointment
  execution_role_arn       = var.ecs_execution_role_arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  cpu       = "256"
  memory    = "512"

  container_definitions = jsonencode([{
    name      = "appointment-service"
    image     = var.appointment_service_image
    cpu       = 256
    memory    = 512
    essential = true
    portMappings = [
      {
        containerPort = 3001
        hostPort      = 3001
        protocol      = "tcp"
      }
    ]
    logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.ecs_logs.name
          awslogs-region        = "us-east-1"
          awslogs-stream-prefix = "appointment-service"
        }
    }
  }])
}

resource "aws_ecs_service" "patient_service" {
  name            = "patient-service"
  cluster         = aws_ecs_cluster.demo.id
  task_definition = aws_ecs_task_definition.patient_service.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnet_id
    security_groups = [var.security_group_id]
    assign_public_ip = true
  }
  load_balancer {
    target_group_arn = var.patient_tg_arn
    container_name   = "patient-service"
    container_port   = 3000
  }
  depends_on = [var.alb_arn, var.patient_tg_arn]
}


resource "aws_ecs_service" "appointment_service" {
  name            = "appointment-service"
  cluster         = aws_ecs_cluster.demo.id
  task_definition = aws_ecs_task_definition.appointment_service.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnet_id
    security_groups = [var.security_group_id]
    assign_public_ip = true
  }
  load_balancer {
    target_group_arn = var.appointment_tg_arn
    container_name   = "appointment-service"
    container_port   = 3001
  }
  depends_on = [var.alb_arn, var.appointment_tg_arn]
}
