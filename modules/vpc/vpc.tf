resource "aws_vpc" "eks_vpc" {
  cidr_block = var.vpc_cidr_block
  instance_tenancy = "default"

  enable_dns_support = true
  enable_dns_hostnames = true

  assign_generated_ipv6_cidr_block = false

  tags = {
    "Name" = var.vpc_tag_name
  }
}
