variable "function_name" {
    description = "The name of the lambda function"
}

variable "ecr_repository_name" {
    description = "The ecr repository that contains the docker image for this lambda function"
}

variable "kinesis_arn" {
    description = "ARN of Kinesis data stream to read from"
}