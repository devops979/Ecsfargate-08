variable "ecs_execution_role_name" {
  description = "Name of the ECS Execution Role"
  type        = string
  default     = "ecs-execution-role"
}

variable "ecs_task_role_name" {
  description = "Name of the ECS Task Role"
  type        = string
  default     = "ecs-task-role"
}
