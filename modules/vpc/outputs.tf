output "vpc_id" {
  value = aws_vpc.eks_vpc.id
  description = "VPC id"
  sensitive = false
}
output "subnet_1_id" {
  value = aws_subnet.public_subnet1.id
  description = "Public subnet 1 id"
  sensitive = false
}
output "subnet_2_id" {
  value = aws_subnet.public_subnet2.id
  description = "Public subnet 2 id"
  sensitive = false
}