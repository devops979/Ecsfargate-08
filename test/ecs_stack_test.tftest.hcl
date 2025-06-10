run "check_vpc_and_ecr" {
  command = plan

  variables {
    cidr_block               = "10.0.0.0/16"
    environment              = "dev"
    public_subnet_cidrs      = ["10.0.1.0/24", "10.0.2.0/24"]
    private_subnet_cidrs     = ["10.0.3.0/24", "10.0.4.0/24"]
    availability_zones       = ["ap-south-1a", "ap-south-1b"]
    name_prefix              = "demo"
    ecs_cluster_name         = "demo-cluster"
    ecs_task_family          = "demo-task"
    ecs_execution_role_name  = "ecsExecRole"
    ecs_task_role_name       = "ecsTaskRole"
    service_name_patitent    = "patient-service"
    service_name_appointment = "appointment-service"
    patient_service_image     = "111111111111.dkr.ecr.ap-south-1.amazonaws.com/patient-service:latest"
    appointment_service_image = "111111111111.dkr.ecr.ap-south-1.amazonaws.com/appointment-service:latest"
    alb_name                 = "demo-alb"
    log_group_name           = "/ecs/demo-app"
  }

  # provider "aws" {
  #   region = "ap-south-1"
  # }

  assert {
    condition     = module.network.vpc_name == "demo-ec-fargate-vpc"
    error_message = "Expected VPC name to be 'demo-ec-fargate-vpc'"
  }

  assert {
    condition     = module.appointment.repository_name == "appointment-service"
    error_message = "ECR repository 'appointment-service' not found"
  }

  assert {
    condition     = module.cloudwatch.log_group_name == "/ecs/demo-app"
    error_message = "CloudWatch log group not set as expected"
  }
}
