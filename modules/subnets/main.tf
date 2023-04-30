
data "aws_vpc" "eks_vpc" {}

resource "aws_subnet" "private_subnet" {
    vpc_id = data.aws_vpc.eks_vpc.id
    
    cidr_block = var.cidr_range
    
    availability_zone = var.availability_zone

    tags = {
      "Name" = "private-${var.availability_zone}"
      "kubernetes.io/cluster/eks" = "shared"
      "kubernetes.io/role/internal-elb" = 1
    }
}