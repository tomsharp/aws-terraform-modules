variable "app_name" {
  description = "Name of the app."
  type        = string
}

variable "region" {
  description = "AWS region to deploy the ECR to."
  type        = string
}

variable "path_to_dockerfile" {
  description = "Path to the Dockerfile relative to the module root."
  type        = string
}

variable "tag" {
  description = "Tag for the Docker image."
  type        = string
  default     = "latest"
}