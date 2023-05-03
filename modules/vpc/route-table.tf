resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"    # 0.0.0.0/0 means every ipv4 address. It is typically used for routes to the internet
    gateway_id = aws_internet_gateway.eks_igw.id # Route traffic to the Internet Gateway
  }

  tags = {
    "Name" = "public_rt"
  }
}

# Associate subnets to route_table
resource "aws_route_table_association" "public_rta1" {
  subnet_id = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public_rt.id
}
resource "aws_route_table_association" "public_rta2" {
  subnet_id = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.public_rt.id
}