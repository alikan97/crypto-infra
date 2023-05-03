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
  vpc_cidr_block = "192.168.0.0/16"
  subnet_public1_cidr_range = "192.168.0.0/18"
  subnet_public2_cidr_block = "192.168.64.0/18"
  vpc_az1 = "us-east-1a"
  vpc_az2 = "us-east-1b"
  vpc_tag_name = "EKS-VPC"
}

module "eks" {
  source = "./modules/eks"
  vpc_id = module.eks_vpc.vpc_id
  cluster_name = "ingestion_cluster"
  ami_type = "AL2_x86_64"
  capacity_type = "SPOT"
  disk_size = 20 # Gb
}