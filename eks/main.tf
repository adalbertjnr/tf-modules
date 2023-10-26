
resource "aws_iam_role" "eks_role" {
  name = var.eksRoleName

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}
//Attach clusterPolicy to the role above be able to manage autoscaling, lb, sg, networking, etc
resource "aws_iam_role_policy_attachment" "attachPolicyToRole" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_role.name
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = var.eks_name
  role_arn = aws_iam_role.eks_role.arn
  vpc_config {
    subnet_ids = var.subnet_ids.*.id
  }

  depends_on = [aws_iam_role.eks_role]
}
