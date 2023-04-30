data "aws_vpc" "eks_vpc" {}

resource "aws_internet_gateway" "eks_igw" {
  vpc_id = data.aws_vpc.eks_vpc.id
  
  tags = {
    "Name" = "EKS-Internet_gateway" 
  }
}