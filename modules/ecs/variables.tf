variable "app_name" {
  description = "Name of the app."
  type        = string
}
variable "region" {
  description = "AWS region to deploy the network to."
  type        = string
}
variable "image" {
  description = "Image used to start the container. Should be in repository-url/image:tag format."
  type        = string
}
variable "vpc_id" {
  description = "ID of the VPC where the ECS will be hosted."
  type        = string
}
variable "public_subnet_ids" {
  description = "IDs of public subnets where the ALB will be attached to."
  type        = list(string)
}
variable "private_subnet_ids" {
  description = "IDs of private subnets where the ECS service will be deployed to."
  type        = list(string)
}
variable "ecs_task_cpu" {
  description = "CPU units for the ECS task."
  type        = number
  default     = 256
}
variable "ecs_task_memory" {
  description = "Memory in MiB for the ECS task."
  type        = number
  default     = 512 
}
variable "ecs_task_command" {
  description = "Command to run in the ECS task. Defaults to null."
  type        = list(string)
  default     = null
}
variable "ecs_task_entrypoint" {
  description = "Entrypoint for the ECS task. Defaults to null."
  type        = list(string)
  default     = null
}