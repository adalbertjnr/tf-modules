
resource "aws_iam_role" "eks_node_role" {
  name = var.eksNodeRole

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

//Attach the policy AmazonEKSWorkerNodePolicy to the role above for manage ec2 instances for nodes
resource "aws_iam_role_policy_attachment" "attachEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node_role.name
}

//Attach the policy AmazonEKS_CNI_Policy to the role above for manage the network connectiviy for the nodes
resource "aws_iam_role_policy_attachment" "attachEKSCNINodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node_role.name
}

//Attach the policy AmazonEC2ContainerRegistryReadOnly to the role above for manage the ecr for the cluster/nodes
resource "aws_iam_role_policy_attachment" "attachEKSECRNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_node_role.name
}

resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = var.eksClusterName
  node_group_name = var.nodeGroupName
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = var.subnet_ids.*.id

  capacity_type  = "ON_DEMAND"
  instance_types = ["t2.micro"]

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.attachEKSCNINodePolicy,
    aws_iam_role_policy_attachment.attachEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.attachEKSECRNodePolicy,
  ]

}
