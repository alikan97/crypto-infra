variable "ECR_INGESTION_NAME" { // To be used for EKS docker images
  description = "The name of the ecr repository for the ingestion lambda"
  type        = string
}
variable "ECR_PROCESSOR_NAME" {
  description = "The name of the ecr repository for the processor lambda"
  type        = string
}
variable "PROCESSOR_FUNCTION_NAME" {
  description = "The name of the processor lambda function"
  type        = string
}