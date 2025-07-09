resource "aws_ecr_repository" "this" {
  name = var.app_name
}

resource "null_resource" "docker_push" {
  provisioner "local-exec" {
    command = <<EOT
      APP_NAME="${var.app_name}"
      REGION="${var.region}"
      REPO_URI="${aws_ecr_repository.this.repository_url}"
      REGISTRY_DOMAIN=$(echo "$REPO_URI" | cut -d'/' -f1)
      TAG="latest"

      echo "Logging in to ECR"
      aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $REGISTRY_DOMAIN

      echo "Building image"
      docker build --no-cache -t $APP_NAME . --no-cache -f ${var.dockerfile_path}

      echo "Tagging image"
      docker tag $APP_NAME:$TAG $REPO_URI:$TAG

      echo "Pushing image to ECR"
      docker push $REPO_URI:$TAG
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
  depends_on = [aws_ecr_repository.this]
}