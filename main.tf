module "processor-repository" {
  source          = "./modules/ecr"
  repository_name = var.ECR_PROCESSOR_NAME
}
module "ingestion-repository" {
  source          = "./modules/ecr"
  repository_name = var.ECR_INGESTION_NAME
}
module "crypto_streams" {
  source      = "./modules/kinesis"
  stream_name = "crypto_streams"
}
module "lambda_processor" {
  depends_on = [ module.processor-repository ]
  source              = "./modules/lambda"
  function_name       = var.PROCESSOR_FUNCTION_NAME
  ecr_repository_name = var.ECR_INGESTION_NAME
  kinesis_arn         = module.crypto_streams.kinesis_arn
}

module "s3_historical" {
  source      = "./modules/s3"
  bucket_name = "historical-bucket"
}

module "eks_vpc" {
  source                    = "./modules/vpc"
  vpc_cidr_block            = "192.168.0.0/16"
  subnet_public1_cidr_range = "192.168.0.0/18"
  subnet_public2_cidr_block = "192.168.64.0/18"
  vpc_az1                   = "ap-southeast-2a"
  vpc_az2                   = "ap-southeast-2b"
  vpc_tag_name              = "EKS-VPC"
}
module "eks" {
  depends_on = [ module.eks_vpc ]
  source        = "./modules/eks"
  vpc_id        = module.eks_vpc.vpc_id
  cluster_name  = "ingestion_cluster"
  ami_type      = "AL2_x86_64"
  capacity_type = "SPOT"
  disk_size     = 20 # Gb
}

module "delivery_stream" {
  depends_on = [module.crypto_streams, module.s3_historical]

  source               = "./modules/kinesis-firehose"
  delivery_name        = "historical_stream"
  s3_bucket_arn        = module.s3_historical.s3_bucket_arn
  firehose_role        = "Firehose_role"
  firehose_policy_name = "firehose_to_s3"
  kinesis_stream_arn   = module.crypto_streams.kinesis_arn
}