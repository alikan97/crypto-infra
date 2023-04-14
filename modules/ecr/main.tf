resource "aws_ecr_repository" "lambda_processor" {
    name = "lambda_processor"
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
      scan_on_push = true
    }
}