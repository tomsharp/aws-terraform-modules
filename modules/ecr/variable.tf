variable "app_name" {
    description = "The name of the application"
    type        = string
}
variable "region" {
    description = "The AWS region to deploy to"
    type        = string
}
variable "dockerfile_path" {
    description = "The path to the Dockerfile"
    type        = string
}