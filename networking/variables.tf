# --- networking/variables.tf --- #
variable "vpc_cidr" {
  type = string
}

variable "public_cidrs" {
  type = list(any)
}

variable "private_cidrs" {
  type = list(any)
}

variable "public_sn_count" {
  type    = number
  default = 2
}

variable "private_sn_count" {
  type    = number
  default = 0
}

variable "shuffleaz_max" {
  type    = number
  default = 2
}

variable "access_addr" {
  type = string
}

variable "security_groups" {}

variable "db_subnet_group" {
  type    = bool
  default = false
}
