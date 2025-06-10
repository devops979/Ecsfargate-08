module "network" {
  source             = "./modules/network"
  vpc_cidr           = var.cidr_block
  vpc_name           = "demo-ec-fargate-vpc"
  environment        = var.environment
  public_cidr_block  = var.public_subnet_cidrs
  private_cidr_block = var.private_subnet_cidrs
  azs                = var.availability_zones
  owner              = "demo-ecs-fargate"
  name_prefix        = var.name_prefix
  ingress_rules      = [3000,30001,22]
}

module "nat" {
  source           = "./modules/nat"
  public_subnet_id = module.network.public_subnets_id[0]
  private_rt_ids   = module.network.private_route_table_ids
  vpc_name         = module.network.vpc_name
}


module "iam" {
  source = "./modules/iam" 

  ecs_execution_role_name = var.ecs_execution_role_name
  ecs_task_role_name      = var.ecs_task_role_name
}


module "ecr" {
  source          = "./modules/ecr"
  repository_name = "${var.service_name}-${terraform.workspace}"
  lifecycle_policy = jsonencode({
    rules = [{
      rulePriority = 1,
      description  = "Keep last 5 images",
      action       = { type = "expire" },
      selection = {
        tagStatus   = "any",
        countType   = "imageCountMoreThan",
        countNumber = 5
      }
    }]
  })
}


module "ecs" {
  source = "./modules/ecs"

  ecs_cluster_name          = var.ecs_cluster_name
  ecs_task_family           = var.ecs_task_family
  ecs_execution_role_arn    = module.iam.ecs_execution_role_arn
  ecs_task_role_arn         = module.iam.ecs_task_role_arn
  patient_service_image     = var.patient_service_image
  appointment_service_image = var.appointment_service_image
  subnet_id                 = module.network.private_subnet_cidrs
  security_group_id         = module.network.ecs_security_group_id
  appointment_tg_arn        = module.alb.patient_tg_arn
  patient_tg_arn            = module.alb.appointment_tg_arn
  alb_arn                   = module.alb.alb_arn
}

module "alb" {
  source = "./modules/alb"

  alb_name               = var.alb_name
  patient_service_ip     = module.ecs.patient_service_ip
  appointment_service_ip = module.ecs.appointment_service_ip
  vpc_id                 = module.network.vpc_id
  lb_security_group      = [module.network.alb_security_group_id]
  lb_subnets             = [module.network.private_subnet_ids]
}


module "cloudwatch" {
  source         = "./modules/cloudwatch"
  log_group_name = var.log_group_name
}
