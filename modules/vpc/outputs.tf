output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.demo_vpc.id
}

output "public_subnet_1_id" {
  description = "The ID of the first public subnet"
  value       = aws_subnet.public_subnet_1.id
}

output "public_subnet_2_id" {
  description = "The ID of the second public subnet"
  value       = aws_subnet.public_subnet_2.id
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.igw.id
}

output "route_table_id" {
  description = "The ID of the Route Table"
  value       = aws_route_table.route_table.id
}

output "ecs_service_sg_id" {
  description = "The ID of the ECS Service Security Group"
  value       = aws_security_group.ecs_service_sg.id
}

output "alb_sg_id" {
  description = "The ID of the ALB Security Group"
  value       = aws_security_group.alb_sg.id
}
