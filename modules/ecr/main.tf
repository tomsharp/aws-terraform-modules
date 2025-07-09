resource "aws_ecr_repository" "this" {
  name = var.app_name
}

resource "null_resource" "docker_push" {
  provisioner "local-exec" {
    command = <<EOT
      APP_NAME="${var.app_name}"
      REGION="${var.region}"
      REPO_URI="${aws_ecr_repository.this.repository_url}"

      echo "[1] Logging in to ECR..."
      aws ecr get-login-password --region "$REGION" | \
        docker login --username AWS --password-stdin "$REPO_URI"

      echo "[2] Building Docker image..."
      docker build -f ${var.path_to_dockerfile} -t "$APP_NAME" .

      echo "[3] Tagging and pushing to $REPO_URI..."
      docker tag "$APP_NAME:${var.tag}" "$REPO_URI:${var.tag}"
      docker push "$REPO_URI:${var.tag}"
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
  depends_on = [aws_ecr_repository.this]
}
