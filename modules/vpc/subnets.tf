resource "aws_subnet" "public_subnet1" {
    vpc_id = aws_vpc.eks_vpc.id
    
    cidr_block = "192.168.0.0/18"
    
    availability_zone = "us-east-1a"

    map_public_ip_on_launch = true
    tags = {
      "Name" = "public-us-east-1a"
      "kubernetes.io/cluster/eks" = "shared"
      "kubernetes.io/role/elb" = 1
    }
}
resource "aws_subnet" "public_subnet2" {
    vpc_id = aws_vpc.eks_vpc.id
    
    cidr_block = "192.168.64.0/18"
    
    availability_zone = "us-east-1b"

    map_public_ip_on_launch = true
    tags = { 
      "Name" = "public-us-east-1b"
      "kubernetes.io/cluster/eks" = "shared"
      "kubernetes.io/role/elb" = 1
    }
}