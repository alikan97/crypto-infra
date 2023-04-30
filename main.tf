module "processor-repository" {
  source          = "./modules/ecr"
  repository_name = var.ECR_PROCESSOR_NAME
}
module "ingestion-repository" {
  source          = "./modules/ecr"
  repository_name = var.ECR_INGESTION_NAME
}
module "lambda_processor" {
  source              = "./modules/lambda"
  function_name       = var.PROCESSOR_FUNCTION_NAME
  ecr_repository_name = var.ECR_INGESTION_NAME
}
module "eks_vpc" {
  source = "./modules/vpc"
}
module "internet_gateway" {
  source = "./modules/internet-gateway"
}
module "subnet_private-1" {
  source = "./modules/subnets"
  cidr_range = "192.168.128.0/18"
  availability_zone = "us-east-1a"
}
module "subnet_private-2" {
  source = "./modules/subnets"
  cidr_range = "192.168.192.0/18"
  availability_zone = "us-east-1b"
}