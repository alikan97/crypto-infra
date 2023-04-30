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

resource "aws_lambda_function_event_invoke_config" "kinesis_invoker" {
    function_name = aws_lambda_function.lambda_func.function_name
    maximum_event_age_in_seconds = 60
    maximum_retry_attempts = 1
}

resource "aws_lambda_event_source_mapping" "event_source_mapper" {
    event_source_arn = aws_lambda_function.lambda_func.arn  # TODO: Change to Kinesis ARN
    function_name = aws_lambda_function.lambda_func.function_name
    starting_position = "LATEST"

    depends_on = [ 
        # IAM Polic attachment for kinesis
     ]
}