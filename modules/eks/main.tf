resource "aws_eks_cluster" "eks_cluster" {
    name = "${var.cluster_name}-cluster"
    role_arn = aws_iam_role.cluster_role.arn
    version = "1.21"
    
    depends_on = [ 
        aws_iam_role_policy_attachment.cluster_policy
     ]
}

resource "aws_iam_role" "cluster_role" {
  name = "${var.cluster_name}-cluster-role"
  assume_role_policy = <<POLICY
  {
    "Version": "2012-10-17",
    "Statement": [
        {
        "Effect": "Allow",
        "Principal": {
            "Service": "eks.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
        }
    ]
  }
  POLICY
}

resource "aws_iam_role_policy_attachment" "cluster_policy" {
  policy_arn = "" # TODO: EKS Cluster Policy
  role = aws_iam_role.cluster_role.name
}