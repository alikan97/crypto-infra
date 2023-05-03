variable "vpc_id" {
  description = "VPC id"
}
variable "cluster_name" {
  description = "EKS Cluster Name"
}
variable "ami_type" {
  description = "Kubernetes instance type"
  default = "AL2_x86_64"
}

variable "capacity_type" {
  type = string

  validation {
    condition = contains(["SPOT", "ON_DEMAND"], var.capacity_type)
    error_message = "Incorrect capacity type, only allowed SPOT or ON_DEMAND"
  }
}

variable "disk_size" {
  type = number
  
  validation {
    condition = var.disk_size > 19 && var.disk_size < 25
    error_message = "Disk size can't be too big, too much money"
  }
}