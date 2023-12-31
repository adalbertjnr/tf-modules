# --- loadbalancing/variables.tf ---#

variable "lb_name" {
  default = "PROJ-LB"
}

variable "public_subnets" {}

variable "security_groups" {}

variable "lb_type" {
  default = "application"
}

variable "tg_port" {
  default = 8000
}

variable "tg_protocol" {
  default = "HTTP"
}

variable "vpc_id" {}

variable "lb_health_limits" {
  default = 2
}

variable "lb_unhealth_limits" {
  default = 2
}

variable "lb_tg_timeout" {
  default = 3
}

variable "lb_tg_interval" {
  default = 30
}

variable "listener_port" {
  default = 443
}

variable "listener_protocol" {
  default = "HTTPS"
}

variable "listener_action" {
  default = "forward"
}

variable "ssl_policy" {
  default = "ELBSecurityPolicy-2016-08"
}

variable "certificate" {}
