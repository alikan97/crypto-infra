resource "aws_subnet" "public_subnet1" {
    vpc_id = aws_vpc.eks_vpc.id     # From Outputs
    
    cidr_block = var.subnet_public1_cidr_range
    
    availability_zone = var.vpc_az1

    map_public_ip_on_launch = true
    tags = {
      "Name" = "public-${var.vpc_az1}"
      "kubernetes.io/cluster/eks" = "shared"
      "kubernetes.io/role/elb" = 1
    }
}
resource "aws_subnet" "public_subnet2" {
    vpc_id = aws_vpc.eks_vpc.id
    
    cidr_block = var.subnet_public2_cidr_block
    
    availability_zone = var.vpc_az2

    map_public_ip_on_launch = true
    tags = { 
      "Name" = "public-${var.vpc_az2}"
      "kubernetes.io/cluster/eks" = "shared"
      "kubernetes.io/role/elb" = 1
    }
}