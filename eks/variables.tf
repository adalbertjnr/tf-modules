# --- variables.tf/EKS --- #

variable "eks_name" {
  default = "eks"
}


variable "eksRoleName" {
  default = "eks-role-from-tf"
}

variable "subnet_ids" {}
