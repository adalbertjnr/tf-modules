# --- k3s/variables.tf ---#

variable "instance_count" {
  default = 1
}

variable "instance_type" {
  default = "t2.micro"
}

variable "public_subnets" {}

variable "public_sg" {}

variable "root_vol_size" {
  default = 20
}

variable "key_name" {
  default = "proj-key"
}

variable "public_key_path" {}

variable "userdata_path" {
  default = "./userdata.tpl"
}

variable "db_user" {
  default = "foo"
}

variable "db_pass" {
  default = "foobarbaz"
}

variable "db_name" {
  default = "proj_db_adalbert"
}

variable "db_endpoint" {}


