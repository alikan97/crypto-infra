variable "ECR_PROCESSOR_NAME" {
  description = "The name of the ecr repository for the processor lambda"
  type = string
}

variable "PROCESSOR_FUNCTION_NAME" {
  description = "The name of the processor lambda function"
  type = string
}

module "processor-repository" {
  source = "./modules/ecr"
  repository_name = var.ECR_PROCESSOR_NAME
}

module "lambda_processor" {
  source = "./modules/lambda"
  function_name = var.PROCESSOR_FUNCTION_NAME
  ecr_repository_name = var.ECR_PROCESSOR_NAME
}