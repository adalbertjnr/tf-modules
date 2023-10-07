# --- database/variables.tf --- #

variable "db_storage" {
  type    = number
  default = 10
}

variable "db_engine_version" {
  default = "8.0.34"
}

variable "db_instance_class" {
  default = "db.t2.micro"
}

variable "db_name" {
  default = "proj_db_adalbert"
}

variable "db_user" {
  default = "foo"
}

variable "db_password" {
  default = "foobarbaz"
}

variable "db_subnet_group_name" {}

variable "vpc_security_group_ids" {}

variable "db_identifier" {
  default = "proj_db_adalbert"
}

variable "skip_final_snapshot" {
  type    = bool
  default = false
}

