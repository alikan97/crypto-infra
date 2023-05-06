data "aws_ecr_repository" "ecr_repository" {
  name = var.ecr_repository_name
}

resource "aws_lambda_function" "lambda_func" {
  function_name = var.function_name
  timeout       = 60 # seconds
  image_uri     = "${data.aws_ecr_repository.ecr_repository.repository_url}:latest"
  package_type  = "Image"
  role          = aws_iam_role.lambda_func_role.arn
}

resource "aws_lambda_function_event_invoke_config" "kinesis_invoker" {
  function_name                = aws_lambda_function.lambda_func.function_name
  maximum_event_age_in_seconds = 60
  maximum_retry_attempts       = 1
}

resource "aws_lambda_event_source_mapping" "event_source_mapper" {
    event_source_arn = var.kinesis_arn
    function_name = aws_lambda_function.lambda_func.function_name
    starting_position = "LATEST"

    depends_on = [ 
        aws_iam_role_policy_attachment.kinesis_execution
     ]
}
