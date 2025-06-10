variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "subnet_cidr_block_1" {
  description = "The CIDR block for the first subnet"
  type        = string
}

variable "subnet_cidr_block_2" {
  description = "The CIDR block for the second subnet"
  type        = string
}

variable "availability_zone_1" {
  description = "The availability zone for the first subnet"
  type        = string
}

variable "availability_zone_2" {
  description = "The availability zone for the second subnet"
  type        = string
}
