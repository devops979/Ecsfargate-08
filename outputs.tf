output "vpc_id" {
  description = "ID of the VPC"
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.network.public_subnets_id
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = module.network.private_subnets_id
}

output "natgw_id" {
  value = module.nat.natgw_id
}
output "natgw_eip" {
  value = module.nat.natgw_eip
}


output "route_table_id" {
  description = "The ID of the Route Table"
  value       = module.network.private_route_table_ids
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

