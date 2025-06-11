## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.99.1 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb"></a> [alb](#module\_alb) | ./modules/alb | n/a |
| <a name="module_appointment"></a> [appointment](#module\_appointment) | ./modules/ecr | n/a |
| <a name="module_cloudwatch"></a> [cloudwatch](#module\_cloudwatch) | ./modules/cloudwatch | n/a |
| <a name="module_ecs"></a> [ecs](#module\_ecs) | ./modules/ecs | n/a |
| <a name="module_iam"></a> [iam](#module\_iam) | ./modules/iam | n/a |
| <a name="module_nat"></a> [nat](#module\_nat) | ./modules/nat | n/a |
| <a name="module_network"></a> [network](#module\_network) | ./modules/network | n/a |
| <a name="module_patitent"></a> [patitent](#module\_patitent) | ./modules/ecr | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_name"></a> [alb\_name](#input\_alb\_name) | Name of the Application Load Balancer | `string` | `"demo-apps-alb"` | no |
| <a name="input_appointment_service_image"></a> [appointment\_service\_image](#input\_appointment\_service\_image) | Docker image URL for the appointment service | `string` | `"741448937052.dkr.ecr.us-east-1.amazonaws.com/appointment-service:latest"` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | List of availability zones | `list(string)` | <pre>[<br>  "us-east-1a",<br>  "us-east-1b"<br>]</pre> | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region to deploy resources in | `string` | `"us-east-1"` | no |
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | The CIDR block for the VPC | `string` | `"10.0.0.0/16"` | no |
| <a name="input_ecs_cluster_name"></a> [ecs\_cluster\_name](#input\_ecs\_cluster\_name) | Name of the ECS Cluster | `string` | `"demo-ecs-cluster"` | no |
| <a name="input_ecs_execution_role_name"></a> [ecs\_execution\_role\_name](#input\_ecs\_execution\_role\_name) | Name of the ECS Execution Role | `string` | `"ecs-execution-role"` | no |
| <a name="input_ecs_task_role_name"></a> [ecs\_task\_role\_name](#input\_ecs\_task\_role\_name) | Name of the ECS Task Role | `string` | `"ecs-task-role"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Deployment environment | `string` | `"dev"` | no |
| <a name="input_log_group_name"></a> [log\_group\_name](#input\_log\_group\_name) | Name of the CloudWatch log group | `string` | `"ecs-cluster-logs"` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for resource names | `string` | n/a | yes |
| <a name="input_patient_service_image"></a> [patient\_service\_image](#input\_patient\_service\_image) | Docker image URL for the patient service | `string` | `"741448937052.dkr.ecr.us-east-1.amazonaws.com/patient-service:latest"` | no |
| <a name="input_private_subnet_cidrs"></a> [private\_subnet\_cidrs](#input\_private\_subnet\_cidrs) | List of CIDR blocks for private subnets | `list(string)` | <pre>[<br>  "10.0.101.0/24",<br>  "10.0.102.0/24"<br>]</pre> | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project name | `string` | `"healthcare-app"` | no |
| <a name="input_public_subnet_cidrs"></a> [public\_subnet\_cidrs](#input\_public\_subnet\_cidrs) | List of CIDR blocks for public subnets | `list(string)` | <pre>[<br>  "10.0.1.0/24",<br>  "10.0.2.0/24"<br>]</pre> | no |
| <a name="input_service_name_appointment"></a> [service\_name\_appointment](#input\_service\_name\_appointment) | The Name of the Ecr Repository | `string` | `"dev/demo-ecs-appointment"` | no |
| <a name="input_service_name_patitent"></a> [service\_name\_patitent](#input\_service\_name\_patitent) | The Name of the Ecr Repository | `string` | `"dev/demo-ecs-patitent"` | no |
| <a name="input_task_family_appointment"></a> [task\_family\_appointment](#input\_task\_family\_appointment) | ECS Task Definition Family | `string` | `"demo-task-family"` | no |
| <a name="input_task_family_patient"></a> [task\_family\_patient](#input\_task\_family\_patient) | ECS Task Definition Family | `string` | `"demo-task-family"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_dns_name"></a> [alb\_dns\_name](#output\_alb\_dns\_name) | DNS name of the alb |
| <a name="output_alb_id"></a> [alb\_id](#output\_alb\_id) | The ID of the application load balancer |
| <a name="output_appointment_repository_arn"></a> [appointment\_repository\_arn](#output\_appointment\_repository\_arn) | ARN of the ECR repository |
| <a name="output_appointment_repository_url"></a> [appointment\_repository\_url](#output\_appointment\_repository\_url) | URL of the ECR repository |
| <a name="output_appointment_service_id"></a> [appointment\_service\_id](#output\_appointment\_service\_id) | n/a |
| <a name="output_appointment_service_ip"></a> [appointment\_service\_ip](#output\_appointment\_service\_ip) | n/a |
| <a name="output_appointment_tg_arn"></a> [appointment\_tg\_arn](#output\_appointment\_tg\_arn) | The ARN of the appointment service target group |
| <a name="output_ecs_cluster_id"></a> [ecs\_cluster\_id](#output\_ecs\_cluster\_id) | n/a |
| <a name="output_ecs_cluster_name"></a> [ecs\_cluster\_name](#output\_ecs\_cluster\_name) | n/a |
| <a name="output_ecs_execution_role_arn"></a> [ecs\_execution\_role\_arn](#output\_ecs\_execution\_role\_arn) | The ARN of the ECS execution role |
| <a name="output_ecs_task_definition_arn"></a> [ecs\_task\_definition\_arn](#output\_ecs\_task\_definition\_arn) | n/a |
| <a name="output_ecs_task_role_arn"></a> [ecs\_task\_role\_arn](#output\_ecs\_task\_role\_arn) | The ARN of the ECS task role |
| <a name="output_log_group_name"></a> [log\_group\_name](#output\_log\_group\_name) | The name of the CloudWatch log group |
| <a name="output_natgw_eip"></a> [natgw\_eip](#output\_natgw\_eip) | n/a |
| <a name="output_natgw_id"></a> [natgw\_id](#output\_natgw\_id) | n/a |
| <a name="output_patient_service_id"></a> [patient\_service\_id](#output\_patient\_service\_id) | n/a |
| <a name="output_patient_service_ip"></a> [patient\_service\_ip](#output\_patient\_service\_ip) | n/a |
| <a name="output_patient_tg_arn"></a> [patient\_tg\_arn](#output\_patient\_tg\_arn) | The ARN of the patient service target group |
| <a name="output_patitent_repository_arn"></a> [patitent\_repository\_arn](#output\_patitent\_repository\_arn) | ARN of the ECR repository |
| <a name="output_patitent_repository_url"></a> [patitent\_repository\_url](#output\_patitent\_repository\_url) | URL of the ECR repository |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | IDs of the private subnets |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | IDs of the public subnets |
| <a name="output_route_table_id"></a> [route\_table\_id](#output\_route\_table\_id) | The ID of the Route Table |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | ID of the VPC |
