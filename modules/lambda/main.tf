variable "function_name" {
    description = "The name of the lambda function"
}

variable "ecr_repository_name" {
    description = "The ecr repository that contains the docker image for this lambda function"
}

data "aws_ecr_repository" "ecr_repository" {
    name = var.ecr_repository_name
}

resource "aws_lambda_function" "lambda_func" {
    function_name = var.function_name
    timeout = 60 # seconds
    image_uri = "${data.aws_ecr_repository.ecr_repository.repository_url}:latest"
    package_type = "Image"
    runtime = "python3.8"
    # handler = "index.handler" // TODO: Fix later
    role = aws_iam_role.lambda_func_role.arn
}

resource "aws_iam_role" "lambda_func_role" {
    name = "${var.function_name}-${var.ecr_repository_name}-role"

    assume_role_policy = jsonencode({
        Statement = [
            {
                Action = "sts:AssumeRole"
                Effect = "Allow"
                Principal = {
                    Service = "lambda.amazonaws.com"
                }
            }
        ]
    })
}