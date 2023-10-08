# --- loadbalancing/main.tf --- #

resource "aws_lb" "lb" {
  name               = var.lb_name
  subnets            = [for subnet in var.public_subnets : subnet.id]
  security_groups    = [var.security_groups]
  load_balancer_type = var.lb_type
}

resource "aws_lb_target_group" "lb_tg" {
  name     = "lb-tg-${substr(uuid(), 0, 8)}"
  port     = var.tg_port
  protocol = var.tg_protocol
  vpc_id   = var.vpc_id
  health_check {
    healthy_threshold   = var.lb_health_limits
    unhealthy_threshold = var.lb_unhealth_limits
    timeout             = var.lb_tg_timeout
    interval            = var.lb_tg_interval
  }
}
