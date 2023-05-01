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

module "eks" {
  source = "./modules/eks"
  vpc_id = module.eks_vpc.vpc_id
}