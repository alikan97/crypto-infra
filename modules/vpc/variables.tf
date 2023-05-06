variable "vpc_cidr_block" {
    description = "CIDR Block value for VPC"
    default = "192.168.0.0/16"
}
variable "subnet_public1_cidr_range" {
    description = "CIDR range value for AZ1 public subnet"
    default = "192.168.0.0/18"
}
variable "subnet_public2_cidr_block" {
    description = "CIDR range value for AZ2 public subnet"
    default = "192.168.64.0/18"
}
variable "vpc_az1" {
    description = "Availability zone for public subnet 2"
    default = "ap-southeast-2a"
}
variable "vpc_az2" {
    description = "Availability zone for public subnet 1"
    default = "ap-southeast-2b"
}
variable "vpc_tag_name" {
    description = "CIDR Block value for VPC"
}