variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}


variable "alb_name" {
  description = "The name of the ALB"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "lb_security_group" {
  description = "List of security group IDs for the load balancer"
  type        = list(string)
}

variable "lb_subnets" {
  description = "The subnets for the ALB"
  type        = list(string)
}

variable "patient_service_ip" {
  description = "The ECS patient service IP"
  type        = string
}

variable "appointment_service_ip" {
  description = "The ECS appointment service IP"
  type        = string
}

