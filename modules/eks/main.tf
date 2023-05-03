data "aws_subnets" "public_subnets" {
  filter {
    name = "vpc_id"
    values = [var.vpc_id]
  }
}

resource "aws_eks_cluster" "eks_cluster" {
    name = "${var.cluster_name}-cluster"
    role_arn = aws_iam_role.cluster_role.arn
    version = "1.21"
    
    vpc_config {
      endpoint_private_access = false
      endpoint_public_access = true
      subnet_ids = data.aws_subnets.public_subnets.ids
    }
    depends_on = [ 
        aws_iam_role_policy_attachment.cluster_policy
     ]
}

resource "aws_eks_node_group" "eks_node" {
  cluster_name = aws_eks_cluster.eks_cluster.name
  node_group_name = "eks_node"
  node_role_arn = aws_iam_role.nodes_role.arn

  subnet_ids = data.aws_subnets.public_subnets.ids

  scaling_config {
    desired_size = 1
    max_size = 1
    min_size = 1
  }

  ami_type = var.ami_type
  capacity_type = var.capacity_type
  disk_size = var.disk_size #Gb
  force_update_version = false
  instance_types = ["t2.micro"]       # Too expensive

  labels = {
    "role" = "eks-node"
  }
  version = "1.21"
  depends_on = [ aws_iam_role_policy_attachment.cluster_policy, aws_iam_role_policy_attachment.ecr_read_policy, aws_iam_role_policy_attachment.eks_cni_policy ]
}