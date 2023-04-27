variable "repository_name" {
  type = string
}

resource "aws_ecr_repository" "repository" {
    name = var.repository_name
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
      scan_on_push = true
    }

    tags = {
      "Name" = "ECR-${var.repository_name}"
    }
}