output "vpc_name" {
  value = lower(local.vpcname)
}

output "vpc_id" {
  value = aws_vpc.demo-vpc.id
}

output "environment" {
  value = var.environment
}

output "public_subnets_id" {
  value = aws_subnet.public-subnets.*.id
}

output "private_subnets_id" {
  value = aws_subnet.private-subnets.*.id
}

# output public_subnets_id_1 {
#   value       = "${aws_subnet.public-subnets.0.id}"
# }

output "private_route_table_ids" {
  value = aws_route_table.private-routing-table.*.id
}

output "ecs_security_group_id" {
  description = "The ID of the demo security group"
  value       = aws_security_group.demo_sg.id
}

output "alb_security_group_id" {
  description = "The ID of the ALB security group"
  value       = aws_security_group.alb_sg.id
}

output "security_group_arn" {
  description = "The ARN of the Lambda security group"
  value       = aws_security_group.demo_sg.arn
}

output "security_group_name" {
  description = "The name of the Lambda security group"
  value       = aws_security_group.demo_sg.name
}


output "alb_security_group_arn" {
  description = "The ARN of the Lambda security group"
  value       = aws_security_group.alb_sg.arn
}

output "alb_security_group_name" {
  description = "The name of the Lambda security group"
  value       = aws_security_group.alb_sg.name
}


