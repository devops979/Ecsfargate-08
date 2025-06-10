output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_1_id" {
  description = "The ID of the first public subnet"
  value       = module.vpc.public_subnet_1_id
}

output "public_subnet_2_id" {
  description = "The ID of the second public subnet"
  value       = module.vpc.public_subnet_2_id
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = module.vpc.internet_gateway_id
}

output "route_table_id" {
  description = "The ID of the Route Table"
  value       = module.vpc.route_table_id
}

output "ecs_service_sg_id" {
  description = "The ID of the ECS Service Security Group"
  value       = module.vpc.ecs_service_sg_id
}

output "alb_sg_id" {
  description = "The ID of the Application Load Balancer Security Group"
  value       = module.vpc.alb_sg_id
}

output "ecs_execution_role_arn" {
  description = "The ARN of the ECS execution role"
  value       = module.iam.ecs_execution_role_arn
}

output "ecs_task_role_arn" {
  description = "The ARN of the ECS task role"
  value       = module.iam.ecs_task_role_arn
}

output "ecs_cluster_name" {
  value = module.ecs.ecs_cluster_name
}

output "ecs_cluster_id" {
  value = module.ecs.ecs_cluster_id
}

output "ecs_task_definition_arn" {
  value = module.ecs.ecs_task_definition_arn
}

output "patient_service_id" {
  value = module.ecs.patient_service_id
}

output "appointment_service_id" {
  value = module.ecs.appointment_service_id
}

output "patient_service_ip" {
  value = module.ecs.patient_service_ip
}

output "appointment_service_ip" {
  value = module.ecs.appointment_service_ip
}

output "alb_dns_name" {
  description = "DNS name of the alb"
  value       = module.alb.alb_dns_name
}
output "alb_id" {
  description = "The ID of the application load balancer"
  value       =  module.alb.alb_id
}

output "patient_tg_arn" {
  description = "The ARN of the patient service target group"
  value       = module.alb.patient_tg_arn
}

output "appointment_tg_arn" {
  description = "The ARN of the appointment service target group"
  value       = module.alb.appointment_tg_arn
}

output "log_group_name" {
  description = "The name of the CloudWatch log group"
  value       = module.cloudwatch.log_group_name
}

