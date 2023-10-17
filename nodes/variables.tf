# --- variables.tf/NODES --- #

variable "eksNodeRole" {
  default = "eks-nodegroup-role-from-tf"
}

variable "eksClusterName" {}

variable "nodeGroupName" {
  default = "eks-nodegroup-name-from-tf"
}

variable "subnet_ids" {}

variable "desired_size" {
  default = 1
}

variable "max_size" {
  default = 2
}

variable "min_size" {
  default = 1
}
