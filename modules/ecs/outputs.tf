output "ecs_cluster_name" {
  value = aws_ecs_cluster.demo.name
}

output "ecs_cluster_id" {
  description = "The ECS cluster ID"
  value       = aws_ecs_cluster.demo.id
}


output "ecs_task_definition_arn" {
  value = aws_ecs_task_definition.patient_service.arn
}

output "patient_service_id" {
  description = "The ECS patient service ID"
  value       = aws_ecs_service.patient_service.id 
}

output "appointment_service_id" {
  description = "The ECS appointment service ID"
  value       = aws_ecs_service.appointment_service.id 
}

output "patient_service_ip" {
  value = aws_ecs_service.patient_service.network_configuration[0].assign_public_ip
}

output "appointment_service_ip" {
  value = aws_ecs_service.appointment_service.network_configuration[0].assign_public_ip
}
