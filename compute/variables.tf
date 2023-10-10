# --- k3s/variables.tf ---#

variable "instance_count" {
  default = 1
}

variable "root_vol_size" {
  default = 20
}
variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "proj-key"
}

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

variable "public_key_path" {}

variable "public_subnets" {}

variable "public_sg" {}

variable "db_endpoint" {}

variable "lb_tg_arn" {}

variable "wp_port" {}
